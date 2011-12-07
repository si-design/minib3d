Type TAnimation

	Function AnimateMesh(ent1:TEntity,framef:Float,start_frame:Int,end_frame:Int)
		
		If TMesh(ent1)<>Null
			
			If TMesh(ent1).anim=False Then Return ' mesh contains no anim data
	
			TMesh(ent1).anim_render=True
	
			' cap framef values
			If framef>end_frame Then framef=end_frame
			If framef<start_frame Then framef=start_frame
			
			Local frame:Int=framef ' float to int
	
			For Local bent:TBone=EachIn TMesh(ent1).bones
						
				Local i:Int=0
				Local ii:Int=0
				Local fd1:Float=0 ' anim time since last key
				Local fd2:Float=0 ' anim time until next key
				Local found:Int=False
				Local no_keys:Int=False
				Local w1:Float
				Local x1:Float
				Local y1:Float
				Local z1:Float
				Local w2:Float
				Local x2:Float
				Local y2:Float
				Local z2:Float
				
				Local flag:Int=0
				
				' position
						
				' backwards
				i=frame+1
				Repeat
					i=i-1
					flag=TBone(bent).keys.flags[i]&1
					If flag
						x1=TBone(bent).keys.px[i]
						y1=TBone(bent).keys.py[i]
						z1=TBone(bent).keys.pz[i]
						fd1=framef-i
						found=True
					EndIf
					If i<=start_frame Then i=end_frame+1;ii=ii+1
				Until found=True Or ii>=2
				If found=False Then no_keys=True
				found=False
				ii=0
				
				' forwards
				i=frame
				Repeat
					i=i+1
					If i>end_frame Then i=start_frame;ii=ii+1
					flag=TBone(bent).keys.flags[i]&1
					If flag
						x2=TBone(bent).keys.px[i]
						y2=TBone(bent).keys.py[i]
						z2=TBone(bent).keys.pz[i]
						fd2=i-framef
						found=True
					EndIf
				Until found=True Or ii>=2
				If found=False Then no_keys=True
				found=False
				ii=0
		
				Local px3:Float=0
				Local py3:Float=0
				Local pz3:Float=0
				If no_keys=True ' no keyframes
					px3=TBone(bent).n_px
					py3=TBone(bent).n_py
					pz3=TBone(bent).n_pz
				Else
					If fd1+fd2=0.0 ' one keyframe
						' if only one keyframe, fd1+fd2 will equal 0 resulting in division error and garbage positional values (which can affect children)
						' so we check for this, and if true then positional values equals x1,y1,z1 (same as x2,y2,z2)
						px3=x1
						py3=y1
						pz3=z1
					Else ' more than one keyframe
						px3=(((x2-x1)/(fd1+fd2))*fd1)+x1
						py3=(((y2-y1)/(fd1+fd2))*fd1)+y1
						pz3=(((z2-z1)/(fd1+fd2))*fd1)+z1
					EndIf
				EndIf
				no_keys=False
				
				' store current keyframe for use with transtions
				TBone(bent).kx=px3
				TBone(bent).ky=py3
				TBone(bent).kz=pz3
			
				' rotation
	
				i=frame+1
				Repeat
					i=i-1
					flag=TBone(bent).keys.flags[i]&4
					If flag
						w1=TBone(bent).keys.qw[i]
						x1=TBone(bent).keys.qx[i]
						y1=TBone(bent).keys.qy[i]
						z1=TBone(bent).keys.qz[i]
						fd1=framef-i
						found=True
					EndIf
					If i<=start_frame Then i=end_frame+1;ii=ii+1
				Until found=True Or ii>=2
				If found=False Then no_keys=True
				found=False
				ii=0
				
				' forwards
				i=frame
				Repeat
					i=i+1
					If i>end_frame Then i=start_frame;ii=ii+1
					flag=TBone(bent).keys.flags[i]&4
					If flag
						w2=TBone(bent).keys.qw[i]
						x2=TBone(bent).keys.qx[i]
						y2=TBone(bent).keys.qy[i]
						z2=TBone(bent).keys.qz[i]
						fd2=i-framef
						found=True
					EndIf
				Until found=True Or ii>=2
				If found=False Then no_keys=True
				found=False
				ii=0
	
				' interpolate keys
	
				Local w3:Float=0
				Local x3:Float=0
				Local y3:Float=0
				Local z3:Float=0
				If no_keys=True ' no keyframes
					w3=TBone(bent).n_qw
					x3=TBone(bent).n_qx
					y3=TBone(bent).n_qy
					z3=TBone(bent).n_qz
				Else
					If fd1+fd2=0.0 ' one keyframe
						' if only one keyframe, fd1+fd2 will equal 0 resulting in division error and garbage rotational values (which can affect children)
						' so we check for this, and if true then rotational values equals w1,x1,y1,z1 (same as w2,x2,y2,z2)
						w3=w1
						x3=x1
						y3=y1
						z3=z1
					Else ' more than one keyframe
						Local t:Float=(1.0/(fd1+fd2))*fd1
						TQuaternion.Slerp(x1,y1,z1,w1,x2,y2,z2,w2,x3,y3,z3,w3,t) ' interpolate between prev and next rotations
					EndIf
				EndIf
				no_keys=False
				
				' store current keyframe for use with transtions
				TBone(bent).kqw=w3
				TBone(bent).kqx=x3
				TBone(bent).kqy=y3
				TBone(bent).kqz=z3
		
				TQuaternion.QuatToMat(w3,x3,y3,z3,TBone(bent).mat)
	
				TBone(bent).mat.grid[3,0]=px3
				TBone(bent).mat.grid[3,1]=py3
				TBone(bent).mat.grid[3,2]=pz3

				' store local position/rotation values. will be needed to maintain bone positions when positionentity etc is called
				Local pitch#=0
				Local yaw#=0
				Local roll#=0
				TQuaternion.QuatToEuler(w3,x3,y3,z3,pitch#,yaw#,roll#)
				TBone(bent).rx#=-pitch#
				TBone(bent).ry#=yaw#
				TBone(bent).rz#=roll#
				
				TBone(bent).px#=px3
				TBone(bent).py#=py3
				TBone(bent).pz#=pz3			
				
				' set mat2 to equal mat
				TBone(bent).mat2.Overwrite(TBone(bent).mat)
				
				' set mat - includes root parent transformation
				' mat is used for store global bone positions, needed when displaying actual bone positions and attaching entities to bones
				If TBone(bent).parent<>Null
					Local new_mat:TMatrix=TBone(bent).parent.mat.Copy()
					new_mat.Multiply(TBone(bent).mat)
					TBone(bent).mat.Overwrite(new_mat)
				EndIf
				
				' set mat2 - does not include root parent transformation
				' mat2 is used to store local bone positions, and is needed for vertex deform
				If TBone(TBone(bent).parent)<>Null
					Local new_mat:TMatrix=TBone(TBone(bent).parent).mat2.Copy()
					new_mat.Multiply(TBone(bent).mat2)
					TBone(bent).mat2.Overwrite(new_mat)
				EndIf

				' set tform mat
				' A tform mat is needed to transform vertices, and is basically the bone mat multiplied by the inverse reference pose mat
				TBone(bent).tform_mat.Overwrite(TBone(bent).mat2)
				TBone(bent).tform_mat.Multiply(TBone(bent).inv_mat)

				' update bone children
				If TBone(bent).child_list.IsEmpty()<>True Then TEntity.UpdateChildren(bent)
								
			Next
								
			' --- vertex deform ---
			VertexDeform(TMesh(ent1))
		
		EndIf
			
	End Function
	
	' AnimateMesh2, used to animate transitions between animations, very similar to AnimateMesh except it
	' interpolates between current animation pose (via saved keyframe) and first keyframe of new animation.
	' framef:Float interpolates between 0 and 1
	
	Function AnimateMesh2(ent1:TEntity,framef:Float,start_frame:Int,end_frame:Int)
		
		If TMesh(ent1)<>Null
	
			If TMesh(ent1).anim=False Then Return ' mesh contains no anim data
			
			TMesh(ent1).anim_render=True
	
			'Local frame=framef ' float to int
	
			For Local bent:TBone=EachIn TMesh(ent1).bones
					
				Local i:Int=0
				Local ii:Int=0
				Local fd1:Float=framef ' fd1 always between 0 and 1 for this function
				Local fd2:Float=1.0-fd1 ' fd1+fd2 always equals 0 for this function
				Local found:Int=False
				Local no_keys:Int=False
				Local w1:Float
				
				' get current keyframe
				Local x1:Float=TBone(bent).kx
				Local y1:Float=TBone(bent).ky
				Local z1:Float=TBone(bent).kz
				
				Local w2:Float
				Local x2:Float
				Local y2:Float
				Local z2:Float
				
				Local flag:Int=0
				
				' position
	
				' forwards
				'i=frame
				i=start_frame-1
				Repeat
					i=i+1
					If i>end_frame Then i=start_frame;ii=ii+1
					flag=TBone(bent).keys.flags[i]&1
					If flag
						x2=TBone(bent).keys.px[i]
						y2=TBone(bent).keys.py[i]
						z2=TBone(bent).keys.pz[i]
						'fd2=i-framef
						found=True
					EndIf
				Until found=True Or ii>=2
				If found=False Then no_keys=True
				found=False
				ii=0
		
				Local px3:Float=0
				Local py3:Float=0
				Local pz3:Float=0
				If no_keys=True ' no keyframes
					px3=TBone(bent).n_px
					py3=TBone(bent).n_py
					pz3=TBone(bent).n_pz
				Else
					If fd1+fd2=0.0 ' one keyframe
						' if only one keyframe, fd1+fd2 will equal 0 resulting in division error and garbage positional values (which can affect children)
						' so we check for this, and if true then positional values equals x1,y1,z1 (same as x2,y2,z2)
						px3=x1
						py3=y1
						pz3=z1
					Else ' more than one keyframe
						px3=(((x2-x1)/(fd1+fd2))*fd1)+x1
						py3=(((y2-y1)/(fd1+fd2))*fd1)+y1
						pz3=(((z2-z1)/(fd1+fd2))*fd1)+z1
					EndIf
				EndIf
				no_keys=False
			
				' get current keyframe
				w1=TBone(bent).kqw
				x1=TBone(bent).kqx
				y1=TBone(bent).kqy
				z1=TBone(bent).kqz
					
				' rotation
	
				' forwards
				'i=frame
				i=start_frame-1
				Repeat
					i=i+1
					If i>end_frame Then i=start_frame;ii=ii+1
					flag=TBone(bent).keys.flags[i]&4
					If flag
						w2=TBone(bent).keys.qw[i]
						x2=TBone(bent).keys.qx[i]
						y2=TBone(bent).keys.qy[i]
						z2=TBone(bent).keys.qz[i]
						'fd2=i-framef
						found=True
					EndIf
				Until found=True Or ii>=2
				If found=False Then no_keys=True
				found=False
				ii=0
	
				' interpolate keys
	
				Local w3:Float=0
				Local x3:Float=0
				Local y3:Float=0
				Local z3:Float=0
				If no_keys=True ' no keyframes
					w3=TBone(bent).n_qw
					x3=TBone(bent).n_qx
					y3=TBone(bent).n_qy
					z3=TBone(bent).n_qz
				Else
					If fd1+fd2=0.0 ' one keyframe
						' if only one keyframe, fd1+fd2 will equal 0 resulting in division error and garbage rotational values (which can affect children)
						' so we check for this, and if true then rotational values equals w1,x1,y1,z1 (same as w2,x2,y2,z2)
						w3=w1
						x3=x1
						y3=y1
						z3=z1
					Else ' more than one keyframe
						Local t:Float=(1.0/(fd1+fd2))*fd1
						TQuaternion.Slerp(x1,y1,z1,w1,x2,y2,z2,w2,x3,y3,z3,w3,t:Float) ' interpolate between prev and next rotations
					EndIf
				EndIf
				no_keys=False
			
				TQuaternion.QuatToMat(w3,x3,y3,z3,TBone(bent).mat)
	
				TBone(bent).mat.grid[3,0]=px3
				TBone(bent).mat.grid[3,1]=py3
				TBone(bent).mat.grid[3,2]=pz3
		
				' store local position/rotation values. will be needed to maintain bone positions when positionentity etc is called
				Local pitch#=0
				Local yaw#=0
				Local roll#=0
				TQuaternion.QuatToEuler(w3,x3,y3,z3,pitch#,yaw#,roll#)
				TBone(bent).rx#=-pitch#
				TBone(bent).ry#=yaw#
				TBone(bent).rz#=roll#
				
				TBone(bent).px#=px3
				TBone(bent).py#=py3
				TBone(bent).pz#=pz3			
				
				' set mat2 to equal mat
				TBone(bent).mat2.Overwrite(TBone(bent).mat)
				
				' set mat - includes root parent transformation
				' mat is used for store global bone positions, needed when displaying actual bone positions and attaching entities to bones
				If TBone(bent).parent<>Null
					Local new_mat:TMatrix=TBone(bent).parent.mat.Copy()
					new_mat.Multiply(TBone(bent).mat)
					TBone(bent).mat.Overwrite(new_mat)
				EndIf
				
				' set mat2 - does not include root parent transformation
				' mat2 is used to store local bone positions, and is needed for vertex deform
				If TBone(TBone(bent).parent)<>Null
					Local new_mat:TMatrix=TBone(TBone(bent).parent).mat2.Copy()
					new_mat.Multiply(TBone(bent).mat2)
					TBone(bent).mat2.Overwrite(new_mat)
				EndIf

				' set tform mat
				' A tform mat is needed to transform vertices, and is basically the bone mat multiplied by the inverse reference pose mat
				TBone(bent).tform_mat.Overwrite(TBone(bent).mat2)
				TBone(bent).tform_mat.Multiply(TBone(bent).inv_mat)

				' update bone children
				If TBone(bent).child_list.IsEmpty()<>True Then TEntity.UpdateChildren(bent)
		
			Next
								
			' --- vertex deform ---
			VertexDeform(TMesh(ent1))
		
		EndIf
			
	End Function
	
	Function VertexDeform(ent:TMesh)

		Local ovx:Float,ovy:Float,ovz:Float ' original vertex positions
		Local x:Float,y:Float,z:Float

		Local bone:TBone
		Local weight:Float
		
		Local slink:TLink=TMesh(ent).surf_list.FirstLink() ' used to iterate through surf_list
	
		' cycle through all surfs
		For Local anim_surf:TSurface=EachIn ent.anim_surf_list

			Local surf:TSurface=TSurface(slink.Value:Object())
			
			' mesh shape will be changed, update reset_vbo flag (1=vertices move)
			anim_surf.reset_vbo:|1
				
			Local vid:Int
			Local vid3:Int
			
			For vid=0 Until anim_surf.no_verts
			
				vid3=vid*3

				' BONE 1
						
				If anim_surf.vert_bone1_no[vid]<>0
							
					' get original vertex position
					ovx=surf.vert_coords[vid3+0]'VertexX(vid)
					ovy=surf.vert_coords[vid3+1]'VertexY(vid)
					ovz=surf.vert_coords[vid3+2]'VertexZ(vid)
					
					bone=ent.bones[anim_surf.vert_bone1_no[vid]-1]
					weight:Float=anim_surf.vert_weight1[vid]
					
					' transform vertex position with transform mat
					x= ( bone.tform_mat.grid[0,0]*ovx + bone.tform_mat.grid[1,0]*ovy + bone.tform_mat.grid[2,0]*ovz + bone.tform_mat.grid[3,0] ) * weight
					y= ( bone.tform_mat.grid[0,1]*ovx + bone.tform_mat.grid[1,1]*ovy + bone.tform_mat.grid[2,1]*ovz + bone.tform_mat.grid[3,1] ) * weight
					z= ( bone.tform_mat.grid[0,2]*ovx + bone.tform_mat.grid[1,2]*ovy + bone.tform_mat.grid[2,2]*ovz + bone.tform_mat.grid[3,2] ) * weight
									
					' BONE 2

					If anim_surf.vert_bone2_no[vid]<>0
				
						bone=ent.bones[anim_surf.vert_bone2_no[vid]-1]
						weight=anim_surf.vert_weight2[vid]
						
						' transform vertex position with transform mat
						x:+ ( bone.tform_mat.grid[0,0]*ovx + bone.tform_mat.grid[1,0]*ovy + bone.tform_mat.grid[2,0]*ovz + bone.tform_mat.grid[3,0] ) * weight
						y:+ ( bone.tform_mat.grid[0,1]*ovx + bone.tform_mat.grid[1,1]*ovy + bone.tform_mat.grid[2,1]*ovz + bone.tform_mat.grid[3,1] ) * weight
						z:+ ( bone.tform_mat.grid[0,2]*ovx + bone.tform_mat.grid[1,2]*ovy + bone.tform_mat.grid[2,2]*ovz + bone.tform_mat.grid[3,2] ) * weight
						
						' BONE 3
						
						If anim_surf.vert_bone3_no[vid]<>0

							bone=ent.bones[anim_surf.vert_bone3_no[vid]-1]
							weight=anim_surf.vert_weight3[vid]

							' transform vertex position with transform mat
							x:+ ( bone.tform_mat.grid[0,0]*ovx + bone.tform_mat.grid[1,0]*ovy + bone.tform_mat.grid[2,0]*ovz + bone.tform_mat.grid[3,0] ) * weight
							y:+ ( bone.tform_mat.grid[0,1]*ovx + bone.tform_mat.grid[1,1]*ovy + bone.tform_mat.grid[2,1]*ovz + bone.tform_mat.grid[3,1] ) * weight
							z:+ ( bone.tform_mat.grid[0,2]*ovx + bone.tform_mat.grid[1,2]*ovy + bone.tform_mat.grid[2,2]*ovz + bone.tform_mat.grid[3,2] ) * weight
										
							' BONE 4
							
							If anim_surf.vert_bone4_no[vid]<>0
		
								bone=ent.bones[anim_surf.vert_bone4_no[vid]-1]
								weight=anim_surf.vert_weight4[vid]
								
								' transform vertex position with transform mat
								x:+ ( bone.tform_mat.grid[0,0]*ovx + bone.tform_mat.grid[1,0]*ovy + bone.tform_mat.grid[2,0]*ovz + bone.tform_mat.grid[3,0] ) * weight
								y:+ ( bone.tform_mat.grid[0,1]*ovx + bone.tform_mat.grid[1,1]*ovy + bone.tform_mat.grid[2,1]*ovz + bone.tform_mat.grid[3,1] ) * weight
								z:+ ( bone.tform_mat.grid[0,2]*ovx + bone.tform_mat.grid[1,2]*ovy + bone.tform_mat.grid[2,2]*ovz + bone.tform_mat.grid[3,2] ) * weight
					
							EndIf
					
						EndIf
					
					EndIf
					
					' update vertex position
					'anim_surf.VertexCoords(vid,x,y,z)
					anim_surf.vert_coords[vid3]=x
					anim_surf.vert_coords[vid3+1]=y
					anim_surf.vert_coords[vid3+2]=z
					
				EndIf

			Next
				
			slink=slink.NextLink() ' iterate through surf_list in sync with anim_surf_list
			
		Next
		
	End Function
	
	' this function will normalise weights if their sum doesn't equal 1.0 (unused)
	Function NormaliseWeights(mesh:TMesh)
	
		' cycle through all surfs
		For Local anim_surf:TSurface=EachIn mesh.anim_surf_list
				
			For Local vid:Int=0 Until anim_surf.no_verts

				' normalise weights
		
				Local w1:Float=anim_surf.vert_weight1[vid]
				Local w2:Float=anim_surf.vert_weight2[vid]
				Local w3:Float=anim_surf.vert_weight3[vid]
				Local w4:Float=anim_surf.vert_weight4[vid]
							
				Local wt:Float=w1+w2+w3+w4
					
				' normalise weights if sum of them <> 1.0
																													
				If wt<0.99 Or wt>1.01
		
					Local wm:Float
					If wt<>0.0
						wm=1.0/wt
					Else
						wm=1.0
					EndIf
					w1=w1*wm
					w2=w2*wm
					w3=w3*wm
					w4=w4*wm
		
					anim_surf.vert_weight1[vid]=w1
					anim_surf.vert_weight2[vid]=w2
					anim_surf.vert_weight3[vid]=w3
					anim_surf.vert_weight4[vid]=w4
						
				EndIf
			
			Next
			
		Next
		
	End Function

End Type

Type TAnimationKeys

	Field frames:Int
	Field flags:Int[1]
	Field px:Float[1]
	Field py:Float[1]
	Field pz:Float[1]
	Field sx:Float[1]
	Field sy:Float[1]
	Field sz:Float[1]
	Field qw:Float[1]
	Field qx:Float[1]
	Field qy:Float[1]
	Field qz:Float[1]
	
	Method New()
	
		If LOG_NEW
			DebugLog "New TAnimationKeys"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TAnimationKeys"
		EndIf
	
	End Method
	
	Method Copy:TAnimationKeys()
	
		Local keys:TAnimationKeys=New TAnimationKeys
	
		keys.frames=frames
		keys.flags=flags[..]
		keys.px=px[..]
		keys.py=py[..]
		keys.pz=pz[..]
		keys.sx=sx[..]
		keys.sy=sy[..]
		keys.sz=sz[..]
		keys.qw=qw[..]
		keys.qx=qx[..]
		keys.qy=qy[..]
		keys.qz=qz[..]

		Return keys
	
	End Method
	
End Type
