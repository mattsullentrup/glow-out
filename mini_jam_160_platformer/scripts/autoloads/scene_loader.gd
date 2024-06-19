extends Node


const LOADING_SCREEN = preload("res://scenes/loading_screen.tscn")


var scene_to_load_path: String
var loading_screen_scene_instance: Node
var loading := false


func _process(_delta: float) -> void:
	if not loading:
		return

	var progress = []
	var status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(
			scene_to_load_path, progress
	)

	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		var progress_bar: ProgressBar = loading_screen_scene_instance.get_node(
				"MarginContainer/ProgressBar"
		)
		progress_bar.value = progress[0] * 100
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_to_load_path))
		loading_screen_scene_instance.queue_free()
		loading = false
	else:
		printerr("Loading fucked up")


func load_scene(path):
	var current_scene: Node = get_tree().current_scene

	loading_screen_scene_instance = LOADING_SCREEN.instantiate()
	get_tree().root.call_deferred("add_child", loading_screen_scene_instance)

	if ResourceLoader.has_cached(path):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path)

	current_scene.queue_free()

	loading = true
	scene_to_load_path = path
