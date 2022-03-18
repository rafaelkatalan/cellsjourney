extends Control
func _ready():
	$somFundo.play()

func _on_Button6_pressed():
	$somClick.play()
	get_tree().change_scene("res://scenes/main menu.tscn")


func _on_pulmo_pressed():
	$somClick.play()
	get_tree().change_scene("res://scenes/instrucoes.tscn")
