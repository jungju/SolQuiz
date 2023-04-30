extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_start_button_pressed():
	SceneTransition.change_scene(Global.GAME_SCENE_PATH)

func _on_exit_button_pressed():
	Global.exit_game()

func _on_option_button_pressed():
	SceneTransition.change_scene(Global.OPTION_SCENE_PATH)
