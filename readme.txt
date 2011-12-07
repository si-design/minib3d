MiniB3D V0.54 by Simon Harrison (si@si-design.co.uk)
----------------------------------------------------

* You are free to use this code as you please - if you do anything interesting with it please let me know!
* Please let me know if you find anything that needs fixing/improving etc.

Using MiniB3D
-------------

* There are two ways of using MiniB3D - as an import file, or as a module.
* To use MiniB3D as an import file, copy 'minib3d.bmx' and the 'inc' folder to the same folder as your main source code file. Then use 'Import "minib3d.bmx"' at the top of your program to import MiniB3D.
* To use MiniB3D as a module, copy the module folder 'sidesign.mod' into your BlitzMax 'mod' folder and build it (you can do this by pressing Ctrl + D in the BlitzMax IDE). Then use 'Import sidesign.minib3d' at the top of your program to use MiniB3D as a module.
* In order to compile MiniB3D on Windows, you will need MinGW 5.1.3 installed. See this thread for more info: http://www.blitzbasic.com/Community/posts.php?topic=72892
* If you have problems compiling MiniB3D programs due to MinGW errors, try a fresh install of MinGW and/or BlitzMax.

MiniB3D and the Blitz3D SDK
---------------------------

* In order to maximise compatibility on all systems, you may consider it preferable to have a single project that uses the Blitz3D SDK (DirectX) for the Windows version of your program, and MiniB3D (OpenGL) for the Mac and Linux versions. 
* In order to make it as easy as possible to use both the BlitzSDK and MiniB3D for the same project, follow these guidelines:
* Copy the contents of the 'blitz3dsdk.mod' folder included with MiniB3D into your actual BlitzMax blitz3dsdk mod folder (you may want to backup the original files)
* These modified files remove the 'bb' prefix from all the Blitz3D SDK function names so that the MiniB3D and Blitz3D SDK function names are the same.
* The files also include an updated set of keycodes which are mapped to work the same as the BlitzMax keycodes when using the Blitz3D SDK.
* To use the BlitzSDK instead of MiniB3D, simply comment out the line at the top of your programs that include or imports MiniB3D, and replace it with these lines:

Framework BRL.Basic
Import brl.retro
Import blitz3d.blitz3dsdk
BeginBlitz3D()

* You will of course have to match up the MiniB3D and Blitz3D SDK functions that you use. This will mean that:
* You will not be able to use functions in the Blitz3D SDK that are not available in BlitzMax + MiniB3D.
* You will not be able to use Max2D functions
* When using MiniB3D, you will have to use functions rather than methods, i.e. you will have to use PositionEntity(entity,0,0,0) rather than entity.PositionEntity(0,0,0)
* When using MiniB3D, you will have to use ints to store entity handles rather than using objects directly, i.e. cam=CreateCamera() rather than cam:TCamera=CreateCamera(). This means you will not be able to use Strict/SuperStrict.
* Using ints instead of objects is somewhat slower though, so you may want to use objects in your MiniB3D version, and then remove all :TType tags before compiling a Blitz3D SDK version.
* Other minor issues may crop up. Feel free to inform me of these at simonh@blitzbasic.com so I can improve MiniB3D and Blitz3D SDK co-operability in future versions.

MiniB3D and Max2D
-----------------

* MiniB3D allows you to integrate Max2D rendering with MiniB3D rendering.
* To do so, after you have used RenderWorld but before you use Flip, use BeginMax2D(), then use your Max2D drawing commands, and then use EndMax2D().
* See 'examples/max2d.bmx' for an example.

MiniB3D and MaxGUI
------------------

* MiniB3D allows you to integrate MaxGUI with MiniB3D.
* You must have purchased and downloaded the MaxGUI module first.
* See 'examples/maxgui.bmx' for an example.

General Notes
-------------

* TurnEntity doesn't works exactly like Blitz3D's TurnEntity - see TurnEntity notes below
* MiniB3D uses BackBufferToTex for dynamic textures - see 'BackBufferToTex' below
* MiniB3D uses bounding spheres for frustum culling as opposed to B3D's OBBs - see 'MeshCullRadius' below
* Non-boned animations not supported yet
* Bone scaling (does anybody use bone scaling?) not supported yet
* Sprite view modes 3 and 4 not supported yet
* Texture flags 128 and 512 not supported
* In Blitz3D, collision types set with EntityType must be between 0-999. In MiniB3D, they must be between 0-99.

TurnEntity Notes
----------------

* MiniB3D's TurnEntity does not work the same as Blitz3D's TurnEntity.
* Blitz3D's TurnEntity, with the global flag enabled, allows for true quaternion rotations, MiniB3D's TurnEntity does not.
* As Blitz3D uses quaternions internally, and MiniB3D does not (it uses eulers), this can't yet be supported in MiniB3D.

BackBuffToTex (MiniB3D only)
----------------------------

* This command is included as MiniB3D currently does not have the same buffer commands as Blitz3D.
* Use this command to copy a region of the backbuffer to a texture.
* The region copied from the backbuffer will start at (0,0), and end at the texture's width and height.
* Therefore if you want to copy the whole of a 3D scene to a texture, you must first resize the camera viewport to the size of the texture, use RenderWorld to render the camera, then use this command to copy the backbuffer to the texture.
* Note that if a texture has the mipmap flag enabled (by default it does), then this command must be called for each mipmap, otherwise the texture will appear to fade into a different, non-matching mipmap as you move away from it. A routine similar to the one below will copy the backbuffer to each mipmap, making sure the camera viewport is the same size as the mipmap.

For i=0 Until tex.CountMipmaps()
	CameraViewport 0,0,tex.MipmapWidth(),tex.MipmapHeight()
	Renderworld
	BackBufferToTex(tex,i)
Next

* It may be easier to disable the mipmap flag for the texture. To do so, use ClearTextureFilters after calling Graphics3D (the mipmap flag is a default filter).
* If you are using this command to copy to a cubemap texture, use SetCubeFace to first select which portion of the texture you will be copying to. Note that in MiniB3D mipmaps are not used by cubemaps, so ignore the information about mipmaps for normal textures above.
* See the cubemap.bmx example included with MiniB3D to learn more about cubemapping.

MeshCullRadius (MiniB3D only)
-----------------------------

* This command is the equivalent of Blitz3D's MeshCullBox command.
* It is used to set the radius of a mesh's 'cull sphere' - if the 'cull sphere' is not inside the viewing area, the mesh will not be rendered.
* A mesh's cull radius is set automatically, therefore in most cases you will not have to use this command.
* You may have to use this command for animated meshes where the default cull radius may not take into account all animation positions, resulting in the mesh being wrongly culled at extreme positions.
* You must use this command for scaled sprites as MiniB3D does not currently take into account the size of scaled sprites before culling them.

Thanks To
---------

* Mark Sibly for writing Blitz3D, and supporting the development of MiniB3D.
* Mark Sibly for providing the Blitz3D source code which MiniB3D's collision system uses
* Peter Scheutz for providing the small fixes version
* Everyone who has contributed to the MiniB3D project in some way

Code Contributors
-----------------

* klepto2 - THardware.bmx, CameraProjMode
* Mark Sibly - C++ code (collision system and UpdateNormals)
* Coyote - CreateSphere, CreateCylinder, CreateCone functions
* mongia2 - PointEntity
* Vertex - DeltaYaw, DeltaPitch
* patmaba - VectorYaw, VectorPitch
* Oddball - BeginMax2D, EndMax2D
* Uncle - bug fix for .b3d loading with BlitzMax 1.33

Version History
---------------

v0.54 - Small fixes version. See smallfixes.txt

v0.53 - Fixed .b3d loading bug with BlitzMax 1.33
v0.53 - Fixed memory leak - occured when mesh collision tree was freed
v0.53 - Fixed AddMesh - in certain cicumstances was adding too many surfaces

v0.52 - Added LoadAnimSeq
v0.52 - Updated VBO support - you can now set 'VBO_MIN_TRIS' Const in minib3d.bmx so only surfaces with certain no. of tris will use VBOs
v0.52 - Fixed FreeEntity bug - bones were not freed when freeing anim meshes
v0.52 - Fixed CollisionNX/NY/NZ bug - incorrect normals were returned

v0.51 - Updated functions.bmx - added ClearWorld
v0.51 - Fixed LoadMesh/LoadAnimMesh bug - would crash if attempting to load non-boned anim mesh - now just ignores anim data
v0.51 - Fixed ClearCollisions bug - would wrongly clear EntityType info
v0.51 - Fixed EntityVisible bug - would wrongly return False if destination entity was picked

v0.5 - Added CameraProjMode
v0.5 - Added ClearWorld
v0.5 - Updated collision and picking system - now uses the Blitz3D C++ source code, and is the same as Blitz3D in all respects
v0.5 - Updated LoadTexture - alpha and mask flags now work the same as in Blitz3D
v0.5 - Updated Graphics3D - depth/modes behaviour now replicates Blitz3D's exactly
v0.5 - Updated TDebug.bmx - tidied up, added brushes info
v0.5 - Fixed FitMesh - meshes were not resized correctly if uniform=true
v0.5 - Fixed .b3d loading bug - certain multi-surface anim meshes weren't animated correctly
v0.5 - Fixed alpha bug - non textured entities with alpha <.5 would not be rendered
v0.5 - Fixed HideEntity bug - if entity was created while parent was hidden, child wouldn't be hidden
v0.5 - Fixed LoadSprite bug - if mask flag=true, blend mode was incorrectly set to 3

v0.452 - Fixed .b3d loading bug - multi-surface anim meshes weren't displayed/animated correctly

v0.451 - Fixed VBO bug - LoadMesh would sometimes cause error if VBOs not supported by graphics card
v0.451 - Fixed animation bug - meshes that were animated would not scale correctly

v0.45 - Added Blitz3D SDK support and Max2D support
v0.45 - Added automatic generation of VBOs (if supported by gfx card) and collision trees for meshes
v0.45 - Added a smattering of C code to UpdateNormals, picking and collision code for faster code execution
v0.45 - Added collision quadtrees and kd-trees - kd-trees used by default
v0.45 - Updated collision system - now faster with lots of entities
v0.45 - Updated bones system - now faster, and bones can now be used as parent entities for other entities
v0.45 - Updated BackBufferToTex - now handles cubemap textures as well. Replace BackBufferToCubeTex function calls with BackBufferToTex. 
v0.45 - Fixed spheremapping bug - spheremaps were upside-down
v0.45 - Fixed rendering bug - surfaces with alpha weren't rendered in order
v0.45 - Fixed .b3d loading bug - normals were sometimes distorted
v0.45 - Fixed .b3d loading bug - textures were sometimes not loaded with correct blend flag
v0.45 - Fixed BackBufferToTex bug - would only work if ClearTextureFilters was used
v0.45 - Fixed TextureHeight and TextureWidth bug - size of 1 would sometimes be returned
v0.45 - Fixed view culling bug

v0.42 - Added separate collision/pick lists - will speed up picking/collision
v0.42 - Updated CreateOctree routine - polys are no longers split (faster)
V0.42 - Fixed matrix transform bug - meshes were not in certain circumstances not rendered correctly
v0.42 - Fixed FlipMesh bug - mesh normals were not flipped
v0.42 - Fixed ProjectedX/Y/Z bug - values were inverted
V0.42 - Fixed sprite orientation bug - if parent was rotated on all three axis, sprite would not face camera
v0.42 - Fixed sprite view mode 2 bug - scaling didn't work
v0.42 - Fixed .b3d loading bug - files with multiple tex/brush chunks wouldn't load
v0.42 - Fixed .b3d loading bug - texture angles weren't being converted from rad to deg
v0.42 - Fixed brush bug - surface/master brush precedence wasn't always correct
v0.42 - Fixed sphere-sphere collision - was broken in last release

v0.41 - Added AntiAlias
v0.41 - Added FitMesh uniform scaling support
v0.41 - Added EntityType recursive flag support
v0.41 - Fixed various bugs

v0.40 - Added Collision commands
v0.40 - Added LoadAnimTexture, added frames support to existing commands
v0.40 - Added GetBrushTexture, GetEntityBrush, GetSurfaceBrush
v0.40 - Added EntityAutoFade
v0.40 - Added DeltaYaw, DeltaPitch, VectorYaw, VectorPitch functions
v0.40 - Added GetMatElement
v0.40 - Updated frustum culling code - meshes are now auto-culled as in B3D (MeshCullRadius still available, use as substitute for B3D's MeshCullBox)
v0.40 - Updated MeshWidth, MeshHeight, MeshDepth so bounding values are searched for only after mesh has changed shape, and not every time function is called
v0.40 - Updated mesh transformation (FitMesh, ScaleMesh etc) commands so that vertex normals are transformed
v0.40 - Updated sprite code so that the same FX and blend modes as B3D are used
v0.40 - Updated sprite code so that parent(s) scale correctly affects sprite scale
v0.40 - Updated EntityClass commmand so that entity class returns same case letters as B3D
v0.40 - Fixed texture crash bug - affected some systems
v0.40 - Fixed LoadAnimB3D bug - in some instances textures were loaded multiple times
v0.40 - Fixed LoadAnimB3D bug - scaled models weren't loaded properly
v0.40 - Fixed picking bug - hidden entities were being picked
v0.40 - Fixed picking bug - sphere picking didn't work if sphere z position <> 0
v0.40 - Fixed picking bug - first polygon in mesh wasn't pickable
v0.40 - Fixed ScaleEntity bug - z-scaling was broken in last release
v0.40 - Fixed EntityInView - was broken in last release
v0.40 - Fixed Spherical mapping - was broken in last release

v0.30 - Added CameraPick, EntityPick, LinePick, EntityVisible, PickedX, PickedY, PickedZ, PickedNX, PickedNY, PickedNZ, PickedTime, PickedEntity, PickedSurface, PickedTriangle
v0.30 - Added CameraProject, ProjectedX, ProjectedY, ProjectedZ. Thanks to ozak for his initial work with this.
v0.30 - Added TFormPoint, TFormVector, TFormNormal, TFormedX, TFormedY, TFormedZ
v0.30 - Added CreateTexture
v0.30 - Added support for texture flag 128 (cube mapping) added, SetCubeFace, SetCubeMode
v0.30 - Added BackBufferToTex, BackBufferToCubeTex (MiniB3D only)
v0.30 - Added Wireframe
v0.30 - Replaced existing UpdateNormals function with Mark Sibly's version. Much faster!

V0.27 - Added initial support for MaxGUI. See gui.bmx
V0.27 - Updated sprites code - sprites are now view plane aligned, like Blitz3D.
V0.27 - Fixed lighting bug that caused LightRange to not work if more than one light
V0.27 - Fixed TriangleVertex bug that returned opposite vertex indices

V0.26 - Added optimised UpdateNormals
V0.26 - Updated LoadMesh/LoadAnimMesh - they will no longer fail if a texture is missing (error message will be sent to debuglog)
V0.26 - Fixed UpdateNormals bug that resulted in wonky lighting
V0.26 - Fixed LoadMesh/LoadAnimMesh bug that resulted in UpdateNormals being called >1 for some meshes
V0.26 - Fixed LoadMesh/LoadAnimMesh bug that would cause crash if 8 texs per brush specifed in .b3d file

V0.25 - Added EntityInView - cull radius must be set first using MeshCullRadius
V0.25 - Added entity frustum culling - cull radius must be set first using MeshCullRadius
V0.25 - Added EntityClass
V0.25 - Added MeshWidth, MeshHeight, MeshDepth
V0.25 - Optimised Matrix commands, increasing performance of transformation commands
V0.25 - Optimised LoadMesh, ScaleMesh, RotateMesh, PositionMesh
V0.25 - Fixed Various bugs

V0.2 - Added UpdateWorld, ExtractAnimSeq, Animate, SetAnimTime, AnimSeq, AnimLength, AnimTime, Animating
V0.2 - Added CreateSprite, LoadSprite, RotateSprite, ScaleSprite, HandleSprite, SpriteViewMode
V0.2 - Added ScaleTexture, PositionTexture, RotateTexture, TextureWidth, TextureHeight, TextureName
V0.2 - Added TextureFilter and ClearTextureFilters
V0.2 - Added Texture flags 8 (mipmapping), 16 (clamp u), 32 (clamp v), 64 (spherical environment map)
V0.2 - Added FX flag 8 (no fog)
V0.2 - Added LoadMesh
V0.2 - Added EntityParent, GetParent, FindChild
V0.2 - Added ClearSurface, FindSurface
V0.2 - Added FreeTexture, FreeBrush
V0.2 - Added HideEntity, ShowEntity
V0.2 - Added PointEntity function by 'mongia'
V0.2 - Improved shininess, now the same as B3D

V0.1 - Early first version