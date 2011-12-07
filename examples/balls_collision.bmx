Import "../minib3d.bmx"

Strict

Local width=640,height=480,depth=16,mode=0,hertz=60

Graphics3D width,height,depth,mode,hertz

' bullet type
Type TBullet

	Global list:TList=CreateList()
	Global no ' no of bullets
	Field ent:TMesh
	Field x#,y#,z#
	Field vx#,vy#,vz#
	Field life ' life counter
	
	' create bullet
	Function Shoot(x#,y#,z#,nx#,ny#,nz#)
	
		Local bull:TBullet=New TBullet
		no=no+1
		bull.ent=CreateSphere()
		EntityColor bull.ent,64+Rand(191),64+Rand(191),64+Rand(191)
		bull.x#=x#
		bull.y#=y#
		bull.z#=z#
		bull.vx#=nx#
		bull.vy#=ny#
		bull.vz#=nz#
		PositionEntity bull.ent,x#,y#,z#,True
		EntityType bull.ent,1
		EntityRadius bull.ent,1
		ResetEntity bull.ent
		ListAddLast(list,bull)

	End Function
	
	' update bullet
	Method Update()
	 
		' life counter is over 600, so bullet hasn't collided with anything for a long time - free it
		If life>600
			ListRemove list,Self
			FreeEntity ent
			no=no-1
			Return
		EndIf
		
		life=life+1 ' increase bullet life counter
	
		x#=EntityX(ent)
		y#=EntityY(ent)
		z#=EntityZ(ent)
	
		' check to see if the entity collided with the level
		Local entity_hit = CountCollisions(ent)

		' if the entity collided with the level, make it bounce
		If entity_hit
	
			' bullet has collided with level - reset life counter
			life=0

			' get the normal of the surface which the entity collided with
			Local nx# = CollisionNX#(ent,1)
			Local ny# = CollisionNY#(ent,1)
			Local nz# = CollisionNZ#(ent,1)

			' compute the dot product of the entity's motion vector and the normal of the surface collided with
			Local vdotn# = vx#*nx# + vy#*ny# + vz#*nz#
			
			' calculate the normal force
			Local nfx# = -2.0 * nx# * vdotn#
			Local nfy# = -2.0 * ny# * vdotn# 
			Local nfz# = -2.0 * nz# * vdotn#

			' add the normal force to the direction vector. 
			vx# = vx# + nfx#
			vy# = vy# + nfy#
			vz# = vz# + nfz#

		EndIf
		
		' apply gravity
		Local GRAVITY#=0.01
		vy#=vy#-GRAVITY#

		' update position values
	
		x#=x#+vx#
		y#=y#+vy#
		z#=z#+vz#
			
		PositionEntity ent,x#,y#,z#
	
	End Method
	
End Type

Local cam:TCamera=CreateCamera()
PositionEntity cam,0,10,-10
CameraRange cam,.5,500

Local light:TLight=CreateLight(1)
RotateEntity light,90,0,0

Local mesh:TMesh=LoadMesh("media/test.b3d")

ScaleMesh mesh,10,10,10

' set collision radius and types
EntityRadius cam,1,1
EntityType cam,1
EntityType mesh,2

' enable collisions
Collisions 1,2,2,2

' used by fps code
Local old_ms=MilliSecs()
Local renders
Local fps

While Not KeyDown(KEY_ESCAPE)		

	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)*2-KeyDown(KEY_UP)*2,KeyDown(KEY_LEFT)*2-KeyDown(KEY_RIGHT)*2,0

	' shoot bullet
	If KeyHit(KEY_SPACE)
	
		TFormNormal 0,0,0.05,cam,Null
	
		TBullet.Shoot(EntityX#(cam,True),EntityY#(cam,True),EntityZ#(cam,True),TFormedX(),TFormedY(),TFormedZ())

	EndIf
	
	' update bullets
	For Local bull:TBullet=EachIn TBullet.list
		bull.Update()
	Next

	UpdateWorld
	RenderWorld
	
	renders=renders+1

	' calculate fps
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,0,"FPS: "+String(fps)
	Text 0,20,"Press space to shoot a bullet"
	Text 0,40,"No. of bullets: "+TBullet.no

	Flip
	
Wend

End