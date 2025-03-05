extends Node

@onready var player = $"../Player"
@onready var fruits_label = player.get_node("CanvasLayer/Label")
@onready var timer = $"../Timer"

@onready var win_label = $CanvasLayer/WinLabel
@onready var lose_label = $CanvasLayer/LoseLabel
@onready var lose_container = $CanvasLayer/LoseContainer
@onready var win_container = $CanvasLayer/WinContainer

const level_path = "res://Scenes/Mundo"

var main_menu_path = load("res://Scenes/main_menu.tscn")
var level_2_path = load("res://Scenes/Mundo2.tscn")

var fruits = 0
var frutas_sobra =0 

func _ready() -> void:
	win_label.visible = false
	lose_label.visible = false
	lose_container.visible = false
	win_container.visible = false
	
	var current_world = get_parent()
	
	if current_world:
		frutas_sobra = 0 
		for child in current_world.get_children():
			if child.name.begins_with("Fruta"):
				frutas_sobra +=1
	fruits_label.text = "Frutas: " + str(frutas_sobra)
	

func add_fruit():
	frutas_sobra -=1 
	fruits_label.text = "Frutas: " + str(frutas_sobra)
	if frutas_sobra == 0:
		timer.stop_timer()
		win()
	

func win():
	if frutas_sobra <= 0:
		player.can_move = false
		win_label.visible = true
		win_container.visible = true
	else:
		lose()
func lose():
	timer.stop_timer()
	player.can_move = false
	lose_label.visible = true
	lose_container.visible = true
	
func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu_path)


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_next_pressed() -> void:
	var cena_atual = get_tree().current_scene.scene_file_path
	var prox_cena = cena_atual.to_int() + 1
	
	var caminho_prox_cena = level_path + str(prox_cena) + ".tscn"
	get_tree().change_scene_to_file(caminho_prox_cena)
