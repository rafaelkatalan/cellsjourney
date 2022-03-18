 extends KinematicBody2D

var vetor = Vector2.ZERO #variavel com componentes (X,Y), usada para programar vetores de movimento do NPC
var limite = 1 #variavel que assume valores 1 e -1 , usada pra fazer NPC mudar de direção
var normal = Vector2(0,-1) #vetor vertical para orientar funções de "is_on_floor", "is_on_ceiling" e "is_on_wall"
var time_1 = 1 #variavel usada para marcar tempo quando o NPC morre
var stop = 1 #variavel que assume valores 0 e 1, mutiplica vetor x para parar o NPC quando assume valor 0
var time = 0 #variavel usada para marcar tempo do movimento do NPC
var time_3 = 0 #variavel usada pra marcar tempo de intervalo que o NPC precisa para causar dano novamente no jogador
var recharge = false #variavel booleana que ativa a contagem de tempo da variave "time_3"




func _process(_delta):#função do godot; roda repetitivamente
	
	#atribuição de valor ao componente "x" da variavel "vetor"; multiplicado por limite para inverter o sentido e stop para parar quando nescessario
	vetor.x = 90*limite*stop
	
	#a cada frame a variavel "time" aumenta seu valor em 1
	time += 1
	

	
	if (time%130)==0:#resto da divisão de time por 130 = 0, ou seja, a cada 130 frames essa condição é valida
		limite = limite*-1#limite é multiplicado por menos 1, dessa forma seu valor será invertido a cada 130 frames
	
	if limite > 0 and vetor.x != 0:#quando limite é positivo, ou seja, igual 1 (movimentação para direita), e o "vetor" no eixo x não é 0, ou seja, NPC está se movimentando, o sprite(imagem do vilão) é espelhado horizontalmente
		get_node("Sprite").set_flip_h(true)
	else: #se não cumprir a condição, ou seja, NPC se movimena para esquerda, sprite volta para seu estado original (virado para esquerda)
		get_node("Sprite").set_flip_h(false)
		
		
	#função do godot que da movimento ao objeto; ele assume o valor do vetor "vetor", que esta programado a cima, e o "normal"
	move_and_slide(vetor, normal)
	
	
	
	if is_on_ceiling():#função do godot que reconhece contato com o teto; o vilao só colide com o teto quando o jogador pula em cima dele; abaixo esta programado o vilão morrendo
		
		ScriptGlobal.vilao2Died = true #variavel global vira verdadeira; isso é usado para programar em outras cenas coisas que acontecem após a morte do NPC
		vetor.y = 1000 #NPC cai
		
		#escala do NPC diminui no eixo Y
		get_node("CollisionShape2D").scale = Vector2(1,1)
		scale.y = 0.1
		
		#linhas 41 a 46  fazem parecer que o NPC é esmagado pelo jogador
		
		stop = 0 #multiplica o "vetor", faz NPC parar ao morrer
		
		
		
	if ScriptGlobal.vilao2Died == true: # após vilão morto
		
		time_1+=1 #soma 1 na variavel a cada frame
		
		
		if time_1 == 70: #quando "time_1" chega em 70, ou seja, 70 frames após o inicio da contagem; sprite fica invisivel e o colisor é desabilitado
			get_node("Sprite").visible = false
			get_node("CollisionShape2D").disabled = true
		
	
	
	if is_on_wall(): #funcao do godot que reconhece colisão horizontal
		ScriptGlobal.vilao2Hit = true #faz a variavel global "vilaoHit" ser verdadeira, variavel utilizada no "Player" para programar colisão após contato com NPC
	else:
		ScriptGlobal.vilao2Hit = false #faz a variavel global "vilaoHit" voltar a ser falsa
		
	if ScriptGlobal.dano == true: #variavel global "dano" é true quando o jogador está no processo de perder vida (programado no script do "Player")
		
		#o colisor é desligado para que o jogador não fique perdendo vida por frame que esta em contato com NPC, mas perder apenas uma vida por contato
		get_node("CollisionShape2D").disabled = true
		recharge = true #variavel vira verdadeira para iniciar contagem de tempo para ligar de volta o colisor
	
	if recharge == true:
		
		time_3+=1 #soma 1 a cada frame em "time_3"
		
	if (time_3%50)==0 and ScriptGlobal.vilao2Died == false: #se time_3 for multipli de 50, ou seja, a cada 50 frames e o NPC não estiver morto (comando escrito para concertar um BUG)
		
		get_node("CollisionShape2D").disabled = false # colisor é reabilitado
		ScriptGlobal.dano == false #desliga o processo de perda de vida
		recharge = false #para o aumento em "time_3" pois a contagem de tempo não é mais utilizada
		time_3 = 0 #para que quando "recharge" for "true" de novo, a contagem do tempo voltar do zero
	

		
	
