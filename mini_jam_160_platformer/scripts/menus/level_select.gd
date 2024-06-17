extends Control


const MAIN_MENU := "res://scenes/menus/main_menu.tscn" as String

@export var level_buttons: VBoxContainer


func _ready() -> void:
	for button: Button in level_buttons.get_children():
		button.pressed.connect(_on_level_button_pressed)


func _on_level_button_pressed() -> void:
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU)
