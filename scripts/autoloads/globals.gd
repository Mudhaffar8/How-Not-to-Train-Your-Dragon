class_name Globals
extends Node

'''
General use class for storing variables used across differents scenes.
Can be accessed using the "globals" node followed by the attribute name.

Example Use case
-------------------

print(globals.coins)
'''

# Coins
var coins : int = 50
var coins_earned : int = 0 # For minigames

# Goober Stats
var food : float = 50.0
var fun : float = 50.0
var health : float = 50.0

# Managing Goober Stages
var seconds : int = 0
var main_time : int = 10
const egg_time : int = 10
const baby_time : int = 90
const teen_time : int = 180
