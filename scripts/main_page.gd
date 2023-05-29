extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	TranslationServer.set_locale('en')
	$title_box/Label.text = tr("TITLE")
	$start_button/Label.text = tr("START")
	$winner_box/Label.text = tr("WINNER_TITLE")
	$bottom_menu/option_button.text = tr("CONFIG")
	$bottom_menu/exit_button.text = tr("EXIT")
	$winner_box/winner_desc.text = tr("WINNER_DECRIPTION") 
	
	$start_button.disabled = false

	Global.init_app()
	# Star 그리기
	var index = 0
	var award_count = Global.config.get_value("game", "award", 0)
	for star_node in $winner_box/starts_box.get_children():
		star_node.get_child(0).visible = award_count > index
		index += 1
	
	GlobalMusicManager.play_music()


func _on_start_button_pressed():
	GlobalMusicManager.play_select_sound()
	$start_button.disabled = true
	SceneTransition.change_scene(Global.GAME_SCENE_PATH)

func _on_exit_button_pressed():
	Global.exit_game()

func _on_option_button_pressed():
	SceneTransition.change_scene(Global.OPTION_SCENE_PATH)
