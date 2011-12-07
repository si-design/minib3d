Rem

These functions have been replaced in the main MiniB3D code by rewritten optimised versions
These versions are more readable than the optimised versions so are contained here for reference purposes

TMesh.bmx
---------

Method TransformMesh(mat:TMatrix)

	For Local s=1 To CountSurfaces()

		Local surf:TSurface=GetSurface(s)
			
		For Local v=0 To surf.CountVertices()-1
	
			' transform vertex
	
			Local vx#=surf.VertexX#(v)
			Local vy#=surf.VertexY#(v)
			Local vz#=-surf.VertexZ#(v)
	
			Local new_mat:TMatrix=mat.Copy() ' copy mat to new_mat so we don't change mat which we need to keep using for every vertex
			new_mat.Translate(vx#,vy#,vz#)

			vx#=new_mat.grid[3,0]
			vy#=new_mat.grid[3,1]
			vz#=new_mat.grid[3,2]
			
			surf.VertexCoords(v,vx#,vy#,-vz#)
			
			' transform normal
			
			Local nx#=surf.VertexNX#(v)
			Local ny#=surf.VertexNY#(v)
			Local nz#=-surf.VertexNZ#(v)
	
			Local new_mat2:TMatrix=mat.Copy() ' copy mat to new_mat so we don't change mat which we need to keep using for every vertex
			new_mat2.Translate(nx#,ny#,nz#)

			nx#=new_mat2.grid[3,0]
			ny#=new_mat2.grid[3,1]
			nz#=new_mat2.grid[3,2]
			
			surf.VertexNormal(v,nx#,ny#,-nz#)

		Next
						
	Next

End Method

TSurface.bmx
------------

Method UpdateNormals()

	Local norm_map:TMap=New TMap

	For Local t=0 Until CountTriangles()
	
		Local nx#=TriangleNX#(t)
		Local ny#=TriangleNY#(t)
		Local nz#=TriangleNZ#(t)
		
		For Local c=0 Until 3
		
			Local vx#=VertexX#(TriangleVertex(t,c))
			Local vy#=VertexY#(TriangleVertex(t,c))
			Local vz#=VertexZ#(TriangleVertex(t,c))
			
			Local vert:TVector=TVector.Create( vx,vy,vz )
	
			Local norm:TVector=TVector( norm_map.ValueForKey( vert ) )
			
			If norm
				norm.x:+nx
				norm.y:+ny
				norm.z:+nz
			Else
				norm_map.Insert vert,TVector.Create(nx,ny,nz)
			EndIf
			
		Next
		
	Next
	
	For Local norm:TVector=EachIn norm_map.Values()
		norm.Normalize
	Next

	For Local v=0 Until CountVertices()

		Local vx#=VertexX#( v )
		Local vy#=VertexY#( v )
		Local vz#=VertexZ#( v )
	
		Local vert:TVector=TVector.Create( vx,vy,vz )
		
		Local norm:TVector=TVector( norm_map.ValueForKey( vert ) )
		If Not norm Continue
		
		VertexNormal v,norm.x,norm.y,norm.z
				
	Next

End Method

TMatrix.bmx
-----------

Method Multiply(mat:TMatrix)

	Local new_mat:TMatrix=New TMatrix

	Local sum#=0

	Local row=0
	Local col=0

	For row=0 To 3
		For col=0 To 3
			For Local r=0 To 3
				Local a#=grid#[r,col]
				Local b#=mat.grid#[row,r]
				Local c#=a#*b#
				sum#=sum#+c#
			Next
			new_mat.grid#[row,col]=sum#
			sum#=0
		Next
	Next

	For row=0 To 3
		For col=0 To 3
			grid[row,col]=new_mat.grid[row,col]
		Next
	Next
	
End Method

Method Translate(x#,y#,z#)

	Local mat:TMatrix=New TMatrix

	mat.grid[0,0]=1
	mat.grid[1,0]=0
	mat.grid[2,0]=0
	mat.grid[3,0]=x#
	mat.grid[0,1]=0
	mat.grid[1,1]=1
	mat.grid[2,1]=0
	mat.grid[3,1]=y#
	mat.grid[0,2]=0
	mat.grid[1,2]=0
	mat.grid[2,2]=1
	mat.grid[3,2]=z#
	
	mat.grid[0,3]=0
	mat.grid[1,3]=0
	mat.grid[2,3]=0
	mat.grid[3,3]=1
	
	Multiply(mat)

End Method

Method Scale(x#,y#,z#)

	Local mat:TMatrix=New TMatrix

	mat.grid[0,0]=x#
	mat.grid[1,0]=0
	mat.grid[2,0]=0
	mat.grid[3,0]=0
	mat.grid[0,1]=0
	mat.grid[1,1]=y#
	mat.grid[2,1]=0
	mat.grid[3,1]=0
	mat.grid[0,2]=0
	mat.grid[1,2]=0
	mat.grid[2,2]=z#
	mat.grid[3,2]=0
	
	mat.grid[0,3]=0
	mat.grid[1,3]=0
	mat.grid[2,3]=0
	mat.grid[3,3]=1
	
	Multiply(mat)

End Method

Method Rotate(rx#,ry#,rz#)

	RotateYaw(ry#)
	RotatePitch(rx#)
	RotateRoll(rz#)

End Method

Method RotatePitch(ang#)

	Local mat:TMatrix=New TMatrix

	mat.grid[0,0]=1
	mat.grid[1,0]=0
	mat.grid[2,0]=0
	mat.grid[3,0]=0
	mat.grid[0,1]=0
	mat.grid[1,1]=Cos(ang#)
	mat.grid[2,1]=-Sin(ang#)
	mat.grid[3,1]=0
	mat.grid[0,2]=0
	mat.grid[1,2]=Sin(ang#)
	mat.grid[2,2]=Cos(ang#)
	mat.grid[3,2]=0
	
	mat.grid[0,3]=0
	mat.grid[1,3]=0
	mat.grid[2,3]=0
	mat.grid[3,3]=1
	
	Multiply(mat)

End Method

Method RotateYaw(ang#)

	Local mat:TMatrix=New TMatrix

	mat.grid[0,0]=Cos(ang#)
	mat.grid[1,0]=0
	mat.grid[2,0]=Sin(ang#)
	mat.grid[3,0]=0
	mat.grid[0,1]=0
	mat.grid[1,1]=1
	mat.grid[2,1]=0
	mat.grid[3,1]=0
	mat.grid[0,2]=-Sin(ang#)
	mat.grid[1,2]=0
	mat.grid[2,2]=Cos(ang#)
	mat.grid[3,2]=0
	
	mat.grid[0,3]=0
	mat.grid[1,3]=0
	mat.grid[2,3]=0
	mat.grid[3,3]=1
	
	Multiply(mat)

End Method

Method RotateRoll(ang#)

	Local mat:TMatrix=New TMatrix

	mat.grid[0,0]=Cos(ang#)
	mat.grid[1,0]=-Sin(ang#)
	mat.grid[2,0]=0
	mat.grid[3,0]=0
	mat.grid[0,1]=Sin(ang#)
	mat.grid[1,1]=Cos(ang#)
	mat.grid[2,1]=0
	mat.grid[3,1]=0
	mat.grid[0,2]=0
	mat.grid[1,2]=0
	mat.grid[2,2]=1
	mat.grid[3,2]=0
	
	mat.grid[0,3]=0
	mat.grid[1,3]=0
	mat.grid[2,3]=0
	mat.grid[3,3]=1
	
	Multiply(mat)

End Method

End Rem
