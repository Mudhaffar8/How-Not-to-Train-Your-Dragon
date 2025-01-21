extends Node2D

@onready var pipe_scene = preload("res://scenes/minigames/flappy_bird/pipe.tscn")
@onready var pipedown_scene = preload("res://scenes/minigames/flappy_bird/pipedown.tscn")
@onready var pipe_spawn_timer = $PipeSpawnTimer

var rng = RandomNumberGenerator.new()


func _ready():
	$PipeSpawnTimer.start()
	_on_pipe_spawn_timer_timeout()
	globals.coinsFlappy = 0
	$Label.text = "Coins collected: 0"

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):  
		$Label2.visible = false

func _on_pipe_spawn_timer_timeout() -> void:
	$Label.text = "Coins collected: " + str(globals.coinsFlappy)
	globals.coinsFlappy += 5
	globals.fun += 2
	var ran1 = rng.randi_range(0, 100)
	if ran1 > 20:
		var pipe = pipe_scene.instantiate() 
		pipe.position = Vector2(1100, randf_range(-100, 0))
		add_child(pipe)
	
	var ran2 = rng.randi_range(0, 100)
	if ran2 > 20:
		var pipe2 = pipedown_scene.instantiate()
		pipe2.position = Vector2(1100, randf_range(0, 100))  
		add_child(pipe2)

func _game_over():
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		scene_switcher.switch_scene("res://scenes/minigames/gameOverMini.tscn")


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		scene_switcher.switch_scene("res://scenes/minigames/gameOverMini.tscn")
