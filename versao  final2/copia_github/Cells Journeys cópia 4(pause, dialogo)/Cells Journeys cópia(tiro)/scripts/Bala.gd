extends KinematicBody2D

var speed = 900 #atribui 900 ao valor da velocidade da bala
var direcao_bala = 0 #atribui a direção da bala para relacionar com a direcao do olhar o personagem
var sentido_x = -1 #valor do eixo x que irá ser atribuido no vetor de movimento da bala
var sentido_y = 0 #valor do eixo y que irá ser atribuido no vetor de movimento da bala

func pega_direcao(dir): #função que será chamada no script do personagem que servirá para relacionar a direção do olhar do personagem com a direção da bala
	self.direcao_bala = dir #função que atrela as duas direções

func _physics_process(delta):
	
	#direção que aponta para 45° a partir da direita
	if(direcao_bala == 0):
		$Sprite.set_rotation_degrees(315)
		sentido_x = 1
		sentido_y = -1
		
	#direção que aponta para 45° a partir da esquerda
	elif(direcao_bala == 1):
		$Sprite.set_rotation_degrees(225)
		sentido_x = -1
		sentido_y = -1
	
	#direção que aponta para a direita
	elif(direcao_bala == 2):
		$Sprite.flip_h = false
		sentido_x = 1
		sentido_y = 0
		
	#direção que aponta para a esquerda
	elif(direcao_bala == 3):
		$Sprite.flip_h = true
		sentido_x = -1
		sentido_y = 0
		
	#direção que aponta para cima
	else:
		$Sprite.set_rotation_degrees(270)
		sentido_x = 0
		sentido_y = -1

	var info = move_and_collide(Vector2(sentido_x, sentido_y)*speed*delta)  #função que faz a munição mover para a direção atrelada anteriormente
	
	#condição que se caso a munição colida com qualquer parede, a munição suma
	if info:
		self.queue_free()
		
#função que faz com que se a munição saia da tela, ela seja apagada
func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
