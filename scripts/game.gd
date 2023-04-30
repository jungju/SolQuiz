extends Node2D

var time_count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("show_leaf")

	$game_board/answer1.pressed.connect(_on_answer1_pressed)
	$game_board/answer2.pressed.connect(_on_answer2_pressed)

	Global.init_game()
	

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
	time_count = time_count + 1
	#var current_time = $AnimationPlayer.current_animation_position
	#var target_index = int(round(current_time))
	#print(target_index)
	$time_board/leaf_box.get_child(time_count-1).visible = false
	#for leaf in $time_board/leaf_box:

	#int(round(current_time))

	# var time_text = "%d" % (30 - int(round(current_time)))
	# $time_bar/time_label.text = time_text
	#pass

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

	$game_board/question_box/question_text.text = current_quiz["question"]
	$game_board/answer1/Label.text = current_quiz["options"][0]
	$game_board/answer2/Label.text = current_quiz["options"][1]
	# TODO: 문제 화면 적용
	pass

func game_time_over():
	game_done()


func game_done():
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "show_leaf":
		$game_board/question_box.visible = true
		$game_board/answer1.visible = true
		$game_board/answer2.visible = true
		# 타이머 가동
		$Timer.start(3.0)
		$Timer.timeout.connect(_on_timer_tick)
		next_question()

