extends Node


@onready var current_level: int = 0


func _enter_tree() -> void:
	find_level_paths()


func start_new_level(new_level: String) -> void:
	SceneLoader.load_scene(new_level)
	current_level = Globals.levels.find(new_level) + 1


func start_new_game() -> void:
	current_level = 1
	start_new_level(Globals.levels[current_level - 1])


func find_level_paths() -> void:
	var dir: DirAccess = DirAccess.open("res://scenes/levels/")

	if not dir:
		print("An error occurred when trying to access the path.")
		return

	dir.list_dir_begin()
	var file_name: String = dir.get_next()

	while file_name != "":
		if not dir.current_is_dir():
			Globals.levels.append("res://scenes/levels/" + file_name)
		file_name = dir.get_next()

	# Sort files by number.
	Globals.levels.sort_custom(
			func(a: String, b: String) -> int: return a.naturalnocasecmp_to(b) < 0)


func _on_player_exiting_level() -> void:
	current_level += 1
	if Globals.levels.size() < current_level:
		SceneLoader.load_scene("res://scenes/menus/end_screen.tscn")
		return
	var new_level: String = Globals.levels[current_level - 1]
	start_new_level(new_level)
