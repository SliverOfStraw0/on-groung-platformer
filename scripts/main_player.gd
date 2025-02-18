extends CharacterBody2D

@export var acc = 200
@export var drag = 0.025

@export var defMaxSpeed = 900
var maxSpeed = defMaxSpeed



@export var maxJumps = 1
@export var currentJump = 0

@export var defultGrav = 2500
var gravity = defultGrav

@export var JUMP_VELOCITY = 50000.0



func _physics_process(delta: float) -> void:
	
	slideAndStopMovement(delta)
	basicMovement(delta)
	
	if $RayCast2D.is_colliding():
		currentJump = 0
		gravity = defultGrav

	move_and_slide()
	
	
	
	
func basicMovement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_pressed("left"):

		velocity.x = max(velocity.x - acc, -maxSpeed)
	elif Input.is_action_pressed("right"):
		
		velocity.x = min(velocity.x + acc, maxSpeed)
	else:
		velocity.x = lerp(velocity.x, 0.0, drag)

	
	if Input.is_action_just_pressed("ui_accept") and currentJump < maxJumps:
		currentJump += 1
		velocity.y = -JUMP_VELOCITY * delta
		
func slideAndStopMovement(delta):
	if Input.is_action_just_pressed("slideStomp"):
		if !$RayCast2D.is_colliding():
			gravity = 50000
		else:
			gravity = defultGrav
			maxSpeed = 2000
	elif Input.is_action_just_released("slideStomp"):
		maxSpeed = defMaxSpeed
