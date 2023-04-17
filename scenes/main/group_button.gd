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
	texture_normal = selected_texture
	Global.current_group = $Label.text
	Global.emit_change_group()

func reset():
	texture_normal = default_texture
