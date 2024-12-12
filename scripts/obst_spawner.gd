extends Node2D

var obst_array: Array[Node2D]
var safe_spawn_margin: float = 50
var floor: float = 228
var diff_scale: int
var min_spawn_time: float = 0.2
var init_spawn_time: float = 1.35
var spawning_active: bool = false

@onready var window_size: Vector2 = get_window().size
@onready var game_manager: GameManager = get_parent()
@onready var obst_scene_array: Array[PackedScene] = [
	preload("res://assets/scenes/small_rock.tscn"),
	preload("res://assets/scenes/obst_tall_cact.tscn"),
	preload("res://assets/scenes/cactus_pair.tscn"),
	preload("res://assets/scenes/snake.tscn"),
	preload("res://assets/scenes/obst_rock_large.tscn"),
	preload("res://assets/scenes/obst_cactus_trail1.tscn"),
	preload("res://assets/scenes/rock_stack_tall.tscn"),
	preload("res://assets/scenes/obst_cactus_trail_2.tscn")
]
@onready var pt_scene: PackedScene = preload("res://assets/scenes/pt.tscn")
@onready var spawn_timer: Timer = $ObstSpawnTimer

func _process(delta: float) -> void:
	diff_scale = 1 + game_manager.score / 100
	if diff_scale >= obst_scene_array.size() - 1:
		diff_scale = obst_scene_array.size() - 1
	
	for i in range(0, obst_array.size() - 1):
		obst_array[i].position.x -= game_manager.global_base_speed * game_manager.game_speed * delta
		if obst_array[i].position.x < 0 - safe_spawn_margin:
			obst_array[i].queue_free()
			obst_array.pop_at(i)

func add_obst() -> void:
	if diff_scale >= 5 && randf() < 1 / float(diff_scale):
		var new_obst: Node2D = pt_scene.instantiate()
		new_obst.position.x = window_size.x + safe_spawn_margin + (randf() * 64)
		new_obst.position.y = floor - randi_range(1, 8) * 16
		add_child(new_obst)
		obst_array.append(new_obst)
	else:
		var new_obst: Node2D = obst_scene_array[randi_range(0, diff_scale)].instantiate()
		new_obst.position.x = window_size.x + safe_spawn_margin + (randf() * 64)
		new_obst.position.y = floor
		add_child(new_obst)
		obst_array.append(new_obst)

func clear_obstacles() -> void:
	for i in range(0, obst_array.size()):
		obst_array[i].queue_free()
	obst_array.clear()

func reset_obst_spawner ():
	spawn_timer.wait_time = init_spawn_time

func _on_obst_spawn_timer_timeout() -> void:
	if spawning_active:
		spawn_timer.wait_time = (init_spawn_time / game_manager.game_speed) * randf_range(0.7, 1.3)
		if spawn_timer.wait_time < min_spawn_time || spawn_timer.wait_time > 5:
			spawn_timer.wait_time = min_spawn_time / game_manager.game_speed
		add_obst()
		print(spawn_timer.time_left)
