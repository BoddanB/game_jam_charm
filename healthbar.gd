extends TextureProgressBar

#Initialize the health bar parameters.
func init_health_bar(min_health: int, max_health: int, health_value: int):
	min_value = min_health
	max_value = max_health
	value = health_value

#Heals the player for a certain amount.
func regen_health(regen_amount: int):
	value += regen_amount

#Deals damage to the player.
func damage(damage_dealt: int):
	value -= damage_dealt

#Set the background color of the progress bar.
func set_progress_color(texture2D):
	set_progress_texture(texture2D)


