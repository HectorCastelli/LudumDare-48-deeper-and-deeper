tool
extends GridMap

export var WALL_HEIGHT = 20 setget set_wall_height

func set_wall_height(newHeight):
	# Load all cells
	var usedCells = self.get_used_cells()
	# Find cells on layer zero (y==0)
	var layerZero := []
	for cell in usedCells:
		if cell.y==0:
			layerZero.append(cell)
	# Gather all information (cell position, tile index, orientation)
	var templateCells := []
	for templateCell in layerZero:
		var templateData = {
			"position": templateCell,
			"cell_item": self.get_cell_item(templateCell.x,templateCell.y,templateCell.z),
			"cell_orientation": self.get_cell_item_orientation(templateCell.x,templateCell.y,templateCell.z)
		}
		templateCells.append(templateData)
	# Clear gridmap
	self.clear()
	# Use template information to create other layers from scratch from -WALL_HEIGHT to WALL_HEIGHT
	for i in range(-WALL_HEIGHT, WALL_HEIGHT):
		for templateCell in templateCells:
			self.set_cell_item(
				templateCell.position.x, i, templateCell.position.z,
				templateCell.cell_item,
				templateCell.cell_orientation
				)
			compute_bounds(templateCell.position.x, templateCell.position.z)
	#Build wall at bottom of the tube
	for x in range(min_x, max_x):
		for z in range(min_z, max_z):
			self.set_cell_item(x,-WALL_HEIGHT, z, 0)
	pass

# Store bounding box to build a wall at the bottom of the map
var max_x:=0
var min_x:=0
var max_z:=0
var min_z:=0
func compute_bounds(x,z):
	if x > max_x:
		max_x = x
	if x < min_x:
		min_x = x
	if z > max_z:
		max_z = z
	if z < min_z:
		min_z = z
