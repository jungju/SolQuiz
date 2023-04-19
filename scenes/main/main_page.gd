extends Node2D

const PAGE_NAME = "main"

@onready var group_button = preload("res://scenes/main/group_button.tscn")
@onready var level_button = preload("res://scenes/main/level_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():	
	var group_array = ["가족", "여행", "수학", "국어", "사회"]
	for group_name in group_array:
		var new_group_button = group_button.instantiate()
		new_group_button.set_group_name(group_name)
		$GameMenu/GroupBox.add_child(new_group_button)
	
	for i in range(10):
		var new_level_button = level_button.instantiate()
		new_level_button.get_node("Label").text = str(i+1)
		$GameMenu/LevelBoard/LevelBox.add_child(new_level_button)
	
	Global.change_group.connect(_on_action_select_group)
	Global.select_level.connect(_on_action_select_level)
	
func _on_action_select_group():
	for child in $GameMenu/GroupBox.get_children():
		if Global.current_group != child.get_group_name():
			child.reset()

	$GameMenu/LevelBoard/LevelLabel.text = Global.current_group
	
	print(Global.current_group)
	
	# var tween = create_tween()
	# tween.set_trans(Tween.TRANS_LINEAR)
	# tween.set_ease(Tween.EASE_IN_OUT)
	# tween.tween_property($LevelBoard, "scale",  Vector2(1.01, 1.01), 0.05)
	# tween.tween_property($LevelBoard, "scale",  Vector2(1, 1), 0.1)

	var level = 1
	var index = 1
	for child in $GameMenu/LevelBoard/LevelBox.get_children():
		if index > level:
			child.set_lock()
		index = index+1

func _on_action_select_level():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($GameMenu, "modulate", Color(1, 1, 1, 0), 0.5)
	SceneTransition.change_scene(Global.GAME_SCENE_PATH)
