extends Node

var total_score
var combo_score = 0
var mult = 1
var ghosts_eaten = 0;

func calculate_score():
	#Output the score and the multiplier to the UI
	
	#This is the part where we would add functionality for combos, for it to wait until all the score and mult stops getting added to calculate it all
	
	#Then, calculate it and output the combo score, before adding it to the total score
	combo_score *= mult
	print(combo_score)
	total_score += combo_score
	
	#Reset all values
	ghosts_eaten = 0;
	combo_score = 0;
	mult = 1;


func score_dot():
	combo_score += 50
	calculate_score()

func score_PP():
	combo_score += 50
	mult += 1
	calculate_score()

func score_ghost():
	ghosts_eaten += 1
	combo_score += (pow(2, ghosts_eaten) * 100)
	mult *= 2
	
	calculate_score()

func score_fruit():
	combo_score += 100
	mult *= 3
	
	calculate_score()
