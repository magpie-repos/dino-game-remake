extends Node2D

var triggered: bool = false
var dino_pos: float = 60

@onready var sfx: AudioStreamPlayer = $SnakeSFX
@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim.play("idle")
	position.y -= 32 #Make sure the snake spawns above the ground rather than in it

func _process(delta: float) -> void:
	if position.x < dino_pos + 64 && triggered == false:
		sfx.play()
		anim.play("strike")
