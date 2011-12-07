Type TCamera Extends TEntity

	Global cam_list:TList=CreateList()

	Field vx:Int,vy:Int,vwidth:Int,vheight:Int
	Field cls_r#=0.0,cls_g#=0.0,cls_b#=0.0
	Field cls_color:Int=True,cls_zbuffer:Int=True
	
	Field range_near#=1.0,range_far#=1000.0
	Field zoom#=1.0
	
	Field proj_mode:Int=1
	
	Field fog_mode:Int
	Field fog_r#,fog_g#,fog_b#
	Field fog_range_near#=1.0,fog_range_far#=1000.0
	
	' used by CameraProject
	Field mod_mat:Double[16]
	Field proj_mat:Double[16]
    Field viewport:Int[4]
	Global projected_x#
	Global projected_y#
	Global projected_z#
	
	Field frustum#[6,4]

	Method New()
	
		If LOG_NEW
			DebugLog "New TCamera"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TCamera"
		EndIf
	
	End Method

	Method CopyEntity:TCamera(parent_ent:TEntity=Null)

		' new cam
		Local cam:TCamera=New TCamera
		
		' copy contents of child list before adding parent
		For Local ent:TEntity=EachIn child_list
			ent.CopyEntity(cam)
		Next
		
		' lists
		
		' add parent, add to list
		cam.AddParent(parent_ent:TEntity)
		cam.EntityListAdd(entity_list)
		
		' add to collision entity list
		If collision_type<>0
			TCollisionPair.ent_lists[collision_type].AddLast(cam)
		EndIf
		
		' add to pick entity list
		If pick_mode<>0
			TPick.ent_list.AddLast(cam)
		EndIf
		
		' update matrix
		If cam.parent<>Null
			cam.mat.Overwrite(cam.parent.mat)
		Else
			cam.mat.LoadIdentity()
		EndIf
		
		' copy entity info
		
		cam.mat.Multiply(mat)
		
		cam.px#=px#
		cam.py#=py#
		cam.pz#=pz#
		cam.sx#=sx#
		cam.sy#=sy#
		cam.sz#=sz#
		cam.rx#=rx#
		cam.ry#=ry#
		cam.rz#=rz#
		cam.qw#=qw#
		cam.qx#=qx#
		cam.qy#=qy#
		cam.qz#=qz#

		cam.name$=name$
		cam.class$=class$
		cam.order=order
		cam.hide=False
		
		cam.cull_radius#=cull_radius#
		cam.radius_x#=radius_x#
		cam.radius_y#=radius_y#
		cam.box_x#=box_x#
		cam.box_y#=box_y#
		cam.box_z#=box_z#
		cam.box_w#=box_w#
		cam.box_h#=box_h#
		cam.box_d#=box_d#
		cam.pick_mode=pick_mode
		cam.obscurer=obscurer

		' copy camera info
		
		cam.EntityListAdd(cam_list) ' add new cam to global cam list
		
		cam.vx=vx
		cam.vy=vy
		cam.vwidth=vwidth
		cam.vheight=vheight
		cam.cls_r#=cls_r#
		cam.cls_g#=cls_g#
		cam.cls_b#=cls_b#
		cam.cls_color=cls_color
		cam.cls_zbuffer=cls_zbuffer
		cam.range_near#=range_near#
		cam.range_far#=range_far#
		cam.zoom#=zoom#
		cam.proj_mode=proj_mode
		cam.fog_mode=fog_mode
		cam.fog_r#=fog_r#
		cam.fog_g#=fog_g#
		cam.fog_b#=fog_b#
		cam.fog_range_near#=fog_range_near#
		cam.fog_range_far#=fog_range_far#

	End Method
	
	Method FreeEntity()
	
		Super.FreeEntity() 
		
		ListRemove cam_list,Self
		
	End Method

	Function CreateCamera:TCamera(parent_ent:TEntity=Null)

		Local cam:TCamera=New TCamera
		
		cam.CameraViewport(0,0,TGlobal.width,TGlobal.height)
		
		cam.class$="Camera"
		
		cam.AddParent(parent_ent:TEntity)
		cam.EntityListAdd(entity_list) ' add to entity list
		cam.EntityListAdd(cam_list) ' add to cam list
		
		' update matrix
		If cam.parent<>Null
			cam.mat.Overwrite(cam.parent.mat)
			cam.UpdateMat()
		Else
			cam.UpdateMat(True)
		EndIf

		Return cam

	End Function

	Method CameraViewport(x:Int,y:Int,w:Int,h:Int)

		vx=x
		vy=TGlobal.height-h-y
		vwidth=w
		vheight=h

	End Method
	
	Method CameraClsColor(r#,g#,b#)

		cls_r#=r#/255.0
		cls_g#=g#/255.0
		cls_b#=b#/255.0

	End Method
	
	Method CameraClsMode(color:Int,zbuffer:Int)

		cls_color=color
		cls_zbuffer=zbuffer
	
	End Method
	
	Method CameraRange(near#,far#)

		range_near#=near#
		range_far#=far#
	
	End Method
	
	Method CameraZoom(zoom_val#)

		zoom#=zoom_val#

	End Method
	
	Method CameraProjMode(mode:Int=1)
	
		proj_mode=mode
		
	End Method
	
	' Calls function in TPick
	Method CameraPick:TEntity(x#,y#)
	
		Return TPick.CameraPick(Self,x#,y#)
	
	End Method
	
	Method CameraFogMode(mode:Int)

		fog_mode=mode

	End Method
	
	Method CameraFogColor(r#,g#,b#)

		fog_r#=r#/255.0
		fog_g#=g#/255.0
		fog_b#=b#/255.0

	End Method
	
	Method CameraFogRange(near#,far#)

		fog_range_near#=near#
		fog_range_far#=far#
	
	End Method

    Method CameraProject(x#,y#,z#)

		Local px!
		Local py!
		Local pz!

        gluProject(x#,y#,-z#,mod_mat!,proj_mat!,viewport,Varptr px!,Varptr py!,Varptr pz!)

		projected_x#=-vx+Float(px!)
		projected_y#=vy+vheight-Float(py!)
		projected_z#=Float(pz!)

    End Method

	Method ProjectedX#()
	
		Return projected_x#
	
	End Method
	
	Method ProjectedY#()

		Return projected_y#
	
	End Method
	
	Method ProjectedZ#()
	
		Return projected_z#
	
	End Method

	Method EntityInView#(ent:TEntity)

		If TMesh(ent)<>Null

			' get new mesh bounds if necessary
			TMesh(ent).GetBounds()

		EndIf
		
		Return EntityInFrustum(ent)
		
	End Method
		
	Method ExtractFrustum()

		Local proj#[16]
		Local modl#[16]
		Local clip#[16]
		Local t#
		
		' Get the current PROJECTION matrix from OpenGL
		glGetFloatv( GL_PROJECTION_MATRIX, proj )
		
		' Get the current MODELVIEW matrix from OpenGL
		glGetFloatv( GL_MODELVIEW_MATRIX, modl )
		
		' Combine the two matrices (multiply projection by modelview)
		clip[ 0] = modl[ 0] * proj[ 0] + modl[ 1] * proj[ 4] + modl[ 2] * proj[ 8] + modl[ 3] * proj[12]
		clip[ 1] = modl[ 0] * proj[ 1] + modl[ 1] * proj[ 5] + modl[ 2] * proj[ 9] + modl[ 3] * proj[13]
		clip[ 2] = modl[ 0] * proj[ 2] + modl[ 1] * proj[ 6] + modl[ 2] * proj[10] + modl[ 3] * proj[14]
		clip[ 3] = modl[ 0] * proj[ 3] + modl[ 1] * proj[ 7] + modl[ 2] * proj[11] + modl[ 3] * proj[15]
		
		clip[ 4] = modl[ 4] * proj[ 0] + modl[ 5] * proj[ 4] + modl[ 6] * proj[ 8] + modl[ 7] * proj[12]
		clip[ 5] = modl[ 4] * proj[ 1] + modl[ 5] * proj[ 5] + modl[ 6] * proj[ 9] + modl[ 7] * proj[13]
		clip[ 6] = modl[ 4] * proj[ 2] + modl[ 5] * proj[ 6] + modl[ 6] * proj[10] + modl[ 7] * proj[14]
		clip[ 7] = modl[ 4] * proj[ 3] + modl[ 5] * proj[ 7] + modl[ 6] * proj[11] + modl[ 7] * proj[15]
		
		clip[ 8] = modl[ 8] * proj[ 0] + modl[ 9] * proj[ 4] + modl[10] * proj[ 8] + modl[11] * proj[12]
		clip[ 9] = modl[ 8] * proj[ 1] + modl[ 9] * proj[ 5] + modl[10] * proj[ 9] + modl[11] * proj[13]
		clip[10] = modl[ 8] * proj[ 2] + modl[ 9] * proj[ 6] + modl[10] * proj[10] + modl[11] * proj[14]
		clip[11] = modl[ 8] * proj[ 3] + modl[ 9] * proj[ 7] + modl[10] * proj[11] + modl[11] * proj[15]
		
		clip[12] = modl[12] * proj[ 0] + modl[13] * proj[ 4] + modl[14] * proj[ 8] + modl[15] * proj[12]
		clip[13] = modl[12] * proj[ 1] + modl[13] * proj[ 5] + modl[14] * proj[ 9] + modl[15] * proj[13]
		clip[14] = modl[12] * proj[ 2] + modl[13] * proj[ 6] + modl[14] * proj[10] + modl[15] * proj[14]
		clip[15] = modl[12] * proj[ 3] + modl[13] * proj[ 7] + modl[14] * proj[11] + modl[15] * proj[15]
		
		' Extract the numbers for the right plane
		frustum[0,0] = clip[ 3] - clip[ 0]
		frustum[0,1] = clip[ 7] - clip[ 4]
		frustum[0,2] = clip[11] - clip[ 8]
		frustum[0,3] = clip[15] - clip[12]
		
		' Normalize the result
		t = Sqr( frustum[0,0] * frustum[0,0] + frustum[0,1] * frustum[0,1] + frustum[0,2] * frustum[0,2] )
		frustum[0,0] :/ t
		frustum[0,1] :/ t
		frustum[0,2] :/ t
		frustum[0,3] :/ t
		
		' Extract the numbers for the left plane 
		frustum[1,0] = clip[ 3] + clip[ 0]
		frustum[1,1] = clip[ 7] + clip[ 4]
		frustum[1,2] = clip[11] + clip[ 8]
		frustum[1,3] = clip[15] + clip[12]
		
		' Normalize the result
		t = Sqr( frustum[1,0] * frustum[1,0] + frustum[1,1] * frustum[1,1] + frustum[1,2] * frustum[1,2] )
		frustum[1,0] :/ t
		frustum[1,1] :/ t
		frustum[1,2] :/ t
		frustum[1,3] :/ t
		
		' Extract the BOTTOM plane
		frustum[2,0] = clip[ 3] + clip[ 1]
		frustum[2,1] = clip[ 7] + clip[ 5]
		frustum[2,2] = clip[11] + clip[ 9]
		frustum[2,3] = clip[15] + clip[13]
		
		' Normalize the result
		t = Sqr( frustum[2,0] * frustum[2,0] + frustum[2,1] * frustum[2,1] + frustum[2,2] * frustum[2,2] )
		frustum[2,0] :/ t
		frustum[2,1] :/ t
		frustum[2,2] :/ t
		frustum[2,3] :/ t
		
		' Extract the TOP plane
		frustum[3,0] = clip[ 3] - clip[ 1]
		frustum[3,1] = clip[ 7] - clip[ 5]
		frustum[3,2] = clip[11] - clip[ 9]
		frustum[3,3] = clip[15] - clip[13]
		
		' Normalize the result
		t = Sqr( frustum[3,0] * frustum[3,0] + frustum[3,1] * frustum[3,1] + frustum[3,2] * frustum[3,2] )
		frustum[3,0] :/ t
		frustum[3,1] :/ t
		frustum[3,2] :/ t
		frustum[3,3] :/ t
		
		' Extract the FAR plane
		frustum[4,0] = clip[ 3] - clip[ 2]
		frustum[4,1] = clip[ 7] - clip[ 6]
		frustum[4,2] = clip[11] - clip[10]
		frustum[4,3] = clip[15] - clip[14]
		
		' Normalize the result
		t = Sqr( frustum[4,0] * frustum[4,0] + frustum[4,1] * frustum[4,1] + frustum[4,2] * frustum[4,2] )
		frustum[4,0] :/ t
		frustum[4,1] :/ t
		frustum[4,2] :/ t
		frustum[4,3] :/ t
		
		' Extract the NEAR plane
		frustum[5,0] = clip[ 3] + clip[ 2]
		frustum[5,1] = clip[ 7] + clip[ 6]
		frustum[5,2] = clip[11] + clip[10]
		frustum[5,3] = clip[15] + clip[14]

		' Normalize the result 
		t = Sqr( frustum[5,0] * frustum[5,0] + frustum[5,1] * frustum[5,1] + frustum[5,2] * frustum[5,2] )
		frustum[5,0] :/ t
		frustum[5,1] :/ t
		frustum[5,2] :/ t
		frustum[5,3] :/ t

	End Method

	Method EntityInFrustum#(ent:TEntity)
	
		Local x#=ent.EntityX#(True)
		Local y#=ent.EntityY#(True)
		Local z#=ent.EntityZ#(True)

		Local radius#=Abs(ent.cull_radius#) ' use absolute value as cull_radius will be negative value if set by MeshCullRadius (manual cull)

		' if entity is mesh, we need to use mesh centre for culling which may be different from entity position
		If TMesh(ent)
		
			' mesh centre
			x#=TMesh(ent).min_x
			y#=TMesh(ent).min_y
			z#=TMesh(ent).min_z
			x#=x#+(TMesh(ent).max_x-TMesh(ent).min_x)/2.0
			y#=y#+(TMesh(ent).max_y-TMesh(ent).min_y)/2.0
			z#=z#+(TMesh(ent).max_z-TMesh(ent).min_z)/2.0
			
			' transform mesh centre into world space
			TEntity.TFormPoint x#,y#,z#,ent,Null
			x#=tformed_x
			y#=tformed_y
			z#=tformed_z
			
			' radius - apply entity scale
			Local rx#=radius#*ent.EntityScaleX(True)
			Local ry#=radius#*ent.EntityScaleY(True)
			Local rz#=radius#*ent.EntityScaleZ(True)
			If rx#>=ry# And rx#>=rz#
				radius#=Abs(rx#)
			Else If ry#>=rx# And ry#>=rz#
				radius#=Abs(ry#)
			Else
				radius#=Abs(rz#)
			EndIf
		
		EndIf
		
		' is sphere in frustum

		Local d#
		For Local p:Int=0 To 5
			d# = frustum[p,0] * x + frustum[p,1] * y + frustum[p,2] * -z + frustum[p,3]
			If d <= -radius Then Return 0
		Next
	
		Return d + radius
	
	End Method
	
	Rem
	Method SphereInFrustum#(x#,y#,z#,radius#)
	
		Local d#
	
		For Local p=0 To 5
	
			d# = frustum[p,0] * x + frustum[p,1] * y + frustum[p,2] * z + frustum[p,3]
	      
			If d <= -radius Then Return 0
	
		Next
	
		Return d + radius
	
	End Method
	End Rem
	
	' Helper funcs
	Rem	
	Method Update0()

		' viewport
		glViewport(vx,vy,vwidth,vheight)
		glScissor(vx,vy,vwidth,vheight)
		glClearColor(cls_r#,cls_g#,cls_b#,1.0)
		
		' clear buffers
		If cls_color=True And cls_zbuffer=True
			glDepthMask(GL_TRUE)
			glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT)
		Else
			If cls_color=True
				glClear(GL_COLOR_BUFFER_BIT)
			Else
				If cls_zbuffer=True
					glDepthMask(GL_TRUE)
					glClear(GL_DEPTH_BUFFER_BIT)
				EndIf
			EndIf
		EndIf
		
		'fog
		If fog_mode>0
			glEnable(GL_FOG)
			glFogi(GL_FOG_MODE,GL_LINEAR)
			glFogf(GL_FOG_START,fog_range_near#)
			glFogf(GL_FOG_END,fog_range_far#)
			Local rgb#[]=[fog_r#,fog_g#,fog_b#]
			glFogfv(GL_FOG_COLOR,rgb#)
		Else
			glDisable(GL_FOG)
		EndIf
					
		glMatrixMode(GL_PROJECTION)
		glLoadIdentity()
		Local ratio#=(Float(vwidth)/vheight)
		gluPerspective(ATan((1.0/(zoom#*ratio#)))*2.0,ratio#,range_near#,range_far#)
				
		glMatrixMode(GL_MODELVIEW)
		
		Local new_mat:TMatrix=mat.Inverse()	
		glLoadMatrixf(new_mat.grid)

		' Get projection/model/viewport info - for use with CameraProject
		glGetDoublev(GL_MODELVIEW_MATRIX,Varptr mod_mat[0])
		glGetDoublev(GL_PROJECTION_MATRIX,Varptr proj_mat[0])
		glGetIntegerv(GL_VIEWPORT,Varptr viewport[0])
		
		ExtractFrustum()

	End Method
	End Rem

	Method Update()

		' viewport
		glViewport(vx,vy,vwidth,vheight)
		glScissor(vx,vy,vwidth,vheight)
		glClearColor(cls_r#,cls_g#,cls_b#,1.0)

		' clear buffers
		If cls_color=True And cls_zbuffer=True
			glDepthMask(GL_TRUE)
			glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT)
		Else
			If cls_color=True
				glClear(GL_COLOR_BUFFER_BIT)
			Else
				If cls_zbuffer=True
					glDepthMask(GL_TRUE)
					glClear(GL_DEPTH_BUFFER_BIT)
				EndIf
			EndIf
		EndIf

		'fog
		If fog_mode>0
			glEnable(GL_FOG)
			glFogi(GL_FOG_MODE,GL_LINEAR)
			glFogf(GL_FOG_START,fog_range_near#)
			glFogf(GL_FOG_END,fog_range_far#)
			Local rgb#[]=[fog_r#,fog_g#,fog_b#]
			glFogfv(GL_FOG_COLOR,rgb#)
		Else
			glDisable(GL_FOG)
		EndIf

		Local ratio#=(Float(vwidth)/vheight)
		Local jx#=TGlobal.j[TGlobal.jitter,0]
		Local jy#=TGlobal.j[TGlobal.jitter,1]
		If TGlobal.aa=False Then jx#=0;jy#=0
		
		accPerspective(ATan((1.0/(zoom#*ratio#)))*2.0,ratio#,range_near#,range_far#,jx#,jy#,0.0,0.0,1.0)

		Local new_mat:TMatrix=mat.Inverse()	
		glLoadMatrixf(new_mat.grid)

		' Get projection/model/viewport info - for use with CameraProject
		glGetDoublev(GL_MODELVIEW_MATRIX,Varptr mod_mat[0])
		glGetDoublev(GL_PROJECTION_MATRIX,Varptr proj_mat[0])
		glGetIntegerv(GL_VIEWPORT,Varptr viewport[0])
		
		ExtractFrustum()
	
	End Method
	
	Method accPerspective(fovy#,aspect#,zNear#,zFar#,pixdx#,pixdy#,eyedx#,eyedy#,focus#)
	
		Local fov2#,left_#,right_#,bottom#,top#
		'fov2=((fovy*Pi)/180.0)/2.0
		fov2=fovy/2.0
		
		top=zNear/(Cos(fov2)/Sin(fov2))
		bottom=-top
		right_=top*aspect
		left_=-right_
	
		accFrustum(left_,right_,bottom,top,zNear,zFar,pixdx,pixdy,eyedx,eyedy,focus)
	
	End Method

	Method accFrustum(left_#,right_#,bottom#,top#,zNear#,zFar#,pixdx#,pixdy#,eyedx#,eyedy#,focus#)
	
		Local xwsize#,ywsize#
		Local dx#,dy#
		
		xwsize=right_-left_
		ywsize=top-bottom
		dx=-(pixdx*xwsize/Float(viewport[2])+eyedx*zNear/focus)
		dy=-(pixdy*ywsize/Float(viewport[3])+eyedy*zNear/focus)
		
		glMatrixMode(GL_PROJECTION)
		glLoadIdentity()
		'Local ratio#=(Float(vwidth)/vheight)
		'gluPerspective(ATan((1.0/(zoom#*ratio#)))*2.0,ratio#,range_near#,range_far#)
		If proj_mode = 1 Then
			glFrustum(left_+dx,right_+dx,bottom+dy,top+dy,zNear,zFar)
		Else If proj_mode = 2
			glOrtho(left_+dx,right_+dx,bottom+dy,top+dy,zNear,zFar)
		EndIf
		glMatrixMode(GL_MODELVIEW)
		glLoadIdentity()
		glTranslatef(-eyedx,-eyedy,0.0)
		
	End Method
	
End Type