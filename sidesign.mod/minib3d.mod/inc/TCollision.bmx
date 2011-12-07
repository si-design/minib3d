Type TCollisionPair

	Global list:TList=New TList
	Global ent_lists:TList[MAX_TYPES]

	Field src_type:Int
	Field des_type:Int
	Field col_method:Int=0
	Field response:Int=0
	
	Method New()
	
		If LOG_NEW
			DebugLog "New TCollisionPair"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TCollisionPair"
		EndIf
	
	End Method

End Type

Type TCollisionImpact

	Method New()
	
		If LOG_NEW
			DebugLog "New TCollisionImpact"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TCollisionImpact"
		EndIf
	
	End Method

	Field x#,y#,z#
	Field nx#,ny#,nz#
	Field time#
	Field ent:TEntity
	Field surf:TSurface
	Field tri:Int

End Type

Const MAX_TYPES:Int=100

'collision methods
Const COLLISION_METHOD_SPHERE:Int=1
Const COLLISION_METHOD_POLYGON:Int=2
Const COLLISION_METHOD_BOX:Int=3

'collision actions
Const COLLISION_RESPONSE_NONE:Int=0
Const COLLISION_RESPONSE_STOP:Int=1
Const COLLISION_RESPONSE_SLIDE:Int=2
Const COLLISION_RESPONSE_SLIDEXZ:Int=3

Function UpdateCollisions()

	Global c_vec_a:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
	Global c_vec_b:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
	Global c_vec_radius:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
						
	Global c_vec_i:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
	Global c_vec_j:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
	Global c_vec_k:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)

	Global c_mat:Byte Ptr=C_CreateMatrixObject(c_vec_i,c_vec_j,c_vec_k)
				
	Global c_vec_v:Byte Ptr=C_CreateVecObject(0.0,0.0,0.0)
	
	Global c_tform:Byte Ptr=C_CreateTFormObject(c_mat,c_vec_v)

	' loop through collision setup list, containing pairs of src entities and des entities to be check for collisions
	For Local i:Int=0 Until MAX_TYPES
	
		' if no entities exist of src_type then do not check for collisions
		If TCollisionPair.ent_lists[i]=Null Then Continue

		' loop through src entities
		For Local ent:TEntity=EachIn TCollisionPair.ent_lists[i]

			ent.no_collisions=0
			ent.collision=ent.collision[..0]
	
			' if src entity is hidden or it's parent is hidden then do not check for collision
			If ent.Hidden()=True Then Continue
					
			C_UpdateVecObject(c_vec_a,ent.EntityX(True),ent.EntityY(True),ent.EntityZ(True))
			C_UpdateVecObject(c_vec_b,ent.old_x,ent.old_y,ent.old_z)
			C_UpdateVecObject(c_vec_radius,ent.radius_x,ent.radius_y,ent.radius_x)

			Local c_col_info:Byte Ptr=C_CreateCollisionInfoObject(c_vec_a,c_vec_b,c_vec_radius)

			Local c_coll:Byte Ptr=Null

			Local response:Int
			Repeat

				Local hit:Int=False
	
				c_coll=C_CreateCollisionObject()

				Local ent2_hit:TEntity=Null
				
				For Local col_pair:TCollisionPair=EachIn TCollisionPair.list
				
					If col_pair.src_type=i
					
						' if no entities exist of des_type then do not check for collisions
						If TCollisionPair.ent_lists[col_pair.des_type]=Null Then Continue
					
						' loop through des entities that are paired with src entities
						For Local ent2:TEntity=EachIn TCollisionPair.ent_lists[col_pair.des_type]
		
							' if des entity is hidden or it's parent is hidden then do not check for collision
							If ent2.Hidden()=True Then Continue
			
							' if src ent is same as des entity then do not check for collision
							If ent=ent2 Then Continue
							
							If QuickCheck(ent,ent2)=False Then Continue ' quick check to see if entities are colliding
		
							C_UpdateVecObject(c_vec_i,ent2.mat.grid[0,0],ent2.mat.grid[0,1],-ent2.mat.grid[0,2])
							C_UpdateVecObject(c_vec_j,ent2.mat.grid[1,0],ent2.mat.grid[1,1],-ent2.mat.grid[1,2])
							C_UpdateVecObject(c_vec_k,-ent2.mat.grid[2,0],-ent2.mat.grid[2,1],ent2.mat.grid[2,2])
					
							C_UpdateMatrixObject(c_mat,c_vec_i,c_vec_j,c_vec_k)
							C_UpdateVecObject(c_vec_v,ent2.mat.grid[3,0],ent2.mat.grid[3,1],-ent2.mat.grid[3,2])
							C_UpdateTFormObject(c_tform,c_mat,c_vec_v)
		
							' if pick mode is sphere or box then update collision info object to include entity radius/box info
							If col_pair.col_method<>COLLISION_METHOD_POLYGON
								C_UpdateCollisionInfoObject(c_col_info,ent2.radius_x,ent2.box_x,ent2.box_y,ent2.box_z,ent2.box_x+ent2.box_w,ent2.box_y+ent2.box_h,ent2.box_z+ent2.box_d)
							EndIf
				
							Local tree:Byte Ptr=Null
							If TMesh(ent2)<>Null
								TMesh(ent2).col_tree.TreeCheck(TMesh(ent2)) ' create collision tree for mesh if necessary
								tree=TMesh(ent2).col_tree.c_col_tree
							EndIf
		
							hit=C_CollisionDetect(c_col_info,c_coll,c_tform,tree,col_pair.col_method)
		
							If hit Then ent2_hit=ent2;response=col_pair.response
						
						Next
					
					EndIf
				
				Next
				
				If ent2_hit<>Null
					Local x:Int=C_CollisionResponse(c_col_info,c_coll,response) 'SMALLFIXES Collision fix from http://www.blitzmax.com/Community/posts.php?topic=87446			

					ent.no_collisions=ent.no_collisions+1

					Local i:Int=ent.no_collisions-1
					ent.collision=ent.collision[..i+1]			
					ent.collision[i]=New TCollisionImpact
					ent.collision[i].x#=C_CollisionX()
					ent.collision[i].y#=C_CollisionY()
					ent.collision[i].z#=C_CollisionZ()
					ent.collision[i].nx#=C_CollisionNX()
					ent.collision[i].ny#=C_CollisionNY()
					ent.collision[i].nz#=C_CollisionNZ()
					ent.collision[i].ent=ent2_hit
					
					If TMesh(ent2_hit)<>Null
						ent.collision[i].surf=TMesh(ent2_hit).GetSurface(C_CollisionSurface())
					Else
						ent.collision[i].surf=Null
					EndIf
					
					ent.collision[i].tri=C_CollisionTriangle()

					'TEntity.TFormPoint ent.collision[i].x#,ent.collision[i].y#,ent.collision[i].z#,ent2_hit,Null
					'ent.collision[i].x#=TEntity.tformed_x
					'ent.collision[i].y#=TEntity.tformed_y
					'ent.collision[i].z#=TEntity.tformed_z

					'TEntity.TFormNormal ent.collision[i].nx#,ent.collision[i].ny#,ent.collision[i].nz#,ent2_hit,Null
					'ent.collision[i].nx#=TEntity.tformed_x
					'ent.collision[i].ny#=TEntity.tformed_y
					'ent.collision[i].nz#=TEntity.tformed_z
						
					'If C_CollisionResponse(c_col_info,c_coll,response)=False Then Exit
					If x=False Then Exit 'SMALLFIXES Collision fix from http://www.blitzmax.com/Community/posts.php?topic=87446
					
				Else
				
					Exit
								
				EndIf
				
				C_DeleteCollisionObject(c_coll)
									
			Forever

			C_DeleteCollisionObject(c_coll)

			Local hits:Int=C_CollisionFinal(c_col_info)
			
			If hits
				
				Local x#=C_CollisionPosX()
				Local y#=C_CollisionPosY()
				Local z#=C_CollisionPosZ()
							
				ent.PositionEntity(x#,y#,z#,True)
				
			EndIf
	
			C_DeleteCollisionInfoObject(c_col_info)

			ent.old_x=ent.EntityX(True)
			ent.old_y=ent.EntityY(True)
			ent.old_z=ent.EntityZ(True)

		Next
										
	Next

End Function

' perform quick check to see whether it is possible that ent and ent 2 are intersecting
Function QuickCheck:int(ent:TEntity,ent2:TEntity)

	' check to see if src ent has moved since last update - if not, no intersection
	If ent.old_x=ent.EntityX(True) And ent.old_y=ent.EntityY(True) And ent.old_z=ent.EntityZ(True)
		Return False
	EndIf

	Return True

End Function
