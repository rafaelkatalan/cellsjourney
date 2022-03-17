extends CanvasLayer

func _ready():
	set_visible(false) # deixa a interface invisível se nada for pressionado
	#OS.window_fullscreen = true

func _input(event):
	if event.is_action_pressed("pause"): # se escape for pressionado
		set_visible(true) # interface fica visível
		get_tree().paused = true # pausa a cena

func set_visible(is_visible): # função para visualizar a interface nos nós
	for node in get_children(): # para node em nós filhos
		node.visible = is_visible 

func _on_resume_pressed(): # função que dá funcionalidade ao botão "resume"
	get_tree().paused = false # jogo despausa
	set_visible(false) # interface fica invisível
	
func _on_backtomenu_pressed(): # função que dá funcionalidade ao botão "back to menu"
	get_tree().paused = false # jogo despausa	
	get_tree().change_scene("res://scenes/main menu.tscn") # muda para o main menu
	set_visible(false) # interface fica invisível
