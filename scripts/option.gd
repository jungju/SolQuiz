extends Node2D

var quiztype_callable = Callable(self, "_on_quiztype_button_pressed")
var age_callable = Callable(self, "_on_age_button_pressed")

var age_value: String
var quiztype_value: String

var binded_config: bool # Config 값 설정시에는 change_option이 안되도록

func _ready():
	for b in $quiztype_buttons.get_children():
		#b.keep_pressed_outside = true
		b.connect("pressed", quiztype_callable.bindv([b.text]))

	for b in $age_buttons.get_children():
		#b.keep_pressed_outside = true
		b.connect("pressed", age_callable.bindv([b.text]))
	
	_on_quiztype_button_pressed(Global.config.get_value("game", "quiztype", "랜덤"))
	_on_age_button_pressed(Global.config.get_value("game", "age", "3~5세"))
	$toggle_button.state = Global.config.get_value("system", "mute", false)
	binded_config = true

func _on_quiztype_button_pressed(value: String):
	# 변경
	quiztype_value = value
	for b in $quiztype_buttons.get_children():
		b.button_pressed = b.text == value
		
	change_option()

func _on_age_button_pressed(value: String):
	# 변경
	age_value = value
	for b in $age_buttons.get_children():
		b.button_pressed = b.text == value

	change_option()

func _on_close_button_pressed():
	SceneTransition.change_scene(Global.MAIN_SCENE_PATH)

func change_option():
	if binded_config:
		Global.save_config(quiztype_value, age_value)