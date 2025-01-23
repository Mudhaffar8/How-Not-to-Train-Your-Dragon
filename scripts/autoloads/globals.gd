class_name Globals
extends Node

'''
General use class for storing variables used across differents scenes.
Can be accessed using the "globals" node followed by the attribute name.

Example Use case
-------------------

print(globals.test) # Prints true
'''

var coins : int = 50
var coinsFlappy : int = 0

var food : float = 50.0
var fun : float = 50.0
var health : float = 50.0

var gooberState : String = "egg"

var seconds : int = 0
var main_time : int = 10
var egg_time : int = 10
var baby_time : int = 90
var teen_time : int = 180
