extends Node


const TRANSITION_COLOR_RECT = preload("res://scenes/transition_color_rect.tscn")

var levels: Array[String] = []


func play_exit_transition(scene: Node) -> void:
	var transition_scene: CanvasLayer = TRANSITION_COLOR_RECT.instantiate()
	var color_rect: ColorRect = transition_scene.get_child(0)
	color_rect.color = Color(Color.BLACK, 0)
	scene.add_child(transition_scene)

	var tween: PropertyTweener = create_tween().tween_property(
			color_rect, "color", Color.BLACK, 1)
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await tween.finished
	scene.queue_free()


func play_enter_transition(scene: Node) -> void:
	var transition_scene: CanvasLayer = TRANSITION_COLOR_RECT.instantiate()
	var color_rect: ColorRect = transition_scene.get_child(0)
	color_rect.color = Color(Color.BLACK, 1)
	scene.add_child(transition_scene)

	var tween: Tween = create_tween()
	tween.tween_property(color_rect, "color", Color(Color.BLACK, 0), 1)
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await tween.finished
	transition_scene.queue_free()
