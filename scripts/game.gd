extends Node2D

const PAGE_NAME = "game"

# Called when the node enters the scene tree for the first time.
func _ready():
	# 타이머 가동
	$Timer.start(1.0)
	$Timer.timeout.connect(_on_timer_tick)
	
	#Global.next_quetion.connect(_on_next_quetion)

	$AnimationPlayer.play("timer_ticking")
	$AnimationPlayer.animation_finished.connect(_on_time_ticking_animation_finished)

	# 하트 번쩍번쩍 커졌다 작아졌다 하기

	# 문제 뷰

	$answer1.pressed.connect(_on_answer1_pressed)
	$answer2.pressed.connect(_on_answer2_pressed)

	Global.init_game()
	next_question()
	

func _on_answer1_pressed():
	if Global.choice_answer(1):
		correct_answer()
	else:
		incorrect_answer()


func _on_answer2_pressed():
	if Global.choice_answer(2):
		correct_answer()
	else:
		incorrect_answer()

func _on_time_ticking_animation_finished(_animation_name):
	# 타임 오버
	game_time_over()

func _on_timer_tick():
	var current_time = $AnimationPlayer.current_animation_position
	var time_text = "%d" % (30 - int(round(current_time)))
	$time_bar/time_label.text = time_text

func correct_answer():
	# 정답 처리
	next_question()
	pass

func incorrect_answer():
	# 오답 처리
	next_question()
	pass

func next_question():
	# 문제 가져오기
	var current_quiz = Global.get_next_quiz()
	if current_quiz == null:
		game_done()
		return

	$question_box/question_text.text = current_quiz["question"]
	$answer1/Label.text = current_quiz["options"][0]
	$answer2/Label.text = current_quiz["options"][1]
	print(current_quiz)	
	# TODO: 문제 화면 적용


	pass

func game_time_over():
	game_done()


func game_done():
	pass
