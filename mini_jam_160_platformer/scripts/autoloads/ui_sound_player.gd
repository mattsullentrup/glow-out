extends Node


@onready var button_sound: AudioStreamPlayer = $ButtonSound


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
		connect_buttons(child)


func connect_to_button(button: BaseButton) -> void:
	button.pressed.connect(_on_button_pressed)


func _on_scene_tree_node_added(node: Node) -> void:
	if node is Button:
		var button: Button = node
		connect_to_button(button)


func _on_button_pressed() -> void:
	button_sound.play()
