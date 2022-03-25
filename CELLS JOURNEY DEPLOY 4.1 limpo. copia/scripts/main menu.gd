extends Control

func _ready():
	$somMenu.play()
	#OS.window_fullscreen = true
	#OS.set_window_fullscreen(!OS.window_fullscreen)

func _on_play_pressed(): #função do godot: envia sinal de botão "play" precionado:
	$somClick.play()
	get_tree().change_scene("res://scenes/menu fase.tscn") #abre cena com mapa de fases ("menu fase.tscn")


func _on_quit_pressed(): #função do godot: envia sinal de botão "quit" precionado:
	$somClick.play()
	get_tree().quit() #sai do jogo


func _on_credits_pressed():#função do godot: envia sinal de botão "credits" precionado:
	$somClick.play()
	get_tree().change_scene("res://scenes/credits.tscn") #abre cena com mais infos do jogo e os creditos
