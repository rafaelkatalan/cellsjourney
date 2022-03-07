extends KinematicBody2D

#biblioteca com todas funcoes de um corpo 
var velocidade = Vector2.ZERO
#vector2 eh um vetor nos eixos 2D

func _physics_process(_delta): #eh um loop #delta eh a releitura
	
	velocidade.y += 20   #soma 20 no frame
	
	#movimento controlado pelo player
	if Input.is_action_pressed("ui_right"): #actionpressed se eu segurar continua
		velocidade.x = 400    #so um simbolo '=' a variavel recebe o valor que ta na direita
	
	elif Input.is_action_pressed("ui_left"): # elif eh uma segunda opçao de uma condiçao para varias coisas
		velocidade.x = -400 
	else:
		velocidade.x = 0 	#ELSE serve para qualquer outra condicao diferente das especificadas ali em cima 
	
	if Input.is_action_just_pressed("ui_up"):
		velocidade.y = -400
	
	move_and_slide(velocidade)   #para mover o narutin
