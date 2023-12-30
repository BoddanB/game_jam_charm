extends CharacterBody2D

#Change these values to change the movement behaviour.
var max_walk_speed: float = 50.0
var walk_acceleration: float = 100.0
var ground_friction: float = 200.0

#Change these values to change the jump curve.
var jump_height: float = 2.0
var jump_time_peak: float = 0.8
var jump_time_descent: float = 0.4

#The jump velocity must be negtive in order to jump.
@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_peak * jump_time_peak)) * -1.0
#The gravity must be negative to be applied to objects.
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_descent * jump_time_descent)) * -1.0
@onready var axis = Vector2.ZERO

var jumps = 0

# func _ready():
# 	$AnimationPlayer.play("idle")


#Pre defined physiscs function gets called every cycle.
func _physics_process(delta):
	axis = get_input()
	velocity.y += apply_gravity() * delta

	if axis:
		walk(delta)
		jump()
	else:
		friction(ground_friction * delta)
		idle()
	
	move_and_slide()

#Handle the input from the player.
func get_input():
	#If x is postive the player moves to the right, if x is negative the player moves to the left.
	axis.x = int(Input.is_action_pressed("player_right")) - int(Input.is_action_pressed("player_left"))
	#Check if the player preseed the space bar for jumping, the player will move up.
	axis.y = int(Input.is_action_pressed("player_jump"))
	return axis.normalized()

#The amount of friction the player has while moving on the ground.
func friction(frictionAmount):
	if is_on_floor_only():
		velocity = velocity.move_toward(Vector2.ZERO, frictionAmount)
		

#Accelerating the player until the max walking speed is reached.
func walk(delta):
	if is_on_floor_only():
		$AnimationPlayer.play("walk_right")
		flip_direction()
		velocity.x += walk_acceleration * axis.x * delta
		velocity = velocity.limit_length(max_walk_speed)

#Let the player do a jump.
func jump():
	if axis.y and is_on_floor():
		$AnimationPlayer.play("jump")
		velocity.y = jump_velocity
#TODO: The player can only jump if they are on the floor. if the player obtains das boots then a double jump is possible.

#Applies gravity to the jump.
func apply_gravity():
	if not is_on_floor():
		$AnimationPlayer.play("jump")
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func idle():
	if is_on_floor():
		$AnimationPlayer.play("idle")

func flip_direction():
	if axis.x >= 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
