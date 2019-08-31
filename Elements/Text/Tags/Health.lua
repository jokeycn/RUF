local RUF = RUF or LibStub('AceAddon-3.0'):GetAddon('RUF')
local LSM = LibStub('LibSharedMedia-3.0')
local L = LibStub('AceLocale-3.0'):GetLocale('RUF')
local RMH = RealMobHealth
local _, ns = ...
local oUF = ns.oUF
local tags = oUF.Tags.Methods or oUF.Tags
local events = oUF.TagEvents or oUF.Tags.Events

----------------------------------------------------------------------------------- HEALTH
tags['RUF:CurHPPerc'] = function(unit) -- Current Health and Percent if below 100%.
	if not UnitName(unit) then return end
	local cur, max
	if RUF.Client == 2 and RMH then
		cur,max=RMH.GetUnitHealth(unit)
		cur,max=RMH.GetUnitHealth(unit)
	else
		cur, max = UnitHealth(unit), UnitHealthMax(unit)
	end
	local r,g,b = RUF:ReturnTextColors(unit, 'CurHPPerc', cur, max)
	if RUF.db.global.TestMode == true then
		cur = math.random(max /4, max - (max/4))
	end
	if realunit then
		r,g,b = RUF:ReturnTextColors(realunit, 'CurHPPerc', cur, max)
	end
	if UnitIsDead(unit) then
		if RUF.db.profile.Appearance.Text.CurHPPerc.Case == 1 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.upper(L['Dead']))
		elseif RUF.db.profile.Appearance.Text.CurHPPerc.Case == 2 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.lower(L['Dead']))
		else
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,L['Dead'])
		end
	elseif UnitIsGhost(unit) then
		if RUF.db.profile.Appearance.Text.CurHPPerc.Case == 1 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.upper(L['Ghost']))
		elseif RUF.db.profile.Appearance.Text.CurHPPerc.Case == 2 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.lower(L['Ghost']))
		else
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,L['Ghost'])
		end
	elseif not UnitIsConnected(unit) then
		if RUF.db.profile.Appearance.Text.CurHPPerc.Case == 1 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.upper(L['Offline']))
		elseif RUF.db.profile.Appearance.Text.CurHPPerc.Case == 2 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.lower(L['Offline']))
		else
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,L['Offline'])
		end
	elseif cur == max then -- if we're at full health
		if RUF.db.profile.Appearance.Text.CurHPPerc.Case == 1 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(cur,true))
		elseif RUF.db.profile.Appearance.Text.CurHPPerc.Case == 2 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(cur,true))
		else
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(cur,true))
		end
	else
		if RUF.db.profile.Appearance.Text.CurHPPerc.Case == 1 then
			return string.format('|cff%02x%02x%02x%s%s%s%%|r',r*255,g*255,b*255,RUF:Short(cur,true), ' - ',RUF:Percent(cur,max))
		elseif RUF.db.profile.Appearance.Text.CurHPPerc.Case == 2 then
			return string.format('|cff%02x%02x%02x%s%s%s%%|r',r*255,g*255,b*255,RUF:Short(cur,true), ' - ',RUF:Percent(cur,max))
		else
			return string.format('|cff%02x%02x%02x%s%s%s%%|r',r*255,g*255,b*255,RUF:Short(cur,true), ' - ',RUF:Percent(cur,max))
		end
	end
end
events['RUF:CurHPPerc'] = 'UNIT_HEALTH UNIT_CONNECTION'

tags['RUF:HPPerc'] = function(unit)
	if not UnitName(unit) then return end
	local cur, max
	if RUF.Client == 2 and RMH then
		cur,max=RMH.GetUnitHealth(unit)
		cur,max=RMH.GetUnitHealth(unit)
	else
		cur, max = UnitHealth(unit), UnitHealthMax(unit)
	end
	local r,g,b = RUF:ReturnTextColors(unit, 'HPPerc', cur, max)
	if RUF.db.global.TestMode == true then
		cur = math.random(max /4, max - (max/4))
	end
	if realunit then
		r,g,b = RUF:ReturnTextColors(realunit, 'HPPerc', cur, max)
	end
	return string.format('|cff%02x%02x%02x%s%%|r',r*255,g*255,b*255,RUF:Percent(cur,max))
end
events['RUF:HPPerc'] = 'UNIT_HEALTH UNIT_CONNECTION'

tags['RUF:CurHP'] = function(unit)
	if not UnitName(unit) then return end
	local cur, max
	if RUF.Client == 2 and RMH then
		cur,max=RMH.GetUnitHealth(unit)
		cur,max=RMH.GetUnitHealth(unit)
	else
		cur, max = UnitHealth(unit), UnitHealthMax(unit)
	end
	local r,g,b = RUF:ReturnTextColors(unit, 'CurHP', cur, max)
	if RUF.db.global.TestMode == true then
		cur = math.random(max /4, max - (max/4))
	end
	if realunit then
		r,g,b = RUF:ReturnTextColors(realunit, 'CurHP', cur, max)
	end
	if cur == max then -- if we're at full health
		if RUF.db.profile.Appearance.Text.CurHP.Case == 1 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(cur,true))
		elseif RUF.db.profile.Appearance.Text.CurHP.Case == 2 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(cur,true))
		else
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(cur,true))
		end
	else
		if RUF.db.profile.Appearance.Text.CurHP.Case == 1 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(cur,true))
		elseif RUF.db.profile.Appearance.Text.CurHP.Case == 2 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(cur,true))
		else
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(cur,true))
		end
	end
end
events['RUF:CurHP'] = 'UNIT_HEALTH UNIT_CONNECTION'

tags['RUF:CurMaxHPPerc'] = function(unit) -- Current Health and Percent if below 100%.
	if not UnitName(unit) then return end
	local cur, max
	if RUF.Client == 2 and RMH then
		cur,max=RMH.GetUnitHealth(unit)
		cur,max=RMH.GetUnitHealth(unit)
	else
		cur, max = UnitHealth(unit), UnitHealthMax(unit)
	end
	local r,g,b = RUF:ReturnTextColors(unit, 'CurHPPerc', cur, max)
	if RUF.db.global.TestMode == true then
		cur = math.random(max /4, max - (max/4))
	end
	if realunit then
		r,g,b = RUF:ReturnTextColors(realunit, 'CurHPPerc', cur, max)
	end
	if UnitIsDead(unit) then
		if RUF.db.profile.Appearance.Text.CurHPPerc.Case == 1 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.upper(L['Dead']))
		elseif RUF.db.profile.Appearance.Text.CurHPPerc.Case == 2 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.lower(L['Dead']))
		else
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,L['Dead'])
		end
	elseif UnitIsGhost(unit) then
		if RUF.db.profile.Appearance.Text.CurHPPerc.Case == 1 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.upper(L['Ghost']))
		elseif RUF.db.profile.Appearance.Text.CurHPPerc.Case == 2 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.lower(L['Ghost']))
		else
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,L['Ghost'])
		end
	elseif not UnitIsConnected(unit) then
		if RUF.db.profile.Appearance.Text.CurHPPerc.Case == 1 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.upper(L['Offline']))
		elseif RUF.db.profile.Appearance.Text.CurHPPerc.Case == 2 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.lower(L['Offline']))
		else
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,L['Offline'])
		end
	elseif cur == max then -- if we're at full health
		if RUF.db.profile.Appearance.Text.CurHPPerc.Case == 1 then
			return string.format('|cff%02x%02x%02x%s/%s|r',r*255,g*255,b*255,RUF:Short(cur,true),RUF:Short(max,true))
		elseif RUF.db.profile.Appearance.Text.CurHPPerc.Case == 2 then
			return string.format('|cff%02x%02x%02x%s/%s|r',r*255,g*255,b*255,RUF:Short(cur,true),RUF:Short(max,true))
		else
			return string.format('|cff%02x%02x%02x%s/%s|r',r*255,g*255,b*255,RUF:Short(cur,true),RUF:Short(max,true))
		end
	else
		if RUF.db.profile.Appearance.Text.CurHPPerc.Case == 1 then
			return string.format('|cff%02x%02x%02x%s/%s - %s%%|r',r*255,g*255,b*255,RUF:Short(cur,true),RUF:Short(max,true),RUF:Percent(cur,max))
		elseif RUF.db.profile.Appearance.Text.CurHPPerc.Case == 2 then
			return string.format('|cff%02x%02x%02x%s/%s - %s%%|r',r*255,g*255,b*255,RUF:Short(cur,true),RUF:Short(max,true),RUF:Percent(cur,max))
		else
			return string.format('|cff%02x%02x%02x%s/%s - %s%%|r',r*255,g*255,b*255,RUF:Short(cur,true),RUF:Short(max,true),RUF:Percent(cur,max))
		end
	end
end
events['RUF:CurMaxHPPerc'] = 'UNIT_HEALTH UNIT_CONNECTION'

tags['RUF:MaxHP'] = function(unit)
	if not UnitName(unit) then return end
	local cur, max
	if RUF.Client == 2 and RMH then
		cur,max=RMH.GetUnitHealth(unit)
		cur,max=RMH.GetUnitHealth(unit)
	else
		cur, max = UnitHealth(unit), UnitHealthMax(unit)
	end
	local r,g,b = RUF:ReturnTextColors(unit, 'CurHP', cur, max)
	if RUF.db.global.TestMode == true then
		cur = math.random(max /4, max - (max/4))
	end
	if realunit then
		r,g,b = RUF:ReturnTextColors(realunit, 'CurHP', cur, max)
	end
	if cur == max then -- if we're at full health
		if RUF.db.profile.Appearance.Text.CurHP.Case == 1 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(max,true))
		elseif RUF.db.profile.Appearance.Text.CurHP.Case == 2 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.lower(RUF:Short(max,true)))
		else
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(max,true))
		end
	else
		if RUF.db.profile.Appearance.Text.CurHP.Case == 1 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(max,true))
		elseif RUF.db.profile.Appearance.Text.CurHP.Case == 2 then
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,string.lower(RUF:Short(max,true)))
		else
			return string.format('|cff%02x%02x%02x%s|r',r*255,g*255,b*255,RUF:Short(max,true))
		end
	end
end
events['RUF:MaxHP'] = 'UNIT_HEALTH UNIT_CONNECTION'