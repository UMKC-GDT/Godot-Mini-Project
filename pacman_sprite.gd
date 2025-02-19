extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event.is_action_pressed("space_bar"):
		scale.y = -4
		if(skew<10):
			skew = 10
		elif(skew > -10):
			skew = -10
