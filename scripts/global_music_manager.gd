extends Node2D

func play_music():
	if !$background_music.playing:
		$background_music.play()

func play_select_sound():
	$select_sound.play()

func play_question_sound():
	$question_sound.play()
	
func play_correct_sound():
	$correct_sound.play()

func play_incorrect_sound():
	$incorrect_sound.play()
