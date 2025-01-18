extends Node2D

@onready var pipe_scene = preload("res://scenes/pipe.tscn")
@onready var pipe_spawn_timer = $PipeSpawnTimer



func _ready():
	$PipeSpawnTimer.start()


func _on_pipe_spawn_timer_timeout() -> void:
		# Logic to spawn pipes
	var pipe = pipe_scene.instantiate()  # Assuming you preload the pipe scene
	pipe.position = Vector2(480, randf_range(200, 500))  # Randomize Y position
	#pipe.connect("body_entered", self)
	add_child(pipe)

func _game_over():
	print("too bad")
