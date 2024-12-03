extends Node2D

var base_obst_speed: float = 225
var obst_array: Array[Node2D]
var obst_cap: int = 1
var safe_spawn_margin: float = 75

@onready var window_size: Vector2 = get_window().size
@onready var game_manager: GameManager = get_parent()
@onready var temp_obst_scene: PackedScene = preload("res://assets/scenes/small_rock.tscn")

func _process(delta: float) -> void:
	if obst_array.size() < obst_cap:
		add_obst()
	
	for i in range(0, obst_array.size()):
		obst_array[i].position.x -= base_obst_speed * game_manager.game_speed * delta
		print(obst_array[i].position)
		if obst_array[i].position.x < 0 - safe_spawn_margin:
			obst_array[i].queue_free()
			obst_array.pop_at(i)

func add_obst() -> void:
	var new_obst: Node2D = temp_obst_scene.instantiate()
	new_obst.position.x = window_size.x + safe_spawn_margin
	new_obst.position.y = 200
	add_child(new_obst)
	
	obst_array.append(new_obst)
