extends Node


@onready var pressed_sound: AudioStreamPlayer = $PressedSound
@onready var click_sound: AudioStreamPlayer = $ClickSound


func _ready() -> void:
	# when _ready is called, there might already be nodes in the tree, so connect all existing buttons
	connect_buttons(get_tree().root)
	get_tree().node_added.connect(_on_scene_tree_node_added)


# recursively connect all buttons
func connect_buttons(root: Node) -> void:
	for child in root.get_children():
		if child is BaseButton:
			var button: Button = child
			connect_to_button(button)
		elif child is HSlider:
			var slider: HSlider = child
			connect_to_slider(slider)
		connect_buttons(child)


func connect_to_slider(slider: HSlider) -> void:
	slider.value_changed.connect(_on_slider_value_changed)
	slider.focus_entered.connect(_on_slider_focus_entered)


func connect_to_button(button: BaseButton) -> void:
	button.pressed.connect(_on_button_pressed)
	button.mouse_entered.connect(_on_button_focus_entered)
	button.focus_entered.connect(_on_button_focus_entered)


func _on_slider_value_changed(_new_value: float) -> void:
	click_sound.play()


func _on_slider_focus_entered() -> void:
	click_sound.play()


func _on_scene_tree_node_added(node: Node) -> void:
	if node is Button:
		var button: Button = node
		connect_to_button(button)


func _on_button_pressed() -> void:
	pressed_sound.play()


func _on_button_focus_entered() -> void:
	click_sound.play()
