extends Node2D

onready var _character = $AnimatedSprite
onready var _label = $Interface/Label
onready var _bar = $Interface/ColorRect/XPBar
var bar_convert = 0

func _ready():
	_label.set_text("Amrith "+"\n"+"Level: "+ str(_character.level)+ "\n" +"Experience Points: " +str(_character.experience) + "\n" +"XP To Next Level: "+str(_character.experience_required))
	_bar.rect_size.x = 1
func _input(event):
	if not event.is_action_pressed("ui_up"):
		return
	_character.gain_xp(1)
	bar_convert = ( _character.experience*550)/_character.experience_required
	#while (_bar.rect_size.x < bar_convert):
	#	_bar.rect_size.x +=1
	_bar.rect_size.x = (_character.experience*550)/_character.experience_required
	_label.set_text("Amrith "+"\n"+"Level: "+ str(_character.level)+ "\n" +"Experience Points: " +str(_character.experience) + "\n" +"XP To Next Level: "+str(_character.experience_required))
		

func _on_LEVELButton_pressed():
	_label.set_text("Amrith "+"\n"+"Level: "+ str(_character.level)+ "\n" +"Experience Points: " +str(_character.experience) + "\n" +"XP To Next Level: "+str(_character.experience_required))
	$AnimatedSprite.gain_xp(_character.experience_required)
	
func save():
	var s_dir = {
		"filename": get_filename(),
		"parent":get_parent().get_path(),
		"level": $AnimatedSprite.level,
		"attack": $AnimatedSprite.atk,
		"def": $AnimatedSprite.def,
		"xp": $AnimatedSprite.experience
	}
	return s_dir
	
func save_game():
	var save_game = File.new()
	save_game.open("res://main.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save");
		save_game.store_line(to_json(node_data))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("res://main.save"):
		print("No File To Load!")
		return # Error! We don't have a save to load.
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	#for i in save_nodes:
		#i.queue_free()
	save_game.open("res://main.save", File.READ)
	
	var current_line = {}
		# Firstly, we need to create the object and add it to the tree and set its position.
		#var new_object = load(current_line["filename"]).instance()
		#get_node(current_line["parent"]).add_child(new_object)
		#new_object.position = Vector2(current_line["pos_x"], current_line["pos_y"])
		# Now we set the remaining variables.
	current_line = parse_json(save_game.get_line())
	print(current_line.get("level"))
	$AnimatedSprite.level = current_line.get("level")
	$AnimatedSprite.atk = current_line.get("attack")
	print($AnimatedSprite.atk)
	_label.set_text("Amrith "+"\n"+"Level: "+ str(_character.level)+ "\n" +"Experience Points: " +str(_character.experience) + "\n" +"XP To Next Level: "+str(_character.experience_required))
	save_game.close()

func _on_Save_pressed():
	save()
	save_game()

func _on_Load_pressed():
	load_game()

func _on_DICT_pressed():
	var test_dict = {
		"name":"Mark",
		"Age": 22
	}
	print(test_dict.get("name","Age"))
