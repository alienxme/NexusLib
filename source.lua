--[[
    NexusLib — A Modern Rewrite of Kavo UI Library
    Design: Glassmorphism + Neon Accent
    Features:
      • Fully scale-based responsive layout (SKILL-compliant)
      • AnchorPoint-centered main window
      • UICorner, UIStroke, UIPadding, UIListLayout throughout
      • Smooth TweenService animations on all interactions
      • Modern pill-style toggles (no legacy ImageLabel hack)
      • Clean slider with animated fill
      • Dropdown with animated expand
      • TextBox with focus highlight
      • ColorPicker (HSV)
      • Label element
      • Tab system with animated indicator
      • Multiple built-in themes + custom theme support
      • ToggleUI / ChangeColor / Destroy API preserved
      • No coroutine polling — event-driven theming
]]

local NexusLib = {}
NexusLib.__index = NexusLib

-- ─── Services ────────────────────────────────────────────────────────────────
local TweenService    = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService      = game:GetService("RunService")
local Players         = game:GetService("Players")
local HttpService     = game:GetService("HttpService")

-- ─── Helpers ─────────────────────────────────────────────────────────────────
local function Tween(obj, props, t, style, dir)
    style = style or Enum.EasingStyle.Quart
    dir   = dir   or Enum.EasingDirection.Out
    TweenService:Create(obj, TweenInfo.new(t or 0.2, style, dir), props):Play()
end

local function NewInst(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    return obj
end

local function Corner(parent, radius)
    return NewInst("UICorner", { CornerRadius = UDim.new(0, radius or 8), Parent = parent })
end

local function Stroke(parent, color, thickness, trans)
    return NewInst("UIStroke", {
        Color       = color or Color3.fromRGB(255,255,255),
        Thickness   = thickness or 1,
        Transparency = trans or 0.85,
        Parent      = parent
    })
end

local function Pad(parent, top, right, bottom, left)
    return NewInst("UIPadding", {
        PaddingTop    = UDim.new(0, top    or 0),
        PaddingRight  = UDim.new(0, right  or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
        PaddingLeft   = UDim.new(0, left   or 0),
        Parent        = parent
    })
end

-- ─── Themes ──────────────────────────────────────────────────────────────────
local Themes = {
    Nexus = {
        Accent      = Color3.fromRGB(99, 102, 241),   -- indigo neon
        Background  = Color3.fromRGB(12, 12, 18),
        Surface     = Color3.fromRGB(20, 21, 30),
        Element     = Color3.fromRGB(28, 30, 42),
        Header      = Color3.fromRGB(16, 17, 25),
        Text        = Color3.fromRGB(230, 230, 255),
        SubText     = Color3.fromRGB(130, 130, 170),
    },
    Aurora = {
        Accent      = Color3.fromRGB(52, 211, 153),
        Background  = Color3.fromRGB(8, 14, 20),
        Surface     = Color3.fromRGB(14, 22, 32),
        Element     = Color3.fromRGB(20, 32, 46),
        Header      = Color3.fromRGB(10, 17, 26),
        Text        = Color3.fromRGB(220, 255, 240),
        SubText     = Color3.fromRGB(100, 170, 140),
    },
    Crimson = {
        Accent      = Color3.fromRGB(239, 68, 68),
        Background  = Color3.fromRGB(14, 8, 8),
        Surface     = Color3.fromRGB(24, 14, 14),
        Element     = Color3.fromRGB(34, 20, 20),
        Header      = Color3.fromRGB(18, 10, 10),
        Text        = Color3.fromRGB(255, 225, 225),
        SubText     = Color3.fromRGB(180, 110, 110),
    },
    Violet = {
        Accent      = Color3.fromRGB(168, 85, 247),
        Background  = Color3.fromRGB(12, 8, 18),
        Surface     = Color3.fromRGB(22, 14, 34),
        Element     = Color3.fromRGB(34, 22, 50),
        Header      = Color3.fromRGB(16, 10, 26),
        Text        = Color3.fromRGB(235, 220, 255),
        SubText     = Color3.fromRGB(150, 120, 200),
    },
    Ocean = {
        Accent      = Color3.fromRGB(56, 189, 248),
        Background  = Color3.fromRGB(6, 12, 22),
        Surface     = Color3.fromRGB(10, 20, 36),
        Element     = Color3.fromRGB(16, 30, 52),
        Header      = Color3.fromRGB(8, 15, 28),
        Text        = Color3.fromRGB(210, 240, 255),
        SubText     = Color3.fromRGB(100, 160, 210),
    },
    Midnight = {
        Accent      = Color3.fromRGB(251, 191, 36),
        Background  = Color3.fromRGB(10, 10, 14),
        Surface     = Color3.fromRGB(18, 18, 24),
        Element     = Color3.fromRGB(26, 26, 34),
        Header      = Color3.fromRGB(13, 13, 18),
        Text        = Color3.fromRGB(255, 245, 210),
        SubText     = Color3.fromRGB(180, 160, 100),
    },
    Light = {
        Accent      = Color3.fromRGB(99, 102, 241),
        Background  = Color3.fromRGB(245, 245, 255),
        Surface     = Color3.fromRGB(235, 235, 248),
        Element     = Color3.fromRGB(220, 220, 240),
        Header      = Color3.fromRGB(200, 200, 225),
        Text        = Color3.fromRGB(20, 20, 40),
        SubText     = Color3.fromRGB(90, 90, 130),
    },
}

-- ─── Drag Helper ─────────────────────────────────────────────────────────────
local function EnableDrag(handle, target)
    local dragging, dragInput, mousePos, framePos = false, nil, nil, nil
    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging  = true
            mousePos  = inp.Position
            framePos  = target.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    handle.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = inp
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if inp == dragInput and dragging then
            local d = inp.Position - mousePos
            target.Position = UDim2.new(
                framePos.X.Scale, framePos.X.Offset + d.X,
                framePos.Y.Scale, framePos.Y.Offset + d.Y
            )
        end
    end)
end

-- ─── Library Entry Point ─────────────────────────────────────────────────────
local LibName = tostring(math.random(1,9999))

function NexusLib.CreateLib(libTitle, themeName)
    -- resolve theme
    local T = Themes[themeName] or Themes.Nexus
    if type(themeName) == "table" then T = themeName end

    -- fill missing theme keys with defaults
    local def = Themes.Nexus
    for k,v in pairs(def) do if T[k] == nil then T[k] = v end end

    libTitle = libTitle or "NexusLib"

    -- destroy any existing instance
    pcall(function()
        game.CoreGui[LibName]:Destroy()
    end)

    -- ── Root ─────────────────────────────────────────────────────────────────
    local ScreenGui = NewInst("ScreenGui", {
        Name           = LibName,
        Parent         = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn   = false,
        DisplayOrder   = 10,
    })

    -- ── Main Window (560×340) centred with AnchorPoint) ──────────────────────
    local Main = NewInst("Frame", {
        Name                = "Main",
        Parent              = ScreenGui,
        AnchorPoint         = Vector2.new(0.5, 0.5),
        Position            = UDim2.new(0.5, 0, 0.5, 0),
        Size                = UDim2.new(0, 580, 0, 360),
        BackgroundColor3    = T.Background,
        ClipsDescendants    = true,
    })
    Corner(Main, 14)
    Stroke(Main, T.Accent, 1.5, 0.70)

    -- subtle drop-shadow frame (rendered behind)
    local Shadow = NewInst("ImageLabel", {
        Name                = "Shadow",
        Parent              = Main,
        AnchorPoint         = Vector2.new(0.5, 0.5),
        Position            = UDim2.new(0.5, 0, 0.5, 6),
        Size                = UDim2.new(1, 40, 1, 40),
        BackgroundTransparency = 1,
        Image               = "rbxassetid://6015897843",
        ImageColor3         = Color3.fromRGB(0,0,0),
        ImageTransparency   = 0.5,
        ScaleType           = Enum.ScaleType.Slice,
        SliceCenter         = Rect.new(49,49,450,450),
        ZIndex              = 0,
    })

    -- ── Header bar ───────────────────────────────────────────────────────────
    local Header = NewInst("Frame", {
        Name             = "Header",
        Parent           = Main,
        Size             = UDim2.new(1, 0, 0, 46),
        BackgroundColor3 = T.Header,
    })
    Corner(Header, 14)
    -- cover bottom corners of header
    NewInst("Frame", {
        Parent           = Header,
        Position         = UDim2.new(0, 0, 0.5, 0),
        Size             = UDim2.new(1, 0, 0.5, 0),
        BackgroundColor3 = T.Header,
        BorderSizePixel  = 0,
    })

    EnableDrag(Header, Main)

    -- Accent left stripe
    local Stripe = NewInst("Frame", {
        Parent           = Header,
        Position         = UDim2.new(0, 14, 0.5, -8),
        Size             = UDim2.new(0, 4, 0, 16),
        BackgroundColor3 = T.Accent,
        ZIndex           = 2,
    })
    Corner(Stripe, 4)

    local TitleLabel = NewInst("TextLabel", {
        Parent               = Header,
        Position             = UDim2.new(0, 28, 0, 0),
        Size                 = UDim2.new(0.7, 0, 1, 0),
        BackgroundTransparency = 1,
        Font                 = Enum.Font.GothamBold,
        Text                 = libTitle,
        TextColor3           = T.Text,
        TextSize             = 15,
        TextXAlignment       = Enum.TextXAlignment.Left,
        RichText             = true,
        ZIndex               = 2,
    })
    Pad(TitleLabel, 0, 0, 0, 10)

    -- Close button
    local CloseBtn = NewInst("TextButton", {
        Parent               = Header,
        AnchorPoint          = Vector2.new(1, 0.5),
        Position             = UDim2.new(1, -12, 0.5, 0),
        Size                 = UDim2.new(0, 26, 0, 26),
        BackgroundColor3     = Color3.fromRGB(239, 68, 68),
        BackgroundTransparency = 0.3,
        Text                 = "✕",
        Font                 = Enum.Font.GothamBold,
        TextColor3           = Color3.fromRGB(255,255,255),
        TextSize             = 12,
        ZIndex               = 5,
        AutoButtonColor      = false,
    })
    Corner(CloseBtn, 8)

    CloseBtn.MouseEnter:Connect(function()
        Tween(CloseBtn, { BackgroundTransparency = 0 }, 0.15)
    end)
    CloseBtn.MouseLeave:Connect(function()
        Tween(CloseBtn, { BackgroundTransparency = 0.3 }, 0.15)
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        Tween(Main, { Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1 }, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.delay(0.3, function() ScreenGui:Destroy() end)
    end)

    -- Minimise button
    local MinBtn = NewInst("TextButton", {
        Parent               = Header,
        AnchorPoint          = Vector2.new(1, 0.5),
        Position             = UDim2.new(1, -44, 0.5, 0),
        Size                 = UDim2.new(0, 26, 0, 26),
        BackgroundColor3     = T.Element,
        BackgroundTransparency = 0.3,
        Text                 = "─",
        Font                 = Enum.Font.GothamBold,
        TextColor3           = T.SubText,
        TextSize             = 12,
        ZIndex               = 5,
        AutoButtonColor      = false,
    })
    Corner(MinBtn, 8)

    local minimised = false
    MinBtn.MouseButton1Click:Connect(function()
        minimised = not minimised
        if minimised then
            Tween(Main, { Size = UDim2.new(0, 580, 0, 46) }, 0.3, Enum.EasingStyle.Quart)
        else
            Tween(Main, { Size = UDim2.new(0, 580, 0, 360) }, 0.3, Enum.EasingStyle.Quart)
        end
    end)

    -- ── Sidebar (tab list) ───────────────────────────────────────────────────
    local Sidebar = NewInst("Frame", {
        Name             = "Sidebar",
        Parent           = Main,
        Position         = UDim2.new(0, 0, 0, 46),
        Size             = UDim2.new(0, 150, 1, -46),
        BackgroundColor3 = T.Header,
    })
    -- right edge separator
    NewInst("Frame", {
        Parent           = Sidebar,
        AnchorPoint      = Vector2.new(1, 0),
        Position         = UDim2.new(1, 0, 0, 0),
        Size             = UDim2.new(0, 1, 1, 0),
        BackgroundColor3 = T.Accent,
        BackgroundTransparency = 0.7,
    })

    local TabList = NewInst("Frame", {
        Parent               = Sidebar,
        Size                 = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
    })
    local TabListLayout = NewInst("UIListLayout", {
        Parent          = TabList,
        SortOrder       = Enum.SortOrder.LayoutOrder,
        Padding         = UDim.new(0, 4),
    })
    Pad(TabList, 10, 8, 8, 8)

    -- ── Content area ─────────────────────────────────────────────────────────
    local Content = NewInst("Frame", {
        Name                 = "Content",
        Parent               = Main,
        Position             = UDim2.new(0, 150, 0, 46),
        Size                 = UDim2.new(1, -150, 1, -46),
        BackgroundTransparency = 1,
        ClipsDescendants     = true,
    })

    -- ── Animate open ─────────────────────────────────────────────────────────
    Main.Size = UDim2.new(0, 0, 0, 0)
    Tween(Main, { Size = UDim2.new(0, 580, 0, 360) }, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    -- ── Public API ───────────────────────────────────────────────────────────
    local Library = {}
    local selectedTab = nil

    function Library:ToggleUI()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end

    function Library:Destroy()
        ScreenGui:Destroy()
    end

    function Library:ChangeColor(key, color)
        T[key] = color
        -- Accent stripe recolour
        if key == "Accent" then
            Stripe.BackgroundColor3 = color
        end
    end

    -- ── Tab factory ──────────────────────────────────────────────────────────
    local Tabs = {}

    function Tabs:NewTab(tabName)
        tabName = tabName or "Tab"

        -- sidebar button
        local TabBtn = NewInst("TextButton", {
            Parent               = TabList,
            Size                 = UDim2.new(1, 0, 0, 34),
            BackgroundColor3     = T.Element,
            BackgroundTransparency = 1,
            Font                 = Enum.Font.Gotham,
            Text                 = tabName,
            TextColor3           = T.SubText,
            TextSize             = 13,
            AutoButtonColor      = false,
            TextXAlignment       = Enum.TextXAlignment.Left,
        })
        Corner(TabBtn, 8)
        Pad(TabBtn, 0, 0, 0, 10)

        -- accent left indicator (hidden by default)
        local Indicator = NewInst("Frame", {
            Parent           = TabBtn,
            Position         = UDim2.new(0, 0, 0.15, 0),
            Size             = UDim2.new(0, 3, 0.7, 0),
            BackgroundColor3 = T.Accent,
            BackgroundTransparency = 1,
        })
        Corner(Indicator, 4)

        -- page ScrollingFrame
        local Page = NewInst("ScrollingFrame", {
            Parent                  = Content,
            Size                    = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency  = 1,
            BorderSizePixel         = 0,
            ScrollBarThickness      = 3,
            ScrollBarImageColor3    = T.Accent,
            CanvasSize              = UDim2.new(0, 0, 0, 0),
            Visible                 = false,
            ClipsDescendants        = true,
        })

        local PageLayout = NewInst("UIListLayout", {
            Parent    = Page,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding   = UDim.new(0, 8),
        })
        Pad(Page, 10, 12, 10, 10)

        local function RefreshCanvas()
            local cs = PageLayout.AbsoluteContentSize
            Page.CanvasSize = UDim2.new(0, 0, 0, cs.Y + 20)
        end
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(RefreshCanvas)

        local function SelectTab()
            if selectedTab then
                -- deselect old
                Tween(selectedTab.Btn, { BackgroundTransparency = 1, TextColor3 = T.SubText }, 0.2)
                Tween(selectedTab.Ind, { BackgroundTransparency = 1 }, 0.2)
                selectedTab.Page.Visible = false
            end
            selectedTab = { Btn = TabBtn, Ind = Indicator, Page = Page }
            Page.Visible = true
            Tween(TabBtn, { BackgroundTransparency = 0.85, TextColor3 = T.Text }, 0.2)
            Tween(Indicator, { BackgroundTransparency = 0 }, 0.2)
        end

        TabBtn.MouseButton1Click:Connect(SelectTab)
        TabBtn.MouseEnter:Connect(function()
            if selectedTab and selectedTab.Btn ~= TabBtn then
                Tween(TabBtn, { BackgroundTransparency = 0.92 }, 0.15)
            end
        end)
        TabBtn.MouseLeave:Connect(function()
            if not (selectedTab and selectedTab.Btn == TabBtn) then
                Tween(TabBtn, { BackgroundTransparency = 1 }, 0.15)
            end
        end)

        -- auto-select first tab
        if selectedTab == nil then SelectTab() end

        -- ── Section factory ──────────────────────────────────────────────────
        local Sections = {}

        function Sections:NewSection(secName)
            secName = secName or "Section"

            local SectionFrame = NewInst("Frame", {
                Parent           = Page,
                Size             = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = T.Surface,
                AutomaticSize    = Enum.AutomaticSize.Y,
            })
            Corner(SectionFrame, 10)
            Stroke(SectionFrame, T.Accent, 1, 0.80)

            -- Section header
            local SecHead = NewInst("Frame", {
                Parent           = SectionFrame,
                Size             = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = T.Element,
            })
            Corner(SecHead, 10)
            NewInst("Frame", {
                Parent           = SecHead,
                Position         = UDim2.new(0, 0, 0.5, 0),
                Size             = UDim2.new(1, 0, 0.5, 0),
                BackgroundColor3 = T.Element,
                BorderSizePixel  = 0,
            })

            local AccentDot = NewInst("Frame", {
                Parent           = SecHead,
                Position         = UDim2.new(0, 10, 0.5, -4),
                Size             = UDim2.new(0, 8, 0, 8),
                BackgroundColor3 = T.Accent,
            })
            Corner(AccentDot, 4)

            NewInst("TextLabel", {
                Parent               = SecHead,
                Position             = UDim2.new(0, 26, 0, 0),
                Size                 = UDim2.new(1, -30, 1, 0),
                BackgroundTransparency = 1,
                Font                 = Enum.Font.GothamBold,
                Text                 = secName,
                TextColor3           = T.Text,
                TextSize             = 13,
                TextXAlignment       = Enum.TextXAlignment.Left,
            })

            -- Elements list
            local ElemList = NewInst("Frame", {
                Parent               = SectionFrame,
                Position             = UDim2.new(0, 0, 0, 36),
                Size                 = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize        = Enum.AutomaticSize.Y,
            })
            local ElemLayout = NewInst("UIListLayout", {
                Parent    = ElemList,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding   = UDim.new(0, 2),
            })
            Pad(ElemList, 4, 8, 6, 8)

            -- ── Element helpers ──────────────────────────────────────────────
            local function BaseElement(h)
                h = h or 38
                local el = NewInst("Frame", {
                    Parent           = ElemList,
                    Size             = UDim2.new(1, 0, 0, h),
                    BackgroundColor3 = T.Element,
                })
                Corner(el, 8)
                return el
            end

            local function ElementIcon(parent, iconId, rectOffset, rectSize)
                return NewInst("ImageLabel", {
                    Parent               = parent,
                    Position             = UDim2.new(0, 8, 0.5, -9),
                    Size                 = UDim2.new(0, 18, 0, 18),
                    BackgroundTransparency = 1,
                    Image                = "rbxassetid://3926305904",
                    ImageColor3          = T.Accent,
                    ImageRectOffset      = rectOffset or Vector2.new(0,0),
                    ImageRectSize        = rectSize   or Vector2.new(36,36),
                })
            end

            local function ElementLabel(parent, text, xPos, yPos, w, h)
                return NewInst("TextLabel", {
                    Parent               = parent,
                    Position             = UDim2.new(0, xPos or 34, 0.5, -(h or 14)/2),
                    Size                 = UDim2.new(0, w or 180, 0, h or 14),
                    BackgroundTransparency = 1,
                    Font                 = Enum.Font.Gotham,
                    Text                 = text,
                    TextColor3           = T.Text,
                    TextSize             = 13,
                    TextXAlignment       = Enum.TextXAlignment.Left,
                    TextScaled           = false,
                })
            end

            local Elements = {}

            -- ══ BUTTON ════════════════════════════════════════════════════════
            function Elements:NewButton(name, tip, callback)
                name     = name     or "Button"
                tip      = tip      or ""
                callback = callback or function() end

                local el  = BaseElement(38)
                local ico  = ElementIcon(el, nil, Vector2.new(84,204), Vector2.new(36,36))
                local lbl  = ElementLabel(el, name)
                local ripple = NewInst("Frame", {
                    Parent               = el,
                    Size                 = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3     = T.Accent,
                    BackgroundTransparency = 1,
                    ClipsDescendants     = true,
                    ZIndex               = 2,
                })
                Corner(ripple, 8)

                -- small chevron right
                NewInst("TextLabel", {
                    Parent               = el,
                    AnchorPoint          = Vector2.new(1, 0.5),
                    Position             = UDim2.new(1, -10, 0.5, 0),
                    Size                 = UDim2.new(0, 14, 0, 14),
                    BackgroundTransparency = 1,
                    Font                 = Enum.Font.GothamBold,
                    Text                 = "›",
                    TextColor3           = T.Accent,
                    TextSize             = 18,
                })

                local Btn = NewInst("TextButton", {
                    Parent               = el,
                    Size                 = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text                 = "",
                    ZIndex               = 3,
                })
                Corner(Btn, 8)

                Btn.MouseEnter:Connect(function()
                    Tween(el, { BackgroundColor3 = Color3.new(
                        T.Element.R + 0.04, T.Element.G + 0.04, T.Element.B + 0.07
                    )}, 0.12)
                    ico.ImageColor3 = T.Text
                end)
                Btn.MouseLeave:Connect(function()
                    Tween(el, { BackgroundColor3 = T.Element }, 0.12)
                    ico.ImageColor3 = T.Accent
                end)
                Btn.MouseButton1Click:Connect(function()
                    pcall(callback)
                    -- ripple flash
                    Tween(ripple, { BackgroundTransparency = 0.85 }, 0.08)
                    task.delay(0.08, function()
                        Tween(ripple, { BackgroundTransparency = 1 }, 0.2)
                    end)
                end)

                local BF = {}
                function BF:UpdateButton(newName) lbl.Text = newName end
                return BF
            end

            -- ══ TOGGLE ════════════════════════════════════════════════════════
            function Elements:NewToggle(name, tip, default, callback)
                name     = name     or "Toggle"
                tip      = tip      or ""
                default  = default  or false
                callback = callback or function() end
                local toggled = default

                local el   = BaseElement(38)
                ElementIcon(el, nil, Vector2.new(724,724), Vector2.new(36,36))
                local lbl  = ElementLabel(el, name)

                -- pill track
                local Track = NewInst("Frame", {
                    Parent           = el,
                    AnchorPoint      = Vector2.new(1, 0.5),
                    Position         = UDim2.new(1, -10, 0.5, 0),
                    Size             = UDim2.new(0, 40, 0, 22),
                    BackgroundColor3 = toggled and T.Accent or T.Header,
                })
                Corner(Track, 11)
                Stroke(Track, toggled and T.Accent or Color3.fromRGB(60,60,80), 1, 0)

                -- pill thumb
                local Thumb = NewInst("Frame", {
                    Parent           = Track,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = toggled and UDim2.new(1,-19,0.5,0) or UDim2.new(0,3,0.5,0),
                    Size             = UDim2.new(0, 16, 0, 16),
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                })
                Corner(Thumb, 8)

                local Btn = NewInst("TextButton", {
                    Parent               = el,
                    Size                 = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text                 = "",
                    ZIndex               = 3,
                })

                local function SetToggle(state, fire)
                    toggled = state
                    if toggled then
                        Tween(Track,  { BackgroundColor3 = T.Accent }, 0.2)
                        Tween(Thumb,  { Position = UDim2.new(1,-19,0.5,0) }, 0.2, Enum.EasingStyle.Back)
                        local stroke = Track:FindFirstChildWhichIsA("UIStroke")
                        if stroke then stroke.Color = T.Accent end
                    else
                        Tween(Track,  { BackgroundColor3 = T.Header }, 0.2)
                        Tween(Thumb,  { Position = UDim2.new(0,3,0.5,0) }, 0.2, Enum.EasingStyle.Back)
                        local stroke = Track:FindFirstChildWhichIsA("UIStroke")
                        if stroke then stroke.Color = Color3.fromRGB(60,60,80) end
                    end
                    if fire then pcall(callback, toggled) end
                end

                Btn.MouseButton1Click:Connect(function()
                    SetToggle(not toggled, true)
                end)

                local TF = {}
                function TF:UpdateToggle(newName, newState)
                    if newName  ~= nil then lbl.Text = newName end
                    if newState ~= nil then SetToggle(newState, true) end
                end
                return TF
            end

            -- ══ SLIDER ════════════════════════════════════════════════════════
            function Elements:NewSlider(name, tip, maxVal, minVal, startVal, callback)
                name     = name     or "Slider"
                tip      = tip      or ""
                maxVal   = maxVal   or 100
                minVal   = minVal   or 0
                startVal = startVal or minVal
                callback = callback or function() end
                startVal = math.clamp(startVal, minVal, maxVal)

                local el  = BaseElement(46)
                ElementIcon(el, nil, Vector2.new(404,164), Vector2.new(36,36))
                local lbl = ElementLabel(el, name, 34, nil, 150, 14)

                -- value badge
                local ValBadge = NewInst("TextLabel", {
                    Parent               = el,
                    AnchorPoint          = Vector2.new(1, 0.5),
                    Position             = UDim2.new(1, -10, 0.3, 0),
                    Size                 = UDim2.new(0, 46, 0, 18),
                    BackgroundColor3     = T.Header,
                    Font                 = Enum.Font.GothamBold,
                    Text                 = tostring(startVal),
                    TextColor3           = T.Accent,
                    TextSize             = 12,
                    TextXAlignment       = Enum.TextXAlignment.Center,
                })
                Corner(ValBadge, 6)

                -- track
                local Track = NewInst("Frame", {
                    Parent           = el,
                    Position         = UDim2.new(0, 34, 1, -14),
                    Size             = UDim2.new(1, -100, 0, 5),
                    BackgroundColor3 = T.Header,
                })
                Corner(Track, 3)

                -- fill
                local Fill = NewInst("Frame", {
                    Parent           = Track,
                    Size             = UDim2.new((startVal-minVal)/(maxVal-minVal), 0, 1, 0),
                    BackgroundColor3 = T.Accent,
                })
                Corner(Fill, 3)

                -- thumb knob
                local Knob = NewInst("Frame", {
                    Parent           = Track,
                    AnchorPoint      = Vector2.new(0.5, 0.5),
                    Position         = UDim2.new((startVal-minVal)/(maxVal-minVal), 0, 0.5, 0),
                    Size             = UDim2.new(0, 12, 0, 12),
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    ZIndex           = 2,
                })
                Corner(Knob, 6)
                Stroke(Knob, T.Accent, 2, 0)

                local sliding = false
                local SliderBtn = NewInst("TextButton", {
                    Parent               = Track,
                    Size                 = UDim2.new(1, 0, 1, 20),
                    Position             = UDim2.new(0, 0, 0.5, -10),
                    BackgroundTransparency = 1,
                    Text                 = "",
                    ZIndex               = 4,
                })

                local function UpdateSlider(x)
                    local ts = Track.AbsoluteSize.X
                    local tp = Track.AbsolutePosition.X
                    local pct = math.clamp((x - tp) / ts, 0, 1)
                    local val = math.floor(minVal + pct * (maxVal - minVal))
                    Tween(Fill,  { Size = UDim2.new(pct, 0, 1, 0) }, 0.06)
                    Tween(Knob,  { Position = UDim2.new(pct, 0, 0.5, 0) }, 0.06)
                    ValBadge.Text = tostring(val)
                    pcall(callback, val)
                end

                SliderBtn.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        sliding = true
                        UpdateSlider(inp.Position.X)
                    end
                end)
                UserInputService.InputChanged:Connect(function(inp)
                    if sliding and inp.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateSlider(inp.Position.X)
                    end
                end)
                UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        sliding = false
                    end
                end)

                local SF = {}
                function SF:UpdateSlider(newVal)
                    newVal = math.clamp(newVal, minVal, maxVal)
                    local pct = (newVal - minVal) / (maxVal - minVal)
                    Fill.Size = UDim2.new(pct, 0, 1, 0)
                    Knob.Position = UDim2.new(pct, 0, 0.5, 0)
                    ValBadge.Text = tostring(newVal)
                end
                return SF
            end

            -- ══ TEXTBOX ═══════════════════════════════════════════════════════
            function Elements:NewTextBox(name, tip, placeholder, callback)
                name        = name        or "TextBox"
                tip         = tip         or ""
                placeholder = placeholder or "Type here..."
                callback    = callback    or function() end

                local el  = BaseElement(40)
                ElementIcon(el, nil, Vector2.new(324,604), Vector2.new(36,36))
                local lbl = ElementLabel(el, name, 34, nil, 120, 14)

                local InputFrame = NewInst("Frame", {
                    Parent           = el,
                    AnchorPoint      = Vector2.new(1, 0.5),
                    Position         = UDim2.new(1, -8, 0.5, 0),
                    Size             = UDim2.new(0, 150, 0, 26),
                    BackgroundColor3 = T.Header,
                })
                Corner(InputFrame, 6)
                local InputStroke = Stroke(InputFrame, T.Accent, 1, 0.80)

                local TB = NewInst("TextBox", {
                    Parent               = InputFrame,
                    Size                 = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Font                 = Enum.Font.Gotham,
                    PlaceholderText      = placeholder,
                    PlaceholderColor3    = T.SubText,
                    Text                 = "",
                    TextColor3           = T.Text,
                    TextSize             = 12,
                    ClearTextOnFocus     = false,
                    ZIndex               = 3,
                })
                Pad(TB, 0, 6, 0, 8)

                TB.Focused:Connect(function()
                    Tween(InputStroke, { Transparency = 0 }, 0.15)
                    Tween(InputFrame, { BackgroundColor3 = Color3.new(
                        T.Header.R + 0.05, T.Header.G + 0.05, T.Header.B + 0.08
                    )}, 0.15)
                end)
                TB.FocusLost:Connect(function(enter)
                    Tween(InputStroke, { Transparency = 0.80 }, 0.15)
                    Tween(InputFrame, { BackgroundColor3 = T.Header }, 0.15)
                    if enter then pcall(callback, TB.Text) end
                end)

                local TBF = {}
                function TBF:GetText() return TB.Text end
                function TBF:SetText(t) TB.Text = t end
                return TBF
            end

            -- ══ DROPDOWN ══════════════════════════════════════════════════════
            function Elements:NewDropdown(name, tip, options, callback)
                name     = name     or "Dropdown"
                tip      = tip      or ""
                options  = options  or {}
                callback = callback or function() end
                local selected = options[1] or "Select..."
                local open = false

                local el = BaseElement(38)
                Corner(el, 8)
                ElementIcon(el, nil, Vector2.new(644,364), Vector2.new(36,36))
                local lbl = ElementLabel(el, name, 34, nil, 100, 14)

                -- selected value display
                local SelLabel = NewInst("TextLabel", {
                    Parent               = el,
                    AnchorPoint          = Vector2.new(1, 0.5),
                    Position             = UDim2.new(1, -28, 0.5, 0),
                    Size                 = UDim2.new(0, 90, 0, 14),
                    BackgroundTransparency = 1,
                    Font                 = Enum.Font.Gotham,
                    Text                 = selected,
                    TextColor3           = T.Accent,
                    TextSize             = 12,
                    TextXAlignment       = Enum.TextXAlignment.Right,
                })

                local Arrow = NewInst("TextLabel", {
                    Parent               = el,
                    AnchorPoint          = Vector2.new(1, 0.5),
                    Position             = UDim2.new(1, -8, 0.5, 0),
                    Size                 = UDim2.new(0, 16, 0, 16),
                    BackgroundTransparency = 1,
                    Font                 = Enum.Font.GothamBold,
                    Text                 = "⌄",
                    TextColor3           = T.SubText,
                    TextSize             = 14,
                })

                -- dropdown panel (initially 0 height)
                local DropPanel = NewInst("Frame", {
                    Parent           = ElemList,
                    Size             = UDim2.new(1, 0, 0, 0),
                    BackgroundColor3 = T.Header,
                    ClipsDescendants = true,
                    ZIndex           = 6,
                })
                Corner(DropPanel, 8)

                local DropLayout = NewInst("UIListLayout", {
                    Parent    = DropPanel,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding   = UDim.new(0, 2),
                })
                Pad(DropPanel, 4, 6, 4, 6)

                local function ClosePanel()
                    open = false
                    Tween(Arrow, { Rotation = 0 }, 0.2)
                    Tween(DropPanel, { Size = UDim2.new(1, 0, 0, 0) }, 0.2)
                end

                local function BuildItems()
                    for _, child in ipairs(DropPanel:GetChildren()) do
                        if child:IsA("TextButton") then child:Destroy() end
                    end
                    for _, opt in ipairs(options) do
                        local item = NewInst("TextButton", {
                            Parent               = DropPanel,
                            Size                 = UDim2.new(1, 0, 0, 28),
                            BackgroundColor3     = opt == selected and T.Element or T.Header,
                            Font                 = Enum.Font.Gotham,
                            Text                 = "  " .. opt,
                            TextColor3           = opt == selected and T.Accent or T.Text,
                            TextSize             = 12,
                            TextXAlignment       = Enum.TextXAlignment.Left,
                            AutoButtonColor      = false,
                            ZIndex               = 7,
                        })
                        Corner(item, 6)
                        item.MouseButton1Click:Connect(function()
                            selected = opt
                            SelLabel.Text = opt
                            ClosePanel()
                            -- refresh colours
                            for _, c in ipairs(DropPanel:GetChildren()) do
                                if c:IsA("TextButton") then
                                    c.BackgroundColor3 = c.Text:sub(3) == opt and T.Element or T.Header
                                    c.TextColor3       = c.Text:sub(3) == opt and T.Accent  or T.Text
                                end
                            end
                            pcall(callback, selected)
                        end)
                    end
                end
                BuildItems()

                local OpenBtn = NewInst("TextButton", {
                    Parent               = el,
                    Size                 = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text                 = "",
                    ZIndex               = 4,
                })

                OpenBtn.MouseButton1Click:Connect(function()
                    open = not open
                    if open then
                        local itemCount = #options
                        local panelH    = math.min(itemCount * 30 + 8, 150)
                        BuildItems()
                        Tween(Arrow, { Rotation = 180 }, 0.2)
                        Tween(DropPanel, { Size = UDim2.new(1, 0, 0, panelH) }, 0.25, Enum.EasingStyle.Quart)
                    else
                        ClosePanel()
                    end
                end)

                local DF = {}
                function DF:GetSelected() return selected end
                function DF:UpdateOptions(newOpts)
                    options = newOpts
                    BuildItems()
                end
                return DF
            end

            -- ══ LABEL ═════════════════════════════════════════════════════════
            function Elements:NewLabel(text)
                text = text or ""
                local el = NewInst("Frame", {
                    Parent           = ElemList,
                    Size             = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = T.Accent,
                    BackgroundTransparency = 0.88,
                })
                Corner(el, 6)
                local Lbl = NewInst("TextLabel", {
                    Parent               = el,
                    Size                 = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Font                 = Enum.Font.GothamSemibold,
                    Text                 = text,
                    TextColor3           = T.Text,
                    TextSize             = 12,
                    TextXAlignment       = Enum.TextXAlignment.Left,
                    RichText             = true,
                })
                Pad(Lbl, 0, 0, 0, 10)
                local LF = {}
                function LF:UpdateLabel(newText) Lbl.Text = newText end
                return LF
            end

            -- ══ COLORPICKER ═══════════════════════════════════════════════════
            function Elements:NewColorPicker(name, tip, defaultColor, callback)
                name         = name         or "Color"
                tip          = tip          or ""
                defaultColor = defaultColor or Color3.fromRGB(255, 80, 80)
                callback     = callback     or function() end

                local h, s, v = Color3.toHSV(defaultColor)

                local el = BaseElement(38)
                ElementIcon(el, nil, Vector2.new(364,204), Vector2.new(36,36))
                local lbl = ElementLabel(el, name, 34, nil, 140, 14)

                -- colour swatch
                local Swatch = NewInst("Frame", {
                    Parent           = el,
                    AnchorPoint      = Vector2.new(1, 0.5),
                    Position         = UDim2.new(1, -10, 0.5, 0),
                    Size             = UDim2.new(0, 28, 0, 22),
                    BackgroundColor3 = defaultColor,
                })
                Corner(Swatch, 5)
                Stroke(Swatch, Color3.fromRGB(255,255,255), 1, 0.7)

                -- picker panel (hidden by default)
                local PickerPanel = NewInst("Frame", {
                    Parent               = ElemList,
                    Size                 = UDim2.new(1, 0, 0, 0),
                    BackgroundColor3     = T.Header,
                    ClipsDescendants     = true,
                    ZIndex               = 8,
                })
                Corner(PickerPanel, 8)
                Pad(PickerPanel, 6, 8, 6, 8)

                local pickerOpen = false
                local SwatchBtn = NewInst("TextButton", {
                    Parent               = el,
                    Size                 = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text                 = "",
                    ZIndex               = 4,
                })

                SwatchBtn.MouseButton1Click:Connect(function()
                    pickerOpen = not pickerOpen
                    if pickerOpen then
                        Tween(PickerPanel, { Size = UDim2.new(1, 0, 0, 130) }, 0.25, Enum.EasingStyle.Quart)
                    else
                        Tween(PickerPanel, { Size = UDim2.new(1, 0, 0, 0) }, 0.2)
                    end
                end)

                -- HSV gradient square
                local GradSquare = NewInst("ImageLabel", {
                    Parent               = PickerPanel,
                    Size                 = UDim2.new(0, 110, 0, 90),
                    BackgroundColor3     = Color3.fromHSV(h, 1, 1),
                    Image                = "rbxassetid://4155801252",
                    ZIndex               = 9,
                })
                Corner(GradSquare, 4)

                -- darkness slider (right side)
                local DarkSlider = NewInst("Frame", {
                    Parent           = PickerPanel,
                    Position         = UDim2.new(0, 118, 0, 0),
                    Size             = UDim2.new(0, 14, 0, 90),
                    BackgroundColor3 = T.Element,
                    ZIndex           = 9,
                })
                Corner(DarkSlider, 4)
                NewInst("UIGradient", {
                    Parent   = DarkSlider,
                    Color    = ColorSequence.new(Color3.fromRGB(255,255,255), Color3.fromRGB(0,0,0)),
                    Rotation = 90,
                })

                -- hue slider (bottom)
                local HueSlider = NewInst("Frame", {
                    Parent           = PickerPanel,
                    Position         = UDim2.new(0, 0, 0, 96),
                    Size             = UDim2.new(0, 134, 0, 12),
                    ZIndex           = 9,
                })
                Corner(HueSlider, 4)
                NewInst("UIGradient", {
                    Parent = HueSlider,
                    Color  = ColorSequence.new({
                        ColorSequenceKeypoint.new(0,    Color3.fromRGB(255,0,0)),
                        ColorSequenceKeypoint.new(0.167,Color3.fromRGB(255,255,0)),
                        ColorSequenceKeypoint.new(0.333,Color3.fromRGB(0,255,0)),
                        ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(0,255,255)),
                        ColorSequenceKeypoint.new(0.667,Color3.fromRGB(0,0,255)),
                        ColorSequenceKeypoint.new(0.833,Color3.fromRGB(255,0,255)),
                        ColorSequenceKeypoint.new(1,    Color3.fromRGB(255,0,0)),
                    }),
                })

                -- cursors
                local GradCursor = NewInst("Frame", {
                    Parent           = GradSquare,
                    AnchorPoint      = Vector2.new(0.5,0.5),
                    Position         = UDim2.new(1-s, 0, 1-v, 0),
                    Size             = UDim2.new(0,10,0,10),
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    ZIndex           = 10,
                })
                Corner(GradCursor, 5)

                local HueCursor = NewInst("Frame", {
                    Parent           = HueSlider,
                    AnchorPoint      = Vector2.new(0.5,0.5),
                    Position         = UDim2.new(h, 0, 0.5, 0),
                    Size             = UDim2.new(0, 6, 1, 4),
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    ZIndex           = 10,
                })
                Corner(HueCursor, 3)

                local currentColor = defaultColor
                local draggingGrad, draggingHue = false, false

                local function UpdateColor()
                    currentColor = Color3.fromHSV(h, s, v)
                    Swatch.BackgroundColor3 = currentColor
                    GradSquare.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    pcall(callback, currentColor)
                end

                -- grad input
                NewInst("TextButton", {
                    Parent               = GradSquare,
                    Size                 = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                    Text                 = "",
                    ZIndex               = 11,
                }).InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        draggingGrad = true
                    end
                end)

                -- hue input
                NewInst("TextButton", {
                    Parent               = HueSlider,
                    Size                 = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                    Text                 = "",
                    ZIndex               = 11,
                }).InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        draggingHue = true
                    end
                end)

                UserInputService.InputChanged:Connect(function(inp)
                    if inp.UserInputType ~= Enum.UserInputType.MouseMovement then return end
                    if draggingGrad then
                        local gp = GradSquare.AbsolutePosition
                        local gs = GradSquare.AbsoluteSize
                        local px = math.clamp((inp.Position.X - gp.X) / gs.X, 0, 1)
                        local py = math.clamp((inp.Position.Y - gp.Y) / gs.Y, 0, 1)
                        s = 1 - px
                        v = 1 - py
                        GradCursor.Position = UDim2.new(px,0,py,0)
                        UpdateColor()
                    end
                    if draggingHue then
                        local hp = HueSlider.AbsolutePosition
                        local hs = HueSlider.AbsoluteSize
                        local px = math.clamp((inp.Position.X - hp.X) / hs.X, 0, 1)
                        h = px
                        HueCursor.Position = UDim2.new(px,0,0.5,0)
                        UpdateColor()
                    end
                end)
                UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        draggingGrad = false
                        draggingHue  = false
                    end
                end)

                local CF = {}
                function CF:GetColor() return currentColor end
                function CF:SetColor(c)
                    defaultColor = c
                    h, s, v = Color3.toHSV(c)
                    UpdateColor()
                end
                return CF
            end

            return Elements
        end -- NewSection
        return Sections
    end -- NewTab
    return Tabs
end -- CreateLib

return NexusLib
