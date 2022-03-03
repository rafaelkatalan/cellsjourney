extends KinematicBody2D
var vetor = Vector2.ZERO
var up_down = 1
var normal = Vector2(0,-1)
var bateu = 0
var lado = 0
var time = 0

func _physics_process(delta):
	
	var lado = rand_range(-100, +100)
	time += 1
	
	if (time%100) == 0:
		vetor.x  = lado
		
		
	
	if (self.position.y >= 2120):
		up_down = -1
	if (self.position.y <= 1900):
		up_down = 1
	
	vetor.y = 100*up_down-bateu
	move_and_slide(vetor,normal)
	
	if is_on_floor():
		bateu = 1000
	elif is_on_ceiling():
		bateu = -2500
	else:
		bateu = 0
	
	
	

	
#	print(position)
	

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
