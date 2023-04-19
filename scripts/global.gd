extends Node

const MAIN_SCENE_PATH = "res://scenes/main/main_page.tscn"
const GAME_SCENE_PATH = "res://scenes/game/game.tscn"

signal change_group
signal select_level

var current_page = "main"
var current_group = ""
var current_level = ""

func emit_change_group(group_name):
	current_group = group_name
	emit_signal("change_group")

func emit_select_level(level):
	current_level = level
	emit_signal("select_level")
