extends Node


const LEVEL_ONE := preload("res://scenes/levels/level_one.tscn") as PackedScene
const LEVEL_TWO := preload("res://scenes/levels/level_two.tscn") as PackedScene
const LEVEL_THREE := preload("res://scenes/levels/level_three.tscn") as PackedScene

var level_paths: Array[PackedScene] = [
		LEVEL_ONE,
		LEVEL_TWO,
		LEVEL_THREE,
]

@onready var current_level: int = 2


func start_new_level() -> void:
	current_level += 1
	if level_paths.size() < current_level:
		#current_level -= 1
		get_tree().change_scene_to_file.call_deferred("res://scenes/end_screen.tscn")
		return
	var new_level: PackedScene = level_paths[current_level - 1]
	get_tree().change_scene_to_packed.call_deferred(new_level)


func _on_player_exiting_level() -> void:
	start_new_level()
