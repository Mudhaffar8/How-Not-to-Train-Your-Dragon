extends Node
'''
General use class for switching between scenes.
Use the "switch_scene" function.

Example use case
-------------------

scene_switcher.switch_scene("res://scenes/name_of_scene.tscn")
'''
var current_scene = null

func _ready() -> void:
	'''
	Get first child in scene tree and set as current scene.
	'''
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
	# print(current_scene.name)


func switch_scene(path : String) -> void:
	'''
	To be called directly.
	'''
	call_deferred("_deferred_switch_scene", path)


func _deferred_switch_scene(path : String):
	'''
	Not to be called directly.
	Free current scene and load new scene as current scene
	'''
	# Free previous scene and instantiate new scene
	current_scene.free()
	var new_scene = load(path)
	current_scene = new_scene.instantiate()
	
	# Set new scene as current scene of tree node
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
