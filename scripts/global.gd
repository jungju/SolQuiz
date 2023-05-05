extends Node

const MAIN_SCENE_PATH = "res://scenes/main_page.tscn"
const GAME_SCENE_PATH = "res://scenes/game_page.tscn"
const OPTION_SCENE_PATH = "res://scenes/option_page.tscn"
const RESULT_SCENE_PATH = "res://scenes/result_page.tscn"

const CONFIG_FILE_PATH = "user://config.cfg"
const RESULTS_FILE_PATH = "user://game_results.log"

var answer_board_incorrect_answer = load("res://assets/images/game_answer_board4.png")
var answer_board_correct_answer = load("res://assets/images/game_answer_board5.png")

# Game
var game_count_correct: int # 퀴즈 맞은 수 
var game_count_incorrect: int # 퀴즈 틀린 수
var current_quiz_index: int # 현재 문제 Index
var quizs_data: Array # 퀴즈 데이터
var start_time: int
var end_time: int

# Option
var config = ConfigFile.new()
var mute_audio: bool

# signal next_quetion 필요 없을 수도
signal check_quetion(is_correct: bool) #정답 결과 시그널. 

func init_app():
	Global.load_config()

func choice_answer(answer_number: int) -> bool:
	var chioce_answer_text = quizs_data[current_quiz_index-1]["options"][answer_number-1]
	var answer = quizs_data[current_quiz_index-1]["answer"]
	if chioce_answer_text == answer:
		game_count_correct = game_count_correct + 1
		return true
	else:
		game_count_incorrect = game_count_incorrect + 1
		return false

func get_next_quiz() -> Dictionary:
	if current_quiz_index == 0: 
		start_time = Time.get_ticks_msec() # 게임 시작	

	if current_quiz_index >= quizs_data.size():
		end_time = Time.get_ticks_msec() # 게임 종료
		save_game_result(str(start_time)+","+str(end_time)+","+str(game_count_correct)+","+str(game_count_incorrect))
		return {}

	current_quiz_index = current_quiz_index + 1
	return quizs_data[current_quiz_index-1]

func load_data(filePath: String): 
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("Error reading file")
	else:
		print("File doesn't exist!")

func init_game():
	var all_quizs = load_data("res://quiz_data.json")
	
	# TODO: 20개 문제 랜덤으로 가져오기
	quizs_data = get_random_dictionaries(all_quizs["datas"], 20)

	start_time = 0
	end_time = 0
	game_count_correct = 0
	game_count_incorrect = 0
	current_quiz_index = 0

func load_config():
	var err = config.load(CONFIG_FILE_PATH)
	if err != OK:
		return
	
func save_config(change_quiztype: String, change_age: String):
	config.set_value("game","quiztype", change_quiztype)
	config.set_value("game", "age", change_age)
	config.save(CONFIG_FILE_PATH)

func save_up_award_count_config():
	var award_count = Global.config.get_value("game", "award", 0)
	config.set_value("game", "award", award_count+1)
	config.save(CONFIG_FILE_PATH)

func save_reset_award_config():
	config.set_value("game", "award", 0)
	config.save(CONFIG_FILE_PATH)

func exit_game():
	print("game_count_correct", game_count_correct)
	print("game_count_incorrect", game_count_incorrect)
	get_tree().quit()

func set_mute_audio(is_muted: bool):
	mute_audio = is_muted
	for i in range(AudioServer.get_bus_count()):
		AudioServer.set_bus_mute(i, mute_audio)

	config.set_value("system", "mute", mute_audio)
	config.save(CONFIG_FILE_PATH)

func get_random_dictionaries(dict_array: Array, count: int) -> Array:
	var result = []
	
	if count >= dict_array.size():
		# 전체 배열을 반환합니다.
		return dict_array.duplicate()
	
	# 무작위로 선택된 인덱스 목록을 채웁니다.
	for _i in range(count):
		# dict_array에서 무작위 인덱스를 선택합니다.
		var random_index = randi() % dict_array.size()
		
		# 무작위로 선택된 Dictionary를 결과 배열에 추가합니다.
		result.append(dict_array[random_index])
		
		# 선택된 Dictionary를 dict_array에서 제거하여 중복 선택을 방지합니다.
		dict_array.erase(random_index)
	
	return result

# 게임 결과를 로그 파일에 저장하는 함수를 정의합니다.
func save_game_result(result: String):
	var file := FileAccess.open(RESULTS_FILE_PATH, FileAccess.READ_WRITE)
	file.seek_end()
	file.store_string(result)
	file.store_string("\n")
	file.close()
