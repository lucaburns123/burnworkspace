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

local Section1 = Tab1:AddSection("layout-helpers", 1)

--Section1:SetText("Text")

Section1:AddButton({
    enabled = true,
    text = "layout-1",
    tooltip = "tooltip1",
    confirm = true,
    risky = false,
    callback = function(=)
            startLayoutLoop("Layout1", "runningLayout1")
    end
})


Section1:AddToggle({
    text = "box teleportation",
    state = false,
    risky = true,
    tooltip = "tooltip1",
    flag = "Toggle_1",
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

Section1:AddToggle({
    text = "Toggle1",
    state = false,
    risky = true,
    tooltip = "tooltip1",
    flag = "Toggle_1",
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
}):AddBind({
    enabled = true,
    text = "Keybind1",
    tooltip = "tooltip1",
    mode = "toggle",
    bind = "None",
    flag = "ToggleKey_1",
    state = false,
    nomouse = false,
    risky = false,
    noindicator = false,
    callback = function(v)
        print(ValueText, v)
    end,
    keycallback = function(v)
        print(ValueText, v)
    end
})

Section1:AddBox({
    enabled = true,
    name = "TextBox1",
    flag = "TextBox_1",
    input = "PlaceHolder1",
    focused = false,
    risky = false,
    callback = function(v)
        print(ValueText, v)
    end
})

--[[Section1:AddToggle({
    text = "Toggle1",
    flag = "Toggle_1",
    callback = function(v)
        print(ValueText, v)
    end
}):AddColor({
    text = "Color1",
    color = Color3.fromRGB(255, 255, 255),
    flag = "Color_1",
    callback = function(v)
        print(ValueText, v)
    end
})--]]

--[[Section1:AddBind({
    enabled = true,
    text = "Keybind1",
    tooltip = "tooltip1",
    mode = "toggle",
    bind = "None",
    flag = "ToggleKey_1",
    state = false,
    nomouse = false,
    risky = false,
    noindicator = false,
    callback = function(v)
        print(ValueText, v)
    end,
    keycallback = function(v)
        print(ValueText, v)
    end
})--]]

Section1:AddSeparator({
    enabled = true,
    text = "Separator1"
})

Section1:AddButton({
    enabled = true,
    text = "Button1",
    tooltip = "tooltip1",
    confirm = true,
    risky = false,
    callback = function()
        print("Pressed!")
    end
})

-- Button1:SetText("Text")

Section1:AddSlider({
    enabled = true,
    text = "Slider1",
    tooltip = "tooltip1",
    flag = "Slider_1",
    suffix = "",
    dragging = true,
    focused = false,
    min = 0,
    max = 100,
    increment = 0.1,
    risky = false,
    callback = function(v)
        print(ValueText, v)
    end
})

--Slider_1:SetValue(100)

Section1:AddList({
    enabled = true,
    text = "Selection", 
    tooltip = "tooltip1",
    selected = "",
    multi = false,
    open = false,
    max = 4,
    values = {"1", "2", "3"},
    risky = false,
    callback = function(v)
        print(ValueText, v)
    end
})

Section1:AddColor({
    enabled = true,
    text = "Color1",
    tooltip = "tooltip1",
    color = Color3.fromRGB(255, 255, 255),
    flag = "Color_1",
    trans = 0,
    open = false,
    risky = false,
    callback = function(v)
        print(ValueText, v)
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
-- DEFINITIONS

-- Layout Toggles
local function startLayoutLoop(layoutName, runningVariable)
    spawn(function()
        while _G[runningVariable] do
            game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", layoutName)
            wait(0.001)
        end
    end)
end

-- Teleport Loop Function
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
