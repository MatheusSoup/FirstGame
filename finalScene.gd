extends Label

@onready var label = $"."
var mortes = 0
func _ready() -> void:
	GameData.carregar_mortes()
	mortes = GameData.mortes
	label.text = "Total Deaths:" + str(mortes)
