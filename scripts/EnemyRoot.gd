extends Node2D

var sprite = null;
const sprites = ["enemy1_blue.png", "enemy1_green.png",
        		"enemy1_pink.png", "enemy1_yellow.png"]
			
var speed = 100
onready var explode = preload("res://Explosion/Explosion.tscn").instance()

func _ready():
	#Set enemy speed
	speed = speed + (globals.currentStage * 10)
	
func _enter_tree():
	#Create random enemy sprites
	sprite = Sprite.new()
	sprite.texture = load ("res://art/PNG/Sprites/Enemies/" + sprites[randi()%sprites.size()])
	add_child(sprite)
	
func _process(delta):
	move_local_x(-delta*speed)
	
func _on_Area2D_area_entered(area):
	#Hit by bullet
	if(area.get_collision_layer_bit(3)):
		explode.set_position(self.get_position())
		get_parent().add_child(explode)
		globals.kills = globals.kills + 1
		queue_free()


