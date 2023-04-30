extends TextureButton

@export var state: bool: 
	set(value):
		flip_h = value
		$off_icon.visible = flip_h
		$on_icon.visible = !flip_h
	get: return flip_h

func _on_pressed(): state=!flip_h
