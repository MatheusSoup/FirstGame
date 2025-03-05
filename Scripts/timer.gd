extends Node2D

@export var countdown_time: float = 20.0 # Tempo do timer em segundos
@onready var countdown_label = $CanvasLayer/CountdownLabel
@onready var timer_label = $CanvasLayer/TimerLabel
@onready var countdown_timer = $CountdownTimer
@onready var game_timer = $GameTimer
@onready var gamemane = %GameManeger

var countdown_stage := 3
var countdown_started_once : bool = false

func _ready() -> void:
	count_starter()

func count_starter():
	countdown_label.text = "3"
	countdown_timer.wait_time = 0.5
	countdown_timer.connect("timeout", Callable(self, "_on_countdown_timeout"))
	countdown_timer.start()

func _on_countdown_timeout():
	if countdown_stage > 1:
		countdown_stage -= 1
		countdown_label.text = str(countdown_stage)
	elif countdown_stage == 1:
		countdown_label.text = "START"
		gamemane.player.can_move = true
		countdown_stage -= 1
	else:
		countdown_label.text = ""
		countdown_timer.stop()
		start_game_timer()

func start_game_timer():
	game_timer.wait_time = 1.0
	game_timer.connect("timeout", Callable(self, "_on_game_timer_timeout"))
	game_timer.start()
	update_timer_label()

func _on_game_timer_timeout():
	countdown_time -= 1
	update_timer_label()
	if countdown_time <= 0:
		game_timer.stop()
		gamemane.win()
		timer_label.text = "00:00"

func update_timer_label():
	var minutes = int(countdown_time) / 60
	var seconds = int(countdown_time) % 60
	timer_label.text = pad_zero(str(minutes)) + ":" + pad_zero(str(seconds))

func pad_zero(value: String) -> String:
	while value.length() < 2:
		value = "0" + value
	return value

func stop_timer():
	game_timer.stop()
