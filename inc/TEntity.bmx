Type TEntity

	Global entity_list:TList=CreateList()

	Field child_list:TList=CreateList()

	Field parent:TEntity
	
	Field mat:TMatrix=New TMatrix
	Field px#,py#,pz#,sx#=1.0,sy#=1.0,sz#=1.0,rx#,ry#,rz#,qw#,qx#,qy#,qz#
	
	Field name$
	Field class$
	Field hide:Int=False
	Field order:Int,alpha_order#
	Field auto_fade:Int,fade_near#,fade_far#,fade_alpha#

	Field brush:TBrush=New TBrush
	
	Field cull_radius#
	
	Field radius_x#=1.0,radius_y#=1.0
	Field box_x#=-1.0,box_y#=-1.0,box_z#=-1.0,box_w#=2.0,box_h#=2.0,box_d#=2.0
	Field collision_type:Int
	Field no_collisions:Int,collision:TCollisionImpact[]
	Field pick_mode:Int,obscurer:Int

	Field anim:Int ' true if mesh contains anim data
	Field anim_render:Int ' true to render as anim mesh
	Field anim_mode:Int
	Field anim_time#
	Field anim_speed#
	Field anim_seq:Int
	Field anim_trans:Int
	Field anim_dir:Int=1 ' 1=forward, -1=backward
	Field anim_seqs_first:Int[1]
	Field anim_seqs_last:Int[1]
	Field no_seqs:Int=0
	Field anim_update:Int
	
	Global tformed_x#
	Global tformed_y#
	Global tformed_z#
	
	' used by TCollisions
	Field old_x#
	Field old_y#
	Field old_z#
		
	Field link:TLink ' entity_list tlink, stored for quick removal of entity from list ***note*** not currently used to remove entity from list

	Method CopyEntity:TEntity(parent_ent:TEntity=Null) Abstract
	Method Update() Abstract

	Method New()
	
		If LOG_NEW
			DebugLog "New TEntity"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TEntity"
		EndIf
	
	End Method

	Method FreeEntity()
	
		ListRemove(entity_list,Self)
	
		'RemoveLink link ' remove self from entity list - mem leak!
		
		' remove from collision entity lists
		If collision_type<>0 ListRemove(TCollisionPair.ent_lists[collision_type],Self)
		
		' remove from pick entity list
		If pick_mode<>0 ListRemove(TPick.ent_list,Self)
		
		Local ent:TEntity
		
		' free self from parent's child_list
		If parent<>Null
			For ent=EachIn parent.child_list
				If ent=Self Then ListRemove(parent.child_list,Self)
			Next
		EndIf
		
		parent=Null
		mat=Null
		brush=Null
		link=Null
	
		' free children entities
		For ent=EachIn child_list
			ent.FreeEntity()
			ent=Null
		Next

	End Method

	' Entity movement

	Method PositionEntity(x#,y#,z#,glob:Int=False)

		px=x
		py=y
		pz=-z

		' conv glob to local. x/y/z always local to parent or global if no parent
		If glob=True And parent<>Null
			
			px=px-parent.EntityX(True)
			py=py-parent.EntityY(True)
			pz=pz+parent.EntityZ(True) ' z reversed
			
			Local prx#=-parent.EntityPitch(True)
			Local pry#=parent.EntityYaw(True)
			Local prz#=parent.EntityRoll(True)
			
			Local psx#=parent.EntityScaleX(True)
			Local psy#=parent.EntityScaleY(True)
			Local psz#=parent.EntityScaleZ(True)
						
			Local new_mat:TMatrix=New TMatrix
			new_mat.LoadIdentity()
			new_mat.Scale(1.0/psx#,1.0/psy#,1.0/psz#)
			new_mat.RotateRoll(-prz)
			new_mat.RotatePitch(-prx)
			new_mat.RotateYaw(-pry)
			new_mat.Translate(px,py,pz)
			
			px=new_mat.grid[3,0]
			py=new_mat.grid[3,1]
			pz=new_mat.grid[3,2]

		EndIf
	
		If parent<>Null
		
			mat.Overwrite(parent.mat)
			UpdateMat()
		
		Else ' glob=true or false
		
			UpdateMat(True)
			
		EndIf
		
		If child_list.IsEmpty()<>True Then UpdateChildren(Self)

	End Method
		
	Method MoveEntity(mx#,my#,mz#)

		mz#=-mz

		Local new_mat:TMatrix=New TMatrix
		new_mat.LoadIdentity()
		new_mat.RotateYaw(ry)
		new_mat.RotatePitch(rx)
		new_mat.RotateRoll(rz)
		new_mat.Translate(mx#,my#,mz#)
	
		mx=new_mat.grid[3,0]
		my=new_mat.grid[3,1]
		mz=new_mat.grid[3,2]
		
		px=px+mx
		py=py+my
		pz=pz+mz

		If parent<>Null
		
			mat.Overwrite(parent.mat)
			UpdateMat()
		
		Else ' glob=true or false
		
			UpdateMat(True)
			
		EndIf
		
		UpdateChildren(Self)

	End Method

	Method TranslateEntity(tx#,ty#,tz#,glob:Int=False)

		'Local tx#=x
		'Local ty#=y
		tz#=-tz#

		' conv glob to local. x/y/z always local to parent or global if no parent
		If glob=True And parent<>Null

			Local ax#=-parent.EntityPitch(True)
			Local ay#=parent.EntityYaw(True)
			Local az#=parent.EntityRoll(True)
						
			Local new_mat:TMatrix=New TMatrix
			new_mat.LoadIdentity()
			new_mat.RotateRoll(-az)
			new_mat.RotatePitch(-ax)
			new_mat.RotateYaw(-ay)
			new_mat.Translate(tx,ty,tz)

			tx=new_mat.grid[3,0]
			ty=new_mat.grid[3,1]
			tz=new_mat.grid[3,2]
			
		EndIf
		
		px=px+tx
		py=py+ty
		pz=pz+tz

		If parent<>Null
		
			mat.Overwrite(parent.mat)
			UpdateMat()
		
		Else ' glob=true or false
		
			UpdateMat(True)
			
		EndIf
		
		If child_list.IsEmpty()<>True Then UpdateChildren(Self)

	End Method
	
	Method ScaleEntity(x#,y#,z#,glob:Int=False)

		sx#=x#
		sy#=y#
		sz#=z#

		' conv glob to local. x/y/z always local to parent or global if no parent
		If glob=True And parent<>Null
			
			Local ent:TEntity=Self
						
			Repeat

				sx#=sx#/ent.parent.sx#
				sy#=sy#/ent.parent.sy#
				sz#=sz#/ent.parent.sz#
	
				ent=ent.parent
									
			Until ent.parent=Null	
	
		EndIf
	
		If parent<>Null
		
			mat.Overwrite(parent.mat)
			UpdateMat()
		
		Else ' glob=true or false
		
			UpdateMat(True)
			
		EndIf
		
		If child_list.IsEmpty()<>True Then UpdateChildren(Self)

	End Method

	Method RotateEntity(x#,y#,z#,glob:Int=False)

		rx=-x#
		ry=y#
		rz=z#
		
		' conv glob to local. pitch/yaw/roll always local to parent or global if no parent
		If glob=True And parent<>Null

			rx=rx+parent.EntityPitch(True)
			ry=ry-parent.EntityYaw(True)
			rz=rz-parent.EntityRoll(True)
		
		EndIf
		
		If parent<>Null
		
			mat.Overwrite(parent.mat)
			UpdateMat()
		
		Else ' glob=true or false
		
			UpdateMat(True)
			
		EndIf
		
		If child_list.IsEmpty()<>True Then UpdateChildren(Self)

	End Method

	Method TurnEntity(x#,y#,z#,glob:Int=False)

		Local tx#=-x
		Local ty#=y
		Local tz#=z

		' conv glob to local. x/y/z always local to parent or global if no parent
		If glob=True And parent<>Null

			'
			
		EndIf
				
		rx=rx+tx
		ry=ry+ty
		rz=rz+tz

		If parent<>Null
		
			mat.Overwrite(parent.mat)
			UpdateMat()
		
		Else ' glob=true or false
		
			UpdateMat(True)
			
		EndIf
		
		If child_list.IsEmpty()<>True Then UpdateChildren(Self)

	End Method

	' Function by mongia2
	Method PointEntity(target_ent:TEntity,roll#=0)
	
		Local x#=target_ent.EntityX#(True)
		Local y#=target_ent.EntityY#(True)
		Local z#=target_ent.EntityZ#(True)

		Local xdiff#=Self.EntityX(True)-x#
		Local ydiff#=Self.EntityY(True)-y#
		Local zdiff#=Self.EntityZ(True)-z#

		Local dist22#=Sqr((xdiff#*xdiff#)+(zdiff#*zdiff#))
		Local pitch#=ATan2(ydiff#,dist22#)
		Local yaw#=ATan2(xdiff#,-zdiff#)

		Self.RotateEntity pitch#,yaw#,roll#,True

	End Method
		
	' Entity animation

	' load anim seq - copies anim data from mesh to self
	Method LoadAnimSeq:Int(file:String)
	
		If FileType(file)=0 Then Return 0
	
		' mesh that we will load anim seq from
		Local mesh:TMesh=TModel.LoadAnimB3D:TMesh(file)
		
		If anim=False Then Return 0 ' self contains no anim data
		If mesh.anim=False Then Return 0 ' mesh contains no anim data
	
		no_seqs=no_seqs+1
		
		' expand anim_seqs array
		anim_seqs_first=anim_seqs_first[..no_seqs+1]
		anim_seqs_last=anim_seqs_last[..no_seqs+1]
	
		' update anim_seqs array
		anim_seqs_first[no_seqs]=anim_seqs_last[0]
		anim_seqs_last[no_seqs]=anim_seqs_last[0]+mesh.anim_seqs_last[0]
	
		' update anim_seqs_last[0] - sequence 0 is for all frames, so this needs to be increased
		' must be done after updating anim_seqs array above
		anim_seqs_last[0]=anim_seqs_last[0]+mesh.anim_seqs_last[0]
	
		If mesh<>Null

			' go through all bones belonging to self
			For Local bone:TBone=EachIn TMesh(Self).bones
			
				' find bone in mesh that matches bone in self - search based on bone name
				Local mesh_bone:TBone=TBone(TEntity(mesh).FindChild(bone.name$))
			
				If mesh_bone<>Null
			
					' resize self arrays first so the one empty element at the end is removed
					bone.keys.flags=bone.keys.flags[..bone.keys.flags.length-1]
					bone.keys.px=bone.keys.px[..bone.keys.px.length-1]
					bone.keys.py=bone.keys.py[..bone.keys.py.length-1]
					bone.keys.pz=bone.keys.pz[..bone.keys.pz.length-1]
					bone.keys.sx=bone.keys.sx[..bone.keys.sx.length-1]
					bone.keys.sy=bone.keys.sy[..bone.keys.sy.length-1]
					bone.keys.sz=bone.keys.sz[..bone.keys.sz.length-1]
					bone.keys.qw=bone.keys.qw[..bone.keys.qw.length-1]
					bone.keys.qx=bone.keys.qx[..bone.keys.qx.length-1]
					bone.keys.qy=bone.keys.qy[..bone.keys.qy.length-1]
					bone.keys.qz=bone.keys.qz[..bone.keys.qz.length-1]
					
					' add mesh bone key arrays to self bone key arrays
					bone.keys.frames=anim_seqs_last[0]
					bone.keys.flags=bone.keys.flags+mesh_bone.keys.flags
					bone.keys.px=bone.keys.px+mesh_bone.keys.px
					bone.keys.py=bone.keys.py+mesh_bone.keys.py
					bone.keys.pz=bone.keys.pz+mesh_bone.keys.pz
					bone.keys.sx=bone.keys.sx+mesh_bone.keys.sx
					bone.keys.sy=bone.keys.sy+mesh_bone.keys.sy
					bone.keys.sz=bone.keys.sz+mesh_bone.keys.sz
					bone.keys.qw=bone.keys.qw+mesh_bone.keys.qw
					bone.keys.qx=bone.keys.qx+mesh_bone.keys.qx
					bone.keys.qy=bone.keys.qy+mesh_bone.keys.qy
					bone.keys.qz=bone.keys.qz+mesh_bone.keys.qz
				
				EndIf
				
			Next
				
		EndIf
		
		mesh.FreeEntity()
		
		Return no_seqs
	
	End Method
	
	Method ExtractAnimSeq:Int(first_frame:Int,last_frame:Int,seq:Int=0)
	
		no_seqs=no_seqs+1
	
		' expand anim_seqs array
		anim_seqs_first=anim_seqs_first[..no_seqs+1]
		anim_seqs_last=anim_seqs_last[..no_seqs+1]
	
		' if seq specifed then extract anim sequence from within existing sequnce
		Local offset:Int=0
		If seq<>0
			offset=anim_seqs_first[seq]
		EndIf
	
		anim_seqs_first[no_seqs]=first_frame+offset
		anim_seqs_last[no_seqs]=last_frame+offset
		
		Return no_seqs
	
	End Method

	Method Animate(mode:Int=1,speed#=1.0,seq:Int=0,trans:Int=0)
	
		anim_mode=mode
		anim_speed#=speed#
		anim_seq=seq
		anim_trans=trans
		anim_time#=anim_seqs_first[seq]
		anim_update=True ' update anim for all modes (including 0)
		
		If trans>0
			anim_time#=0
		EndIf
		
	End Method
	
	' Updates:
	' 30/01/06 - updated to make anim_time return wrapped value
	Method SetAnimTime(time#,seq:Int=0)
	
		anim_mode=-1 ' use a mode of -1 for setanimtime
		anim_speed#=0
		anim_seq=seq
		anim_trans=0
		anim_time#=time#
		anim_update=False ' set anim_update to false so UpdateWorld won't animate entity

		Local first:Int=anim_seqs_first[anim_seq]
		Local last:Int=anim_seqs_last[anim_seq]
		Local first2last:Int=anim_seqs_last[anim_seq]-anim_seqs_first[anim_seq]
		
		time#=time#+first ' offset time so that anim time of 0 will equal first frame of sequence
		
		If time#>last And first2last>0 ' check that first2last>0 to prevent infinite loop
			Repeat
				time#=time#-first2last
			Until time#<=last
		EndIf
		If time#<first And first2last>0 ' check that first2last>0 to prevent infinite loop
			Repeat
				time#=time#+first2last
			Until time#>=first
		EndIf
		
		TAnimation.AnimateMesh(Self,time#,first,last)

		anim_time#=time# ' update anim_time# to equal time#

	End Method
	
	Method AnimSeq:Int()
	
		Return anim_seq ' current anim sequence
	
	End Method
	
	Method AnimLength:Int()
	
		Return anim_seqs_last[anim_seq]-anim_seqs_first[anim_seq] ' no of frames in anim sequence
	
	End Method

	Method AnimTime#()
	
		' if animation in transition, return 0 (anim_time actually will be somewhere between 0 and 1)
		If anim_trans>0 Then Return 0
		
		' for animate and setanimtime we want to return anim_time starting from 0 and ending at no. of frames in sequence
		If anim_mode>0 Or anim_mode=-1
			Return anim_time#-anim_seqs_first[anim_seq]
		EndIf

		Return 0

	End Method
	
	Method Animating:Int()
	
		If anim_trans>0 Then Return True
		If anim_mode>0 Then Return True
		
		Return False
	
	End Method
		
	' Entity control

	Method EntityColor(r#,g#,b#)
	
		brush.red  =r#/255.0
		brush.green=g#/255.0
		brush.blue =b#/255.0
	
	End Method

	Method EntityAlpha(a#)
	
		brush.alpha=a#
			
	End Method
	
	Method EntityShininess(s#)
	
		brush.shine=s#
	
	End Method

	Method EntityTexture(texture:TTexture,frame:Int=0,index:Int=0)

		brush.tex[index]=texture
		If index+1>brush.no_texs Then brush.no_texs=index+1
		
		If frame<0 Then frame=0
		If frame>texture.no_frames-1 Then frame=texture.no_frames-1 
		brush.tex_frame=frame
	
	End Method
	
	Method EntityBlend(blend_no:Int)
	
		brush.blend=blend_no
		
		If TMesh(Self)<>Null
		
			' overwrite surface blend modes with master blend mode
			For Local surf:TSurface=EachIn TMesh(Self).surf_list
				If surf.brush<>Null
					surf.brush.blend=brush.blend
				EndIf
			Next
			
		EndIf
		
	End Method
	
	Method EntityFX(fx_no:Int)
	
		brush.fx=fx_no
		
	End Method
	
	Method EntityAutoFade(near#,far#)
	
		auto_fade=True
		fade_near=near#
		fade_far=far#
	
	End Method
	
	Method PaintEntity(bru:TBrush)
	
		brush.no_texs=bru.no_texs
		brush.name$=bru.name$
		brush.red#=bru.red#
		brush.green#=bru.green#
		brush.blue#=bru.blue#
		brush.alpha#=bru.alpha#
		brush.shine#=bru.shine#
		brush.blend=bru.blend
		brush.fx=bru.fx
		For Local i:Int=0 To 7
			brush.tex[i]=bru.tex[i]
		Next
	
	End Method
	
	Method EntityOrder(order_no:Int)
	
		order=order_no

		If TCamera(Self)<>Null
			ListRemove(TCamera.cam_list,Self)
			EntityListAdd(TCamera.cam_list)
		EndIf

	End Method
	
	Method ShowEntity()
	
		hide=False
		
	End Method

	Method HideEntity()

		hide=True

	End Method

	Method Hidden:Int()
	
		If hide=True Return True
		
		Local ent:TEntity=parent
		While ent<>Null
			If ent.hide=True Return True
			ent=ent.parent
		Wend
		
		Return False
	
	End Method

	Method NameEntity(e_name$)
	
		name$=e_name$
	
	End Method
	
	Method EntityParent(parent_ent:TEntity,glob:Int=True)

		'' remove old parent

		' get global values
		Local gpx:Float=EntityX(True)
		Local gpy:Float=EntityY(True)
		Local gpz:Float=EntityZ(True)
		
		Local grx:Float=EntityPitch(True)
		Local gry:Float=EntityYaw(True)
		Local grz:Float=EntityRoll(True)
		
		Local gsx:Float=EntityScaleX(True)
		Local gsy:Float=EntityScaleY(True)
		Local gsz:Float=EntityScaleZ(True)
	
		' remove self from parent's child list
		If parent<>Null
			For Local ent:TEntity=EachIn parent.child_list
				If ent=Self Then ListRemove(parent.child_list,Self)
			Next
			parent=Null
		EndIf

		' entity no longer has parent, so set local values to equal global values
		' must get global values before we reset transform matrix with UpdateMat
		px#=gpx
		py#=gpy
		pz#=-gpz
		rx#=-grx
		ry#=gry
		rz#=grz
		sx#=gsx
		sy#=gsy
		sz#=gsz
		
		''
		
		' No new parent
		If parent_ent=Null
			UpdateMat(True)
			Return
		EndIf
		
		' New parent
	
		If parent_ent<>Null
			
			If glob=True

				AddParent(parent_ent)
				'UpdateMat()

				PositionEntity(gpx,gpy,gpz,True)
				RotateEntity(grx,gry,grz,True)
				ScaleEntity(gsx,gsy,gsz,True)

			Else
			
				AddParent(parent_ent)
				UpdateMat()
				
			EndIf
			
		EndIf

	End Method
		
	Method GetParent:TEntity()
	
		Return parent
	
	End Method

	' Entity state

	Method EntityX#(glob:Int=False)
	
		If glob=False
		
			Return px
		
		Else
		
			Return mat.grid[3,0]
		
		EndIf
	
	End Method
	
	Method EntityY#(glob:Int=False)
	
		If glob=False
		
			Return py
		
		Else
		
			Return mat.grid[3,1]
		
		EndIf
	
	End Method
	
	Method EntityZ#(glob:Int=False)
	
		If glob=False
		
			Return -pz
		
		Else
		
			Return -mat.grid[3,2]
		
		EndIf
	
	End Method

	Method EntityPitch#(glob:Int=False)
		
		If glob=False
		
			Return -rx
			
		Else
		
			Local ang#=ATan2( mat.grid[2,1],Sqr( mat.grid[2,0]*mat.grid[2,0]+mat.grid[2,2]*mat.grid[2,2] ) )
			'Local ang#=ASin(mat.grid[2,1])
			'If ang#=nan Then ang#=0
			If ang#<=0.0001 And ang#>=-0.0001 Then ang#=0
		
			Return ang#
			
		EndIf
			
	End Method
	
	Method EntityYaw#(glob:Int=False)
		
		If glob=False
		
			Return ry
			
		Else
		
			Local a#=mat.grid[2,0]
			Local b#=mat.grid[2,2]
			If a#<=0.0001 And a#>=-0.0001 Then a#=0
			If b#<=0.0001 And b#>=-0.0001 Then b#=0
			Return ATan2(a#,b#)
			
		EndIf
			
	End Method
	
	Method EntityRoll#(glob:Int=False)
		
		If glob=False
		
			Return rz
			
		Else
		
			Local a#=mat.grid[0,1]
			Local b#=mat.grid[1,1]
			If a#<=0.0001 And a#>=-0.0001 Then a#=0
			If b#<=0.0001 And b#>=-0.0001 Then b#=0
			Return ATan2(a#,b#)
			
		EndIf
			
	End Method
	
	Method EntityClass$()
		
		Return class$
		
	End Method
	
	Method EntityName$()
		
		Return name$
		
	End Method
	
	Method CountChildren:Int()

		Local no_children:Int=0
		
		For Local ent:TEntity=EachIn child_list

			no_children=no_children+1

		Next

		Return no_children

	End Method
	
	Method GetChild:TEntity(child_no:Int)
	
		Local no_children:Int=0
		
		For Local ent:TEntity=EachIn child_list

			no_children=no_children+1
			If no_children=child_no Return ent

		Next

		Return Null
	
	End Method
	
	Method FindChild:TEntity(child_name$)
	
		Local cent:TEntity
	
		For Local ent:TEntity=EachIn child_list

			If ent.EntityName$()=child_name$ Return ent

			cent=ent.FindChild(child_name$)
			
			If cent<>Null Return cent
	
		Next

		Return Null
	
	End Method
	
	' Calls function in TPick
	Method EntityPick:TEntity(range#)
	
		Return TPick.EntityPick:TEntity(Self,range#)
	
	End Method
	
	' Calls function in TPick
	Method LinePick:TEntity(x#,y#,z#,dx#,dy#,dz#,radius#=0.0)
	
		Return TPick.LinePick:TEntity(x#,y#,z#,dx#,dy#,dz#,radius#=0.0)
	
	End Method
	
	' Calls function in TPick
	Method EntityVisible:Int(src_entity:TEntity,dest_entity:TEntity)
	
		Return TPick.EntityVisible(src_entity,dest_entity)
	
	End Method
	
	Method EntityDistance#(ent2:TEntity)

		Return Sqr(Self.EntityDistanceSquared#(ent2))

	End Method
	
	' Function by Vertex
	Method DeltaYaw#(ent2:TEntity)
	
		Local x#=ent2.EntityX#(True)-Self.EntityX#(True)
		'Local y#=ent2.EntityY#(True)-Self.EntityY#(True)
		Local z#=ent2.EntityZ#(True)-Self.EntityZ#(True)
		
		Return -ATan2(x#,z#)

	End Method
	
	' Function by Vertex
	Method DeltaPitch#(ent2:TEntity)
	
		Local x#=ent2.EntityX#(True)-Self.EntityX#(True)
		Local y#=ent2.EntityY#(True)-Self.EntityY#(True)
		Local z#=ent2.EntityZ#(True)-Self.EntityZ#(True)
	
		Return -ATan2(y#,Sqr(x#*x#+z#*z#))
	
	End Method
	
	Function TFormPoint(x#,y#,z#,src_ent:TEntity,dest_ent:TEntity)
	
		Global mat:TMatrix=New TMatrix '***global***
	
		If src_ent<>Null

			mat.Overwrite(src_ent.mat)
			mat.Translate(x#,y#,-z#)
			
			x#=mat.grid[3,0]
			y#=mat.grid[3,1]
			z#=-mat.grid[3,2]
		
		EndIf

		If dest_ent<>Null

			mat.LoadIdentity()
		
			Local ent:TEntity=dest_ent
			
			Repeat
	
				mat.Scale(1.0/ent.sx,1.0/ent.sy,1.0/ent.sz)
				mat.RotateRoll(-ent.rz)
				mat.RotatePitch(-ent.rx)
				mat.RotateYaw(-ent.ry)
				mat.Translate(-ent.px,-ent.py,-ent.pz)																																																																																																																																																																																																																																																																																																																																									

				ent=ent.parent
			
			Until ent=Null
		
			mat.Translate(x#,y#,-z#)
			
			x#=mat.grid[3,0]
			y#=mat.grid[3,1]
			z#=-mat.grid[3,2]
			
		EndIf
		
		tformed_x#=x#
		tformed_y#=y#
		tformed_z#=z#
		
	End Function

	Function TFormVector(x#,y#,z#,src_ent:TEntity,dest_ent:TEntity)
	
		Global mat:TMatrix=New TMatrix '***global***
	
		If src_ent<>Null

			mat.Overwrite(src_ent.mat)
			
			mat.grid[3,0]=0
			mat.grid[3,1]=0
			mat.grid[3,2]=0
			mat.grid[3,3]=1
			mat.grid[0,3]=0
			mat.grid[1,3]=0
			mat.grid[2,3]=0
				
			mat.Translate(x#,y#,-z#)
	
			x#=mat.grid[3,0]
			y#=mat.grid[3,1]
			z#=-mat.grid[3,2]
		
		EndIf

		If dest_ent<>Null

			mat.LoadIdentity()
			'mat.Translate(x#,y#,z#)
		
			Local ent:TEntity=dest_ent
			
			Repeat
	
				mat.Scale(1.0/ent.sx,1.0/ent.sy,1.0/ent.sz)
				mat.RotateRoll(-ent.rz)
				mat.RotatePitch(-ent.rx)
				mat.RotateYaw(-ent.ry)
				'mat.Translate(-ent.px,-ent.py,-ent.pz)																																																																																																																																																																																																																																																																																																																																									

				ent=ent.parent
			
			Until ent=Null
		
			mat.Translate(x#,y#,-z#)
			
			x#=mat.grid[3,0]
			y#=mat.grid[3,1]
			z#=-mat.grid[3,2]
			
		EndIf
		
		tformed_x#=x#
		tformed_y#=y#
		tformed_z#=z#
	
	End Function

	Function TFormNormal(x#,y#,z#,src_ent:TEntity,dest_ent:TEntity)

		TEntity.TFormVector(x#,y#,z#,src_ent,dest_ent)
		
		Local uv#=Sqr((tformed_x#*tformed_x#)+(tformed_y#*tformed_y#)+(tformed_z#*tformed_z#))
		
		tformed_x#:/uv#
		tformed_y#:/uv#
		tformed_z#:/uv#
	
	End Function
	
	Function TFormedX#()
	
		Return tformed_x#
	
	End Function
	
	Function TFormedY#()
	
		Return tformed_y#
	
	End Function
	
	Function TFormedZ#()
	
		Return tformed_z#
	
	End Function
	
	Method GetMatElement#(row:Int,col:Int)
	
		Return mat.grid[row,col]
	
	End Method
	
	' Entity collision
	
	Method ResetEntity()
	
		no_collisions=0
		collision=collision[..0]
		old_x=EntityX(True)
		old_y=EntityY(True)
		old_z=EntityZ(True)
	
	End Method
	
	Method EntityRadius(rx#,ry#=0.0)
	
		radius_x#=rx#
		If ry#=0.0 Then radius_y#=rx# Else radius_y#=ry#
	
	End Method
	
	Method EntityBox(x#,y#,z#,w#,h#,d#)
	
		box_x#=x#
		box_y#=y#
		box_z#=z#
		box_w#=w#
		box_h#=h#
		box_d#=d#
	
	End Method

	Method EntityType(type_no:Int,recursive:Int=False)
	
		' add to collision entity list if new type no<>0 and not previously added
		If collision_type=0 And type_no<>0
		
			If TCollisionPair.ent_lists[type_no]=Null Then TCollisionPair.ent_lists[type_no]=CreateList() ' create new list is one doesn't exist
			
			ListAddLast(TCollisionPair.ent_lists[type_no],Self)
			
		EndIf
		
		' remove from collision entity list if new type no=0 and previously added
		If collision_type<>0 And type_no=0
			'ListRemove(TCollisionPair.ent_lists[type_no],Self)
			ListRemove(TCollisionPair.ent_lists[collision_type],Self) 'SMALLFIXES Collision fix from http://www.blitzbasic.com/Community/posts.php?topic=87551
		EndIf
		
		collision_type=type_no
		
		old_x#=EntityX(True)
		old_y#=EntityY(True)
		old_z#=EntityZ(True)
	
		If recursive=True
		
			For Local ent:TEntity=EachIn child_list
			
				ent.EntityType(type_no,True)
			
			Next
		
		EndIf
		
	End Method
	
	Method EntityPickMode(no:Int,obscure:Int=True)
	
		' add to pick entity list if new mode no<>0 and not previously added
		If pick_mode=0 And no<>0
			ListAddLast(TPick.ent_list,Self)
		EndIf
		
		' remove from pick entity list if new mode no=0 and previously added
		If pick_mode<>0 And no=0
			ListRemove(TPick.ent_list,Self)
		EndIf
	
		pick_mode=no
		obscurer=obscure
			
	End Method
	
	Method EntityCollided:TEntity(type_no:Int)

		' if self is source entity and type_no is dest entity
		For Local i:Int=1 To CountCollisions()
			If CollisionEntity(i).collision_type=type_no Then Return CollisionEntity(i)
		Next

		' if self is dest entity and type_no is src entity
		For Local ent:TEntity=EachIn TCollisionPair.ent_lists[type_no]
			For Local i:Int=1 To ent.CountCollisions()
				If CollisionEntity(i)=Self Then Return ent		
			Next
		Next

		Return Null

	End Method
	
	Method CountCollisions:Int()
	
		Return no_collisions
	
	End Method
	
	Method CollisionX#(index:Int)
	
		If index>0 And index<=no_collisions
		
			Return collision[index-1].x#
		
		EndIf
	
	End Method
	
	Method CollisionY#(index:Int)
	
		If index>0 And index<=no_collisions
		
			Return collision[index-1].y#
		
		EndIf
	
	End Method
	
	Method CollisionZ#(index:Int)
	
		If index>0 And index<=no_collisions
		
			Return collision[index-1].z#
		
		EndIf
	
	End Method

	Method CollisionNX#(index:Int)
	
		If index>0 And index<=no_collisions
		
			Return collision[index-1].nx#
		
		EndIf
	
	End Method
	
	Method CollisionNY#(index:Int)
	
		If index>0 And index<=no_collisions
		
			Return collision[index-1].ny#
		
		EndIf
	
	End Method
	
	Method CollisionNZ#(index:Int)
	
		If index>0 And index<=no_collisions
		
			Return collision[index-1].nz#
		
		EndIf
	
	End Method
	
	Method CollisionTime#(index:Int)
	
		If index>0 And index<=no_collisions
		
			Return collision[index-1].time#
		
		EndIf
	
	End Method
	
	Method CollisionEntity:TEntity(index:Int)
	
		If index>0 And index<=no_collisions
		
			Return collision[index-1].ent
		
		EndIf
	
	End Method
	
	Method CollisionSurface:TSurface(index:Int)
	
		If index>0 And index<=no_collisions

			Return collision[index-1].surf
		
		EndIf
	
	End Method
	
	Method CollisionTriangle:Int(index:Int)
	
		If index>0 And index<=no_collisions
		
			Return collision[index-1].tri
		
		EndIf
	
	End Method
	
	Method GetEntityType:Int()

		Return collision_type

	End Method
	
	' Sets an entity's mesh cull radius
	Method MeshCullRadius(radius#)
	
		' set to negative no. so we know when user has set cull radius (manual cull)
		' a check in TMesh.GetBounds then prevents negative no. being overwritten by a positive cull radius (auto cull)
		cull_radius#=-radius#
	
	End Method
	
	Method EntityScaleX#(glob:Int=False)
	
		If glob=True

			If parent<>Null
				
				Local ent:TEntity=Self
					
				Local x#=sx#
							
				Repeat
	
					x#=x#*ent.parent.sx#

					ent=ent.parent
										
				Until ent.parent=Null
				
				Return x#
		
			EndIf

		EndIf
		
		Return sx#
		
	End Method
	
	Method EntityScaleY#(glob:Int=False)
	
		If glob=True

			If parent<>Null
				
				Local ent:TEntity=Self
					
				Local y#=sy#
							
				Repeat
	
					y#=y#*ent.parent.sy#

					ent=ent.parent
										
				Until ent.parent=Null
				
				Return y#
		
			EndIf

		EndIf
		
		Return sy#
		
	End Method
	
	Method EntityScaleZ#(glob:Int=False)
	
		If glob=True

			If parent<>Null
				
				Local ent:TEntity=Self
					
				Local z#=sz#
							
				Repeat
	
					z#=z#*ent.parent.sz#

					ent=ent.parent
										
				Until ent.parent=Null
				
				Return z#
		
			EndIf

		EndIf
		
		Return sz#
		
	End Method

	' Returns an entity's bounding sphere
	Rem
	Method BoundingSphere:TSphere()
	
		Local x#=EntityX(True)
		Local y#=EntityY(True)
		Local z#=EntityZ(True)

		Local radius#=Abs(cull_radius#) ' use absolute value as cull_radius will be negative value if set by MeshCullRadius (manual cull)

		' if entity is mesh, we need to use mesh centre for culling which may be different from entity position
		If TMesh(Self)
		
			' mesh centre
			x=TMesh(Self).min_x
			y=TMesh(Self).min_y
			z=TMesh(Self).min_z
			x=x+(TMesh(Self).max_x-TMesh(Self).min_x)/2.0
			y=y+(TMesh(Self).max_y-TMesh(Self).min_y)/2.0
			z=z+(TMesh(Self).max_z-TMesh(Self).min_z)/2.0
			
			' transform mesh centre into world space
			TFormPoint x,y,z,Self,Null
			x=TFormedX()
			y=TFormedY()
			z=TFormedZ()
			
			' radius - apply entity scale
			Local rx#=radius*EntityScaleX(True)
			Local ry#=radius*EntityScaleY(True)
			Local rz#=radius*EntityScaleZ(True)
			If rx>=ry And rx>=rz
				radius=Abs(rx)
			Else If ry>=rx And ry>=rz
				radius=Abs(ry)
			Else
				radius=Abs(rz)
			EndIf
		
		EndIf

		Local s:TSphere=New TSphere
		s.c.x=x
		s.c.y=y
		s.c.z=z
		s.r=radius
		
		Return s

	End Method
	End Rem

	' Returns an entity's bounding sphere
	Method BoundingSphereNew(sx# Var,sy# Var,sz# Var,sr# Var)

		Local x#=EntityX(True)
		Local y#=EntityY(True)
		Local z#=EntityZ(True)

		Local radius#=Abs(cull_radius#) ' use absolute value as cull_radius will be negative value if set by MeshCullRadius (manual cull)

		' if entity is mesh, we need to use mesh centre for culling which may be different from entity position
		If TMesh(Self)
		
			' mesh centre
			x=TMesh(Self).min_x
			y=TMesh(Self).min_y
			z=TMesh(Self).min_z
			x=x+(TMesh(Self).max_x-TMesh(Self).min_x)/2.0
			y=y+(TMesh(Self).max_y-TMesh(Self).min_y)/2.0
			z=z+(TMesh(Self).max_z-TMesh(Self).min_z)/2.0
			
			' transform mesh centre into world space
			TFormPoint x,y,z,Self,Null
			x=tformed_x
			y=tformed_y
			z=tformed_z
			
			' radius - apply entity scale
			Local rx#=radius*EntityScaleX(True)
			Local ry#=radius*EntityScaleY(True)
			Local rz#=radius*EntityScaleZ(True)
			If rx>=ry And rx>=rz
				radius=Abs(rx)
			Else If ry>=rx And ry>=rz
				radius=Abs(ry)
			Else
				radius=Abs(rz)
			EndIf
		
		EndIf

		sx=x
		sy=y
		sz=z
		sr=radius

	End Method
	
	Function CountAllChildren:int(ent:TEntity,no_children:Int=0)
		
		Local ent2:TEntity
	
		For ent2=EachIn ent.child_list

			no_children=no_children+1
			
			no_children=TEntity.CountAllChildren(ent2,no_children)

		Next

		Return no_children

	End Function
	
	Method GetChildFromAll:TEntity(child_no:Int,no_children:Int Var,ent:TEntity=Null)

		If ent=Null Then ent=Self
		
		Local ent3:TEntity=Null
		
		For Local ent2:TEntity=EachIn ent.child_list

			no_children=no_children+1
			
			If no_children=child_no Then Return ent2
			
			If ent3=Null
			
				ent3=GetChildFromAll(child_no,no_children,ent2)

			EndIf

		Next

		Return ent3
			
	End Method
	
	' Internal - not recommended for general use

	Method UpdateMat(load_identity:Int=False)

		If load_identity=True
			mat.LoadIdentity()
			mat.Translate(px,py,pz)
			mat.Rotate(rx,ry,rz)
			mat.Scale(sx,sy,sz)
		Else
			mat.Translate(px,py,pz)
			mat.Rotate(rx,ry,rz)
			mat.Scale(sx,sy,sz)
		EndIf
	
	End Method
	
	Method AddParent(parent_ent:TEntity)
	
		' self.parent = parent_ent
		parent:TEntity=parent_ent
		
		' add self to parent_ent child list
		If parent<>Null

			mat.Overwrite(parent.mat)
		
			ListAddLast(parent.child_list,Self)
		
		EndIf
		
	End Method
	
	Function UpdateChildren(ent_p:TEntity)
	
		For Local ent_c:TEntity=EachIn ent_p.child_list

			ent_c.mat.Overwrite(ent_p.mat)
			ent_c.UpdateMat()
				
			UpdateChildren(ent_c:TEntity)
			
		Next
	
	End Function

	' unoptimised, unused
	Method EntityDistanceSquared0#(ent2:TEntity)

		Local xd# = ent2.EntityX#(True)-EntityX#(True)
		Local yd# = ent2.EntityY#(True)-EntityY#(True)
		Local zd# = ent2.EntityZ#(True)-EntityZ#(True)
				
		Return xd*xd + yd*yd + zd*zd
		
	End Method
	
	' optimised
	Method EntityDistanceSquared#(ent2:TEntity)

		Local xd# = ent2.mat.grid[3,0]-mat.grid[3,0]
		Local yd# = ent2.mat.grid[3,1]-mat.grid[3,1]
		Local zd# = -ent2.mat.grid[3,2]+mat.grid[3,2]
				
		Return xd*xd + yd*yd + zd*zd
		
	End Method

	Method EntityListAdd(list:TList)
	
		' if order>0, drawn first
		' if order<0, drawn last
	
		Local llink:TLink=list._head ' get start/end link (llink = local link, so as not to clash with entity's link var)
	
		If order>0

			' --- add first ---
		
			' add entity to start of list
			' entites with order>0 should be added to the start of the list
		
			' cycle fowards through list until we've passed all entities with order>0, or if entity itself has order>0,
			' it's own position within entities with order>0
			Repeat
				llink=llink._succ
			Until llink=list._head Or TEntity(llink.Value()).order<=order Or TEntity(llink.Value()).order<=0
	
			link=list.InsertBeforeLink(Self,llink)
			Return
	
		Else ' put entities with order=0 at back of list, so cameras with order=0 are sorted the same as in B3D

			' --- add last ---
	
			' add entity to end of list
			' only entites with order<=0 should be added to the end of the list
		
			' cycle backwards through list until we've passed all entities with order<0, or if entity itself has order<0,
			' it's own position within entities with order<0
			Repeat
				llink=llink._pred
			Until llink=list._head Or TEntity(llink.Value()).order>=order Or TEntity(llink.Value()).order>=0
	
			link=list.InsertAfterLink(Self,llink)
			Return

		EndIf

	End Method
	
End Type