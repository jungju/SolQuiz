extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# 로딩 화면에 필요한 초기화를 수행합니다.
	# 예를 들어, 애니메이션을 시작하거나 프로그레스 바를 설정할 수 있습니다.
	
	# 로딩이 완료된 후 다음 씬으로 이동하는 타이머를 설정합니다.
	# 여기서는 2초 후에 다음 씬으로 이동하도록 설정하겠습니다.
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.timeout.connect(_on_loading_complete)
	add_child(timer)
	timer.start()

func _on_loading_complete():
	# 다음 씬으로 이동합니다.
	#get_tree().change_scene(NEXT_SCENE_PATH)
	print("!!!!")
