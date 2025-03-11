extends Node2D

var AHHHHHaorgasumTouchingmefuck = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_special_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		print("AHHH TOUCHING ME !! HELP ")
		$mainPlayer/RemoteTransform2D.queue_free()
		var tween = get_tree().create_tween()
		tween.tween_property($mainCam, "position", Vector2(31559,-51138), 6)
		$special/Timer.start()
			


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file(Globals.levelList.secondTUT)
