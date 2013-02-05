Type TMatrix

	Field grid#[4,4]
	
	Method New()
	
		If LOG_NEW
			DebugLog "New TMatrix"
		EndIf

	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TMatrix"
		EndIf

	End Method
	
	Method LoadIdentity()
	
		grid[0,0]=1.0
		grid[1,0]=0.0
		grid[2,0]=0.0
		grid[3,0]=0.0
		grid[0,1]=0.0
		grid[1,1]=1.0
		grid[2,1]=0.0
		grid[3,1]=0.0
		grid[0,2]=0.0
		grid[1,2]=0.0
		grid[2,2]=1.0
		grid[3,2]=0.0
		
		grid[0,3]=0.0
		grid[1,3]=0.0
		grid[2,3]=0.0
		grid[3,3]=1.0
	
	End Method
	
	' copy - create new copy and returns it
	
	Method Copy:TMatrix()
	
		Local mat:TMatrix=New TMatrix
	
		mat.grid[0,0]=grid[0,0]
		mat.grid[1,0]=grid[1,0]
		mat.grid[2,0]=grid[2,0]
		mat.grid[3,0]=grid[3,0]
		mat.grid[0,1]=grid[0,1]
		mat.grid[1,1]=grid[1,1]
		mat.grid[2,1]=grid[2,1]
		mat.grid[3,1]=grid[3,1]
		mat.grid[0,2]=grid[0,2]
		mat.grid[1,2]=grid[1,2]
		mat.grid[2,2]=grid[2,2]
		mat.grid[3,2]=grid[3,2]
		
		' do not remove
		mat.grid[0,3]=grid[0,3]
		mat.grid[1,3]=grid[1,3]
		mat.grid[2,3]=grid[2,3]
		mat.grid[3,3]=grid[3,3]
		
		Return mat
	
	End Method
	
	' overwrite - overwrites self with matrix passed as parameter
	
	Method Overwrite(mat:TMatrix)
	
		grid[0,0]=mat.grid[0,0]
		grid[1,0]=mat.grid[1,0]
		grid[2,0]=mat.grid[2,0]
		grid[3,0]=mat.grid[3,0]
		grid[0,1]=mat.grid[0,1]
		grid[1,1]=mat.grid[1,1]
		grid[2,1]=mat.grid[2,1]
		grid[3,1]=mat.grid[3,1]
		grid[0,2]=mat.grid[0,2]
		grid[1,2]=mat.grid[1,2]
		grid[2,2]=mat.grid[2,2]
		grid[3,2]=mat.grid[3,2]
		
		grid[0,3]=mat.grid[0,3]
		grid[1,3]=mat.grid[1,3]
		grid[2,3]=mat.grid[2,3]
		grid[3,3]=mat.grid[3,3]
		
	End Method
	
	Method Determinant#()
		Return	_m[0,0]*_m[1,1]*_m[2,2]*_m[3,3] + _m[0,0]*_m[1,2]*_m[2,3]*_m[3,1] + _m[0,0]*_m[1,3]*_m[2,1]*_m[3,2] +..
						_m[0,1]*_m[1,0]*_m[2,3]*_m[3,2] + _m[0,1]*_m[1,2]*_m[2,0]*_m[3,3] + _m[0,1]*_m[1,3]*_m[2,2]*_m[3,0] +..
						_m[0,2]*_m[1,0]*_m[2,1]*_m[3,3] + _m[0,2]*_m[1,1]*_m[2,3]*_m[3,0] + _m[0,2]*_m[1,3]*_m[2,0]*_m[3,1] +..
						_m[0,3]*_m[1,0]*_m[2,2]*_m[3,1] + _m[0,3]*_m[1,1]*_m[2,0]*_m[3,2] + _m[0,3]*_m[1,2]*_m[2,1]*_m[3,0] -..
						_m[0,0]*_m[1,1]*_m[2,3]*_m[3,2] - _m[0,0]*_m[1,2]*_m[2,1]*_m[3,3] - _m[0,0]*_m[1,3]*_m[2,2]*_m[3,1] -..
						_m[0,1]*_m[1,0]*_m[2,2]*_m[3,3] - _m[0,1]*_m[1,2]*_m[2,3]*_m[3,0] - _m[0,1]*_m[1,3]*_m[2,0]*_m[3,2] -..
						_m[0,2]*_m[1,0]*_m[2,3]*_m[3,1] - _m[0,2]*_m[1,1]*_m[2,0]*_m[3,3] - _m[0,2]*_m[1,3]*_m[2,1]*_m[3,0] -..
						_m[0,3]*_m[1,0]*_m[2,1]*_m[3,2] - _m[0,3]*_m[1,1]*_m[2,2]*_m[3,0] - _m[0,3]*_m[1,2]*_m[2,0]*_m[3,1]
	End Method

	Method Inverse:TMatrix()
		Local matrix:TMatrix=New TMatrix
		
		Local d# = Determinant()
		If d = 0 Return Null
		d = 1.0/d
		
		matrix._m[0,0] = (_m[1,1]*_m[2,2]*_m[3,3] + _m[1,2]*_m[2,3]*_m[3,1] + _m[1,3]*_m[2,1]*_m[3,2] - _m[1,1]*_m[2,3]*_m[3,2] - _m[1,2]*_m[2,1]*_m[3,3] - _m[1,3]*_m[2,2]*_m[3,1])*d
		matrix._m[0,1] = (_m[0,1]*_m[2,3]*_m[3,2] + _m[0,2]*_m[2,1]*_m[3,3] + _m[0,3]*_m[2,2]*_m[3,1] - _m[0,1]*_m[2,2]*_m[3,3] - _m[0,2]*_m[2,3]*_m[3,1] - _m[0,3]*_m[2,1]*_m[3,2])*d
		matrix._m[0,2] = (_m[0,1]*_m[1,2]*_m[3,3] + _m[0,2]*_m[1,3]*_m[3,1] + _m[0,3]*_m[1,1]*_m[3,2] - _m[0,1]*_m[1,3]*_m[3,2] - _m[0,2]*_m[1,1]*_m[3,3] - _m[0,3]*_m[1,2]*_m[3,1])*d
		matrix._m[0,3] = (_m[0,1]*_m[1,3]*_m[2,2] + _m[0,2]*_m[1,1]*_m[2,3] + _m[0,3]*_m[1,2]*_m[2,1] - _m[0,1]*_m[1,2]*_m[2,3] - _m[0,2]*_m[1,3]*_m[2,1] - _m[0,3]*_m[1,1]*_m[2,2])*d
		matrix._m[1,0] = (_m[1,0]*_m[2,3]*_m[3,2] + _m[1,2]*_m[2,0]*_m[3,3] + _m[1,3]*_m[2,2]*_m[3,0] - _m[1,0]*_m[2,2]*_m[3,3] - _m[1,2]*_m[2,3]*_m[3,0] - _m[1,3]*_m[2,0]*_m[3,2])*d
		matrix._m[1,1] = (_m[0,0]*_m[2,2]*_m[3,3] + _m[0,2]*_m[2,3]*_m[3,0] + _m[0,3]*_m[2,0]*_m[3,2] - _m[0,0]*_m[2,3]*_m[3,2] - _m[0,2]*_m[2,0]*_m[3,3] - _m[0,3]*_m[2,2]*_m[3,0])*d
		matrix._m[1,2] = (_m[0,0]*_m[1,3]*_m[3,2] + _m[0,2]*_m[1,0]*_m[3,3] + _m[0,3]*_m[1,2]*_m[3,0] - _m[0,0]*_m[1,2]*_m[3,3] - _m[0,2]*_m[1,3]*_m[3,0] - _m[0,3]*_m[1,0]*_m[3,2])*d
		matrix._m[1,3] = (_m[0,0]*_m[1,2]*_m[2,3] + _m[0,2]*_m[1,3]*_m[2,0] + _m[0,3]*_m[1,0]*_m[2,2] - _m[0,0]*_m[1,3]*_m[2,2] - _m[0,2]*_m[1,0]*_m[2,3] - _m[0,3]*_m[1,2]*_m[2,0])*d
		matrix._m[2,0] = (_m[1,0]*_m[2,1]*_m[3,3] + _m[1,1]*_m[2,3]*_m[3,0] + _m[1,3]*_m[2,0]*_m[3,1] - _m[1,0]*_m[2,3]*_m[3,1] - _m[1,1]*_m[2,0]*_m[3,3] - _m[1,3]*_m[2,1]*_m[3,0])*d
		matrix._m[2,1] = (_m[0,0]*_m[2,3]*_m[3,1] + _m[0,1]*_m[2,0]*_m[3,3] + _m[0,3]*_m[2,1]*_m[3,0] - _m[0,0]*_m[2,1]*_m[3,3] - _m[0,1]*_m[2,3]*_m[3,0] - _m[0,3]*_m[2,0]*_m[3,1])*d
		matrix._m[2,2] = (_m[0,0]*_m[1,1]*_m[3,3] + _m[0,1]*_m[1,3]*_m[3,0] + _m[0,3]*_m[1,0]*_m[3,1] - _m[0,0]*_m[1,3]*_m[3,1] - _m[0,1]*_m[1,0]*_m[3,3] - _m[0,3]*_m[1,1]*_m[3,0])*d
		matrix._m[2,3] = (_m[0,0]*_m[1,3]*_m[2,1] + _m[0,1]*_m[1,0]*_m[2,3] + _m[0,3]*_m[1,1]*_m[2,0] - _m[0,0]*_m[1,1]*_m[2,3] - _m[0,1]*_m[1,3]*_m[2,0] - _m[0,3]*_m[1,0]*_m[2,1])*d
		matrix._m[3,0] = (_m[1,0]*_m[2,2]*_m[3,1] + _m[1,1]*_m[2,0]*_m[3,2] + _m[1,2]*_m[2,1]*_m[3,0] - _m[1,0]*_m[2,1]*_m[3,2] - _m[1,1]*_m[2,2]*_m[3,0] - _m[1,2]*_m[2,0]*_m[3,1])*d
		matrix._m[3,1] = (_m[0,0]*_m[2,1]*_m[3,2] + _m[0,1]*_m[2,2]*_m[3,0] + _m[0,2]*_m[2,0]*_m[3,1] - _m[0,0]*_m[2,2]*_m[3,1] - _m[0,1]*_m[2,0]*_m[3,2] - _m[0,2]*_m[2,1]*_m[3,0])*d
		matrix._m[3,2] = (_m[0,0]*_m[1,2]*_m[3,1] + _m[0,1]*_m[1,0]*_m[3,2] + _m[0,2]*_m[1,1]*_m[3,0] - _m[0,0]*_m[1,1]*_m[3,2] - _m[0,1]*_m[1,2]*_m[3,0] - _m[0,2]*_m[1,0]*_m[3,1])*d
		matrix._m[3,3] = (_m[0,0]*_m[1,1]*_m[2,2] + _m[0,1]*_m[1,2]*_m[2,0] + _m[0,2]*_m[1,0]*_m[2,1] - _m[0,0]*_m[1,2]*_m[2,1] - _m[0,1]*_m[1,0]*_m[2,2] - _m[0,2]*_m[1,1]*_m[2,0])*d
		
		Return matrix
	End Method

	Method Multiply(mat:TMatrix)
	
		Local m00# = grid#[0,0]*mat.grid#[0,0] + grid#[1,0]*mat.grid#[0,1] + grid#[2,0]*mat.grid#[0,2] + grid#[3,0]*mat.grid#[0,3]
		Local m01# = grid#[0,1]*mat.grid#[0,0] + grid#[1,1]*mat.grid#[0,1] + grid#[2,1]*mat.grid#[0,2] + grid#[3,1]*mat.grid#[0,3]
		Local m02# = grid#[0,2]*mat.grid#[0,0] + grid#[1,2]*mat.grid#[0,1] + grid#[2,2]*mat.grid#[0,2] + grid#[3,2]*mat.grid#[0,3]
		'Local m03# = grid#[0,3]*mat.grid#[0,0] + grid#[1,3]*mat.grid#[0,1] + grid#[2,3]*mat.grid#[0,2] + grid#[3,3]*mat.grid#[0,3]
		Local m10# = grid#[0,0]*mat.grid#[1,0] + grid#[1,0]*mat.grid#[1,1] + grid#[2,0]*mat.grid#[1,2] + grid#[3,0]*mat.grid#[1,3]
		Local m11# = grid#[0,1]*mat.grid#[1,0] + grid#[1,1]*mat.grid#[1,1] + grid#[2,1]*mat.grid#[1,2] + grid#[3,1]*mat.grid#[1,3]
		Local m12# = grid#[0,2]*mat.grid#[1,0] + grid#[1,2]*mat.grid#[1,1] + grid#[2,2]*mat.grid#[1,2] + grid#[3,2]*mat.grid#[1,3]
		'Local m13# = grid#[0,3]*mat.grid#[1,0] + grid#[1,3]*mat.grid#[1,1] + grid#[2,3]*mat.grid#[1,2] + grid#[3,3]*mat.grid#[1,3]
		Local m20# = grid#[0,0]*mat.grid#[2,0] + grid#[1,0]*mat.grid#[2,1] + grid#[2,0]*mat.grid#[2,2] + grid#[3,0]*mat.grid#[2,3]
		Local m21# = grid#[0,1]*mat.grid#[2,0] + grid#[1,1]*mat.grid#[2,1] + grid#[2,1]*mat.grid#[2,2] + grid#[3,1]*mat.grid#[2,3]
		Local m22# = grid#[0,2]*mat.grid#[2,0] + grid#[1,2]*mat.grid#[2,1] + grid#[2,2]*mat.grid#[2,2] + grid#[3,2]*mat.grid#[2,3]
		'Local m23# = grid#[0,3]*mat.grid#[2,0] + grid#[1,3]*mat.grid#[2,1] + grid#[2,3]*mat.grid#[2,2] + grid#[3,3]*mat.grid#[2,3]
		Local m30# = grid#[0,0]*mat.grid#[3,0] + grid#[1,0]*mat.grid#[3,1] + grid#[2,0]*mat.grid#[3,2] + grid#[3,0]*mat.grid#[3,3]
		Local m31# = grid#[0,1]*mat.grid#[3,0] + grid#[1,1]*mat.grid#[3,1] + grid#[2,1]*mat.grid#[3,2] + grid#[3,1]*mat.grid#[3,3]
		Local m32# = grid#[0,2]*mat.grid#[3,0] + grid#[1,2]*mat.grid#[3,1] + grid#[2,2]*mat.grid#[3,2] + grid#[3,2]*mat.grid#[3,3]
		'Local m33# = grid#[0,3]*mat.grid#[3,0] + grid#[1,3]*mat.grid#[3,1] + grid#[2,3]*mat.grid#[3,2] + grid#[3,3]*mat.grid#[3,3]
	
		grid[0,0]=m00
		grid[0,1]=m01
		grid[0,2]=m02
		'grid[0,3]=m03
		grid[1,0]=m10
		grid[1,1]=m11
		grid[1,2]=m12
		'grid[1,3]=m13
		grid[2,0]=m20
		grid[2,1]=m21
		grid[2,2]=m22
		'grid[2,3]=m23
		grid[3,0]=m30
		grid[3,1]=m31
		grid[3,2]=m32
		'grid[3,3]=m33
		
	End Method

	Method Translate(x#,y#,z#)
	
		grid[3,0] = grid#[0,0]*x# + grid#[1,0]*y# + grid#[2,0]*z# + grid#[3,0]
		grid[3,1] = grid#[0,1]*x# + grid#[1,1]*y# + grid#[2,1]*z# + grid#[3,1]
		grid[3,2] = grid#[0,2]*x# + grid#[1,2]*y# + grid#[2,2]*z# + grid#[3,2]

	End Method
		
	Method Scale(x#,y#,z#)
	
		grid[0,0] = grid#[0,0]*x#
		grid[0,1] = grid#[0,1]*x#
		grid[0,2] = grid#[0,2]*x#

		grid[1,0] = grid#[1,0]*y#
		grid[1,1] = grid#[1,1]*y#
		grid[1,2] = grid#[1,2]*y#

		grid[2,0] = grid#[2,0]*z#
		grid[2,1] = grid#[2,1]*z#
		grid[2,2] = grid#[2,2]*z# 
	
	End Method
	
	Method Rotate(rx#,ry#,rz#)
	
		Local cos_ang#,sin_ang#
	
		' yaw
	
		cos_ang#=Cos(ry#)
		sin_ang#=Sin(ry#)
	
		Local m00# = grid#[0,0]*cos_ang + grid#[2,0]*-sin_ang#
		Local m01# = grid#[0,1]*cos_ang + grid#[2,1]*-sin_ang#
		Local m02# = grid#[0,2]*cos_ang + grid#[2,2]*-sin_ang#

		grid[2,0] = grid#[0,0]*sin_ang# + grid#[2,0]*cos_ang
		grid[2,1] = grid#[0,1]*sin_ang# + grid#[2,1]*cos_ang
		grid[2,2] = grid#[0,2]*sin_ang# + grid#[2,2]*cos_ang

		grid[0,0]=m00#
		grid[0,1]=m01#
		grid[0,2]=m02#
		
		' pitch
		
		cos_ang#=Cos(rx#)
		sin_ang#=Sin(rx#)
	
		Local m10# = grid#[1,0]*cos_ang + grid#[2,0]*sin_ang
		Local m11# = grid#[1,1]*cos_ang + grid#[2,1]*sin_ang
		Local m12# = grid#[1,2]*cos_ang + grid#[2,2]*sin_ang

		grid[2,0] = grid#[1,0]*-sin_ang + grid#[2,0]*cos_ang
		grid[2,1] = grid#[1,1]*-sin_ang + grid#[2,1]*cos_ang
		grid[2,2] = grid#[1,2]*-sin_ang + grid#[2,2]*cos_ang

		grid[1,0]=m10
		grid[1,1]=m11
		grid[1,2]=m12
		
		' roll
		
		cos_ang#=Cos(rz#)
		sin_ang#=Sin(rz#)

		m00# = grid#[0,0]*cos_ang# + grid#[1,0]*sin_ang#
		m01# = grid#[0,1]*cos_ang# + grid#[1,1]*sin_ang#
		m02# = grid#[0,2]*cos_ang# + grid#[1,2]*sin_ang#

		grid[1,0] = grid#[0,0]*-sin_ang# + grid#[1,0]*cos_ang#
		grid[1,1] = grid#[0,1]*-sin_ang# + grid#[1,1]*cos_ang#
		grid[1,2] = grid#[0,2]*-sin_ang# + grid#[1,2]*cos_ang#

		grid[0,0]=m00#
		grid[0,1]=m01#
		grid[0,2]=m02#
	
	End Method
	
	Method RotatePitch(ang#)
	
		Local cos_ang#=Cos(ang#)
		Local sin_ang#=Sin(ang#)
	
		Local m10# = grid#[1,0]*cos_ang + grid#[2,0]*sin_ang
		Local m11# = grid#[1,1]*cos_ang + grid#[2,1]*sin_ang
		Local m12# = grid#[1,2]*cos_ang + grid#[2,2]*sin_ang

		grid[2,0] = grid#[1,0]*-sin_ang + grid#[2,0]*cos_ang
		grid[2,1] = grid#[1,1]*-sin_ang + grid#[2,1]*cos_ang
		grid[2,2] = grid#[1,2]*-sin_ang + grid#[2,2]*cos_ang

		grid[1,0]=m10
		grid[1,1]=m11
		grid[1,2]=m12

	End Method
	
	Method RotateYaw(ang#)
	
		Local cos_ang#=Cos(ang#)
		Local sin_ang#=Sin(ang#)
	
		Local m00# = grid#[0,0]*cos_ang + grid#[2,0]*-sin_ang#
		Local m01# = grid#[0,1]*cos_ang + grid#[2,1]*-sin_ang#
		Local m02# = grid#[0,2]*cos_ang + grid#[2,2]*-sin_ang#

		grid[2,0] = grid#[0,0]*sin_ang# + grid#[2,0]*cos_ang
		grid[2,1] = grid#[0,1]*sin_ang# + grid#[2,1]*cos_ang
		grid[2,2] = grid#[0,2]*sin_ang# + grid#[2,2]*cos_ang

		grid[0,0]=m00#
		grid[0,1]=m01#
		grid[0,2]=m02#

	End Method
	
	Method RotateRoll(ang#)
	
		Local cos_ang#=Cos(ang#)
		Local sin_ang#=Sin(ang#)

		Local m00# = grid#[0,0]*cos_ang# + grid#[1,0]*sin_ang#
		Local m01# = grid#[0,1]*cos_ang# + grid#[1,1]*sin_ang#
		Local m02# = grid#[0,2]*cos_ang# + grid#[1,2]*sin_ang#

		grid[1,0] = grid#[0,0]*-sin_ang# + grid#[1,0]*cos_ang#
		grid[1,1] = grid#[0,1]*-sin_ang# + grid#[1,1]*cos_ang#
		grid[1,2] = grid#[0,2]*-sin_ang# + grid#[1,2]*cos_ang#

		grid[0,0]=m00#
		grid[0,1]=m01#
		grid[0,2]=m02#

	End Method
		
End Type
