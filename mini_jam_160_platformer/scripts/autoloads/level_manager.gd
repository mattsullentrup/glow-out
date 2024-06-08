extends Node


func load_new_level(new_scene: PackedScene, exit_direction: Globals.Directions) -> void:
	get_tree().change_scene_to_packed.call_deferred(new_scene)
	new_scene.previous_player_direction = exit_direction

const LEVEL_1: String = "res://scenes/levels/level_1.tscn"
const LEVEL_2: String = "res://scenes/levels/level_2.tscn"
const LEVEL_3: String = "res://scenes/levels/level_3.tscn"
const LEVEL_4: String = "res://scenes/levels/level_4.tscn"
const LEVEL_5: String = "res://scenes/levels/level_5.tscn"

var levels: Array[String] = [LEVEL_1, LEVEL_2, LEVEL_3, LEVEL_4, LEVEL_5]
var total_collectables: int
var dots_collected: int
var amount_collected_this_level: int
var time_taken: int

@onready var current_level: int


func start_new_level() -> void:
	amount_collected_this_level = 0
	current_level += 1
	if levels.size() < current_level:
		get_tree().change_scene_to_file.call_deferred("res://scenes/results_screen.tscn")
		return
		#current_level -= 1
	var new_level: String = levels[current_level - 1]
	get_tree().change_scene_to_file.call_deferred(new_level)


func _on_player_exiting_level() -> void:
	start_new_level()
