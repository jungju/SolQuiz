extends Node2D

var state: String = "start"

var time_count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$game_menu.visible = false
	$AnimationPlayer.play("show_leaf")

	$game_board/answer1.pressed.connect(_on_answer1_pressed)
	$game_board/answer2.pressed.connect(_on_answer2_pressed)

	Global.init_game()
	
func _on_answer1_pressed(): _on_answer_pressed(1)
func _on_answer2_pressed(): _on_answer_pressed(2)

func _on_answer_pressed(value):
	if state == "start":
		return

	if Global.choice_answer(value): correct_answer()
	else: incorrect_answer()

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
	state = "time_over"
	game_done()

func next_question():
	# 문제 가져오기
	var current_quiz = Global.get_next_quiz()
	if current_quiz.size() == 0:
		game_done()
		return

	$game_board/question_box/question_text.text = current_quiz["question"]
	$game_board/answer1/Label.text = current_quiz["options"][0]
	$game_board/answer2/Label.text = current_quiz["options"][1]
	# TODO: 문제 화면 적용


func game_done():
	state = "done"
	# TODO: Result 화면 보여주기
	SceneTransition.change_scene(Global.RESULT_SCENE_PATH)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "show_leaf":
		state = "playing"
		$game_board/question_box.visible = true
		$game_board/answer1.visible = true
		$game_board/answer2.visible = true
		# 타이머 가동
		$Timer.start(3.0)
		$Timer.timeout.connect(_on_timer_tick)
		next_question()


func _on_pause_button_pressed():
	$game_menu.visible = true
	if state == "start":
		$AnimationPlayer.pause()
	else:
		$Timer.stop()

func _on_game_gomain_button_pressed():
	SceneTransition.change_scene(Global.MAIN_SCENE_PATH)

func _on_game_resume_button_pressed():
	$game_menu.visible = false
	if state == "start":
		$AnimationPlayer.play("show_leaf")
	else:
		$Timer.start(3.0)
