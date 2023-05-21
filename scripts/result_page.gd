extends Node2D

# award 조건
var time_limit = 55
var incorrect_limit = 5
var required_correct_answers = 10
var wrong_time = 10

func _ready():
	$gomain_button.disabled = false

	var total = Global.current_quizs_data.size()
	var correct = Global.current_count_correct
	var incorrect = Global.current_count_incorrect
	var end_time = Global.current_end_time
	var start_time = Global.current_start_time
	var point = correct * 100.0 / total
	
	$result_board/bar1/Label.text = str(correct) + "개 맞았습니다."
	$result_board/bar2/Label.text = str(incorrect) + "개 틀렸습니다."
	var remaining_quiz_count = total -correct - incorrect
	if remaining_quiz_count > 0:
		$result_board/bar3/Label.text = str(remaining_quiz_count) + "개 못 풀었습니다"
	else:
		$result_board/bar3/Label.text = "모두 풀었습니다."

	# 퀴즈를 보지않고 풀은 경우 처리
	var runing_time = int(round((end_time - start_time)/1000.0))
	if runing_time > 0 && runing_time < wrong_time:
		$result_board/bar1/Label.text = "-"
		$result_board/bar2/Label.text = "마구마구 풀었습니다."
		$result_board/bar3/Label.text = "-"
		$result_board/result_start/point_label.text = "0"
		return

	$result_board/result_start/point_label.text = str(point)
	var win = point >= 80
	if win:
		$result_board/result_start/TextureRect.modulate = Color(1, 1, 1, 1)
		$result_board/result_start/comment.text = "스티커 획득!"
	else:
		$result_board/result_start/comment.text = "다음에는 꼭 성공하세요."

	if win:
		Global.save_up_award_count_config()

func _on_gomain_button_pressed():
	$gomain_button.disabled = true
	SceneTransition.change_scene(Global.MAIN_SCENE_PATH)
