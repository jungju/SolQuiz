extends Node2D

# award 조건
var time_limit = 30
var incorrect_limit = 5
var required_correct_answers = 10
var wrong_time = 10

func _ready():
	$gomain_button.disabled = false

	$result_board/bar1/Label.text = str(Global.game_count_correct) + "개 맞음"
	var runing_time = int(round((Global.end_time - Global.start_time)/1000.0))
	if runing_time > 0:
		$result_board/bar2/Label.text = str(runing_time) + "초 진행"
	else:	
		$result_board/bar2/Label.text = "시간 초과"
	$result_board/bar3/Label.text = str(Global.game_count_incorrect) + "개 틀림"

	var check_correct = Global.game_count_correct > required_correct_answers
	var check_time = runing_time < time_limit && runing_time > 0
	var check_incorrect = Global.game_count_incorrect < incorrect_limit
	
	# 퀴즈를 보지않고 풀은 경우 처리
	if runing_time > 0 && runing_time < wrong_time:
		check_correct = false
		check_time = false
		check_incorrect = false
		$result_board/bar1/Label.text = "-"
		$result_board/bar2/Label.text = "너무 빠름"
		$result_board/bar3/Label.text = "-"

	$result_board/bar1/bar1_skull.visible = !check_correct
	$result_board/bar1/bar1_star.visible = check_correct
	$result_board/bar2/bar2_skull.visible = !check_time
	$result_board/bar2/bar2_star.visible = check_time
	$result_board/bar3/bar3_skull.visible = !check_incorrect
	$result_board/bar3/bar3_star.visible = check_incorrect

	var win = check_correct && check_time && check_incorrect
	$result_board/sticker_star.visible = win
	$result_board/no_star.visible = !win

	if win:
		Global.save_up_award_count_config()

func _on_gomain_button_pressed():
	$gomain_button.disabled = true
	SceneTransition.change_scene(Global.MAIN_SCENE_PATH)