Import "../minib3d.bmx"

Strict

Local width=640,height=480,depth=16,mode=0

Graphics3D width,height,depth,mode
ClearTextureFilters

Local cam:TCamera=CreateCamera()
CameraFogMode cam,1
CameraFogRange cam,0,1000
PositionEntity cam,0,100,-100

Local light:TLight=CreateLight(1)

Local grid:TMesh=LoadAnimMesh("media/grid.b3d")
ScaleEntity grid,100,1,100

Local tex:TTexture=LoadTexture("media/test.png")

Local cube:TMesh=CreateCube()
Local sphere:TMesh=CreateSphere()
Local cylinder:TMesh=CreateCylinder()
Local cone:TMesh=CreateCone()

PositionEntity cube,0,100,250
PositionEntity sphere,500,100,500
PositionEntity cylinder,-500,100,750
PositionEntity cone,0,100,1000

ScaleEntity cube,100,100,100
ScaleEntity sphere,100,100,100
ScaleEntity cylinder,100,100,100
ScaleEntity cone,100,100,100

EntityTexture cube,tex
EntityTexture sphere,tex
EntityTexture cylinder,tex
EntityTexture cone,tex

' used by fps code
Local old_ms=MilliSecs()
Local renders
Local fps

While Not KeyDown(KEY_ESCAPE)		

	If KeyHit(KEY_ENTER) Then DebugStop

	' control camera
	MoveEntity cam,KeyDown(KEY_D)*10-KeyDown(KEY_A)*10,0,KeyDown(KEY_W)*10-KeyDown(KEY_S)*10
	TurnEntity cam,KeyDown(KEY_DOWN)*2-KeyDown(KEY_UP)*2,KeyDown(KEY_LEFT)*2-KeyDown(KEY_RIGHT)*2,0

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