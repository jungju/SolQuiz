extends TextureButton

func _ready():
	button_pressed = Global.config.get_value("system", "mute", false)
	
func _process(_delta):
	flip_h = button_pressed
	$off_icon.visible = button_pressed
	$on_icon.visible = !button_pressed

# button_pressed는 이미 있는 변수라 Warn 발생. 하지만 사용가능
# 매개변수 없으면 동작안함. 버그
func _on_toggled(button_pressed:bool):
	GlobalMusicManager.play_select_sound()
	Global.set_mute_audio(button_pressed)
