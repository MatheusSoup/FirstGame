extends Node2D

@onready var animation = $AnimationPlayer
@onready var gamemane = %GameManeger
@onready var player = $"../Player"

func _ready() -> void:
	animation.play("top_down")


func _on_animatable_body_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animation.stop()
		player.death()
