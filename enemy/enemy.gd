extends CharacterBody2D


const SPEED = 30.0
const JUMP_VELOCITY = -400.0

var follow_player = false
var player = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Apply the gravity.
	apply_gravity(delta)
	# Chase the player if in vicinity.
	chase()

	move_and_slide()

func flip_animation(playerPosition: float):
	if playerPosition < 0:
		pass #Flip the animation to the left.
	else:
		pass #Flip the animation to the right.

func chase():
	if follow_player:
		position += (player.position - position) / SPEED
		#To play the animation add it here.
	else:
		pass #Play an idle animation or something similar.

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func _on_detection_area_body_exited(body:Node2D):
	player = null
	follow_player = false

func _on_detection_area_body_entered(body:Node2D):
	player = body
	follow_player = true
