extends Control


func _ready() -> void:
	hide()


func _process(_delta: float) -> void:
	if not Input.is_action_just_pressed("pause"):
		return

	if get_tree().paused == true:
		get_tree().paused = false
		hide()
	elif get_tree().paused == false:
		show()
		get_tree().paused = true
