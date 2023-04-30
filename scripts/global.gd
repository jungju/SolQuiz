extends Node

const MAIN_SCENE_PATH = "res://scenes/main_page.tscn"
const GAME_SCENE_PATH = "res://scenes/game.tscn"
const OPTION_SCENE_PATH = "res://scenes/option.tscn"

var answer_board_incorrect_answer = load("res://assets/images/game_answer_board4.png")
var answer_board_correct_answer = load("res://assets/images/game_answer_board5.png")

# Game
var game_count_correct: int # 퀴즈 맞은 수 
var game_count_incorrect: int # 퀴즈 틀린 수
var current_quiz_index: int # 현재 문제 Index
var quizs_size: int # 전체 퀴즈 수
var quizs: Dictionary # 퀴즈 데이터

# signal next_quetion 필요 없을 수도
signal check_quetion(is_correct: bool) #정답 결과 시그널. 

var current_page = "main"

func choice_answer(answer_number: int):
	print(answer_number)

	# TODO: 맞았는지 틀렸는지 처리

	# 다음 문제로 넘기기

	return true

func get_next_quiz():
	current_quiz_index = current_quiz_index + 1
	if current_quiz_index > quizs_size:
		return null
	return quizs["datas"][current_quiz_index-1]

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
	quizs = load_data("res://quiz_data.json")
	quizs_size = quizs["datas"].size()

func exit_game():
	get_tree().quit()

func set_mute_audio(is_muted: bool):
	for i in range(AudioServer.get_bus_count()):
		AudioServer.set_bus_mute(i, is_muted)