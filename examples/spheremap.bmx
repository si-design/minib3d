Import "../minib3d.bmx"

strict

Local width=640,height=480,depth=16,mode=0

Graphics3D width,height,depth,mode

Local cam:TCamera=CreateCamera()
PositionEntity cam,0,0,-3

Local light:TLight=CreateLight()
RotateEntity light,90,0,0

' load object we will apply spheremap to - the classic teapot
Local teapot:TMesh=LoadMesh("media/teapot.b3d")

' load texture with color + spherical environment map
Local tex:TTexture=LoadTexture("media/spheremap.bmp",1+64)

' apply spherical environment map to teapot
EntityTexture teapot,tex

' used by fps code
Local old_ms=MilliSecs()
Local renders
Local fps

While Not KeyDown(KEY_ESCAPE)

	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	TurnEntity teapot,0,1,0

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