extends Sprite2D
var far_scroll_speed: float = 0.1
var med_scroll_speed: float = 0.3

var horizon_line: int = 216
var obst_scroll_speed: int

#Obst Scenes
var far_mount_scenes: Array[PackedScene] = [
	preload("res://assets/scenes/far_mount_1.tscn"),
	preload("res://assets/scenes/far_mount_2.tscn"),
	preload("res://assets/scenes/far_mount_3.tscn")
]
var med_rock_scenes: Array[PackedScene] = [
	preload("res://assets/scenes/para_rock_med_1.tscn"),
	preload("res://assets/scenes//para_rock_med_2.tscn"),
	preload("res://assets/scenes//para_rock_med_3.tscn")
]
var g_scuff_scenes: Array[PackedScene] = [
	preload("res://assets/scenes/ground_scuff_1.tscn"),
	preload("res://assets/scenes/ground_scuff_2.tscn"),
	preload("res://assets/scenes/ground_scuff_3.tscn"),
	preload("res://assets/scenes/ground_scuff_4.tscn"),
	preload("res://assets/scenes/ground_scuff_5.tscn")
]

var far_array: Array[Sprite2D]
var med_array: Array[Sprite2D]
var near_array: Array[Sprite2D]

var num_far_mount: int = 6
var num_med_rock: int = 5
var num_g_scuff: int = 3
var num_far_cloud: int = 2
var num_med_cloud: int = 1

@onready var gm: GameManager = get_parent()

func _ready() -> void:
	
	##Far Mount Seup
	for i in range(0, num_far_mount):
		var new_mount: Sprite2D = far_mount_scenes.pick_random().instantiate()
		new_mount.position.y = horizon_line 
		new_mount.position.x = randi_range(0, get_window().size.x)
		new_mount.scale *= randf_range(0.9, 1.1)
		if randf() > 0.5:
			new_mount.flip_h = true
		add_child(new_mount)
		far_array.append(new_mount)
	##Med Rock Setup
	for i in range(0, num_med_rock):
		var new_rock: Sprite2D = med_rock_scenes.pick_random().instantiate()
		new_rock.position.y = horizon_line
		new_rock.position.x = (randi_range(0, get_window().size.x) / num_med_rock) * (1 + i)
		new_rock.scale *= randf_range(0.85, 1.15)
		if randf() > 0.5:
			new_rock.flip_h = true
		add_child(new_rock)
		med_array.append(new_rock)
	##Ground Scuff Setup
	for i in range(0, num_g_scuff):
		var new_scuff: Sprite2D = g_scuff_scenes.pick_random().instantiate()
		new_scuff.position.y = horizon_line
		new_scuff.position.x = (randi_range(0, get_window().size.x) / num_med_rock) * (1 + i)
		new_scuff.scale *= randf_range(0.85, 1.15)
		if randf() > 0.5:
			new_scuff.flip_h = true
		add_child(new_scuff)
		near_array.append(new_scuff)
	
func _process(delta: float) -> void:
		
		##Far Object Stuff
		for f in range(0, far_array.size()):
			far_array[f].position.x -= gm.game_speed * gm.global_base_speed * far_scroll_speed * delta
			
			if far_array[f].position.x <= 0 - 64:
				far_array[f].position.x = get_window().size.x + 64 + (randf() * 64)
		
		##Med Object Stuff
		for m in range(0, med_array.size()):
			med_array[m].position.x -= gm.game_speed * gm.global_base_speed * med_scroll_speed * delta
			
			if med_array[m].position.x <= 0 - 64:
				med_array[m].position.x = get_window().size.x + 64 + (randf() * 64)

		##Near Object Stuff
		for n in range(0, near_array.size()):
			near_array[n].position.x -= gm.game_speed * gm.global_base_speed * delta
			
			if near_array[n].position.x <= 0 - 64:
				near_array[n].position.x = get_window().size.x + 64 + (randf() * 64)
