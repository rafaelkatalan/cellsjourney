extends Control


func _ready():#roda som de fundo
	$somFundo.play()

func _on_Button6_pressed():#roda som de botão precionado; muda cena paramenu principal
	$somClick.play()
	get_tree().change_scene("res://scenes/main menu.tscn")


func _on_pulmo_pressed():#roda som de botão precionado e muda cena para instruções do jogo
	$somClick.play()
	get_tree().change_scene("res://scenes/instrucoes.tscn")
