extends Node

var tenis = 1 #variavel que assume valor 1 e 2 e é utilizada para habilitar os habilidades adquiridas com o tenis
var vilaoDied = false #variavel booleana que indica se o vilão esta morto
var posicaoVilao = Vector2() #variavel com componentes (X,Y) que assumira o valor da posição do vilão
var dano = false #variavel booleana que armazena a informação de que o personagem está no processo de perder vida 
var vilaoHit = false #variavel booleana que indica que o vilão esta batendo horizontalmente
var vilao2Died = false
var vilao2Hit = false
var life = 6# Variável que armaneza o número de vidas do jogador (inicia com 6)
var arma = false
#OS.set_window_fullscreen(!OS.window_fullscreen)
