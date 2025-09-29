local Decimals = 4
local Clock = os.clock()
local ValueText = "Value Is Now :"

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Roblox-UI-Libs/main/1%20Tokyo%20Lib%20(FIXED)/Tokyo%20Lib%20Source.lua"))({
    cheatname = "burnscript!", -- watermark text
    gamename = "miners haven", -- watermark text
})

library:init()

local Window1  = library.NewWindow({
    title = "burn.script! | miners haven", -- Mainwindow Text
    size = UDim2.new(0, 510, 0.6, 6
)})

local Tab1 = Window1:AddTab("  layout  ")
local SettingsTab = library:CreateSettingsTab(Window1)

--Tab1:SetText("Text")

local Section1 = Tab1:AddSection("layout switch", 1)

local Section2 = Tab1:AddSection("helpers", 2)










Section1:AddButton({
    enabled = true,
    text = "layout 1",
    tooltip = "forcibly switches your layout to layout 1",
    confirm = true,
    risky = false,
    callback = function()
        startLayoutLoop("Layout1", "runningLayout1")
    end
})




Section2:AddToggle({
    text = "auto regular boxes",
    state = false,
    risky = true,
    tooltip = "auto opens regular boxes!",
    flag = "Toggle_1",
    risky = false,
    callback = function(v)
       autoRegularBox = v
        spawn(function()
            while autoRegularBox do
                game:GetService("ReplicatedStorage").MysteryBox:InvokeServer("Regular")
                wait(0.001)
            end
        end)
    end
})

Section2:AddToggle({
    text = "auto unreal boxes",
    state = false,
    risky = true,
    tooltip = "auto opens unreal boxes!",
    flag = "Toggle_2",
    risky = false,
    callback = function(v)
       autoUnrealBox = v
        spawn(function()
            while autoUnrealBox do
                game:GetService("ReplicatedStorage").MysteryBox:InvokeServer("Unreal")
                wait(0.001)
            end
        end)
    end
})

Section2:AddToggle({
    text = "auto inferno boxes",
    state = false,
    risky = true,
    tooltip = "auto opens inferno boxes!",
    flag = "Toggle_3",
    risky = false,
    callback = function(v)
      autoInfernoBox = v
        spawn(function()
            while autoInfernoBox do
                game:GetService("ReplicatedStorage").MysteryBox:InvokeServer("Inferno")
                wait(0.001)
            end
        end)
    end
})

Section2:AddToggle({
    text = "auto pulse",
    state = false,
    risky = true,
    tooltip = "auto pulses ores! (works best with stardust pulsar's.)",
    flag = "Toggle_4",
    risky = false,
    callback = function(v)
      autoPulse = v
        spawn(function()
            while autoPulse do
                game:GetService("ReplicatedStorage").Pulse:FireServer()
                wait(0.001)
            end
        end)
    end
})

Section2:AddToggle({
    text = "auto rebirth",
    state = false,
    risky = true,
    tooltip = "auto-rebirth's based on $ requirement's",
    flag = "Toggle_5",
    risky = false,
    callback = function(v)
      autoRebirth = v
        spawn(function()
            while autoRebirth do
                game:GetService("ReplicatedStorage").Rebirth:InvokeServer(26)
                wait(0.001)
            end
        end)
    end
})

Section2:AddToggle({
    text = "box teleportation",
    state = false,
    risky = true,
    tooltip = "teleports to every box spawned currently",
    flag = "Toggle_6",
    risky = false,
    callback = function(v)
        autoTeleport = v -- Update toggle state

        local player = game.Players.LocalPlayer
        local character = player.Character

        if character and character:FindFirstChild("HumanoidRootPart") then
            if v then
                teleportLoop()
            end
        end
    end
})

local Time = (string.format("%."..tostring(Decimals).."f", os.clock() - Clock))
library:SendNotification(("Loaded In "..tostring(Time)), 6)

--[[
    --Window1:SetOpen(false)
    makefolder("Title Here")
    library:SetTheme(Default)
    library:GetConfig(Default)
    library:LoadConfig(Default)
    library:SaveConfig(Default)
]]

-- Teleport Loop Function
-- Layout Toggles
function startLayoutLoop(layoutName, runningVariable)
    spawn(function()
        while _G[runningVariable] do
            game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", layoutName)
            wait(0.001)
        end
    end)
end

function teleportLoop()
    local player = game.Players.LocalPlayer
    local character = player.Character

    if character and character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = character.HumanoidRootPart
        local originalPosition = humanoidRootPart.CFrame -- Store original position

        while autoTeleport do -- Only run if the toggle is ON
            task.wait(0.001) -- Fast teleporting

            local boxesFolder = game.Workspace:FindFirstChild("Boxes") -- Locate the boxes
            local hasBoxes = false -- Flag to check if any boxes exist

            if boxesFolder and #boxesFolder:GetChildren() > 0 then
                for _, box in pairs(boxesFolder:GetChildren()) do
                    if not autoTeleport then return end -- Stop if toggle is turned off
                    if box:IsA("Part") or box:IsA("MeshPart") then
                        hasBoxes = true -- At least one box exists
                        -- Move the player directly onto the box (touching it)
                        humanoidRootPart.CFrame = box.CFrame + Vector3.new(0, humanoidRootPart.Size.Y / 2, 0)
                        task.wait(0.05) -- Small delay to ensure touch
                    end
                end
            end

            -- If no boxes are found, loop teleport to the original position
            if not hasBoxes then
                while autoTeleport and (not boxesFolder or #boxesFolder:GetChildren() == 0) do
                    humanoidRootPart.CFrame = originalPosition -- Continuously teleport to the original position
                    task.wait(0.1) -- Prevents excessive looping
                end
            end
        end
    end
end
