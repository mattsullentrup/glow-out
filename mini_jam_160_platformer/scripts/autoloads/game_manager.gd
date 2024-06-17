extends Node


#const LEVEL_ONE := preload("res://scenes/levels/level_one.tscn") as PackedScene
#const LEVEL_TWO := preload("res://scenes/levels/level_two.tscn") as PackedScene
#const LEVEL_THREE := preload("res://scenes/levels/level_three.tscn") as PackedScene

#var level_paths: Array[PackedScene] = [
		#LEVEL_ONE,
		#LEVEL_TWO,
		#LEVEL_THREE,
#]

@onready var current_level: int = 1


func _enter_tree() -> void:
	preload_levels()


func start_new_level() -> void:
	if Globals.levels.size() < current_level:
		#current_level -= 1
		get_tree().change_scene_to_file.call_deferred("res://scenes/end_screen.tscn")
		return
	var new_level: PackedScene = Globals.levels[current_level - 1]
	get_tree().change_scene_to_packed.call_deferred(new_level)
	current_level += 1


func start_new_game() -> void:
	current_level = 1
	start_new_level()


func preload_levels() -> void:
	var dir = DirAccess.open("res://scenes/levels/")

	if not dir:
		print("An error occurred when trying to access the path.")
		return

	dir.list_dir_begin()
	var file_name = dir.get_next()
	var files: Array[String] = []

	while file_name != "":
		if not dir.current_is_dir():
			files.append(file_name)
		file_name = dir.get_next()

	# Sort files by number.
	files.sort_custom(func(a, b): return a.naturalnocasecmp_to(b) < 0)

	for file in files:
		var level := load("res://scenes/levels/" + file) as PackedScene
		Globals.levels.append(level)


func _on_player_exiting_level() -> void:
	start_new_level()
