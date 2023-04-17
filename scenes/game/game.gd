extends Node2D

const PAGE_NAME = "game"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu.goto_main_scene.connect(_on_goto_main_scene)

func _on_goto_main_scene():
	get_tree().change_scene_to_file(Global.MAIN_SCENE_PATH)