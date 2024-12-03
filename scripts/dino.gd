extends Node2D

@export var jump_force: float = 20
@export var gravity: float = 100
@export var velocity: float = 0
@export var floor: float = 200 ##NOTE -> 230 is floor, we add dino sprite size to comp for offset

var ducking: bool = false

func _process(delta: float) -> void:
	##Jump logic
	if is_grounded():
		if Input.is_action_just_pressed("jump"):
			velocity -= jump_force
		else:
			velocity = 0
			position.y = floor
	else:
		velocity += gravity * delta
	position.y += velocity

	##Duck Logic
	if Input.is_action_just_pressed("duck") && ducking == false:
		##TODO proper animation shifting w sprites
		scale.y *= 0.5
		floor += 16 ##NOTE value tied to sprite size
		position.y += 16 
		ducking = true
	if Input.is_action_just_released("duck") && ducking == true:
		scale.y *= 2
		floor -= 16##NOTE ^^^ See Above
		position.y -= 16
		ducking = false
	


func is_grounded() -> bool:
	if position.y >= floor:
		return true
	else:
		return false
