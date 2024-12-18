class_name UI
extends Control

@export var score_ui: Control
@export var go_ui: Control
@export var tut_ui: Control
@export var score_label: Label
@export var hi_score_label: Label

@export var ui_game_over: Control
@export var ui_tutorial: Control

func hide_tutorial() -> void:
	ui_tutorial.hide()

func update_score(new_score: int) -> void :
	score_label.text = str_zero_pad(str(new_score), 5)

func update_hi_score(new_score: int) -> void :
	hi_score_label.text = str_zero_pad(str(new_score), 5)

func show_game_over() -> void:
	ui_game_over.show()

func hide_game_over() -> void:
	ui_game_over.hide()

func str_zero_pad(raw_str: String, target_len: int) -> String:
	if raw_str.length() < target_len:
		var padding = ""
		for i in range(0, target_len - raw_str.length()):
			padding += "0"
		var padded_str = padding + raw_str
		return padded_str
	else:
		return raw_str
