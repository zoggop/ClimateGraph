require "common"
require "pixel"

Graph = class(function(a, climate, fillRegion, fillSubRegion)
	a.climate = climate
	local grid = {}
	for t = 1, 100 do
		local rains = {}
		for r = 1, 100 do
			local pixel = Pixel(a, t, r, fillRegion, fillSubRegion)
			rains[r] = pixel
		end
		grid[t] = rains
	end
	a.grid = grid
	fillRegion.area = 10000
	fillSubRegion.area = 10000
	fillRegion.latitudeArea = 91
	fillSubRegion.latitudeArea = 91
	print(fillRegion.name, fillSubRegion.name)
end)

function Graph:PixelAt(temp, rain)
	-- print(temp, rain, self.grid, self.grid[temp])
	return self.grid[temp][rain]
end

function Graph:PaintRegion(region, temp, rain, brush, isSub)
	local pixel = self:PixelAt(temp, rain)
	if isSub then
		pixel:SetSubRegion(region)
	else
		pixel:SetRegion(region)
	end
	if brush then
		for b, bristle in pairs(brush) do
			for mx = -1, 1, 2 do
				for my = -1, 1, 2 do
					local t = temp + (bristle.x * mx)
					local r = rain + (bristle.y * my)
					local p = self:PixelAt(t, r)
					if isSub then
						p:SetSubRegion(region)
					else
						p:SetRegion(region)
					end
				end
			end
		end
	end
end