' Original firepaint3d.bb program by Mark Sibly

Import "../../minib3d.bmx"

width=640;height=480;depth=16;mode=0

Graphics3D width,height,depth,mode

AmbientLight 0,0,0

Const grav#=-.02,intensity=5

Type Frag
	Field ys#,alpha#,entity
End Type

fraglist:TList=CreateList()

pivot=CreatePivot()

camera=CreateCamera(pivot)
CameraClsMode camera,False,True

camera2=CreateCamera(pivot)
RotateEntity camera2,90,0,0
CameraViewport camera2,0,0,100,100

'create blitzlogo 'cursor'
cursor=CreateSphere(8,camera)
EntityTexture cursor,LoadTexture("media/blitzlogo.bmp")
MoveEntity cursor,0,0,25
EntityBlend cursor,3
EntityFX cursor,1

'create sky sphere
sky=CreateSphere()
tex=LoadTexture( "media/stars.bmp" )
ScaleTexture tex,.125,.25
EntityTexture sky,tex
ScaleEntity sky,500,500,500
EntityFX sky,1
FlipMesh sky

spark=LoadSprite("media/bluspark.bmp")

time=MilliSecs()

' used by fps code
Local old_ms=MilliSecs()
Local renders
Local fps

MoveMouse 0,0

While Not KeyDown(KEY_ESCAPE)

	Repeat
		elapsed=MilliSecs()-time
	Until elapsed>0
	
	time=time+elapsed
	dt#=elapsed*60.0/1000.0
	
	Local x_speed#,y_speed#
	
	x_speed=((MouseX()-320)-x_speed)/4+x_speed
	y_speed=((MouseY()-240)-y_speed)/4+y_speed
	MoveMouse 320,240

	TurnEntity pivot,0,-x_speed,0	'turn player Left/Right
	TurnEntity camera,-y_speed,0,0	'tilt camera
	TurnEntity cursor,0,dt*5,0
	
	If MouseDown(1)
		For t=1 To intensity
			f:Frag=New Frag
			f.ys=0
			f.alpha=Rnd(2,3)
			f.entity=CopyEntity( spark,cursor )
			ShowEntity f.entity
			EntityColor f.entity,Rnd(255),Rnd(255),Rnd(255)
			EntityParent f.entity,0
			RotateEntity f.entity,Rnd(360),Rnd(360),Rnd(360)
			num=num+1
			ListAddLast(fraglist,f)
		Next
	EndIf
	
	n_parts=0
	n_surfs=0
	For f:Frag=EachIn Fraglist
		f.alpha=f.alpha-dt*.02
		If f.alpha>0
			al#=f.alpha
			If al>1 Then al=1
			EntityAlpha f.entity,al
			MoveEntity f.entity,0,0,dt*.4
			ys#=f.ys+grav*dt
			dy#=f.ys*dt
			f.ys=ys
			TranslateEntity f.entity,0,dy,0
		Else
			FreeEntity f.entity
			ListRemove(fraglist,f)
			num=num-1
		EndIf
	Next
	
	RenderWorld
	renders=renders+1

	' calculate fps
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,0,"FPS: "+String(fps)

	Flip
Wend

End