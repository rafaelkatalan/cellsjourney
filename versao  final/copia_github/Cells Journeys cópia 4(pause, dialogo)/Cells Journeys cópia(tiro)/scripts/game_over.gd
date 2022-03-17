extends Control

func _ready():
	
	#retorna variaveis globais para estado original
	ScriptGlobal.vilaoDied = false
	ScriptGlobal.vilao2Hit = false
	ScriptGlobal.life = 6
	
func _process(delta):
	#reconhece entrada "enter" e abre a cena da fase de novo
	if Input.is_action_just_pressed("ui_enter"):
		
		get_tree().change_scene("res://scenes/mapa_1.tscn")


func _on_Button_pressed():#função do godot: envia sinal de botão "Button" precionado:
	
	get_tree().change_scene("res://scenes/main menu.tscn")#abre cena da fase de novo
