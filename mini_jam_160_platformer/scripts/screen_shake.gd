class_name ScreenShake
extends Node2D


@export var random_shake_strength: float = 30.0
@export var shake_decay_rate: float = 5.0
@export var noise_shake_speed: float = 30.0
@export var noise_shake_strength: float = 60.0

@export var intensity = 30.0

var camera: Camera2D
var noise_i: float = 0.0
var shake_strength: float = 0.0

@onready var rand:RandomNumberGenerator = RandomNumberGenerator.new()
@onready var noise: FastNoiseLite = FastNoiseLite.new()


func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	rand.randomize()
	noise.seed = rand.randi()
	noise.frequency = 0.5


func _process(delta: float) -> void:
	shake_strength = lerpf(shake_strength, 0, shake_decay_rate * delta)
	camera.offset = get_noise_offset(delta)


func get_noise_offset(delta: float) -> Vector2:
	noise_i += delta * noise_shake_speed
	return Vector2(
		noise.get_noise_2d(1, noise_i) * shake_strength,
		noise.get_noise_2d(100, noise_i) * shake_strength
	)


func apply_shake() -> void:
	#shake_strength = random_shake_strength

	var tween = self.create_tween()
	#tween.interpolate_property(self,"offset", get_random_offset(),get_random_offset(), 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.interpolate_value(self,"offset", get_random_offset(),get_random_offset(), 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)

	tween.interpolate_property(self,"offset", get_random_offset(),Vector2(0,0), 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)

	tween.start()



func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-intensity, intensity),
		rand.randf_range(-intensity, intensity)
	)
