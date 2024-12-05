extends Node2D

@export var jump_force: float = 20
@export var gravity: float = 100
@export var velocity: float = 0
@export var floor: float = 196  ##NOTE -> 230 is floor, we add dino sprite size to comp for offset
##Refs
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var up_col_shape: CollisionPolygon2D = $Area2D/UpColShape
@onready var duck_col_shape: CollisionPolygon2D = $Area2D/DuckColShape
@onready var sprite: Sprite2D = $DinoSprite
@onready var death_part: CPUParticles2D = $DeathParticle

##State vars
var ducking: bool = false
var game_start: bool = false

##Signals
signal ded

func _process(delta: float) -> void:
	
	manage_animation_state()
	
	##Jump logic
	if is_grounded():
		if Input.is_action_just_pressed("jump"):
			velocity -= jump_force
		else:
			velocity = 0
			position.y = floor
	else:
		ducking = false
		velocity += gravity * delta
	position.y += velocity

	##Duck Logic
	if Input.is_action_pressed("duck"):
		if ducking == false && is_grounded():
			ducking = true
			up_col_shape.show()
			duck_col_shape.hide()
	else:
		ducking = false
		duck_col_shape.show()
		up_col_shape.hide()

func manage_animation_state() -> void:
	if !game_start:
		anim_player.play("still")
	else:
		if is_grounded():
			if !ducking && anim_player.current_animation != "up_walk":
				anim_player.play("up_walk")
			elif ducking && anim_player.current_animation != "duck_walk":
				anim_player.play("duck_walk")
		else: ##if not grounded
			if anim_player.current_animation != "still":
				anim_player.play("still")

func is_grounded() -> bool:
	if position.y >= floor:
		return true
	else:
		return false

func reset_dino() -> void:
	game_start = false	
	sprite.show()
	death_part.hide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	sprite.hide()
	death_part.show()
	death_part.emitting = true
	ded.emit()
