extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.init_app()
	# Star 그리기
	var index = 0
	for star_node in $WinnerBox/starts_box.get_children():
		star_node.get_child(0).visible = Global.award_count > index
		index += 1


func _on_start_button_pressed():
	SceneTransition.change_scene(Global.GAME_SCENE_PATH)

func _on_exit_button_pressed():
	Global.exit_game()

func _on_option_button_pressed():
	SceneTransition.change_scene(Global.OPTION_SCENE_PATH)
