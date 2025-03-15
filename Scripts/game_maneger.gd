extends Node

@onready var player = $"../Player"
@onready var fruits_label = player.get_node("CanvasLayer/Label")
@onready var timer = $"../Timer"

@onready var win_label = $CanvasLayer/WinLabel
@onready var lose_label = $CanvasLayer/LoseLabel
@onready var lose_container = $CanvasLayer/LoseContainer
@onready var win_container = $CanvasLayer/WinContainer
@onready var death_number = $CanvasLayer/DeathNumber

const level_path = "res://Scenes/Mundo"

var main_menu_path = load("res://Scenes/main_menu.tscn")
var level_2_path = load("res://Scenes/Mundo2.tscn")
var final_scene = load("res://Scenes/finalScene.tscn")

var fruits = 0
var frutas_sobra =0 
var mortes = 0

func salvar_mortes():
	var file = FileAccess.open("user://mortes.json", FileAccess.WRITE)
	if file:
		var data = {"mortes" : mortes}
		var json = JSON.new()
		var json_text = json.stringify(data)
		file.store_string(json_text)
		file.close
	else:
		print("ERRO SALVAR MORTEs")

func carregar_mortes() -> int:
	var file = FileAccess.open("user://mortes.json", FileAccess.READ)
	if file:
		var json = JSON.new()
		var json_text = file.get_as_text()
		var parse_result = json.parse(json_text)
		
		if parse_result == OK:
			var data = json.get_data()
			file.close()
			return data["mortes"]
		else:
			print("ERRO AO LER ARQUIVO")
			file.close()
			return 0
	else:
		print("ERRO AO CARREGAR ARQUIVO")
		return 0

func atual_death_number() -> void:
	death_number.text = "Death Number: " + str(mortes)

func _ready() -> void:
	mortes = carregar_mortes()
	atual_death_number()
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
		player.set_physics_process(false)
		player.can_move = false
		win_label.visible = true
		win_container.visible = true
	else:
		player.death()
func lose():
	timer.stop_timer()
	player.set_physics_process(false)
	player.can_move = false
	lose_label.visible = true
	lose_container.visible = true
	death_number.visible = true
	
	mortes += 1
	salvar_mortes()
	atual_death_number()
	
func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu_path)


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_next_pressed() -> void:
	var cena_atual = get_tree().current_scene.scene_file_path
	var prox_cena = cena_atual.to_int() + 1
	
	var caminho_prox_cena = level_path + str(prox_cena) + ".tscn"
	get_tree().change_scene_to_file(caminho_prox_cena)
