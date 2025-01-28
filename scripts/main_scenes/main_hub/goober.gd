class_name Goober
extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var state_timer = $StateTimer

const SPEED = 30

enum Stages { EGG, BABY, TEEN }
enum States { IDLE, WALK }

var curr_stage = Stages.EGG
var curr_state = States.IDLE
var dir = Vector2.ZERO

var rng = RandomNumberGenerator.new()

var boundary_min : Vector2
var boundary_max : Vector2
var velocity : Vector2


func _ready() -> void:
	var screen_size = get_viewport_rect().size
	
	boundary_min = screen_size / 2 + Vector2(30.0, -10.0)
	boundary_max = screen_size - Vector2(30.0, 60.0)


func _process(delta: float) -> void:
	if globals.seconds < globals.egg_time:
		self.scale = Vector2(0.23, 0.23)
		
		sprite.play("egg")
		curr_stage = Stages.EGG
	
	# Messy Solution for now oops
	if globals.seconds >= globals.egg_time and curr_stage != Stages.TEEN:
		self.scale = Vector2(0.35, 0.35)
		
		if curr_state == States.IDLE:
			sprite.play("baby_idle")
		else:
			sprite.play("baby_walk")
			
		curr_stage = Stages.BABY
		
	if globals.seconds >= globals.baby_time:
		self.scale = Vector2(0.5, 0.5)
		
		if curr_state == States.IDLE:
			sprite.play("teen_idle")
		else:
			sprite.play("teen_walk")
			
		curr_stage = Stages.TEEN
		
	sprite.flip_h = true if dir.x > 0 else false

func _physics_process(delta: float) -> void:
	if curr_state == States.WALK and curr_stage != Stages.EGG:
		velocity = dir * SPEED
		position += velocity * delta
	
		# Check for collisions
		if ((position.y > boundary_max.y and dir.y > 0) or (position.y < boundary_min.y and dir.y < 0)):
			dir.y *= -1
		elif ((position.x < boundary_min.x and dir.x < 0) or (position.x > boundary_max.x and dir.x > 0)):
			dir.x *= -1

func _on_state_timer_timeout() -> void:
	state_timer.wait_time = rng.randf_range(2.0, 5.0)
	
	if curr_stage == Stages.EGG:
		return
	
	if curr_state == States.IDLE:
		curr_state = States.WALK
		
		# Randomize direction
		dir.x = rng.randf_range(-1, 1)
		dir.y = rng.randf_range(-1, 1)
		dir = dir.normalized()
		
	else:
		curr_state = States.IDLE
		dir = Vector2.ZERO
