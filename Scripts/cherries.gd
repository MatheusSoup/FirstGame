extends AnimatedSprite2D

@onready var anime = $AnimatedSprite2D


func _ready() -> void:
	anime.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
