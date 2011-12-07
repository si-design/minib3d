Type TSprite Extends TMesh

	Field angle#
	Field scale_x#=1.0,scale_y#=1.0
	Field handle_x#,handle_y# 
	Field view_mode:Int=1

	Method New()
	
		If LOG_NEW
			DebugLog "New TSprite"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TSprite"
		EndIf
	
	End Method

	Method CopyEntity:TSprite(parent_ent:TEntity=Null)
	
		' new sprite
		Local sprite:TSprite=New TSprite
		
		' copy contents of child list before adding parent
		For Local ent:TEntity=EachIn child_list
			ent.CopyEntity(sprite)
		Next
		
		' add parent, add to list
		sprite.AddParent(parent_ent:TEntity)
		sprite.EntityListAdd(entity_list)
				
		' lists
		
		' add to collision entity list
		If collision_type<>0
			TCollisionPair.ent_lists[collision_type].AddLast(sprite)
		EndIf
		
		' add to pick entity list
		If pick_mode<>0
			ListAddLast(TPick.ent_list,sprite)
		EndIf
		
		' update matrix
		If sprite.parent<>Null
			sprite.mat.Overwrite(sprite.parent.mat)
		Else
			sprite.mat.LoadIdentity()
		EndIf
		
		' copy entity info
			
		sprite.mat.Multiply(mat)
		
		sprite.px#=px#
		sprite.py#=py#
		sprite.pz#=pz#
		sprite.sx#=sx#
		sprite.sy#=sy#
		sprite.sz#=sz#
		sprite.rx#=rx#
		sprite.ry#=ry#
		sprite.rz#=rz#
		sprite.qw#=qw#
		sprite.qx#=qx#
		sprite.qy#=qy#
		sprite.qz#=qz#

		sprite.name$=name$
		sprite.class$=class$
		sprite.order=order
		sprite.hide=False
		sprite.auto_fade=auto_fade
		sprite.fade_near#=fade_near
		sprite.fade_far#=fade_far
		
		sprite.brush=Null
		sprite.brush=brush.Copy()
		
		sprite.cull_radius#=cull_radius#
		sprite.radius_x#=radius_x#
		sprite.radius_y#=radius_y#
		sprite.box_x#=box_x#
		sprite.box_y#=box_y#
		sprite.box_z#=box_z#
		sprite.box_w#=box_w#
		sprite.box_h#=box_h#
		sprite.box_d#=box_d#
		sprite.collision_type=collision_type
		sprite.pick_mode=pick_mode
		sprite.obscurer=obscurer
	
		' copy mesh info
		
		sprite.no_surfs=no_surfs
		sprite.surf_list=surf_list ' pointer to surf list

		' copy sprite info
		
		sprite.mat_sp.Overwrite(mat_sp)
		sprite.angle#=angle#
		sprite.scale_x#=scale_x#
		sprite.scale_y#=scale_y#
		sprite.handle_x#=handle_x#
		sprite.handle_y#=handle_y#
		sprite.view_mode=view_mode

		Return sprite
		
	End Method
		
	Function CreateSprite:TSprite(parent_ent:TEntity=Null)

		Local sprite:TSprite=New TSprite
		sprite.class$="Sprite"
		
		sprite.AddParent(parent_ent:TEntity)
		sprite.EntityListAdd(entity_list)

		' update matrix
		If sprite.parent<>Null
			sprite.mat.Overwrite(sprite.parent.mat)
			sprite.UpdateMat()
		Else
			sprite.UpdateMat(True)
		EndIf
		
		Local surf:TSurface=sprite.CreateSurface()
		surf.AddVertex(-1,-1,0, 0, 1)
		surf.AddVertex(-1, 1,0, 0, 0)
		surf.AddVertex( 1, 1,0, 1, 0)
		surf.AddVertex( 1,-1,0, 1, 1)
		surf.AddTriangle(0,1,2)
		surf.AddTriangle(0,2,3)
		
		sprite.EntityFX 1

		Return sprite

	End Function

	Function LoadSprite:TSprite(tex_file$,tex_flag:Int=1,parent_ent:TEntity=Null)

		Local sprite:TSprite=CreateSprite(parent_ent)
		
		Local tex:TTexture=TTexture.LoadTexture(tex_file$,tex_flag)
		sprite.EntityTexture(tex)
		
		' additive blend if sprite doesn't have alpha or masking flags set
		If tex_flag&2=0 And tex_flag&4=0
			sprite.EntityBlend 3
		EndIf
	
		Return sprite

	End Function
	
	Method RotateSprite(ang#)
	
		angle#=ang#
	
	End Method
	
	Method ScaleSprite(s_x#,s_y#)
	
		scale_x#=s_x#
		scale_y#=s_y#
	
	End Method
	
	Method HandleSprite(h_x#,h_y#)
	
		handle_x#=h_x#
		handle_y#=h_y#
	
	End Method
	
	Method SpriteViewMode(mode:int)
	
		view_mode=mode
	
	End Method
	
End Type

