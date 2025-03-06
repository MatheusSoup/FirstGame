extends StaticBody2D


@onready var collision_shape = $CollisionShape2D
var timer = 0.0

func _ready() -> void:
	randomize()
	set_process(true)
	_reset_timer()

func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		_toggle_visibility()
		_reset_timer()

func _reset_timer() -> void:
	timer = randf_range(1.0, 5.0)  # Define o intervalo de tempo aleatório entre 1 a 5 segundos

func _toggle_visibility() -> void:
	visible = not visible
	collision_shape.disabled = not collision_shape.disabled
