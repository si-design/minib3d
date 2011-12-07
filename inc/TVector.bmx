Type TVector

	Field x#,y#,z#
	
	Const EPSILON:Float=.0001

	Method New()
	
		If LOG_NEW
			DebugLog "New TVector"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TVector"
		EndIf
	
	End Method

	Function Create:TVector(x#,y#,z#)
	
		Local vec:TVector=New TVector
		vec.x=x
		vec.y=y
		vec.z=z
		
		Return vec
		
	End Function
	
	Method Copy:TVector()
	
		Local vec:TVector=New TVector
	
		vec.x=x
		vec.y=y
		vec.z=z
	
		Return vec
	
	End Method
	
	Method Add:TVector(vec:TVector)
	
		Local new_vec:TVector=New TVector
		
		new_vec.x=x+vec.x
		new_vec.y=y+vec.y
		new_vec.z=z+vec.z
		
		Return new_vec
	
	End Method
	
	Method Subtract:TVector(vec:TVector)
	
		Local new_vec:TVector=New TVector
		
		new_vec.x=x-vec.x
		new_vec.y=y-vec.y
		new_vec.z=z-vec.z
		
		Return new_vec
	
	End Method
	
	Method Multiply:TVector(val#)
	
		Local new_vec:TVector=New TVector
		
		new_vec.x=x*val#
		new_vec.y=y*val#
		new_vec.z=z*val#
		
		Return new_vec
	
	End Method
	
	Method Divide:TVector(val#)
	
		Local new_vec:TVector=New TVector
		
		new_vec.x=x/val#
		new_vec.y=y/val#
		new_vec.z=z/val#
		
		Return new_vec
	
	End Method
	
	Method Dot:Float(vec:TVector)
	
		Return (x#*vec.x#)+(y#*vec.y#)+(z#*vec.z#)
	
	End Method
	
	Method Cross:TVector(vec:TVector)
	
		Local new_vec:TVector=New TVector
		
		new_vec.x=(y*vec.z)-(z*vec.y)
		new_vec.y=(z*vec.x)-(x*vec.z)
		new_vec.z=(x*vec.y)-(y*vec.x)
		
		Return new_vec
	
	End Method
	
	Method Normalize()
	
		Local d#=1/Sqr(x*x+y*y+z*z)
		x:*d
		y:*d
		z:*d
		
	End Method
	
	Method Length#()
			
		Return Sqr(x*x+y*y+z*z)

	End Method
	
	Method SquaredLength#()
	
		Return x*x+y*y+z*z

	End Method
	
	Method SetLength#(val#)
	
		Normalize()
		x=x*val
		y=y*val
		z=z*val

	End Method
	
	Method Compare:int( with:Object )
		Local q:TVector=TVector(with)
		If x-q.x>EPSILON Return 1
		If q.x-x>EPSILON Return -1
		If y-q.y>EPSILON Return 1
		If q.y-y>EPSILON Return -1
		If z-q.z>EPSILON Return 1
		If q.z-z>EPSILON Return -1
		Return 0
	End Method

	' Function by patmaba
	Function VectorYaw#(vx#,vy#,vz#)

		Return ATan2(-vx#,vz#)
	
	End Function

	' Function by patmaba
	Function VectorPitch#(vx#,vy#,vz#)

		Local ang#=ATan2(Sqr(vx#*vx#+vz#*vz#),vy#)-90.0

		If ang#<=0.0001 And ang#>=-0.0001 Then ang#=0
	
		Return ang#
	
	End Function

End Type
