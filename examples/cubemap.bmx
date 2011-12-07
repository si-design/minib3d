Import "../minib3d.bmx"

Strict

Local width=640,height=480,depth=16,mode=0

Graphics3D width,height,depth,mode

Local cam:TCamera=CreateCamera()
PositionEntity cam,0,10,-10

' create separate camera for updating cube map - this allows us fo manipulate main camera and cube camera which avoids any confusion
Local cube_cam:TCamera=CreateCamera()
HideEntity cube_cam

Local light:TLight=CreateLight()
RotateEntity light,90,0,0

' load object we will apply cubemap to - the classic teapot
Local teapot:TMesh=LoadMesh("media/teapot.b3d")
ScaleEntity teapot,3,3,3
PositionEntity teapot,0,10,0

' create some scenery

' ground
Local ground:TMesh=LoadMesh("media/grid.b3d")
ScaleEntity ground,1000,1,1000
EntityColor ground,168,133,55
Local ground_tex:TTexture=LoadTexture("media/sand.bmp")
ScaleTexture ground_tex,0.001,0.001
EntityTexture ground,ground_tex

' sky
Local sky:TMesh=CreateSphere(24)
ScaleEntity sky,500,500,500
FlipMesh sky
EntityFX sky,1
Local sky_tex:TTexture=LoadTexture("media/sky.bmp")
EntityTexture sky,sky_tex

' cactus
Local cactus:TMesh=LoadMesh("media/cactus2.b3d")
FitMesh cactus,-5,0,0,2,6,.5

' camel
Local camel:TMesh=LoadMesh("media/camel.b3d")
FitMesh camel,5,0,0,6,5,4

'

' load ufo to give us a dynamic moving object that the cubemap will be able to reflect
Local ufo_piv:TPivot=CreatePivot()
PositionEntity ufo_piv,0,15,0
Local ufo:TMesh=LoadMesh("media/green_ufo.b3d",ufo_piv)
PositionEntity ufo,0,0,10

' create texture with color + cubic environment map
Local tex:TTexture=CreateTexture(256,256,1+128)

' apply cubic environment map to teapot
EntityTexture teapot,tex,0,0

' set initial cube mode value
Local cube_mode=1

' used by fps code
Local old_ms=MilliSecs()
Local renders
Local fps

While Not KeyDown(KEY_ESCAPE)

	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	' If M key pressed then change cube mode
	If KeyHit(KEY_M)
		cube_mode=cube_mode+1
		If cube_mode=3 Then cube_mode=1
		SetCubeMode tex,cube_mode
	EndIf
	
	' turn ufo pivot, causing child ufo mesh to spin around it (and teapot)
	TurnEntity ufo_piv,0,2,0

	' hide our main camera before updating cube map - we don;'t need it to be rendererd every time cube_cam is rendered
	HideEntity cam

	' update cubemap
	UpdateCubemap(tex,cube_cam,teapot)

	' show main camera again
	ShowEntity cam

	RenderWorld
	renders=renders+1
	
	' calculate fps
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,0,""
	Text 0,0,"FPS: "+fps
	Text 0,20,"Press M to change cube mode"
	Text 0,40,"SetCubeMode tex,"+cube_mode

	Flip

Wend

Function UpdateCubemap(tex:TTexture,camera:TCamera,entity:TEntity)

	Local tex_sz=256'TextureWidth(tex)

	' show the camera we have specifically created for updating the cubemap
	ShowEntity camera
	
	' hide entity that will have cubemap applied To it. This is so we can get cubemap from its position, without it blocking the view
	HideEntity entity

	' position camera where the entity is - this is where we will be rendering views from for cubemap
	PositionEntity camera,EntityX#(entity),EntityY#(entity),EntityZ#(entity)

	CameraClsMode camera,False,True
	
	' set the camera;'s viewport so it is the same size as our texture - so we can fit entire screen contents into texture
	CameraViewport camera,0,0,tex_sz,tex_sz

	' update cubemap

	' do left view	
	SetCubeFace tex,0
	RotateEntity camera,0,90,0
	RenderWorld
	BackBufferToTex(tex) ;' bmx
	'CopyRect 0,0,tex_sz,tex_sz,0,0,BackBuffer(),TextureBuffer(tex) ;' bb
	
	' do forward view
	SetCubeFace tex,1
	RotateEntity camera,0,0,0
	RenderWorld
	BackBufferToTex(tex) ;' bmx
	'CopyRect 0,0,tex_sz,tex_sz,0,0,BackBuffer(),TextureBuffer(tex) ;' bb
	
	' do right view	
	SetCubeFace tex,2
	RotateEntity camera,0,-90,0
	RenderWorld
	BackBufferToTex(tex) ;' bmx
	'CopyRect 0,0,tex_sz,tex_sz,0,0,BackBuffer(),TextureBuffer(tex) ;' bb
	
	' do backward view
	SetCubeFace tex,3
	RotateEntity camera,0,180,0
	RenderWorld
	BackBufferToTex(tex) ;' bmx
	'CopyRect 0,0,tex_sz,tex_sz,0,0,BackBuffer(),TextureBuffer(tex) ;' bb
	
	' do up view
	SetCubeFace tex,4
	RotateEntity camera,-90,0,0
	RenderWorld
	BackBufferToTex(tex) ;' bmx
	'CopyRect 0,0,tex_sz,tex_sz,0,0,BackBuffer(),TextureBuffer(tex) ;' bb
	
	' do down view
	SetCubeFace tex,5
	RotateEntity camera,90,0,0
	RenderWorld
	BackBufferToTex(tex) ;' bmx
	'CopyRect 0,0,tex_sz,tex_sz,0,0,BackBuffer(),TextureBuffer(tex) ;' bb
	
	'
	
	' show entity again
	ShowEntity entity
	
	' hide the cubemap camera
	HideEntity camera
	
End Function
