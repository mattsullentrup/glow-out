extends Node


const LEVEL_ONE := preload("res://scenes/levels/level_one.tscn") as PackedScene

var level_paths: Array[PackedScene] = [
		LEVEL_ONE,
]

@onready var current_level: int


func start_new_level() -> void:
	current_level += 1
	if level_paths.size() < current_level:
		current_level -= 1
	var new_level: PackedScene = level_paths[current_level - 1]
	get_tree().change_scene_to_packed.call_deferred(new_level)


func _on_player_exiting_level() -> void:
	start_new_level()
