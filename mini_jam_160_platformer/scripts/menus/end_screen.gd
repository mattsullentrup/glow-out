extends Control


const MAIN_MENU := "res://scenes/menus/main_menu.tscn" as String

@onready var main_menu_button: Button = %MainMenuButton


func _ready() -> void:
	main_menu_button.grab_focus()


func _on_main_menu_button_pressed() -> void:
	SceneLoader.load_scene(MAIN_MENU)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
