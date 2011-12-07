' Based on code by Birdie and Peter Scheutz

Import "../minib3d.bmx"

Strict

SetGraphicsDriver GLGraphicsDriver(),GRAPHICS_BACKBUFFER|GRAPHICS_DEPTHBUFFER

Local win:TGadget=CreateWindow("MiniB3D in a GUI window", 10, 10, 512, 512 )

Local can:TGadget=CreateCanvas(0,0,ClientWidth(win),ClientHeight(win),win,0)
SetGadgetLayout can,1,1,1,1

TGlobal.width=ClientWidth(win)
TGlobal.height=ClientHeight(win)

TGlobal.depth=16
TGlobal.mode=0
TGlobal.rate=60

SetGraphics CanvasGraphics(can)

TGlobal.GraphicsInit()

Local cam:TCamera=CreateCamera()
PositionEntity cam,0,0,-10

Local light:TLight=CreateLight(1)

Local tex:TTexture=LoadTexture("media/test.png")

Local cube:TMesh=CreateCube()
Local sphere:TMesh=CreateSphere()
Local cylinder:TMesh=CreateCylinder()
Local cone:TMesh=CreateCone() 

PositionEntity cube,-6,0,0
PositionEntity sphere,-2,0,0
PositionEntity cylinder,2,0,0
PositionEntity cone,6,0,0

EntityTexture cube,tex
EntityTexture sphere,tex
EntityTexture cylinder,tex
EntityTexture cone,tex

Local cx#=0
Local cy#=0
Local cz#=0

Local pitch#=0
Local yaw#=0
Local roll#=0

' used by fps code
Local old_ms:Int=MilliSecs()
Local renders:Int
Local fps:Int

Local up_key:Int
Local down_key:Int
Local left_key:Int
Local right_key:Int

CreateTimer( 60 )

While True

	WaitEvent()

	Select EventID()

		Case EVENT_KEYDOWN
		
			Select EventData()
				Case KEY_ESCAPE
					End
				Case KEY_UP
					up_key=True
				Case KEY_DOWN
					down_key=True			
				Case KEY_LEFT
					left_key=True
				Case KEY_RIGHT
					right_key=True	
			EndSelect
			
		Case EVENT_KEYUP
		
			Select EventData()
				Case KEY_UP
					up_key=False
				Case KEY_DOWN
					down_key=False			
				Case KEY_LEFT
					left_key=False
				Case KEY_RIGHT
					right_key=False	
			EndSelect

		Case EVENT_WINDOWCLOSE
		
            End

		Case EVENT_WINDOWSIZE
		
			TGlobal.width=ClientWidth(win)
			TGlobal.height=ClientHeight(win)

			cam.CameraViewport(0,0,ClientWidth(win),ClientHeight(win))
							
			DebugLog "EVENT_WINDOWSIZE" 

		Case EVENT_TIMERTICK

			If up_key Then cz#=cz#+1.0
			If left_key Then cx#=cx#-1.0
			If right_key Then cx#=cx#+1.0
			If down_key Then cz#=cz#-1.0

			MoveEntity cam,cx#*0.5,cy#*0.5,cz#*0.5
			RotateEntity cam,pitch#,yaw#,roll#
			
			cx#=0
			cy#=0
			cz#=0

			RedrawGadget can
              
		Case EVENT_GADGETPAINT
			
			SetGraphics CanvasGraphics(can)

			TurnEntity cube,0,1,0

			RenderWorld
			
			Flip
                                
	EndSelect
	
Wend
