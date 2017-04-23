onSpnPress = {}
modCrewSize = {}
modFuelEfficiency = {}
modMaxFuel = {}
function init()
	local shipUpgrades = player.shipUpgrades()
	self.crewSize = shipUpgrades.crewSize
	self.fuelEfficiency = shipUpgrades.fuelEfficiency
	self.maxFuel = shipUpgrades.maxFuel

	setText("lblCrewSizeValue",self.crewSize)
	setText("lblFuelEfficiencyValue",self.fuelEfficiency)
	setText("lblMaxFuelValue",self.maxFuel)
end
--[[
	"data" : {
	"linkedLabel" : "lblFuelEfficiencyValue",
	"maxIndex" : -1,
	"minIndex" : 0.0,
	"step" : 0.1
	}
]]

function modValue(num, data, dir)
	if dir == "up" then dir = 1*data.step else dir = (-1)*data.step end
	num = num + dir
	num = math.max(data.minIndex, num)
	if data.maxIndex > -1 then
		num = math.min(data.maxIndex, num)
	end

	return num
end

function modCrewSize.up(dir)
	local data = widget.getData("spnCrewSizeValue")
	self.crewSize = modValue(self.crewSize, data, dir)
	setText(data.linkedLabel, self.crewSize)
end

function modCrewSize.down(dir)
	local data = widget.getData("spnCrewSizeValue")
	self.crewSize = modValue(self.crewSize, data, dir)
	setText(data.linkedLabel, self.crewSize)
end

function modFuelEfficiency.down(dir)
	local data = widget.getData("spnFuelEfficiencyValue")
	self.fuelEfficiency = modValue(self.fuelEfficiency, data, dir)
	setText(data.linkedLabel, self.fuelEfficiency)
--things
end

function modFuelEfficiency.up(dir)
	local data = widget.getData("spnFuelEfficiencyValue")
	self.fuelEfficiency = modValue(self.fuelEfficiency, data, dir)
	setText(data.linkedLabel, self.fuelEfficiency)
end

function modMaxFuel.up(dir)
	local data = widget.getData("spnMaxFuelValue")
	self.maxFuel = modValue(self.maxFuel, data, dir)
	setText(data.linkedLabel, self.maxFuel)
end


function modMaxFuel.down(dir)
	local data = widget.getData("spnMaxFuelValue")
	self.maxFuel = modValue(self.maxFuel, data, dir)
	setText(data.linkedLabel, self.maxFuel)
end

function setText(lbl, value)
	value = tostring(value)
	widget.setText(lbl, value)
end


function uninit()
	applyUpgrades()
end

function applyUpgrades()
	local shipUpgrades = player.shipUpgrades()
	shipUpgrades.crewSize = self.crewSize
	shipUpgrades.fuelEfficiency = self.fuelEfficiency * 1.0
	shipUpgrades.maxFuel = self.maxFuel
	player.upgradeShip(shipUpgrades)

	dLogJson(player.shipUpgrades(), "shipUpgrades")
end