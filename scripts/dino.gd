extends Node2D

@export var jump_force: float = 20
@export var gravity: float = 100
@export var velocity: float = 0
@export var floor: float = 196
##Refs
@onready var body_anim_player: AnimationPlayer = $BodyAnimaiton
@onready var leg_anim_player: AnimationPlayer = $LegAnimation
@onready var up_col_shape: CollisionPolygon2D = $Area2D/UpColShape
@onready var duck_col_shape: CollisionPolygon2D = $Area2D/DuckColShape
@onready var body_sprite: Sprite2D = $DinoSprite
@onready var leg_sprite: Sprite2D = $DinoLegs
@onready var death_part_scene: PackedScene = preload("res://assets/scenes/death_particle.tscn")
var death_part: CPUParticles2D

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
		leg_anim_player.play("stand")
	else:
		leg_anim_player.play("walk")
		if is_grounded():
			if !ducking && body_anim_player.current_animation != "up":
				body_anim_player.play("up")
			elif ducking && body_anim_player.current_animation != "duck":
				body_anim_player.play("duck")
		else: ##if not grounded
			if leg_anim_player.current_animation != "stand":
				leg_anim_player.play("stand")

func is_grounded() -> bool:
	if position.y >= floor:
		return true
	else:
		return false

func reset_dino() -> void:
	game_start = false	
	body_sprite.show()
	leg_sprite.show()
	
	if death_part:
		print("in reset dino")
		death_part.queue_free()
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	body_sprite.hide()
	leg_sprite.hide()
	death_part = death_part_scene.instantiate()
	add_child(death_part)
	ded.emit()
