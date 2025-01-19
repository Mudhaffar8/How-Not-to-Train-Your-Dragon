extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_go_back_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main.tscn")


func _on_timer_timeout() -> void:
	pass # Replace with function body.
