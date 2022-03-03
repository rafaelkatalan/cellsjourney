extends KinematicBody2D

var speed = Vector2.ZERO
var count = 0
const normal = Vector2 (0,-1)
var run = 1


func _physics_process(delta):

	#Gravity:
	speed.y += 20
	
	#Walking
	if Input.is_action_pressed("ui_right"):
		speed.x = 400*run
		get_node("Sprite").set_flip_h(false)
	elif Input. is_action_pressed("ui_left"):
		speed.x = -400*run
		get_node("Sprite").set_flip_h(true)
	else:
		speed.x = 0
	
	#running:
	
	if Input.is_action_pressed("ui_shift"):
		run = 2
	else:
		run = 1

	#Jumping:
	if Input. is_action_just_pressed("ui_up") && count < 2 || Input. is_action_just_pressed("ui_espaco") && count < 2:
		speed.y = -400
		count += 1
		
	move_and_slide(speed, normal)
	
	if is_on_floor():
		count = 0
		speed.y = 0
	
	if is_on_ceiling():
		speed.y = -10
	
	#animation:
	if Input.is_action_pressed("ui_right") && is_on_floor() || Input.is_action_pressed("ui_left") && is_on_floor():
		$Sprite/AnimationPlayer.play("walk")
	else:	
		$Sprite/AnimationPlayer. play("stoped")
		

#	print(speed.y)
#	print(position.y)
	
	
	#voo: se quiser dps
#	if position.y < -10:
#		speed.y += 50
#	if Input.is_action_pressed("ui_espaco"):
#		speed.y -= 50
#
#	if Input. is_action_pressed("ui_down"):
#		speed.y += 50
