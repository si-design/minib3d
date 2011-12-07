Type TQuaternion

	Field w#,x#,y#,z#

	Method New()
	
		If LOG_NEW
			DebugLog "New TQuaternion"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TQuaternion"
		EndIf
	
	End Method

	Function QuatToMat(w#,x#,y#,z#,mat:TMatrix Var)
	
		Local q:Float[4]
		q[0]=w
		q[1]=x
		q[2]=y
		q[3]=z
		
		Local xx#=q[1]*q[1]
		Local yy#=q[2]*q[2]
		Local zz#=q[3]*q[3]
		Local xy#=q[1]*q[2]
		Local xz#=q[1]*q[3]
		Local yz#=q[2]*q[3]
		Local wx#=q[0]*q[1]
		Local wy#=q[0]*q[2]
		Local wz#=q[0]*q[3]
	
		mat.grid[0,0]=1-2*(yy+zz)
		mat.grid[0,1]=  2*(xy-wz)
		mat.grid[0,2]=  2*(xz+wy)
		mat.grid[1,0]=  2*(xy+wz)
		mat.grid[1,1]=1-2*(xx+zz)
		mat.grid[1,2]=  2*(yz-wx)
		mat.grid[2,0]=  2*(xz-wy)
		mat.grid[2,1]=  2*(yz+wx)
		mat.grid[2,2]=1-2*(xx+yy)
		mat.grid[3,3]=1
	
		For Local iy:Int=0 To 3
			For Local ix:Int=0 To 3
				xx#=mat.grid[ix,iy]
				If xx#<0.0001 And xx#>-0.0001 Then xx#=0
				mat.grid[ix,iy]=xx#
			Next
		Next
	
	End Function
	
	Function QuatToEuler(w#,x#,y#,z#,pitch# Var,yaw# Var,roll# Var)
	
		Local q:Float[4]
		q[0]=w
		q[1]=x
		q[2]=y
		q[3]=z
		
		Local xx#=q[1]*q[1]
		Local yy#=q[2]*q[2]
		Local zz#=q[3]*q[3]
		Local xy#=q[1]*q[2]
		Local xz#=q[1]*q[3]
		Local yz#=q[2]*q[3]
		Local wx#=q[0]*q[1]
		Local wy#=q[0]*q[2]
		Local wz#=q[0]*q[3]
	
		Local mat:TMatrix=New TMatrix
		
		mat.grid[0,0]=1-2*(yy+zz)
		mat.grid[0,1]=  2*(xy-wz)
		mat.grid[0,2]=  2*(xz+wy)
		mat.grid[1,0]=  2*(xy+wz)
		mat.grid[1,1]=1-2*(xx+zz)
		mat.grid[1,2]=  2*(yz-wx)
		mat.grid[2,0]=  2*(xz-wy)
		mat.grid[2,1]=  2*(yz+wx)
		mat.grid[2,2]=1-2*(xx+yy)
		mat.grid[3,3]=1
	
		For Local iy:Int=0 To 3
			For Local ix:Int=0 To 3
				xx#=mat.grid[ix,iy]
				If xx#<0.0001 And xx#>-0.0001 Then xx#=0
				mat.grid[ix,iy]=xx#
			Next
		Next
	
		pitch#=ATan2( mat.grid[2,1],Sqr( mat.grid[2,0]*mat.grid[2,0]+mat.grid[2,2]*mat.grid[2,2] ) )
		yaw#=ATan2(mat.grid[2,0],mat.grid[2,2])
		roll#=ATan2(mat.grid[0,1],mat.grid[1,1])
				
		'If pitch#=nan# Then pitch#=0
		'If yaw#  =nan# Then yaw#  =0
		'If roll# =nan# Then roll# =0
	
	End Function
			
	Function Slerp:int(Ax#,Ay#,Az#,Aw#,Bx#,By#,Bz#,Bw#,Cx# Var,Cy# Var,Cz# Var,Cw# Var,t#)
	
		If Abs(ax-bx)<0.001 And Abs(ay-by)<0.001 And Abs(az-bz)<0.001 And Abs(aw-bw)<0.001
			cx#=ax
			cy#=ay
			cz#=az
			cw#=aw
			Return True
		EndIf
		
		Local cosineom#=Ax#*Bx#+Ay#*By#+Az#*Bz#+Aw#*Bw#
		Local scaler_w#
		Local scaler_x#
		Local scaler_y#
		Local scaler_z#
		
		If cosineom# <= 0.0
			cosineom#=-cosineom#
			scaler_w#=-Bw#
			scaler_x#=-Bx#
			scaler_y#=-By#
			scaler_z#=-Bz#
		Else
			scaler_w#=Bw#
			scaler_x#=Bx#
			scaler_y#=By#
			scaler_z#=Bz#
		EndIf
		
		Local scale0#
		Local scale1#
		
		If (1.0 - cosineom#)>0.0001
			Local omega#=ACos(cosineom#)
			Local sineom#=Sin(omega#)
			scale0#=Sin((1.0-t#)*omega#)/sineom#
			scale1#=Sin(t#*omega#)/sineom#
		Else
			scale0#=1.0-t#
			scale1#=t#
		EndIf
			
		cw#=scale0#*Aw#+scale1#*scaler_w#
		cx#=scale0#*Ax#+scale1#*scaler_x#
		cy#=scale0#*Ay#+scale1#*scaler_y#
		cz#=scale0#*Az#+scale1#*scaler_z#
		
	End Function
		
End Type

