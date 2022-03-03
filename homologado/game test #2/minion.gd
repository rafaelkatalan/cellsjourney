 extends KinematicBody2D

var vetor = Vector2.ZERO
var limite = 1
var normal = Vector2(0,-1)
var time_1 = 1
var stop = 1
var hit = 0
var time = 0

func _process(delta):
	vetor.x = 90*limite*stop
	
	time += 1
	
	if (time%130)==0:
		limite = limite*-1
	
	if limite > 0:
		get_node("Sprite").set_flip_h(true)
	else:
		get_node("Sprite").set_flip_h(false)
		
	move_and_slide(vetor, normal)
	
	
	
#	if position.x < 605:
#		limite = 1
#		get_node("Sprite").set_flip_h(true)
#	if position.x > 800:
#		limite = -1
#		get_node("Sprite").set_flip_h(false)
	
	if is_on_ceiling():
		
		time_1 += 1
		$Sprite. scale = Vector2(1,1)
		scale.y = 0.1
		vetor.y = 1000
		stop = 0
		
		
		if time_1 == 20:
			get_node("Sprite").visible = false
			get_node("CollisionShape2D").disabled = true
		

	print(limite)
	print(position.x)
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
