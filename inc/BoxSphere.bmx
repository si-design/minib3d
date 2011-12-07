' p=point
' b=box
Function BoxFromPoints(	px1:Float,py1:Float,pz1:Float,..
						px2:Float,py2:Float,pz2:Float,..
						bx1:Float Var,by1:Float Var,bz1:Float Var,..
						bx2:Float Var,by2:Float Var,bz2:Float Var)

	' calculate bounding box that encloses points 1 and 2
	If px1<px2
		bx1=px1
		bx2=px2
	Else
		bx1=px2
		bx2=px1
	EndIf
	If py1<py2
		by1=py1
		by2=py2
	Else
		by1=py2
		by2=py1
	EndIf
	If pz1<pz2
		bz1=pz1
		bz2=pz2
	Else
		bz1=pz2
		bz2=pz1
	EndIf
	
End Function

' t=triangle
' b=box
Function BoxFromTri(tx1:Float,ty1:Float,tz1:Float,..
					tx2:Float,ty2:Float,tz2:Float,..
					tx3:Float,ty3:Float,tz3:Float,..
					bx1:Float Var,by1:Float Var,bz1:Float Var,..
					bx2:Float Var,by2:Float Var,bz2:Float Var)

	bx1=1000000;by1=1000000;bz1=1000000
	bx2=-1000000;by2=-1000000;bz2=-1000000

	If tx1<bx1 Then bx1=tx1
	If ty1<by1 Then by1=ty1
	If tz1<bz1 Then bz1=tz1

	If tx2<bx1 Then bx1=tx2
	If ty2<by1 Then by1=ty2
	If tz2<bz1 Then bz1=tz2
	
	If tx3<bx1 Then bx1=tx3
	If ty3<by1 Then by1=ty3
	If tz3<bz1 Then bz1=tz3

	If tx1>bx2 Then bx2=tx1
	If ty1>by2 Then by2=ty1
	If tz1>bz2 Then bz2=tz1

	If tx2>bx2 Then bx2=tx2
	If ty2>by2 Then by2=ty2
	If tz2>bz2 Then bz2=tz2
	
	If tx3>bx2 Then bx2=tx3
	If ty3>by2 Then by2=ty3
	If tz3>bz2 Then bz2=tz3
	
End Function
	
' a=box a
' b=box b
Function BoxBoxIntersection:Int(ax1:Float,ay1:Float,az1:Float,ax2:Float,ay2:Float,az2:Float,..
							bx1:Float,by1:Float,bz1:Float,bx2:Float,by2:Float,bz2:Float)

	If ax2<bx1 Or ax1>bx2 Return 0
	If ay2<by1 Or ay1>by2 Return 0
	If az2<bz1 Or az1>bz2 Return 0
	
	Return True

End Function
	
Function BoxSphereIntersection:int(	x1:Float,y1:Float,z1:Float,x2:Float,y2:Float,z2:Float,..
								sx:Float,sy:Float,sz:Float,sr:Float)

	Local dmin#=0
	Local sr2:Float=sr*sr
	
	' x axis
	If sx<x1

		dmin=dmin+(sx-x1)*(sx-x1)
		
	Else If sx>x2

		dmin=dmin+(sx-x2)*(sx-x2)

	EndIf

	' y axis
	If sy<y1

		dmin=dmin+(sy-y1)*(sy-y1)
		
	Else If sy>y2

		dmin=dmin+(sy-y2)*(sy-y2)

	EndIf

	' z axis
	If sz<z1

		dmin=dmin+(sz-z1)*(sz-z2)

	Else If sz>x2

		dmin=dmin+(sz-z2)*(sz-z2)

	EndIf

	If dmin#<=sr2# Then Return True Else Return False

End Function
