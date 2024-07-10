local boardW = 34;
local cellW = 14;
local h = 25;

local nodeClass = require(script.NodeClass);
local stackModule = require(script.Stack);

local nodes = {};

function createNewMaze()
	local index = 1;
	for i = 1, boardW do
		for j = 1, boardW do
			local currentNode = nodeClass.new(i, j, cellW, h, boardW);
			currentNode:spawnWalls();
			nodes[index] = currentNode;
			index += 1;
		end
	end
end

function removeWalls(currentNode, nextNode)
	local y = (currentNode.i - nextNode.i);
	local x = (currentNode.j - nextNode.j);
	
	if x == 1  then
		currentNode.walls[2]:Destroy();
		nextNode.walls[4]:Destroy();
	elseif x == -1 then
		currentNode.walls[4]:Destroy();
		nextNode.walls[2]:Destroy();
	end
	
	if y == 1  then
		currentNode.walls[1]:Destroy();
		nextNode.walls[3]:Destroy();
	elseif y == -1 then
		currentNode.walls[3]:Destroy();
		nextNode.walls[1]:Destroy();
	end
end

function calculateMaze()
	local nodeStack = stackModule.new(cellW * cellW);
	local current = nodes[1];
	
	--Mark first one as visited and push onto stack
	current.visited = true;
	--print(current:checkNeighbours(nodes));
	nodeStack:push(current);
	
	--Create the currentNodePointerMesh
	
	while not nodeStack:isEmpty() do
		current = nodeStack:pop();
		local neighbour, index = current:checkNeighbours(nodes);
	
		if neighbour ~= nil then
			nodeStack:push(current);
			removeWalls(current, neighbour);
			neighbour.visited = true;
			nodeStack:push(neighbour);
		end
	end
end

createNewMaze();
calculateMaze();


for i,k in pairs(game.Workspace:GetChildren()) do
		if k.Name == "TOP" then
			k.CanCollide = true
			for _,obj in pairs(k:GetTouchingParts()) do
				if obj.Name == "BOTTOM" then
					obj:Destroy();
				end
			end
		end
		if k.Name == "BOTTOM" then
			k.CanCollide = true
			for _,obj in pairs(k:GetTouchingParts()) do
				if obj.Name == "TOP" then
					obj:Destroy();
				end
			end
		end
		if k.Name == "RIGHT" then
			k.CanCollide = true
			for _,obj in pairs(k:GetTouchingParts()) do
				if obj.Name == "LEFT" then
					obj:Destroy();
				end
			end
		end
		if k.Name == "LEFT" then
			k.CanCollide = true
			for _,obj in pairs(k:GetTouchingParts()) do
				if obj.Name == "RIGHT" then
					obj:Destroy();
				end
			end
		end
end