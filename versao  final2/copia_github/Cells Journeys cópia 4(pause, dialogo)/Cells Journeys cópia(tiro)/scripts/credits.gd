extends Control

func _on_back_pressed():#função do godot: envia sinal de botão "back" precionado:
	get_tree().change_scene("res://scenes/main menu.tscn")#abre cena do "main menu"

func _process(delta):#função de processo; é lida a cada frame
	
	#reconhece entrada "seta pra baixo" e desce a camera
	if Input.is_action_just_pressed("ui_down"):
		get_node("Camera2D").position.y += 100
		
	#reconhece entrada "seta pra cima" e sobe a camera com limite para não sair da tela 
	if Input.is_action_just_pressed("ui_up") and get_node("Camera2D").position.y > 0:
		get_node("Camera2D").position.y -= 100
