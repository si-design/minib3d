Rem
bbdoc: minib3d
End Rem
'Module sidesign.minib3d
'ModuleInfo "Version: 0.52"
'ModuleInfo "Main Author: Simon Harrison (simonh@blitzbasic.com). Includes routines by various authors."
'ModuleInfo "License: You are free to use this code as you please"
'ModuleInfo "Please see readme.txt for more details"

Strict

Import BRL.GLMax2D
Import BRL.GLGraphics
Import PUB.Glew
Import BRL.BMPLoader
Import BRL.PNGLoader
Import BRL.JPGLoader
Import BRL.Retro

' c++
Import "inc/std.cpp"
Import "inc/misc.cpp"		' contains C_UpdateNormals and C_IntersectTriangle
Import "inc/collision.cpp"	' contains functions used by TCollisionB.bmx
Import "inc/tree.cpp"		' contains functions used by TCollisionB.bmx
Import "inc/geom.cpp"		' contains functions used by TCollisionB.bmx

' global
Include "inc/TGlobal.bmx"

' entity
Include "inc/TEntity.bmx"
Include "inc/TCamera.bmx"
Include "inc/TLight.bmx"
Include "inc/TPivot.bmx"
Include "inc/TMesh.bmx"
Include "inc/TSprite.bmx"
Include "inc/TBone.bmx"

' mesh structure
Include "inc/TSurface.bmx"
Include "inc/TTexture.bmx"
Include "inc/TBrush.bmx"
Include "inc/TAnimation.bmx"
Include "inc/TModel.bmx"

' picking/collision
Include "inc/TColTree.bmx"
Include "inc/TPick.bmx"
Include "inc/TCollision.bmx"

' geom
Include "inc/TVector.bmx"
Include "inc/TMatrix.bmx"
Include "inc/TQuaternion.bmx"
Include "inc/BoxSphere.bmx"

' misc
Include "inc/THardwareInfo.bmx"
Include "inc/TBlitz2D.bmx"
Include "inc/TUtility.bmx"
Include "inc/TDebug.bmx"

' data
Include "inc/data.bmx"

' functions
Include "inc/functions.bmx"

Extern

	Function C_UpdateNormals(no_tris:Int,no_verts:Int,tris:Short Ptr,vert_coords:Float Ptr,vert_norms:Float Ptr) ' used by TMesh.bmx

	Function C_NewMeshInfo:Byte Ptr()
	Function C_DeleteMeshInfo(mesh_info:Byte Ptr)
	Function C_AddSurface(mesh_info:Byte Ptr,no_tris:Int,no_verts:Int,tris:Short Ptr,verts:Float Ptr,surf:Int)
	
	Function C_CreateColTree:Byte Ptr(mesh_info:Byte Ptr)
	Function C_DeleteColTree(col_tree:Byte Ptr)
	
	Function C_CreateCollisionInfoObject:Byte Ptr(vec_a:Byte Ptr,vec_b:Byte Ptr,vec_radius:Byte Ptr)
	Function C_UpdateCollisionInfoObject(col_info:Byte Ptr,dst_radius:Float,ax:Float,ay:Float,az:Float,bx:Float,by:Float,bz:Float)
	Function C_DeleteCollisionInfoObject(col_info:Byte Ptr)
	
	Function C_CreateCollisionObject:Byte Ptr()
	Function C_DeleteCollisionObject(coll:Byte Ptr)
	
	Function C_Pick:Int(col_info:Byte Ptr,line:Byte Ptr,radius:Float,coll:Byte Ptr,dst_tform:Byte Ptr,mesh_col:Byte Ptr,pick_geom:Int)
	
	Function C_CollisionDetect:Int(col_info:Byte Ptr,coll:Byte Ptr,tform:Byte Ptr,col_tree:Byte Ptr,method_no:Int)
	Function C_CollisionResponse:Int(col_info:Byte Ptr,coll:Byte Ptr,response:Int)
	Function C_CollisionFinal:Int(col_info:Byte Ptr)
		
	Function C_CollisionPosX:Float()
	Function C_CollisionPosY:Float()
	Function C_CollisionPosZ:Float()
	Function C_CollisionX:Float()
	Function C_CollisionY:Float()
	Function C_CollisionZ:Float()
	Function C_CollisionNX:Float()
	Function C_CollisionNY:Float()
	Function C_CollisionNZ:Float()
	Function C_CollisionTime:Float()
	Function C_CollisionSurface:Int()
	Function C_CollisionTriangle:Int()
	
	Function C_CreateVecObject:Byte Ptr(x:Float,y:Float,z:Float)
	Function C_DeleteVecObject(v:Byte Ptr)
	Function C_UpdateVecObject(vec:Byte Ptr,x:Float,y:Float,z:Float)
	Function C_VecX:Float(vec:Byte Ptr)
	Function C_VecY:Float(vec:Byte Ptr)
	Function C_VecZ:Float(vec:Byte Ptr)
	
	Function C_CreateLineObject:Byte Ptr(ox:Float,oy:Float,oz:Float,dx:Float,dy:Float,dz:Float)
	Function C_DeleteLineObject(line:Byte Ptr)
	Function C_UpdateLineObject(line:Byte Ptr,ox:Float,oy:Float,oz:Float,dx:Float,dy:Float,dz:Float)

	Function C_CreateMatrixObject:Byte Ptr(vec_i:Byte Ptr,vec_j:Byte Ptr,vec_k:Byte Ptr)
	Function C_DeleteMatrixObject(mat:Byte Ptr)
	Function C_UpdateMatrixObject(mat:Byte Ptr,vec_i:Byte Ptr,vec_j:Byte Ptr,vec_k:Byte Ptr)
	
	Function C_CreateTFormObject:Byte Ptr(mat:Byte Ptr,vec_v:Byte Ptr)
	Function C_DeleteTFormObject(tform:Byte Ptr)
	Function C_UpdateTFormObject(tform:Byte Ptr,mat:Byte Ptr,vec_v:Byte Ptr)
					
End Extern

Const USE_MAX2D=True	' true to enable max2d/minib3d integration
Const USE_VBO=True	' true to use vbos if supported by hardware
Const VBO_MIN_TRIS=250	' if USE_VBO=True and vbos are supported by hardware, then surface must also have this minimum no. of tris before vbo is used for surface (vbos work best with surfaces with high amount of tris)
Const LOG_NEW=False	' true to write to debuglog when new minib3d object created
Const LOG_DEL=False	' true to write to debuglog when minib3d object destroyed