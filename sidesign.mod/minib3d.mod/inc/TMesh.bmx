Type TMesh Extends TEntity
	
	Field min_x#,min_y#,min_z#,max_x#,max_y#,max_z#

	Field no_surfs:Int=0
	Field surf_list:TList=CreateList()
	Field anim_surf_list:TList=CreateList() ' only used if mesh contains anim info, only contains vertex coords array, initialised upon loading b3d
	
	Field no_bones:Int=0
	Field bones:TBone[]
	
	Field mat_sp:TMatrix=New TMatrix ' mat_sp used in TMesh's Update to provide necessary additional transform matrix for sprites
		
	Field col_tree:TColTree=New TColTree

	' reset flags - these are set when mesh shape is changed by various commands in TMesh
	Field reset_bounds:Int=True
	'Field reset_col_tree=True

	Method New()
	
		If LOG_NEW
			DebugLog "New TMesh"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TMesh"
		EndIf
	
	End Method
	
	Method CopyEntity:TMesh(parent_ent:TEntity=Null)

		' new mesh
		Local mesh:TMesh=New TMesh
		
		' copy contents of child list before adding parent
		For Local ent:TEntity=EachIn child_list
			ent.CopyEntity(mesh)
		Next
		
		' lists
			
		' add parent, add to list
		mesh.AddParent(parent_ent:TEntity)
		mesh.EntityListAdd(entity_list)
		
		' add to collision entity list
		If collision_type<>0
			TCollisionPair.ent_lists[collision_type].AddLast(mesh)
		EndIf
		
		' add to pick entity list
		If pick_mode<>0
			TPick.ent_list.AddLast(mesh)
		EndIf
		
		' update matrix
		If mesh.parent<>Null
			mesh.mat.Overwrite(mesh.parent.mat)
		Else
			mesh.mat.LoadIdentity()
		EndIf
		
		' copy entity info
				
		mesh.mat.Multiply(mat)
		
		mesh.px#=px#
		mesh.py#=py#
		mesh.pz#=pz#
		mesh.sx#=sx#
		mesh.sy#=sy#
		mesh.sz#=sz#
		mesh.rx#=rx#
		mesh.ry#=ry#
		mesh.rz#=rz#
		mesh.qw#=qw#
		mesh.qx#=qx#
		mesh.qy#=qy#
		mesh.qz#=qz#
		
		mesh.name$=name$
		mesh.class$=class$
		mesh.order=order
		mesh.hide=False
		mesh.auto_fade=auto_fade
		mesh.fade_near#=fade_near
		mesh.fade_far#=fade_far
		
		mesh.brush=Null
		mesh.brush=brush.Copy()
		
		mesh.anim=anim
		mesh.anim_render=anim_render
		mesh.anim_mode=anim_mode
		mesh.anim_time#=anim_time#
		mesh.anim_speed#=anim_speed#
		mesh.anim_seq=anim_seq
		mesh.anim_trans=anim_trans
		mesh.anim_dir=anim_dir
		mesh.anim_seqs_first=anim_seqs_first[..]
		mesh.anim_seqs_last=anim_seqs_last[..]
		mesh.no_seqs=no_seqs
		mesh.anim_update=anim_update
	
		mesh.cull_radius#=cull_radius#
		mesh.radius_x#=radius_x#
		mesh.radius_y#=radius_y#
		mesh.box_x#=box_x#
		mesh.box_y#=box_y#
		mesh.box_z#=box_z#
		mesh.box_w#=box_w#
		mesh.box_h#=box_h#
		mesh.box_d#=box_d#
		mesh.collision_type=collision_type
		mesh.pick_mode=pick_mode
		mesh.obscurer=obscurer
	
		' copy mesh info
		
		mesh.min_x#=min_x#
		mesh.min_y#=min_y#
		mesh.min_z#=min_z#
		mesh.max_x#=max_x#
		mesh.max_y#=max_y#
		mesh.max_z#=max_z#
		
		mesh.no_surfs=no_surfs
		
		' pointer to surf list
		mesh.surf_list=surf_list
		
		' copy anim surf list
		For Local surf:TSurface=EachIn anim_surf_list
		
			Local new_surf:TSurface=New TSurface
			ListAddLast(mesh.anim_surf_list,new_surf)
			
			new_surf.no_verts=surf.no_verts
			
			' copy array
			new_surf.vert_coords#=surf.vert_coords#[..]

			' pointers to arrays
			new_surf.vert_bone1_no=surf.vert_bone1_no
			new_surf.vert_bone2_no=surf.vert_bone2_no
			new_surf.vert_bone3_no=surf.vert_bone3_no
			new_surf.vert_bone4_no=surf.vert_bone4_no
			new_surf.vert_weight1=surf.vert_weight1
			new_surf.vert_weight2=surf.vert_weight2
			new_surf.vert_weight3=surf.vert_weight3
			new_surf.vert_weight4=surf.vert_weight4
			
			new_surf.vert_array_size=surf.vert_array_size
			new_surf.tri_array_size=surf.tri_array_size
			new_surf.vmin=surf.vmin
			new_surf.vmax=surf.vmax
			
			new_surf.reset_vbo=-1 ' (-1 = all)
			
		Next
		
		mesh.col_tree=col_tree
	
		mesh.reset_bounds=reset_bounds

		Local no_bones:Int=0
		CopyBonesList(mesh,mesh.bones,no_bones)

		Return mesh

	End Method
	
	Method FreeEntity()
	
		Super.FreeEntity() 
		
		'ClearList surf_list
		ClearList anim_surf_list
		bones=bones[..0]
		
	End Method
	
	Function CreateMesh:TMesh(parent_ent:TEntity=Null)

		Local mesh:TMesh=New TMesh

		mesh.class$="Mesh"
	
		mesh.AddParent(parent_ent:TEntity)
		mesh.EntityListAdd(entity_list)

		' update matrix
		If mesh.parent<>Null
			mesh.mat.Overwrite(mesh.parent.mat)
			mesh.UpdateMat()
		Else
			mesh.UpdateMat(True)
		EndIf
	
		Return mesh

	End Function
	
	Function LoadMesh:TMesh(file$,parent_ent:TEntity=Null)
	
		Local ent:TEntity=LoadAnimMesh(file$)
		ent.HideEntity()
		Local mesh:TMesh=TMesh(ent).CollapseAnimMesh()
		ent.FreeEntity()
		
		mesh.class$="Mesh"

		mesh.AddParent(parent_ent:TEntity)
		mesh.EntityListAdd(entity_list)

		' update matrix
		If mesh.parent<>Null
			mesh.mat.Overwrite(mesh.parent.mat)
			mesh.UpdateMat()
		Else
			mesh.UpdateMat(True)
		EndIf
		
		Return mesh
	
	End Function
	
	Function LoadAnimMesh:TMesh(file$,parent_ent:TEntity=Null)
		
		If Right$(file$,4)=".3ds" Then file$=Replace$(file$,".3ds",".b3d")
		
		If FileType(file$)=0 Then Return TMesh.CreateCube()
		
		Return TModel.LoadAnimB3D:TMesh(file$,parent_ent)

	End Function

	Function CreateCube:TMesh(parent_ent:TEntity=Null)
	
		Local mesh:TMesh=TMesh.CreateMesh(parent_ent)
	
		Local surf:TSurface=mesh.CreateSurface()
			
		surf.AddVertex(-1.0,-1.0,-1.0)
		surf.AddVertex(-1.0, 1.0,-1.0)
		surf.AddVertex( 1.0, 1.0,-1.0)
		surf.AddVertex( 1.0,-1.0,-1.0)
		
		surf.AddVertex(-1.0,-1.0, 1.0)
		surf.AddVertex(-1.0, 1.0, 1.0)
		surf.AddVertex( 1.0, 1.0, 1.0)
		surf.AddVertex( 1.0,-1.0, 1.0)
			
		surf.AddVertex(-1.0,-1.0, 1.0)
		surf.AddVertex(-1.0, 1.0, 1.0)
		surf.AddVertex( 1.0, 1.0, 1.0)
		surf.AddVertex( 1.0,-1.0, 1.0)
		
		surf.AddVertex(-1.0,-1.0,-1.0)
		surf.AddVertex(-1.0, 1.0,-1.0)
		surf.AddVertex( 1.0, 1.0,-1.0)
		surf.AddVertex( 1.0,-1.0,-1.0)

		surf.AddVertex(-1.0,-1.0, 1.0)
		surf.AddVertex(-1.0, 1.0, 1.0)
		surf.AddVertex( 1.0, 1.0, 1.0)
		surf.AddVertex( 1.0,-1.0, 1.0)
		
		surf.AddVertex(-1.0,-1.0,-1.0)
		surf.AddVertex(-1.0, 1.0,-1.0)
		surf.AddVertex( 1.0, 1.0,-1.0)
		surf.AddVertex( 1.0,-1.0,-1.0)

		surf.VertexNormal(0,0.0,0.0,-1.0)
		surf.VertexNormal(1,0.0,0.0,-1.0)
		surf.VertexNormal(2,0.0,0.0,-1.0)
		surf.VertexNormal(3,0.0,0.0,-1.0)
	
		surf.VertexNormal(4,0.0,0.0,1.0)
		surf.VertexNormal(5,0.0,0.0,1.0)
		surf.VertexNormal(6,0.0,0.0,1.0)
		surf.VertexNormal(7,0.0,0.0,1.0)
		
		surf.VertexNormal(8,0.0,-1.0,0.0)
		surf.VertexNormal(9,0.0,1.0,0.0)
		surf.VertexNormal(10,0.0,1.0,0.0)
		surf.VertexNormal(11,0.0,-1.0,0.0)
				
		surf.VertexNormal(12,0.0,-1.0,0.0)
		surf.VertexNormal(13,0.0,1.0,0.0)
		surf.VertexNormal(14,0.0,1.0,0.0)
		surf.VertexNormal(15,0.0,-1.0,0.0)
	
		surf.VertexNormal(16,-1.0,0.0,0.0)
		surf.VertexNormal(17,-1.0,0.0,0.0)
		surf.VertexNormal(18,1.0,0.0,0.0)
		surf.VertexNormal(19,1.0,0.0,0.0)
				
		surf.VertexNormal(20,-1.0,0.0,0.0)
		surf.VertexNormal(21,-1.0,0.0,0.0)
		surf.VertexNormal(22,1.0,0.0,0.0)
		surf.VertexNormal(23,1.0,0.0,0.0)

		surf.VertexTexCoords(0,0.0,1.0)
		surf.VertexTexCoords(1,0.0,0.0)
		surf.VertexTexCoords(2,1.0,0.0)
		surf.VertexTexCoords(3,1.0,1.0)
		
		surf.VertexTexCoords(4,1.0,1.0)
		surf.VertexTexCoords(5,1.0,0.0)
		surf.VertexTexCoords(6,0.0,0.0)
		surf.VertexTexCoords(7,0.0,1.0)
		
		surf.VertexTexCoords(8,0.0,1.0)
		surf.VertexTexCoords(9,0.0,0.0)
		surf.VertexTexCoords(10,1.0,0.0)
		surf.VertexTexCoords(11,1.0,1.0)
			
		surf.VertexTexCoords(12,0.0,0.0)
		surf.VertexTexCoords(13,0.0,1.0)
		surf.VertexTexCoords(14,1.0,1.0)
		surf.VertexTexCoords(15,1.0,0.0)
	
		surf.VertexTexCoords(16,0.0,1.0)
		surf.VertexTexCoords(17,0.0,0.0)
		surf.VertexTexCoords(18,1.0,0.0)
		surf.VertexTexCoords(19,1.0,1.0)
				
		surf.VertexTexCoords(20,1.0,1.0)
		surf.VertexTexCoords(21,1.0,0.0)
		surf.VertexTexCoords(22,0.0,0.0)
		surf.VertexTexCoords(23,0.0,1.0)

		surf.VertexTexCoords(0,0.0,1.0,0.0,1)
		surf.VertexTexCoords(1,0.0,0.0,0.0,1)
		surf.VertexTexCoords(2,1.0,0.0,0.0,1)
		surf.VertexTexCoords(3,1.0,1.0,0.0,1)
		
		surf.VertexTexCoords(4,1.0,1.0,0.0,1)
		surf.VertexTexCoords(5,1.0,0.0,0.0,1)
		surf.VertexTexCoords(6,0.0,0.0,0.0,1)
		surf.VertexTexCoords(7,0.0,1.0,0.0,1)
		
		surf.VertexTexCoords(8,0.0,1.0,0.0,1)
		surf.VertexTexCoords(9,0.0,0.0,0.0,1)
		surf.VertexTexCoords(10,1.0,0.0,0.0,1)
		surf.VertexTexCoords(11,1.0,1.0,0.0,1)
			
		surf.VertexTexCoords(12,0.0,0.0,0.0,1)
		surf.VertexTexCoords(13,0.0,1.0,0.0,1)
		surf.VertexTexCoords(14,1.0,1.0,0.0,1)
		surf.VertexTexCoords(15,1.0,0.0,0.0,1)
	
		surf.VertexTexCoords(16,0.0,1.0,0.0,1)
		surf.VertexTexCoords(17,0.0,0.0,0.0,1)
		surf.VertexTexCoords(18,1.0,0.0,0.0,1)
		surf.VertexTexCoords(19,1.0,1.0,0.0,1)
				
		surf.VertexTexCoords(20,1.0,1.0,0.0,1)
		surf.VertexTexCoords(21,1.0,0.0,0.0,1)
		surf.VertexTexCoords(22,0.0,0.0,0.0,1)
		surf.VertexTexCoords(23,0.0,1.0,0.0,1)
				
		surf.AddTriangle(0,1,2) ' front
		surf.AddTriangle(0,2,3)
		surf.AddTriangle(6,5,4) ' back
		surf.AddTriangle(7,6,4)
		surf.AddTriangle(6+8,5+8,1+8) ' top
		surf.AddTriangle(2+8,6+8,1+8)
		surf.AddTriangle(0+8,4+8,7+8) ' bottom
		surf.AddTriangle(0+8,7+8,3+8)
		surf.AddTriangle(6+16,2+16,3+16) ' right
		surf.AddTriangle(7+16,6+16,3+16)
		surf.AddTriangle(0+16,1+16,5+16) ' left
		surf.AddTriangle(0+16,5+16,4+16)

		Return mesh
	
	End Function
	
	' Function by Coyote
	Function CreateSphere:TMesh(segments:Int=8,parent_ent:TEntity=Null)

		If segments<2 Or segments>100 Then Return Null
		
		Local thissphere:TMesh=TMesh.CreateMesh(parent_ent)
		Local thissurf:TSurface=thissphere.CreateSurface()

		Local div#=Float(360.0/(segments*2))
		Local height#=1.0
		Local upos#=1.0
		Local udiv#=Float(1.0/(segments*2))
		Local vdiv#=Float(1.0/segments)
		Local RotAngle#=90	
	
		If segments=2 ' diamond shape - no center strips
		
			For Local i:Int=1 To (segments*2)
				Local np:Int=thissurf.AddVertex(0.0,height,0.0,upos#-(udiv#/2.0),0)'northpole
				Local sp:Int=thissurf.AddVertex(0.0,-height,0.0,upos#-(udiv#/2.0),1)'southpole
				Local XPos#=-Cos(RotAngle#)
				Local ZPos#=Sin(RotAngle#)
				Local v0:Int=thissurf.AddVertex(XPos#,0,ZPos#,upos#,0.5)
				RotAngle#=RotAngle#+div#
				If RotAngle#>=360.0 Then RotAngle#=RotAngle#-360.0
				XPos#=-Cos(RotAngle#)
				ZPos#=Sin(RotAngle#)
				upos#=upos#-udiv#
				Local v1:Int=thissurf.AddVertex(XPos#,0,ZPos#,upos#,0.5)
				thissurf.AddTriangle(np,v0,v1)
				thissurf.AddTriangle(v1,v0,sp)	
			Next
			
		Else ' have center strips now
		
			' poles first
			For Local i:Int=1 To (segments*2)
			
				Local np:Int=thissurf.AddVertex(0.0,height,0.0,upos#-(udiv#/2.0),0)'northpole
				Local sp:Int=thissurf.AddVertex(0.0,-height,0.0,upos#-(udiv#/2.0),1)'southpole
				
				Local YPos#=Cos(div#)
				
				Local XPos#=-Cos(RotAngle#)*(Sin(div#))
				Local ZPos#=Sin(RotAngle#)*(Sin(div#))
				
				Local v0t:Int=thissurf.AddVertex(XPos#,YPos#,ZPos#,upos#,vdiv#)
				Local v0b:Int=thissurf.AddVertex(XPos#,-YPos#,ZPos#,upos#,1-vdiv#)
				
				RotAngle#=RotAngle#+div#
				
				XPos#=-Cos(RotAngle#)*(Sin(div#))
				ZPos#=Sin(RotAngle#)*(Sin(div#))
				
				upos#=upos#-udiv#
	
				Local v1t:Int=thissurf.AddVertex(XPos#,YPos#,ZPos#,upos#,vdiv#)
				Local v1b:Int=thissurf.AddVertex(XPos#,-YPos#,ZPos#,upos#,1-vdiv#)
				
				thissurf.AddTriangle(np,v0t,v1t)
				thissurf.AddTriangle(v1b,v0b,sp)	
				
			Next
			
			' then center strips
	
			upos#=1.0
			RotAngle#=90
			For Local i:Int=1 To (segments*2)
			
				Local mult#=1
				Local YPos#=Cos(div#*(mult#))
				Local YPos2#=Cos(div#*(mult#+1.0))
				Local Thisvdiv#=vdiv#
				For Local j:Int=1 To (segments-2)
	
					
					Local XPos#=-Cos(RotAngle#)*(Sin(div#*(mult#)))
					Local ZPos#=Sin(RotAngle#)*(Sin(div#*(mult#)))
	
					Local XPos2#=-Cos(RotAngle#)*(Sin(div#*(mult#+1.0)))
					Local ZPos2#=Sin(RotAngle#)*(Sin(div#*(mult#+1.0)))
								
					Local v0t:Int=thissurf.AddVertex(XPos#,YPos#,ZPos#,upos#,Thisvdiv#)
					Local v0b:Int=thissurf.AddVertex(XPos2#,YPos2#,ZPos2#,upos#,Thisvdiv#+vdiv#)
				
					' 2nd tex coord set
					thissurf.VertexTexCoords(v0t,upos#,Thisvdiv#,0.0,1)
					thissurf.VertexTexCoords(v0b,upos#,Thisvdiv#+vdiv#,0.0,1)
				
					Local tempRotAngle#=RotAngle#+div#
				
					XPos#=-Cos(tempRotAngle#)*(Sin(div#*(mult#)))
					ZPos#=Sin(tempRotAngle#)*(Sin(div#*(mult#)))
					
					XPos2#=-Cos(tempRotAngle#)*(Sin(div#*(mult#+1.0)))
					ZPos2#=Sin(tempRotAngle#)*(Sin(div#*(mult#+1.0)))				
				
					Local temp_upos#=upos#-udiv#
	
					Local v1t:Int=thissurf.AddVertex(XPos#,YPos#,ZPos#,temp_upos#,Thisvdiv#)
					Local v1b:Int=thissurf.AddVertex(XPos2#,YPos2#,ZPos2#,temp_upos#,Thisvdiv#+vdiv#)
					
					' 2nd tex coord set
					thissurf.VertexTexCoords(v1t,temp_upos#,Thisvdiv#,0.0,1)
					thissurf.VertexTexCoords(v1b,temp_upos#,Thisvdiv#+vdiv#,0.0,1)
					
					thissurf.AddTriangle(v1t,v0t,v0b)
					thissurf.AddTriangle(v1b,v1t,v0b)
					
					Thisvdiv#=Thisvdiv#+vdiv#			
					mult#=mult#+1
					YPos#=Cos(div#*(mult#))
					YPos2#=Cos(div#*(mult#+1.0))
				
				Next
				upos#=upos#-udiv#
				RotAngle#=RotAngle#+div#
			Next
	
		EndIf
	
		thissphere.UpdateNormals() 
		Return thissphere 

	End Function

	' Function by Coyote
	Function CreateCylinder:TMesh(verticalsegments:Int=8,solid:Int=True,parent_ent:TEntity=Null)
	
		Local ringsegments:Int=0 ' default?
	
		Local tr:Int,tl:Int,br:Int,bl:Int' 		side of cylinder
		Local ts0:Int,ts1:Int,newts:Int' 	top side vertexs
		Local bs0:Int,bs1:Int,newbs:Int' 	bottom side vertexs
		If verticalsegments<3 Or verticalsegments>100 Then Return Null
		If ringsegments<0 Or ringsegments>100 Then Return Null
		
		Local thiscylinder:TMesh=TMesh.CreateMesh(parent_ent)
		Local thissurf:TSurface=thiscylinder.CreateSurface()
		Local thissidesurf:TSurface
		If solid=True
			thissidesurf=thiscylinder.CreateSurface()
		EndIf
		Local div#=Float(360.0/(verticalsegments))
	
		Local height#=1.0
		Local ringSegmentHeight#=(height#*2.0)/(ringsegments+1)
		Local upos#=1.0
		Local udiv#=Float(1.0/(verticalsegments))
		Local vpos#=1.0
		Local vdiv#=Float(1.0/(ringsegments+1))
	
		Local SideRotAngle#=90
	
		' re-diminsion arrays to hold needed memory.
		' this is used just for helping to build the ring segments...
		Local tRing:Int[verticalsegments+1]
		Local bRing:Int[verticalsegments+1]
		
		' render end caps if solid
		If solid=True
			Local XPos#=-Cos(SideRotAngle#)
			Local ZPos#=Sin(SideRotAngle#)
	
			ts0=thissidesurf.AddVertex(XPos#,height,ZPos#,XPos#/2.0+0.5,ZPos#/2.0+0.5)
			bs0=thissidesurf.AddVertex(XPos#,-height,ZPos#,XPos#/2.0+0.5,ZPos#/2.0+0.5)
			
			' 2nd tex coord set
			thissidesurf.VertexTexCoords(ts0,XPos#/2.0+0.5,ZPos#/2.0+0.5,0.0,1)
			thissidesurf.VertexTexCoords(bs0,XPos#/2.0+0.5,ZPos#/2.0+0.5,0.0,1)
	
			SideRotAngle#=SideRotAngle#+div#
	
			XPos#=-Cos(SideRotAngle#)
			ZPos#=Sin(SideRotAngle#)
			
			ts1=thissidesurf.AddVertex(XPos#,height,ZPos#,XPos#/2.0+0.5,ZPos#/2.0+0.5)
			bs1=thissidesurf.AddVertex(XPos#,-height,ZPos#,XPos#/2.0+0.5,ZPos#/2.0+0.5)
		
			' 2nd tex coord set
			thissidesurf.VertexTexCoords(ts1,XPos#/2.0+0.5,ZPos#/2.0+0.5,0.0,1)
			thissidesurf.VertexTexCoords(bs1,XPos#/2.0+0.5,ZPos#/2.0+0.5,0.0,1)
			
			For Local i:Int=1 To (verticalsegments-2)
				SideRotAngle#=SideRotAngle#+div#
	
				XPos#=-Cos(SideRotAngle#)
				ZPos#=Sin(SideRotAngle#)
				
				newts=thissidesurf.AddVertex(XPos#,height,ZPos#,XPos#/2.0+0.5,ZPos#/2.0+0.5)
				newbs=thissidesurf.AddVertex(XPos#,-height,ZPos#,XPos#/2.0+0.5,ZPos#/2.0+0.5)
				
				' 2nd tex coord set
				thissidesurf.VertexTexCoords(newts,XPos#/2.0+0.5,ZPos#/2.0+0.5,0.0,1)
				thissidesurf.VertexTexCoords(newbs,XPos#/2.0+0.5,ZPos#/2.0+0.5,0.0,1)
				
				thissidesurf.AddTriangle(ts0,ts1,newts)
				thissidesurf.AddTriangle(newbs,bs1,bs0)
			
				If i<(verticalsegments-2)
					ts1=newts
					bs1=newbs
				EndIf
			Next
		EndIf
		
		' -----------------------
		' middle part of cylinder
		Local thisHeight#=height#
		
		' top ring first		
		SideRotAngle#=90
		Local XPos#=-Cos(SideRotAngle#)
		Local ZPos#=Sin(SideRotAngle#)
		Local thisUPos#=upos#
		Local thisVPos#=0
		tRing[0]=thissurf.AddVertex(XPos#,thisHeight,ZPos#,thisUPos#,thisVPos#)		
		thissurf.VertexTexCoords(tRing[0],thisUPos#,thisVPos#,0.0,1) ' 2nd tex coord set
		For Local i:Int=0 To (verticalsegments-1)
			SideRotAngle#=SideRotAngle#+div#
			XPos#=-Cos(SideRotAngle#)
			ZPos#=Sin(SideRotAngle#)
			thisUPos#=thisUPos#-udiv#
			tRing[i+1]=thissurf.AddVertex(XPos#,thisHeight,ZPos#,thisUPos#,thisVPos#)
			thissurf.VertexTexCoords(tRing[i+1],thisUPos#,thisVPos#,0.0,1) ' 2nd tex coord set
		Next	
		
		For Local ring:Int=0 To ringsegments
	
			' decrement vertical segment
			Local thisHeight:Int=thisHeight-ringSegmentHeight#
			
			' now bottom ring
			SideRotAngle#=90
			XPos#=-Cos(SideRotAngle#)
			ZPos#=Sin(SideRotAngle#)
			thisUPos#=upos#
			thisVPos#=thisVPos#+vdiv#
			bRing[0]=thissurf.AddVertex(XPos#,thisHeight,ZPos#,thisUPos#,thisVPos#)
			thissurf.VertexTexCoords(bRing[0],thisUPos#,thisVPos#,0.0,1) ' 2nd tex coord set
			For Local i:Int=0 To (verticalsegments-1)
				SideRotAngle#=SideRotAngle#+div#
				XPos#=-Cos(SideRotAngle#)
				ZPos#=Sin(SideRotAngle#)
				thisUPos#=thisUPos#-udiv#
				bRing[i+1]=thissurf.AddVertex(XPos#,thisHeight,ZPos#,thisUPos#,thisVPos#)
				thissurf.VertexTexCoords(bRing[i+1],thisUPos#,thisVPos#,0.0,1) ' 2nd tex coord set
			Next
			
			' Fill in ring segment sides with triangles
			For Local v:Int=1 To (verticalsegments)
				tl=tRing[v]
				tr=tRing[v-1]
				bl=bRing[v]
				br=bRing[v-1]
				
				thissurf.AddTriangle(tl,tr,br)
				thissurf.AddTriangle(bl,tl,br)
			Next
			
			' make bottom ring segmentthe top ring segment for the next loop.
			For Local v:Int=0 To (verticalsegments)
				tRing[v]=bRing[v]
			Next		
		Next
				
		thiscylinder.UpdateNormals()
		Return thiscylinder 
		
	End Function
	
	' Function by Coyote
	Function CreateCone:TMesh(segments:Int=8,solid:Int=True,parent_ent:TEntity=Null)
	
		Local top:Int,br:Int,bl:Int' 		side of cone
		Local bs0:Int,bs1:Int,newbs:Int' 	bottom side vertices
		
		If segments<3 Or segments>100 Then Return Null
		
		Local thiscone:TMesh=TMesh.CreateMesh(parent_ent)
		Local thissurf:TSurface=thiscone.CreateSurface()
		Local thissidesurf:TSurface
		If solid=True
			thissidesurf=thiscone.CreateSurface()
		EndIf
		Local div#=Float(360.0/(segments))
	
		Local height#=1.0
		Local upos#=1.0
		Local udiv#=Float(1.0/(segments))
		Local RotAngle#=90	
	
		' first side
		Local XPos#=-Cos(RotAngle#)
		Local ZPos#=Sin(RotAngle#)
	
		top=thissurf.AddVertex(0.0,height,0.0,upos#-(udiv#/2.0),0)
		br=thissurf.AddVertex(XPos#,-height,ZPos#,upos#,1)
		
		' 2nd tex coord set
		thissurf.VertexTexCoords(top,upos#-(udiv#/2.0),0,0.0,1)
		thissurf.VertexTexCoords(br,upos#,1,0.0,1)
	
		If solid=True Then bs0=thissidesurf.AddVertex(XPos#,-height,ZPos#,XPos#/2.0+0.5,ZPos#/2.0+0.5)
		If solid=True Then thissidesurf.VertexTexCoords(bs0,XPos#/2.0+0.5,ZPos#/2.0+0.5,0.0,1) ' 2nd tex coord set
	
		RotAngle#=RotAngle#+div#
	
		XPos#=-Cos(RotAngle#)
		ZPos#=Sin(RotAngle#)
					
		bl=thissurf.AddVertex(XPos#,-height,ZPos#,upos#-udiv#,1)
		thissurf.VertexTexCoords(bl,upos#-udiv#,1,0.0,1) ' 2nd tex coord set	
	
		If solid=True Then bs1=thissidesurf.AddVertex(XPos#,-height,ZPos#,XPos#/2.0+0.5,ZPos#/2.0+0.5)
		If solid=True Then thissidesurf.VertexTexCoords(bs1,XPos#/2.0+0.5,ZPos#/2.0+0.5,0.0,1) ' 2nd tex coord set
		
		thissurf.AddTriangle(bl,top,br)
	
		' rest of sides
		For Local i:Int=1 To (segments-1)
			br=bl
			upos#=upos#-udiv#
			top=thissurf.AddVertex(0.0,height,0.0,upos#-(udiv#/2.0),0)
			thissurf.VertexTexCoords(top,upos#-(udiv#/2.0),0,0.0,1) ' 2nd tex coord set
		
			RotAngle#=RotAngle#+div#
	
			XPos#=-Cos(RotAngle#)
			ZPos#=Sin(RotAngle#)
			
			bl=thissurf.AddVertex(XPos#,-height,ZPos#,upos#-udiv#,1)
			thissurf.VertexTexCoords(bl,upos#-udiv#,1,0.0,1) ' 2nd tex coord set
	
			If solid=True Then newbs=thissidesurf.AddVertex(XPos#,-height,ZPos#,XPos#/2.0+0.5,ZPos#/2.0+0.5)
			If solid=True Then thissidesurf.VertexTexCoords(newbs,XPos#/2.0+0.5,ZPos#/2.0+0.5,0.0,1) ' 2nd tex coord set
		
			thissurf.AddTriangle(bl,top,br)
			
			If solid=True
				thissidesurf.AddTriangle(newbs,bs1,bs0)
			
				If i<(segments-1)
					bs1=newbs
				EndIf
			EndIf
		Next
		
		thiscone.UpdateNormals()
		Return thiscone
		
	End Function
	
	Method CopyMesh:TMesh(parent_ent:TEntity=Null)
	
		Local mesh:TMesh=TMesh.CreateMesh(parent_ent)
		Self.AddMesh(mesh)
		Return mesh
	
	End Method
	
	Method AddMesh(mesh2:TMesh)

		'Local cs2=mesh2.CountSurfaces()
	
		For Local s1:Int=1 To CountSurfaces()
			
			Local surf1:TSurface=GetSurface(s1)

			' if surface is empty, don't add it
			If surf1.CountVertices()=0 And surf1.CountTriangles()=0 Continue
				
			Local new_surf:Int=True
			
			For Local s2:Int=1 To mesh2.CountSurfaces()	
			'For Local s2=1 To cs2
			
				Local surf2:TSurface=mesh2.GetSurface(s2)
				
				Local no_verts2:Int=surf2.CountVertices()
	
				' if brushes properties are the same, add surf1 verts and tris to surf2
				If TBrush.CompareBrushes(surf1.brush,surf2.brush)=True
				
					' add vertices
				
					For Local v:Int=0 To surf1.CountVertices()-1
		
						Local vx#=surf1.VertexX#(v)
						Local vy#=surf1.VertexY#(v)
						Local vz#=surf1.VertexZ#(v)
						Local vr#=surf1.VertexRed#(v)
						Local vg#=surf1.VertexGreen#(v)
						Local vb#=surf1.VertexBlue#(v)
						Local va#=surf1.VertexAlpha#(v)
						Local vnx#=surf1.VertexNX#(v)
						Local vny#=surf1.VertexNY#(v)
						Local vnz#=surf1.VertexNZ#(v)
						Local vu0#=surf1.VertexU#(v,0)
						Local vv0#=surf1.VertexV#(v,0)
						Local vw0#=surf1.VertexW#(v,0)
						Local vu1#=surf1.VertexU#(v,1)
						Local vv1#=surf1.VertexV#(v,1)
						Local vw1#=surf1.VertexW#(v,1)
						
						Local v2:Int=surf2.AddVertex(vx#,vy#,vz#)
						surf2.VertexColor(v2,vr#,vg#,vb#,va#)
						surf2.VertexNormal(v2,vnx#,vny#,vnz#)
						surf2.VertexTexCoords(v2,vu0#,vv0#,vw0#,0)
						surf2.VertexTexCoords(v2,vu1#,vv1#,vw1#,1)

					Next
		
					' add triangles
				
					For Local t:Int=0 To surf1.CountTriangles()-1
		
						Local v0:Int=surf1.TriangleVertex(t,0)+no_verts2
						Local v1:Int=surf1.TriangleVertex(t,1)+no_verts2
						Local v2:Int=surf1.TriangleVertex(t,2)+no_verts2
						
						surf2.AddTriangle(v0,v1,v2)

					Next
					
					' mesh shape has changed - update reset flags
					surf2.reset_vbo=-1 ' (-1 = all)
	
					new_surf=False
					Exit
			
				EndIf
				
			Next
			
			' add new surface
			
			If new_surf=True
			
				Local surf:TSurface=mesh2.CreateSurface()
				
				' add vertices
			
				For Local v:Int=0 To surf1.CountVertices()-1
	
					Local vx#=surf1.VertexX#(v)
					Local vy#=surf1.VertexY#(v)
					Local vz#=surf1.VertexZ#(v)
					Local vr#=surf1.VertexRed#(v)
					Local vg#=surf1.VertexGreen#(v)
					Local vb#=surf1.VertexBlue#(v)
					Local va#=surf1.VertexAlpha#(v)
					Local vnx#=surf1.VertexNX#(v)
					Local vny#=surf1.VertexNY#(v)
					Local vnz#=surf1.VertexNZ#(v)
					Local vu0#=surf1.VertexU#(v,0)
					Local vv0#=surf1.VertexV#(v,0)
					Local vw0#=surf1.VertexW#(v,0)
					Local vu1#=surf1.VertexU#(v,1)
					Local vv1#=surf1.VertexV#(v,1)
					Local vw1#=surf1.VertexW#(v,1)
									
					Local v2:Int=surf.AddVertex(vx#,vy#,vz#)
					surf.VertexColor(v2,vr#,vg#,vb#,va#)
					surf.VertexNormal(v2,vnx#,vny#,vnz#)
					surf.VertexTexCoords(v2,vu0#,vv0#,vw0#,0)
					surf.VertexTexCoords(v2,vu1#,vv1#,vw1#,1)

				Next
	
				' add triangles
			
				For Local t:Int=0 To surf1.CountTriangles()-1
	
					Local v0:Int=surf1.TriangleVertex(t,0)
					Local v1:Int=surf1.TriangleVertex(t,1)
					Local v2:Int=surf1.TriangleVertex(t,2)
					
					surf.AddTriangle(v0,v1,v2)

				Next
				
				' copy brush
				
				If surf1.brush<>Null
				
					surf.brush=surf1.brush.Copy()
					
				EndIf
				
				' mesh shape has changed - update reset flags
				surf.reset_vbo=-1 ' (-1 = all)
			
			EndIf
							
		Next
		
		' mesh shape has changed - update reset flags
		mesh2.reset_bounds=True
		mesh2.col_tree.reset_col_tree=True
		
	End Method
	
	Method FlipMesh()
	
		For Local surf:TSurface=EachIn surf_list
		
			' flip triangle vertex order
			For Local t:Int=1 To surf.no_tris
			
				Local i0:Int=t*3-3
				Local i1:Int=t*3-2
				Local i2:Int=t*3-1
			
				Local v0:Int=surf.tris[i0]
				Local v1:Int=surf.tris[i1]
				Local v2:Int=surf.tris[i2]
		
				surf.tris[i0]=v2
				'surf.tris[i1]
				surf.tris[i2]=v0
		
			Next
			
			' flip vertex normals
			For Local v:Int=0 To surf.no_verts-1
			
				surf.vert_norm[v*3]=surf.vert_norm[v*3]*-1 ' x
				surf.vert_norm[(v*3)+1]=surf.vert_norm[(v*3)+1]*-1 ' y
				surf.vert_norm[(v*3)+2]=surf.vert_norm[(v*3)+2]*-1 ' z

			Next
			
			' mesh shape has changed - update reset flag
			surf.reset_vbo:|4|16
		
		Next
		
		' mesh shape has changed - update reset flag
		col_tree.reset_col_tree=True
		
	EndMethod
	
	Method PaintMesh(bru:TBrush)

		For Local surf:TSurface=EachIn surf_list

			If surf.brush=Null Then surf.brush=New TBrush
			
			surf.brush.no_texs=bru.no_texs
			surf.brush.name$=bru.name$
			surf.brush.red#=bru.red#
			surf.brush.green#=bru.green#
			surf.brush.blue#=bru.blue#
			surf.brush.alpha#=bru.alpha#
			surf.brush.shine#=bru.shine#
			surf.brush.blend=bru.blend
			surf.brush.fx=bru.fx
			For Local i:Int=0 To 7
				surf.brush.tex[i]=bru.tex[i]
			Next

		Next

	End Method
	
	Method FitMesh(x#,y#,z#,width#,height#,depth#,uniform:Int=False)
	
		' if uniform=true than adjust fitmesh dimensions
		
		If uniform=True
						
			Local wr#=MeshWidth()/width
			Local hr#=MeshHeight()/height
			Local dr#=MeshDepth()/depth
		
			If wr>=hr And wr>=dr
	
				y=y+((height-(MeshHeight()/wr))/2.0)
				z=z+((depth-(MeshDepth()/wr))/2.0)
				
				height=MeshHeight()/wr
				depth=MeshDepth()/wr
			
			Else If hr>dr
			
				x=x+((width-(MeshWidth()/hr))/2.0)
				z=z+((depth-(MeshDepth()/hr))/2.0)
			
				width=MeshWidth()/hr
				depth=MeshDepth()/hr
						
			Else
			
				x=x+((width-(MeshWidth()/dr))/2.0)
				y=y+((height-(MeshHeight()/dr))/2.0)
			
				width=MeshWidth()/dr
				height=MeshHeight()/dr
								
			EndIf

		EndIf
		
		' old to new dimensions ratio, used to update mesh normals
		Local wr#=MeshWidth()/width
		Local hr#=MeshHeight()/height
		Local dr#=MeshDepth()/depth
		
		' find min/max dimensions
	
		Local minx#=9999999999
		Local miny#=9999999999
		Local minz#=9999999999
		Local maxx#=-9999999999
		Local maxy#=-9999999999
		Local maxz#=-9999999999
	
		For Local s:Int=1 To CountSurfaces()
			
			Local surf:TSurface=GetSurface(s)
				
			For Local v:Int=0 To surf.CountVertices()-1
		
				Local vx#=surf.VertexX#(v)
				Local vy#=surf.VertexY#(v)
				Local vz#=surf.VertexZ#(v)
				
				If vx#<minx# Then minx#=vx#
				If vy#<miny# Then miny#=vy#
				If vz#<minz# Then minz#=vz#
				
				If vx#>maxx# Then maxx#=vx#
				If vy#>maxy# Then maxy#=vy#
				If vz#>maxz# Then maxz#=vz#

			Next
							
		Next
		
		For Local s:Int=1 To CountSurfaces()
			
			Local surf:TSurface=GetSurface(s)
				
			For Local v:Int=0 To surf.CountVertices()-1
		
				' update vertex positions
		
				Local vx#=surf.VertexX#(v)
				Local vy#=surf.VertexY#(v)
				Local vz#=surf.VertexZ#(v)
								
				Local mx#=maxx#-minx#
				Local my#=maxy#-miny#
				Local mz#=maxz#-minz#
				
				Local ux#,uy#,uz#
				
				If mx#<0.0001 And mx#>-0.0001 Then ux#=0.0 Else ux#=(vx#-minx#)/mx# ' 0-1
				If my#<0.0001 And my#>-0.0001 Then uy#=0.0 Else uy#=(vy#-miny#)/my# ' 0-1
				If mz#<0.0001 And mz#>-0.0001 Then uz#=0.0 Else uz#=(vz#-minz#)/mz# ' 0-1
										
				vx#=x#+(ux#*width#)
				vy#=y#+(uy#*height#)
				vz#=z#+(uz#*depth#)
				
				surf.VertexCoords(v,vx#,vy#,vz#)
				
				' update normals
				
				Local nx#=surf.VertexNX#(v)
				Local ny#=surf.VertexNY#(v)
				Local nz#=surf.VertexNZ#(v)
				
				nx#=nx#*wr#
				ny#=ny#*hr#
				nz#=nz#*dr#
				
				surf.VertexNormal(v,nx#,ny#,nz#)

			Next
			
			' mesh shape has changed - update reset flag
			surf.reset_vbo:|1|4

		Next
		
		' mesh shape has changed - update reset flags
		reset_bounds=True
		col_tree.reset_col_tree=True
		
	End Method
	
	Method ScaleMesh(sx#,sy#,sz#)
	
		For Local s:Int=1 To no_surfs
	
			Local surf:TSurface=GetSurface(s)
				
			For Local v:Int=0 To surf.no_verts-1
		
				surf.vert_coords[v*3]:*sx#
				surf.vert_coords[v*3+1]:*sy#
				surf.vert_coords[v*3+2]:*sz#

			Next
			
			' mesh shape has changed - update reset flag
			surf.reset_vbo:|1
				
		Next
		
		' mesh shape has changed - update reset flags
		reset_bounds=True
		col_tree.reset_col_tree=True

	End Method
	
	Method RotateMesh(pitch#,yaw#,roll#)
	
		pitch#=-pitch#
		
		Local mat:TMatrix=New TMatrix
		mat.LoadIdentity()
		mat.Rotate(pitch#,yaw#,roll#)

		For Local s:Int=1 To no_surfs
	
			Local surf:TSurface=GetSurface(s)
				
			For Local v:Int=0 To surf.no_verts-1
		
				Local vx#=surf.vert_coords[v*3]
				Local vy#=surf.vert_coords[v*3+1]
				Local vz#=surf.vert_coords[v*3+2]
	
				surf.vert_coords[v*3] = mat.grid#[0,0]*vx# + mat.grid#[1,0]*vy# + mat.grid#[2,0]*vz# + mat.grid#[3,0]
				surf.vert_coords[v*3+1] = mat.grid#[0,1]*vx# + mat.grid#[1,1]*vy# + mat.grid#[2,1]*vz# + mat.grid#[3,1]
				surf.vert_coords[v*3+2] = mat.grid#[0,2]*vx# + mat.grid#[1,2]*vy# + mat.grid#[2,2]*vz# + mat.grid#[3,2]

				Local nx#=surf.vert_norm[v*3]
				Local ny#=surf.vert_norm[v*3+1]
				Local nz#=surf.vert_norm[v*3+2]
	
				surf.vert_norm[v*3] = mat.grid#[0,0]*nx# + mat.grid#[1,0]*ny# + mat.grid#[2,0]*nz# + mat.grid#[3,0]
				surf.vert_norm[v*3+1] = mat.grid#[0,1]*nx# + mat.grid#[1,1]*ny# + mat.grid#[2,1]*nz# + mat.grid#[3,1]
				surf.vert_norm[v*3+2] = mat.grid#[0,2]*nx# + mat.grid#[1,2]*ny# + mat.grid#[2,2]*nz# + mat.grid#[3,2]

			Next
			
			' mesh shape has changed - update reset flag
			surf.reset_vbo:|1|4
							
		Next
		
		' mesh shape has changed - update reset flag
		reset_bounds=True
		col_tree.reset_col_tree=True
				
	End Method
	
	Method PositionMesh(px#,py#,pz#)

		pz#=-pz#
	
		For Local s:Int=1 To no_surfs
	
			Local surf:TSurface=GetSurface(s)
				
			For Local v:Int=0 To surf.no_verts-1
		
				surf.vert_coords[v*3]:+px#
				surf.vert_coords[v*3+1]:+py#
				surf.vert_coords[v*3+2]:+pz#

			Next
			
			' mesh shape has changed - update reset flag
			surf.reset_vbo:|1
						
		Next
		
		' mesh shape has changed - update reset flags
		reset_bounds=True
		col_tree.reset_col_tree=True
		
	End Method

	Method UpdateNormals()

		For Local s:Int=1 To CountSurfaces()

			Local surf:TSurface=GetSurface( s )
			
			'If USE_C
				C_UpdateNormals(surf.no_tris,surf.no_verts,surf.tris,surf.vert_coords,surf.vert_norm)
			'Else
				'surf.UpdateNormals()
			'EndIf
			
			' mesh state has changed - update reset flags
			surf.reset_vbo:|4

		Next
	
	End Method
	
	Method CreateSurface:TSurface(bru:TBrush=Null)
	
		Local surf:TSurface=New TSurface
		ListAddLast surf_list,surf
		
		no_surfs=no_surfs+1
		
		'SMALLFIXES CreateSurface & BrushFX/EntityFX fix from http://www.blitzbasic.com/Community/posts.php?topic=88060
		If bru<>Null
		   surf.brush=bru.Copy()
	           brush = bru.Copy()
		EndIf


		' new mesh surface - update reset flags
		reset_bounds=True
		col_tree.reset_col_tree=True

		Return surf
		
	End Method
	
	Method MeshWidth#()

		GetBounds()

		Return max_x-min_x
		
	End Method
	
	Method MeshHeight#()

		GetBounds()

		Return max_y-min_y
		
	End Method
	
	Method MeshDepth#()

		GetBounds()

		Return max_z-min_z
		
	End Method

	Method CountSurfaces:Int()
	
		Return no_surfs
	
	End Method
	
	Method GetSurface:TSurface(surf_no_get:Int)
	
		Local surf_no:Int=0
	
		For Local surf:TSurface=EachIn surf_list
		
			surf_no=surf_no+1
			
			If surf_no_get=surf_no Then Return surf
		
		Next
	
		Return Null
	
	End Method
	
	Method FindSurface:TSurface(brush:TBrush)
	
		' ***note*** unlike B3D version, this will find a surface with no brush, if a null brush is supplied
	
		For Local surf:TSurface=EachIn surf_list
		
			If TBrush.CompareBrushes(brush,surf.brush)=True
				Return surf
			EndIf
		
		Next
		
		Return Null
	
	End Method
		
	' returns total no. of vertices in mesh
	Method CountVertices:Int()
	
		Local verts:Int=0
	
		For Local s:Int=1 To CountSurfaces()
		
			Local surf:TSurface=GetSurface(s)	
		
			verts=verts+surf.CountVertices()
		
		Next
	
		Return verts
	
	End Method
	
	' returns total no. of triangles in mesh
	Method CountTriangles:Int()
	
		Local tris:Int=0
	
		For Local s:Int=1 To CountSurfaces()
		
			Local surf:TSurface=GetSurface(s)	
		
			tris=tris+surf.CountTriangles()
		
		Next
	
		Return tris
	
	End Method
		
	 ' used by CopyEntity
	Function CopyBonesList(ent:TEntity,bones:TBone[] Var,no_bones:Int Var)

		For Local ent:TEntity=EachIn ent.child_list
			If TBone(ent)<>Null
				no_bones=no_bones+1
				bones=bones[..no_bones]
				bones[no_bones-1]=TBone(ent)
			EndIf
			CopyBonesList(ent,bones,no_bones)
		Next

	End Function
	
	 ' used by LoadMesh
	Method CollapseAnimMesh:TMesh(mesh:TMesh=Null)
	
		If mesh=Null Then mesh=New TMesh
		
		If TMesh(Self)<>Null
			'Local new_mesh:TMesh=New TMesh 'TMesh(ent).CopyMesh() ' don't use copymesh, uses CreateMesh and adds to entity list
			'TMesh(Self).AddMesh(new_mesh)
			'new_mesh.TransformMesh(Self.mat)
			'new_mesh.AddMesh(mesh)
			TransformMesh(Self.mat)
			AddMesh(mesh)
		EndIf
		
		mesh=CollapseChildren(Self,mesh)

		Return mesh

	End Method
	
	' used by LoadMesh
	' has to be function as we need to use this function with all entities and not just meshes
	Function CollapseChildren:TMesh(ent0:TEntity,mesh:TMesh=Null)

		For Local ent:TEntity=EachIn ent0.child_list
			If TMesh(ent)<>Null
				'Local new_mesh:TMesh=New TMesh 'TMesh(ent).CopyMesh() ' don't use copymesh, uses CreateMesh and adds to entity list
				'TMesh(ent).AddMesh(new_mesh)
				'new_mesh.TransformMesh(ent.mat)
				'new_mesh.AddMesh(mesh)
				TMesh(ent).TransformMesh(ent.mat)
				TMesh(ent).AddMesh(mesh)
			EndIf
			mesh=CollapseChildren(ent,mesh)
		Next
		
		Return mesh
		
	End Function

	' used by LoadMesh
	Method TransformMesh(mat:TMatrix)

		For Local s:Int=1 To no_surfs
	
			Local surf:TSurface=GetSurface(s)
				
			For Local v:Int=0 To surf.no_verts-1
		
				Local vx#=surf.vert_coords[v*3]
				Local vy#=surf.vert_coords[v*3+1]
				Local vz#=surf.vert_coords[v*3+2]
	
				surf.vert_coords[v*3] = mat.grid#[0,0]*vx# + mat.grid#[1,0]*vy# + mat.grid#[2,0]*vz# + mat.grid#[3,0]
				surf.vert_coords[v*3+1] = mat.grid#[0,1]*vx# + mat.grid#[1,1]*vy# + mat.grid#[2,1]*vz# + mat.grid#[3,1]
				surf.vert_coords[v*3+2] = mat.grid#[0,2]*vx# + mat.grid#[1,2]*vy# + mat.grid#[2,2]*vz# + mat.grid#[3,2]

				Local nx#=surf.vert_norm[v*3]
				Local ny#=surf.vert_norm[v*3+1]
				Local nz#=surf.vert_norm[v*3+2]
	
				surf.vert_norm[v*3] = mat.grid#[0,0]*nx# + mat.grid#[1,0]*ny# + mat.grid#[2,0]*nz#
				surf.vert_norm[v*3+1] = mat.grid#[0,1]*nx# + mat.grid#[1,1]*ny# + mat.grid#[2,1]*nz#
				surf.vert_norm[v*3+2] = mat.grid#[0,2]*nx# + mat.grid#[1,2]*ny# + mat.grid#[2,2]*nz#

			Next
							
		Next

	End Method
	
	' used by MeshWidth, MeshHeight, MeshDepth, RenderWorld
	Method GetBounds()
	
		' only get new bounds if we have to
		' mesh.reset_bounds=True for all new meshes, plus set to True by various Mesh commands
		If reset_bounds=True
		
			reset_bounds=False
	
			min_x#=999999999
			max_x#=-999999999
			min_y#=999999999
			max_y#=-999999999
			min_z#=999999999
			max_z#=-999999999
			
			For Local surf:TSurface=EachIn surf_list
		
				For Local v:Int=0 Until surf.no_verts
				
					Local x#=surf.vert_coords[v*3] ' surf.VertexX(v)
					If x#<min_x# Then min_x#=x#
					If x#>max_x# Then max_x#=x#
					
					Local y#=surf.vert_coords[(v*3)+1] ' surf.VertexY(v)
					If y#<min_y# Then min_y#=y#
					If y#>max_y# Then max_y#=y#
					
					Local z#=-surf.vert_coords[(v*3)+2] ' surf.VertexZ(v)
					If z#<min_z# Then min_z#=z#
					If z#>max_z# Then max_z#=z#
				
				Next
			
			Next
		
			' get mesh width, height, depth
			Local width#=max_x#-min_x#
			Local height#=max_y#-min_y#
			Local depth#=max_z#-min_z#
			
			' get bounding sphere (cull_radius#) from AABB
			' only get cull radius (auto cull), if cull radius hasn't been set to a negative no. by TEntity.MeshCullRadius (manual cull)
			If cull_radius>=0
				If width>=height And width>=depth
					cull_radius=width#
				Else
					If height>=width And height>=depth
						cull_radius=height
					Else
						cull_radius=depth
					EndIf
				EndIf
				cull_radius=cull_radius/2.0
				Local crs#=cull_radius*cull_radius
				cull_radius=Sqr(crs#+crs#+crs#)
			EndIf

		EndIf

	End Method

	' returns true if mesh is to be drawn with alpha, i.e alpha<1.0.
	' this func is used in MeshListAdd to see whether entity should be manually depth sorted (if alpha=true then yes).
	' alpha_enable true/false is also set for surfaces - this is used to sort alpha surfaces and enable/disable alpha blending 
	' in TMesh.Update.
	Method Alpha:int()
	
		' ***note*** func doesn't taken into account fact that surf brush blend modes override master brush blend mode
		' when rendering. shouldn't be a problem, as will only incorrectly return true if master brush blend is 2 or 3,
		' while surf blend is 1. won't crop up often, and if it does, will only result in blending being enabled when it
		' shouldn't (may cause interference if surf tex is masked?).

		Local alpha:Int=False

		' check master brush (check alpha value, blend value, force vertex alpha flag)
		If brush.alpha#<1.0 Or brush.blend=2 Or brush.blend=3 Or brush.fx&32
			
			alpha=True

		Else
		
			' tex 0 alpha flag
			If brush.tex[0]<>Null
				If brush.tex[0].flags&2<>0
					alpha=True
				EndIf
			EndIf
			
		EndIf

		' check surf brushes
		For Local surf:TSurface=EachIn surf_list
		
			surf.alpha_enable=False
			
			If surf.brush<>Null
			
				If surf.brush.alpha#<1.0 Or surf.brush.blend=2 Or surf.brush.blend=3 Or surf.brush.fx&32
				
					alpha=True
		
				Else
				
					If surf.brush.tex[0]<>Null
						If surf.brush.tex[0].flags&2<>0
							alpha=True
						EndIf
					EndIf
					
				EndIf
			
			EndIf
			
			' entity auto fade
			If fade_alpha#<>0.0
				alpha=True
			EndIf
			
			' set surf alpha_enable flag to true if mesh or surface has alpha properties
			If alpha=True
				surf.alpha_enable=True
			EndIf
			
		Next
		
		Return alpha

	End Method
	
	' used by RenderWorld
	Method Update()
	
		Local name$=Self.EntityName$()
	
		Local fog:Int=False
		If glIsEnabled(GL_FOG)=GL_TRUE Then fog=True ' if fog enabled, we'll enable it again at end of each surf loop in case of fx flag disabling it
	
		glDisable(GL_ALPHA_TEST)
	
		If order<>0
			glDisable(GL_DEPTH_TEST)
			glDepthMask(GL_FALSE)
		Else
			glEnable(GL_DEPTH_TEST)
			glDepthMask(GL_TRUE)
		EndIf
		
		' convert surf lists into arrays, sort by alpha true/false (we need to draw surfaces with alpha last)
		Local surfs:TSurface[]=TSurface[](ListToArray(surf_list))
		surfs.Sort
		Local anim_surfs:TSurface[]=TSurface[](ListToArray(anim_surf_list))
		anim_surfs.Sort

		Local anim_surf:TSurface
		Local anim_surf_no:Int=-1
		
		For Local surf:TSurface=EachIn surfs
		
			anim_surf_no=anim_surf_no+1
	
			Local vbo:Int=False
			If surf.no_tris>=VBO_MIN_TRIS
				If TGlobal.vbo_enabled Then vbo=True
			Else
				' if surf no longer has required no of tris then free vbo
				If surf.vbo_id[0]<>0 
					glDeleteBuffersARB(6,surf.vbo_id)
				EndIf
			EndIf
			
			' update surf vbo if necessary
			If vbo
				
				' update vbo
				If surf.reset_vbo<>False
					surf.UpdateVBO()
				Else If surf.vbo_id[0]=0 ' no vbo - unknown reason
					surf.reset_vbo=-1
					surf.UpdateVBO()
				EndIf
				
			EndIf
	
			If anim
			
				' get anim_surf
				anim_surf=anim_surfs[anim_surf_no]
				
				If vbo
				
					' update vbo
					If anim_surf.reset_vbo<>False
						anim_surf.UpdateVBO()
					Else If anim_surf.vbo_id[0]=0 ' no vbo - unknown reason
						anim_surf.reset_vbo=-1
						anim_surf.UpdateVBO()
					EndIf
				
				EndIf
				
			EndIf
			
			Local red#,green#,blue#,alpha#,shine#,blend:Int,fx:Int
			Local ambient_red#,ambient_green#,ambient_blue#

			' get main brush values
			red#  =brush.red
			green#=brush.green
			blue# =brush.blue
			alpha#=brush.alpha
			shine#=brush.shine
			blend =brush.blend
			fx    =brush.fx
			
			' combine surface brush values with main brush values
			'If surf.brush<>Null

				Local shine2#=0.0

				red#   =red#  *surf.brush.red
				green# =green#*surf.brush.green
				blue#  =blue# *surf.brush.blue
				alpha# =alpha *surf.brush.alpha
				shine2#=surf.brush.shine#
				If shine#=0.0 Then shine#=shine2#
				If shine#<>0.0 And shine2#<>0.0 Then shine#=shine#*shine2#
				If blend=0 Then blend=surf.brush.blend ' overwrite master brush if master brush blend=0
				fx=fx|surf.brush.fx
			
			'EndIf
			
			' take into account auto fade alpha
			alpha#=alpha#-fade_alpha#

			' if surface contains alpha info, enable blending
			If surf.alpha_enable=True
				glEnable(GL_BLEND)
				glDepthMask(GL_FALSE)
			Else
				glDisable(GL_BLEND)
				glDepthMask(GL_TRUE)
			EndIf

			' blend modes
			Select blend
				Case 0
					glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA) ' alpha
				Case 1
					glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA) ' alpha
				Case 2
					glBlendFunc(GL_DST_COLOR,GL_ZERO) ' multiply
				Case 3
					glBlendFunc(GL_SRC_ALPHA,GL_ONE) ' additive and alpha
			End Select
			
			' fx flag 1 - full bright ***todo*** disable all lights?
			If fx&1
				ambient_red#  =1.0
				ambient_green#=1.0
				ambient_blue# =1.0
			Else
				ambient_red#  =TGlobal.ambient_red#
				ambient_green#=TGlobal.ambient_green#
				ambient_blue# =TGlobal.ambient_blue#
			EndIf

			' fx flag 2 - vertex colors ***todo*** disable all lights?
			If fx&2
				glEnable(GL_COLOR_MATERIAL)
			Else
				glDisable(GL_COLOR_MATERIAL)
			EndIf
			
			' fx flag 4 - flatshaded
			If fx&4
				glShadeModel(GL_FLAT)
			Else
				glShadeModel(GL_SMOOTH)
			EndIf

			' fx flag 8 - disable fog
			If fx&8
				glDisable(GL_FOG)
			EndIf
			
			' fx flag 16 - disable backface culling
			If fx&16
				glDisable(GL_CULL_FACE)
			Else
				glEnable(GL_CULL_FACE)
			EndIf
			
			If vbo
			
				If anim_render
					glBindBufferARB(GL_ARRAY_BUFFER_ARB,anim_surf.vbo_id[0])
					glVertexPointer(3,GL_FLOAT,0,Null)
				Else
					glBindBufferARB(GL_ARRAY_BUFFER_ARB,surf.vbo_id[0])
					glVertexPointer(3,GL_FLOAT,0,Null)
				EndIf
							
				glBindBufferARB(GL_ELEMENT_ARRAY_BUFFER_ARB,surf.vbo_id[5])
					
				glBindBufferARB(GL_ARRAY_BUFFER_ARB,surf.vbo_id[3])
				glNormalPointer(GL_FLOAT,0,Null)
				
				glBindBufferARB(GL_ARRAY_BUFFER_ARB,surf.vbo_id[4])
				glColorPointer(4,GL_FLOAT,0,Null)
				
			Else
				If THardwareInfo.VBOSupport 'SMALLFIXES this if statement is a hack to prevent crash when vbo is not supported by GFX
					glBindBufferARB(GL_ARRAY_BUFFER_ARB,0) ' reset - necessary for when non-vbo surf follows vbo surf
					glBindBufferARB(GL_ELEMENT_ARRAY_BUFFER_ARB,0)
				EndIf
				
				If anim_render
					glVertexPointer(3,GL_FLOAT,0,anim_surf.vert_coords#)
				Else
					glVertexPointer(3,GL_FLOAT,0,surf.vert_coords#)
				EndIf
				
				glColorPointer(4,GL_FLOAT,0,surf.vert_col#)
				glNormalPointer(GL_FLOAT,0,surf.vert_norm#)
			
			EndIf
							
			' light + material color
			
			Local ambient#[]=[ambient_red#,ambient_green#,ambient_blue#]	
			glLightModelfv(GL_LIGHT_MODEL_AMBIENT,ambient#)
			
			Local no_mat#[]=[0.0,0.0]
			Local mat_ambient#[]=[red#,green#,blue#,alpha#]
			Local mat_diffuse#[]=[red#,green#,blue#,alpha#]
			Local mat_specular#[]=[shine#,shine#,shine#,shine#]
			Local mat_shininess#[]=[100.0] ' upto 128

			glMaterialfv(GL_FRONT,GL_AMBIENT,mat_ambient)
			glMaterialfv(GL_FRONT,GL_DIFFUSE,mat_diffuse)
			glMaterialfv(GL_FRONT,GL_SPECULAR,mat_specular)
			glMaterialfv(GL_FRONT,GL_SHININESS,mat_shininess)

			' textures
				
			Local tex_count:Int=0
			tex_count=brush.no_texs
			'If surf.brush<>Null
				If surf.brush.no_texs>tex_count Then tex_count=surf.brush.no_texs
			'EndIf

			For Local ix:Int=0 To tex_count-1
	
				If surf.brush.tex[ix]<>Null Or brush.tex[ix]<>Null

					' Main brush texture takes precedent over surface brush texture
					Local texture:TTexture,tex_flags:Int,tex_blend:Int,tex_coords:Int,tex_u_scale#,tex_v_scale#,tex_u_pos#,tex_v_pos#,tex_ang#,tex_cube_mode:Int,frame:Int
					If brush.tex[ix]<>Null
						texture=brush.tex[ix]
						tex_flags=brush.tex[ix].flags
						tex_blend=brush.tex[ix].blend
						tex_coords=brush.tex[ix].coords
						tex_u_scale#=brush.tex[ix].u_scale#
						tex_v_scale#=brush.tex[ix].v_scale#
						tex_u_pos#=brush.tex[ix].u_pos#
						tex_v_pos#=brush.tex[ix].v_pos#
						tex_ang#=brush.tex[ix].angle#
						tex_cube_mode=brush.tex[ix].cube_mode
						frame=brush.tex_frame
					Else
						texture=surf.brush.tex[ix]
						tex_flags=surf.brush.tex[ix].flags
						tex_blend=surf.brush.tex[ix].blend
						tex_coords=surf.brush.tex[ix].coords
						tex_u_scale#=surf.brush.tex[ix].u_scale#
						tex_v_scale#=surf.brush.tex[ix].v_scale#
						tex_u_pos#=surf.brush.tex[ix].u_pos#
						tex_v_pos#=surf.brush.tex[ix].v_pos#
						tex_ang#=surf.brush.tex[ix].angle#
						tex_cube_mode=surf.brush.tex[ix].cube_mode
						frame=surf.brush.tex_frame
					EndIf
					If THardwareInfo.VBOSupport 'SMALLFIXES this if statement is a hack to prevent crash when vbo is not supported by GFX

						glActiveTextureARB(GL_TEXTURE0+ix)
						glClientActiveTextureARB(GL_TEXTURE0+ix)
					EndIf
					glEnable(GL_TEXTURE_2D)
					glBindTexture(GL_TEXTURE_2D,texture.gltex[frame]) ' call before glTexParameteri

					' masked texture flag
					If tex_flags&4<>0
						glEnable(GL_ALPHA_TEST)
					Else
						glDisable(GL_ALPHA_TEST)
					EndIf
				
					' mipmapping texture flag
					If tex_flags&8<>0
						glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
						glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_LINEAR)
					Else
						glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
						glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR)
					EndIf
					
					' clamp u flag
					If tex_flags&16<>0
						glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP_TO_EDGE)
					Else						
						glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_REPEAT)
					EndIf
					
					' clamp v flag
					If tex_flags&32<>0
						glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP_TO_EDGE)
					Else
						glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_REPEAT)
					EndIf
			
					' spherical environment map texture flag
					If tex_flags&64<>0
						glTexGeni(GL_S,GL_TEXTURE_GEN_MODE,GL_SPHERE_MAP)
						glTexGeni(GL_T,GL_TEXTURE_GEN_MODE,GL_SPHERE_MAP)
						glEnable(GL_TEXTURE_GEN_S)
						glEnable(GL_TEXTURE_GEN_T)
					Else
						glDisable(GL_TEXTURE_GEN_S)
						glDisable(GL_TEXTURE_GEN_T)
					EndIf
					
					' cubic environment map texture flag
					If tex_flags&128<>0
		
						glEnable(GL_TEXTURE_CUBE_MAP)
						glBindTexture(GL_TEXTURE_CUBE_MAP,texture.gltex[frame]) ' call before glTexParameteri
						
						glTexParameteri(GL_TEXTURE_CUBE_MAP,GL_TEXTURE_WRAP_S,GL_CLAMP_TO_EDGE)
						glTexParameteri(GL_TEXTURE_CUBE_MAP,GL_TEXTURE_WRAP_T,GL_CLAMP_TO_EDGE)
						glTexParameteri(GL_TEXTURE_CUBE_MAP,GL_TEXTURE_WRAP_R,GL_CLAMP_TO_EDGE)
						glTexParameteri(GL_TEXTURE_CUBE_MAP,GL_TEXTURE_MIN_FILTER,GL_NEAREST)
  						glTexParameteri(GL_TEXTURE_CUBE_MAP,GL_TEXTURE_MAG_FILTER,GL_NEAREST)
						
						glEnable(GL_TEXTURE_GEN_S)
						glEnable(GL_TEXTURE_GEN_T)
						glEnable(GL_TEXTURE_GEN_R)
						'glEnable(GL_TEXTURE_GEN_Q)

						If tex_cube_mode=1
							glTexGeni(GL_S,GL_TEXTURE_GEN_MODE,GL_REFLECTION_MAP)
							glTexGeni(GL_T,GL_TEXTURE_GEN_MODE,GL_REFLECTION_MAP)
							glTexGeni(GL_R,GL_TEXTURE_GEN_MODE,GL_REFLECTION_MAP)
						EndIf
						
						If tex_cube_mode=2
							glTexGeni(GL_S,GL_TEXTURE_GEN_MODE,GL_NORMAL_MAP)
							glTexGeni(GL_T,GL_TEXTURE_GEN_MODE,GL_NORMAL_MAP)
							glTexGeni(GL_R,GL_TEXTURE_GEN_MODE,GL_NORMAL_MAP)
						EndIf
				
					Else
					
						glDisable(GL_TEXTURE_CUBE_MAP)
						
						' only disable tex gen s and t if sphere mapping isn't using them
						If tex_flags&64=0
							glDisable(GL_TEXTURE_GEN_S)
							glDisable(GL_TEXTURE_GEN_T)
						EndIf
						
						glDisable(GL_TEXTURE_GEN_R)
						'glDisable(GL_TEXTURE_GEN_Q)
						
					EndIf 
					
					Select tex_blend
						Case 0 glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_REPLACE)
						Case 1 glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_REPLACE)
						Case 2 glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE)
						'Case 2 glTexEnvf(GL_TEXTURE_ENV,GL_COMBINE_RGB_EXT,GL_MODULATE)
						Case 3 glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_ADD)
						Case 4
							glTexEnvf GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE_EXT
							glTexEnvf GL_TEXTURE_ENV, GL_COMBINE_RGB_EXT, GL_DOT3_RGB_EXT
						Case 5
							glTexEnvi(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_COMBINE)
							glTexEnvi(GL_TEXTURE_ENV,GL_COMBINE_RGB,GL_MODULATE)
							glTexEnvi(GL_TEXTURE_ENV,GL_RGB_SCALE,2.0)
						Default glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE)
					End Select

					glEnableClientState(GL_TEXTURE_COORD_ARRAY)

					If vbo
						If tex_coords=0
							glBindBufferARB(GL_ARRAY_BUFFER_ARB,surf.vbo_id[1])
							glTexCoordPointer(2,GL_FLOAT,0,Null)
						Else
							glBindBufferARB(GL_ARRAY_BUFFER_ARB,surf.vbo_id[2])
							glTexCoordPointer(2,GL_FLOAT,0,Null)
						EndIf
					Else
						If tex_coords=0
							'glBindBufferARB(GL_ARRAY_BUFFER_ARB,0) already reset above
							glTexCoordPointer(2,GL_FLOAT,0,surf.vert_tex_coords0#)
						Else
							'glBindBufferARB(GL_ARRAY_BUFFER_ARB,0)
							glTexCoordPointer(2,GL_FLOAT,0,surf.vert_tex_coords1#)
						EndIf
					EndIf
							
					' reset texture matrix
					glMatrixMode(GL_TEXTURE)
					glLoadIdentity()
								
					If tex_u_pos#<>0.0 Or tex_v_pos#<>0.0
						glTranslatef(tex_u_pos#,tex_v_pos#,0.0)
					EndIf
					If tex_ang#<>0.0
						glRotatef(tex_ang#,0.0,0.0,1.0)
					EndIf
					If tex_u_scale#<>0.0 Or tex_v_scale#<>0.0
						glScalef(tex_u_scale#,tex_v_scale#,1.0)
					EndIf
					
					' if spheremap flag=true then flip tex
					If tex_flags&64<>0
						glScalef(1.0,-1.0,-1.0)
					EndIf
					
					' if cubemap flag=true then manipulate texture matrix so that cubemap is displayed properly 
					If tex_flags&128<>0

						glScalef(1.0,-1.0,-1.0)
						
						' get current modelview matrix (set in last camera update)
						Local mod_mat![16]
						glGetDoublev(GL_MODELVIEW_MATRIX,Varptr mod_mat[0])
	
						' get rotational inverse of current modelview matrix
						Local new_mat:TMatrix=New TMatrix
						new_mat.LoadIdentity()
						
						new_mat.grid[0,0] = mod_mat[0]
  						new_mat.grid[1,0] = mod_mat[1]
  						new_mat.grid[2,0] = mod_mat[2]

						new_mat.grid[0,1] = mod_mat[4]
						new_mat.grid[1,1] = mod_mat[5]
						new_mat.grid[2,1] = mod_mat[6]

						new_mat.grid[0,2] = mod_mat[8]
						new_mat.grid[1,2] = mod_mat[9]
						new_mat.grid[2,2] = mod_mat[10]
						
						glMultMatrixf(new_mat.grid)

					EndIf
					
				EndIf
			
			Next
				
			' draw tris
			
			glMatrixMode(GL_MODELVIEW)

			glPushMatrix()
	
			If TSprite(Self)=Null
				glMultMatrixf(mat.grid)
			Else
				glMultMatrixf(mat_sp.grid)
			EndIf
					
			If vbo																																																																																																																																																																																																																																																																																
				glDrawElements(GL_TRIANGLES,surf.no_tris*3,GL_UNSIGNED_SHORT,Null)
			Else
				'//SMALLFIXES NOTFIXED 'DebugStop IRRmesh+others sometimes crash here under parallels 
				glDrawElements(GL_TRIANGLES,surf.no_tris*3,GL_UNSIGNED_SHORT,surf.tris)
			EndIf

			glPopMatrix()
			
			' disable all texture layers
			For Local ix:Int=0 To tex_count-1
				If THardwareInfo.VBOSupport 'SMALLFIXES this if statement is a hack to prevent crash when vbo is not supported by GFX
					glActiveTextureARB(GL_TEXTURE0+ix)
					glClientActiveTextureARB(GL_TEXTURE0+ix)
				EndIf				
				' reset texture matrix
				glMatrixMode(GL_TEXTURE)
				glLoadIdentity()
				
				glDisable(GL_TEXTURE_2D)
				
				glDisable(GL_TEXTURE_CUBE_MAP)
				glDisable(GL_TEXTURE_GEN_S)
				glDisable(GL_TEXTURE_GEN_T)
				glDisable(GL_TEXTURE_GEN_R)
			
			Next
			
			glDisableClientState(GL_TEXTURE_COORD_ARRAY)
	
			' enable fog again if fog was enabled at start of func
			If fog=True
				glEnable(GL_FOG)
			EndIf

		Next
			
	End Method
	
End Type

