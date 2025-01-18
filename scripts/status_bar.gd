class_name StatusBar
extends Control

@onready var progress_bar = $HBoxContainer/ProgressBar

func _ready() -> void:
	pass
	
func set_value(value : float):
	progress_bar.value = value
