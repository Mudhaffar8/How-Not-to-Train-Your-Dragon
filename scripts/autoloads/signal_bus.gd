class_name SignalBus
extends Node

'''
General use class for managing signals globally.
Useful for "one-to-many" or "many-to-many" communication.
Use the "signal_bus" node to access it.


Example Use Case
-------------------
node.gd (sending the signal):

func _ready() -> void:
	# Sends a signal
	signal_bus.emit_signal("test_signal", "Hello, World") # Signal, parameters
	
	
node2.gd (receiving the signal):

func _ready() -> void:
	# connect to signal
	signal_bus.connect("test_signal", printHelloWorld) # Signal name, callback function
	
	
func printHelloWorld(val : String) -> void: 
	# Make sure parameters match
	print(val)
'''

# Insert global signals below

# One way for managing game state
# new_state could be an enum for different game states?
# signal game_state_changed(new_state) 
