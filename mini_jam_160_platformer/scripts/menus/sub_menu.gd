class_name SubMenu
extends Control


@onready var back_button: Button = %BackButton


func _ready() -> void:
	hide()

	var parent_menu := owner as ParentMenu
	if parent_menu != null:
		back_button.pressed.connect(parent_menu._on_sub_menu_back_button_pressed)


func _on_draw() -> void:
	Globals.mute_click_sound_on_menu_change(back_button)
