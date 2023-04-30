extends Node2D

var quiztype_callable = Callable(self, "_on_quiztype_button_pressed")
var age_callable = Callable(self, "_on_age_button_pressed")

var auqa_button_texture = load("res://assets/images/aqua_button.png")
var normal_button_texture = load("res://assets/images/normal_button.png")

var auqa_wide_button_texture = load("res://assets/images/aqua_wide_button.png")
var normal_wide_button_texture = load("res://assets/images/normal_wide_button.png")

var age_value: String
var quiztype_value: String

func _ready():
	for node in $quiztype_buttons.get_children():
		var quiztype_text =node.get_node("Label").text
		node.connect("pressed", quiztype_callable.bindv([quiztype_text]))

	for node in $age_buttons.get_children():
		var age_text = node.get_node("Label").text
		node.connect("pressed", age_callable.bindv([age_text]))

func _on_quiztype_button_pressed(value):
	if quiztype_value == value: return
	
	# 변경
	quiztype_value = value
	for b in $quiztype_buttons.get_children():
		if b.get_node("Label").text != value: b.texture_normal = normal_button_texture
		else: b.texture_normal = auqa_button_texture
	
	save_quiztype_and_age()

func _on_age_button_pressed(value):
	if age_value == value: return
	
	# 변경
	age_value = value
	for b in $age_buttons.get_children():
		if b.get_node("Label").text != value: b.texture_normal = normal_wide_button_texture
		else: b.texture_normal = auqa_wide_button_texture
	
	save_quiztype_and_age()
	
func save_quiztype_and_age():
	pass

func _on_close_button_pressed():
	SceneTransition.change_scene(Global.MAIN_SCENE_PATH)
