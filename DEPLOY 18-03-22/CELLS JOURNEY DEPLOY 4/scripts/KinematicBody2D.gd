extends KinematicBody2D # Biblioteca que contém funções de movimentação e fisica em 2D

var velocidade = Vector2.ZERO # Variável que determina o vetor que será usado para movimentação do personagem. Vector2 é um vetor de dimensões (x,y).
var contagem_pulo = 0 # 
var normal = Vector2(0,-1) #vetor vertical para orientar funções de "is_on_floor", "is_on_ceiling" e "is_on_wall"
var run = 1 #variavel que multiplica o vetor de velocidade para acelerar o movimento quando a corrida for habilitada (assume valor 1(neutro em multiplicação) quando esta andando e 2 para correr)
var direcao_player = 2 #variavel que define a direção do personagem dependendo da direção de onde o personagem esta olhando
var parado = 1 #variavel que serve para 
#var vida = 6
 
var collision #variavel ultilizada para reconhecer colisão

#andar (movimento horizontal controlado pelo jogador)
func move():
	#condição para que quando a tecla control seja pressionada, o personagem se mantenha parado para atirar
	if Input.is_action_pressed("ui_parado"):
		parado = 0
	else:
		parado = 1
	
	#condição para identificar a direção do olhar do personagem
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):
		direcao_player = 0  #caso o jogador aperte as teclas da direita e cima, o olhar dele é atrelado à 45° para a direita
		velocidade.x = 400*parado*run
		$Sprite.flip_h = false
		
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"): 
		direcao_player = 1 #caso o jogador aperte as teclas da esquerdaa e cima, o olhar dele é atrelado à 45° para a esquerda
		velocidade.x = -400*parado*run
		$Sprite.flip_h = true #espelha a imagem do personagem horizontalmente quando o personagem anda para trás
		
	else:
		#condição de ao identificar que determinadas entradas estão precionadas o vetor "velocidade" assume um valor no eixo "X" multiplicado pela variavel "parado" e "run"
		if Input.is_action_pressed("ui_right"): #seta para direita 
			velocidade.x = 400*parado*run
			direcao_player = 2
			get_node("Sprite").set_flip_h(false)
			
			#reproduz animação do personagem se estiver andando e no chão
			if is_on_floor() and parado == 1:
				get_node("Sprite/AnimationPlayer").play("andando")
			else:
				get_node("Sprite/AnimationPlayer").play("RESET")
				
		elif Input.is_action_pressed("ui_left"): #seta para esquerda
			velocidade.x = -400*parado*run
			direcao_player = 3
			get_node("Sprite").set_flip_h(true) #espelha a imagem do personagem horizontalmente quando o personagem anda para trás
			
			#reproduz animação do personagem se estiver andando e no chão
			if is_on_floor() and parado == 1:
				get_node("Sprite/AnimationPlayer").play("andando")
			else:
				get_node("Sprite/AnimationPlayer").play("RESET")
				
		elif Input.is_action_pressed("ui_up"):
			direcao_player = 4
			
		else:
			velocidade.x = 0
			get_node("Sprite/AnimationPlayer").play("RESET")
		
	if Input.is_action_pressed("ui_shift"):   ###quando "shift" é precionado a variavel "run" assume o valor da variavel global "tenis"
		run = ScriptGlobal.tenis   ###"tenis" é uma variavel global que assume o valor 2 quando o personagem passa pelo ícone do tenis(area 2D)
	else:
		run = 1
		
func pulo():
	#identifica entrada de seta para cima e faz o vetor velocidade assumir o valor -400 no eixo "y"
	#para personagem não poder pular o quanto quiser e sair voando, função só é valida se "contagem_pulo"(variavel que aumenta 1 em seu valor a cada vez que o personagem pula) for menor do que o limite de pulos que o personagem pode dar 
	if Input.is_action_just_pressed("ui_up") and contagem_pulo < ScriptGlobal.tenis:#"contagem_pulo" < "tenis" para o limite de pulos ser 1 ao iniciar o jogo e passar a ser 2 depois que o personagem pega o tenis
		$somPulo.play()
		velocidade.y = -400
		contagem_pulo += 1
		
#função que determina a vida do personagem
func vida():
	
	
	#reconhece contato lateral com os monstrinhos:
	for i in range(get_slide_count() -1):
		collision = get_slide_collision(i)
		
	if (ScriptGlobal.vilaoHit == true or (is_on_wall() and collision.collider.name == "vilao")) or (ScriptGlobal.vilao2Hit == true or (is_on_wall() and collision.collider.name == "vilao_2")):
		ScriptGlobal.dano = true #"dano" variavel booleana global que armazena a informação de que o personagem está no processo de perder vida 
	else:
		ScriptGlobal.dano = false
	
	if ScriptGlobal.dano == true:
		#variavel "life" reduz 1 quando "dano" é verdadeiro
		ScriptGlobal.life -= 1
		
		

	#personagem pisca enquanto perde vida
		get_node("Sprite").visible = false
	else:
		get_node("Sprite").visible = true
		
	#"vida" é o nó que contém a barra de vida; assume valor de "life"
	get_node("vida").value = ScriptGlobal.life
	
	
	#encerrar a fase quando a vida chega à zero
	if ScriptGlobal.life<=0 or velocidade.y > 2000:
		get_tree().change_scene("res://scenes/game_over.tscn")
	
func tiro():
	if Input.is_action_just_pressed("ui_shoot"):
		$somTiro.play()
		var chama_a_bala = preload("res://scenes/Bala.tscn")
		var bala = chama_a_bala.instance()
		
		bala.pega_direcao(direcao_player)
		
		if direcao_player == 0:
			bala.position.x = self.position.x + 35
			bala.position.y = self.position.y - 20
			
		elif direcao_player == 1:
			bala.position.x = self.position.x - 40
			bala.position.y = self.position.y - 20
			
		elif direcao_player == 2:
			bala.position.x = self.position.x + 35
			bala.position.y = self.position.y - 20
			
		elif direcao_player == 3:
			bala.position.x = self.position.x - 40
			bala.position.y = self.position.y - 20
			
		else:
			bala.position.x = self.position.x
			bala.position.y = self.position.y - 45
			
		get_parent().add_child(bala)

	
#função do godot para rodar os processos físicos
func _physics_process(_delta):
	#$CanvasLayer/vida.value = vida
	#gravidade: aceleração constante para baixo:
	velocidade.y += 20
#	
	if ScriptGlobal.arma == true:
		tiro()
	
	#funções programadas a cima; linha 11 e 39:
	
	move()
	
	pulo()
	
	#função do godot que da movimento ao objeto; ele assume o valor do vetor "velocidade", que esta programado a cima, e o "normal"
	move_and_slide(velocidade,normal)
	
	#função do godot que reconhece contato com o chão; zera contagem de pulo e faz "velocidade" assumir valor 0 quando esta no chão, sem isso, "velocidade" continua aumentando para baixo e o valor acumulado fica sendo armazenado, isso daria problema em movimentações futuras
	if is_on_floor():
		
		contagem_pulo = 0
		velocidade.y = 0
	
	#função do godot que reconhece contato com o teto; faz "velocidade" assumir um vetor de valo 10 para baixo, da impressão de que o personagem "pinga" quando bate
	if is_on_ceiling():
		
		velocidade.y = -10
		
	#função vida; programado linha (47):
	vida()
	
		
#função do godot: recebe sinal da area 2D "tenis" quando o personagem passa por ela
func _on_Area2D_body_entered(_body):
	ScriptGlobal.tenis = 2 #variavel global "tenis" assume valor 2 para habilitar corrida e pulo duplo

func _on_arma_body_entered(_body):
	ScriptGlobal.arma = true

func _on_VoltaMenu_body_entered(_body):
	get_tree().change_scene("res://scenes/menu fase.tscn")
