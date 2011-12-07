Import "../minib3d.bmx"

Strict

Local width=640,height=480,depth=16,mode=0

Graphics3D width,height,depth,mode
AmbientLight 32,32,32

Local cam:TCamera=CreateCamera()
PositionEntity cam,0,0,-60

Local light:TLight=CreateLight(2)
LightColor light,255,0,0
LightRange light,5

Local ent1:TMesh=LoadAnimMesh("media/grid.b3d")
Local ent2:TMesh=TMesh(CopyEntity(ent1))

PositionEntity ent1,0,10,0
PositionEntity ent2,0,-10,0

RotateEntity ent1,180,0,0

Local ent3:TMesh=CreateSphere()
Local ent4:TMesh=CreateSphere()

PositionEntity ent3,-10,0,0
PositionEntity ent4,10,0,0

ScaleEntity ent3,4,4,4
ScaleEntity ent4,4,4,4

' used by fps code
Local old_ms=MilliSecs()
Local renders
Local fps

While Not KeyDown(KEY_ESCAPE)		

	If KeyHit(KEY_ENTER) Then DebugStop

	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
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