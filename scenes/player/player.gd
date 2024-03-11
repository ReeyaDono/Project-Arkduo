## Using template from 
## https://github.com/EladKarni/godot4-2d-platformer-template/blob/main/Scenes/Player/player.gd
extends CharacterBody2D

@onready var coyote_timer = $CoyoteTimer
@onready var jump_buffer_timer = $JumpBufferTimer
@onready var wall_jump_buffer_timer = $WallJumpBufferTimer

@export_group("Movement")
## Maximum speed reachable by player
@export_range(0, 500) var max_speed := 400.0
## Minimum speed when variable_min_speed is set to true & min_speed isn't 0
@export_range(0, 500) var min_speed := 0.0
## Acceleration while on the ground (how quickly the player reaches max speed)
@export_range(0, 500) var acceleration := 200.0
## Friction while on group (how quickly the player slows down)
@export_range(0, 50) var friction := 25.0
## Acceleration while in the air (how quickly the player reaches max speed)
@export_range(0, 500) var air_acceleration := 150.0
## Air friction while in the air (how quickly the player slows down)
@export_range(0, 50) var air_resistance := 25.0
## Sets a variable max speed depending on how far the joystick is pushed
@export var is_variable_max_speed := false
## sets a minimum speed based on min_speed
@export var is_variable_min_speed := false

@export_group("Jump Assist")
## Max amount of time allowed after leaving the ground while still being able to jump
@export_range(0, 1) var coyote_timer_value = 0.1
## Max amount of time the game holds on to the players input to accecute when avaiable
@export_range(0, 1) var jump_buffer_timer_value = 0.15
## Max amount of time allowed after leaving the wall while still being able to wall jump
@export_range(0, 1) var wall_jump_buffer_timer_value = 0.2

@export_group("Jump")
## Max jump height
@export var jump_height := 200
## Amount of time it takes the player to reach the peak of their jump
@export var jump_time_to_peak := 0.5
## Amount of time it takes the player to fall from the peak of their jump to the ground
@export var jump_time_to_descent := 0.4
## Determains if a player jump highet changes depending on how long they held it in
@export var variable_jump_height := true
## Determains the minumum jump heighet a player can reach if they barely tap the jump button (and variable_jump_height is true)
@export var minimum_jump_height := 100

@export_group("Wall Jump")
## Horizontal Force
@export var horizontal_force := 800.0
## Gravity Reduction Ratio
@export var gravity_reduction := 0.2

@onready var jump_velocity : float = (2.0 * jump_height) / jump_time_to_peak * -1
@onready var jump_gravity : float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak) * -1
@onready var fall_gravity : float = (-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent) * -1

func _ready():
	coyote_timer.wait_time = coyote_timer_value
	jump_buffer_timer.wait_time = jump_buffer_timer_value
	wall_jump_buffer_timer.wait_time = wall_jump_buffer_timer_value

# Sets the gravity depending on the context
func _get_gravity(_velocity):
	if is_on_wall() and (Input.is_action_pressed("Move_Left") or Input.is_action_pressed("Move_Right")):
		return jump_gravity if _velocity.y < 0.0 else (fall_gravity * gravity_reduction)
	else:
		return jump_gravity if _velocity.y < 0.0 else fall_gravity
	
# Calculates the players movement depending on the context
func _get_movement(fric: float, accel: float, delta: float):
	var direction = Input.get_axis("Move_Left", "Move_Right")

	if direction:
		velocity.x += sign(direction) * accel * delta * 100
	
	if !direction or sign(direction) != sign(velocity.x):
		velocity.x = move_toward(velocity.x, 0, fric * delta * 100)
	
	if is_variable_max_speed:
		velocity.x = clamp(velocity.x, -max_speed * abs(direction), max_speed * abs(direction))
	else:
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
	if is_variable_min_speed and min_speed > 0:
			velocity.x = maxf(abs(velocity.x), abs(min_speed * sign(direction))) * sign(direction)
			
# Flips the player sprite depending on their movemnt direction
func _set_sprite_direction(direction: int) -> void:
	if direction > 0.0:
		$AnimatedSprite2D.flip_h = false

	if direction < 0.0:
		$AnimatedSprite2D.flip_h = true
		
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += _get_gravity(velocity) * delta
		wall_jump()
		_get_movement(air_resistance, air_acceleration, delta)
	else:
		if coyote_timer.is_stopped():
			coyote_timer.start()
		if jump_buffer_timer.time_left > 0.0:
			jump_buffer_timer.stop()
			jump()
		_get_movement(friction, acceleration, delta)
	
	_set_sprite_direction(sign(velocity.x))
	
	if Input.is_action_just_pressed("Jump"):
		jump()
	
	if Input.is_action_just_released("Jump"):
		jump_cut()
	
	if velocity != Vector2.ZERO:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
	
	move_and_slide()
	
# Adds the player's jump velocity if able
func jump():
	if coyote_timer.time_left > 0.0:
		coyote_timer.stop()
		velocity.y = jump_velocity
	
	if _get_gravity(velocity) == fall_gravity:
		jump_buffer_timer.start()


# Stops jump acceleration if variable_jump_height is enabled
func jump_cut():
	if not variable_jump_height:
		return
	
	if velocity.y < minimum_jump_height * up_direction.y:
		velocity.y = 0

func wall_jump():
	var direction = Input.get_axis("Move_Left", "Move_Right")
	if direction and is_on_wall() and wall_jump_buffer_timer.is_stopped():
		wall_jump_buffer_timer.start()
	if Input.is_action_just_pressed("Jump") and (wall_jump_buffer_timer.time_left > 0.0):
		wall_jump_buffer_timer.stop()
		velocity.x = sign(velocity.x) * horizontal_force * -1
		velocity.y = jump_velocity
		print("Velocity x wall jump: " + str(velocity.x))
