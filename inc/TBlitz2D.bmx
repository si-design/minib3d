Type TBlitz2D

	Function Text(x:Int,y:Int,text$)
	
		' set active texture to texture 0 so gldrawtext will work correctly
		If THardwareInfo.VBOSupport 'SMALLFIXES hack to keep non vbo GFX from crashing
			glActiveTextureARB(GL_TEXTURE0)
			glClientActiveTextureARB(GL_TEXTURE0)
		EndIf
			
		glDisable(GL_LIGHTING)
		
		glColor3f(1.0,1.0,1.0)
		
		' enable blend to hide text background
		glEnable(GL_BLEND)

		GLDrawText text$,x,y
		
		glDisable(GL_BLEND)
		
		glEnable(GL_LIGHTING)
		
		' disable texture 2D - needed as gldrawtext enables it, but doesn't disable after use
		glDisable(GL_TEXTURE_2D)
		
	End Function

	' Function by Oddball
	Function BeginMax2D()

		glPopClientAttrib
		glPopAttrib
		glMatrixMode GL_MODELVIEW
		glPopMatrix
		glMatrixMode GL_PROJECTION
		glPopMatrix
		glMatrixMode GL_TEXTURE
		glPopMatrix
		glMatrixMode GL_COLOR
		glPopMatrix 
	
	End Function
	
	' Function by Oddball	
	Function EndMax2D()
	
		' save the Max2D settings for later
		glPushAttrib GL_ALL_ATTRIB_BITS
		glPushClientAttrib GL_CLIENT_ALL_ATTRIB_BITS
		glMatrixMode GL_MODELVIEW
		glPushMatrix
		glMatrixMode GL_PROJECTION
		glPushMatrix
		glMatrixMode GL_TEXTURE
		glPushMatrix
		glMatrixMode GL_COLOR
		glPushMatrix 
		
		TGlobal.EnableStates()
		glDisable GL_TEXTURE_2D
		
		glLightModeli(GL_LIGHT_MODEL_COLOR_CONTROL,GL_SEPARATE_SPECULAR_COLOR)
		glLightModeli(GL_LIGHT_MODEL_LOCAL_VIEWER,GL_TRUE)
	
		glClearDepth(1.0)						
		glDepthFunc(GL_LEQUAL)
		glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)
	
		glAlphaFunc(GL_GEQUAL,0.5)
		
	End Function
		
End Type

