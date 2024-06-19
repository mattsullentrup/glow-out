extends Node


#var levels: Array[PackedScene] = []
var levels: Array[String] = []


func play_exit_transition(scene: Node) -> void:
	var tween: PropertyTweener = create_tween().tween_property(
			scene, "modulate", Color.BLACK, 1)
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await tween.finished
	scene.queue_free()


func play_enter_transition(scene: Node) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(scene, "modulate", Color.WHITE, 1).from(Color.BLACK)
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await tween.finished
	#scene.queue_free()
