extends KinematicBody2D

const ACCELERATION = 800
const MAXSPEED = 80
const FRICTION = 400
var velocity = Vector2.ZERO
var keys = []

func my_init(k, otherPlayers):
	#for p in otherPlayers:
	#	add_collision_exception_with(p)
	keys = k

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength(keys[0]) - Input.get_action_strength(keys[2])
	input_vector.y = Input.get_action_strength(keys[1]) - Input.get_action_strength(keys[3])
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAXSPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
		
	velocity = move_and_slide(velocity)
	
