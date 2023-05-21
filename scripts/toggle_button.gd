@tool
extends TextureButton

@export var state: bool

func _on_pressed():
	GlobalMusicManager.play_select_sound()
	state=!flip_h
	Global.set_mute_audio(state)
	
func _process(_delta):
	flip_h = state
	$off_icon.visible = state
	$on_icon.visible = !state