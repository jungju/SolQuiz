extends Node2D

var answer_board_incorrect_answer = load("res://assets/images/game_answer_board4.png")
var answer_board_correct_answer = load("res://assets/images/game_answer_board5.png")

var is_processing_answer: bool = false
var initial_loading_complete: bool = false
var answer_option_callable = Callable(self, "_on_answer_pressed")
var time_count = 0

func _ready():
	$game_menu.visible = false
	$game_board/question_box.visible = false
	$game_board/answer1.visible = false
	$game_board/answer2.visible = false
	$AnimationPlayer.play("show_leaf")

	$game_board/answer1.connect("pressed", answer_option_callable.bindv([1]))
	$game_board/answer2.connect("pressed", answer_option_callable.bindv([2]))

	Global.init_game()

func _on_answer_pressed(value):
	# 게임 로딩중 또는 게임 문제 확인중
	if !initial_loading_complete || is_processing_answer:
		return

	is_processing_answer=true

	if Global.choice_answer(value): 
		correct_answer()
	else: 
		incorrect_answer()

func correct_answer():
	# 정답 처리
	next_question()

func incorrect_answer():
	# 오답 처리
	next_question()

func _on_timer_tick():
	time_count = time_count + 1
	var target_leaf = $time_board/leaf_box.get_child(time_count-1)
	if target_leaf != null:
		target_leaf.visible = false
	else:
		game_time_over()
	
func game_time_over():
	game_done()

func next_question():
	# 문제 가져오기
	var current_quiz = Global.get_next_quiz()
	if current_quiz.size() == 0:
		game_done()
		return

	var info_index = "문제 "+str(Global.current_quiz_index)
	var info_category = current_quiz["category"]

	$game_board/question_box/question_info.text = info_index + " - 유형:" + info_category
	$game_board/question_box/question_text.text = current_quiz["question"]
	$game_board/answer1/Label.text = current_quiz["options"][0]
	$game_board/answer2/Label.text = current_quiz["options"][1]
	
	is_processing_answer = false

func game_start():
	initial_loading_complete = true
	$game_board/question_box.visible = true
	$game_board/answer1.visible = true
	$game_board/answer2.visible = true
	# 타이머 가동
	$Timer.start(3.0)
	$Timer.timeout.connect(_on_timer_tick)
	next_question()

func game_done():
	SceneTransition.change_scene(Global.RESULT_SCENE_PATH)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "show_leaf":
		game_start()

func _on_pause_button_pressed():
	$game_menu.visible = true
	if !initial_loading_complete:
		$AnimationPlayer.pause()
	else:
		$Timer.stop()

func _on_game_gomain_button_pressed():
	SceneTransition.change_scene(Global.MAIN_SCENE_PATH)

func _on_game_resume_button_pressed():
	$game_menu.visible = false
	if !initial_loading_complete:
		$AnimationPlayer.play("show_leaf")
	else:
		$Timer.start(3.0)
