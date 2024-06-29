extends Control


const MAIN_MENU := "res://scenes/menus/main_menu.tscn" as String

@onready var button: Button = $MarginContainer/VBoxContainer/Button


func _ready() -> void:
	button.grab_focus()


func _on_button_pressed() -> void:
	SceneLoader.load_scene(MAIN_MENU)
