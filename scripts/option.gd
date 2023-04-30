extends Node2D

func _ready():
	var kind_callable = Callable(self, "_on_kind_button_pressed")
	
	#$quiztype_buttons/TextureButton2.pressed.connect(tt)
	$quiztype_buttons/TextureButton2.connect("pressed",
	kind_callable.bindv([$quiztype_buttons/quiztype_buttons/TextureButton2/Label.text]))

func _on_kind_button_pressed(extra_arg_0):
	print(extra_arg_0)
	pass # Replace with function body.
	
