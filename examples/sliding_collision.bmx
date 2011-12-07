Import "../minib3d.bmx"

Strict

Local width=640,height=480,depth=16,mode=0

Graphics3D width,height,depth,mode

Local cam:TCamera=CreateCamera()
CameraRange cam,.5,500
PositionEntity cam,0,10,-10

Local light:TLight=CreateLight(1)
RotateEntity light,90,0,0

Local mesh:TMesh=LoadMesh("media/test.b3d")
ScaleEntity mesh,10,10,10

' set camera entity type to 1
EntityType cam,1

' set camera radius as it's the source collision entity
EntityRadius cam,1

' set mesh entity type to 2
EntityType mesh,2

' use collisions command to enable collisons between entity type 1 and 2, with method 2 and reponse 2
Collisions 1,2,2,2

' used by fps code
Local old_ms=MilliSecs()
Local renders
Local fps

While Not KeyDown(KEY_ESCAPE)		

	If KeyHit(KEY_ENTER) Then DebugStop

	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)*2-KeyDown(KEY_UP)*2,KeyDown(KEY_LEFT)*2-KeyDown(KEY_RIGHT)*2,0

	UpdateWorld
	RenderWorld

	renders=renders+1

	' calculate fps
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf

	Text 0,0,"FPS: "+fps

	Flip
	
Wend
End