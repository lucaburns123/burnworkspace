-- burnscript! | v1.193 | miners haven

-- definitions!


local Decimals = 4
local Clock = os.clock()
local ValueText = "Value Is Now :"

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Roblox-UI-Libs/main/1%20Tokyo%20Lib%20(FIXED)/Tokyo%20Lib%20Source.lua"))({
    cheatname = "burnscript!", -- watermark text
    gamename = "miners haven", -- watermark text
})

-- Function to load a layout (prevents unnecessary reloads)
local function loadLayout(layoutName)
    if lastLoadedLayout ~= layoutName then
        game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", layoutName)
        lastLoadedLayout = layoutName
    end
end

-- definitions!



-- Auto Layout Switching Loop (Loops Layout 1, Loads Layout 2 Once)
local function layoutSwitchLoop12()
    spawn(function()
        local loadedLayout2 = false
        while autoLayoutSwitch12 do
            local moneyValue = game:GetService("Players").LocalPlayer.PlayerGui.GUI.Money.Value
            if moneyValue >= layoutSwitchThreshold then
                if not loadedLayout2 then
                    game:GetService("ReplicatedStorage").DestroyAll:InvokeServer()
                    game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", "Layout2")
                    loadedLayout2 = true
                end
            else
                game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", "Layout1")
                loadedLayout2 = false
            end
            wait(0.001)
        end
    end)
end

-- Auto Layout Switching Loop (Loops Layout 1, Loads Layout 3 Once)
local function layoutSwitchLoop13()
    spawn(function()
        local loadedLayout3 = false
        while autoLayoutSwitch13 do
            local moneyValue = game:GetService("Players").LocalPlayer.PlayerGui.GUI.Money.Value
            if moneyValue >= layoutSwitchThreshold then
                if not loadedLayout3 then
                    game:GetService("ReplicatedStorage").DestroyAll:InvokeServer()
                    game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", "Layout3")
                    loadedLayout3 = true
                end
            else
                game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", "Layout1")
                loadedLayout3 = false
            end
            wait(0.001)
        end
    end)
end

-- Dropdown for Auto Layout Switch Threshold
local thresholdOptions = {
    "1K (thousand)", "1M (million)", "1B (billion)", "1T (trillion)", "1qd (quadrillion)", "1Qn (quintillion)",
    "1sx (sextillion)", "1Sp (septillion)", "1O (octillion)", "1N (nonillion)", "1de (decillion)", "1Ud (undecillion)",
    "1DD (duodecillion)", "1tdD (tredecillion)", "1qdD (quattuordecillion)", "1QnD (quindecillion)", "1sxD (sedecillion)", "1SpD (septendecillion)"
}

local thresholdValues = {
    ["1K (thousand)"] = 1e3,
    ["1M (million)"] = 1e6,
    ["1B (billion)"] = 1e9,
    ["1T (trillion)"] = 1e12,
    ["1qd (quadrillion)"] = 1e15,
    ["1Qn (quintillion)"] = 1e18,
    ["1sx (sextillion)"] = 1e21,
    ["1Sp (septillion)"] = 1e24,
    ["1O (octillion)"] = 1e27,
    ["1N (nonillion)"] = 1e30,
    ["1de (decillion)"] = 1e33,
    ["1Ud (undecillion)"] = 1e36,
    ["1DD (duodecillion)"] = 1e39,
    ["1tdD (tredecillion)"] = 1e42,
    ["1qdD (quattuordecillion)"] = 1e45,
    ["1QnD (quindecillion)"] = 1e48,
    ["1sxD (sedecillion)"] = 1e51,
    ["1SpD (septendecillion)"] = 1e54,
}

library:init()

local Window1  = library.NewWindow({
    title = "burn.script! | miners haven", -- Mainwindow Text
    size = UDim2.new(0, 510, 0.6, 6
)})

local Tab1 = Window1:AddTab("  main  ")
local Tab2 = Window1:AddTab("  misc  ")
local SettingsTab = library:CreateSettingsTab(Window1)

--Tab1:SetText("Text")

local Section1 = Tab1:AddSection("layout switch", 1)

local Section2 = Tab1:AddSection("helpers", 2)



Section1:AddList({
    enabled = true,
    text = "auto switch value minimum", 
    tooltip = "select layout switch minimum (cash value to auto-switch)",
    selected = "",
    multi = false,
    open = false,
    max = 18,
    values = thresholdOptions,
    risky = false,
    callback = function(v)
        layoutSwitchThreshold = thresholdValues[v] or 1e3
    end
})

Section1:AddToggle({
    text = "auto layout switch (1-2)",
    state = false,
    risky = true,
    tooltip = "auto opens regular boxes!",
    flag = "Toggle_1",
    risky = false,
    callback = function(v)
        autoLayoutSwitch12 = v
        if v then
            layoutSwitchLoop12()
        end
    end
})

Section1:AddToggle({
    text = "auto layout switch (1-3)",
    state = false,
    risky = true,
    tooltip = "auto opens regular boxes!",
    flag = "Toggle_1",
    risky = false,
    callback = function(v)
        autoLayoutSwitch13 = v
        if v then
            layoutSwitchLoop13()
        end
    end
})

-- Layout Toggles
local function startLayoutLoop(layoutName, runningVariable)
    spawn(function()
        while _G[runningVariable] do
            game:GetService("ReplicatedStorage").Layouts:InvokeServer("Load", layoutName)
            wait(0.001)
        end
    end)
end

Section1:AddButton({
    enabled = true,
    text = "layout 1 (broken)",
    tooltip = "forcibly switches your layout to layout 1",
    confirm = true,
    risky = false,
    callback = function()
        startLayoutLoop("Layout1", "runningLayout1")
    end
})

Section1:AddButton({
    enabled = true,
    text = "layout 2 (broken)",
    tooltip = "forcibly switches your layout to layout 2",
    confirm = true,
    risky = false,
    callback = function()
        startLayoutLoop("Layout1", "runningLayout1")
    end
})

Section1:AddButton({
    enabled = true,
    text = "layout 3 (broken)",
    tooltip = "forcibly switches your layout to layout 3",
    confirm = true,
    risky = false,
    callback = function()
        startLayoutLoop("Layout1", "runningLayout1")
    end
})


Section2:AddButton({
    enabled = true,
    text = "auto free daily crate",
    tooltip = "auto-obtains daily crate from the shop",
    confirm = true,
    risky = false,
    callback = function()
        firesignal(game:GetService("Players").LocalPlayer.PlayerGui.GUI.SpookMcDookShop.RedeemFrame.MouseButton1Click)
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



local Section1misc = Tab2:AddSection("teleports", 1)
local Section2misc = Tab2:AddSection("attributes", 2)
local Section3misc = Tab2:AddSection("quick menu", 3)
local Section4misc = Tab2:AddSection("exploits", 4)

Section1misc:AddButton({
    enabled = true,
    text = "base",
    tooltip = "spawns player to base",
    confirm = true,
    risky = false,
    callback = function()
        main.toBase()
    end
})

Section1misc:AddButton({
    enabled = true,
    text = "docks",
    tooltip = "spawns player to docks",
    confirm = true,
    risky = false,
    callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(988,47,-19)
    end
})

Section1misc:AddButton({
    enabled = true,
    text = "bridge",
    tooltip = "spawns player to bridge",
    confirm = true,
    risky = false,
    callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-324,104,524)
    end
})

Section1misc:AddButton({
    enabled = true,
    text = "leaderboard",
    tooltip = "spawns player to leaderboard",
    confirm = true,
    risky = false,
    callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-67,179,328)
    end
})

Section2misc:AddSlider({
    enabled = true,
    text = "player walk speed",
    tooltip = "attempts to modify the walk speed",
    flag = "Slider_1",
    suffix = "",
    dragging = true,
    focused = false,
    min = 0,
    max = 100,
    increment = 0.1,
    risky = false,
    callback = function(v)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

Section2misc:AddSlider({
    enabled = true,
    text = "player jump power",
    tooltip = "attempts to modify the jump power",
    flag = "Slider_1",
    suffix = "",
    dragging = true,
    focused = false,
    min = 0,
    max = 100,
    increment = 0.1,
    risky = false,
    callback = function(v)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end
})

Section3misc:AddButton({
    enabled = true,
    text = "open crate shop",
    tooltip = "open's spookmcdook's shop (crate shop)",
    confirm = true,
    risky = false,
    callback = function()
        game.Players.LocalPlayer.PlayerGui.GUI.SpookMcDookShop.Visible = true;
    end
})

Section3misc:AddButton({
    enabled = true,
    text = "open st. patty's shop",
    tooltip = "open's st. patty's shop (not avaliable currently.)",
    confirm = true,
    risky = false,
    callback = function()
       game.Players.LocalPlayer.PlayerGui.GUI.Patrick.Visible = true;
    end
})

Section3misc:AddButton({
    enabled = true,
    text = "open craftsman shop",
    tooltip = "open's masked man's shop",
    confirm = true,
    risky = false,
    callback = function()
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Craftsman.Visible  = true;
    end
})

Section4misc:AddButton({
    enabled = true,
    text = "anti afk",
    tooltip = "attempts to keep the user's connected at all times",
    confirm = true,
    risky = false,
    callback = function()
        for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
        v:Disable()
        end
    end
})

Section4misc:AddButton({
    enabled = true,
    text = "performance boost",
    tooltip = "attempts to boost perfomance in various ways",
    confirm = true,
    risky = false,
    callback = function()

-- Remove Player Clothing  
for _, player in pairs(Players:GetPlayers()) do  
    if player.Character then  
        for _, obj in pairs(player.Character:GetChildren()) do  
            if obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("Accessory") then  
                obj:Destroy()  
            end  
        end  
    end  
end  

-- Remove Lighting Effects and Make Sky Black  
Lighting.GlobalShadows = false  
Lighting.FogEnd = 9e9  
Lighting.Brightness = 0  
Lighting.TimeOfDay = "00:00:00"  
if Lighting:FindFirstChildOfClass("Sky") then  
    Lighting:FindFirstChildOfClass("Sky"):Destroy()  
end  


optimizeGame()
          
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
