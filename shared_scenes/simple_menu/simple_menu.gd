extends Control
var is_menu_actived = false
var is_muted = false
var textureAudioOff = load("res://shared_scenes/simple_menu/images/audioOff.png")
var textureAudioOn = load("res://shared_scenes/simple_menu/images/audioOn.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuButton.button_down.connect(_on_MenuButton_pressed)
	$Menus.focus_exited.connect(_on_MenuButton_focus_exited)
	$Menus/ExitButton.pressed.connect(_on_Exit_pressed)
	$Menus/MuteButton.pressed.connect(_on_MuteButton_pressed)
	
	$Menus/MuteButton/TextureRect.texture = self.textureAudioOn
	
	action_set_menus(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_MenuButton_focus_exited():
	action_set_menus(false)
		
func _on_MenuButton_pressed():
	action_toggle_menus()
	
func _on_Exit_pressed():
	action_exit()

func _on_MuteButton_pressed():
	action_toggle_mute()

func action_exit():
	get_tree().quit()
	
func action_toggle_menus():
	if is_menu_actived:
		action_set_menus(false)
	else:
		action_set_menus(true)

func action_toggle_mute():
	is_muted = !is_muted
	for i in range(AudioServer.get_bus_count()):
		AudioServer.set_bus_mute(i, is_muted)
	
	if is_muted:
		$Menus/MuteButton/TextureRect.texture = self.textureAudioOff
	else:
		$Menus/MuteButton/TextureRect.texture = self.textureAudioOn
	
func action_set_menus(visible):
	var alpha = 0.0
	is_menu_actived = false
	
	if visible:
		is_menu_actived = true
		alpha = 1.0
		
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property($Menus, "modulate", Color(1, 1, 1, alpha), 1)
