extends CharacterBody2D

#Change these values to change the movement behaviour.
@export var max_walk_speed: float = 400.0
@export var walk_acceleration: float = 1000.0
@export var ground_friction: float = 700.0

#Change these values to change the jump curve.
@export var jump_height: float = 100.0
@export var jump_time_peak: float = 0.5
@export var jump_time_descent: float = 0.4

#The jump velocity must be negtive in order to jump.
@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_peak * jump_time_peak)) * -1.0
#The gravity must be negative to be applied to objects.
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_descent * jump_time_descent)) * -1.0
@onready var axis = Vector2.ZERO

var jumps = 0
#Pre defined physiscs function gets called every cycle.
func _physics_process(delta):
	axis = get_input()
	velocity.y += fall() * delta
	if axis:
		jump()
		walk(walk_acceleration * axis.x * delta)
	else:
		friction(ground_friction * delta)
	move_and_slide()

#Handle the axis from the player 
func get_input():
	#If x is postive the player moves to the right, if x is negative the player moves to the left.
	axis.x = int(Input.is_action_pressed("player_right")) - int(Input.is_action_pressed("player_left"))
	#Check if the player preseed the space bar for jumping, the player will move up.
	axis.y = int(Input.is_action_pressed("player_jump"))
	return axis.normalized()

#The amount of friction the player has while moving on the ground.
func friction(frictionAmount):
	if velocity.length() > frictionAmount:
		velocity -= velocity.normalized() * frictionAmount
	else:
		velocity = Vector2.ZERO

#Here the speed of the player and a more natural feeling of accelerating the before reaching max speed.
func walk(acceleration):
	velocity.x += acceleration
	velocity = velocity.limit_length(max_walk_speed)

#Let's the player do a jump.
func jump():
	if axis.y and is_on_floor():
		velocity.y = jump_velocity
#TODO: The player can only jump if they are on the floor. if the player obtains das boots then a double jump is possible.

#Applies the gravity to player depending on the current velocity.
func fall():
	return jump_gravity if velocity.y < 0.0 else fall_gravity

