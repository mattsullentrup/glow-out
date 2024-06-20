extends Node


signal progress_changed(progress: float)

const LOADING_SCREEN = preload("res://scenes/loading_screen.tscn")

var scene_path: String
#var is_loading := false
var progress: Array = []


func _process(_delta: float) -> void:
	#if not is_loading:
		#return

	check_load_status()


func check_load_status() -> void:
	var status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(
			scene_path, progress)

	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_changed.emit(progress[0])
		ResourceLoader.THREAD_LOAD_LOADED:
			var new_scene: PackedScene = ResourceLoader.load_threaded_get(scene_path)
			progress_changed.emit(1.0)
			get_tree().change_scene_to_packed(new_scene)
		ResourceLoader.THREAD_LOAD_FAILED:
			printerr("loading fucked up")
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			print("not loading")
			set_process(false)


func create_loading_screen() -> void:
	var loading_screen: LoadingScreen = LOADING_SCREEN.instantiate()
	if loading_screen is LoadingScreen:
		get_tree().root.call_deferred("add_child", loading_screen)
		progress_changed.connect(loading_screen.update_progress_bar)
		#loading_screen.progress = progress


func load_scene(path: String) -> void:
	if ResourceLoader.has_cached(path):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path)

	create_loading_screen()
	set_process(true)
	scene_path = path
	var current_scene: Node = get_tree().current_scene
	Globals.play_exit_transition(current_scene)
	await current_scene.tree_exited
