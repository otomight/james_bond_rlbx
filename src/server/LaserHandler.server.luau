local alarmSystem: Model? = workspace:FindFirstChild("AlarmSystem")

local function activateAlarm(alarm: Model)
	local sound: 			Sound? = alarm:FindFirstChild("Sound")
	local isAlarmActive:	boolean? = alarm:GetAttribute("IsActive")

	if not sound then
		warn("Alarm sound not found")
	end
	if isAlarmActive then
		return
	end
	alarm:SetAttribute("IsActive", true)
	sound:Play()
	wait(5)
	sound:Stop()
	alarm:SetAttribute("IsActive", false)
end

local function configLasers()
	local lasersFolder: Folder? = alarmSystem:FindFirstChild("Lasers")
	local alarm:		Model? = alarmSystem:FindFirstChild("Alarm")

	if not lasersFolder or not alarm then
		warn("Lasers folder or alarm not found")
	end

	for _, laser: Instance in pairs(lasersFolder:GetChildren()) do
		if laser:IsA("Part") then
			laser.Touched:Connect(function() activateAlarm(alarm) end)
		end
	end
end

configLasers()
