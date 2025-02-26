extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_right_teleporter_area_entered(area: Area2D) -> void:
	area.get_parent().position = $"Left Teleporter/Left Spawn Point".global_position


func _on_left_teleporter_area_entered(area: Area2D) -> void:
	area.get_parent().position = $"Right Teleporter/Right Spawn Point".global_position
