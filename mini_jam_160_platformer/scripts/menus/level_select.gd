extends Control


const MAIN_MENU := "res://scenes/menus/main_menu.tscn" as String

@export var level_buttons: VBoxContainer


func _ready() -> void:
	hide()
	for button: Button in level_buttons.get_children():
		button.pressed.connect(_on_level_button_pressed.bind(button))


func _on_level_button_pressed(button: Button) -> void:
	GameManager.start_new_level(Globals.levels[button.get_index()])


func _on_back_button_pressed() -> void:
	var menu: CanvasItem = get_parent().get_node("VBoxContainer")
	if menu is not CanvasItem:
		printerr("Invalid menu")
		return
	menu.show()
	hide()
