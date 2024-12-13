extends Sprite2D
var far_scroll_speed: float = 0.1
var far_cloud_scroll_speed: float = 0.05
var med_scroll_speed: float = 0.3
var med_cloud_scroll_speed: float = 0.25

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
	preload("res://assets/scenes//para_rock_med_3.tscn"),
	preload("res://assets/scenes/med_rock_4.tscn"),
	preload("res://assets/scenes/med_rock_5.tscn"),
	preload("res://assets/scenes/med_rock_6.tscn")
]

var far_cloud_scenes: Array[PackedScene] = [
	preload("res://assets/scenes/far_cloud_1.tscn"),
	preload("res://assets/scenes/far_cloud_2.tscn"),
	preload("res://assets/scenes/far_cloud_3.tscn")
]
var near_cloud_scenes: Array[PackedScene] = []

var far_array: Array[Sprite2D]
var med_array: Array[Sprite2D]

var far_cloud_array: Array[Sprite2D]
var med_cloud_array: Array[Sprite2D]

var num_far_mount: int = 16
var num_med_rock: int = 4 
var num_far_cloud: int = 3

@onready var gm: GameManager = get_parent()
@onready var win_size: Vector2 = get_window().size

func _ready() -> void:
	
	##Far Cloud Setup
	for i in range(0, num_far_cloud):
		var new_cloud: Node2D = spawn_cloud()
		new_cloud.position.x = randf_range(0.6, 1.4) * (((win_size.x + 128) / num_far_cloud * i) - 64)
		add_child(new_cloud)
		far_cloud_array.append(new_cloud)
	
	##Far Mount Seup
	for i in range(0, num_far_mount):
		var new_mount: Node2D = spawn_mount()
		new_mount.position.x = ((win_size.x + 128) / num_far_mount * i) - 64
		add_child(new_mount)
		far_array.append(new_mount)
		
	##Med Rock Setup
	for i in range(0, num_med_rock):
		var new_rock: Node2D = spawn_rock()
		new_rock.position.x = randf_range(0.6, 1.4) * (((win_size.x + 128) / num_med_rock * i) - 64)
		add_child(new_rock)
		med_array.append(new_rock)

func spawn_cloud() -> Node2D:
	var new_cloud: Sprite2D = far_cloud_scenes.pick_random().instantiate()
	new_cloud.position.y = horizon_line - 100
	new_cloud.position.x = win_size.x + 64
	new_cloud.scale *= randf_range(0.75, 1.25)
	new_cloud.rotation *= randf_range(0.95, 1.05)
	if randf() > 0.5:
		new_cloud.flip_h = true
	
	return new_cloud

func spawn_mount() -> Node2D:
	var new_mount: Sprite2D = far_mount_scenes.pick_random().instantiate()
	new_mount.position.y = horizon_line 
	new_mount.position.x = win_size.x + 64
	new_mount.scale *= randf_range(0.9, 1.1)
	if randf() > 0.5:
		new_mount.flip_h = true
		
	return new_mount

func spawn_rock() -> Node2D:
	var new_rock: Sprite2D = med_rock_scenes.pick_random().instantiate()
	new_rock.position.y = horizon_line
	new_rock.position.x = get_window().size.x + 64 + randf() * 64
	new_rock.scale *= randf_range(0.85, 1.15)
	if randf() > 0.5:
		new_rock.flip_h = true
	
	return new_rock

func _process(delta: float) -> void:

		##Far Cloud Stuff
		for c in range(0, far_cloud_array.size()):
			far_cloud_array[c].position.x -= gm.game_speed * gm.global_base_speed * far_cloud_scroll_speed * delta
			
			if far_cloud_array[c].position.x <= 0 - 64:
				far_cloud_array[c].queue_free()
				far_cloud_array.pop_at(c)
				var new_cloud: Node2D = spawn_cloud()
				add_child(new_cloud)
				far_cloud_array.append(new_cloud)
		
		##Far Object Stuff
		for f in range(0, far_array.size()):
			far_array[f].position.x -= gm.game_speed * gm.global_base_speed * far_scroll_speed * delta
			
			if far_array[f].position.x <= 0 - 64:
				far_array[f].queue_free()
				far_array.pop_at(f)
				var new_mount: Node2D = spawn_mount()
				add_child(new_mount)
				far_array.append(new_mount)
		
		##Med Object Stuff
		for m in range(0, med_array.size()):
			med_array[m].position.x -= gm.game_speed * gm.global_base_speed * med_scroll_speed * delta
			
			if med_array[m].position.x <= 0 - 64:
				med_array[m].queue_free()
				med_array.pop_at(m)
				var new_med: Node2D = spawn_rock()
				add_child(new_med)
				med_array.append(new_med)
