extends Node2D

const PAGE_NAME = "game"

# Called when the node enters the scene tree for the first time.
func _ready():
	# 타이머 가동
	$Timer.start(1.0)
	$Timer.timeout.connect(_on_timeout)
	$AnimationPlayer.play("timer_ticking")
	$AnimationPlayer.animation_finished.connect(_on_time_ticking_animation_finished)

	# 하트 번쩍번쩍 커졌다 작아졌다 하기

	# 문제 뷰

	#
	pass

func _on_time_ticking_animation_finished(animation_name):
	print(animation_name)

func _on_timeout():
	var current_time = $AnimationPlayer.current_animation_position
	var rounded_time = int(round(current_time))
	var time_text = "%d" % (30 - rounded_time)
	$time_bar/time_label.text = time_text
