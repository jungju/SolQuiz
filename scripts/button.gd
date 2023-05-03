@tool
extends TextureButton

@export var text: String = "Text"

# func _on_pressed(): 
# 	state=!flip_h
# 	Global.set_mute_audio(state)
	
func _process(_delta):
	$Label.text = text