Type TModel

	Function LoadAnimB3D:TMesh(f_name$,parent_ent_ext:TEntity=Null)
	
		' Start file reading
		
		Local file:TStream
		
		file=OpenStream("littleendian::"+f_name$)
		
		If file=Null Then RuntimeError "File not found"
		
		' Dir stuff
	
		' get current dir - we'll change it back at end of func
		Local cd$=CurrentDir$()
		
		' get directory of b3d file name, set current dir to match it so we can find textures
		Local dir$=f_name$
		Local in:Int=0
		While Instr(dir$,"\",in+1)<>0
			in=Instr(dir$,"\",in+1)
		Wend
		While Instr(dir$,"/",in+1)<>0
			in=Instr(dir$,"/",in+1)
		Wend
		If in<>0 Then dir$=Left$(dir$,in-1)
	
		If dir$<>"" Then ChangeDir(dir$)
		
		' Header info
		
		Local tag$
		Local prev_tag$
		Local new_tag$
		
		tag$=ReadTag$(file)
		ReadLong(file)
		Local vno:Int=ReadInt(file)
		If tag$<>"BB3D" RuntimeError "Invalid b3d file"
		If vno/100>0 RuntimeError "Invalid b3d file version"
		
		' Locals
		
		Local size:Int
		Local node_level:Int=-1
		Local old_node_level:Int=-1
		Local node_pos:Int[100]
	
		' tex local vars
		Local tex_no:Int=0
		Local tex:TTexture[1]
		Local te_file$
		Local te_flags:Int
		Local te_blend:Int
		Local te_coords:Int
		Local te_u_pos#
		Local te_v_pos#
		Local te_u_scale#
		Local te_v_scale#
		Local te_angle#
		
		' brush local vars
		Local brush_no:Int
		Local brush:TBrush[1]
		Local b_no_texs:Int
		Local b_name$
		Local b_red#
		Local b_green#
		Local b_blue#
		Local b_alpha#
		Local b_shine#
		Local b_blend:Int
		Local b_fx:Int
		Local b_tex_id:Int
		
		' node local vars
		Local n_name$=""
		Local n_px#=0
		Local n_py#=0
		Local n_pz#=0
		Local n_sx#=0
		Local n_sy#=0
		Local n_sz#=0
		Local n_rx#=0
		Local n_ry#=0
		Local n_rz#=0
		Local n_qw#=0
		Local n_qx#=0
		Local n_qy#=0
		Local n_qz#=0
		
		' mesh local vars
		Local mesh:TMesh
		Local m_brush_id:Int
	
		' verts local vars
		Local v_mesh:TMesh
		Local v_surf:TSurface
		Local v_flags:Int
		Local v_tc_sets:Int
		Local v_tc_size:Int
		Local v_sz:Int
		Local v_x#
		Local v_y#
		Local v_z#
		Local v_nx#
		Local v_ny#
		Local v_nz#
		Local v_r#
		Local v_g#
		Local v_b#
		Local v_u#
		Local v_v#
		Local v_w#
		Local v_a#	
		Local v_id:Int
		
		' tris local vars
		Local surf:TSurface
		Local tr_brush_id:Int
		Local tr_sz:Int
		Local tr_vid:Int
		Local tr_vid0:Int
		Local tr_vid1:Int
		Local tr_vid2:Int
		Local tr_x#
		Local tr_y#
		Local tr_z#
		Local tr_nx#
		Local tr_ny#
		Local tr_nz#
		Local tr_r#
		Local tr_g#
		Local tr_b#
		Local tr_u#
		Local tr_v#
		Local tr_w#
		Local tr_a#	
		Local tr_no:Int
		
		' anim local vars
		Local a_flags:Int
		Local a_frames:Int
		Local a_fps:Int
					
		' bone local vars
		Local bo_bone:TBone
		Local bo_no_bones:Int
		Local bo_vert_id:Int
		Local bo_vert_w#
		
		' key local vars	
		Local k_flags:Int
		Local k_frame:Int
		Local k_px#
		Local k_py#
		Local k_pz#
		Local k_sx#
		Local k_sy#
		Local k_sz#
		Local k_qw#
		Local k_qx#
		Local k_qy#
		Local k_qz#
	
		Local parent_ent:TEntity=Null ' parent_ent - used to keep track of parent entitys within model, separate to parent_ent_ext paramater which is external to model
		Local root_ent:TEntity=Null
	
		Local last_ent:TEntity=Null ' last created entity, used for assigning parent ent in node code
	
		' Begin chunk (tag) reading
	
		Repeat
	
			new_tag$=ReadTag$(file)
			
			If NewTag(new_tag$)=True
			
				prev_tag$=tag$
				tag$=new_tag$
				ReadInt(file)
	
				size=ReadInt(file)
	
				' deal with nested nodes
				
				old_node_level=node_level
				If tag$="NODE"
				
					node_level=node_level+1
			
					If node_level>0
					
						Local fd:Int=0
						Repeat
							fd=StreamPos(file)-node_pos[node_level-1]
							If fd=>8
							
								node_level=node_level-1
	
							EndIf
		
						Until fd<8
					
					EndIf
					
					node_pos[node_level]=StreamPos(file)+size
																																																																									
				EndIf
				
				' up level
				If node_level>old_node_level
				
					If node_level>0
						parent_ent=last_ent
					Else
						parent_ent=Null
					EndIf
					
				EndIf
				
				' down level
				If node_level<old_node_level
				
					Local tent:TEntity=root_ent
					
					' get parent entity of last entity of new node level
					If node_level>1
					
						Local cc:Int
						For Local levs:Int=1 To node_level-2
							cc=tent.CountChildren()
							tent=tent.GetChild(cc)
						Next
						cc=tent.CountChildren()			
						tent=tent.GetChild(cc)
						parent_ent=tent
						
					EndIf
					
					If node_level=1 Then parent_ent=root_ent
					If node_level=0 Then parent_ent=Null
					
				EndIf
						
				' output debug tree
				Local tab$=""
				Local info$=""
				If tag$="NODE" And parent_ent<>Null Then info$=" (parent= "+parent_ent.name$+")"
				For Local i:Int=1 To node_level
					tab$=tab$+"-"
				Next
				' DebugLog tab$+tag$+info$
				
			Else
			
				tag$=""
				
			EndIf
	
			Select tag$
			
				Case "TEXS"
				
					'Local tex_no=0 ' moved to top
					
					new_tag$=ReadTag$(file)
					
					While NewTag(new_tag$)<>True And Eof(file)<>True
					
						te_file$=b3dReadString$(file)
						te_flags=ReadInt(file)
						te_blend=ReadInt(file)
						te_u_pos#=ReadFloat(file)
						te_v_pos#=ReadFloat(file)
						te_u_scale#=ReadFloat(file)
						te_v_scale#=ReadFloat(file)
						te_angle#=ReadFloat(file)
						
						' hidden tex coords 1 flag
						If te_flags&65536
							te_flags=te_flags-65536
							te_coords=1
						Else
							te_coords=0
						EndIf
						
						' convert tex angle from rad to deg
						te_angle=te_angle*(180.0/Pi)
	
						' create texture object so we can set texture values (blend etc) before loading texture
						tex[tex_no]=New TTexture
	
						' .flags and .file set in LoadTexture
						tex[tex_no].blend=te_blend
						tex[tex_no].coords=te_coords
						tex[tex_no].u_pos#=te_u_pos#
						tex[tex_no].v_pos#=te_v_pos#
						tex[tex_no].u_scale#=te_u_scale#
						tex[tex_no].v_scale#=te_v_scale#
						tex[tex_no].angle#=te_angle#
									
						' load texture, providing texture we created above as parameter.
						' if a texture exists with all the same values as above (blend etc), the existing texture will be returned.
						' if not then the texture created above (supplied as param below) will be returned
						tex[tex_no]=TTexture.LoadTexture:TTexture(te_file$,te_flags,tex[tex_no])
											
						tex_no=tex_no+1
						tex=tex:TTexture[..tex_no+1] ' resize array +1
	
						new_tag$=ReadTag$(file)
						
					Wend
			
				Case "BRUS"
						
					'Local brush_no=0 ' moved to top
					
					b_no_texs=ReadInt(file)
					
					new_tag$=ReadTag$(file)
					
					While NewTag(new_tag$)<>True And Eof(file)<>True
	
						b_name$=b3dReadString$(file)
						b_red#=ReadFloat(file)
						b_green#=ReadFloat(file)
						b_blue#=ReadFloat(file)
						b_alpha#=ReadFloat(file)
						b_shine#=ReadFloat(file)
						b_blend=ReadInt(file)
						b_fx=ReadInt(file)
						
						brush[brush_no]=TBrush.CreateBrush:TBrush()
						brush[brush_no].no_texs=b_no_texs
						brush[brush_no].name$=b_name$
						brush[brush_no].red#=b_red#
						brush[brush_no].green#=b_green#
						brush[brush_no].blue#=b_blue#
						brush[brush_no].alpha#=b_alpha#
						brush[brush_no].shine#=b_shine#
						brush[brush_no].blend=b_blend
						brush[brush_no].fx=b_fx
				
						For Local ix:Int=0 To b_no_texs-1
						
							b_tex_id=ReadInt(file)
			
							If b_tex_id>=0
								brush[brush_no].tex[ix]=tex[b_tex_id]
							Else
								brush[brush_no].tex[ix]=Null
							EndIf
			
						Next
		
						brush_no=brush_no+1
						brush=brush:TBrush[..brush_no+1] ' resize array +1
						
						new_tag$=ReadTag$(file)
					
					Wend
					
				Case "NODE"
	
					new_tag$=ReadTag$(file)
					
					n_name$=b3dReadString$(file)
					n_px#=ReadFloat(file)
					n_py#=ReadFloat(file)
					n_pz#=ReadFloat(file)*-1
					n_sx#=ReadFloat(file)
					n_sy#=ReadFloat(file)
					n_sz#=ReadFloat(file)
					n_qw#=ReadFloat(file)
					n_qx#=ReadFloat(file)
					n_qy#=ReadFloat(file)
					n_qz#=ReadFloat(file)
					Local pitch#=0
					Local yaw#=0
					Local roll#=0
					TQuaternion.QuatToEuler(n_qw#,n_qx#,n_qy#,-n_qz#,pitch#,yaw#,roll#)
					n_rx#=-pitch#
					n_ry#=yaw#
					n_rz#=roll#
	
					new_tag$=ReadTag$(file)
					
					If new_tag$="NODE" Or new_tag$="ANIM"
		
						' make 'piv' entity a mesh, not a pivot, as B3D does
						Local piv:TMesh=New TMesh
						piv.class$="Mesh"
			
						piv.name$=n_name$
						piv.px#=n_px#
						piv.py#=n_py#
						piv.pz#=n_pz#
						piv.sx#=n_sx#
						piv.sy#=n_sy#
						piv.sz#=n_sz#
						piv.rx#=n_rx#
						piv.ry#=n_ry#
						piv.rz#=n_rz#
						piv.qw#=n_qw#
						piv.qx#=n_qx#
						piv.qy#=n_qy#
						piv.qz#=n_qz#
								
						'piv.UpdateMat(True)
						piv.EntityListAdd(TEntity.entity_list)
						last_ent=piv
			
						' root ent?
						If root_ent=Null Then root_ent=piv
			
						' if ent is root ent, and external parent specified, add parent
						If root_ent=piv Then piv.AddParent(parent_ent_ext)
			
						' if ent nested then add parent
						If node_level>0 Then piv.AddParent(parent_ent)
						
						TQuaternion.QuatToMat(-n_qw#,n_qx#,n_qy#,-n_qz#,piv.mat)
										
						piv.mat.grid[3,0]=n_px#
						piv.mat.grid[3,1]=n_py#
						piv.mat.grid[3,2]=n_pz#
						
						piv.mat.Scale(n_sx#,n_sy#,n_sz#)
							
						If piv.parent<>Null
							Local new_mat:TMatrix=piv.parent.mat.Copy()
							new_mat.Multiply(piv.mat)
							piv.mat.Overwrite(new_mat)'.Multiply(mat)
						EndIf				
				
					EndIf
			
				Case "MESH"
						
					m_brush_id=ReadInt(file)
					
					mesh=New TMesh
					mesh.class$="Mesh"
					mesh.name$=n_name$
					mesh.px#=n_px#
					mesh.py#=n_py#
					mesh.pz#=n_pz#
					mesh.sx#=n_sx#
					mesh.sy#=n_sy#
					mesh.sz#=n_sz#
					mesh.rx#=n_rx#
					mesh.ry#=n_ry#
					mesh.rz#=n_rz#
					mesh.qw#=n_qw#
					mesh.qx#=n_qx#
					mesh.qy#=n_qy#
					mesh.qz#=n_qz#
					
					mesh.EntityListAdd(TEntity.entity_list)
					last_ent=mesh
					
					' root ent?
					If root_ent=Null Then root_ent=mesh
					
					' if ent is root ent, and external parent specified, add parent
					If root_ent=mesh Then mesh.AddParent(parent_ent_ext)
					
					' if ent nested then add parent
					If node_level>0 Then mesh.AddParent(parent_ent)
	
					TQuaternion.QuatToMat(-n_qw#,n_qx#,n_qy#,-n_qz#,mesh.mat)
									
					mesh.mat.grid[3,0]=n_px#
					mesh.mat.grid[3,1]=n_py#
					mesh.mat.grid[3,2]=n_pz#
					
					mesh.mat.Scale(n_sx#,n_sy#,n_sz#)
					
					If mesh.parent<>Null
						Local new_mat:TMatrix=mesh.parent.mat.Copy()
						new_mat.Multiply(mesh.mat)
						mesh.mat.Overwrite(new_mat)'.Multiply(mat)
					EndIf				
	
				Case "VRTS"
				
					If v_mesh<>Null Then v_mesh=Null
					If v_surf<>Null Then v_surf=Null
						
					v_mesh=New TMesh
					v_surf=v_mesh.CreateSurface()
					v_flags=ReadInt(file)
					v_tc_sets=ReadInt(file)
					v_tc_size=ReadInt(file)
					v_sz=12+v_tc_sets*v_tc_size*4
					If v_flags & 1 Then v_sz=v_sz+12
					If v_flags & 2 Then v_sz=v_sz+16
	
					new_tag$=ReadTag$(file)
	
					While NewTag(new_tag$)<>True And Eof(file)<>True
				
						v_x#=ReadFloat(file)
						v_y#=ReadFloat(file)
						v_z#=ReadFloat(file)
						
						If v_flags&1
							v_nx#=ReadFloat(file)
							v_ny#=ReadFloat(file)
							v_nz#=ReadFloat(file)
						EndIf
						
						If v_flags&2
							v_r#=ReadFloat(file)*255.0 ' *255 as VertexColor requires 0-255 values
							v_g#=ReadFloat(file)*255.0
							v_b#=ReadFloat(file)*255.0
							v_a#=ReadFloat(file)
						EndIf
						
						v_id=v_surf.AddVertex(v_x,v_y,v_z)
						v_surf.VertexColor(v_id,v_r,v_g,v_b,v_a)
						v_surf.VertexNormal(v_id,v_nx,v_ny,v_nz)
						
						'read tex coords...
						For Local j:Int=0 To v_tc_sets-1 ' texture coords per vertex - 1 for simple uv, 8 max
							For Local k:Int=1 To v_tc_size ' components per set - 2 for simple uv, 4 max
								If k=1 v_u#=ReadFloat(file)
								If k=2 v_v#=ReadFloat(file)
								If k=3 v_w#=ReadFloat(file)
							Next
							If j=0 Or j=1 Then v_surf.VertexTexCoords(v_id,v_u,v_v,v_w,j)
						Next
							
						new_tag$=ReadTag$(file)
														
					Wend
					
				Case "TRIS"
							
					Local old_tr_brush_id:Int=tr_brush_id
					tr_brush_id=ReadInt(file)
	
					' don't create new surface if tris chunk has same brush as chunk immediately before it
					If prev_tag$<>"TRIS" Or tr_brush_id<>old_tr_brush_id
					
						' no further tri data for this surf - trim verts
						If prev_tag$="TRIS" Then TrimVerts(surf)
					
						' new surf - copy arrays
						surf=mesh.CreateSurface()
						surf.vert_coords=v_surf.vert_coords[..]
						surf.vert_col=v_surf.vert_col[..]
						surf.vert_norm=v_surf.vert_norm[..]
						surf.vert_tex_coords0=v_surf.vert_tex_coords0[..]
						surf.vert_tex_coords1=v_surf.vert_tex_coords1[..]
						surf.no_verts=v_surf.no_verts
							
					EndIf
	
					tr_sz=12
						
					new_tag$=ReadTag$(file)
	
					While NewTag(new_tag$)<>True And Eof(file)<>True
					
						tr_vid0=ReadInt(file)
						tr_vid1=ReadInt(file)
						tr_vid2=ReadInt(file)
				
						' Find out minimum and maximum vertex indices - used for TrimVerts func after
						' (TrimVerts used due to .b3d format not being an exact fit with Blitz3D itself)
						If tr_vid0<surf.vmin Then surf.vmin=tr_vid0
						If tr_vid1<surf.vmin Then surf.vmin=tr_vid1
						If tr_vid2<surf.vmin Then surf.vmin=tr_vid2
						
						If tr_vid0>surf.vmax Then surf.vmax=tr_vid0
						If tr_vid1>surf.vmax Then surf.vmax=tr_vid1
						If tr_vid2>surf.vmax Then surf.vmax=tr_vid2
				
						surf.AddTriangle(tr_vid0,tr_vid1,tr_vid2)
						
						new_tag$=ReadTag$(file)
	
					Wend
					
					If m_brush_id<>-1 Then mesh.PaintEntity(brush:TBrush[m_brush_id])
					If tr_brush_id<>-1 Then surf.PaintSurface(brush:TBrush[tr_brush_id])
					
					If v_flags&1=0 And new_tag$<>"TRIS" Then mesh.UpdateNormals() ' if no normal data supplied and no further tri data then update normals
	
					' no further tri data for this surface - trim verts
					If new_tag$<>"TRIS" Then TrimVerts(surf)

				Case "ANIM"
				
					a_flags=ReadInt(file)
					a_frames=ReadInt(file)
					a_fps=ReadFloat(file)
					
					If mesh<>Null
					
						mesh.anim=True
					
						'mesh.frames=a_frames
						mesh.anim_seqs_first[0]=0
						mesh.anim_seqs_last[0]=a_frames
						
						' create anim surfs, copy vertex coords array, add to anim_surf_list
						For Local surf:TSurface=EachIn mesh.surf_list
						
							Local anim_surf:TSurface=New TSurface
							ListAddLast(mesh.anim_surf_list,anim_surf)
						
							anim_surf.no_verts=surf.no_verts
										
							anim_surf.vert_coords=surf.vert_coords[..]
						
							anim_surf.vert_bone1_no=anim_surf.vert_bone1_no[..surf.no_verts+1]
							anim_surf.vert_bone2_no=anim_surf.vert_bone2_no[..surf.no_verts+1]
							anim_surf.vert_bone3_no=anim_surf.vert_bone3_no[..surf.no_verts+1]
							anim_surf.vert_bone4_no=anim_surf.vert_bone4_no[..surf.no_verts+1]
							anim_surf.vert_weight1=anim_surf.vert_weight1[..surf.no_verts+1]
							anim_surf.vert_weight2=anim_surf.vert_weight2[..surf.no_verts+1]
							anim_surf.vert_weight3=anim_surf.vert_weight3[..surf.no_verts+1]
							anim_surf.vert_weight4=anim_surf.vert_weight4[..surf.no_verts+1]
							
							' transfer vmin/vmax values for using with TrimVerts func after
							anim_surf.vmin=surf.vmin
							anim_surf.vmax=surf.vmax
						
						Next
												
					EndIf
	
				Case "BONE"
				
					Local ix:Int=0
					
					new_tag$=ReadTag$(file)
				
					bo_bone:TBone=New TBone
					bo_no_bones=bo_no_bones+1
					
					While NewTag(new_tag$)<>True And Eof(file)<>True
				
						bo_vert_id=ReadInt(file)
						bo_vert_w#=ReadFloat(file)
						
						' assign weight values, with the strongest weight in vert_weight[1], and weakest in vert_weight[4]
							
						Local anim_surf:TSurface			
						For anim_surf:TSurface=EachIn mesh.anim_surf_list
						
							If bo_vert_id>=anim_surf.vmin And bo_vert_id<=anim_surf.vmax
						
								If anim_surf<>Null
								
									Local vid:Int=bo_vert_id-anim_surf.vmin
								
									If bo_vert_w#>anim_surf.vert_weight1[vid]
														
										anim_surf.vert_bone4_no[vid]=anim_surf.vert_bone3_no[vid]
										anim_surf.vert_weight4[vid]=anim_surf.vert_weight3[vid]
										
										anim_surf.vert_bone3_no[vid]=anim_surf.vert_bone2_no[vid]
										anim_surf.vert_weight3[vid]=anim_surf.vert_weight2[vid]
										
										anim_surf.vert_bone2_no[vid]=anim_surf.vert_bone1_no[vid]
										anim_surf.vert_weight2[vid]=anim_surf.vert_weight1[vid]
										
										anim_surf.vert_bone1_no[vid]=bo_no_bones
										anim_surf.vert_weight1[vid]=bo_vert_w#
																
									Else If bo_vert_w#>anim_surf.vert_weight2[vid]
									
										anim_surf.vert_bone4_no[vid]=anim_surf.vert_bone3_no[vid]
										anim_surf.vert_weight4[vid]=anim_surf.vert_weight3[vid]
										
										anim_surf.vert_bone3_no[vid]=anim_surf.vert_bone2_no[vid]
										anim_surf.vert_weight3[vid]=anim_surf.vert_weight2[vid]
										
										anim_surf.vert_bone2_no[vid]=bo_no_bones
										anim_surf.vert_weight2[vid]=bo_vert_w#
																							
									Else If bo_vert_w#>anim_surf.vert_weight3[vid]
									
										anim_surf.vert_bone4_no[vid]=anim_surf.vert_bone3_no[vid]
										anim_surf.vert_weight4[vid]=anim_surf.vert_weight3[vid]
						
										anim_surf.vert_bone3_no[vid]=bo_no_bones
										anim_surf.vert_weight3[vid]=bo_vert_w#
							
									Else If bo_vert_w#>anim_surf.vert_weight4[vid]
									
										anim_surf.vert_bone4_no[vid]=bo_no_bones
										anim_surf.vert_weight4[vid]=bo_vert_w#
												
									EndIf
													
								EndIf
								
							EndIf
							
						Next
						
						new_tag$=ReadTag$(file)
							
					Wend

					bo_bone.class$="Bone"
					bo_bone.name$=n_name$
					bo_bone.px#=n_px#
					bo_bone.py#=n_py#
					bo_bone.pz#=n_pz#
					bo_bone.sx#=n_sx#
					bo_bone.sy#=n_sy#
					bo_bone.sz#=n_sz#
					bo_bone.rx#=n_rx#
					bo_bone.ry#=n_ry#
					bo_bone.rz#=n_rz#
					bo_bone.qw#=n_qw#
					bo_bone.qx#=n_qx#
					bo_bone.qy#=n_qy#
					bo_bone.qz#=n_qz#
					
					bo_bone.n_px#=n_px#
					bo_bone.n_py#=n_py#
					bo_bone.n_pz#=n_pz#
					bo_bone.n_sx#=n_sx#
					bo_bone.n_sy#=n_sy#
					bo_bone.n_sz#=n_sz#
					bo_bone.n_rx#=n_rx#
					bo_bone.n_ry#=n_ry#
					bo_bone.n_rz#=n_rz#
					bo_bone.n_qw#=n_qw#
					bo_bone.n_qx#=n_qx#
					bo_bone.n_qy#=n_qy#
					bo_bone.n_qz#=n_qz#
				
					bo_bone.keys=New TAnimationKeys
					bo_bone.keys.frames=a_frames
					bo_bone.keys.flags=bo_bone.keys.flags[..a_frames+1]
					bo_bone.keys.px=bo_bone.keys.px[..a_frames+1]
					bo_bone.keys.py=bo_bone.keys.py[..a_frames+1]
					bo_bone.keys.pz=bo_bone.keys.pz[..a_frames+1]
					bo_bone.keys.sx=bo_bone.keys.sx[..a_frames+1]
					bo_bone.keys.sy=bo_bone.keys.sy[..a_frames+1]
					bo_bone.keys.sz=bo_bone.keys.sz[..a_frames+1]
					bo_bone.keys.qw=bo_bone.keys.qw[..a_frames+1]
					bo_bone.keys.qx=bo_bone.keys.qx[..a_frames+1]
					bo_bone.keys.qy=bo_bone.keys.qy[..a_frames+1]
					bo_bone.keys.qz=bo_bone.keys.qz[..a_frames+1]
							
					' root ent?
					If root_ent=Null Then root_ent=bo_bone
					
					' if ent nested then add parent
					If node_level>0 Then bo_bone.AddParent(parent_ent)
					
					TQuaternion.QuatToMat(-bo_bone.n_qw#,bo_bone.n_qx#,bo_bone.n_qy#,-bo_bone.n_qz#,bo_bone.mat)
					
					bo_bone.mat.grid[3,0]=bo_bone.n_px#
					bo_bone.mat.grid[3,1]=bo_bone.n_py#
					bo_bone.mat.grid[3,2]=bo_bone.n_pz#
					
					If bo_bone.parent<>Null And TBone(bo_bone.parent)<>Null ' And... onwards needed to prevent inv_mat being incorrect if external parent supplied
						Local new_mat:TMatrix=bo_bone.parent.mat.Copy()
						new_mat.Multiply(bo_bone.mat)
						bo_bone.mat.Overwrite(new_mat)
					EndIf

					bo_bone.inv_mat=bo_bone.mat.Inverse()
				
					If new_tag$<>"KEYS"
						bo_bone.EntityListAdd(TEntity.entity_list)
						mesh.bones=mesh.bones[..bo_no_bones]
						mesh.bones[bo_no_bones-1]=bo_bone
						last_ent=bo_bone
					EndIf
		
				Case "KEYS"
				
					k_flags=ReadInt(file)
				
					new_tag$=ReadTag$(file)
	
					While NewTag(new_tag$)<>True And Eof(file)<>True
				
						k_frame=ReadInt(file)
						
						If(k_flags&1)
							k_px#=ReadFloat(file)
							k_py#=ReadFloat(file)
							k_pz#=-ReadFloat(file)
						EndIf
						If(k_flags&2)
							k_sx#=ReadFloat(file)
							k_sy#=ReadFloat(file)
							k_sz#=ReadFloat(file)
						EndIf
						If(k_flags&4)
							k_qw#=-ReadFloat(file)
							k_qx#=ReadFloat(file)
							k_qy#=ReadFloat(file)
							k_qz#=-ReadFloat(file)
						EndIf
						
						If bo_bone<>Null ' check if bo_bone exists - it won't for non-boned, keyframe anims
						
							bo_bone.keys.flags[k_frame]=bo_bone.keys.flags[k_frame]+k_flags
							If(k_flags&1)
								bo_bone.keys.px[k_frame]=k_px
								bo_bone.keys.py[k_frame]=k_py
								bo_bone.keys.pz[k_frame]=k_pz
							EndIf
							If(k_flags&2)
								bo_bone.keys.sx[k_frame]=k_sx
								bo_bone.keys.sy[k_frame]=k_sy
								bo_bone.keys.sz[k_frame]=k_sz
							EndIf
							If(k_flags&4)
								bo_bone.keys.qw[k_frame]=k_qw
								bo_bone.keys.qx[k_frame]=k_qx
								bo_bone.keys.qy[k_frame]=k_qy
								bo_bone.keys.qz[k_frame]=k_qz
							EndIf
						
						EndIf
						
						new_tag$=ReadTag$(file)
							
					Wend
					
					If new_tag$<>"KEYS"
					
						If bo_bone<>Null ' check if bo_bone exists - it won't for non-boned, keyframe anims
					
							bo_bone.EntityListAdd(TEntity.entity_list)
							mesh.bones=mesh.bones[..bo_no_bones]
							mesh.bones[bo_no_bones-1]=bo_bone
							last_ent=bo_bone
						
						EndIf
						
					EndIf
					
				Default
				
					ReadByte(file)
	
			End Select
		
		Until Eof(file)
		
		CloseStream file
	
		ChangeDir(cd$)
				
		Return TMesh(root_ent)
	
	End Function

	' Due to the .b3d format not being an exact fit with B3D, we need to slice vert arrays
	' Otherwise we duplicate all vert information per surf
	Function TrimVerts(surf:TSurface Var)
				
		If surf.no_tris=0 Then Return ' surf has no tri info, do not trim
				
		Local vmin:Int=surf.vmin
		Local vmax:Int=surf.vmax

		surf.vert_coords=surf.vert_coords[vmin*3..vmax*3+3]
		surf.vert_col=surf.vert_col[vmin*4..vmax*4+4]
		surf.vert_norm=surf.vert_norm[vmin*3..vmax*3+3]
		surf.vert_tex_coords0=surf.vert_tex_coords0[vmin*2..vmax*2+2]
		surf.vert_tex_coords1=surf.vert_tex_coords1[vmin*2..vmax*2+2]
		
		For Local i:Int=0 Until (surf.no_tris*3)+3
			surf.tris[i]=surf.tris[i]-vmin ' reassign vertex indices
		Next
		
		surf.no_verts=(vmax-vmin)+1
		
	End Function

	Function b3dReadString:String(file:TStream Var)
		Local t$=""
		Repeat
			Local ch:Int=ReadByte(file)
			If ch=0 Return t$
			t$=t$+Chr$(ch)
		Forever
	End Function
	
	Function ReadTag$(file:TStream)
		
		Local pos:Int=StreamPos(file)
		
		Local tag$=""
		
		For Local i:Int = 1 To 4
			
			If StreamPos(file) < StreamSize(file) Then
				Local rb:Int = ReadByte(file)
			
				tag:String = tag:String + Chr:String(rb)
			EndIf
			
		Next
			
		SeekStream(file,pos)
		
		Return tag$
		
	End Function
	
	Function NewTag:int(tag$)
	
		Select tag$
		
			Case "TEXS" Return True
			Case "BRUS" Return True
			Case "NODE" Return True
			Case "ANIM" Return True
			Case "MESH" Return True
			Case "VRTS" Return True
			Case "TRIS" Return True
			Case "BONE" Return True
			Case "KEYS" Return True
			Default Return False
		
		End Select
	
	End Function

End Type
