Import "../minib3d.bmx"

Strict

Local width=640,height=480,depth=16,mode=0

Graphics3D width,height,depth,mode

Local cam:TCamera=CreateCamera()
PositionEntity cam,0,0,-5

Local light:TLight=CreateLight(1)

Local tex:TTexture=LoadTexture("media/test.png")

Local cube:TMesh=CreateCube()
Local sphere:TMesh=CreateSphere()
Local cylinder:TMesh=CreateCylinder()
Local cone:TMesh=CreateCone() 

PositionEntity cube,-3,0,0
PositionEntity sphere,-1,0,0
PositionEntity cylinder,1,0,0
PositionEntity cone,3,0,0

EntityTexture cube,tex
EntityTexture sphere,tex
EntityTexture cylinder,tex
EntityTexture cone,tex

' used by fps code
Local old_ms=MilliSecs()
Local renders
Local fps

Local aa

While Not KeyDown(KEY_ESCAPE)		

	If KeyHit(KEY_ENTER) Then DebugStop

	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
		
	If KeyHit(KEY_MINUS)
	
		aa=aa-1
		If aa=-1 Then aa=16
		If aa=15 Then aa=12
		If aa=11 Then aa=9
		If aa=7 Then aa=6
		If aa=1 Then aa=0
		AntiAlias aa
	
	EndIf
	
	If KeyHit(KEY_EQUALS)
	
		aa=aa+1
		If aa=1 Then aa=2
		If aa=7 Then aa=9
		If aa=10 Then aa=12
		If aa=13 Then aa=16
		If aa=17 Then aa=0
		AntiAlias aa
	
	EndIf
	
	TurnEntity cube,0,1,0

	RenderWorld
	renders=renders+1

	;' calculate fps
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,0,"FPS: "+fps
	Text 0,20,"+/- to change AA value"
	Text 0,40,"AntiAlias "+aa

	Flip

Wend
End