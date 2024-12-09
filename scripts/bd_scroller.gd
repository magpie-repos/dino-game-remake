extends Sprite2D

var global_scroll_speed: float = 50
var far_scroll_speed: float = 0.5
var med_scroll_speed: float = 1

var horizon_line: int = 216
var game_speed: int

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
var g_scuffs_scene: PackedScene = preload("res://assets/scenes/ground_scuff_1.tscn")

var far_array: Array[Sprite2D]
var med_array: Array[Sprite2D]

var num_far_mount: int = 6
var num_med_rock: int = 5
var num_g_scuff: int = 3
var num_far_cloud: int = 2
var num_med_cloud: int = 1

func _ready() -> void:
	##Far Mount Seup
	for i in range(0, num_far_mount):
		var new_mount: Sprite2D = far_mount_scenes.pick_random().instantiate()
		new_mount.position.y = horizon_line 
		new_mount.position.x = randi_range(0, get_window().size.x)
		add_child(new_mount)
		far_array.append(new_mount)
	##Med Rock Setup
	for i in range(0, num_med_rock):
		var new_rock: Sprite2D = med_rock_scenes.pick_random().instantiate()
		new_rock.position.y = horizon_line
		new_rock.position.x = (randi_range(0, get_window().size.x) / num_med_rock) * (1 + i)
		add_child(new_rock)
		med_array.append(new_rock)
	''' TODO: Figure out this shit
	##Ground Scuff Setup
	for i in range(0, num_g_scuff):
		var new_scuff: Sprite2D = g_scuffs_scene.instantiate()
		new_scuff.frame = randi_range(0, vframes - 1)
		new_scuff.position = Vector2(250, 250)
		add_child(new_scuff)
		new_rock.position.y = horizon_line
		new_rock.position.x = (randi_range(0, get_window().size.x) / num_med_rock) * (1 + i)
		add_child(new_rock)
		med_array.append(new_rock)
	'''
	
func _process(delta: float) -> void:
		game_speed = get_parent().game_speed
		
		##Far Object Stuff
		for f in range(0, far_array.size()):
			far_array[f].position.x -= game_speed * global_scroll_speed * far_scroll_speed * delta
			
			if far_array[f].position.x <= 0 - 64:
				far_array[f].position.x = get_window().size.x + 64
		
		##Med Object Stuff
		for m in range(0, med_array.size()):
			med_array[m].position.x -= game_speed * global_scroll_speed * med_scroll_speed * delta
			
			if med_array[m].position.x <= 0 - 64:
				med_array[m].position.x = get_window().size.x + 64
	

##Teleport back after passing edge
