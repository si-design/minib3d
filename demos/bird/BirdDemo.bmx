' Original BirdDemo.bb program by Adam Gore

Import "bbtype.bmx"
Import "bbvkey.bmx"
Import "../../minib3d.bmx"

Include "KBSplines.bmx"

gwidth = 640
gheight = 480

fstep#=0

Graphics3D gwidth,gheight,16

cmot:bbMotion = New bbMotion
b2mot:bbMotion = New bbMotion
b1mot:bbMotion = New bbMotion

If Load_Motion( "media/Cam.bbm", cmot ) = False Then RuntimeError "Error loading file" ; End 
If Load_Motion( "media/Bird1.bbm", b1mot ) = False Then RuntimeError "Error loading file" ; End 
If Load_Motion( "media/Bird2.bbm", b2mot ) = False Then RuntimeError "Error loading file" ; End 

camera=CreateCamera()
CameraRange camera,1,3000

AmbientLight 90,90,90
light_sun = CreateLight(1)
LightColor light_sun,200,200,100
RotateEntity light_sun,60,-90,0

mesh_canyon = LoadMesh( "media/Canyon.b3d" )
RotateEntity mesh_canyon,0,180,0

mesh_skybox = MakeSkyBox("media/sky")

mesh_bird = LoadAnimMesh("media/Bird.b3d")
mesh_bird2 = CopyEntity( mesh_bird )

Apply_Motion(cmot,0,camera)
Apply_Motion(b1mot,0,mesh_bird,180)
Apply_Motion(b2mot,0,mesh_bird2,180)
fstep# = 1

' used by fps code
Local old_ms=MilliSecs()
Local renders
Local fps

While KeyHit(KEY_ESCAPE)<>True

	If KeyDown(KEY_SPACE)=False Then fstep = fstep + .25 ; anim_time#=anim_time#+0.5
	If fstep > cmot.nsteps Then fstep = 1

	SetAnimTime mesh_bird,anim_time#
	SetAnimTime mesh_bird2,anim_time#+10.0
	
	Apply_Motion(cmot,fstep,camera)
	Apply_Motion(b1mot,fstep,mesh_bird,180)
	Apply_Motion(b2mot,fstep,mesh_bird2,180)
	
	PositionEntity mesh_skybox,EntityX(camera,1),EntityY(camera,1),EntityZ(camera,1)

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

Function MakeSkyBox( file$ )

	m=CreateMesh()
	'front face
	b=LoadBrush( file$+"_FR.bmp",49 )
	s=CreateSurface( m )
	AddVertex s,-1,+1,-1,0,0;AddVertex s,+1,+1,-1,1,0
	AddVertex s,+1,-1,-1,1,1;AddVertex s,-1,-1,-1,0,1
	AddTriangle s,0,1,2;AddTriangle s,0,2,3
	PaintSurface s,b
	'FreeBrush b
	'Right face
	b=LoadBrush( file$+"_LF.bmp",49 )
	s=CreateSurface( m )
	AddVertex s,+1,+1,-1,0,0;AddVertex s,+1,+1,+1,1,0
	AddVertex s,+1,-1,+1,1,1;AddVertex s,+1,-1,-1,0,1
	AddTriangle s,0,1,2;AddTriangle s,0,2,3
	PaintSurface s,b
	'FreeBrush b
	'back face
	b=LoadBrush( file$+"_BK.bmp",49 )
	s=CreateSurface( m )
	AddVertex s,+1,+1,+1,0,0;AddVertex s,-1,+1,+1,1,0
	AddVertex s,-1,-1,+1,1,1;AddVertex s,+1,-1,+1,0,1
	AddTriangle s,0,1,2;AddTriangle s,0,2,3
	PaintSurface s,b
	'FreeBrush b
	'Left face
	b=LoadBrush( file$+"_RT.bmp",49 )
	s=CreateSurface( m )
	AddVertex s,-1,+1,+1,0,0;AddVertex s,-1,+1,-1,1,0
	AddVertex s,-1,-1,-1,1,1;AddVertex s,-1,-1,+1,0,1
	AddTriangle s,0,1,2;AddTriangle s,0,2,3
	PaintSurface s,b
	'FreeBrush b
	'top face
	b=LoadBrush( file$+"_UP.bmp",49 )
	s=CreateSurface( m )
	AddVertex s,-1,+1,+1,0,1;AddVertex s,+1,+1,+1,0,0
	AddVertex s,+1,+1,-1,1,0;AddVertex s,-1,+1,-1,1,1
	AddTriangle s,0,1,2;AddTriangle s,0,2,3
	PaintSurface s,b
	'FreeBrush b

	ScaleMesh m,1700,1700,1700
	FlipMesh m
	EntityFX m,1
	Return m
	
End Function