extends CharacterBody2D

@export var speed: int = 80 #Speed in units per second
@onready var wakawaka = $wakawakaplayer
@onready var intro = $introplayer

# Called when the node enters the scene tree for the first time.
func _ready():
	intro.play()
	#pass # Replace with function body.
	scale.x = -scale.x
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position,  position)
	
#region Input Management
	if Input.is_action_just_pressed("right"):
		query = PhysicsRayQueryParameters2D.create(position, Vector2(position.x +50, position.y))
		query.exclude = [self]
			
		var result = space_state.intersect_ray(query)#result of the ray cast
	
		if !result:
			velocity.x = 1
			velocity.y = 0
		if not wakawaka.playing:
			wakawaka.play()
	elif Input.is_action_just_pressed("left"):
		#cast ray 50 units infront of player 
		query = PhysicsRayQueryParameters2D.create(position, Vector2(position.x -50, position.y))
		query.exclude = [self] #ignore players collider
		
		var result = space_state.intersect_ray(query)#result of the ray cast
	
		if !result:
			velocity.x = -1
			velocity.y = 0
		

		if not wakawaka.playing:
			wakawaka.play()
	elif Input.is_action_just_pressed("down"):
		query = PhysicsRayQueryParameters2D.create(position, Vector2(position.x, position.y +50))
		query.exclude = [self]
		var result = space_state.intersect_ray(query)#result of the ray cast
	
		if !result:
			velocity.y = 1
			velocity.x = 0
		if not wakawaka.playing:
			wakawaka.play()
	elif Input.is_action_just_pressed("up"):
		
		query = PhysicsRayQueryParameters2D.create(position, Vector2(position.x, position.y -50))
		query.exclude = [self]
		var result = space_state.intersect_ray(query)#result of the ray cast
	
		if !result:
			velocity.y = -1
			velocity.x = 0
		if not wakawaka.playing:
			wakawaka.play()
#endregion

	
	var result = space_state.intersect_ray(query)
	
	if result:
		print("Hit at point: ", result.position)
		print("Player point:", position)
	
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
