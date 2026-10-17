
--[[
    ALLWISH SUPER POWERS
    Animated UI Prototype
    Roblox Lua / LocalScript
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove previous interface
local old = playerGui:FindFirstChild("AllWishMenu")
if old then
    old:Destroy()
end

-- State
local powers = {
    SuperStrength = false,
    AntiGrab = false,
    SuperThrow = false,
    SuperJump = false
}

local function tween(object, duration, properties)
    local animation = TweenService:Create(
        object,
        TweenInfo.new(
            duration,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    )
    animation:Play()
    return animation
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "AllWishMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(0, 0)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18, 20, 32)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0, 16)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 90, 255)
stroke.Thickness = 2
stroke.Parent = main

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(
        0, Color3.fromRGB(25, 28, 48)
    ),
    ColorSequenceKeypoint.new(
        1, Color3.fromRGB(13, 14, 24)
    )
})
gradient.Rotation = 35
gradient.Parent = main

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 58)
header.BackgroundColor3 = Color3.fromRGB(35, 34, 75)
header.BorderSizePixel = 0
header.Parent = main

Instance.new("UICorner", header).CornerRadius =
    UDim.new(0, 16)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.fromOffset(18, 0)
title.BackgroundTransparency = 1
title.Text = "✦ ALLWISH  /  POWERS"
title.TextColor3 = Color3.fromRGB(235, 235, 255)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(38, 38)
close.Position = UDim2.new(1, -47, 0, 10)
close.BackgroundColor3 = Color3.fromRGB(180, 55, 75)
close.Text = "×"
close.TextSize = 26
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.Parent = header

Instance.new("UICorner", close).CornerRadius =
    UDim.new(0, 10)

-- Content
local content = Instance.new("ScrollingFrame")
content.Position = UDim2.fromOffset(12, 70)
content.Size = UDim2.new(1, -24, 1, -82)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 =
    Color3.fromRGB(115, 100, 255)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

local function makeLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -4, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(165, 165, 195)
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content
    return label
end

local function makeToggle(name, description, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -4, 0, 66)
    button.BackgroundColor3 = Color3.fromRGB(35, 37, 57)
    button.Text = ""
    button.AutoButtonColor = false
    button.Parent = content

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 12)

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Position = UDim2.fromOffset(13, 8)
    nameLabel.Size = UDim2.new(1, -85, 0, 24)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(245, 245, 255)
    nameLabel.TextSize = 15
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = button

    local desc = Instance.new("TextLabel")
    desc.Position = UDim2.fromOffset(13, 34)
    desc.Size = UDim2.new(1, -85, 0, 20)
    desc.BackgroundTransparency = 1
    desc.Text = description
    desc.TextColor3 = Color3.fromRGB(155, 158, 185)
    desc.TextSize = 11
    desc.Font = Enum.Font.Gotham
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = button

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.fromOffset(42, 24)
    indicator.Position = UDim2.new(1, -54, 0.5, -12)
    indicator.BackgroundColor3 = Color3.fromRGB(70, 72, 92)
    indicator.Parent = button

    Instance.new("UICorner", indicator).CornerRadius =
        UDim.new(1, 0)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.fromOffset(18, 18)
    dot.Position = UDim2.fromOffset(3, 3)
    dot.BackgroundColor3 = Color3.new(1, 1, 1)
    dot.Parent = indicator

    Instance.new("UICorner", dot).CornerRadius =
        UDim.new(1, 0)

    local enabled = false

    button.MouseEnter:Connect(function()
        tween(button, 0.15, {
            BackgroundColor3 = Color3.fromRGB(48, 48, 76)
        })
    end)

    button.MouseLeave:Connect(function()
        tween(button, 0.15, {
            BackgroundColor3 = Color3.fromRGB(35, 37, 57)
        })
    end)

    button.Activated:Connect(function()
        enabled = not enabled

        tween(indicator, 0.2, {
            BackgroundColor3 = enabled
                and Color3.fromRGB(110, 90, 255)
                or Color3.fromRGB(70, 72, 92)
        })

        tween(dot, 0.2, {
            Position = enabled
                and UDim2.fromOffset(21, 3)
                or UDim2.fromOffset(3, 3)
        })

        powers[name] = enabled
        callback(enabled)
    end)

    return button
end

makeLabel("  SUPERHERO ABILITIES")

makeToggle(
    "SuperStrength",
    "Суперсила в твоей игре",
    function(enabled)
        print("SuperStrength:", enabled)
    end
)

makeToggle(
    "AntiGrab",
    "Защита от захвата в своей игре",
    function(enabled)
        print("AntiGrab:", enabled)
    end
)

makeToggle(
    "SuperThrow",
    "Сверхдальний бросок в своей игре",
    function(enabled)
        print("SuperThrow:", enabled)
    end
)

makeToggle(
    "SuperJump",
    "Высокий прыжок в своей игре",
    function(enabled)
        print("SuperJump:", enabled)
    end
)

makeLabel("  MENU SETTINGS")

local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(1, -4, 0, 45)
hideButton.BackgroundColor3 = Color3.fromRGB(65, 53, 125)
hideButton.Text = "Скрыть меню  [RIGHT SHIFT]"
hideButton.TextColor3 = Color3.new(1, 1, 1)
hideButton.TextSize = 13
hideButton.Font = Enum.Font.GothamBold
hideButton.Parent = content

Instance.new("UICorner", hideButton).CornerRadius =
    UDim.new(0, 10)

-- Drag window
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Open / close animation
local opened = true

local function setVisible(visible)
    opened = visible

    if visible then
        main.Visible = true
        tween(main, 0.3, {
            Size = UDim2.fromOffset(340, 430)
        })
    else
        tween(main, 0.25, {
            Size = UDim2.fromOffset(0, 0)
        })

        task.delay(0.26, function()
            if not opened then
                main.Visible = false
            end
        end)
    end
end

close.Activated:Connect(function()
    setVisible(false)
end)

hideButton.Activated:Connect(function()
    setVisible(false)
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end

    if input.KeyCode == Enum.KeyCode.RightShift then
        setVisible(not opened)
    end
end)

-- Intro
task.wait()
tween(main, 0.45, {
    Size = UDim2.fromOffset(340, 430)
})

print("ALLWISH POWERS UI loaded!")
