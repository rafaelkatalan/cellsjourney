extends Node2D

func _ready():
	$somFundo.play()
	ScriptGlobal.tenis = 1 #variavel que assume valor 1 e 2 e é utilizada para habilitar os habilidades adquiridas com o tenis
	ScriptGlobal.vilaoDied = false #variavel booleana que indica se o vilão esta morto
	ScriptGlobal.posicaoVilao = Vector2() #variavel com componentes (X,Y) que assumira o valor da posição do vilão
	ScriptGlobal.dano = false #variavel booleana que armazena a informação de que o personagem está no processo de perder vida
	ScriptGlobal.vilaoHit = false #variavel booleana que indica que o vilão esta batendo horizontalmente
	ScriptGlobal.vilao2Died = false
	ScriptGlobal.vilao2Hit = false
	ScriptGlobal.life = 6# Variável que armaneza o número de vidas do jogador (inicia com 6)
	ScriptGlobal.arma = false
