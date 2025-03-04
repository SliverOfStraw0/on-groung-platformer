extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.changeCamLimits.connect(changeLimits)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func changeLimits(nx,x):
	print("gyattit")
	print(nx)
	print(x)
	if !nx == null:
		limit_left = nx
	limit_right = x
	
