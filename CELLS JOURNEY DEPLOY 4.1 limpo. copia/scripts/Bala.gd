extends KinematicBody2D

var speed = 900 #atribui 900 ao valor da velocidade da bala
var direcao_bala = 0 #atribui a direção da bala para relacionar com a direcao do olhar o personagem
var sentido_x = -1 #valor do eixo x que irá ser atribuido no vetor de movimento da bala
var sentido_y = 0 #valor do eixo y que irá ser atribuido no vetor de movimento da bala
var viloes = ["vilao1","vilao_2","vilao_3","vilao_4","vilao_5"]#lista com nome dos NPCs "vilões"
var mapa = ["cenario_11","cenario_12"]#lista com nomes das partes do cenario


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


#função que faz com que se a munição saia da tela, ela seja apagada
func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()


func _on_Area2D_body_entered(body):
	#quando a munição atinge algum corpo verifica se o corpo esta na lista dos NPCs ou das partes do cenario
	if body != self:
		for i in viloes:#se o corpo for um NPCs o NPC sai da cena
			if i in body.name:
				print("ooooo")
				body.queue_free()
			if i == "vilao1":#se for o "vilao1" a variavel global vilaoDied é ativada para o tenis aparecer
				ScriptGlobal.vilaoDied = true

		for i in mapa:#se o corpo for uma parte do mapa, a bala some
			if i in body.name:
				self.queue_free()

