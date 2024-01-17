extends Control


var health: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	health = $healthbar

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass

#Set how large the health bar should be. Note: There is a limit to how small the
#the progress bar can be.
func health_bar_dimensions(bar_width: int, bar_height: int):
	health.set_custom_minimum_size(Vector2(bar_width, bar_height))
	set_custom_minimum_size(Vector2(bar_width, bar_height))

#Initialize the health bar parameters.
func init_health_bar(min_health: int, max_health: int, health_value: int):
	health.min_value = min_health
	health.max_value = max_health
	health.value = health_value

#Heals the player for a certain amount.
func regen_health(regen_amount: int):
	health.value += regen_amount

#Deals damage to the player.
func damage(damage_dealt: int):
	health.value -= damage_dealt

#Set the background color of the progress bar.
func set_background_color(red: float, green: float, blue: float, alpha: float = 1.0):
	var sbl = StyleBoxFlat.new()
	health.add_theme_stylebox_override("fill", sbl)
	sbl.bg_color = Color(red, green, blue, alpha)

#Display the percentage of the health bar.	
func show_percentage(visibility: bool):
	health.set_show_percentage(visibility)
