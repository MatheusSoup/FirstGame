extends Node2D

@onready var anime = $AnimatedSprite2D
@onready var gamemane = %GameManeger
@onready var audio = $FrutaColetada

func _ready() -> void:
	anime.play("Idle")
	#add_to_group("Frutas")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		anime.play("Colected")
		audio.play()
		gamemane.add_fruit()

func _on_animated_sprite_2d_animation_finished() -> void:
	if anime.animation == "Colected":
		queue_free()
