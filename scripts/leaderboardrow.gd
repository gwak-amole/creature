extends HBoxContainer

func set_row(username: String, score: int):
	$"Name Label".text = username
	$Score.text = str(score)
