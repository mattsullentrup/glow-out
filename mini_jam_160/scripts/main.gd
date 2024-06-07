extends Node


#func _on_tree_entered() -> void:
	##print(ProjectSettings.get_setting("rendering/2d/snap/snap_2d_transforms_to_pixel"))
	#RenderingServer.viewport_set_snap_2d_transforms_to_pixel(get_viewport().get_viewport_rid(), true)
	#ProjectSettings.save()
	##print(ProjectSettings.get_setting("rendering/2d/snap/snap_2d_transforms_to_pixel"))
#
#
#func _on_pixel_transforms_button_toggled(toggled_on: bool) -> void:
	#RenderingServer.viewport_set_snap_2d_transforms_to_pixel(get_viewport().get_viewport_rid(), toggled_on)
	#print(ProjectSettings.get_setting("rendering/2d/snap/snap_2d_transforms_to_pixel"))
#
#
#func _on_node_physics_interp_button_toggled(toggled_on: bool) -> void:
	#if toggled_on:
		#physics_interpolation_mode = PHYSICS_INTERPOLATION_MODE_ON
	#else:
		#physics_interpolation_mode = PHYSICS_INTERPOLATION_MODE_OFF
#
#
#func _on_settings_physics_interp_button_toggled(toggled_on: bool) -> void:
	##SceneTree.physics_interpolation = toggled_on
	#get_tree().physics_interpolation = toggled_on
#
#
#func _on_jitter_fix_button_toggled(toggled_on: bool) -> void:
	#Engine.physics_jitter_fix = 0.5 if toggled_on else 0.0
	#print(Engine.physics_jitter_fix)
