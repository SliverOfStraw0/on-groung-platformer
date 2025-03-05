extends Area2D

@export_category("cam limits")
@export var minX = 0
@export var maxX = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	print("AREA ENTERS TO CHANGE CAM")
	Globals.emit_signal("changeCamLimits",minX,maxX)
	
