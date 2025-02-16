extends CharacterBody2D

@export var acc = 100
@export var maxSpeed = 800

@export var maxJumps = 1
@export var currentJump = 0

@export var gravity = 2200

@export var JUMP_VELOCITY = 40000.0



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_pressed("left"):

		velocity.x = max(velocity.x - acc, -maxSpeed)
	elif Input.is_action_pressed("right"):
		
		velocity.x = min(velocity.x + acc, maxSpeed)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.01)

	# Handle jump.
	
	if Input.is_action_just_pressed("ui_accept") and currentJump < maxJumps:
		currentJump += 1
		velocity.y = -JUMP_VELOCITY * delta
	
	if $RayCast2D.is_colliding():
		currentJump = 0


	move_and_slide()
