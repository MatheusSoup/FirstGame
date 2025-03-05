extends Node2D

@onready var botao1 = $CanvasLayer/Control/Button
@onready var botao2 = $CanvasLayer/Control/Button2
@onready var animation = $AnimationPlayer
@onready var anime2 = $AnimatedSprite2D
@onready var audio = $MenuSong

func _ready() -> void:
	animation.play("Menu")
	anime2.play("Idle_menu")
	audio.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Mundo1.tscn")

func _on_button_2_pressed() -> void:
	get_tree().quit()

func _on_button_mouse_entered() -> void:
	botao1.size.x = 700

func _on_button_2_mouse_entered() -> void:
	botao2.size.x = 700

func _on_button_mouse_exited() -> void:
	botao1.size.x = 510
	
func _on_button_2_mouse_exited() -> void:
	botao2.size.x = 510
