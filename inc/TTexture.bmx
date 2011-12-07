Type TTexture

	Global tex_list:TList=CreateList()

	Field file$,flags:Int,blend:Int=2,coords:Int,u_scale#=1.0,v_scale#=1.0,u_pos#,v_pos#,angle#
	Field file_abs$,width:Int,height:Int ' returned by Name/Width/Height commands
	Field pixmap:TPixmap
	Field gltex:Int[1]
	Field cube_pixmap:TPixmap[7]
	Field no_frames:Int=1
	Field no_mipmaps:Int
	Field cube_face:Int=0,cube_mode:Int=1

	Method New()
	
		If LOG_NEW
			DebugLog "New TTexture"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TTexture"
		EndIf
	
	End Method
Rem	
	Method FreeTexture()
	
		ListRemove(tex_list,Self)
		pixmap=Null
		cube_pixmap=Null
		gltex=Null
	
	End Method
EndRem	
	Method FreeTexture() 'SMALLFIXES New function from http://www.blitzbasic.com/Community/posts.php?topic=88263#1002039
	
		ListRemove(tex_list,Self)
		pixmap=Null
		cube_pixmap=Null
		
		For Local name:Int = EachIn gltex
			glDeleteTextures 1, Varptr name
		Next
		gltex=Null
	
	End Method
	
	
	
	Function CreateTexture:TTexture(width:Int,height:Int,flags:Int=1,frames:Int=1,tex:TTexture=Null)
	
		If flags&128 Then Return CreateCubeMapTexture(width,height,flags,tex)
		
		If tex=Null Then tex:TTexture=New TTexture ; ListAddLast(tex_list,tex)
		
		tex.pixmap=CreatePixmap(width*frames,height,PF_RGBA8888)

		' ---
		
		tex.flags=flags
		'tex.FilterFlags() ' not needed in CreateTexture
				
		tex.no_frames=frames
		tex.gltex=tex.gltex[..tex.no_frames]

		' ---
		
		' pixmap -> tex
			
		Local x:Int=0
	
		Local pixmap:TPixmap
	
		For Local i:Int=0 To tex.no_frames-1
	
			pixmap=tex.pixmap.Window(x*width,0,width,height)
			x=x+1
		
			' ---
		
			pixmap=AdjustPixmap(pixmap)
			tex.width=pixmap.width
			tex.height=pixmap.height
			Local width:Int=pixmap.width
			Local height:Int=pixmap.height

			Local name:Int
			glGenTextures 1,Varptr name
			glBindtexture GL_TEXTURE_2D,name

			Local mipmap:Int
			If tex.flags&8 Then mipmap=True
			Local mip_level:Int=0
			Repeat
				'glPixelStorei GL_UNPACK_ROW_LENGTH,pixmap.pitch/BytesPerPixel[pixmap.format] 'BAD LINE!
    				glPixelStorei 2,pixmap.pitch/BytesPerPixel[pixmap.format]    'SMALLFIXES http://www.blitzmax.com/Community/posts.php?topic=87020
				glTexImage2D GL_TEXTURE_2D,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
				If Not mipmap Then Exit
				If width=1 And height=1 Exit
				If width>1 width:/2
				If height>1 height:/2

				pixmap=ResizePixmap(pixmap,width,height)
				mip_level:+1
			Forever
			tex.no_mipmaps=mip_level

			tex.gltex[i]=name
	
		Next
		
		Return tex

	End Function

	Function LoadTexture:TTexture(file$,flags:Int=1,tex:TTexture=Null)
	
		Return LoadAnimTexture:TTexture(file$,flags,0,0,0,1,tex)
	
	End Function
	
	Function LoadAnimTexture:TTexture(file$,flags:Int,frame_width:Int,frame_height:Int,first_frame:Int,frame_count:Int,tex:TTexture=Null)

		If flags&128 Then Return LoadCubeMapTexture(file$,flags,tex)
	
		If tex=Null Then tex:TTexture=New TTexture

		If FileFind(file$)=False Then Return Null
		
		tex.file$=file$
		tex.file_abs$=FileAbs$(file$)
		
		' set tex.flags before TexInList
		tex.flags=flags
		tex.FilterFlags()
		
		' check to see if texture with same properties exists already, if so return existing texture
		Local old_tex:TTexture
		old_tex=tex.TexInList()
		If old_tex<>Null And old_tex<>tex
			Return old_tex
		Else
			If old_tex<>tex
				ListAddLast(tex_list,tex)
			EndIf
		EndIf

		' load pixmap
		tex.pixmap=LoadPixmap(file$)
		
		' check to see if pixmap contain alpha layer, set alpha_present to true if so (do this before converting)
		Local alpha_present:Int=False
		If tex.pixmap.format=PF_RGBA8888 Or tex.pixmap.format=PF_BGRA8888 Or tex.pixmap.format=PF_A8 Then alpha_present=True

		' convert pixmap to appropriate format
		If tex.pixmap.format<>PF_RGBA8888
			tex.pixmap=tex.pixmap.Convert(PF_RGBA8888)
		EndIf
		
		' if alpha flag is true and pixmap doesn't contain alpha info, apply alpha based on color values
		If tex.flags&2 And alpha_present=False
			tex.pixmap=ApplyAlpha(tex.pixmap)
		EndIf		

		' if mask flag is true, mask pixmap
		If tex.flags&4
			tex.pixmap=MaskPixmap(tex.pixmap,0,0,0)
		EndIf
		
		' ---
		
		' if tex not anim tex, get frame width and height
		If frame_width=0 And frame_height=0
			frame_width=tex.pixmap.width
			frame_height=tex.pixmap.height
		EndIf

		' ---
		
		tex.no_frames=frame_count
		tex.gltex=tex.gltex[..tex.no_frames]

		' ---
		
		' pixmap -> tex

		Local xframes:Int=tex.pixmap.width/frame_width
		Local yframes:Int=tex.pixmap.height/frame_height
			
		Local startx:Int=first_frame Mod xframes
		Local starty:Int=(first_frame/yframes) Mod yframes
			
		Local x:Int=startx
		Local y:Int=starty
	
		Local pixmap:TPixmap
	
		For Local i:Int=0 To tex.no_frames-1
	
			' get static pixmap window. when resize pixmap is called new pixmap will be returned.
			pixmap=tex.pixmap.Window(x*frame_width,y*frame_height,frame_width,frame_height)
			x=x+1
			If x>=xframes
				x=0
				y=y+1
			EndIf
		
			' ---
		
			pixmap=AdjustPixmap(pixmap)
			tex.width=pixmap.width
			tex.height=pixmap.height
			Local width:Int=pixmap.width
			Local height:Int=pixmap.height

			Local name:Int
			glGenTextures 1,Varptr name
			glBindtexture GL_TEXTURE_2D,name

			Local mipmap:Int
			If tex.flags&8 Then mipmap=True
			Local mip_level:Int=0
			Repeat
				glPixelStorei GL_UNPACK_ROW_LENGTH,pixmap.pitch/BytesPerPixel[pixmap.format]
				glTexImage2D GL_TEXTURE_2D,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
				If Not mipmap Then Exit
				If width=1 And height=1 Exit
				If width>1 width:/2
				If height>1 height:/2

				pixmap=ResizePixmap(pixmap,width,height)
				mip_level:+1
			Forever
			tex.no_mipmaps=mip_level

			tex.gltex[i]=name
	
		Next
				
		Return tex
		
	End Function

	Function CreateCubeMapTexture:TTexture(width:Int,height:Int,flags:Int,tex:TTexture=Null)
		
		If tex=Null Then tex:TTexture=New TTexture ; ListAddLast(tex_list,tex)
		
		tex.pixmap=CreatePixmap(width*6,height,PF_RGBA8888)
		
		' ---
		
		tex.flags=flags
		'tex.FilterFlags() ' not needed in CreateCubeMapTexture
				
		tex.no_frames=1'frame_count
		'tex.gltex=tex.gltex[..tex.no_frames]

		' ---
		
		' pixmap -> tex
				
		Local name:Int
		glGenTextures 1,Varptr name
		glBindtexture GL_TEXTURE_CUBE_MAP,name
	
		Local pixmap:TPixmap
	
		For Local i:Int=0 To 5
		
			pixmap=tex.pixmap.Window(width*i,0,width,height)

			' ---
		
			pixmap=AdjustPixmap(pixmap)
			tex.width=pixmap.width
			tex.height=pixmap.height
			Local width:Int=pixmap.width
			Local height:Int=pixmap.height

			Local mipmap:Int
			'If tex.flags&8 Then mipmap=True ***note*** prevent mipmaps being created for cubemaps - they are not used by TMesh.Update, so we don't need to create them
			Local mip_level:Int=0
			Repeat
				glPixelStorei GL_UNPACK_ROW_LENGTH,pixmap.pitch/BytesPerPixel[pixmap.format]
				Select i
					Case 0 glTexImage2D GL_TEXTURE_CUBE_MAP_NEGATIVE_X,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
					Case 1 glTexImage2D GL_TEXTURE_CUBE_MAP_POSITIVE_Z,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
					Case 2 glTexImage2D GL_TEXTURE_CUBE_MAP_POSITIVE_X,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
					Case 3 glTexImage2D GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
					Case 4 glTexImage2D GL_TEXTURE_CUBE_MAP_POSITIVE_Y,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
					Case 5 glTexImage2D GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
				End Select
				If Not mipmap Then Exit
				If width=1 And height=1 Exit
				If width>1 width:/2
				If height>1 height:/2

				pixmap=ResizePixmap(pixmap,width,height)
				mip_level:+1
			Forever
			tex.no_mipmaps=mip_level
			
		Next
		
		tex.gltex[0]=name
		
		Return tex
		
	End Function

	Function LoadCubeMapTexture:TTexture(file$,flags:Int=1,tex:TTexture=Null)
		
		If tex=Null Then tex:TTexture=New TTexture
		
		If FileFind(file$)=False Then Return Null
		
		tex.file$=file$
		tex.file_abs$=FileAbs$(file$)
		
		' set tex.flags before TexInList
		tex.flags=flags
		tex.FilterFlags()
		
		' check to see if texture with same properties exists already, if so return existing texture
		Local old_tex:TTexture
		old_tex=tex.TexInList()
		If old_tex<>Null And old_tex<>tex
			Return old_tex
		Else
			If old_tex<>tex
				ListAddLast(tex_list,tex)
			EndIf
		EndIf

		' load pixmap
		tex.pixmap=LoadPixmap(file$)
		
		' check to see if pixmap contain alpha layer, set alpha_present to true if so (do this before converting)
		Local alpha_present:Int=False
		If tex.pixmap.format=PF_RGBA8888 Or tex.pixmap.format=PF_BGRA8888 Or tex.pixmap.format=PF_A8 Then alpha_present=True

		' convert pixmap to appropriate format
		If tex.pixmap.format<>PF_RGBA8888
			tex.pixmap=tex.pixmap.Convert(PF_RGBA8888)
		EndIf
		
		' if alpha flag is true and pixmap doesn't contain alpha info, apply alpha based on color values
		If tex.flags&2 And alpha_present=False
			tex.pixmap=ApplyAlpha(tex.pixmap)
		EndIf		

		' if mask flag is true, mask pixmap
		If tex.flags&4
			tex.pixmap=MaskPixmap(tex.pixmap,0,0,0)
		EndIf
		
		' ---
						
		tex.no_frames=1'frame_count
		'tex.gltex=tex.gltex[..tex.no_frames]
		
		' ---
		
		' pixmap -> tex
			
		Local name:Int
		glGenTextures 1,Varptr name
		glBindtexture GL_TEXTURE_CUBE_MAP,name
	
		Local pixmap:TPixmap
	
		For Local i:Int=0 To 5
		
			pixmap=tex.pixmap.Window((tex.pixmap.width/6)*i,0,tex.pixmap.width/6,tex.pixmap.height)

			' ---
		
			pixmap=AdjustPixmap(pixmap)
			tex.width=pixmap.width
			tex.height=pixmap.height
			Local width:Int=pixmap.width
			Local height:Int=pixmap.height

			Local mipmap:Int
			'If tex.flags&8 Then mipmap=True ***note*** prevent mipmaps being created for cubemaps - they are not used by TMesh.Update, so we don't need to create them
			Local mip_level:Int=0
			Repeat
				glPixelStorei GL_UNPACK_ROW_LENGTH,pixmap.pitch/BytesPerPixel[pixmap.format]
				Select i
					Case 0 glTexImage2D GL_TEXTURE_CUBE_MAP_NEGATIVE_X,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
					Case 1 glTexImage2D GL_TEXTURE_CUBE_MAP_POSITIVE_Z,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
					Case 2 glTexImage2D GL_TEXTURE_CUBE_MAP_POSITIVE_X,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
					Case 3 glTexImage2D GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
					Case 4 glTexImage2D GL_TEXTURE_CUBE_MAP_POSITIVE_Y,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
					Case 5 glTexImage2D GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,mip_level,GL_RGBA8,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,pixmap.pixels
				End Select
				If Not mipmap Then Exit
				If width=1 And height=1 Exit
				If width>1 width:/2
				If height>1 height:/2

				pixmap=ResizePixmap(pixmap,width,height)
				mip_level:+1
			Forever
			tex.no_mipmaps=mip_level
			
		Next
		
		tex.gltex[0]=name
	
		Return tex

	End Function

	Method TextureBlend(blend_no:Int)
		
		blend=blend_no
		
	End Method
	
	Method TextureCoords(coords_no:Int)
	
		coords=coords_no
	
	End Method
	
	Method ScaleTexture(u_s#,v_s#)
	
		u_scale#=1.0/u_s#
		v_scale#=1.0/v_s#
	
	End Method
	
	Method PositionTexture(u_p#,v_p#)
	
		u_pos#=-u_p#
		v_pos#=-v_p#
	
	End Method
	
	Method RotateTexture(ang#)
	
		angle#=ang#
	
	End Method
	
	Method TextureWidth:Int()
	
		Return width
	
	End Method
	
	Method TextureHeight:Int()
	
		Return height
	
	End Method
	
	Method TextureName$()
	
		Return file_abs$
	
	End Method
	
	Function GetBrushTexture:TTexture(brush:TBrush,index:Int=0)
	
		Return brush.tex[index]
	
	End Function
	
	Function ClearTextureFilters()
	
		ClearList TTextureFilter.filter_list
	
	End Function
	
	Function TextureFilter(match_text$,flags:Int)
	
		Local filter:TTextureFilter=New TTextureFilter
		filter.text$=match_text$
		filter.flags=flags
		ListAddLast(TTextureFilter.filter_list,filter)
	
	End Function
	
	Method SetCubeFace(face:Int)
		cube_face=face
	End Method
	
	Method SetCubeMode(mode:Int)
		cube_mode=mode
	End Method
	
	Method BackBufferToTex(mipmap_no:Int=0,frame:Int=0)
	
		If flags&128=0 ' normal texture
	
			Local x:Int=0,y:Int=0
	
			glBindtexture GL_TEXTURE_2D,gltex[frame]
			glCopyTexImage2D(GL_TEXTURE_2D,mipmap_no,GL_RGBA8,x,TGlobal.height-y-height,width,height,0)
			
		Else ' cubemap texture

			Local x:Int=0,y:Int=0
	
			glBindtexture GL_TEXTURE_CUBE_MAP_EXT,gltex[0]
			Select cube_face
				Case 0 glCopyTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_X,mipmap_no,GL_RGBA8,x,TGlobal.height-y-height,width,height,0)
				Case 1 glCopyTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Z,mipmap_no,GL_RGBA8,x,TGlobal.height-y-height,width,height,0)
				Case 2 glCopyTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X,mipmap_no,GL_RGBA8,x,TGlobal.height-y-height,width,height,0)
				Case 3 glCopyTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,mipmap_no,GL_RGBA8,x,TGlobal.height-y-height,width,height,0)
				Case 4 glCopyTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,mipmap_no,GL_RGBA8,x,TGlobal.height-y-height,width,height,0)
				Case 5 glCopyTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Y,mipmap_no,GL_RGBA8,x,TGlobal.height-y-height,width,height,0)
			End Select
		
		EndIf

	End Method
		
	Method CountMipmaps:Int()
		Return no_mipmaps
	End Method
	
	Method MipmapWidth:Int(mipmap_no:Int)
		If mipmap_no>=0 And mipmap_no<=no_mipmaps
			Return width/(mipmap_no+1)
		Else
			Return 0
		EndIf
	End Method
	
	Method MipmapHeight:Int(mipmap_no:Int)
		If mipmap_no>=0 And mipmap_no<=no_mipmaps
			Return height/(mipmap_no+1)
		Else
			Return 0
		EndIf
	End Method
	
	
	Function FileFind%(file$ Var) 'SMALLFIXES, replaced function to alow Incbin and Zipstream (from http://blitzmax.com/Community/posts.php?topic=88901#1009408 ) 
		Local TS:TStream = OpenFile(file$,True,False)
		If Not TS Then
			Repeat
				file$=Right$(file$,(Len(file$)-Instr(file$,"\",1)))
			Until Instr(file$,"\",1)=0
			Repeat
				file$=Right$(file$,(Len(file$)-Instr(file$,"/",1)))
			Until Instr(file$,"/",1)=0
			TS = OpenStream(file$,True,False)
			If Not TS Then
				DebugLog "ERROR: Cannot find texture: "+file$
				Return False
			Else
			    CloseStream(TS)
                            TS=Null
			EndIf
		Else
			CloseStream TS
			TS=Null	
		EndIf
		Return True
	End Function
	
	
	Rem
	' Internal - not recommended for general use	
	Function FileFind:Int(file$ Var)
	
		If FileType(file$)=0
			Repeat
				file$=Right$(file$,(Len(file$)-Instr(file$,"\",1)))
			Until Instr(file$,"\",1)=0
			Repeat
				file$=Right$(file$,(Len(file$)-Instr(file$,"/",1)))
			Until Instr(file$,"/",1)=0
			If FileType(file$)=0
				DebugLog "ERROR: Cannot find texture: "+file$
				Return False
			EndIf
		EndIf
		
		Return True
		
	End Function
	EndRem
	
	Function FileAbs$(file$)
	
		Local file_abs$
	
		If Instr(file$,":")=False
			file_abs$=CurrentDir$()+"/"+file$
		Else
			file_abs$=file$
		EndIf
		file_abs$=Replace$(file_abs$,"\","/")
		
		Return file_abs$
	
	End Function
		
	Method TexInList:TTexture()

		' check if tex already exists in list and if so return it

		For Local tex:TTexture=EachIn tex_list
			If file$=tex.file$ And flags=tex.flags And blend=tex.blend
				If u_scale#=tex.u_scale# And v_scale#=tex.v_scale# And u_pos#=tex.u_pos# And v_pos#=tex.v_pos# And angle#=tex.angle#
					Return tex
				EndIf
			EndIf
		Next
	
		Return Null
	
	End Method
	
	Method FilterFlags()
	
		' combine specifieds flag with texture filter flags
		For Local filter:TTextureFilter=EachIn TTextureFilter.filter_list
			If Instr(file$,filter.text$) Then flags=flags|filter.flags
		Next
	
	End Method
		
	Function AdjustPixmap:TPixmap(pixmap:TPixmap)
	
		' adjust width and height size to next biggest power of 2 size
		Local width:Int=Pow2Size(pixmap.width)
		Local height:Int=Pow2Size(pixmap.height)

		' ***note*** commented out as it fails on some cards
		Rem
		' check that width and height size are valid (not too big)
		Repeat
			Local t
			glTexImage2D GL_PROXY_TEXTURE_2D,0,4,width,height,0,GL_RGBA,GL_UNSIGNED_BYTE,Null
			glGetTexLevelParameteriv GL_PROXY_TEXTURE_2D,0,GL_TEXTURE_WIDTH,Varptr t
			If t Exit
			If width=1 And height=1 RuntimeError "Unable to calculate tex size"
			If width>1 width:/2
			If height>1 height:/2
		Forever
		End Rem

		' if width or height have changed then resize pixmap
		If width<>pixmap.width Or height<>pixmap.height
			pixmap=ResizePixmap(pixmap,width,height)
		EndIf
		
		' return pixmap
		Return pixmap
		
	End Function
	
	Function Pow2Size:Int( n:Int )
		Local t:Int=1
		While t<n
			t:*2
		Wend
		Return t
	End Function

	' applys alpha to a pixmap based on average of colour values
	Function ApplyAlpha:TPixmap( pixmap:TPixmap ) NoDebug
	
		Local tmp:TPixmap=pixmap
		If tmp.format<>PF_RGBA8888 tmp=tmp.Convert( PF_RGBA8888 )
		
		Local out:TPixmap=CreatePixmap( tmp.width,tmp.height,PF_RGBA8888 )
		
		For Local y:Int=0 Until pixmap.height
			Local t:Byte Ptr=tmp.PixelPtr( 0,y )
			Local o:Byte Ptr=out.PixelPtr( 0,y )
			For Local x:Int=0 Until pixmap.width

				o[0]=t[0]
				o[1]=t[1]
				o[2]=t[2]
				o[3]=(o[0]+o[1]+o[2])/3.0

				t:+4
				o:+4
			Next
		Next
		Return out
	End Function

End Type

Type TTextureFilter

	Global filter_list:TList=CreateList()

	Field text$
	Field flags:Int
	
End Type
