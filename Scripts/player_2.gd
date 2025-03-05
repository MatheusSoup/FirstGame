extends CharacterBody2D

@onready var anime = $AnimatedSprite2D

func _ready() -> void:
	anime.play("Idle")
