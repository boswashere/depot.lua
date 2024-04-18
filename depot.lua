local player = game.Players.LocalPlayer
local autoEnabled = false -- Variable to track whether auto features are enabled
local guiEnabled = true -- Variable to track whether the GUI is enabled

-- Function to enable the features
local function enableFeatures()
    -- Enable the gamepasses that start with "2xD" or "2xC"
    local gamepasses = game:GetService("Players").LocalPlayer:WaitForChild("Info"):WaitForChild("Gamepasses"):GetChildren()
    for _, gamepass in ipairs(gamepasses) do
        if string.sub(gamepass.Name, 1, 3) == "Double D" or string.sub(gamepass.Name, 1, 3) == "Double C" then
            gamepass.Value = true
        elseif gamepass.Name == "auto" then
            gamepass.Value = true
        end
    end

    -- Loop through existing crates and set properties
    for i,p in pairs(game.Workspace:GetChildren()) do
        if p.Name == "Crate" then
            p.CanCollide = false
            p.Position = player.Character.HumanoidRootPart.Position
        end
    end

    -- Connect to the ChildAdded event to handle new crates
    game.Workspace.ChildAdded:Connect(function(child)
        if child.Name == "Crate" then
            child.CanCollide = false
            child.Position = player.Character.HumanoidRootPart.Position
        end
    end)

    -- Function to periodically update crate positions
    local function updateCratePositions()
        while wait(15) do
            for i,p in pairs(game.Workspace:GetChildren()) do
                if p.Name == "Crate" then
                    p.CanCollide = false
                    p.Position = player.Character.HumanoidRootPart.Position
                end
            end
        end
    end

    -- Start the update loop
    spawn(updateCratePositions)

    autoEnabled = true
end

-- Function to disable the features
local function disableFeatures()
    -- Stop updating crate positions
    -- The ChildAdded event connection will automatically be removed

    autoEnabled = false
end

-- Function to toggle GUI visibility
local function toggleGUIVisibility()
    if guiEnabled then
        gui.Enabled = false
    else
        gui.Enabled = true
    end
    guiEnabled = not guiEnabled
end

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create draggable frame
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0.2, 0, 0.2, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.new(1, 1, 1)
frame.BorderSizePixel = 0
frame.Active = true -- Make the frame able to capture touch input

-- Variable to store the initial touch position when dragging starts
local initialTouchPos = nil

-- Function to handle touch input for dragging
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        initialTouchPos = input.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        initialTouchPos = nil
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and initialTouchPos then
        local delta = input.Position - initialTouchPos
        frame.Position = frame.Position + UDim2.new(0, delta.X, 0, delta.Y)
        initialTouchPos = input.Position
    end
end)

-- Create enable button
local enableButton = Instance.new("TextButton")
enableButton.Parent = frame
enableButton.Position = UDim2.new(0.1, 0, 0.1, 0)
enableButton.Size = UDim2.new(0.8, 0, 0.2, 0)
enableButton.Text = "Enable Features"
enableButton.MouseButton1Click:Connect(function()
    if not autoEnabled then
        enableFeatures()
    end
end)

-- Create disable button
local disableButton = Instance.new("TextButton")
disableButton.Parent = frame
disableButton.Position = UDim2.new(0.1, 0, 0.4, 0)
disableButton.Size = UDim2.new(0.8, 0, 0.2, 0)
disableButton.Text = "Disable Features"
disableButton.MouseButton1Click:Connect(function()
    if autoEnabled then
        disableFeatures()
    end
end)

-- Create toggle GUI visibility button
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = frame
toggleButton.Position = UDim2.new(0.1, 0, 0.7, 0)
toggleButton.Size = UDim2.new(0.8, 0, 0.2, 0)
toggleButton.Text = "Toggle GUI Visibility"
toggleButton.MouseButton1Click:Connect(toggleGUIVisibility)
