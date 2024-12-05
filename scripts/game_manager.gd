extends Node2D
class_name GameManager

var game_speed: float =  1
var game_over: bool = false
var game_start: bool = false
var score: int
var hi_score: int

@onready var dino_node: Node2D = $Dino
@onready var obst_spawner: Node2D = $ObstSpawner

func _ready() -> void:
	reset_game()

func _process(delta: float) -> void:
	if Input.is_anything_pressed() && !game_start:
		game_start = true
		start_game()
	
	if game_over && Input.is_action_just_pressed("reset"):
		reset_game()

func start_game() -> void:
	dino_node.game_start = true
	obst_spawner.spawning_active = true

func end_game() -> void:
	game_over = true
	obst_spawner.spawning_active = false
	get_tree().paused = true
	if score > hi_score:
		save_score(score)

func reset_game() -> void:
	game_start = false
	dino_node.game_start = false
	game_over = false
	obst_spawner.clear_obstacles()
	get_tree().paused = false
	dino_node.reset_dino()
	score = 0
	hi_score = load_score()

func load_score() -> int:
	var hi_scr: int
	var file: FileAccess = FileAccess.open("score.sav", FileAccess.READ)
	if file:
		hi_scr = file.get_32()
		file.close()
	else:
		hi_scr = 0
		print("here")
	
	return hi_scr
		
func save_score(scr: int) -> void:
	var file = FileAccess.open("score.sav", FileAccess.WRITE)
	file.store_32(scr)
	print(file)
	file.close()

func _on_dino_ded() -> void:
	end_game()
