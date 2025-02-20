extends CharacterBody2D

@export var speed: int = 80

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2.ZERO # The player's movement vector.
	
#region Input Management
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
#endregion
	
#region Animation Management
	if velocity.x == 0 && velocity.y == 0:
		$AnimatedSprite2D.pause()
	else:
		$AnimatedSprite2D.play("mouthCycle")
		$AnimatedSprite2D.flip_h = velocity.x > 0
		$AnimatedSprite2D.flip_v = velocity.y > 0
#endregion
	
#region Movement Management
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	move_and_slide()
#endregion
