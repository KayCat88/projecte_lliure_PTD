extends enemy

var damage = 3
@onready var hitbox = $rotator/Hitbox
var attack_cooldown = 2

func _ready():
	get_player_info_at_spawn()


func _physics_process(delta):
	
	# Add the gravity.
	set_behavior()
	if attack_cooldown >= 0:
		attack_cooldown -= delta
	
	move_and_slide()
	if can_attack == true and attack_cooldown <= 0:
		attack()
	else:
		hitbox.collider.disabled = true

func attack():
	hitbox.collider.disabled = false
	attack_cooldown = 2
	print(hitbox.damage)
