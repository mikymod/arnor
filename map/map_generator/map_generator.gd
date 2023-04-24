class_name MapGenerator
extends Node

# Generates map data procedurally
func generate(plane_len: int, node_count: int, path_count: int) -> MapGeneratorData:
	randomize()
	
	var points: Array[Vector2] = _generate_random_points(plane_len, node_count)
	
	var paths: Array[PackedInt64Array] = _generate_paths(points, path_count)
	
	var data = MapGeneratorData.new()
	data.set_paths(paths, points)
	return data

# Generates random points
func _generate_random_points(plane_len: int, node_count: int) -> Array[Vector2]:
	var points: Array[Vector2] = []
	points.append(Vector2(0, plane_len / 2))
	points.append(Vector2(plane_len, plane_len / 2))
	var center: Vector2 = Vector2(plane_len / 2, plane_len / 2)
	for i in range(node_count):
		while true:
			var point = Vector2(randi() % plane_len, randi() % plane_len)
			var dist_from_center = (point - center).length_squared()
			# only accept points inside of a circle
			var in_circle = dist_from_center <= plane_len * plane_len / 4
			if not points.has(point) and in_circle:
				points.append(point)
				break
	return points

# Finds paths from start to finish using A*
func _generate_paths(points: Array[Vector2], path_count: int) -> Array[PackedInt64Array]:
	# Connects all the points into a graph without intersecting edges
	var pool: PackedVector2Array = PackedVector2Array(points)
	var triangles: PackedInt32Array = Geometry2D.triangulate_delaunay(pool)
	
	var astar: AStar2D = AStar2D.new()
	for i in range(points.size()):
		astar.add_point(i, points[i])
	
	for i in range(triangles.size() / 3):
		var p1 = triangles[i * 3]
		var p2 = triangles[i * 3 + 1]
		var p3 = triangles[i * 3 + 2]
		if not astar.are_points_connected(p1, p2):
			astar.connect_points(p1, p2)
		if not astar.are_points_connected(p2, p3):
			astar.connect_points(p2, p3)
		if not astar.are_points_connected(p1, p3):
			astar.connect_points(p1, p3)
	
	var paths: Array[PackedInt64Array] = []
	for i in range(path_count):
		var id_path = astar.get_id_path(0, 1)
		if id_path.size() == 0:
			break
		
		paths.append(id_path)
		
		# Removes nodes / generating unique path every time
		for j in range(randi() % 2 + 1):
			# index between 1 and id_path.size() - 2 (inclusive)
			var index = randi() % (id_path.size() - 2) + 1
			var id = id_path[index]
			astar.set_point_disabled(id)
	
	return paths
