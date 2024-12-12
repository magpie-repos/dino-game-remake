extends Node2D

@export var jump_force: float = 500
@export var gravity: float = 1500
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

@onready var land_sfx: AudioStreamPlayer = $LandSFX
@onready var jump_sfx: AudioStreamPlayer = $JumpSFX
@onready var gm: GameManager = get_parent()

##State vars
var ducking: bool = false
var game_start: bool = false
var game_over: bool = false

##Signals
signal ded

func _process(delta: float) -> void:
	if !game_over:
		manage_animation_state()
		##Jump Logic 2: The Seagull
		if is_grounded() && Input.is_action_just_pressed("jump"):
			velocity -= jump_force
			jump_sfx.play()
		if !is_grounded():
			velocity += gravity * delta * gm.game_speed
			
		if position.y + velocity * delta * gm.game_speed > floor:
			velocity = 0
			position.y = floor
			land_sfx.play()
		else:
			position.y += velocity * delta * gm.game_speed

		
		##Duck Logic
		if Input.is_action_pressed("duck") && is_grounded():
			ducking = true
		else:
			ducking = false

func manage_animation_state() -> void:
	if !is_grounded() || !game_start:
		leg_anim_player.play("stand")
	elif leg_anim_player.current_animation != "walk":
		leg_anim_player.play("walk")
		
	##Body Animation
	if ducking && body_anim_player.current_animation != "duck":
		body_anim_player.play("duck")
		up_col_shape.hide()
		duck_col_shape.show()
	elif !ducking && body_anim_player.current_animation != "up":
		body_anim_player.play("up")
		up_col_shape.show()
		duck_col_shape.hide()

func is_grounded() -> bool:
	if position.y >= floor:
		return true
	else:
		return false

func reset_dino() -> void:
	game_start = false
	game_over = false
	body_sprite.show()
	leg_sprite.show()
	
	if death_part:
		death_part.queue_free()
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	game_over = true
	body_sprite.hide()
	leg_sprite.hide()
	death_part = death_part_scene.instantiate()
	add_child(death_part)
	ded.emit()
