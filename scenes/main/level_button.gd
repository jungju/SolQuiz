extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_select_level)

func set_lock():
	disabled = true
	$Label.hide()
	$Sprite2D.show()

func _on_select_level():
	Global.emit_select_level($Label.text)