extends Area2D

func _process(_delta):
	if ScriptGlobal.arma:
		self.queue_free()
