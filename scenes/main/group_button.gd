extends TextureButton

var selected_texture = load("res://assets/images/main_group_button_back_aqua.png")
var default_texture = load("res://assets/images/main_group_button_back.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_select_group)

func set_group_name(group_name):
	$Label.text = group_name

func get_group_name():
	return $Label.text

func _on_select_group():
	Global.emit_change_group($Label.text)
	
	texture_normal = selected_texture

func reset():
	texture_normal = default_texture
