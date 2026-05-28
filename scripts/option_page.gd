extends Node2D

var input_age_value: String
var input_quiztype_value: String
var input_lang_value: String

var category_all_button

var loaded_status: bool # Config 값 설정시에는 change_option이 안되도록

func _ready():
	$sticker_option/Label.text = "스티커 초기화"

	for b in $category_option/quiztype_buttons.get_children():
		b.connect("pressed", Callable(self, "_on_quiztype_button_pressed").bindv([b.text]))
		if b.text == "전부":
			category_all_button = b
		
	for b in $age_option/age_buttons.get_children():
		b.connect("pressed",  Callable(self, "_on_age_button_pressed").bindv([b.text]))
	
	for b in $lang_option/lang_buttons.get_children():
		b.connect("pressed", Callable(self, "_on_lang_button_pressed").bindv([b.text]))
	
	input_quiztype_value = Global.config.get_value("game", "quiztype", "전부")
	input_age_value = Global.config.get_value("game", "age", "전부")
	input_lang_value = Global.config.get_value("game", "lang", "한국어")

	render_buttons($category_option/quiztype_buttons.get_children(), input_quiztype_value)
	render_buttons($age_option/age_buttons.get_children(), input_age_value)
	render_buttons($lang_option/lang_buttons.get_children(), input_lang_value)

	loaded_status = true

func render_buttons(children, values):
	for b in children:
		b.button_pressed = values.find(b.text) != -1
		
func _on_quiztype_button_pressed(value: String):
	if value == "전부":
		render_buttons($category_option/quiztype_buttons.get_children(), value)
	else: 
		category_all_button.button_pressed = false
	change_option()

func _on_age_button_pressed(value: String):
	render_buttons($age_option/age_buttons.get_children(), value)
	change_option()

func _on_lang_button_pressed(value: String):
	render_buttons($lang_option/lang_buttons.get_children(), value)
	change_option()

func change_option():
	if !loaded_status:
		return
	
	input_quiztype_value = ""
	input_age_value = ""
	input_lang_value = ""
	
	for b in $category_option/quiztype_buttons.get_children():
		if b.button_pressed:
			input_quiztype_value = input_quiztype_value + "," + b.text

	for b in $age_option/age_buttons.get_children():
		if b.button_pressed:
			input_age_value = b.text
			break

	for b in $lang_option/lang_buttons.get_children():
		if b.button_pressed:
			input_lang_value = b.text
			break

	Global.save_config(input_quiztype_value, input_age_value, input_lang_value)

func _on_reset_button_pressed(_pressed_arg = null) -> void:
	if $sticker_option/reset_button.text == "네!":
		Global.save_reset_award_config()
		$sticker_option/Label.text = "스티커 초기화"
		$sticker_option/reset_button.text = "리셋"
		return
	$sticker_option/Label.text = "초기화 할까요?"
	$sticker_option/reset_button.text = "네!"

func _on_close_button_pressed(_pressed_arg = null) -> void:
	SceneTransition.change_scene(Global.MAIN_SCENE_PATH)
