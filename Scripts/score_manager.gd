extends Node

@onready var combo_timer = $ComboTimer

#Note for future reference: All of the print statements in the code are meant to represent the user-facing UI. Keep em if you want for the sake of debugging, but to connect the scoring system to the UI, just do it wherever you see a print statement, and try to follow its lead.

var total_score = 0
var combo_score = 0
var mult = 1
var ghosts_eaten = 0

@export_category("Combo Settings")
@export var combo_time_length = 3.0

@export_category("Scoring Values")
@export var dot_score = 10
@export var power_pellet_score = 50
@export var power_pellet_mult = 1
@export var ghost_score_base = 2
@export var ghost_mult_multiplier = 2
@export var fruit_score = 100
@export var fruit_mult_multiplier = 3

func reset():
	total_score = 0
	combo_score = 0
	mult = 1
	ghosts_eaten = 0
	
	combo_timer.stop()


func _ready():
	combo_timer.timeout.connect(calculate_score) # This is responsible for calling the final calculate_score() once the time runs out

# update_score is a function called every time that we call one of the scoring functions down below, and handles outputting it to the UI side and starting the combo timer.
func update_score():
	#Update the current combo_score and multiplier to the UI. Replace these lines with whatever UI work you need.
	print("Current score: " + str(combo_score) + " x " + str(mult))
	
	#Starts the combo timer. If three seconds pass without the player scoring anything at all, then it'll end the combo and score it all.
	combo_timer.start(combo_time_length)

#This one's called by the combo timer once the player's combo runs out after three seconds 
func calculate_score():
	#Then, calculate it and output the combo score, before adding it to the total score
	combo_score *= mult
	print("Final combo: " + str(combo_score))
	total_score += combo_score
	
	#Update the total score of the game
	print("Total score: " + str(total_score))
	
	#Reset all values, and output their reset versions for the combo score and mult
	ghosts_eaten = 0;
	combo_score = 0;
	mult = 1;
	
	print("Current score: " + str(combo_score) + " x " + str(mult))
	combo_timer.stop()


func score_dot():
	combo_score += dot_score
	update_score()

func score_PP():
	combo_score += power_pellet_score
	mult += power_pellet_mult
	update_score()

func score_ghost():
	ghosts_eaten += 1
	print("Current ghost streak: " + str(ghosts_eaten))
	
	combo_score += (pow(ghost_score_base, ghosts_eaten) * 100)
	mult *= ghost_mult_multiplier
	
	update_score()

func score_fruit():
	combo_score += fruit_score
	mult *= fruit_mult_multiplier
	
	update_score()

# For the sake of debugging, this handles using the inputs to trigger each of the scoring functions.
func _input(event):
	if Input.is_action_just_pressed("score_dot"):
		print("Scored Dot!")
		score_dot()
	elif Input.is_action_just_pressed("score_PP"):
		print("Power pellet time!")
		score_PP()
	elif Input.is_action_just_pressed("score_ghost"):
		print("Scoring ghost!")
		score_ghost()
	elif Input.is_action_just_pressed("score_fruit"):
		print("Scored fruit!")
		score_fruit()
