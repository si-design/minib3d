' Original flag.bb program by Mark Sibly

Import "../../minib3d.bmx"

Graphics3D 640,480,16,0

Const segs=128,width#=4,depth#=.125

mesh=CreateMesh()
surf=CreateSurface( mesh )

For k=0 To segs
	x#=Float(k)*width/segs-width/2
	u#=Float(k)/segs
	AddVertex surf,x,1,0,u,0
	AddVertex surf,x,-1,0,u,1
Next

For k=0 To segs-1
	AddTriangle surf,k*2,k*2+2,k*2+3
	AddTriangle surf,k*2,k*2+3,k*2+1
Next

b=LoadBrush( "media/b3dlogo.jpg" )
PaintSurface surf,b

camera=CreateCamera()
PositionEntity camera,0,0,-5

light=CreateLight()
TurnEntity light,45,45,0

' used by fps code
Local old_ms=MilliSecs()
Local renders
Local fps

While Not KeyHit(KEY_ESCAPE)

	ph#=MilliSecs()/4
	cnt=CountVertices(surf)-1
	For k=0 To cnt
		x#=VertexX(surf,k)
		y#=VertexY(surf,k)
		z#=Sin(ph+x*300)*depth
		VertexCoords surf,k,x,y,z
	Next
	UpdateNormals mesh
	
	If KeyDown(KEY_OPENBRACKET) TurnEntity camera,0,1,0
	If KeyDown(KEY_CLOSEBRACKET) TurnEntity camera,0,-1,0
	If KeyDown(KEY_A) MoveEntity camera,0,0,.1
	If KeyDown(KEY_Z) MoveEntity camera,0,0,-.1
	
	If KeyDown(KEY_LEFT) TurnEntity mesh,0,1,0,True
	If KeyDown(KEY_RIGHT) TurnEntity mesh,0,-1,0,True
	If KeyDown(KEY_UP) TurnEntity mesh,1,0,0,True
	If KeyDown(KEY_DOWN) TurnEntity mesh,-1,0,0,True
	
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
	
	Flip
Wend
End
