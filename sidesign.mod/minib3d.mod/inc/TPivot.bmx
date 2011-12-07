Type TPivot Extends TEntity

	Method New()
	
		If LOG_NEW
			DebugLog "New TPivot"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TPivot"
		EndIf
	
	End Method

	Method CopyEntity:TPivot(parent_ent:TEntity=Null)

		' new piv
		Local piv:TPivot=New TPivot
		
		' copy contents of child list before adding parent
		For Local ent:TEntity=EachIn child_list
			ent.CopyEntity(piv)
		Next
		
		' lists
		
		' add parent, add to list
		piv.AddParent(parent_ent:TEntity)
		piv.EntityListAdd(entity_list)
		
		' add to collision entity list
		If collision_type<>0
			TCollisionPair.ent_lists[collision_type].AddLast(piv)
		EndIf
		
		' add to pick entity list
		If pick_mode<>0
			TPick.ent_list.AddLast(piv)
		EndIf
		
		' update matrix
		If piv.parent<>Null
			piv.mat.Overwrite(piv.parent.mat)
		Else
			piv.mat.LoadIdentity()
		EndIf
		
		' copy entity info
				
		piv.mat.Multiply(mat)
		
		piv.px#=px#
		piv.py#=py#
		piv.pz#=pz#
		piv.sx#=sx#
		piv.sy#=sy#
		piv.sz#=sz#
		piv.rx#=rx#
		piv.ry#=ry#
		piv.rz#=rz#
		piv.qw#=qw#
		piv.qx#=qx#
		piv.qy#=qy#
		piv.qz#=qz#

		piv.name$=name$
		piv.class$=class$
		piv.order=order
		piv.hide=False

		piv.cull_radius#=cull_radius#
		piv.radius_x#=radius_x#
		piv.radius_y#=radius_y#
		piv.box_x#=box_x#
		piv.box_y#=box_y#
		piv.box_z#=box_z#
		piv.box_w#=box_w#
		piv.box_h#=box_h#
		piv.box_d#=box_d#
		piv.pick_mode=pick_mode
		piv.obscurer=obscurer
		
		Return piv

	End Method
	
	Method FreeEntity()
	
		Super.FreeEntity() 
			
	End Method
	
	Function CreatePivot:TPivot(parent_ent:TEntity=Null)

		Local piv:TPivot=New TPivot
		piv.class$="Pivot"
		
		piv.AddParent(parent_ent:TEntity)
		piv.EntityListAdd(entity_list)

		' update matrix
		If piv.parent<>Null
			piv.mat.Overwrite(piv.parent.mat)
			piv.UpdateMat()
		Else
			piv.UpdateMat(True)
		EndIf

		Return piv

	End Function
		
	Method Update()

	End Method

End Type
