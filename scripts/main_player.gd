extends CharacterBody2D

@export var acc = 400
@export var drag = 0.15
@export var defMaxSpeed = 650
var maxSpeed = defMaxSpeed
var a = 1


@export var maxJumps = 1
@export var currentJump = 0
@export var JUMP_VELOCITY = 55000.0
@export var JMinscrease = 0.1
@export var defJumpMultiplyer = 1.5
var jumpMultiplyer = defJumpMultiplyer
@export var walljumpdisplace = 1500
var canSlamJump = false
var isOnJumpableWall = false


@export var defultGrav = 2500
var gravity = defultGrav

@onready var jumpCast = $ShapeCast2D




func _physics_process(delta: float) -> void:
	
	slideAndStopMovement(delta)
	basicMovement(delta)
	
	if jumpCast.is_colliding():
		#a += 1
		#print("COL" + str(a))
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
		#print(currentJump)
		currentJump += 1
		if isOnJumpableWall:
			velocity.x = walljumpdisplace*get_wall_normal().x
		
		if !canSlamJump:
			velocity.y = -JUMP_VELOCITY * delta
		elif canSlamJump and jumpCast.is_colliding():
			velocity.y = ((-JUMP_VELOCITY)*jumpMultiplyer) * delta
			jumpMultiplyer += JMinscrease
		elif canSlamJump and !jumpCast.is_colliding():
			velocity.y = -JUMP_VELOCITY * delta
		
func slideAndStopMovement(delta):
	if Input.is_action_just_pressed("slideStomp"):
		if !jumpCast.is_colliding():
			gravity = 45000
			canSlamJump = true
			$"time fore higher jump after slam".start()
		else:
			gravity = defultGrav
			maxSpeed = 1400
	elif Input.is_action_just_released("slideStomp"):
		maxSpeed = defMaxSpeed
		

func _on_time_fore_higher_jump_after_slam_timeout() -> void:
	canSlamJump = false
	jumpMultiplyer = defJumpMultiplyer
	currentJump = 0
	print("STOPPED")


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("wallJump"):
		#print("isOnWallGroup")
		if is_on_wall():
			currentJump = 0
			isOnJumpableWall = true
			#print("PrevAndIsOnWALL")


func _on_area_2d_body_exited(body: Node2D) -> void:
	isOnJumpableWall = false
	
