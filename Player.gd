extends KinematicBody2D

const ACCELERATION = 1600
const MAXSPEED = 160
const FRICTION = 800
var velocity = Vector2.ZERO
var keys = []

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func my_init(k, otherPlayers):
	for p in otherPlayers:
		add_collision_exception_with(p)
	keys = k

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength(keys[0]) - Input.get_action_strength(keys[2])
	input_vector.y = Input.get_action_strength(keys[1]) - Input.get_action_strength(keys[3])
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAXSPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
		
	velocity = move_and_slide(velocity)
