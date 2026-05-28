@tool
extends TextureButton

enum ButtonType {Normal, Wide, Small}

@export var text: String = "Text"
@export var button_type: ButtonType = ButtonType.Normal

var resource_texture_normal = load("res://assets/images/normal_button.png")
var resource_texture_aqua_normal = load("res://assets/images/aqua_button.png")
var resource_texture_wide_normal = load("res://assets/images/normal_wide_button.png")
var resource_texture_aqua_wide_normal = load("res://assets/images/aqua_wide_button.png")
var resource_texture_mini_normal = load("res://assets/images/normal_mini_button.png")
var resource_texture_aqua_mini_normal = load("res://assets/images/aqua_mini_button.png")

func _process(_delta):
	$Label.text = text
	$Label.size = Vector2(size.x,size.y-10)
	if button_type == ButtonType.Normal:
		texture_normal = resource_texture_normal
		texture_pressed = resource_texture_aqua_normal
	elif button_type == ButtonType.Wide:
		texture_normal = resource_texture_wide_normal
		texture_pressed = resource_texture_aqua_wide_normal
	elif button_type == ButtonType.Small:
		texture_normal = resource_texture_mini_normal
		texture_pressed = resource_texture_aqua_mini_normal

func _on_pressed(_pressed_arg = null) -> void:
	GlobalMusicManager.play_select_sound()
