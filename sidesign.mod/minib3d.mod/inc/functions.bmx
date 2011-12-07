' Procedural Interfaces

Rem
bbdoc: Minib3d Only
about:
This command is included as MiniB3D currently does not have the same buffer commands as Blitz3D.

Use this command to copy a region of the backbuffer to a texture.

The region copied from the backbuffer will start at (0,0), and end at the texture's width and height.

Therefore if you want to copy the whole of a 3D scene to a texture, you must first resize the camera viewport to the size of 
the texture, use RenderWorld to render the camera, then use this command to copy the backbuffer to the texture.

Note that if a texture has the mipmap flag enabled (by default it does), then this command must be called for each mipmap,
otherwise the texture will appear to fade into a different, non-matching mipmap as you move away from it. A routine similar to
the one below will copy the backbuffer to each mipmap, making sure the camera viewport is the same size as the mipmap.

For i=0 Until tex.CountMipmaps()
	CameraViewport 0,0,tex.MipmapWidth(),tex.MipmapHeight()
	Renderworld
	BackBufferToTex(tex,i)
Next

It may be easier to disable the mipmap flag for the texture. To do so, use ClearTextureFilters after calling Graphics3D 
(the mipmap flag is a default filter).

If you are using this command to copy to a cubemap texture, use SetCubeFace to first select which portion of the texture you
will be copying to. Note that in MiniB3D mipmaps are not used by cubemaps, so ignore the information about mipmaps for normal 
textures above.

See the cubemap.bmx example included with MiniB3D to learn more about cubemapping.
End Rem
Function BackBufferToTex(tex:TTexture,mipmap_no:Int=0,frame:Int=0)
	tex.BackBufferToTex(mipmap_no,frame)
End Function

Rem
bbdoc: Minib3d Only
about:
This command is the equivalent of Blitz3D's MeshCullBox command.

It is used to set the radius of a mesh's 'cull sphere' - if the 'cull sphere' is not inside the viewing area, the mesh will not 
be rendered.

A mesh's cull radius is set automatically, therefore in most cases you will not have to use this command.

One time you may have to use it is for animated meshes where the default cull radius may not take into account all animation 
positions, resulting in the mesh being wrongly culled at extreme positions.
End Rem
Function MeshCullRadius(ent:TEntity,radius#)
	ent.MeshCullRadius(radius#)
End Function

' Blitz3D functions, A-Z

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=AddMesh">Online Help</a>
End Rem
Function AddMesh:TMesh(mesh1:TMesh,mesh2:TMesh)
	mesh1.AddMesh(mesh2)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=AddTriangle">Online Help</a>
End Rem
Function AddTriangle:Int(surf:TSurface,v0:Int,v1:Int,v2:Int)
	Return surf.AddTriangle(v0,v1,v2)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=AddVertex">Online Help</a>
End Rem
Function AddVertex:Int(surf:TSurface,x#,y#,z#,u#=0.0,v#=0.0,w#=0.0)
	Return surf.AddVertex(x#,y#,z#,u#,v#,w#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=AmbientLight">Online Help</a>
End Rem
Function AmbientLight(r#,g#,b#)
	TGlobal.AmbientLight(r#,g#,b#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=AntiAlias">Online Help</a>
End Rem
Function AntiAlias(samples:Int)
	TGlobal.AntiAlias(samples)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=Animate">Online Help</a>
End Rem
Function Animate(ent:TEntity,mode:Int=1,speed#=1.0,seq:Int=0,trans:Int=0)
	ent.Animate(mode:Int,speed#,seq:Int,trans:Int)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=Animating">Online Help</a>
End Rem
Function Animating:Int(ent:TEntity)
	Return ent.Animating()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=AnimLength">Online Help</a>
End Rem
Function AnimLength:Int(ent:TEntity)
	Return ent.AnimLength()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=AnimSeq">Online Help</a>
End Rem
Function AnimSeq:Int(ent:TEntity)
	Return ent.AnimSeq()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=AnimTime">Online Help</a>
End Rem
Function AnimTime#(ent:TEntity)
	Return ent.AnimTime#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=BrushAlpha">Online Help</a>
End Rem
Function BrushAlpha(brush:TBrush,a#)
	brush.BrushAlpha(a#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=BrushBlend">Online Help</a>
End Rem
Function BrushBlend(brush:TBrush,blend:Int)
	brush.BrushBlend(blend)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=BrushColor">Online Help</a>
End Rem
Function BrushColor(brush:TBrush,r#,g#,b#)
	brush.BrushColor(r#,g#,b#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=BrushFX">Online Help</a>
End Rem
Function BrushFX(brush:TBrush,fx:Int)
	brush.BrushFX(fx)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=BrushShininess">Online Help</a>
End Rem
Function BrushShininess(brush:TBrush,s#)
	brush.BrushShininess(s#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=BrushTexture">Online Help</a>
End Rem
Function BrushTexture(brush:TBrush,tex:TTexture,frame:Int=0,index:Int=0)
	brush.BrushTexture(tex,frame,index)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CameraClsColor">Online Help</a>
End Rem
Function CameraClsColor(cam:TCamera,r#,g#,b#)
	cam.CameraClsColor(r#,g#,b#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CameraClsMode">Online Help</a>
End Rem
Function CameraClsMode(cam:TCamera,cls_depth:Int,cls_zbuffer:Int)
	cam.CameraClsMode(cls_depth,cls_zbuffer)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CameraFogColor">Online Help</a>
End Rem
Function CameraFogColor(cam:TCamera,r#,g#,b#)
	cam.CameraFogColor(r#,g#,b#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CameraFogMode">Online Help</a>
End Rem
Function CameraFogMode(cam:TCamera,mode:Int)
	cam.CameraFogMode(mode)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CameraFogRange">Online Help</a>
End Rem
Function CameraFogRange(cam:TCamera,near#,far#)
	cam.CameraFogRange(near#,far#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CameraPick">Online Help</a>
End Rem
Function CameraPick:TEntity(cam:TCamera,x#,y#)
	Return TPick.CameraPick(cam,x#,y#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CameraProject">Online Help</a>
End Rem
Function CameraProject(cam:TCamera,x#,y#,z#)
	cam.CameraProject(x#,y#,z#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CameraProjMode">Online Help</a>
End Rem
Function CameraProjMode(cam:TCamera,mode:Int)
	cam.CameraProjMode(mode)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CameraRange">Online Help</a>
End Rem
Function CameraRange(cam:TCamera,near#,far#)
	cam.CameraRange(near#,far#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CameraViewport">Online Help</a>
End Rem
Function CameraViewport(cam:TCamera,x:Int,y:Int,width:Int,height:Int)
	cam.CameraViewport(x,y,width,height)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CameraZoom">Online Help</a>
End Rem
Function CameraZoom(cam:TCamera,zoom#)
	cam.CameraZoom(zoom#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ClearCollisions">Online Help</a>
End Rem
Function ClearCollisions()
	TGlobal.ClearCollisions()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ClearSurface">Online Help</a>
End Rem
Function ClearSurface(surf:TSurface,clear_verts:Int=True,clear_tris:Int=True)
	surf.ClearSurface(clear_verts,clear_tris)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ClearTextureFilters">Online Help</a>
End Rem
Function ClearTextureFilters()
	TTexture.ClearTextureFilters()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ClearWorld">Online Help</a>
End Rem
Function ClearWorld(entities:Int=True,brushes:Int=True,textures:Int=True)
	TGlobal.ClearWorld(entities,brushes,textures)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CollisionEntity">Online Help</a>
End Rem
Function CollisionEntity:TEntity(ent:TEntity,index:Int)
	Return ent.CollisionEntity(index)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=Collisions">Online Help</a>
End Rem
Function Collisions(src_no:Int,dest_no:Int,method_no:Int,response_no:Int=0)
	TGlobal.Collisions(src_no,dest_no,method_no,response_no)
End Function
	
Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CollisionNX">Online Help</a>
End Rem
Function CollisionNX#(ent:TEntity,index:Int)
	Return ent.CollisionNX#(index)
End Function
	
Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CollisionNY">Online Help</a>
End Rem
Function CollisionNY#(ent:TEntity,index:Int)
	Return ent.CollisionNY#(index)
End Function
	
Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CollisionNZ">Online Help</a>
End Rem
Function CollisionNZ#(ent:TEntity,index:Int)
	Return ent.CollisionNZ#(index)
End Function
	
Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CollisionSurface">Online Help</a>
End Rem
Function CollisionSurface:TSurface(ent:TEntity,index:Int)
	Return ent.CollisionSurface(index)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CollisionTime">Online Help</a>
End Rem
Function CollisionTime#(ent:TEntity,index:Int)
	Return ent.CollisionTime#(index)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CollisionTriangle">Online Help</a>
End Rem	
Function CollisionTriangle:Int(ent:TEntity,index:Int)
	Return ent.CollisionTriangle(index)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CollisionX">Online Help</a>
End Rem
Function CollisionX#(ent:TEntity,index:Int)
	Return ent.CollisionX#(index)
End Function
	
Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CollisionY">Online Help</a>
End Rem
Function CollisionY#(ent:TEntity,index:Int)
	Return ent.CollisionY#(index)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CollisionZ">Online Help</a>
End Rem
Function CollisionZ#(ent:TEntity,index:Int)
	Return ent.CollisionZ#(index)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CountChildren">Online Help</a>
End Rem
Function CountChildren:Int(ent:TEntity)
	Return ent.CountChildren()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CountCollisions">Online Help</a>
End Rem
Function CountCollisions:Int(ent:TEntity)
	Return ent.CountCollisions()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CopyEntity">Online Help</a>
End Rem
Function CopyEntity:TEntity(ent:TEntity,parent:TEntity=Null)
	Return ent.CopyEntity(parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CopyMesh">Online Help</a>
End Rem
Function CopyMesh:TMesh(mesh:TMesh,parent:TEntity=Null)
	Return mesh.CopyMesh(parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CountSurfaces">Online Help</a>
End Rem
Function CountSurfaces:Int(mesh:TMesh)
	Return mesh.CountSurfaces()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CountTriangles">Online Help</a>
End Rem
Function CountTriangles:Int(surf:TSurface)
	Return surf.CountTriangles()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CountVertices">Online Help</a>
End Rem
Function CountVertices:Int(surf:TSurface)
	Return surf.CountVertices()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreateBrush">Online Help</a>
End Rem
Function CreateBrush:TBrush(r#=255.0,g#=255.0,b#=255.0)
	Return TBrush.CreateBrush(r#,g#,b#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreateCamera">Online Help</a>
End Rem
Function CreateCamera:TCamera(parent:TEntity=Null)
	Return TCamera.CreateCamera(parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreateCone">Online Help</a>
End Rem
Function CreateCone:TMesh(segments:Int=8,solid:Int=True,parent:TEntity=Null)
	Return TMesh.CreateCone(segments,solid,parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreateCylinder">Online Help</a>
End Rem
Function CreateCylinder:TMesh(segments:Int=8,solid:Int=True,parent:TEntity=Null)
	Return TMesh.CreateCylinder(segments,solid,parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreateCube">Online Help</a>
End Rem
Function CreateCube:TMesh(parent:TEntity=Null)
	Return TMesh.CreateCube(parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreateMesh">Online Help</a>
End Rem
Function CreateMesh:TMesh(parent:TEntity=Null)
	Return TMesh.CreateMesh(parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreateLight">Online Help</a>
End Rem
Function CreateLight:TLight(light_type:Int=1,parent:TEntity=Null)
	Return TLight.CreateLight(light_type,parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreatePivot">Online Help</a>
End Rem
Function CreatePivot:TPivot(parent:TEntity=Null)
	Return TPivot.CreatePivot(parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreateSphere">Online Help</a>
End Rem
Function CreateSphere:TMesh(segments:Int=8,parent:TEntity=Null)
	Return TMesh.CreateSphere(segments,parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreateSprite">Online Help</a>
End Rem
' Sprite
Function CreateSprite:TSprite(parent:TEntity=Null)
	Return TSprite.CreateSprite(parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreateSurface">Online Help</a>
End Rem
Function CreateSurface:TSurface(mesh:TMesh,brush:TBrush=Null)
	Return mesh.CreateSurface(brush)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=CreateTexture">Online Help</a>
End Rem
Function CreateTexture:TTexture(width:Int,height:Int,flags:Int=1,frames:Int=1)
	Return TTexture.CreateTexture(width,height,flags,frames)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=DeltaPitch">Online Help</a>
End Rem
Function DeltaPitch#(ent1:TEntity,ent2:TEntity)
	Return ent1.DeltaPitch#(ent2:TEntity)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=DeltaYaw">Online Help</a>
End Rem
Function DeltaYaw#(ent1:TEntity,ent2:TEntity)
	Return ent1.DeltaYaw#(ent2:TEntity)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityAlpha">Online Help</a>
End Rem
Function EntityAlpha(ent:TEntity,alpha#)
	ent.EntityAlpha(alpha#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityAutoFade">Online Help</a>
End Rem
Function EntityAutoFade(ent:TEntity,near#,far#)
	ent.EntityAutoFade(near#,far#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityBlend">Online Help</a>
End Rem
Function EntityBlend(ent:TEntity,blend:Int)
	ent.EntityBlend(blend)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityBox">Online Help</a>
End Rem
Function EntityBox(ent:TEntity,x#,y#,z#,w#,h#,d#)
	ent.EntityBox(x#,y#,z#,w#,h#,d#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityClass">Online Help</a>
End Rem
Function EntityClass$(ent:TEntity)
	Return ent.EntityClass$()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityCollided">Online Help</a>
End Rem
Function EntityCollided:TEntity(ent:TEntity,type_no:Int)
	Return ent.EntityCollided(type_no)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityColor">Online Help</a>
End Rem
Function EntityColor(ent:TEntity,red#,green#,blue#)
	ent.EntityColor(red#,green#,blue#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityDistance">Online Help</a>
End Rem
Function EntityDistance#(ent1:TEntity,ent2:TEntity)
	Return ent1.EntityDistance#(ent2)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityFX">Online Help</a>
End Rem
Function EntityFX(ent:TEntity,fx:Int)
	ent.EntityFX(fx)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityInView">Online Help</a>
End Rem
Function EntityInView:Int(ent:TEntity,cam:TCamera)
	Return cam.EntityInView(ent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityName">Online Help</a>
End Rem
Function EntityName$(ent:TEntity)
	Return ent.EntityName$()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityOrder">Online Help</a>
End Rem
Function EntityOrder(ent:TEntity,order:Int)
	ent.EntityOrder(order)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityParent">Online Help</a>
End Rem
Function EntityParent(ent:TEntity,parent_ent:TEntity,glob:Int=True)
	ent.EntityParent(parent_ent,glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityPick">Online Help</a>
End Rem
Function EntityPick:TEntity(ent:TEntity,range#)
	Return TPick.EntityPick(ent,range#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityPickMode">Online Help</a>
End Rem
Function EntityPickMode(ent:TEntity,pick_mode:Int,obscurer:Int=True)
	ent.EntityPickMode(pick_mode,obscurer)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityPitch">Online Help</a>
End Rem
Function EntityPitch#(ent:TEntity,glob:Int=False)
	Return ent.EntityPitch#(glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityRadius">Online Help</a>
End Rem
Function EntityRadius(ent:TEntity,radius_x#,radius_y#=0.0)
	ent.EntityRadius(radius_x#,radius_y#)
End Function
	
Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityRoll">Online Help</a>
End Rem
Function EntityRoll#(ent:TEntity,glob:Int=False)
	Return ent.EntityRoll#(glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityShininess">Online Help</a>
End Rem
Function EntityShininess(ent:TEntity,shine#)
	ent.EntityShininess(shine#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityTexture">Online Help</a>
End Rem
Function EntityTexture(ent:TEntity,tex:TTexture,frame:Int=0,index:Int=0)
	TMesh(ent).EntityTexture(tex:TTexture,frame,index)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityType">Online Help</a>
End Rem
Function EntityType(ent:TEntity,type_no:Int,recursive:Int=False)
	ent.EntityType(type_no,recursive)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityVisible">Online Help</a>
End Rem
Function EntityVisible:Int(src_ent:TEntity,dest_ent:TEntity)
	Return TPick.EntityVisible(src_ent,dest_ent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityX">Online Help</a>
End Rem
Function EntityX#(ent:TEntity,glob:Int=False)
	Return ent.EntityX#(glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityY">Online Help</a>
End Rem
Function EntityY#(ent:TEntity,glob:Int=False)
	Return ent.EntityY#(glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityYaw">Online Help</a>
End Rem
Function EntityYaw#(ent:TEntity,glob:Int=False)
	Return ent.EntityYaw#(glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=EntityZ">Online Help</a>
End Rem
Function EntityZ#(ent:TEntity,glob:Int=False)
	Return ent.EntityZ#(glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ExtractAnimSeq">Online Help</a>
End Rem
Function ExtractAnimSeq:Int(ent:TEntity,first_frame:Int,last_frame:Int,seq:Int=0)
	Return ent.ExtractAnimSeq(first_frame,last_frame,seq)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=FindChild">Online Help</a>
End Rem
Function FindChild:TEntity(ent:TEntity,child_name$)
	Return ent.FindChild(child_name$)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=FindSurface">Online Help</a>
End Rem
Function FindSurface:TSurface(mesh:TMesh,brush:TBrush)
	Return mesh.FindSurface(brush)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=FitMesh">Online Help</a><p>
End Rem
Function FitMesh:TMesh(mesh:TMesh,x#,y#,z#,width#,height#,depth#,uniform:Int=False)
	mesh.FitMesh(x#,y#,z#,width#,height#,depth#,uniform)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=FlipMesh">Online Help</a>
End Rem
Function FlipMesh:TMesh(mesh:TMesh)
	mesh.FlipMesh()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=FreeBrush">Online Help</a>
End Rem
Function FreeBrush(brush:TBrush)
	brush.FreeBrush()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=FreeEntity">Online Help</a>
End Rem
Function FreeEntity(ent:TEntity)
	ent.FreeEntity()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=FreeTexture">Online Help</a>
End Rem
Function FreeTexture:TTexture(tex:TTexture)
	tex.FreeTexture()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=GetBrushTexture">Online Help</a>
End Rem
Function GetBrushTexture:TTexture(brush:TBrush,index:Int=0)
	Return TTexture.GetBrushTexture(brush,index)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=GetChild">Online Help</a>
End Rem
Function GetChild:TEntity(ent:TEntity,child_no:Int)
	Return ent.GetChild(child_no)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=GetEntityBrush">Online Help</a>
End Rem
Function GetEntityBrush:TBrush(ent:TEntity)
	TBrush.GetEntityBrush(ent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=GetEntityType">Online Help</a>
End Rem	
Function GetEntityType:Int(ent:TEntity)
	Return ent.GetEntityType()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ResetEntity">Online Help</a>
End Rem
Function GetMatElement#(ent:TEntity,row:Int,col:Int)
	ent.GetMatElement#(row,col)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=GetParent">Online Help</a>
End Rem
Function GetParent:TEntity(ent:TEntity)
	Return ent.GetParent()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=GetSurface">Online Help</a>
End Rem
Function GetSurface:TSurface(mesh:TMesh,surf_no:Int)
	Return mesh.GetSurface(surf_no)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=GetSurfaceBrush">Online Help</a>
End Rem
Function GetSurfaceBrush:TBrush(surf:TSurface)
	Return TBrush.GetSurfaceBrush(surf)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=Graphics3D">Online Help</a>
End Rem
Function Graphics3D(width:Int,height:Int,depth:Int=0,mode:Int=0,rate:Int=60,flags:Int=-1) 'SMALLFIXES added flags
	TGlobal.Graphics3D(width,height,depth,mode,rate,flags)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=HandleSprite">Online Help</a>
End Rem	
Function HandleSprite(sprite:TSprite,h_x#,h_y#)
	sprite.HandleSprite(h_x#,h_y#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=HideEntity">Online Help</a>
End Rem
Function HideEntity(ent:TEntity)
	ent.HideEntity()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LightColor">Online Help</a>
End Rem
Function LightColor(light:TLight,red#,green#,blue#)
	light.LightColor(red#,green#,blue#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LightConeAngles">Online Help</a>
End Rem
Function LightConeAngles(light:TLight,inner_ang#,outer_ang#)
	light.LightConeAngles(inner_ang#,outer_ang#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LightRange">Online Help</a>
End Rem
Function LightRange(light:TLight,range#)
	light.LightRange(range#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LinePick">Online Help</a>
End Rem
Function LinePick:TEntity(x#,y#,z#,dx#,dy#,dz#,radius#=0.0)
	Return TPick.LinePick(x#,y#,z#,dx#,dy#,dz#,radius#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LoadAnimMesh">Online Help</a>
End Rem
Function LoadAnimMesh:TMesh(file$,parent:TEntity=Null)
	Return TMesh.LoadAnimMesh(file$,parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LoadAnimTexture">Online Help</a>
End Rem
Function LoadAnimTexture:TTexture(file$,flags:Int,frame_width:Int,frame_height:Int,first_frame:Int,frame_count:Int)
	Return TTexture.LoadAnimTexture(file$,flags,frame_width,frame_height,first_frame,frame_count)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LoadBrush">Online Help</a>
End Rem
Function LoadBrush:TBrush(file$,flags:Int=1,u_scale#=1.0,v_scale#=1.0)
	Return TBrush.LoadBrush(file$,flags,u_scale#,v_scale#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LoadMesh">Online Help</a>
End Rem
Function LoadMesh:TMesh(file$,parent:TEntity=Null)
	Return TMesh.LoadMesh(file$,parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LoadTexture">Online Help</a>
End Rem
Function LoadTexture:TTexture(file$,flags:Int=1)
	Return TTexture.LoadTexture(file$,flags)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LoadSprite">Online Help</a>
End Rem
Function LoadSprite:TSprite(tex_file$,tex_flag:Int=1,parent:TEntity=Null)
	Return TSprite.LoadSprite(tex_file$,tex_flag,parent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=MeshDepth">Online Help</a>
End Rem
Function MeshDepth#(mesh:TMesh)
	Return mesh.MeshDepth#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=MeshHeight">Online Help</a>
End Rem
Function MeshHeight#(mesh:TMesh)
	Return mesh.MeshHeight#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=MeshWidth">Online Help</a>
End Rem
Function MeshWidth#(mesh:TMesh)
	Return mesh.MeshWidth#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=MoveEntity">Online Help</a>
End Rem
Function MoveEntity(ent:TEntity,x#,y#,z#)
	ent.MoveEntity(x#,y#,z#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=NameEntity">Online Help</a>
End Rem
Function NameEntity(ent:TEntity,name$)
	ent.NameEntity(name$)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PaintEntity">Online Help</a>
End Rem
Function PaintEntity(ent:TEntity,brush:TBrush)
	TMesh(ent).PaintEntity(brush)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PaintMesh">Online Help</a>
End Rem
Function PaintMesh:TMesh(mesh:TMesh,brush:TBrush)
	mesh.PaintMesh(brush)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PaintSurface">Online Help</a>
End Rem
Function PaintSurface:Int(surf:TSurface,brush:TBrush)
	Return surf.PaintSurface(brush)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PickedEntity">Online Help</a>
End Rem
Function PickedEntity:TEntity()
	Return TPick.PickedEntity:TEntity()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PickedNX">Online Help</a>
End Rem
Function PickedNX#()
	Return TPick.PickedNX#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PickedNY">Online Help</a>
End Rem
Function PickedNY#()
	Return TPick.PickedNY#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PickedNZ">Online Help</a>
End Rem
Function PickedNZ#()
	Return TPick.PickedNZ#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PickedSurface">Online Help</a>
End Rem
Function PickedSurface:TSurface()
	Return TPick.PickedSurface:TSurface()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PickedTime">Online Help</a>
End Rem
Function PickedTime#()
	Return TPick.PickedTime#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PickedTriangle">Online Help</a>
End Rem
Function PickedTriangle:Int()
	Return TPick.PickedTriangle()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PickedX">Online Help</a>
End Rem
Function PickedX#()
	Return TPick.PickedX#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PickedY">Online Help</a>
End Rem
Function PickedY#()
	Return TPick.PickedY#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PickedZ">Online Help</a>
End Rem
Function PickedZ#()
	Return TPick.PickedZ#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PointEntity">Online Help</a>
End Rem
Function PointEntity(ent:TEntity,target_ent:TEntity,roll#=0)
	ent.PointEntity(target_ent,roll#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PositionEntity">Online Help</a>
End Rem
Function PositionEntity(ent:TEntity,x#,y#,z#,glob:Int=False)
	ent.PositionEntity(x#,y#,z#,glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PositionMesh">Online Help</a>
End Rem
Function PositionMesh:TMesh(mesh:TMesh,px#,py#,pz#)
	mesh.PositionMesh(px#,py#,pz#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=PositionTexture">Online Help</a>
End Rem
Function PositionTexture(tex:TTexture,u_pos#,v_pos#)
	tex.PositionTexture(u_pos#,v_pos#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ProjectedX">Online Help</a>
End Rem
Function ProjectedX#()
    Return TCamera.projected_x#
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ProjectedY">Online Help</a>
End Rem
Function ProjectedY#()
    Return TCamera.projected_y#
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ProjectedZ">Online Help</a>
End Rem
Function ProjectedZ#()
    Return TCamera.projected_z#
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=RenderWorld">Online Help</a>
End Rem
Function RenderWorld()
	TGlobal.RenderWorld()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ResetEntity">Online Help</a>
End Rem
Function ResetEntity(ent:TEntity)
	ent.ResetEntity()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=RotateEntity">Online Help</a>
End Rem
Function RotateEntity(ent:TEntity,x#,y#,z#,glob:Int=False)
	ent.RotateEntity(x#,y#,z#,glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=RotateMesh">Online Help</a>
End Rem
Function RotateMesh:TMesh(mesh:TMesh,pitch#,yaw#,roll#)
	mesh.RotateMesh(pitch#,yaw#,roll#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=RotateSprite">Online Help</a>
End Rem
Function RotateSprite(sprite:TSprite,ang#)
	sprite.RotateSprite(ang#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=RotateTexture">Online Help</a>
End Rem	
Function RotateTexture(tex:TTexture,ang#)
	tex.RotateTexture(ang#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ScaleEntity">Online Help</a>
End Rem
Function ScaleEntity(ent:TEntity,x#,y#,z#,glob:Int=False)
	ent.ScaleEntity(x#,y#,z#,glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ScaleMesh">Online Help</a>
End Rem
Function ScaleMesh:TMesh(mesh:TMesh,sx#,sy#,sz#)
	mesh.ScaleMesh(sx#,sy#,sz#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ScaleSprite">Online Help</a>
End Rem	
Function ScaleSprite(sprite:TSprite,s_x#,s_y#)
	sprite.ScaleSprite(s_x#,s_y#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ScaleTexture">Online Help</a>
End Rem
Function ScaleTexture(tex:TTexture,u_scale#,v_scale#)	
	tex.ScaleTexture(u_scale#,v_scale#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=SetAnimTime">Online Help</a>
End Rem
Function SetAnimTime(ent:TEntity,time#,seq:Int=0)
	ent.SetAnimTime(time#,seq)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=SetCubeFace">Online Help</a>
End Rem
Function SetCubeFace(tex:TTexture,face:Int)
	tex.SetCubeFace(face)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=SetCubeMode">Online Help</a>
End Rem
Function SetCubeMode(tex:TTexture,mode:Int)
	tex.SetCubeMode(mode)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=ShowEntity">Online Help</a>
End Rem
Function ShowEntity(ent:TEntity)
	ent.ShowEntity()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=SpriteViewMode">Online Help</a>
End Rem	
Function SpriteViewMode(sprite:TSprite,mode:Int)
	sprite.SpriteViewMode(mode)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TextureBlend">Online Help</a>
End Rem
Function TextureBlend(tex:TTexture,blend:Int)
	tex.TextureBlend(blend)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TextureCoords">Online Help</a>
End Rem
Function TextureCoords(tex:TTexture,coords:Int)
	tex.TextureCoords(coords)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TextureHeight">Online Help</a>
End Rem	
Function TextureHeight:Int(tex:TTexture)
	Return tex.TextureHeight()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TextureFilter">Online Help</a>
End Rem
Function TextureFilter(match_text$,flags:Int)
	TTexture.TextureFilter(match_text$,flags)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TextureName">Online Help</a>
End Rem	
Function TextureName$(tex:TTexture)
	Return tex.TextureName$()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TextureWidth">Online Help</a>
End Rem	
Function TextureWidth:Int(tex:TTexture)
	Return tex.TextureWidth()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TFormedX">Online Help</a>
End Rem
Function TFormedX#()
	Return TEntity.TFormedX#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TFormedY">Online Help</a>
End Rem
Function TFormedY#()
	Return TEntity.TFormedY#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TFormedZ">Online Help</a>
End Rem
Function TFormedZ#()
	Return TEntity.TFormedZ#()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TFormNormal">Online Help</a>
End Rem
Function TFormNormal(x#,y#,z#,src_ent:TEntity,dest_ent:TEntity)
	TEntity.TFormNormal(x#,y#,z#,src_ent,dest_ent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TFormPoint">Online Help</a>
End Rem
Function TFormPoint(x#,y#,z#,src_ent:TEntity,dest_ent:TEntity)
	TEntity.TFormPoint(x#,y#,z#,src_ent,dest_ent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TFormVector">Online Help</a>
End Rem
Function TFormVector(x#,y#,z#,src_ent:TEntity,dest_ent:TEntity)
	TEntity.TFormVector(x#,y#,z#,src_ent,dest_ent)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TranslateEntity">Online Help</a>
End Rem
Function TranslateEntity(ent:TEntity,x#,y#,z#,glob:Int=False)
	ent.TranslateEntity(x#,y#,z#,glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TriangleVertex">Online Help</a>
End Rem
Function TriangleVertex:Int(surf:TSurface,tri_no:Int,corner:Int)
	Return surf.TriangleVertex(tri_no,corner)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=TurnEntity">Online Help</a>
End Rem
Function TurnEntity(ent:TEntity,x#,y#,z#,glob:Int=False)
	ent.TurnEntity(x#,y#,z#,glob)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=UpdateNormals">Online Help</a>
End Rem
Function UpdateNormals(mesh:TMesh)
	mesh.UpdateNormals()
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=UpdateWorld">Online Help</a>
End Rem
Function UpdateWorld(anim_speed#=1.0)
	TGlobal.UpdateWorld(anim_speed#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VectorPitch">Online Help</a>
End Rem	
Function VectorPitch#(vx#,vy#,vz#)
	Return TVector.VectorPitch#(vx#,vy#,vz#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VectorYaw">Online Help</a>
End Rem	
Function VectorYaw#(vx#,vy#,vz#)
	Return TVector.VectorYaw#(vx#,vy#,vz#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexAlpha">Online Help</a>
End Rem
Function VertexAlpha#(surf:TSurface,vid:Int)
	Return surf.VertexAlpha#(vid)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexBlue">Online Help</a>
End Rem
Function VertexBlue#(surf:TSurface,vid:Int)
	Return surf.VertexBlue#(vid)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexColor">Online Help</a>
End Rem
Function VertexColor:Int(surf:TSurface,vid:Int,r#,g#,b#,a#=1.0)
	Return surf.VertexColor(vid,r#,g#,b#,a#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexCoords">Online Help</a>
End Rem
Function VertexCoords:Int(surf:TSurface,vid:Int,x#,y#,z#)
	Return surf.VertexCoords(vid,x#,y#,z#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexGreen">Online Help</a>
End Rem
Function VertexGreen#(surf:TSurface,vid:Int)
	Return surf.VertexGreen#(vid)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexNormal">Online Help</a>
End Rem
Function VertexNormal:Int(surf:TSurface,vid:Int,nx#,ny#,nz#)
	Return surf.VertexNormal(vid,nx#,ny#,nz#)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexNX">Online Help</a>
End Rem
Function VertexNX#(surf:TSurface,vid:Int)
	Return surf.VertexNX#(vid)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexNY">Online Help</a>
End Rem
Function VertexNY#(surf:TSurface,vid:Int)
	Return surf.VertexNY#(vid)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexNZ">Online Help</a>
End Rem
Function VertexNZ#(surf:TSurface,vid:Int)
	Return surf.VertexNZ#(vid)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexRed">Online Help</a>
End Rem
Function VertexRed#(surf:TSurface,vid:Int)
	Return surf.VertexRed#(vid)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexTexCoords">Online Help</a>
End Rem
Function VertexTexCoords:int(surf:TSurface,vid:Int,u#,v#,w#=0.0,coord_set:Int=0)
	Return surf.VertexTexCoords(vid,u#,v#,w#,coord_set)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexU">Online Help</a>
End Rem
Function VertexU#(surf:TSurface,vid:Int,coord_set:Int=0)
	Return surf.VertexU#(vid,coord_set)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexV">Online Help</a>
End Rem
Function VertexV#(surf:TSurface,vid:Int,coord_set:Int=0)
	Return surf.VertexV#(vid,coord_set)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexW">Online Help</a>
End Rem
Function VertexW#(surf:TSurface,vid:Int,coord_set:Int=0)
	Return surf.VertexW#(vid,coord_set)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexX">Online Help</a>
End Rem
Function VertexX#(surf:TSurface,vid:Int)
	Return surf.VertexX#(vid)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexY">Online Help</a>
End Rem
Function VertexY#(surf:TSurface,vid:Int)
	Return surf.VertexY#(vid)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=VertexZ">Online Help</a>
End Rem
Function VertexZ#(surf:TSurface,vid:Int)
	Return surf.VertexZ#(vid)
End Function

Rem
bbdoc: <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=Wireframe">Online Help</a>
End Rem
Function Wireframe(enable:Int)
	TGlobal.Wireframe(enable)
End Function

' Blitz2D

Function Text(x:Int,y:Int,str$)
	TBlitz2D.Text(x,y,str$)
End Function

Function BeginMax2D()
	TBlitz2D.BeginMax2D()
End Function

Function EndMax2D()
	TBlitz2D.EndMax2D()
End Function

' ***extras***

Function EntityScaleX:Float(ent:TEntity,glob:Int=False)
	Return ent.EntityScaleX:Float(glob)
End Function

Function EntityScaleY:Float(ent:TEntity,glob:Int=False)
	Return ent.EntityScaleY:Float(glob)
End Function

Function EntityScaleZ:Float(ent:TEntity,glob:Int=False)
	Return ent.EntityScaleZ:Float(glob)
End Function

' ***todo***

Function LightMesh(mesh:TMesh,red#,green#,blue#,range#=0,light_x#=0,light_y#=0,light_z#=0)
End Function
Function MeshesIntersect(mesh1:TMesh,mesh2:TMesh)
End Function
Function CreatePlane(sub_divs:Int=1,parent:TEntity=Null)
End Function
Function AlignToVector(vx:Float,vy:Float,vz:Float,axis:Int,rate:Int=1)
End Function
Function LoadAnimSeq(ent:TEntity,filename$)
End Function
Function SetAnimKey(ent:TEntity,frame:Int,pos_key:Int=True,rot_key:Int=True,scale_key:Int=True)
End Function
Function AddAnimSeq(ent:TEntity,length:Int)
End Function
