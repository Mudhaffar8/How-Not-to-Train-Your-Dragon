class_name StatusBar
extends Control


@export var texture : Texture2D 

@onready var progress_bar = $HBoxContainer/ProgressBar
@onready var texture_node = $HBoxContainer/TextureRect


func _ready() -> void:
	texture_node.texture = texture

func set_value(value : float) -> void:
	progress_bar.value = value
	
func get_value(value : float) -> float: 
	return progress_bar.value
