extends Area2D

@onready var animation = $"../AnimationPlayer"
@onready var gamemane = %GameManeger

func _ready() -> void:
	animation.play("top_down")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animation.stop()
		
		
		
		
