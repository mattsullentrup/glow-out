extends SubMenu


const MAIN_MENU := "res://scenes/menus/main_menu.tscn" as String

@export var level_buttons: VBoxContainer

#@onready var back_button: Button = %BackButton


func _ready() -> void:
	super._ready()
	for button: Button in level_buttons.get_children():
		button.pressed.connect(_on_level_button_pressed.bind(button))


func _on_level_button_pressed(button: Button) -> void:
	GameManager.start_new_level(Globals.levels[button.get_index()])


func _on_draw() -> void:
	back_button.grab_focus()
