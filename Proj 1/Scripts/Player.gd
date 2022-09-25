extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 100
const JUMPFORCE = 300
const ACCEL = 5

var motion = Vector2()
var facing_right = true


func _ready():
	pass
	
onready var bullet = preload("res://Scenes/Bullet.tscn")
var b
	
func _physics_process(delta):
	
	shoot(facing_right)
	
	motion.y += GRAVITY
	
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	if facing_right == true:
		$Sprite.scale.x = 1
		
	else:
		$Sprite.scale.x = -1
		
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed('right'):
		if is_on_floor():
			if $Timer.time_left <=0:
				$AudioStreamPlayer2D.pitch_scale = rand_range(0.8, 1.2)
				$AudioStreamPlayer2D.play()
				$Timer.start(0.25)
			
		motion.x += ACCEL
		facing_right = true
		$AnimationPlayer.play("Walk")
		$Position2D.position.x = 6
		
	elif Input.is_action_pressed('left'):
		if is_on_floor():
			if $Timer.time_left <=0:
				$AudioStreamPlayer2D.pitch_scale = rand_range(0.8, 1.2)
				$AudioStreamPlayer2D.play()
				$Timer.start(0.25)
				
		motion.x -= ACCEL
		facing_right = false
		$AnimationPlayer.play("Walk")
		$Position2D.position.x = -8
		
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		$AnimationPlayer.play("Idle")
	
	if is_on_floor():
		if Input.is_action_pressed('jump'):
			$AudioStreamPlayer.play()
			motion.y = -JUMPFORCE
		
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play('Jump')
			
		elif motion.y > 0:
			$AnimationPlayer.play('Fall')
			
	motion = move_and_slide(motion, UP)
	
func shoot(dir):
	if Input.is_action_just_pressed('shoot'):
		if $Timer2.time_left <=0:
				$AudioStreamPlayer2D2.pitch_scale = rand_range(0.8, 1.2)
				$AudioStreamPlayer2D2.play()
				$Timer2.start(0.1)
		b = bullet.instance()
		b.init(dir)
		
		get_parent().add_child(b)
		b.global_position = $Position2D.global_position
		
##func hit():

##	$HealthBar.value -= 20
	
##	if $HealthBar.value <= 0:
##		Globals.restart_game()
##		$AudioStreamPlayer2D2.play()
		
		
		
	
