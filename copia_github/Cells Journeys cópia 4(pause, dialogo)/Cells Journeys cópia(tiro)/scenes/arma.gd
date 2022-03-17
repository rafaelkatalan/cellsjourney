extends Area2D

func _process(delta):
	if ScriptGlobal.arma:
		self.queue_free()
