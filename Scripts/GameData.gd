extends Node
var mortes: int = 0

func salvar_mortes() -> void:
	var file = FileAccess.open("user://mortes.json", FileAccess.WRITE)
	if file:
		var data = {"mortes" : mortes}
		var json = JSON.new()
		var json_text = json.stringify(data)
		file.store_string(json_text)
		file.close

func carregar_mortes() -> void:
	var file = FileAccess.open("user://mortes.json", FileAccess.READ)
	if file:
		var json = JSON.new()
		var json_text = file.get_as_text()
		var parse_result = json.parse(json_text)
		
		if parse_result == OK:
			var data = json.get_data()
			mortes = data.get("mortes", 0)
		file.close()
