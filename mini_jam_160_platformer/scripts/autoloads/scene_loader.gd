extends Node


const LOADING_SCREEN = preload("res://scenes/loading_screen.tscn")


var scene_path: String
var is_loading := false


func _process(_delta: float) -> void:
	if not is_loading:
		return

	var progress: Array = []
	var status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(
			scene_path, progress
	)

	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		create_loading_screen(progress)
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene: PackedScene = ResourceLoader.load_threaded_get(scene_path)
		get_tree().change_scene_to_packed(new_scene)
		is_loading = false
	else:
		printerr("loading fucked up")


func create_loading_screen(progress: Array) -> void:
	var loading_screen: LoadingScreen = LOADING_SCREEN.instantiate()
	if loading_screen is LoadingScreen:
		get_tree().root.call_deferred("add_child", loading_screen)
		loading_screen.progress = progress


func load_scene(path: String) -> void:
	if ResourceLoader.has_cached(path):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path)

	var current_scene: Node = get_tree().current_scene
	Globals.play_exit_transition(current_scene)
	await current_scene.tree_exited

	is_loading = true
	scene_path = path
