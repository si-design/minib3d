Type TPick

	' EntityPickMode in TEntity

	Const EPSILON:Float=.0001
	
	Global ent_list:TList=New TList ' list containing pickable entities

	Global picked_x:Float,picked_y:Float,picked_z:Float
	Global picked_nx:Float,picked_ny:Float,picked_nz:Float
	Global picked_time:Float
	Global picked_ent:TEntity
	Global picked_surface:TSurface
	Global picked_triangle:Int

	Function CameraPick:TEntity(cam:TCamera,vx:Float,vy:Float)

		vy:Float=TGlobal.height-vy

		Local px:Double
		Local py:Double
		Local pz:Double

        gluUnProject(vx,vy,0.0,cam.mod_mat,cam.proj_mat,cam.Viewport,Varptr px,Varptr py,Varptr pz)

		Local x:Float=Float(px)
		Local y:Float=Float(py)
		Local z:Float=-Float(pz)
		
        gluUnProject(vx,vy,1.0,cam.mod_mat,cam.proj_mat,cam.Viewport,Varptr px,Varptr py,Varptr pz)

		Local x2:Float=Float(px)
		Local y2:Float=Float(py)
		Local z2:Float=-Float(pz)

		Return Pick(x:Float,y:Float,z:Float,x2:Float,y2:Float,z2:Float)
	
	End Function

	Function EntityPick:TEntity(ent:TEntity,range:Float)

		TEntity.TFormPoint(0.0,0.0,0.0,ent,Null)
		Local x:Float=TEntity.TFormedX()
		Local y:Float=TEntity.TFormedY()
		Local z:Float=TEntity.TFormedZ()
		
		TEntity.TFormPoint(0.0,0.0,range:Float,ent,Null)
		Local x2:Float=TEntity.TFormedX()
		Local y2:Float=TEntity.TFormedY()
		Local z2:Float=TEntity.TFormedZ()
		
		Return Pick(x,y,z,x2,y2,z2)

	End Function

	Function LinePick:TEntity(x:Float,y:Float,z:Float,dx:Float,dy:Float,dz:Float,radius:Float=0.0)

		Return Pick(x,y,z,x+dx,y+dy,z+dz,radius)

	End Function

	Function EntityVisible:Int(src_ent:TEntity,dest_ent:TEntity)

		' get pick values
		
		Local px:Float=picked_x
		Local py:Float=picked_y
		Local pz:Float=picked_z
		Local pnx:Float=picked_nx
		Local pny:Float=picked_ny
		Local pnz:Float=picked_nz
		Local ptime:Float=picked_time
		Local pent:TEntity=picked_ent
		Local psurf:TSurface=picked_surface
		Local ptri:Int=picked_triangle

		' perform line pick

		Local ax:Float=src_ent.EntityX(True)
		Local ay:Float=src_ent.EntityY(True)
		Local az:Float=src_ent.EntityZ(True)
		
		Local bx:Float=dest_ent.EntityX(True)
		Local by:Float=dest_ent.EntityY(True)
		Local bz:Float=dest_ent.EntityZ(True)

		Local pick:TEntity=Pick(ax,ay,az,bx,by,bz)
		
		' if picked entity was dest ent then dest_picked flag to true
		Local dest_picked:Int=False
		If picked_ent=dest_ent Then dest_picked=True
		
		' restore pick values
		
		picked_x=px
		picked_y=py
		picked_z=pz
		picked_nx=pnx
		picked_ny=pny
		picked_nz=pnz
		picked_time=ptime
		picked_ent=pent
		picked_surface=psurf
		picked_triangle=ptri
		
		' return false (not visible) if nothing picked, or dest ent wasn't picked
		If pick<>Null And dest_picked<>True
		
			Return False
			
		EndIf
		
		Return True
		
	End Function

	Function PickedX:Float()
		Return picked_x
	End Function
	
	Function PickedY:Float()
		Return picked_y
	End Function
	
	Function PickedZ:Float()
		Return picked_z
	End Function
	
	Function PickedNX:Float()
		Return picked_nx
	End Function
	
	Function PickedNY:Float()
		Return picked_ny
	End Function
	
	Function PickedNZ:Float()
		Return picked_nz
	End Function
	
	Function PickedTime:Float()
		Return picked_time
	End Function
	
	Function PickedEntity:TEntity()
		Return picked_ent
	End Function
	
	Function PickedSurface:TSurface()
		Return picked_surface
	End Function
	
	Function PickedTriangle:int()
		Return picked_triangle
	End Function

	' requires two absolute positional values
	Function Pick:TEntity(ax:Float,ay:Float,az:Float,bx:Float,by:Float,bz:Float,radius:Float=0.0)

		Global c_vec_a:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
		Global c_vec_b:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
		Global c_vec_radius:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
		Global c_col_info:Byte Ptr=C_CreateCollisionInfoObject(c_vec_a,c_vec_b,c_vec_radius)

		Global c_line:Byte Ptr=C_CreateLineObject(0.0,0.0,0.0,0.0,0.0,0.0)

		Global c_vec_i:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
		Global c_vec_j:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
		Global c_vec_k:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)

		Global c_mat:Byte Ptr=C_CreateMatrixObject(c_vec_i,c_vec_j,c_vec_k)		
		Global c_vec_v:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
		Global c_tform:Byte Ptr=C_CreateTFormObject(c_mat,c_vec_v)

		picked_ent=Null
		picked_time=1.0
	
		C_UpdateLineObject(c_line,ax,ay,az,bx-ax,by-ay,bz-az)
		
		Local c_col:Byte Ptr=C_CreateCollisionObject()
		
		Local pick:Int=False
		
		For Local ent:TEntity=EachIn ent_list
		
			If ent.pick_mode=0 Or ent.Hidden()=True Then Continue
						
			C_UpdateVecObject(c_vec_i,ent.mat.grid[0,0],ent.mat.grid[0,1],-ent.mat.grid[0,2])
			C_UpdateVecObject(c_vec_j,ent.mat.grid[1,0],ent.mat.grid[1,1],-ent.mat.grid[1,2])
			C_UpdateVecObject(c_vec_k,-ent.mat.grid[2,0],-ent.mat.grid[2,1],ent.mat.grid[2,2])
			
			C_UpdateMatrixObject(c_mat,c_vec_i,c_vec_j,c_vec_k)
			C_UpdateVecObject(c_vec_v,ent.mat.grid[3,0],ent.mat.grid[3,1],-ent.mat.grid[3,2])
			C_UpdateTFormObject(c_tform,c_mat,c_vec_v)
			
			' if pick mode is sphere or box then update collision info object to include entity radius/box info
			If ent.pick_mode<>2
				C_UpdateCollisionInfoObject(c_col_info,ent.radius_x,ent.box_x,ent.box_y,ent.box_z,ent.box_x+ent.box_w,ent.box_y+ent.box_h,ent.box_z+ent.box_d)
			EndIf
		
			Local tree:Byte Ptr=Null
			If TMesh(ent)<>Null
				TMesh(ent).col_tree.TreeCheck(TMesh(ent)) ' create collision tree for mesh if necessary
				tree=TMesh(ent).col_tree.c_col_tree
			'SMALLFIXES to avoid crashes, skip pivots with pickmode 2
			ElseIf ent.pick_mode = 2	
				Continue
			EndIf

		
			pick=C_Pick(c_col_info,c_line,radius,c_col,c_tform,tree,ent.pick_mode)
			
			If pick
				picked_ent=ent
			EndIf
			
		Next
		
		C_DeleteCollisionObject(c_col)

		If picked_ent<>Null

			picked_x=C_CollisionX()
			picked_y=C_CollisionY()
			picked_z=C_CollisionZ()
			
			picked_nx=C_CollisionNX()
			picked_ny=C_CollisionNY()
			picked_nz=C_CollisionNZ()
			
			'TEntity.TFormPoint(picked_x,picked_y,picked_z,picked_ent,Null)
			'picked_x=TEntity.tformed_x
			'picked_y=TEntity.tformed_y
			'picked_z=TEntity.tformed_z
			
			'TEntity.TFormNormal(picked_nx,picked_ny,picked_nz,picked_ent,Null)
			'picked_nx=TEntity.tformed_x
			'picked_ny=TEntity.tformed_y
			'picked_nz=TEntity.tformed_z
			
			picked_time=C_CollisionTime()
			
			'picked_ent=ent
			If TMesh(picked_ent)<>Null
				picked_surface=TMesh(picked_ent).GetSurface(C_CollisionSurface())
			Else
				picked_surface=Null
			EndIf
			picked_triangle=C_CollisionTriangle()
	
		EndIf
		
		Return picked_ent

	End Function

End Type
