local nodeClass = {};
nodeClass.__index = nodeClass;

function nodeClass.new(i, j, w, h, boardW, __key)
	local self = setmetatable({}, nodeClass);
	self.i = i;
	self.j = j;
	
	self.x = j * w;
	self.y = i * w;
	
	self.wallColour = Color3.fromRGB(8,8,8);
	
	if self.x == w and self.y == w then
		self.wallColour = Color3.fromRGB(8, 8, 8);
	end
	
	self.w = w;
	self.boardW = boardW;
	
	self.h = h;
	self.stroke = 0.5;
	
	self.__key = __key;

	self.visited = false;
	
	self.walls = {};
	return self;
end

--[[function nodeClass:changeWallColours()
	for i, v in pairs(self.walls) do
		v.Color = Color3.new(0.909803, 0.458823, 1);
	end
end]]

--[[function nodeClass:changeWallTex()
	for i, v in pairs(self.walls) do
		v.Color = Color3.new(0.972549, 0.278431, 0.278431);
		for _,k in pairs(v:GetChildren()) do
			k.StudsPerTileU = 15;
			k.StudsPerTileV = 15;
		end
	end
end]]

function nodeClass:spawnWalls()
	local m = 1;
	--TOP WALL
	self:createWall(Vector3.new(self.w*m,self.h*m, self.stroke), Vector3.new(self.x, 0, self.y - self.w/2), "TOP");
	--LEFT WALL
	self:createWall(Vector3.new(self.stroke,self.h*m, self.w*m), Vector3.new(self.x - self.w/2, 0, self.y), "LEFT");
	--BOTTOM WALL
	self:createWall(Vector3.new(self.w*m,self.h*m, self.stroke), Vector3.new(self.x, 0, self.y + self.w/2), "BOTTOM");
	--RIGHT WALL
	self:createWall(Vector3.new(self.stroke,self.h*m, self.w*m), Vector3.new(self.x + self.w/2, 0, self.y), "RIGHT");
end


function nodeClass:createWall(size, position, name)
	local stud_per_tile_U = 14.5;
	local stud_per_tile_V = 23;
	local offset_studs_v = 23;
	local transparency = .2
	local id = "17756323456"

	local wall = Instance.new("Part");
	wall.CanCollide = false
	wall.Anchored = true;
	wall.Name = name;
	wall.Size = size;
	wall.Position = position;
	wall.CanCollide = true
	wall.Parent = game.Workspace;
	wall.Color = self.wallColour;
	wall.Material = Enum.Material.Neon;
	wall.Transparency = 0
	wall.CastShadow = false
	wall.CollisionGroup = "walls"
	wall.CanCollide = true
	table.insert(self.walls, wall);

	local tex = Instance.new("Texture");
	tex.Texture = "rbxassetid://"..id;
	tex.StudsPerTileU = stud_per_tile_U;
	tex.StudsPerTileV = stud_per_tile_V;
	tex.OffsetStudsV = offset_studs_v;
	tex.Transparency = transparency;
	tex.Parent = wall;
	tex.Face = Enum.NormalId.Front
	tex.Name = "tex_front"

	local tex2 = Instance.new("Texture");
	tex2.Texture = "rbxassetid://"..id;
	tex2.StudsPerTileU = stud_per_tile_U;
	tex2.StudsPerTileV = stud_per_tile_V;
	tex.OffsetStudsV = offset_studs_v;
	tex2.Transparency = transparency;
	tex2.Parent = wall;
	tex2.Face = Enum.NormalId.Back;
	tex2.Name = "tex_back";

	local tex3 = Instance.new("Texture");
	tex3.Texture = "rbxassetid://"..id;
	tex3.StudsPerTileU = stud_per_tile_U;
	tex3.StudsPerTileV = stud_per_tile_V;
	tex.OffsetStudsV = offset_studs_v;
	tex3.Transparency = transparency;
	tex3.Parent = wall;
	tex3.Face = Enum.NormalId.Left;
	tex3.Name = "tex_left";

	local tex4 = Instance.new("Texture");
	tex4.Texture = "rbxassetid://"..id;
	tex4.StudsPerTileU = stud_per_tile_U;
	tex4.StudsPerTileV = stud_per_tile_V;
	tex.OffsetStudsV = offset_studs_v;
	tex4.Transparency = transparency;
	tex4.Parent = wall;
	tex4.Face = Enum.NormalId.Right;
	tex4.Name = "tex_right";

	local pathfind_mod = Instance.new("PathfindingModifier")
	pathfind_mod.Parent = wall
	pathfind_mod.PassThrough = true

end

function nodeClass:calculateStackNodeIndex(i ,j)
	if i < 1 or j < 1 or i > self.boardW or j > self.boardW then
		return "nil";
	end
	return (j + (i-1) * self.boardW);
end

function nodeClass:checkNeighbours(nodes)
	local neighbours = {}
	
	local bottom = nodes[self:calculateStackNodeIndex(self.i, self.j+1)];
	
	local left = nodes[self:calculateStackNodeIndex(self.i-1, self.j)];
	
	local top = nodes[self:calculateStackNodeIndex(self.i, self.j-1)];

	local right = nodes[self:calculateStackNodeIndex(self.i+1, self.j)];
	
	
	if top ~= nil and not top.visited then
		table.insert(neighbours, top);
	end
	if right ~= nil and not right.visited then
		table.insert(neighbours, right);
	end
	if bottom ~= nil and not bottom.visited then
		table.insert(neighbours, bottom);
	end
	if left ~= nil and not left.visited then
		table.insert(neighbours, left);
	end
	
	if #neighbours > 0 then
		local randomNeighbour = neighbours[math.random(1, #neighbours)];
		local index = table.find(nodes, randomNeighbour)
		return neighbours[math.random(1, #neighbours)], index;
	else
		return nil, nil;
	end

end

return nodeClass;