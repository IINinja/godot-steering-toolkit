extends Node2D


signal path_established(points)


var active_points := []
var drawing := false
var distance_threshold := 100.0


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if drawing:
			active_points.append(event.position)
			update()
	elif event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			active_points.clear()
			active_points.append(event.position)
			drawing = true
			update()
		elif not event.pressed:
			drawing = false
			if active_points.size() >= 2:
				_simplify()


func _draw() -> void:
	if drawing:
		for point in active_points:
			draw_circle(point, 1, Color.red)
	else:
		if active_points.size() > 0:
			draw_circle(active_points.front(), 2, Color.red)
			draw_circle(active_points.back(), 2, Color.yellow)
			for i in range(1, active_points.size()):
				var start: Vector2 = active_points[i-1]
				var end: Vector2 = active_points[i]
				draw_line(start, end, Color.skyblue)


func _simplify() -> void:
	var first: Vector2 = active_points.front()
	var last: Vector2 = active_points.back()
	var key := first
	var simplified_path := [first]
	for i in range(1, active_points.size()):
		var point: Vector2 = active_points[i]
		var distance := point.distance_to(key)
		if distance > distance_threshold:
			key = point
			simplified_path.append(key)
	active_points = simplified_path
	if active_points.back() != last:
		active_points.append(last)
	update()
	emit_signal("path_established", active_points)
