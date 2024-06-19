extends Node


#var levels: Array[PackedScene] = []
var levels: Array[String] = []


func play_exit_transition(scene: Node) -> void:
	var tween = create_tween().tween_property(scene, "modulate", Color.BLACK, 1)
	await tween.finished
	scene.queue_free()


func play_enter_transition(scene: Node) -> void:
	var tween = create_tween().tween_property(scene, "modulate", Color.WHITE, 1).from(Color.BLACK)
	await tween.finished
	#scene.queue_free()
