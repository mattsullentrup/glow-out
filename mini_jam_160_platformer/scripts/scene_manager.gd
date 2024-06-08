extends Node


func load_new_room(new_scene: PackedScene, exit_direction: Globals.Directions) -> void:
	get_tree().change_scene_to_packed.call_deferred(new_scene)
	new_scene.previous_player_direction = exit_direction
