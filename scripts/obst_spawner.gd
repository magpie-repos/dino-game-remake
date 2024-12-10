extends Node2D

var obst_array: Array[Node2D]
var obst_cap: int = 1
var safe_spawn_margin: float = 50
var floor: float = 228
var spawning_active: bool = false

@onready var window_size: Vector2 = get_window().size
@onready var game_manager: GameManager = get_parent()
@onready var ground_obst_array: Array[PackedScene] = [
	preload("res://assets/scenes/small_rock.tscn"),
	preload("res://assets/scenes/obst_tall_cact.tscn"),
	preload("res://assets/scenes/obst_rock_large.tscn"),
	preload("res://assets/scenes/obst_cactus_trail1.tscn"),
	preload("res://assets/scenes/obst_cactus_trail_2.tscn")
]

func _process(delta: float) -> void:
	if obst_array.size() < obst_cap && spawning_active:
		add_obst()
	
	for i in range(0, obst_array.size()):
		obst_array[i].position.x -= game_manager.global_base_speed * game_manager.game_speed * delta
		if obst_array[i].position.x < 0 - safe_spawn_margin:
			obst_array[i].queue_free()
			obst_array.pop_at(i)

func add_obst() -> void:
	var new_obst: Node2D = ground_obst_array.pick_random().instantiate()
	new_obst.position.x = window_size.x + safe_spawn_margin + (randf() * 64)
	new_obst.position.y = floor
	add_child(new_obst)
	
	obst_array.append(new_obst)

func clear_obstacles() -> void:
	for i in range(0, obst_array.size()):
		obst_array[i].queue_free()
	obst_array.clear()
