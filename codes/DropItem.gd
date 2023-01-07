extends Area2D

onready var model = $Model

var _type = "None"
var drops = [
	"health",
	"handgun_ammo",
	"rifile_ammo",
	"shotgun_ammo",
]

func get_item(player : KinematicBody2D = null):
	if not player:
		return "None"
	var p = randf()
	if p <= .5:
		if PlayerStats.health < PlayerStats.max_health:
			return "health"
		p = 0.51
	
	var wep = p - 0.5
	
	var kills = PlayerStats.kills
	if kills < 75:
		return "handgun_ammo"
	if kills < 75*4:
		if wep <= .7:
			return "handgun_ammo"
		return "rifle_ammo"
	if wep <= 0.4:
		return "handgun_ammo"
	wep -= 0.4
	if wep <= 0.35:
		return "rifle_ammo"
	return "shotgun_ammo"

func Deploy(ply : KinematicBody2D = null, parent : KinematicBody2D = null) -> bool:
	if ply == null:
		print("player inválido")
		return false
	if not parent:
		print("parent inválido")
		return false
	randomize()
	if randf() < .5:
		print("bad luck")
		return false
	var item = get_item(ply)
	if item == "None":
		print("item = None")
		return false
	if not item in drops:
		print("Item n ta em drops")
		return false
	var item_model : StreamTexture = load("res://image/drops/"+ item +".png")
	model.texture = item_model
	model.scale = Vector2(16, 16) / Vector2(item_model.get_width(), item_model.get_height())
	position = parent.position
	return true

func _on_DropItem_area_entered(area):
	print(area.get_parent(), " entrou!")