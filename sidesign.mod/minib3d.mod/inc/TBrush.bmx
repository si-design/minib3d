Type TBrush

	Field no_texs:Int
	Field name$
	Field red#=1.0,green#=1.0,blue#=1.0,alpha#=1.0
	Field shine#
	Field blend:Int,fx:Int
	Field tex_frame:Int
	Field tex:TTexture[8]

	Method New()
	
		If LOG_NEW
			DebugLog "New TBrush"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TBrush"
		EndIf
	
	End Method
	
	Method Copy:TBrush()
		
		Local brush:TBrush=New TBrush
	
		brush.no_texs=no_texs
		brush.name$=name$
		brush.red#=red#
		brush.green#=green#
		brush.blue#=blue#
		brush.alpha#=alpha#
		brush.shine#=shine#
		brush.blend=blend
		brush.fx=fx
		brush.tex_frame=tex_frame
		brush.tex[0]=tex[0]
		brush.tex[1]=tex[1]
		brush.tex[2]=tex[2]
		brush.tex[3]=tex[3]
		brush.tex[4]=tex[4]
		brush.tex[5]=tex[5]
		brush.tex[6]=tex[6]
		brush.tex[7]=tex[7]
					
		Return brush

	End Method
	
	Method FreeBrush()
	
	End Method
		
	Function CreateBrush:TBrush(r#=255.0,g#=255.0,b#=255.0)
	
		Local brush:TBrush=New TBrush
		brush.red#=r#/255.0
		brush.green#=g#/255.0
		brush.blue#=b#/255.0
		
		Return brush
		
	End Function
	
	Function LoadBrush:TBrush(file$,flags:Int=1,u_scale#=1.0,v_scale#=1.0)
	
		Local brush:TBrush=New TBrush
		brush.tex[0]=TTexture.LoadTexture:TTexture(file$,flags)
		brush.no_texs=1
		'brush.tex[0].u_scale#=u_scale#
		'brush.tex[0].v_scale#=v_scale#
				
		Return brush
		
	End Function
	
	Method BrushColor(r#,g#,b#)
	
		red=r#/255.0
		green=g#/255.0
		blue=b#/255.0
	
	End Method
	
	Method BrushAlpha(a#)
	
		alpha#=a#
	
	End Method
	
	Method BrushShininess(s#)
	
		shine#=s#
	
	End Method
	
	Method BrushTexture(texture:TTexture,frame:Int=0,index:Int=0)
	
		tex[index]=texture
		If index+1>no_texs Then no_texs=index+1
		
		If frame<0 Then frame=0
		If frame>texture.no_frames-1 Then frame=texture.no_frames-1 
		tex_frame=frame
	
	End Method
	
	Method BrushBlend(blend_no:Int)
	
		blend=blend_no
	
	End Method
	
	Method BrushFX(fx_no:Int)
	
		fx=fx_no
	
	End Method
	
	Function GetEntityBrush:TBrush(ent:TEntity)
	
		Return ent.brush.Copy()
		
	End Function
	
	Function GetSurfaceBrush:TBrush(surf:TSurface)
	
		Return surf.brush.Copy()

	End Function
	
	Function CompareBrushes:int(brush1:TBrush,brush2:TBrush)
	
		' returns true if specified brush1 has same properties as brush2

		If brush1=Null And brush2<>Null Then Return False
		If brush1<>Null And brush2=Null Then Return False
		If brush1<>Null And brush2<>Null
			If brush1.no_texs<>brush2.no_texs Then Return False
			If brush1.red#<>brush2.red# Then Return False
			If brush1.green#<>brush2.green# Then Return False
			If brush1.blue#<>brush2.blue# Then Return False
			If brush1.alpha#<>brush2.alpha# Then Return False
			If brush1.shine#<>brush2.shine# Then Return False
			If brush1.blend<>brush2.blend Then Return False
			If brush1.fx<>brush2.fx Then Return False
			For Local i:Int=0 To 7
				If brush1.tex[i]=Null And brush2.tex[i]<>Null Then Return False
				If brush1.tex[i]<>Null And brush2.tex[i]=Null Then Return False
				If brush1.tex[i]<>Null And brush2.tex[i]<>Null
					If brush1.tex[i].gltex<>brush2.tex[i].gltex Then Return False
					If brush1.tex[i].blend<>brush2.tex[i].blend Then Return False
					If brush1.tex[i].coords<>brush2.tex[i].coords Then Return False
				EndIf
			Next
		EndIf
		
		Return True
	
	End Function
	
End Type