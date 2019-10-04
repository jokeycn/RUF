local _, ns = ...
local oUF = ns.oUF

local smoothing = {}
local function Smooth(self, value)
	local _, max = self:GetMinMaxValues()
	if value == self:GetValue() or (self._max and self._max ~= max) then
		smoothing[self] = nil
		self:SetValue_(value)
	else
		smoothing[self] = value
	end
	self._max = max
end

local function UnSmooth(self)
	smoothing[self] = nil
	self.SetValue = self.SetValue_
	self.SetValue_ = nil
	self.Smooth = nil
end

local function SmoothBar(self, bar)
	bar.SetValue_ = bar.SetValue
	bar.SetValue = Smooth
	bar.UnSmooth = UnSmooth
end

local function hook(frame)
	frame.SmoothBar = SmoothBar
	if frame.Health and frame.Health.Smooth then
		frame:SmoothBar(frame.Health)
	end
	if frame.Power and frame.Power.Smooth then
		frame:SmoothBar(frame.Power)
	end
end

for i, frame in ipairs(oUF.objects) do hook(frame) end
oUF:RegisterInitCallback(hook)


local f, min, max, abs = CreateFrame('Frame'), math.min, math.max, math.abs
f:SetScript('OnUpdate', function()
	local limit = 30/GetFramerate()
	for bar, value in pairs(smoothing) do
		local minVal,maxVal = bar:GetMinMaxValues()
		local curVal = bar:GetValue()
		local new = curVal + min((value-curVal)/5, max(value-curVal, limit))
		if new ~= new then
			new = value
		end
		bar:SetValue_(new)
		local pVal = new
		if curVal == value or abs(new - value) < 2 then
			bar:SetValue_(value)
			pVal = value
			smoothing[bar] = nil
		end
		if bar == bar.__owner.Health and bar.__owner.Portrait and bar.__owner.Portrait.Cutaway then
			local Portrait = bar.__owner.Portrait
			local frameWidth = bar.__owner:GetWidth()
			local width = frameWidth * (pVal/maxVal)
			local fillStyle = bar.FillStyle
			if fillStyle == 'REVERSE' then
				Portrait:SetViewInsets((-frameWidth)+width,0,0,0) -- Right
			elseif fillStyle == 'CENTER' then
				Portrait:SetViewInsets(((-frameWidth)+width)/2,((-frameWidth)+width)/2,0,0)
			else
				Portrait:SetViewInsets(0,(-frameWidth)+width,0,0) -- Left
			end
		end
	end
end)