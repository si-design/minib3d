Type TColTree

	Field c_col_tree:Byte Ptr=Null
	Field reset_col_tree:Int=False

	Method New()
	
		If LOG_NEW
			DebugLog "New TColTree"
		EndIf
	
	End Method
	
	Method Delete()
	
		If c_col_tree<>Null
			C_DeleteColTree(c_col_tree)
			c_col_tree=Null
		EndIf
	
		If LOG_DEL
			DebugLog "Del TColTree"
		EndIf
	
	End Method
	
	' creates a collision tree for a mesh if necessary
	Method TreeCheck(mesh:TMesh)

		' if reset_col_tree flag is true clear tree
		If reset_col_tree=True

			If c_col_tree<>Null
				C_DeleteColTree(c_col_tree)
				c_col_tree=Null
			EndIf
			reset_col_tree=False
				
		EndIf

		If c_col_tree=Null

			Local total_verts:Int=0
			Local mesh_info:Byte Ptr=C_NewMeshInfo()
		
			For Local s:Int=1 To mesh.CountSurfaces()
			
				Local surf:TSurface=mesh.GetSurface(s)
				
				Local no_tris:Int=surf.no_tris
				Local no_verts:Int=surf.no_verts
				Local tris:Short[]=surf.tris[..]
				Local verts:Float[]=surf.vert_coords[..]
										
				If no_tris<>0 And no_verts<>0
				
					' inc vert index
					For Local i:Int=0 To no_tris-1
						tris[i*3+0]:+total_verts
						tris[i*3+1]:+total_verts
						tris[i*3+2]:+total_verts
					Next
				
					' reverse vert order
					For Local i:Int=0 To no_tris-1
						Local t_v0:Int=tris[i*3+0]
						Local t_v2:Int=tris[i*3+2]
						tris[i*3+0]=t_v2
						tris[i*3+2]=t_v0
					Next
					
					' negate z vert coords
					For Local i:Int=0 To no_verts-1
						verts[i*3+2]=-verts[i*3+2]
					Next
		
					C_AddSurface(mesh_info,no_tris,no_verts,tris,verts,s)
										
					total_verts:+no_verts
				
				EndIf
	
			Next

			c_col_tree=C_CreateColTree(mesh_info)

			C_DeleteMeshInfo(mesh_info)

		EndIf
						
	End Method	
	
End Type
