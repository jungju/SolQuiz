extends Node2D

var quiztype_callable = Callable(self, "_on_quiztype_button_pressed")
var age_callable = Callable(self, "_on_age_button_pressed")

var age_value: String
var quiztype_value: String

var binded_config: bool # Config 값 설정시에는 change_option이 안되도록

func _ready():
	$reset_info_label.text = "스티커를 초기화 합니다."

	for b in $quiztype_buttons.get_children():
		b.connect("pressed", quiztype_callable.bindv([b.text]))

	for b in $age_buttons.get_children():
		b.connect("pressed", age_callable.bindv([b.text]))
	
	change_quiztype_age_option(Global.config.get_value("game", "quiztype", "랜덤"), "quiztype")
	change_quiztype_age_option(Global.config.get_value("game", "age", "3~5세"), "age")
	$toggle_button.state = Global.config.get_value("system", "mute", false)
	binded_config = true

func _on_quiztype_button_pressed(value: String):
	change_quiztype_age_option(value,"quiztype")

func _on_age_button_pressed(value: String):
	change_quiztype_age_option(value,"age")

func change_quiztype_age_option(value: String, option_type: String):
	if option_type == "quiztype":
		quiztype_value = value
		for b in $quiztype_buttons.get_children():
			b.button_pressed = b.text == value
	elif option_type == "age":
		age_value = value
		for b in $age_buttons.get_children():
			b.button_pressed = b.text == value

	change_option()

func _on_close_button_pressed():
	SceneTransition.change_scene(Global.MAIN_SCENE_PATH)

func change_option():
	if binded_config:
		Global.save_config(quiztype_value, age_value)

func _on_reset_button_pressed():
	if $reset_button.text == "네!":
		Global.save_reset_award_config()
		$reset_info_label.text = "스티커를 초기화 합니다."
		$reset_button.text = "리셋"
		return
	$reset_info_label.text = "정말 초기화 할까요?"
	$reset_button.text = "네!"
