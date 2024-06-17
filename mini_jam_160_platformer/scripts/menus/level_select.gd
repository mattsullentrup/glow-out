extends Control


const MAIN_MENU := "res://scenes/menus/main_menu.tscn" as String

@export var level_buttons: VBoxContainer


func _ready() -> void:
	for button: Button in level_buttons.get_children():
		button.pressed.connect(_on_level_button_pressed.bind(button))


func _on_level_button_pressed(button: Button) -> void:
	GameManager.start_new_level(Globals.levels[button.get_index()])


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU)
