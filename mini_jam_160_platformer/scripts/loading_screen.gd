class_name LoadingScreen
extends Control


var progress: Array = []

@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar


func _ready() -> void:
	progress_bar.value = 0


func _process(_delta: float) -> void:
	if not progress:
		return

	progress_bar.value = progress[0] * 100

	if progress_bar.value == progress_bar.max_value:
		queue_free()
