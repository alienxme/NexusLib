--[[
    ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗
    ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝
    ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗
    ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║
    ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║
    ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝

    Nexus UI Library v1.0.0
    A modern, lightweight Roblox UI Library
    Inspired by Kavo & Rayfield
    
    Usage:
        local Nexus = loadstring(game:HttpGet("YOUR_RAW_URL"))()
        local Window = Nexus:CreateWindow({ Title = "My Script", Theme = "Dark" })
        local Tab    = Window:NewTab("Main")
        local Sec    = Tab:NewSection("Settings")
        Sec:NewButton({ Name = "Click Me", Callback = function() print("clicked") end })
--]]

-- ─────────────────────────────────────────────────────────────────────────────
-- Services
-- ─────────────────────────────────────────────────────────────────────────────
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui          = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- ─────────────────────────────────────────────────────────────────────────────
-- Themes
-- ─────────────────────────────────────────────────────────────────────────────
local Themes = {
    Dark = {
        WindowBG      = Color3.fromRGB(18, 18, 24),
        TitleBar      = Color3.fromRGB(25, 25, 35),
        TabBar        = Color3.fromRGB(22, 22, 30),
        TabSelected   = Color3.fromRGB(90, 90, 200),
        TabUnselected = Color3.fromRGB(35, 35, 50),
        SectionBG     = Color3.fromRGB(28, 28, 40),
        SectionHeader = Color3.fromRGB(60, 60, 90),
        ElementBG     = Color3.fromRGB(35, 35, 52),
        ElementHover  = Color3.fromRGB(50, 50, 70),
        Accent        = Color3.fromRGB(100, 100, 230),
        AccentHover   = Color3.fromRGB(120, 120, 255),
        TextPrimary   = Color3.fromRGB(240, 240, 255),
        TextSecondary = Color3.fromRGB(160, 160, 185),
        TextMuted     = Color3.fromRGB(100, 100, 130),
        ToggleOff     = Color3.fromRGB(60, 60, 80),
        ToggleOn      = Color3.fromRGB(90, 200, 130),
        SliderFill    = Color3.fromRGB(100, 100, 230),
        SliderTrack   = Color3.fromRGB(50, 50, 70),
        Border        = Color3.fromRGB(55, 55, 80),
        CloseBtn      = Color3.fromRGB(220, 80, 80),
        MinBtn        = Color3.fromRGB(220, 180, 60),
        ScrollBar     = Color3.fromRGB(60, 60, 90),
        DropdownBG    = Color3.fromRGB(30, 30, 46),
        Notification  = Color3.fromRGB(25, 25, 38),
    },
    Light = {
        WindowBG      = Color3.fromRGB(245, 245, 250),
        TitleBar      = Color3.fromRGB(230, 230, 240),
        TabBar        = Color3.fromRGB(235, 235, 245),
        TabSelected   = Color3.fromRGB(80, 80, 200),
        TabUnselected = Color3.fromRGB(210, 210, 230),
        SectionBG     = Color3.fromRGB(250, 250, 255),
        SectionHeader = Color3.fromRGB(200, 200, 220),
        ElementBG     = Color3.fromRGB(240, 240, 252),
        ElementHover  = Color3.fromRGB(220, 220, 245),
        Accent        = Color3.fromRGB(80, 80, 210),
        AccentHover   = Color3.fromRGB(100, 100, 230),
        TextPrimary   = Color3.fromRGB(20, 20, 40),
        TextSecondary = Color3.fromRGB(80, 80, 110),
        TextMuted     = Color3.fromRGB(140, 140, 170),
        ToggleOff     = Color3.fromRGB(180, 180, 200),
        ToggleOn      = Color3.fromRGB(60, 190, 110),
        SliderFill    = Color3.fromRGB(80, 80, 210),
        SliderTrack   = Color3.fromRGB(200, 200, 220),
        Border        = Color3.fromRGB(190, 190, 215),
        CloseBtn      = Color3.fromRGB(210, 60, 60),
        MinBtn        = Color3.fromRGB(210, 170, 40),
        ScrollBar     = Color3.fromRGB(160, 160, 200),
        DropdownBG    = Color3.fromRGB(235, 235, 250),
        Notification  = Color3.fromRGB(240, 240, 255),
    },
    Midnight = {
        WindowBG      = Color3.fromRGB(8, 8, 16),
        TitleBar      = Color3.fromRGB(12, 12, 24),
        TabBar        = Color3.fromRGB(10, 10, 20),
        TabSelected   = Color3.fromRGB(140, 60, 220),
        TabUnselected = Color3.fromRGB(25, 25, 45),
        SectionBG     = Color3.fromRGB(14, 14, 28),
        SectionHeader = Color3.fromRGB(40, 20, 80),
        ElementBG     = Color3.fromRGB(20, 20, 38),
        ElementHover  = Color3.fromRGB(35, 20, 65),
        Accent        = Color3.fromRGB(150, 70, 240),
        AccentHover   = Color3.fromRGB(170, 90, 255),
        TextPrimary   = Color3.fromRGB(230, 220, 255),
        TextSecondary = Color3.fromRGB(160, 140, 200),
        TextMuted     = Color3.fromRGB(90, 75, 130),
        ToggleOff     = Color3.fromRGB(40, 30, 70),
        ToggleOn      = Color3.fromRGB(140, 60, 220),
        SliderFill    = Color3.fromRGB(150, 70, 240),
        SliderTrack   = Color3.fromRGB(35, 25, 65),
        Border        = Color3.fromRGB(45, 30, 90),
        CloseBtn      = Color3.fromRGB(200, 60, 80),
        MinBtn        = Color3.fromRGB(200, 160, 50),
        ScrollBar     = Color3.fromRGB(50, 35, 100),
        DropdownBG    = Color3.fromRGB(16, 12, 32),
        Notification  = Color3.fromRGB(14, 10, 28),
    },
    Crimson = {
        WindowBG      = Color3.fromRGB(18, 10, 10),
        TitleBar      = Color3.fromRGB(28, 12, 12),
        TabBar        = Color3.fromRGB(22, 10, 10),
        TabSelected   = Color3.fromRGB(200, 40, 60),
        TabUnselected = Color3.fromRGB(45, 18, 18),
        SectionBG     = Color3.fromRGB(26, 12, 12),
        SectionHeader = Color3.fromRGB(80, 20, 25),
        ElementBG     = Color3.fromRGB(38, 16, 16),
        ElementHover  = Color3.fromRGB(60, 22, 22),
        Accent        = Color3.fromRGB(220, 50, 70),
        AccentHover   = Color3.fromRGB(240, 70, 90),
        TextPrimary   = Color3.fromRGB(255, 230, 230),
        TextSecondary = Color3.fromRGB(200, 155, 155),
        TextMuted     = Color3.fromRGB(130, 90, 90),
        ToggleOff     = Color3.fromRGB(60, 25, 25),
        ToggleOn      = Color3.fromRGB(220, 50, 70),
        SliderFill    = Color3.fromRGB(220, 50, 70),
        SliderTrack   = Color3.fromRGB(60, 25, 25),
        Border        = Color3.fromRGB(70, 28, 28),
        CloseBtn      = Color3.fromRGB(220, 50, 70),
        MinBtn        = Color3.fromRGB(210, 170, 50),
        ScrollBar     = Color3.fromRGB(80, 30, 30),
        DropdownBG    = Color3.fromRGB(22, 10, 10),
        Notification  = Color3.fromRGB(24, 10, 12),
    },
    Ocean = {
        WindowBG      = Color3.fromRGB(8, 18, 30),
        TitleBar      = Color3.fromRGB(10, 24, 40),
        TabBar        = Color3.fromRGB(9, 20, 34),
        TabSelected   = Color3.fromRGB(30, 140, 200),
        TabUnselected = Color3.fromRGB(18, 40, 65),
        SectionBG     = Color3.fromRGB(10, 22, 36),
        SectionHeader = Color3.fromRGB(15, 55, 90),
        ElementBG     = Color3.fromRGB(14, 30, 50),
        ElementHover  = Color3.fromRGB(20, 48, 80),
        Accent        = Color3.fromRGB(40, 160, 220),
        AccentHover   = Color3.fromRGB(60, 180, 240),
        TextPrimary   = Color3.fromRGB(210, 240, 255),
        TextSecondary = Color3.fromRGB(130, 185, 220),
        TextMuted     = Color3.fromRGB(70, 120, 160),
        ToggleOff     = Color3.fromRGB(20, 50, 80),
        ToggleOn      = Color3.fromRGB(30, 180, 200),
        SliderFill    = Color3.fromRGB(40, 160, 220),
        SliderTrack   = Color3.fromRGB(20, 50, 85),
        Border        = Color3.fromRGB(25, 65, 110),
        CloseBtn      = Color3.fromRGB(200, 70, 80),
        MinBtn        = Color3.fromRGB(200, 175, 50),
        ScrollBar     = Color3.fromRGB(25, 70, 120),
        DropdownBG    = Color3.fromRGB(9, 20, 34),
        Notification  = Color3.fromRGB(10, 22, 38),
    },
}

-- ─────────────────────────────────────────────────────────────────────────────
-- Utility Helpers
-- ─────────────────────────────────────────────────────────────────────────────
local function Tween(obj, props, t, style, dir)
    local info = TweenInfo.new(t or 0.15, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
    local tw   = TweenService:Create(obj, info, props)
    tw:Play()
    return tw
end

local function MakeCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 6)
    c.Parent = parent
end

local function MakeStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
end

local function MakePadding(parent, top, bottom, left, right)
    local p = Instance.new("UIPadding")
    p.PaddingTop    = UDim.new(0, top    or 4)
    p.PaddingBottom = UDim.new(0, bottom or 4)
    p.PaddingLeft   = UDim.new(0, left   or 8)
    p.PaddingRight  = UDim.new(0, right  or 8)
    p.Parent = parent
end

local function MakeLabel(parent, text, size, color, font, xAlign)
    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Text = text or ""
    lbl.TextSize = size or 13
    lbl.TextColor3 = color or Color3.new(1,1,1)
    lbl.Font = font or Enum.Font.GothamMedium
    lbl.TextXAlignment = xAlign or Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.RichText = true
    lbl.Parent = parent
    return lbl
end

local function HoverEffect(frame, normalColor, hoverColor, property)
    property = property or "BackgroundColor3"
    frame.MouseEnter:Connect(function()
        Tween(frame, {[property] = hoverColor}, 0.12)
    end)
    frame.MouseLeave:Connect(function()
        Tween(frame, {[property] = normalColor}, 0.12)
    end)
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Dragging
-- ─────────────────────────────────────────────────────────────────────────────
local function MakeDraggable(dragHandle, mainFrame)
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = input.Position
            startPos  = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Notification System (standalone, top-right)
-- ─────────────────────────────────────────────────────────────────────────────
local NexusLib = {}
NexusLib.Flags  = {}
NexusLib._theme = Themes.Dark

local NotifGui, NotifHolder

local function EnsureNotifGui()
    if NotifGui and NotifGui.Parent then return end
    NotifGui = Instance.new("ScreenGui")
    NotifGui.Name             = "NexusNotifications"
    NotifGui.ResetOnSpawn     = false
    NotifGui.IgnoreGuiInset   = true
    NotifGui.ZIndexBehavior   = Enum.ZIndexBehavior.Sibling
    NotifGui.DisplayOrder     = 999
    pcall(function() NotifGui.Parent = CoreGui end)
    if not NotifGui.Parent then NotifGui.Parent = LocalPlayer.PlayerGui end

    NotifHolder = Instance.new("Frame")
    NotifHolder.Name                  = "Holder"
    NotifHolder.BackgroundTransparency = 1
    NotifHolder.AnchorPoint           = Vector2.new(1, 1)
    NotifHolder.Position              = UDim2.new(1, -16, 1, -16)
    NotifHolder.Size                  = UDim2.new(0, 300, 1, -32)
    NotifHolder.Parent                = NotifGui

    local layout = Instance.new("UIListLayout")
    layout.SortOrder        = Enum.SortOrder.LayoutOrder
    layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    layout.Padding          = UDim.new(0, 8)
    layout.Parent           = NotifHolder
end

function NexusLib:Notify(opts)
    opts = opts or {}
    EnsureNotifGui()
    local T = self._theme

    local card = Instance.new("Frame")
    card.Name                  = "Notif"
    card.BackgroundColor3      = T.Notification
    card.BorderSizePixel       = 0
    card.Size                  = UDim2.new(1, 0, 0, 0)
    card.AutomaticSize         = Enum.AutomaticSize.Y
    card.BackgroundTransparency = 1
    card.Parent                = NotifHolder
    MakeCorner(card, 8)
    MakeStroke(card, T.Border, 1)

    local accentBar = Instance.new("Frame")
    accentBar.Name             = "Accent"
    accentBar.BackgroundColor3 = opts.AccentColor or T.Accent
    accentBar.BorderSizePixel  = 0
    accentBar.Size             = UDim2.new(0, 3, 1, 0)
    accentBar.Position         = UDim2.new(0, 0, 0, 0)
    accentBar.Parent           = card
    local acCorner = Instance.new("UICorner")
    acCorner.CornerRadius = UDim.new(0, 8)
    acCorner.Parent = accentBar

    local inner = Instance.new("Frame")
    inner.BackgroundTransparency = 1
    inner.Size                   = UDim2.new(1, -10, 1, 0)
    inner.Position               = UDim2.new(0, 10, 0, 0)
    inner.AutomaticSize          = Enum.AutomaticSize.Y
    inner.Parent                 = card
    MakePadding(inner, 10, 10, 6, 6)

    local layout2 = Instance.new("UIListLayout")
    layout2.SortOrder = Enum.SortOrder.LayoutOrder
    layout2.Padding   = UDim.new(0, 3)
    layout2.Parent    = inner

    if opts.Title then
        local titleLbl = MakeLabel(inner, opts.Title, 13, T.TextPrimary, Enum.Font.GothamBold)
        titleLbl.Size         = UDim2.new(1, 0, 0, 16)
        titleLbl.LayoutOrder  = 1
    end
    if opts.Description then
        local descLbl = MakeLabel(inner, opts.Description, 12, T.TextSecondary, Enum.Font.Gotham)
        descLbl.Size          = UDim2.new(1, 0, 0, 0)
        descLbl.AutomaticSize = Enum.AutomaticSize.Y
        descLbl.LayoutOrder   = 2
    end

    -- Slide in
    Tween(card, {BackgroundTransparency = 0}, 0.2)
    Tween(accentBar, {BackgroundTransparency = 0}, 0.2)

    local duration = opts.Duration or 4
    task.delay(duration, function()
        Tween(card, {BackgroundTransparency = 1}, 0.3)
        task.wait(0.35)
        card:Destroy()
    end)
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Section Builder
-- ─────────────────────────────────────────────────────────────────────────────
local Section = {}
Section.__index = Section

function Section.new(parent, name, T)
    local self = setmetatable({}, Section)
    self._theme = T

    -- Container
    local container = Instance.new("Frame")
    container.Name              = "Section_" .. name
    container.BackgroundColor3  = T.SectionBG
    container.BorderSizePixel   = 0
    container.Size              = UDim2.new(1, -16, 0, 0)
    container.AutomaticSize     = Enum.AutomaticSize.Y
    container.Parent            = parent
    MakeCorner(container, 8)
    MakeStroke(container, T.Border, 1)

    local vLayout = Instance.new("UIListLayout")
    vLayout.SortOrder = Enum.SortOrder.LayoutOrder
    vLayout.Padding   = UDim.new(0, 0)
    vLayout.Parent    = container

    -- Header
    local header = Instance.new("Frame")
    header.Name             = "Header"
    header.BackgroundColor3 = T.SectionHeader
    header.BorderSizePixel  = 0
    header.Size             = UDim2.new(1, 0, 0, 30)
    header.LayoutOrder      = 0
    header.Parent           = container
    MakeCorner(header, 6)
    MakePadding(header, 0, 0, 10, 10)

    local headerLbl = MakeLabel(header, name, 12, T.TextSecondary, Enum.Font.GothamBold)
    headerLbl.Size              = UDim2.new(1, 0, 1, 0)
    headerLbl.TextXAlignment    = Enum.TextXAlignment.Left
    headerLbl.TextTransparency  = 0

    -- Elements holder
    local elemHolder = Instance.new("Frame")
    elemHolder.Name             = "Elements"
    elemHolder.BackgroundTransparency = 1
    elemHolder.Size             = UDim2.new(1, 0, 0, 0)
    elemHolder.AutomaticSize    = Enum.AutomaticSize.Y
    elemHolder.LayoutOrder      = 1
    elemHolder.Parent           = container

    local elemLayout = Instance.new("UIListLayout")
    elemLayout.SortOrder = Enum.SortOrder.LayoutOrder
    elemLayout.Padding   = UDim.new(0, 1)
    elemLayout.Parent    = elemHolder

    MakePadding(elemHolder, 4, 6, 8, 8)

    self._container  = container
    self._header     = headerLbl
    self._elemHolder = elemHolder
    self._elemCount  = 0
    return self
end

function Section:UpdateSection(newTitle)
    self._header.Text = newTitle
end

-- ── Internal helper: create a row frame ──────────────────────────────────────
function Section:_MakeRow(height)
    self._elemCount += 1
    local row = Instance.new("Frame")
    row.Name                    = "Row" .. self._elemCount
    row.BackgroundColor3        = self._theme.ElementBG
    row.BorderSizePixel         = 0
    row.Size                    = UDim2.new(1, 0, 0, height or 36)
    row.LayoutOrder             = self._elemCount
    row.Parent                  = self._elemHolder
    MakeCorner(row, 5)
    return row
end

-- ─────────────────────────────────────────────────────────────────────────────
-- LABEL
-- ─────────────────────────────────────────────────────────────────────────────
function Section:NewLabel(opts)
    if type(opts) == "string" then opts = { Name = opts } end
    opts = opts or {}
    local T = self._theme

    local row = self:_MakeRow(30)
    row.BackgroundTransparency = 1
    MakePadding(row, 0, 0, 6, 6)

    local lbl = MakeLabel(row, opts.Name or "", 12, opts.Color or T.TextMuted, Enum.Font.Gotham)
    lbl.Size = UDim2.new(1, 0, 1, 0)

    local ctrl = {}
    function ctrl:Set(text) lbl.Text = text end
    -- legacy alias
    function ctrl:UpdateLabel(text) lbl.Text = text end
    return ctrl
end

-- ─────────────────────────────────────────────────────────────────────────────
-- BUTTON
-- ─────────────────────────────────────────────────────────────────────────────
function Section:NewButton(opts)
    if type(opts) == "string" then
        opts = { Name = opts, Callback = select(2, ...) }
    end
    opts = opts or {}
    local T = self._theme

    local row = self:_MakeRow(38)
    MakePadding(row, 0, 0, 10, 10)
    HoverEffect(row, T.ElementBG, T.ElementHover)

    local nameLbl = MakeLabel(row, opts.Name or "Button", 13, T.TextPrimary, Enum.Font.GothamMedium)
    nameLbl.Size                = UDim2.new(0.65, 0, 1, 0)
    nameLbl.Position            = UDim2.new(0, 0, 0, 0)

    if opts.Description then
        local descLbl = MakeLabel(row, opts.Description, 11, T.TextMuted, Enum.Font.Gotham)
        descLbl.Size             = UDim2.new(0.65, 0, 0.5, 0)
        descLbl.Position         = UDim2.new(0, 0, 0.5, 0)
        nameLbl.Size             = UDim2.new(0.65, 0, 0.5, 0)
        row.Size                 = UDim2.new(1, 0, 0, 46)
    end

    -- Action button on the right
    local btn = Instance.new("TextButton")
    btn.Name                    = "ActionBtn"
    btn.Text                    = "Run"
    btn.TextSize                = 12
    btn.Font                    = Enum.Font.GothamBold
    btn.TextColor3              = T.TextPrimary
    btn.BackgroundColor3        = T.Accent
    btn.BorderSizePixel         = 0
    btn.AnchorPoint             = Vector2.new(1, 0.5)
    btn.Position                = UDim2.new(1, 0, 0.5, 0)
    btn.Size                    = UDim2.new(0, 54, 0, 24)
    btn.Parent                  = row
    MakeCorner(btn, 5)

    btn.MouseButton1Click:Connect(function()
        Tween(btn, {BackgroundColor3 = T.AccentHover}, 0.08)
        task.delay(0.12, function()
            Tween(btn, {BackgroundColor3 = T.Accent}, 0.12)
        end)
        if opts.Callback then
            task.spawn(opts.Callback)
        end
    end)

    local ctrl = {}
    function ctrl:Set(text)
        nameLbl.Text = text
    end
    -- legacy alias
    function ctrl:UpdateButton(text)
        nameLbl.Text = text
    end
    return ctrl
end

-- ─────────────────────────────────────────────────────────────────────────────
-- TOGGLE
-- ─────────────────────────────────────────────────────────────────────────────
function Section:NewToggle(opts)
    if type(opts) == "string" then
        opts = { Name = opts, Callback = select(3, ...) }
    end
    opts = opts or {}
    local T    = self._theme
    local flag = opts.Flag
    local val  = opts.CurrentValue or false
    if flag then NexusLib.Flags[flag] = val end

    local row = self:_MakeRow(38)
    MakePadding(row, 0, 0, 10, 10)
    HoverEffect(row, T.ElementBG, T.ElementHover)

    local nameLbl = MakeLabel(row, opts.Name or "Toggle", 13, T.TextPrimary, Enum.Font.GothamMedium)
    nameLbl.Size     = UDim2.new(0.7, 0, 1, 0)

    -- Track
    local track = Instance.new("Frame")
    track.AnchorPoint      = Vector2.new(1, 0.5)
    track.Position         = UDim2.new(1, 0, 0.5, 0)
    track.Size             = UDim2.new(0, 40, 0, 20)
    track.BackgroundColor3 = val and T.ToggleOn or T.ToggleOff
    track.BorderSizePixel  = 0
    track.Parent           = row
    MakeCorner(track, 10)

    -- Knob
    local knob = Instance.new("Frame")
    knob.AnchorPoint      = Vector2.new(0, 0.5)
    knob.Position         = val and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
    knob.Size             = UDim2.new(0, 16, 0, 16)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    knob.BorderSizePixel  = 0
    knob.Parent           = track
    MakeCorner(knob, 8)

    local function SetToggle(state, silent)
        val = state
        if flag then NexusLib.Flags[flag] = val end
        Tween(track, {BackgroundColor3 = val and T.ToggleOn or T.ToggleOff}, 0.18)
        Tween(knob,  {Position = val and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)}, 0.18)
        if not silent and opts.Callback then
            task.spawn(opts.Callback, val)
        end
    end

    local btn = Instance.new("TextButton")
    btn.BackgroundTransparency = 1
    btn.Size                   = UDim2.new(1, 0, 1, 0)
    btn.Text                   = ""
    btn.Parent                 = row
    btn.ZIndex                 = 3
    btn.MouseButton1Click:Connect(function()
        SetToggle(not val)
    end)

    local ctrl = {}
    function ctrl:Set(state)
        SetToggle(state, true)
    end
    -- legacy alias
    function ctrl:UpdateToggle(state)
        if type(state) == "boolean" then
            SetToggle(state, true)
        end
    end
    ctrl.CurrentValue = val
    return ctrl
end

-- ─────────────────────────────────────────────────────────────────────────────
-- SLIDER
-- ─────────────────────────────────────────────────────────────────────────────
function Section:NewSlider(opts)
    if type(opts) == "string" then
        opts = { Name = opts }
    end
    opts = opts or {}
    local T     = self._theme
    local flag  = opts.Flag
    local range = opts.Range or {0, 100}
    local incr  = opts.Increment or 1
    local suf   = opts.Suffix or ""
    local cur   = opts.CurrentValue or range[1]
    if flag then NexusLib.Flags[flag] = cur end

    local row = self:_MakeRow(52)
    row.BackgroundColor3 = T.ElementBG
    MakePadding(row, 6, 6, 10, 10)

    local topRow = Instance.new("Frame")
    topRow.BackgroundTransparency = 1
    topRow.Size                   = UDim2.new(1, 0, 0, 18)
    topRow.Position               = UDim2.new(0, 0, 0, 0)
    topRow.Parent                 = row

    local nameLbl = MakeLabel(topRow, opts.Name or "Slider", 13, T.TextPrimary, Enum.Font.GothamMedium)
    nameLbl.Size = UDim2.new(0.7, 0, 1, 0)

    local valLbl = MakeLabel(topRow, tostring(cur) .. suf, 12, T.Accent, Enum.Font.GothamBold, Enum.TextXAlignment.Right)
    valLbl.Size     = UDim2.new(0.3, 0, 1, 0)
    valLbl.Position = UDim2.new(0.7, 0, 0, 0)

    -- Track
    local track = Instance.new("Frame")
    track.Name             = "Track"
    track.BackgroundColor3 = T.SliderTrack
    track.BorderSizePixel  = 0
    track.AnchorPoint      = Vector2.new(0, 0)
    track.Position         = UDim2.new(0, 0, 0, 26)
    track.Size             = UDim2.new(1, 0, 0, 6)
    track.Parent           = row
    MakeCorner(track, 3)

    local fill = Instance.new("Frame")
    fill.Name             = "Fill"
    fill.BackgroundColor3 = T.SliderFill
    fill.BorderSizePixel  = 0
    fill.Size             = UDim2.new((cur - range[1]) / (range[2] - range[1]), 0, 1, 0)
    fill.Parent           = track
    MakeCorner(fill, 3)

    -- Knob
    local knob = Instance.new("Frame")
    knob.Name             = "Knob"
    knob.BackgroundColor3 = Color3.new(1,1,1)
    knob.BorderSizePixel  = 0
    knob.AnchorPoint      = Vector2.new(0.5, 0.5)
    knob.Size             = UDim2.new(0, 14, 0, 14)
    knob.ZIndex           = 3
    local pct0 = (cur - range[1]) / (range[2] - range[1])
    knob.Position         = UDim2.new(pct0, 0, 0.5, 0)
    knob.Parent           = track
    MakeCorner(knob, 7)
    MakeStroke(knob, T.Accent, 2)

    local function UpdateValue(v)
        v = math.clamp(v, range[1], range[2])
        -- snap to increment
        v = math.round((v - range[1]) / incr) * incr + range[1]
        cur = v
        if flag then NexusLib.Flags[flag] = cur end
        local pct = (v - range[1]) / (range[2] - range[1])
        Tween(fill, {Size = UDim2.new(pct, 0, 1, 0)}, 0.05)
        Tween(knob, {Position = UDim2.new(pct, 0, 0.5, 0)}, 0.05)
        valLbl.Text = tostring(v) .. suf
        if opts.Callback then task.spawn(opts.Callback, v) end
    end

    local sliding = false
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local absPos  = track.AbsolutePosition.X
            local absSize = track.AbsoluteSize.X
            local pct     = math.clamp((input.Position.X - absPos) / absSize, 0, 1)
            local v       = range[1] + (range[2] - range[1]) * pct
            UpdateValue(v)
        end
    end)

    local ctrl = {}
    function ctrl:Set(v) UpdateValue(v) end
    ctrl.CurrentValue = cur
    return ctrl
end

-- ─────────────────────────────────────────────────────────────────────────────
-- TEXT INPUT
-- ─────────────────────────────────────────────────────────────────────────────
function Section:NewInput(opts)
    if type(opts) == "string" then
        opts = { Name = opts }
    end
    opts = opts or {}
    local T    = self._theme
    local flag = opts.Flag

    local row = self:_MakeRow(54)
    MakePadding(row, 6, 6, 10, 10)

    local nameLbl = MakeLabel(row, opts.Name or "Input", 13, T.TextPrimary, Enum.Font.GothamMedium)
    nameLbl.Size     = UDim2.new(1, 0, 0, 16)
    nameLbl.Position = UDim2.new(0, 0, 0, 0)

    local inputFrame = Instance.new("Frame")
    inputFrame.BackgroundColor3 = T.WindowBG
    inputFrame.BorderSizePixel  = 0
    inputFrame.Position         = UDim2.new(0, 0, 0, 22)
    inputFrame.Size             = UDim2.new(1, 0, 0, 26)
    inputFrame.Parent           = row
    MakeCorner(inputFrame, 5)
    MakeStroke(inputFrame, T.Border, 1)

    local box = Instance.new("TextBox")
    box.BackgroundTransparency  = 1
    box.Size                    = UDim2.new(1, -8, 1, 0)
    box.Position                = UDim2.new(0, 4, 0, 0)
    box.PlaceholderText         = opts.PlaceholderText or "Enter text..."
    box.PlaceholderColor3       = T.TextMuted
    box.TextColor3              = T.TextPrimary
    box.TextSize                = 12
    box.Font                    = Enum.Font.Gotham
    box.TextXAlignment          = Enum.TextXAlignment.Left
    box.ClearTextOnFocus        = false
    box.Text                    = opts.CurrentValue or ""
    box.Parent                  = inputFrame

    box.Focused:Connect(function()
        Tween(inputFrame, {}, 0.12)
        MakeStroke(inputFrame, T.Accent, 1)
    end)
    box.FocusLost:Connect(function(enter)
        MakeStroke(inputFrame, T.Border, 1)
        if flag then NexusLib.Flags[flag] = box.Text end
        if opts.Callback then task.spawn(opts.Callback, box.Text) end
        if opts.RemoveTextAfterFocusLost then box.Text = "" end
    end)

    local ctrl = {}
    function ctrl:Set(text)
        box.Text = text
        if flag then NexusLib.Flags[flag] = text end
    end
    ctrl.CurrentValue = box.Text
    return ctrl
end

-- Legacy alias used in Kavo-style scripts
Section.NewTextBox = Section.NewInput

-- ─────────────────────────────────────────────────────────────────────────────
-- DROPDOWN
-- ─────────────────────────────────────────────────────────────────────────────
function Section:NewDropdown(opts)
    if type(opts) == "string" then
        opts = { Name = opts }
    end
    opts = opts or {}
    local T       = self._theme
    local flag    = opts.Flag
    local options = opts.Options or {}
    local multi   = opts.MultipleOptions or false
    local selected = opts.CurrentOption or (multi and {} or options[1] or "")

    if flag then NexusLib.Flags[flag] = selected end

    local row = self:_MakeRow(38)
    row.ClipsDescendants = true
    MakePadding(row, 0, 0, 10, 10)

    local nameLbl = MakeLabel(row, opts.Name or "Dropdown", 13, T.TextPrimary, Enum.Font.GothamMedium)
    nameLbl.Size     = UDim2.new(0.55, 0, 1, 0)

    -- Display button
    local dispFrame = Instance.new("Frame")
    dispFrame.AnchorPoint      = Vector2.new(1, 0.5)
    dispFrame.Position         = UDim2.new(1, 0, 0.5, 0)
    dispFrame.Size             = UDim2.new(0, 140, 0, 26)
    dispFrame.BackgroundColor3 = T.DropdownBG
    dispFrame.BorderSizePixel  = 0
    dispFrame.Parent           = row
    MakeCorner(dispFrame, 5)
    MakeStroke(dispFrame, T.Border, 1)

    local function GetDisplayText()
        if multi then
            if #selected == 0 then return "None" end
            return table.concat(selected, ", ")
        else
            return tostring(selected)
        end
    end

    local dispLbl = MakeLabel(dispFrame, GetDisplayText(), 11, T.TextSecondary, Enum.Font.Gotham)
    dispLbl.Size                = UDim2.new(1, -22, 1, 0)
    dispLbl.Position            = UDim2.new(0, 6, 0, 0)
    dispLbl.TextTruncate        = Enum.TextTruncate.AtEnd

    local arrow = MakeLabel(dispFrame, "▾", 13, T.TextMuted, Enum.Font.GothamBold, Enum.TextXAlignment.Right)
    arrow.Size     = UDim2.new(0, 18, 1, 0)
    arrow.Position = UDim2.new(1, -20, 0, 0)

    -- Dropdown popup (rendered above/below, parented to section container)
    local isOpen    = false
    local popupFrame = nil

    local function ClosePopup()
        if popupFrame then
            Tween(popupFrame, {Size = UDim2.new(popupFrame.Size.X.Scale, popupFrame.Size.X.Offset, 0, 0)}, 0.15)
            task.delay(0.16, function()
                if popupFrame then popupFrame:Destroy() popupFrame = nil end
            end)
        end
        Tween(arrow, {Rotation = 0}, 0.15)
        isOpen = false
    end

    local function OpenPopup()
        if popupFrame then return end
        isOpen = true
        Tween(arrow, {Rotation = 180}, 0.15)

        local absPos  = dispFrame.AbsolutePosition
        local absSize = dispFrame.AbsoluteSize

        popupFrame = Instance.new("Frame")
        popupFrame.Name             = "DropdownPopup"
        popupFrame.BackgroundColor3 = T.DropdownBG
        popupFrame.BorderSizePixel  = 0
        popupFrame.ZIndex           = 20
        popupFrame.Size             = UDim2.new(0, absSize.X, 0, 0)
        popupFrame.Position         = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 2)
        MakeCorner(popupFrame, 6)
        MakeStroke(popupFrame, T.Border, 1)

        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel        = 0
        scrollFrame.Size                   = UDim2.new(1, 0, 1, 0)
        scrollFrame.ScrollBarThickness     = 3
        scrollFrame.ScrollBarImageColor3   = T.ScrollBar
        scrollFrame.CanvasSize             = UDim2.new(0, 0, 0, 0)
        scrollFrame.AutomaticCanvasSize    = Enum.AutomaticSize.Y
        scrollFrame.Parent                 = popupFrame

        local opLayout = Instance.new("UIListLayout")
        opLayout.SortOrder = Enum.SortOrder.LayoutOrder
        opLayout.Padding   = UDim.new(0, 1)
        opLayout.Parent    = scrollFrame
        MakePadding(scrollFrame, 4, 4, 4, 4)

        for i, opt in ipairs(options) do
            local opBtn = Instance.new("TextButton")
            opBtn.Name                 = "Option_" .. i
            opBtn.Text                 = ""
            opBtn.BackgroundColor3     = T.ElementBG
            opBtn.BorderSizePixel      = 0
            opBtn.Size                 = UDim2.new(1, 0, 0, 28)
            opBtn.ZIndex               = 21
            opBtn.LayoutOrder          = i
            opBtn.Parent               = scrollFrame
            MakeCorner(opBtn, 4)
            MakePadding(opBtn, 0, 0, 8, 8)

            local isSelected = multi and table.find(selected, opt) or (selected == opt)
            local optLbl = MakeLabel(opBtn, opt, 12,
                isSelected and T.Accent or T.TextSecondary, Enum.Font.Gotham)
            optLbl.Size   = UDim2.new(1, 0, 1, 0)
            optLbl.ZIndex = 22

            HoverEffect(opBtn, T.ElementBG, T.ElementHover)

            opBtn.MouseButton1Click:Connect(function()
                if multi then
                    local idx = table.find(selected, opt)
                    if idx then
                        table.remove(selected, idx)
                        optLbl.TextColor3 = T.TextSecondary
                    else
                        table.insert(selected, opt)
                        optLbl.TextColor3 = T.Accent
                    end
                    dispLbl.Text = GetDisplayText()
                    if flag then NexusLib.Flags[flag] = selected end
                    if opts.Callback then task.spawn(opts.Callback, selected) end
                else
                    selected = opt
                    dispLbl.Text = GetDisplayText()
                    if flag then NexusLib.Flags[flag] = selected end
                    if opts.Callback then task.spawn(opts.Callback, {opt}) end
                    ClosePopup()
                end
            end)
        end

        local maxH = math.min(#options * 29 + 8, 180)
        local gui = popupFrame
        -- Parent to the ScreenGui
        local sg = row:FindFirstAncestorWhichIsA("ScreenGui")
        if sg then gui.Parent = sg else gui.Parent = row.Parent end
        Tween(popupFrame, {Size = UDim2.new(0, absSize.X, 0, maxH)}, 0.18)
    end

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Size                   = UDim2.new(1, 0, 1, 0)
    toggleBtn.Text                   = ""
    toggleBtn.ZIndex                 = 5
    toggleBtn.Parent                 = dispFrame
    toggleBtn.MouseButton1Click:Connect(function()
        if isOpen then ClosePopup() else OpenPopup() end
    end)

    -- Close on outside click
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and isOpen then
            if popupFrame then
                local mPos = UserInputService:GetMouseLocation()
                local pAbs = popupFrame.AbsolutePosition
                local pSize = popupFrame.AbsoluteSize
                if mPos.X < pAbs.X or mPos.X > pAbs.X + pSize.X
                    or mPos.Y < pAbs.Y or mPos.Y > pAbs.Y + pSize.Y then
                    ClosePopup()
                end
            end
        end
    end)

    local ctrl = {}
    function ctrl:Set(option)
        if multi then
            selected = type(option) == "table" and option or {option}
        else
            selected = type(option) == "table" and option[1] or option
        end
        dispLbl.Text = GetDisplayText()
        if flag then NexusLib.Flags[flag] = selected end
        if opts.Callback then task.spawn(opts.Callback, multi and selected or {selected}) end
    end
    function ctrl:Refresh(newOptions)
        options = newOptions
        if not multi then
            selected = newOptions[1] or ""
            dispLbl.Text = GetDisplayText()
        end
        if isOpen then ClosePopup() end
    end
    ctrl.CurrentOption = selected
    return ctrl
end

-- ─────────────────────────────────────────────────────────────────────────────
-- COLOR PICKER
-- ─────────────────────────────────────────────────────────────────────────────
function Section:NewColorPicker(opts)
    if type(opts) == "string" then
        opts = { Name = opts }
    end
    opts = opts or {}
    local T     = self._theme
    local flag  = opts.Flag
    local color = opts.Color or Color3.fromRGB(255, 255, 255)
    if flag then NexusLib.Flags[flag] = color end

    local row = self:_MakeRow(38)
    MakePadding(row, 0, 0, 10, 10)
    HoverEffect(row, T.ElementBG, T.ElementHover)

    local nameLbl = MakeLabel(row, opts.Name or "Color Picker", 13, T.TextPrimary, Enum.Font.GothamMedium)
    nameLbl.Size = UDim2.new(0.65, 0, 1, 0)

    -- Color swatch
    local swatch = Instance.new("Frame")
    swatch.AnchorPoint      = Vector2.new(1, 0.5)
    swatch.Position         = UDim2.new(1, 0, 0.5, 0)
    swatch.Size             = UDim2.new(0, 55, 0, 22)
    swatch.BackgroundColor3 = color
    swatch.BorderSizePixel  = 0
    swatch.Parent           = row
    MakeCorner(swatch, 5)
    MakeStroke(swatch, T.Border, 1)

    local hexLbl = MakeLabel(swatch, "", 9, Color3.new(1,1,1), Enum.Font.GothamBold, Enum.TextXAlignment.Center)
    hexLbl.Size            = UDim2.new(1, 0, 1, 0)
    hexLbl.TextStrokeColor3 = Color3.new(0,0,0)
    hexLbl.TextStrokeTransparency = 0.5

    local function UpdateSwatch(c)
        color = c
        swatch.BackgroundColor3 = c
        -- Show hex
        local r = math.round(c.R * 255)
        local g = math.round(c.G * 255)
        local b = math.round(c.B * 255)
        hexLbl.Text = string.format("#%02X%02X%02X", r, g, b)
        if flag then NexusLib.Flags[flag] = color end
    end
    UpdateSwatch(color)

    -- Simple HSV picker popup
    local pickerOpen  = false
    local pickerFrame = nil

    local function ClosePicker()
        if pickerFrame then
            Tween(pickerFrame, {BackgroundTransparency = 1}, 0.15)
            task.delay(0.16, function()
                if pickerFrame then pickerFrame:Destroy() pickerFrame = nil end
            end)
        end
        pickerOpen = false
    end

    local function OpenPicker()
        if pickerFrame then return end
        pickerOpen = true

        local absPos  = swatch.AbsolutePosition
        local absSize = swatch.AbsoluteSize

        pickerFrame = Instance.new("Frame")
        pickerFrame.Name             = "ColorPicker"
        pickerFrame.BackgroundColor3 = T.DropdownBG
        pickerFrame.BorderSizePixel  = 0
        pickerFrame.ZIndex           = 20
        pickerFrame.Size             = UDim2.new(0, 200, 0, 180)
        pickerFrame.Position         = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 4)
        MakeCorner(pickerFrame, 8)
        MakeStroke(pickerFrame, T.Border, 1)

        local sg = row:FindFirstAncestorWhichIsA("ScreenGui")
        if sg then pickerFrame.Parent = sg else pickerFrame.Parent = row.Parent end

        -- Hue bar
        local hueBar = Instance.new("Frame")
        hueBar.Name            = "HueBar"
        hueBar.BackgroundColor3 = Color3.new(1,1,1)
        hueBar.BorderSizePixel = 0
        hueBar.Position        = UDim2.new(0, 8, 0, 8)
        hueBar.Size            = UDim2.new(1, -16, 0, 18)
        hueBar.ZIndex          = 21
        hueBar.Parent          = pickerFrame
        MakeCorner(hueBar, 4)

        -- Fill hue gradient
        local hueGrad = Instance.new("UIGradient")
        hueGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   Color3.fromHSV(0,    1, 1)),
            ColorSequenceKeypoint.new(1/6, Color3.fromHSV(1/6,  1, 1)),
            ColorSequenceKeypoint.new(2/6, Color3.fromHSV(2/6,  1, 1)),
            ColorSequenceKeypoint.new(3/6, Color3.fromHSV(3/6,  1, 1)),
            ColorSequenceKeypoint.new(4/6, Color3.fromHSV(4/6,  1, 1)),
            ColorSequenceKeypoint.new(5/6, Color3.fromHSV(5/6,  1, 1)),
            ColorSequenceKeypoint.new(1,   Color3.fromHSV(1,    1, 1)),
        })
        hueGrad.Parent = hueBar

        -- SV square
        local svSq = Instance.new("ImageLabel")
        svSq.Name              = "SVSquare"
        svSq.BackgroundColor3  = Color3.new(1,1,1)
        svSq.BorderSizePixel   = 0
        svSq.Position          = UDim2.new(0, 8, 0, 34)
        svSq.Size              = UDim2.new(1, -16, 0, 110)
        svSq.ZIndex            = 21
        -- Use a simple white->transparent horizontal + black vertical gradient overlay
        svSq.Image             = "rbxassetid://0"
        svSq.Parent            = pickerFrame
        MakeCorner(svSq, 4)

        -- White→ Color horizontal gradient
        local hGrad = Instance.new("UIGradient")
        hGrad.Color = ColorSequence.new(Color3.new(1,1,1), Color3.fromHSV(0,1,1))
        hGrad.Parent = svSq

        -- Dark overlay (top→black vertical)
        local darkOverlay = Instance.new("Frame")
        darkOverlay.BackgroundColor3 = Color3.new(0,0,0)
        darkOverlay.BorderSizePixel  = 0
        darkOverlay.Size             = UDim2.new(1, 0, 1, 0)
        darkOverlay.ZIndex           = 22
        darkOverlay.Parent           = svSq
        MakeCorner(darkOverlay, 4)
        local darkGrad = Instance.new("UIGradient")
        darkGrad.Rotation = 90
        darkGrad.Color    = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
            ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
        })
        darkGrad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0),
        })
        darkGrad.Parent = darkOverlay

        -- Current H, S, V
        local H, S, V = color:ToHSV()

        local function RebuildHGradient()
            hGrad.Color = ColorSequence.new(Color3.new(1,1,1), Color3.fromHSV(H, 1, 1))
        end
        RebuildHGradient()

        -- Hue knob
        local hueKnob = Instance.new("Frame")
        hueKnob.AnchorPoint      = Vector2.new(0.5, 0.5)
        hueKnob.BackgroundColor3 = Color3.new(1,1,1)
        hueKnob.BorderSizePixel  = 0
        hueKnob.Size             = UDim2.new(0, 12, 0, 20)
        hueKnob.ZIndex           = 23
        hueKnob.Position         = UDim2.new(H, 0, 0.5, 0)
        hueKnob.Parent           = hueBar
        MakeCorner(hueKnob, 3)
        MakeStroke(hueKnob, T.Border, 1)

        -- SV knob
        local svKnob = Instance.new("Frame")
        svKnob.AnchorPoint      = Vector2.new(0.5, 0.5)
        svKnob.BackgroundColor3 = Color3.new(1,1,1)
        svKnob.BorderSizePixel  = 0
        svKnob.Size             = UDim2.new(0, 12, 0, 12)
        svKnob.ZIndex           = 24
        svKnob.Position         = UDim2.new(S, 0, 1 - V, 0)
        svKnob.Parent           = svSq
        MakeCorner(svKnob, 6)
        MakeStroke(svKnob, T.Border, 1)

        local function Emit()
            local c = Color3.fromHSV(H, S, V)
            UpdateSwatch(c)
            if opts.Callback then task.spawn(opts.Callback, c) end
        end

        -- Hue dragging
        local hDrag = false
        hueBar.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then hDrag = true end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then hDrag = false end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if hDrag and inp.UserInputType == Enum.UserInputType.MouseMovement then
                local pct = math.clamp((inp.Position.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
                H = pct
                hueKnob.Position = UDim2.new(H, 0, 0.5, 0)
                RebuildHGradient()
                Emit()
            end
        end)

        -- SV dragging
        local svDrag = false
        svSq.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then svDrag = true end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then svDrag = false end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if svDrag and inp.UserInputType == Enum.UserInputType.MouseMovement then
                S = math.clamp((inp.Position.X - svSq.AbsolutePosition.X) / svSq.AbsoluteSize.X, 0, 1)
                V = 1 - math.clamp((inp.Position.Y - svSq.AbsolutePosition.Y) / svSq.AbsoluteSize.Y, 0, 1)
                svKnob.Position = UDim2.new(S, 0, 1 - V, 0)
                Emit()
            end
        end)

        -- Close button
        local closeBtn = Instance.new("TextButton")
        closeBtn.Text                = "✕  Close"
        closeBtn.TextSize            = 11
        closeBtn.Font                = Enum.Font.GothamMedium
        closeBtn.TextColor3          = T.TextSecondary
        closeBtn.BackgroundColor3    = T.ElementBG
        closeBtn.BorderSizePixel     = 0
        closeBtn.Size                = UDim2.new(1, -16, 0, 22)
        closeBtn.Position            = UDim2.new(0, 8, 1, -30)
        closeBtn.ZIndex              = 23
        closeBtn.Parent              = pickerFrame
        MakeCorner(closeBtn, 4)
        closeBtn.MouseButton1Click:Connect(ClosePicker)
    end

    local swatchBtn = Instance.new("TextButton")
    swatchBtn.BackgroundTransparency = 1
    swatchBtn.Size                   = UDim2.new(1, 0, 1, 0)
    swatchBtn.Text                   = ""
    swatchBtn.ZIndex                 = 5
    swatchBtn.Parent                 = swatch
    swatchBtn.MouseButton1Click:Connect(function()
        if pickerOpen then ClosePicker() else OpenPicker() end
    end)

    local ctrl = {}
    function ctrl:Set(c)
        UpdateSwatch(c)
        if flag then NexusLib.Flags[flag] = c end
    end
    ctrl.CurrentValue = color
    return ctrl
end

-- ─────────────────────────────────────────────────────────────────────────────
-- KEYBIND
-- ─────────────────────────────────────────────────────────────────────────────
function Section:NewKeybind(opts)
    if type(opts) == "string" then
        opts = { Name = opts }
    end
    opts = opts or {}
    local T      = self._theme
    local flag   = opts.Flag
    local curKey = opts.CurrentKeybind or opts.DefaultKeybind or Enum.KeyCode.Unknown
    if flag then NexusLib.Flags[flag] = curKey end

    local row = self:_MakeRow(38)
    MakePadding(row, 0, 0, 10, 10)
    HoverEffect(row, T.ElementBG, T.ElementHover)

    local nameLbl = MakeLabel(row, opts.Name or "Keybind", 13, T.TextPrimary, Enum.Font.GothamMedium)
    nameLbl.Size = UDim2.new(0.55, 0, 1, 0)

    local keyBtn = Instance.new("TextButton")
    keyBtn.AnchorPoint      = Vector2.new(1, 0.5)
    keyBtn.Position         = UDim2.new(1, 0, 0.5, 0)
    keyBtn.Size             = UDim2.new(0, 90, 0, 24)
    keyBtn.BackgroundColor3 = T.ElementHover
    keyBtn.BorderSizePixel  = 0
    keyBtn.Text             = curKey == Enum.KeyCode.Unknown and "[ None ]" or ("[ " .. curKey.Name .. " ]")
    keyBtn.TextSize         = 11
    keyBtn.Font             = Enum.Font.GothamMedium
    keyBtn.TextColor3       = T.Accent
    keyBtn.Parent           = row
    MakeCorner(keyBtn, 5)
    MakeStroke(keyBtn, T.Border, 1)

    local listening = false
    keyBtn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        keyBtn.Text = "[ ... ]"
        keyBtn.TextColor3 = T.TextMuted
    end)

    UserInputService.InputBegan:Connect(function(input, gpe)
        if not listening then
            -- Trigger callback
            if input.UserInputType == Enum.UserInputType.Keyboard
                and input.KeyCode == curKey then
                if opts.Callback then task.spawn(opts.Callback) end
            end
            return
        end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            curKey = input.KeyCode
            if flag then NexusLib.Flags[flag] = curKey end
            keyBtn.Text = "[ " .. curKey.Name .. " ]"
            keyBtn.TextColor3 = T.Accent
            listening = false
        end
    end)

    local ctrl = {}
    function ctrl:Set(kc)
        curKey = kc
        keyBtn.Text = "[ " .. curKey.Name .. " ]"
        if flag then NexusLib.Flags[flag] = curKey end
    end
    ctrl.CurrentKeybind = curKey
    return ctrl
end

-- ─────────────────────────────────────────────────────────────────────────────
-- SEPARATOR
-- ─────────────────────────────────────────────────────────────────────────────
function Section:NewSeparator()
    local row = self:_MakeRow(10)
    row.BackgroundTransparency = 1
    local line = Instance.new("Frame")
    line.BackgroundColor3 = self._theme.Border
    line.BorderSizePixel  = 0
    line.AnchorPoint      = Vector2.new(0, 0.5)
    line.Position         = UDim2.new(0, 0, 0.5, 0)
    line.Size             = UDim2.new(1, 0, 0, 1)
    line.Parent           = row
end

-- ─────────────────────────────────────────────────────────────────────────────
-- TAB Builder
-- ─────────────────────────────────────────────────────────────────────────────
local Tab = {}
Tab.__index = Tab

function Tab.new(scrollParent, T)
    local self = setmetatable({}, Tab)
    self._theme = T

    local scroll = Instance.new("ScrollingFrame")
    scroll.BackgroundTransparency   = 1
    scroll.BorderSizePixel          = 0
    scroll.Size                     = UDim2.new(1, 0, 1, 0)
    scroll.CanvasSize               = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize      = Enum.AutomaticSize.Y
    scroll.ScrollBarThickness       = 3
    scroll.ScrollBarImageColor3     = T.ScrollBar
    scroll.ElasticBehavior          = Enum.ElasticBehavior.Never
    scroll.Visible                  = false
    scroll.Parent                   = scrollParent

    local layout = Instance.new("UIListLayout")
    layout.SortOrder  = Enum.SortOrder.LayoutOrder
    layout.Padding    = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent     = scroll

    MakePadding(scroll, 8, 8, 8, 8)

    self._frame = scroll
    return self
end

function Tab:NewSection(name)
    local sec = Section.new(self._frame, name, self._theme)
    return sec
end

-- ─────────────────────────────────────────────────────────────────────────────
-- WINDOW Builder
-- ─────────────────────────────────────────────────────────────────────────────
local Window = {}
Window.__index = Window

function NexusLib:CreateWindow(opts)
    opts = opts or {}

    -- Resolve theme
    local T
    if type(opts.Theme) == "table" then
        T = opts.Theme
    elseif type(opts.Theme) == "string" and Themes[opts.Theme] then
        T = Themes[opts.Theme]
    else
        T = Themes.Dark
    end
    self._theme = T

    local win = setmetatable({}, Window)
    win._theme    = T
    win._tabs     = {}
    win._tabBtns  = {}
    win._activeTab = nil

    -- ── ScreenGui ────────────────────────────────────────────────────────────
    local sg = Instance.new("ScreenGui")
    sg.Name           = "NexusUI_" .. (opts.Title or "Window")
    sg.ResetOnSpawn   = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder   = 100
    pcall(function() sg.Parent = CoreGui end)
    if not sg.Parent then sg.Parent = LocalPlayer.PlayerGui end

    -- ── Main Frame ───────────────────────────────────────────────────────────
    local W = opts.Size and opts.Size[1] or 540
    local H = opts.Size and opts.Size[2] or 400

    local mainFrame = Instance.new("Frame")
    mainFrame.Name             = "MainFrame"
    mainFrame.AnchorPoint      = Vector2.new(0.5, 0.5)
    mainFrame.Position         = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Size             = UDim2.new(0, W, 0, H)
    mainFrame.BackgroundColor3 = T.WindowBG
    mainFrame.BorderSizePixel  = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent           = sg
    MakeCorner(mainFrame, 10)
    MakeStroke(mainFrame, T.Border, 1)

    -- Drop shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Name                = "Shadow"
    shadow.AnchorPoint         = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position            = UDim2.new(0.5, 0, 0.5, 6)
    shadow.Size                = UDim2.new(1, 30, 1, 30)
    shadow.ZIndex              = -1
    shadow.Image               = "rbxassetid://6015897843"  -- shadow asset
    shadow.ImageColor3         = Color3.new(0,0,0)
    shadow.ImageTransparency   = 0.5
    shadow.ScaleType           = Enum.ScaleType.Slice
    shadow.SliceCenter         = Rect.new(49, 49, 450, 450)
    shadow.Parent              = mainFrame

    -- ── Title Bar ────────────────────────────────────────────────────────────
    local titleBar = Instance.new("Frame")
    titleBar.Name             = "TitleBar"
    titleBar.BackgroundColor3 = T.TitleBar
    titleBar.BorderSizePixel  = 0
    titleBar.Size             = UDim2.new(1, 0, 0, 38)
    titleBar.Parent           = mainFrame

    -- Round only top corners
    local tbCorner = Instance.new("UICorner")
    tbCorner.CornerRadius = UDim.new(0, 10)
    tbCorner.Parent = titleBar
    -- Patch bottom corners
    local tbPatch = Instance.new("Frame")
    tbPatch.BackgroundColor3 = T.TitleBar
    tbPatch.BorderSizePixel  = 0
    tbPatch.Position         = UDim2.new(0, 0, 0.5, 0)
    tbPatch.Size             = UDim2.new(1, 0, 0.5, 0)
    tbPatch.Parent           = titleBar

    -- Logo / accent strip
    local accentStrip = Instance.new("Frame")
    accentStrip.BackgroundColor3 = T.Accent
    accentStrip.BorderSizePixel  = 0
    accentStrip.Size             = UDim2.new(0, 3, 1, -16)
    accentStrip.AnchorPoint      = Vector2.new(0, 0.5)
    accentStrip.Position         = UDim2.new(0, 12, 0.5, 0)
    accentStrip.Parent           = titleBar
    MakeCorner(accentStrip, 2)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Name              = "Title"
    titleLbl.BackgroundTransparency = 1
    titleLbl.Position          = UDim2.new(0, 22, 0, 0)
    titleLbl.Size              = UDim2.new(0.7, 0, 1, 0)
    titleLbl.Text              = opts.Title or "Nexus"
    titleLbl.TextSize          = 14
    titleLbl.Font              = Enum.Font.GothamBold
    titleLbl.TextColor3        = T.TextPrimary
    titleLbl.TextXAlignment    = Enum.TextXAlignment.Left
    titleLbl.RichText          = true
    titleLbl.Parent            = titleBar

    -- Subtitle
    if opts.Subtitle then
        titleLbl.Size = UDim2.new(0.7, 0, 0.55, 0)
        local subLbl = MakeLabel(titleBar, opts.Subtitle, 10, T.TextMuted, Enum.Font.Gotham)
        subLbl.Position = UDim2.new(0, 22, 0.55, 0)
        subLbl.Size     = UDim2.new(0.7, 0, 0.45, 0)
    end

    -- Window controls
    local function MakeWinBtn(color, xOff)
        local btn = Instance.new("TextButton")
        btn.Text                = ""
        btn.BackgroundColor3    = color
        btn.BorderSizePixel     = 0
        btn.AnchorPoint         = Vector2.new(1, 0.5)
        btn.Position            = UDim2.new(1, xOff, 0.5, 0)
        btn.Size                = UDim2.new(0, 12, 0, 12)
        btn.Parent              = titleBar
        MakeCorner(btn, 6)
        return btn
    end

    local closeBtn = MakeWinBtn(T.CloseBtn, -10)
    local minBtn   = MakeWinBtn(T.MinBtn,   -28)

    local minimized = false
    local bodyContainer

    closeBtn.MouseButton1Click:Connect(function()
        Tween(mainFrame, {Size = UDim2.new(0, W, 0, 0)}, 0.2)
        task.delay(0.22, function() sg:Destroy() end)
    end)

    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(mainFrame, {Size = UDim2.new(0, W, 0, 38)}, 0.2)
        else
            Tween(mainFrame, {Size = UDim2.new(0, W, 0, H)}, 0.2)
        end
    end)

    MakeDraggable(titleBar, mainFrame)

    -- ── Tab Bar ──────────────────────────────────────────────────────────────
    local tabBar = Instance.new("Frame")
    tabBar.Name             = "TabBar"
    tabBar.BackgroundColor3 = T.TabBar
    tabBar.BorderSizePixel  = 0
    tabBar.Position         = UDim2.new(0, 0, 0, 38)
    tabBar.Size             = UDim2.new(0, 130, 1, -38)
    tabBar.Parent           = mainFrame

    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.BackgroundTransparency  = 1
    tabScroll.BorderSizePixel         = 0
    tabScroll.Size                    = UDim2.new(1, 0, 1, -8)
    tabScroll.Position                = UDim2.new(0, 0, 0, 8)
    tabScroll.CanvasSize              = UDim2.new(0, 0, 0, 0)
    tabScroll.AutomaticCanvasSize     = Enum.AutomaticSize.Y
    tabScroll.ScrollBarThickness      = 0
    tabScroll.Parent                  = tabBar

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder              = Enum.SortOrder.LayoutOrder
    tabLayout.Padding                = UDim.new(0, 3)
    tabLayout.HorizontalAlignment    = Enum.HorizontalAlignment.Center
    tabLayout.Parent                 = tabScroll
    MakePadding(tabScroll, 4, 4, 6, 6)

    -- Divider between tab bar and content
    local divider = Instance.new("Frame")
    divider.BackgroundColor3 = T.Border
    divider.BorderSizePixel  = 0
    divider.Position         = UDim2.new(0, 130, 0, 38)
    divider.Size             = UDim2.new(0, 1, 1, -38)
    divider.Parent           = mainFrame

    -- ── Content Area ─────────────────────────────────────────────────────────
    bodyContainer = Instance.new("Frame")
    bodyContainer.Name             = "Body"
    bodyContainer.BackgroundTransparency = 1
    bodyContainer.Position         = UDim2.new(0, 132, 0, 38)
    bodyContainer.Size             = UDim2.new(1, -133, 1, -38)
    bodyContainer.ClipsDescendants = true
    bodyContainer.Parent           = mainFrame

    win._sg            = sg
    win._mainFrame     = mainFrame
    win._tabScroll     = tabScroll
    win._bodyContainer = bodyContainer
    win._W, win._H     = W, H

    -- Open animation
    mainFrame.Size = UDim2.new(0, W, 0, 0)
    Tween(mainFrame, {Size = UDim2.new(0, W, 0, H)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    return win
end

function Window:NewTab(name, icon)
    local T = self._theme

    -- Tab button
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name             = "Tab_" .. name
    tabBtn.Text             = (icon and (icon .. "  ") or "") .. name
    tabBtn.TextSize         = 12
    tabBtn.Font             = Enum.Font.GothamMedium
    tabBtn.TextXAlignment   = Enum.TextXAlignment.Left
    tabBtn.TextColor3       = T.TextSecondary
    tabBtn.BackgroundColor3 = T.TabUnselected
    tabBtn.BorderSizePixel  = 0
    tabBtn.Size             = UDim2.new(1, -4, 0, 32)
    tabBtn.LayoutOrder      = #self._tabs + 1
    tabBtn.Parent           = self._tabScroll
    MakeCorner(tabBtn, 6)
    MakePadding(tabBtn, 0, 0, 10, 6)

    -- Active indicator
    local indicator = Instance.new("Frame")
    indicator.AnchorPoint      = Vector2.new(0, 0.5)
    indicator.Position         = UDim2.new(0, 0, 0.5, 0)
    indicator.Size             = UDim2.new(0, 3, 0.6, 0)
    indicator.BackgroundColor3 = T.Accent
    indicator.BorderSizePixel  = 0
    indicator.Visible          = false
    indicator.Parent           = tabBtn
    MakeCorner(indicator, 2)

    local tab = Tab.new(self._bodyContainer, T)
    tab._btn = tabBtn

    local function SelectTab()
        -- Deselect all
        for _, t in ipairs(self._tabs) do
            Tween(t._btn, {BackgroundColor3 = T.TabUnselected}, 0.12)
            t._btn.TextColor3 = T.TextSecondary
            t._btn:FindFirstChild("Frame").Visible = false
            t._frame.Visible = false
        end
        -- Select this
        Tween(tabBtn, {BackgroundColor3 = T.TabSelected}, 0.12)
        tabBtn.TextColor3 = T.TextPrimary
        indicator.Visible = true
        tab._frame.Visible = true
        self._activeTab = tab
    end

    tabBtn.MouseButton1Click:Connect(SelectTab)
    HoverEffect(tabBtn, T.TabUnselected, T.ElementHover)

    table.insert(self._tabs, tab)
    table.insert(self._tabBtns, tabBtn)

    -- Auto-select first tab
    if #self._tabs == 1 then
        SelectTab()
    end

    return tab
end

function Window:Destroy()
    self._sg:Destroy()
end

function Window:ToggleUI()
    self._mainFrame.Visible = not self._mainFrame.Visible
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Expose theme table & utilities
-- ─────────────────────────────────────────────────────────────────────────────
NexusLib.Themes   = Themes
NexusLib.Version  = "1.0.0"

function NexusLib:GetFlag(flag)
    return self.Flags[flag]
end

function NexusLib:SetTheme(themeName)
    if Themes[themeName] then
        self._theme = Themes[themeName]
    elseif type(themeName) == "table" then
        self._theme = themeName
    end
end

-- ─────────────────────────────────────────────────────────────────────────────
-- DEMO  (remove or comment out when distributing as a library)
-- ─────────────────────────────────────────────────────────────────────────────
--[[
local Window = NexusLib:CreateWindow({
    Title    = "Nexus Library",
    Subtitle = "v1.0.0  •  Demo",
    Theme    = "Dark",       -- Dark | Light | Midnight | Crimson | Ocean
    Size     = {560, 420},
})

local MainTab = Window:NewTab("🏠  Main")
local PlayerTab = Window:NewTab("👤  Player")
local VisualTab = Window:NewTab("👁  Visual")
local SettingsTab = Window:NewTab("⚙  Settings")

-- Main Tab
local infoSec = MainTab:NewSection("Information")
infoSec:NewLabel({ Name = "Welcome to Nexus UI Library!" })
infoSec:NewLabel({ Name = "Version: <b>1.0.0</b>  •  <font color='#8080FF'>Open Source</font>", Color = Color3.fromRGB(160,160,200) })
infoSec:NewSeparator()

local actionSec = MainTab:NewSection("Actions")
actionSec:NewButton({
    Name = "Print Hello",
    Description = "Prints 'Hello, World!' to the console",
    Callback = function() print("Hello, World!") end
})
actionSec:NewButton({
    Name = "Send Notification",
    Callback = function()
        NexusLib:Notify({
            Title = "Nexus Notification",
            Description = "This is a test notification from the demo!",
            Duration = 5,
        })
    end
})

-- Player Tab
local moveSec = PlayerTab:NewSection("Movement")
moveSec:NewSlider({
    Name = "Walk Speed",
    Range = {16, 150},
    Increment = 1,
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Suffix = " studs/s",
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v
        end
    end
})
moveSec:NewSlider({
    Name = "Jump Power",
    Range = {0, 200},
    Increment = 5,
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = v
        end
    end
})
moveSec:NewToggle({
    Name = "Fly",
    Description = "Enable flight",
    CurrentValue = false,
    Flag = "FlyEnabled",
    Callback = function(state)
        print("Fly:", state)
    end
})

local toolSec = PlayerTab:NewSection("Tools")
toolSec:NewKeybind({
    Name = "Toggle UI",
    DefaultKeybind = Enum.KeyCode.RightShift,
    Flag = "UIToggle",
    Callback = function()
        Window:ToggleUI()
    end
})
toolSec:NewInput({
    Name = "Custom Message",
    PlaceholderText = "Type something...",
    Flag = "Message",
    Callback = function(text)
        print("Message:", text)
    end
})

-- Visual Tab
local colorSec = VisualTab:NewSection("Colors")
colorSec:NewColorPicker({
    Name = "Highlight Color",
    Color = Color3.fromRGB(100, 100, 255),
    Flag = "HighlightColor",
    Callback = function(color)
        print("Color changed:", color)
    end
})

local dropSec = VisualTab:NewSection("Options")
dropSec:NewDropdown({
    Name = "Theme",
    Options = {"Dark", "Light", "Midnight", "Crimson", "Ocean"},
    CurrentOption = {"Dark"},
    Flag = "SelectedTheme",
    Callback = function(opts)
        print("Selected theme:", opts[1])
    end
})
dropSec:NewDropdown({
    Name = "Effects",
    Options = {"Bloom", "Blur", "Sunrays", "Depth of Field"},
    MultipleOptions = true,
    CurrentOption = {},
    Flag = "Effects",
    Callback = function(selected)
        print("Effects:", table.concat(selected, ", "))
    end
})

-- Settings Tab
local configSec = SettingsTab:NewSection("Configuration")
configSec:NewToggle({
    Name = "Auto-Save Config",
    CurrentValue = true,
    Flag = "AutoSave",
})
configSec:NewToggle({
    Name = "Show Notifications",
    CurrentValue = true,
    Flag = "ShowNotifs",
})
configSec:NewButton({
    Name = "Reset to Defaults",
    Description = "Clears all saved configuration",
    Callback = function()
        NexusLib:Notify({ Title = "Config Reset", Description = "All settings have been reset.", AccentColor = Color3.fromRGB(220,80,80) })
    end
})
]]

-- ─────────────────────────────────────────────────────────────────────────────
return NexusLib
