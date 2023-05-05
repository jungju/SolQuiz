@tool
extends TextureButton

enum ButtonType {Normal, Wide, Small}

@export var text: String = "Text"
@export var button_type: ButtonType = ButtonType.Normal
	
func _process(_delta):
	$Label.text = text

	if button_type == ButtonType.Normal:
		texture_normal = load("res://assets/images/normal_button.png")
		texture_pressed = load("res://assets/images/aqua_button.png")
		$Label.size = Vector2(size.x,size.y-10)
	elif button_type == ButtonType.Wide:
		texture_normal = load("res://assets/images/normal_wide_button.png")
		texture_pressed = load("res://assets/images/aqua_wide_button.png")
		$Label.size = Vector2(size.x,size.y-10)
	elif button_type == ButtonType.Small:
		texture_normal = load("res://assets/images/normal_mini_button.png")
		texture_pressed = load("res://assets/images/aqua_mini_button.png")
		$Label.size = Vector2(size.x,size.y-10)