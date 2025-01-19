class_name Globals
extends Node

'''
General use class for storing variables used across differents scenes.
Can be accessed using the "globals" node followed by the attribute name.

Example Use case
-------------------

print(globals.test) # Prints true
'''

# Insert Global functions and variables below
var test : bool = true
var coins : int = 50
var food : float = 50.0
var fun : float = 50.0
var health : float = 50.0
var coinsFlappy : int = 0
var seconds : int = 0
var gooberState : String = "egg"
