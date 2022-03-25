extends Area2D

#arma sai da cena quando jogador pega arma

func _process(_delta):
	if ScriptGlobal.arma:
		self.queue_free()
