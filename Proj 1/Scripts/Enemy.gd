extends Node2D

onready var bullet = preload("res://Scenes/Sprite.tscn")
var b

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		$Exclamation.visible = true
		if $Timer.is_stopped():
			$Timer.start()
		
	else:
		$Exclamation.visible = false
		if not $Timer.is_stopped():
			$Timer.stop()

func _on_Area2D_area_entered(area):
	if "Bullet" in area.get_parent().name:
		$AudioStreamPlayer2D.pitch_scale = rand_range(0.8, 1.2)
		$AudioStreamPlayer2D.play()
		hit(area)
		
func hit(a):
	a.get_parent().queue_free()
	$HealthBar.value -= 20
	
	if $HealthBar.value <= 0:
		Globals.enemies_defeated += 1
		queue_free()
		$AudioStreamPlayer2D2.play()

	
func shoot(dir):
	b = bullet.instance()
	b.init(dir, 800)
		
	get_parent().add_child(b)
	b.global_position = $Position2D.global_position
	
	
func _on_Timer_timeout():
	shoot(false)
