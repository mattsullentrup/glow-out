extends Control


const MAIN_MENU := "res://scenes/menus/main_menu.tscn" as String


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


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU)
