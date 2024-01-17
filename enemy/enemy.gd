extends CharacterBody2D


const MAX_SPEED = 25.0
const JUMP_VELOCITY = -400.0

var player = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Pre defined physiscs function gets called every cycle.
func _physics_process(delta):
	# Apply the gravity.
	apply_gravity(delta)
	# Chase the player if in vicinity.
	chase()

	move_and_slide()

func flip_animation(enemyPosition: float):
	if enemyPosition <= 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false

func chase():
	if player:
		position.x += (player.position.x - position.x) / MAX_SPEED
		flip_animation(player.position.x - position.x)
		#To play the animation add it here.
	else:
		pass #Play an idle animation or something similar.

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func _on_detection_area_body_exited(_body:Node):
	player = null

func _on_detection_area_body_entered(body:Node2D):
	player = body


func _on_enemyhitbox_body_entered(_body:Node):
	Global.change_scene("res://battlescreen.tscn")
