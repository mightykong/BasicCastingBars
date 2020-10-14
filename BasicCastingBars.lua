
local f = CreateFrame("Frame", "BasicCastingBarsFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")

local bg = f:CreateTexture()
bg:SetAllPoints(f)
bg:SetColorTexture(0, 1, 0, 0.3)
bg:Show()

local SetPoint = f.SetPoint
local ClearAllPoints = f.ClearAllPoints
ClearAllPoints(CastingBarFrame)
SetPoint(CastingBarFrame, "TOPRIGHT", f, "TOPRIGHT")
hooksecurefunc(CastingBarFrame, "SetPoint", function(frame)
	ClearAllPoints(frame)
	SetPoint(frame, "CENTER", f, "CENTER")
end)

local header = f:CreateFontString(nil, "OVERLAY", "TextStatusBarText")
header:SetAllPoints(f)
header:SetText("BasicCastingBars")
header:Show()

f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
f:SetWidth(220)
f:SetHeight(35)
f:Show()
f:EnableMouse(true)
f:RegisterForDrag("LeftButton")
f:SetMovable(true)
f:SetScript("OnDragStart", function(frame) frame:StartMoving() end)
f:SetScript("OnDragStop", function(frame)
	frame:StopMovingOrSizing()
	local a, _, b, c, d = frame:GetPoint()
	BasicCastingBarsOptions[1] = a
	BasicCastingBarsOptions[2] = b
	BasicCastingBarsOptions[3] = c
	BasicCastingBarsOptions[4] = d
end)

f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(display)
	if not BasicCastingBarsOptions then
		BasicCastingBarsOptions = {"CENTER", "CENTER", 0, 0, false}
	end

	display:ClearAllPoints()
	display:SetPoint(BasicCastingBarsOptions[1], UIParent, BasicCastingBarsOptions[2], BasicCastingBarsOptions[3], BasicCastingBarsOptions[4])

	if BasicCastingBarsOptions[5] then
		bg:Hide()
		header:Hide()
		display:EnableMouse(false)
		display:SetMovable(false)
	end

	display:UnregisterEvent("PLAYER_LOGIN")
	display:SetScript("OnEvent", nil)
end)

SlashCmdList.BASICCASTINGBARS = function()
	if not BasicCastingBarsOptions then return end

	if not BasicCastingBarsOptions[5] then
		bg:Hide()
		header:Hide()
		f:EnableMouse(false)
		f:SetMovable(false)
		BasicCastingBarsOptions[5] = true
		print("|cFF33FF99BasicCastingBars|r:", _G.LOCKED)
	else
		bg:Show()
		header:Show()
		f:EnableMouse(true)
		f:SetMovable(true)
		BasicCastingBarsOptions[5] = false
		print("|cFF33FF99BasicCastingBars|r:", _G.UNLOCK)
	end
end
SLASH_BASICCASTINGBARS1 = "/basiccastingbars"

