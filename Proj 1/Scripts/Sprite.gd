extends Sprite

var direction = false
var start_position = 0
var lifespan = 150

func init(d, ls = 150):
	direction = d
	lifespan = ls
	
func _ready():
	scale = Vector2(1, 1)

func _physics_process(delta):
		if start_position == 0:
			start_position = position.x
	
		if direction:
			if position.x > start_position + lifespan:
				queue_free()
			else:
				position.x += 4
				$AnimationPlayer.play('Blaster')
		
		else:
			if position.x < start_position - lifespan:
				queue_free()
				
			else:
				position.x -= 4
				$AnimationPlayer.play('Blaster')

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
