extends CharacterBody2D

@export var speed: int = 80 #Speed in units per second

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
#region Input Management
	if Input.is_action_just_pressed("right"):
		velocity.x = 1
		velocity.y = 0
	elif Input.is_action_just_pressed("left"):
		velocity.x = -1
		velocity.y = 0
	elif Input.is_action_just_pressed("down"):
		velocity.y = 1
		velocity.x = 0
	elif Input.is_action_just_pressed("up"):
		velocity.y = -1
		velocity.x = 0
#endregion
	
#region Animation Management
	if velocity.x == 0 && velocity.y == 0:
		$AnimatedSprite2D.set_frame_and_progress(0, 0.85)
		$AnimatedSprite2D.pause()
	else:
		$AnimatedSprite2D.play("mouthCycle")
		$AnimatedSprite2D.flip_h = velocity.x > 0
		if velocity.y > 0:
			$AnimatedSprite2D.rotation = 1.571 #90 Degrees in Radians
		elif velocity.y < 0:
			$AnimatedSprite2D.rotation = -1.571 #-90 Degrees in Radians
		else:
			$AnimatedSprite2D.rotation = 0
#endregion
	
#region Movement Management
	velocity = velocity.normalized() * speed
	position += velocity * delta
	move_and_slide()
#endregion
