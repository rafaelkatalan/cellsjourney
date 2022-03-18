extends Control

func _on_Button_pressed():
	$somClick.play()
	get_tree().change_scene("res://scenes/mapa_1.tscn")
