extends KinematicBody2D

var speed = 900
var direcao_bala = 0
var sentido_x = -1
var sentido_y = 0

func pega_direcao(dir):
	self.direcao_bala = dir

func _physics_process(delta):
	
	if(direcao_bala == 0):
		$Sprite.set_rotation_degrees(315)
		sentido_x = 1
		sentido_y = -1
		
	elif(direcao_bala == 1):
		$Sprite.set_rotation_degrees(225)
		sentido_x = -1
		sentido_y = -1
		
	elif(direcao_bala == 2):
		$Sprite.flip_h = false
		sentido_x = 1
		sentido_y = 0
		
	elif(direcao_bala == 3):
		$Sprite.flip_h = true
		sentido_x = -1
		sentido_y = 0
		
	else:
		$Sprite.set_rotation_degrees(270)
		sentido_x = 0
		sentido_y = -1

	var info = move_and_collide(Vector2(sentido_x, sentido_y)*speed*delta)
	
	if info:
		self.queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
