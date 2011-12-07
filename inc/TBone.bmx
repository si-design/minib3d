Type TBone Extends TEntity

	Field n_px#,n_py#,n_pz#,n_sx#,n_sy#,n_sz#,n_rx#,n_ry#,n_rz#,n_qw#,n_qx#,n_qy#,n_qz#

	Field keys:TAnimationKeys
	
	' additional matrices used for animation purposes
	Field mat2:TMatrix=New TMatrix
	Field inv_mat:TMatrix ' set in TModel, when loading anim mesh
	Field tform_mat:TMatrix=New TMatrix
	
	Field kx#,ky#,kz#,kqw#,kqx#,kqy#,kqz# ' used to store current keyframe in AnimateMesh, for use with transition

	Method New()
	
		If LOG_NEW
			DebugLog "New TBone"
		EndIf
	
	End Method
	
	Method Delete()
	
		If LOG_DEL
			DebugLog "Del TBone"
		EndIf
	
	End Method
	
	Method CopyEntity:TBone(parent_ent:TEntity=Null)
	
		' new bone
		Local bone:TBone=New TBone
		
		' copy contents of child list before adding parent
		For Local ent:TEntity=EachIn child_list
			ent.CopyEntity(bone)
		Next
		
		' add parent, add to list
		bone.AddParent(parent_ent:TEntity)
		bone.EntityListAdd(entity_list)
		
		' update matrix
		If bone.parent<>Null
			bone.mat.Overwrite(bone.parent.mat)
		Else
			bone.mat.LoadIdentity()
		EndIf
		
		' copy entity info
		
		bone.mat.Multiply(mat)

		bone.px#=px#
		bone.py#=py#
		bone.pz#=pz#
		bone.sx#=sx#
		bone.sy#=sy#
		bone.sz#=sz#
		bone.rx#=rx#
		bone.ry#=ry#
		bone.rz#=rz#
		bone.qw#=qw#
		bone.qx#=qx#
		bone.qy#=qy#
		bone.qz#=qz#
		
		bone.name$=name$
		bone.class$=class$
		bone.order=order
		bone.hide=False
		
		' copy bone info
		
		bone.n_px#=n_px#
		bone.n_py#=n_py#
		bone.n_pz#=n_pz#
		bone.n_sx#=n_sx#
		bone.n_sy#=n_sy#
		bone.n_sz#=n_sz#
		bone.n_rx#=n_rx#
		bone.n_ry#=n_ry#
		bone.n_rz#=n_rz#
		bone.n_qw#=n_qw#
		bone.n_qx#=n_qx#
		bone.n_qy#=n_qy#
		bone.n_qz#=n_qz#
	
		bone.keys=keys.Copy()
		
		bone.kx#=kx#
		bone.ky#=ky#
		bone.kz#=kz#
		bone.kqw#=kqw#
		bone.kqx#=kqx#
		bone.kqy#=kqy#
		bone.kqz#=kqz#
		
		bone.mat2=mat2.Copy()
		bone.inv_mat=inv_mat.Copy()
		bone.tform_mat=tform_mat.Copy()

		Return bone
	
	End Method
		
	Method FreeEntity()
	
		Super.FreeEntity() 
	
		keys=Null
	
	End Method

	' Same as UpdateChildren in TEntity except it negates z value of bone matrices so that children are transformed
	' in correct z direction
	Function UpdateBoneChildren(ent_p:TEntity)
		Return
		For Local ent_c:TEntity=EachIn ent_p.child_list
			
			If TBone(ent_c)=Null ' if child is not a bone
						
				Local mat:TMatrix=ent_p.mat.Copy()
			
				' if parent is a bone, negate z value of matrix
				If TBone(ent_p)<>Null
					mat.grid[3,2]=-mat.grid[3,2]
					'mat=TBone(ent_p).tform_mat
				EndIf
			
				ent_c.mat.Overwrite(mat)
				ent_c.UpdateMat()
				
			EndIf
			
			UpdateChildren(ent_c:TEntity)
					
		Next
	
	End Function
	
	Method Update()
	
	End Method

End Type
