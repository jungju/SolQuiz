extends TextureButton

func _ready():
	button_pressed = Global.config.get_value("system", "mute", false)
	
func _process(_delta):
	flip_h = button_pressed
	$off_icon.visible = button_pressed
	$on_icon.visible = !button_pressed

func _on_toggled(button_pressed:bool):
	GlobalMusicManager.play_select_sound()
	Global.set_mute_audio(button_pressed)
