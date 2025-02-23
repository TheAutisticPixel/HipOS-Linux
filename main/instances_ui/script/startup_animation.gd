extends Node2D

onready var right_motions = $right.get_children()
onready var right_pos = []
var r_count = 0

onready var left_motion = $left.get_children()
onready var left_pos = []
var l_count = 0

onready var rand_motion = $rand.get_children()
onready var rand_pos = []
var ra_count = -2

onready var label = $label.duplicate()

var boot_texts = [
	"Now booting...",
	"Initializing core subsystems...",
	"Loading kernel...",
	"Scanning storage drives...",
	"Verifying system integrity...",
	"Decrypting user data...",
	"Checking security protocols...",
	"Calibrating processing units...",
	"Loading system registry...",
	"Optimizing memory usage...",
	"Retrieving last session data...",
	"Verifying connected peripherals...",
	"Running startup diagnostics...",
	"Configuring user environment...",
	"Rendering desktop interface...",
	"Finalizing boot sequence...",
	"All systems operational...",
	"WELCOME, USER.",
	"Powering up neural cores...",
	"Scanning for threats...",
	"Synchronizing internal clock...",
	"Establishing network connection...",
	"Allocating virtual memory...",
	"Parsing configuration files...",
	"Defragmenting startup cache...",
	"Executing startup scripts...",
	"Mounting file systems...",
	"Analyzing system logs...",
	"Updating environment variables...",
	"Cleaning temporary directories...",
	"Compiling UI elements...",
	"Applying power efficiency modes...",
	"Activating security layers...",
	"Checking disk integrity...",
	"Injecting runtime dependencies...",
	"Validating cryptographic signatures...",
	"Processing user authentication...",
	"Indexing local files...",
	"Engaging quantum encryption...",
	"Syncing cloud backup...",
	"Testing input/output channels...",
	"Activating firewall...",
	"Performing deep memory scan...",
	"Reconstructing previous session...",
	"Calibrating visual output...",
	"Verifying BIOS checksum...",
	"Analyzing CPU thermal readings...",
	"Initializing AI-assisted modules...",
	"Scanning for unauthorized modifications...",
	"Purging obsolete data...",
	"Decrypting restricted logs...",
	"Rebooting redundant subsystems...",
	"Optimizing system response time...",
	"Synchronizing neural processing units...",
	"Deploying security countermeasures...",
	"Analyzing machine learning predictions...",
	"Aligning computational grid...",
	"Checking for software conflicts...",
	"Activating autonomous protocols...",
	"Engaging advanced heuristics...",
	"Firing up auxiliary power units...",
	"Preparing emergency rollback...",
	"Detecting user presence...",
	"Mapping system resources...",
	"Running final boot checks...",
	"System ready.",
	"Welcome back, User."
];


var infos = []
var info_count = 2
var info_index = 0

func _ready() -> void:
	for i in range(right_motions.size()):
		var p = right_motions[i]
		right_pos.append(p.rect_position)
		p.rect_position += Vector2(1,0) * 55 * rand_range(15,15)

	for i in range(left_motion.size()):
		var p = left_motion[i]
		left_pos.append(p.rect_position)
		p.rect_position += Vector2(-1,1) * 55 * rand_range(15,15)
	
	for i in range(rand_motion.size()):
		var p = rand_motion[i]
		rand_pos.append(p.rect_position)
#		p.rect_position += Vector2(floor(rand_range(-55555,55555)),floor(rand_range(-55555,55555))).normalized() * 555555
		if p.rect_size.x > p.rect_size.y:
			p.rect_position.x += rand_range(-21000,21000)
		else:
			p.rect_position.y += rand_range(-21000,21000)
			
var finished = false
var add_boost = 0

func _physics_process(delta: float) -> void:
	
	if not Input.is_action_pressed("CLICK"):
		if r_count < right_motions.size() - 1:
			r_count += 1
			
		for i in range(r_count):
			right_motions[i].rect_position = right_motions[i].rect_position.linear_interpolate(right_pos[i],delta * 10)
			right_motions[i].rect_scale = right_motions[i].rect_scale.linear_interpolate(Vector2.ONE,delta * 10)

		if l_count < left_motion.size() - 1:
			l_count += 1
			
		for i in range(l_count):
			left_motion[i].rect_position = left_motion[i].rect_position.linear_interpolate(left_pos[i],delta * 10)
			left_motion[i].rect_scale = left_motion[i].rect_scale.linear_interpolate(Vector2.ONE,delta * 10)

		if ra_count < rand_motion.size():
			ra_count += 0.4
			
		for i in range(ra_count):
			rand_motion[i].rect_position = rand_motion[i].rect_position.linear_interpolate(rand_pos[i],delta * 10)
			rand_motion[i].rect_scale = rand_motion[i].rect_scale.linear_interpolate(Vector2.ONE,delta * 10)
		
		info_count -= delta
		
		if info_count < 0 and info_index < boot_texts.size():
			info_count += rand_range(0,0.1)
			var info_inst = label.duplicate()
			info_inst.text = boot_texts[info_index]
			info_inst.rect_position = Vector2(0,(infos.size() - add_boost) * 10)
			$rand/info_container.add_child(info_inst)
			infos.append(info_inst)
			info_index += 1
			info_inst.visible_characters = 0
			if info_index >= boot_texts.size():
				info_count = 0.8
		
		if info_count < 0 and info_index >= boot_texts.size():
			finished = true
			
		if finished:
			$wallpaper.modulate = $wallpaper.modulate.linear_interpolate(Color.transparent,delta * 7)
			$right.position -= Vector2(25,-25) 
			$left.position += Vector2(25,-25)
			$rand.position.x -= 35
			global.main_scene.current_state = global.main_scene.states.main
			
			if info_count < -1:
				global.main_scene.current_state = global.main_scene.states.main
				queue_free()
		else:
			$wallpaper.modulate = $wallpaper.modulate.linear_interpolate(Color8(0,22,22255),delta * 5)
		
		add_boost = infos.size() - 7
		add_boost = clamp(add_boost,0,9999)
		for i in range(infos.size()):
			infos[i].rect_position = infos[i].rect_position.linear_interpolate(Vector2(0,(i - add_boost)* 10),delta * 25)
			infos[i].visible_characters += 3
			if i < infos.size() - 1:
				infos[i].visible_characters += 10
		
	if Input.is_action_just_pressed("CLICK"):
		
		finished = true
