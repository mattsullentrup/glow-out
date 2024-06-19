extends Node


const LOADING_SCREEN = preload("res://scenes/loading_screen.tscn")


var scene_path: String
var loading_screen_scene_instance: Node
var loading := false


func _process(_delta: float) -> void:
	if not loading:
		return

	var progress: Array = []
	var status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(
			scene_path, progress
	)

	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		var progress_bar: ProgressBar = loading_screen_scene_instance.get_node(
				"MarginContainer/ProgressBar"
		)
		progress_bar.value = progress[0] * 100
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene: PackedScene = ResourceLoader.load_threaded_get(scene_path)
		get_tree().change_scene_to_packed(new_scene)
		loading_screen_scene_instance.queue_free()
		loading = false
	else:
		printerr("Loading fucked up")


func load_scene(path: String) -> void:
	if ResourceLoader.has_cached(path):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path)

	var current_scene: Node = get_tree().current_scene
	#current_scene.queue_free()
	Globals.play_exit_transition(current_scene)
	await current_scene.tree_exited

	loading_screen_scene_instance = LOADING_SCREEN.instantiate()
	get_tree().root.call_deferred("add_child", loading_screen_scene_instance)

	loading = true
	scene_path = path
