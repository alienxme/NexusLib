 **Nexus UI Library** — a full 1,800-line custom Roblox UI library inspired by both Kavo and Rayfield. Here's a breakdown of everything included:

---

## 🪟 Window System
- Animated open/close (spring easing on open, shrink on close)
- Minimize button collapses the window to the title bar
- Fully **draggable** title bar — works on both PC and mobile touch
- Drop shadow via sliced ImageLabel
- Accent strip + title + optional subtitle in the header

## 🗂 Tabs & Sections
- **Left-side vertical tab bar** (scrollable, auto-selects first tab)
- Animated tab highlight with an active indicator bar
- **Sections** with a styled header, rounded container, and border stroke
- `Section:UpdateSection("New Name")` to rename dynamically

## 🎛 All Interactive Elements
| Element | API | Features |
|---|---|---|
| **Label** | `sec:NewLabel({})` | Rich text, color override |
| **Button** | `sec:NewButton({})` | Description sub-text, click flash |
| **Toggle** | `sec:NewToggle({})` | Animated knob, flag system |
| **Slider** | `sec:NewSlider({})` | Draggable knob, increment snap, suffix |
| **Input** | `sec:NewInput({})` | Placeholder, focus glow, clear-after-focus |
| **Dropdown** | `sec:NewDropdown({})` | Single & multi-select, animated popup, refresh |
| **Color Picker** | `sec:NewColorPicker({})` | HSV square + hue bar, hex preview swatch |
| **Keybind** | `sec:NewKeybind({})` | Click-to-rebind, executes callback on press |
| **Separator** | `sec:NewSeparator()` | Visual divider line |

## 🎨 5 Built-in Themes
`"Dark"` · `"Light"` · `"Midnight"` · `"Crimson"` · `"Ocean"` — or pass a custom color table.

## 🔔 Notification System
```lua
NexusLib:Notify({ Title = "Hello", Description = "World!", Duration = 5, AccentColor = ... })
```
Slides in from the bottom-right, auto-dismisses.

## ⚙ Flag System
Every element supports `Flag = "name"` — values are stored in `NexusLib.Flags["name"]`.

---

## Quick Start
```lua
local Nexus = loadstring(game:HttpGet("YOUR_RAW_URL"))()

local Win = Nexus:CreateWindow({ Title = "My Script", Theme = "Midnight" })
local Tab = Win:NewTab("⚙  Settings")
local Sec = Tab:NewSection("Player")

Sec:NewSlider({ Name = "Speed", Range = {16, 200}, Increment = 1,
    Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end })

Sec:NewToggle({ Name = "Noclip", Flag = "Noclip",
    Callback = function(state) print(state) end })
```

A full demo script is included inside a `--[[ ]]` block at the bottom of the file — just uncomment it to test all components instantly.
