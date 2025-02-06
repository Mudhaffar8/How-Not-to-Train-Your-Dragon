extends Node

'''
General use class for switching between scenes.
Use the "switch_scene" function.

Example use case
-------------------

scene_switcher.switch_scene("res://scenes/name_of_scene.tscn")
'''

@onready var anim_player = $AnimationPlayer

var current_scene = null


func _ready() -> void:
	'''
	Get first child in scene tree and set as current scene.
	'''
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)


func switch_scene(path : String, speed : float = 1.0) -> void:
	'''
	To be called directly.
	'''
	call_deferred("_deferred_switch_scene", path, speed)


func _deferred_switch_scene(path : String, speed : float):
	'''
	Not to be called directly.
	Free current scene and load new scene as current scene
	'''
	# Animation in
	anim_player.play("fade", -1, speed)
	await anim_player.animation_finished
	
	# Free previous scene and instantiate new scene
	current_scene.free()
	var new_scene = load(path)
	current_scene = new_scene.instantiate()
	
	# Set new scene as current scene
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
	# Animation out
	anim_player.play_backwards("fade")
	await anim_player.animation_finished
