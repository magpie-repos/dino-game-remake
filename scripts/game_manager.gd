extends Node2D
class_name GameManager

var game_over: bool = false
var game_start: bool = false
var score: int
var hi_score: int
var game_speed: float =  0
var global_base_speed: float = 400
var speed_multiplier: float = 0.10
var score_increment: float = 0.10
var score_time_cntr: float

@onready var dino_node: Node2D = $Dino
@onready var obst_spawner: Node2D = $ObstSpawner
@onready var ui: UI = $UI

func _ready() -> void:
	reset_game()
	ui.update_score(score)
	ui.update_hi_score(hi_score)

func _process(delta: float) -> void:
	if Input.is_anything_pressed() && !game_start:
		game_start = true
		start_game()
	
	if game_over && Input.is_action_just_pressed("reset"):
		reset_game()
	
	if game_start && !game_over:
		
		score_time_cntr += delta
		if score_time_cntr >= score_increment:
			score += 1 
			score_time_cntr = 0
			
		ui.update_score(score)
		if score > hi_score:
			hi_score = score
			ui.update_hi_score(snapped(hi_score, 1))
		
		if game_speed < 10:
			game_speed = score / 100 * speed_multiplier + 1
		else:
			game_speed = 10

func start_game() -> void:
	game_speed = 1
	dino_node.game_start = true
	obst_spawner.spawning_active = true

func end_game() -> void:
	game_over = true
	obst_spawner.spawning_active = false
	get_tree().paused = true
	if score >= hi_score:
		save_score(snapped(score, 1))

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
	return hi_scr
		
func save_score(scr: int) -> void:
	var file = FileAccess.open("score.sav", FileAccess.WRITE)
	file.store_32(snapped(scr, 1))
	file.close()

func _on_dino_ded() -> void:
	end_game()
