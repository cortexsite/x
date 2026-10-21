--[[
    CortexSite | Universal  v1.0
    Roblox executor script. Custom UI, zero external dependencies.
    Tabs: Player, Visuals, World, Teleport, Misc, Settings
    Menu toggle: RightShift (rebindable) or the floating "C" button on mobile.
]]

local env = (getgenv and getgenv()) or _G
if env.CortexSite and env.CortexSite.Unload then pcall(env.CortexSite.Unload) end

local cloneref = cloneref or function(x) return x end
local function svc(n) return cloneref(game:GetService(n)) end

local Players         = svc("Players")
local RunService      = svc("RunService")
local UIS             = svc("UserInputService")
local TweenService    = svc("TweenService")
local Lighting        = svc("Lighting")
local TeleportService = svc("TeleportService")
local HttpService     = svc("HttpService")
local VirtualUser     = svc("VirtualUser")
local Stats           = svc("Stats")
local Workspace       = svc("Workspace")
local LP              = Players.LocalPlayer

------------------------------------------------------------------------
-- Core helpers
------------------------------------------------------------------------
local Conns = {}
local function Bind(sig, fn)
    local c = sig:Connect(fn)
    table.insert(Conns, c)
    return c
end

local function New(class, props, kids)
    local o = Instance.new(class)
    for k, v in pairs(props or {}) do o[k] = v end
    for _, c in ipairs(kids or {}) do c.Parent = o end
    return o
end
local function Corner(o, r) return New("UICorner", {CornerRadius = UDim.new(0, r or 8), Parent = o}) end
local function Stroke(o, c, t)
    return New("UIStroke", {Color = c, Transparency = t or 0, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = o})
end
local function Tween(o, t, props)
    TweenService:Create(o, TweenInfo.new(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play()
end

local function Char() return LP.Character end
local function Hum() local c = LP.Character return c and c:FindFirstChildOfClass("Humanoid") end
local function Root() local c = LP.Character return c and c:FindFirstChild("HumanoidRootPart") end

------------------------------------------------------------------------
-- Theme
------------------------------------------------------------------------
local T = {
    Accent = Color3.fromRGB(0, 200, 255),
    BG     = Color3.fromRGB(10, 10, 16),
    Panel  = Color3.fromRGB(16, 16, 26),
    Item   = Color3.fromRGB(24, 24, 38),
    Text   = Color3.fromRGB(235, 235, 245),
    Sub    = Color3.fromRGB(140, 140, 165),
    Alt    = Color3.fromRGB(150, 80, 255),
}
local accentFns = {}
local function OnAccent(fn) fn() table.insert(accentFns, fn) end
local function SetAccent(c)
    T.Accent = c
    for _, fn in ipairs(accentFns) do pcall(fn) end
end

------------------------------------------------------------------------
-- GUI root
------------------------------------------------------------------------
local Gui = New("ScreenGui", {
    Name = "CortexSite", ResetOnSpawn = false, IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 999,
})
do
    if syn and syn.protect_gui then pcall(syn.protect_gui, Gui) end
    local ok = pcall(function() Gui.Parent = (gethui and gethui()) or svc("CoreGui") end)
    if not ok or not Gui.Parent then Gui.Parent = LP:WaitForChild("PlayerGui") end
end

local cam0 = Workspace.CurrentCamera
local vp = cam0 and cam0.ViewportSize or Vector2.new(1280, 720)
local WIN_W, WIN_H = math.min(640, vp.X - 24), math.min(410, vp.Y - 24)

local Main = New("Frame", {
    Name = "Main", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(WIN_W, WIN_H), BackgroundColor3 = T.BG, BackgroundTransparency = 0.04,
    BorderSizePixel = 0, ClipsDescendants = true, Parent = Gui,
})
Corner(Main, 14)
local mainStroke = Stroke(Main, T.Accent, 0.45)
New("UIGradient", {
    Rotation = 90,
    Color = ColorSequence.new(Color3.fromRGB(18, 18, 30), Color3.fromRGB(8, 8, 13)),
    Parent = Main,
})
OnAccent(function() mainStroke.Color = T.Accent end)

-- Top bar
local Top = New("Frame", {Size = UDim2.new(1, 0, 0, 44), BackgroundColor3 = T.Panel, BackgroundTransparency = 0.2, BorderSizePixel = 0, Parent = Main})
local Title = New("TextLabel", {
    BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 0), Size = UDim2.fromOffset(120, 44),
    Text = "CortexSite", Font = Enum.Font.GothamBlack, TextSize = 19, TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = T.Accent, Parent = Top,
})
OnAccent(function() Title.TextColor3 = T.Accent end)
New("TextLabel", {
    BackgroundTransparency = 1, Position = UDim2.fromOffset(122, 3), Size = UDim2.fromOffset(160, 44),
    Text = "Universal  •  v1.0", Font = Enum.Font.GothamMedium, TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = T.Sub, Parent = Top,
})
local TopLine = New("Frame", {Position = UDim2.new(0, 0, 1, -2), Size = UDim2.new(1, 0, 0, 2), BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1), Parent = Top})
local TopGrad = New("UIGradient", {Parent = TopLine})
OnAccent(function() TopGrad.Color = ColorSequence.new(T.Accent, T.Alt) end)

local function TopButton(txt, xOff)
    local b = New("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, xOff, 0.5, 0), Size = UDim2.fromOffset(28, 28),
        BackgroundColor3 = T.Item, Text = txt, Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = T.Text,
        AutoButtonColor = false, Parent = Top,
    })
    Corner(b, 8)
    return b
end
local CloseBtn = TopButton("×", -10)
local MinBtn   = TopButton("–", -44)

-- Drag (works for mouse and touch)
local function Drag(handle, target)
    local dragging, start, startPos
    Bind(handle.InputBegan, function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging, start, startPos = true, i.Position, target.Position
            local c
            c = i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then dragging = false c:Disconnect() end
            end)
        end
    end)
    Bind(UIS.InputChanged, function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - start
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
end
Drag(Top, Main)

-- Sidebar + pages
local Side = New("Frame", {Position = UDim2.fromOffset(0, 44), Size = UDim2.new(0, 132, 1, -44), BackgroundColor3 = Color3.fromRGB(12, 12, 20), BackgroundTransparency = 0.3, BorderSizePixel = 0, Parent = Main})
local SideList = New("ScrollingFrame", {
    Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 1, -52), BackgroundTransparency = 1, BorderSizePixel = 0,
    ScrollBarThickness = 0, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(), Parent = Side,
})
New("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, Parent = SideList})
New("TextLabel", {
    AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 12, 1, -10), Size = UDim2.new(1, -20, 0, 30),
    BackgroundTransparency = 1, Text = LP.DisplayName, Font = Enum.Font.GothamMedium, TextSize = 11,
    TextColor3 = T.Sub, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Side,
})
local Pages = New("Frame", {Position = UDim2.fromOffset(140, 52), Size = UDim2.new(1, -150, 1, -60), BackgroundTransparency = 1, Parent = Main})

------------------------------------------------------------------------
-- Notifications
------------------------------------------------------------------------
local NH = New("Frame", {AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -14, 1, -14), Size = UDim2.fromOffset(250, 400), BackgroundTransparency = 1, Parent = Gui})
New("UIListLayout", {
    Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Bottom, HorizontalAlignment = Enum.HorizontalAlignment.Right, Parent = NH,
})
local function Notify(title, text, dur)
    local f = New("Frame", {Size = UDim2.fromOffset(250, 54), BackgroundColor3 = T.Panel, BackgroundTransparency = 0.05, BorderSizePixel = 0, Parent = NH})
    Corner(f, 10)
    Stroke(f, T.Accent, 0.5)
    local bar = New("Frame", {Size = UDim2.new(0, 3, 1, -16), Position = UDim2.fromOffset(8, 8), BackgroundColor3 = T.Accent, BorderSizePixel = 0, Parent = f})
    Corner(bar, 2)
    New("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(20, 7), Size = UDim2.new(1, -28, 0, 18), Text = title,
        Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = T.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = f,
    })
    New("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(20, 26), Size = UDim2.new(1, -28, 0, 22), Text = text,
        Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = T.Sub, TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Parent = f,
    })
    task.delay(dur or 3, function()
        if f.Parent then
            Tween(f, 0.3, {BackgroundTransparency = 1})
            task.wait(0.3)
            f:Destroy()
        end
    end)
end

------------------------------------------------------------------------
-- UI elements
------------------------------------------------------------------------
local TabMT = {}
TabMT.__index = TabMT

local function Order(tab, o) tab.n = tab.n + 1 o.LayoutOrder = tab.n end

local function Row(tab, h)
    local f = New("Frame", {Size = UDim2.new(1, 0, 0, h or 36), BackgroundColor3 = T.Item, BackgroundTransparency = 0.1, BorderSizePixel = 0, Parent = tab.Page})
    Corner(f, 8)
    Order(tab, f)
    return f
end
local function RowLabel(parent, text, w)
    return New("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -(w or 70), 0, 36), Text = text,
        TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamMedium, TextSize = 13, TextColor3 = T.Text, Parent = parent,
    })
end

function TabMT:Section(title)
    local l = New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1, Text = string.upper(title), Font = Enum.Font.GothamBlack,
        TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = T.Accent, Parent = self.Page,
    })
    Order(self, l)
    OnAccent(function() l.TextColor3 = T.Accent end)
end

function TabMT:Label(text)
    local r = Row(self, 30)
    local l = New("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -24, 1, 0), Text = text,
        Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = T.Sub, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, Parent = r,
    })
    return {Set = function(_, t) l.Text = t end}
end

function TabMT:Button(name, cb)
    local r = Row(self)
    local b = New("TextButton", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", Parent = r})
    RowLabel(r, name, 50)
    local arrow = New("TextLabel", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(20, 20),
        BackgroundTransparency = 1, Text = "›", Font = Enum.Font.GothamBold, TextSize = 20, TextColor3 = T.Accent, Parent = r,
    })
    OnAccent(function() arrow.TextColor3 = T.Accent end)
    b.MouseEnter:Connect(function() Tween(r, 0.15, {BackgroundColor3 = Color3.fromRGB(34, 34, 54)}) end)
    b.MouseLeave:Connect(function() Tween(r, 0.15, {BackgroundColor3 = T.Item}) end)
    b.MouseButton1Click:Connect(function()
        r.BackgroundColor3 = T.Accent
        Tween(r, 0.3, {BackgroundColor3 = T.Item})
        local ok, err = pcall(cb)
        if not ok then Notify("Error", tostring(err), 4) end
    end)
end

function TabMT:Toggle(name, default, cb)
    local r = Row(self)
    RowLabel(r, name, 60)
    local sw = New("Frame", {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(40, 20), BackgroundColor3 = Color3.fromRGB(45, 45, 65), BorderSizePixel = 0, Parent = r})
    Corner(sw, 10)
    local knob = New("Frame", {Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(2, 2), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Parent = sw})
    Corner(knob, 8)
    local btn = New("TextButton", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", Parent = r})
    local state = default and true or false
    local function render()
        Tween(sw, 0.18, {BackgroundColor3 = state and T.Accent or Color3.fromRGB(45, 45, 65)})
        Tween(knob, 0.18, {Position = state and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)})
    end
    local obj = {}
    function obj:Set(v, silent)
        state = v and true or false
        render()
        if not silent then
            local ok, err = pcall(cb, state)
            if not ok then Notify("Error", tostring(err), 4) end
        end
    end
    btn.MouseButton1Click:Connect(function() obj:Set(not state) end)
    OnAccent(render)
    if state then pcall(cb, true) end
    return obj
end

function TabMT:Slider(name, min, max, default, step, cb)
    step = step or 1
    local r = Row(self, 50)
    New("TextLabel", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 5), Size = UDim2.new(1, -90, 0, 20), Text = name,
        TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamMedium, TextSize = 13, TextColor3 = T.Text, Parent = r,
    })
    local valLbl = New("TextLabel", {
        AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1, Position = UDim2.new(1, -12, 0, 5), Size = UDim2.fromOffset(70, 20),
        Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = T.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = r,
    })
    local bar = New("Frame", {Position = UDim2.new(0, 12, 0, 34), Size = UDim2.new(1, -24, 0, 6), BackgroundColor3 = Color3.fromRGB(40, 40, 60), BorderSizePixel = 0, Parent = r})
    Corner(bar, 3)
    local fill = New("Frame", {Size = UDim2.fromScale(0, 1), BackgroundColor3 = T.Accent, BorderSizePixel = 0, Parent = bar})
    Corner(fill, 3)
    OnAccent(function() fill.BackgroundColor3 = T.Accent valLbl.TextColor3 = T.Accent end)

    local value = default
    local function set(v, silent)
        v = math.clamp(math.floor(v / step + 0.5) * step, min, max)
        value = v
        fill.Size = UDim2.fromScale((v - min) / (max - min), 1)
        valLbl.Text = string.format("%g", v)
        if not silent then pcall(cb, v) end
    end
    local dragging = false
    local function upd(x) set(min + (max - min) * math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)) end
    bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            upd(i.Position.X)
        end
    end)
    Bind(UIS.InputChanged, function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then upd(i.Position.X) end
    end)
    Bind(UIS.InputEnded, function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    set(default, true)
    pcall(cb, default)
    return {Set = function(_, v) set(v) end, Get = function() return value end}
end

function TabMT:Dropdown(name, options, cb)
    local holder = New("Frame", {Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = T.Item, BackgroundTransparency = 0.1, BorderSizePixel = 0, ClipsDescendants = true, Parent = self.Page})
    Corner(holder, 8)
    Order(self, holder)
    RowLabel(holder, name, 170)
    local val = New("TextLabel", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -30, 0, 0), Size = UDim2.fromOffset(140, 36), BackgroundTransparency = 1,
        Text = "Select", Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = T.Sub, TextXAlignment = Enum.TextXAlignment.Right,
        TextTruncate = Enum.TextTruncate.AtEnd, Parent = holder,
    })
    local arrow = New("TextLabel", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 0), Size = UDim2.fromOffset(16, 36), BackgroundTransparency = 1,
        Text = "▾", Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = T.Accent, Parent = holder,
    })
    OnAccent(function() arrow.TextColor3 = T.Accent end)
    local head = New("TextButton", {Size = UDim2.new(1, 0, 0, 36), BackgroundTransparency = 1, Text = "", Parent = holder})
    local list = New("ScrollingFrame", {
        Position = UDim2.fromOffset(6, 40), Size = UDim2.new(1, -12, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 2, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(), Parent = holder,
    })
    New("UIListLayout", {Padding = UDim.new(0, 3), Parent = list})

    local open, opts, obj = false, options or {}, {}
    local function layout()
        local h = math.min(#opts, 5) * 29
        Tween(holder, 0.2, {Size = UDim2.new(1, 0, 0, open and (46 + h) or 36)})
        list.Size = UDim2.new(1, -12, 0, h)
    end
    local function rebuild()
        for _, c in ipairs(list:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        for _, o in ipairs(opts) do
            local b = New("TextButton", {
                Size = UDim2.new(1, -4, 0, 26), BackgroundColor3 = Color3.fromRGB(34, 34, 52), Text = tostring(o), Font = Enum.Font.Gotham,
                TextSize = 12, TextColor3 = T.Text, AutoButtonColor = false, Parent = list,
            })
            Corner(b, 6)
            b.MouseButton1Click:Connect(function()
                val.Text = tostring(o)
                open = false
                arrow.Text = "▾"
                layout()
                pcall(cb, o)
            end)
        end
        layout()
    end
    head.MouseButton1Click:Connect(function()
        open = not open
        arrow.Text = open and "▴" or "▾"
        layout()
    end)
    function obj:SetOptions(n) opts = n or {} rebuild() end
    function obj:Set(v) val.Text = tostring(v) end
    rebuild()
    return obj
end

function TabMT:Keybind(name, default, onPress, onChange)
    local r = Row(self)
    RowLabel(r, name, 120)
    local b = New("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(96, 24),
        BackgroundColor3 = Color3.fromRGB(38, 38, 58), Text = default.Name, Font = Enum.Font.GothamBold, TextSize = 12,
        TextColor3 = T.Text, AutoButtonColor = false, Parent = r,
    })
    Corner(b, 6)
    local key, listening = default, false
    b.MouseButton1Click:Connect(function() listening = true b.Text = "..." end)
    Bind(UIS.InputBegan, function(i, gp)
        if listening then
            if i.UserInputType == Enum.UserInputType.Keyboard then
                listening = false
                if i.KeyCode ~= Enum.KeyCode.Escape then key = i.KeyCode if onChange then onChange(key) end end
                b.Text = key.Name
            end
            return
        end
        if not gp and i.KeyCode == key and onPress then onPress() end
    end)
end

------------------------------------------------------------------------
-- Window / tabs
------------------------------------------------------------------------
local Window = {Tabs = {}}
function Window:AddTab(name, icon)
    local btn = New("TextButton", {Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = T.Item, BackgroundTransparency = 1, Text = "", AutoButtonColor = false, LayoutOrder = #Window.Tabs + 1, Parent = SideList})
    Corner(btn, 8)
    local ic = New("TextLabel", {BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 0), Size = UDim2.fromOffset(20, 34), Text = icon, TextSize = 14, Font = Enum.Font.GothamBold, TextColor3 = T.Sub, Parent = btn})
    local tx = New("TextLabel", {BackgroundTransparency = 1, Position = UDim2.fromOffset(34, 0), Size = UDim2.new(1, -38, 1, 0), Text = name, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamMedium, TextSize = 13, TextColor3 = T.Sub, Parent = btn})
    local bar = New("Frame", {Size = UDim2.fromOffset(3, 18), Position = UDim2.new(0, 0, 0.5, -9), BackgroundTransparency = 1, BorderSizePixel = 0, Parent = btn})
    Corner(bar, 2)
    local page = New("ScrollingFrame", {
        Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
        AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(), Visible = false, Parent = Pages,
    })
    New("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = page})
    New("UIPadding", {PaddingRight = UDim.new(0, 6), PaddingBottom = UDim.new(0, 8), Parent = page})
    OnAccent(function() page.ScrollBarImageColor3 = T.Accent end)

    local tab = setmetatable({Page = page, n = 0}, TabMT)
    local function show(active)
        page.Visible = active
        Tween(btn, 0.2, {BackgroundTransparency = active and 0.2 or 1})
        ic.TextColor3 = active and T.Accent or T.Sub
        tx.TextColor3 = active and T.Text or T.Sub
        bar.BackgroundTransparency = active and 0 or 1
        bar.BackgroundColor3 = T.Accent
    end
    tab.Show = show
    OnAccent(function() if page.Visible then show(true) end end)
    btn.MouseButton1Click:Connect(function()
        for _, t in ipairs(Window.Tabs) do t.Show(t == tab) end
    end)
    table.insert(Window.Tabs, tab)
    if #Window.Tabs == 1 then show(true) end
    return tab
end

-- Open / minimize / close
local Menu = {Open = true, Mini = false}
local function SetOpen(v) Menu.Open = v Main.Visible = v end
MinBtn.MouseButton1Click:Connect(function()
    Menu.Mini = not Menu.Mini
    Side.Visible, Pages.Visible = not Menu.Mini, not Menu.Mini
    Tween(Main, 0.25, {Size = Menu.Mini and UDim2.fromOffset(WIN_W, 44) or UDim2.fromOffset(WIN_W, WIN_H)})
end)

-- Floating mobile button
local Float = New("TextButton", {
    Position = UDim2.new(0, 14, 0.5, -60), Size = UDim2.fromOffset(44, 44), BackgroundColor3 = T.Panel, Text = "C",
    Font = Enum.Font.GothamBlack, TextSize = 22, TextColor3 = T.Accent, AutoButtonColor = false, Parent = Gui,
})
Corner(Float, 22)
local floatStroke = Stroke(Float, T.Accent, 0.2)
OnAccent(function() Float.TextColor3 = T.Accent floatStroke.Color = T.Accent end)
Drag(Float, Float)
do
    local down
    Float.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then down = Float.Position end
    end)
    Float.InputEnded:Connect(function(i)
        if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and down == Float.Position then
            SetOpen(not Menu.Open)
        end
    end)
end

------------------------------------------------------------------------
-- State
------------------------------------------------------------------------
local F = {}
local S = {WalkSpeed = 60, JumpPower = 80, FlySpeed = 70, FOV = 90, ESPDist = 2000, Clock = 14, MenuKey = Enum.KeyCode.RightShift}
local Orig = {
    Gravity = Workspace.Gravity, Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime, FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart, GlobalShadows = Lighting.GlobalShadows, Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient, FOV = (Workspace.CurrentCamera and Workspace.CurrentCamera.FieldOfView) or 70,
}
local function RestoreWorld()
    Workspace.Gravity = Orig.Gravity
    Lighting.Brightness, Lighting.ClockTime = Orig.Brightness, Orig.ClockTime
    Lighting.FogEnd, Lighting.FogStart = Orig.FogEnd, Orig.FogStart
    Lighting.GlobalShadows, Lighting.Ambient, Lighting.OutdoorAmbient = Orig.GlobalShadows, Orig.Ambient, Orig.OutdoorAmbient
    local cam = Workspace.CurrentCamera
    if cam then cam.FieldOfView = Orig.FOV end
end

------------------------------------------------------------------------
-- Fly
------------------------------------------------------------------------
local flyBV, flyBG
local function StopFly()
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
    local h = Hum()
    if h then h.PlatformStand = false end
end
local function StartFly()
    StopFly()
    local r, h = Root(), Hum()
    if not (r and h) then return end
    flyBV = New("BodyVelocity", {MaxForce = Vector3.new(9e9, 9e9, 9e9), Velocity = Vector3.zero, Parent = r})
    flyBG = New("BodyGyro", {MaxTorque = Vector3.new(9e9, 9e9, 9e9), P = 9e4, CFrame = r.CFrame, Parent = r})
    h.PlatformStand = true
end
Bind(LP.CharacterAdded, function()
    task.wait(0.6)
    if F.fly then StartFly() end
end)

------------------------------------------------------------------------
-- Click teleport tool
------------------------------------------------------------------------
local function GiveTPTool()
    local tool = New("Tool", {Name = "CortexSite TP", RequiresHandle = false, CanBeDropped = false, ToolTip = "Tap to teleport"})
    tool.Activated:Connect(function()
        local m, r = LP:GetMouse(), Root()
        if m and m.Hit and r then r.CFrame = CFrame.new(m.Hit.Position + Vector3.new(0, 3, 0)) end
    end)
    tool.Parent = LP:FindFirstChildOfClass("Backpack") or LP
end
Bind(UIS.InputBegan, function(i, gp)
    if gp or not F.clicktp then return end
    if i.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
        local m, r = LP:GetMouse(), Root()
        if m and m.Hit and r then r.CFrame = CFrame.new(m.Hit.Position + Vector3.new(0, 3, 0)) end
    end
end)
Bind(UIS.JumpRequest, function()
    if F.infjump then
        local h = Hum()
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

------------------------------------------------------------------------
-- ESP
------------------------------------------------------------------------
local ESP, ESPChar = {}, {}
local function DropESP(p)
    local o = ESP[p]
    if o then
        for _, v in pairs(o) do
            pcall(function()
                if typeof(v) == "Instance" then v:Destroy() else v:Remove() end
            end)
        end
    end
    ESP[p], ESPChar[p] = nil, nil
end
local function BuildESP(c)
    local head, root = c:FindFirstChild("Head"), c:FindFirstChild("HumanoidRootPart")
    if not (head and root) then return nil end
    local o = {}
    o.hl = New("Highlight", {Adornee = c, FillTransparency = 0.55, OutlineTransparency = 0, DepthMode = Enum.HighlightDepthMode.AlwaysOnTop, Parent = Gui})
    o.bb = New("BillboardGui", {Adornee = head, AlwaysOnTop = true, Size = UDim2.fromOffset(220, 40), StudsOffset = Vector3.new(0, 2.6, 0), Parent = Gui})
    o.txt = New("TextLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Font = Enum.Font.GothamBold, TextSize = 13, TextStrokeTransparency = 0.4, Text = "", TextColor3 = Color3.new(1, 1, 1), Parent = o.bb})
    if Drawing then
        local ok, ln = pcall(Drawing.new, "Line")
        if ok and ln then ln.Thickness = 1.5 ln.Visible = false o.line = ln end
    end
    return o
end
Bind(Players.PlayerRemoving, DropESP)

------------------------------------------------------------------------
-- Main loops
------------------------------------------------------------------------
local lastSafe, lastESP, fps = nil, 0, 60
local HUD = New("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.fromOffset(240, 24),
    BackgroundColor3 = T.Panel, BackgroundTransparency = 0.15, Text = "", Font = Enum.Font.GothamBold, TextSize = 12,
    TextColor3 = T.Text, Visible = false, Parent = Gui,
})
Corner(HUD, 12)
local hudStroke = Stroke(HUD, T.Accent, 0.4)
OnAccent(function() hudStroke.Color = T.Accent end)

Bind(RunService.Heartbeat, function(dt)
    fps = fps + (1 / math.max(dt, 1e-3) - fps) * 0.1
    local h, r = Hum(), Root()
    if h then
        if F.speed then h.WalkSpeed = S.WalkSpeed end
        if F.jump then h.UseJumpPower = true h.JumpPower = S.JumpPower end
    end
    if F.fly and flyBV and flyBG and r and h then
        local cf = Workspace.CurrentCamera.CFrame
        local d = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then d += cf.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then d -= cf.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then d += cf.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then d -= cf.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) or UIS:IsKeyDown(Enum.KeyCode.E) then d += Vector3.yAxis end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.Q) then d -= Vector3.yAxis end
        if d.Magnitude == 0 and h.MoveDirection.Magnitude > 0 then
            local flat = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
            local dot = flat.Magnitude > 0 and h.MoveDirection:Dot(flat.Unit) or 0
            d = h.MoveDirection + Vector3.new(0, cf.LookVector.Y * math.sign(dot), 0)
        end
        flyBV.Velocity = d.Magnitude > 0 and d.Unit * S.FlySpeed or Vector3.zero
        flyBG.CFrame = cf
    end
    if r and h then
        if h.FloorMaterial ~= Enum.Material.Air and r.Position.Y > Workspace.FallenPartsDestroyHeight + 80 then lastSafe = r.CFrame end
        if F.antivoid and lastSafe and r.Position.Y < Workspace.FallenPartsDestroyHeight + 60 then
            r.AssemblyLinearVelocity = Vector3.zero
            r.CFrame = lastSafe + Vector3.new(0, 4, 0)
        end
    end
    if HUD.Visible then
        local ping = 0
        pcall(function() ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        HUD.Text = string.format("CortexSite  |  %d FPS  |  %d ms  |  %d players", math.floor(fps), ping, #Players:GetPlayers())
    end
end)

Bind(RunService.Stepped, function()
    if F.noclip then
        local c = Char()
        if c then
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
            end
        end
    end
end)

Bind(RunService.RenderStepped, function()
    local cam = Workspace.CurrentCamera
    if F.fov and cam then cam.FieldOfView = S.FOV end
    if F.fullbright then
        Lighting.Brightness, Lighting.GlobalShadows = 2, false
        Lighting.ClockTime = 14
        Lighting.Ambient, Lighting.OutdoorAmbient = Color3.fromRGB(190, 190, 190), Color3.fromRGB(190, 190, 190)
    end
    if F.freezetime then Lighting.ClockTime = S.Clock end
    if F.nofog then Lighting.FogEnd, Lighting.FogStart = 1e6, 1e6 end

    if not F.esp then
        for p in pairs(ESP) do DropESP(p) end
        return
    end
    local now = os.clock()
    local slow = now - lastESP > 0.1
    if slow then lastESP = now end
    local myRoot = Root()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local c = p.Character
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            local root = c and c:FindFirstChild("HumanoidRootPart")
            local skip = (not hum) or (not root) or hum.Health <= 0 or (F.teamcheck and p.Team ~= nil and p.Team == LP.Team)
            local dist = (myRoot and root) and (myRoot.Position - root.Position).Magnitude or 0
            if skip or dist > S.ESPDist then
                DropESP(p)
            else
                local o = ESP[p]
                if not o or ESPChar[p] ~= c then
                    DropESP(p)
                    o = BuildESP(c)
                    if o then ESP[p], ESPChar[p] = o, c end
                end
                if o then
                    local col = (F.teamcolor and p.Team and p.TeamColor.Color) or T.Accent
                    o.hl.Enabled, o.hl.FillColor, o.hl.OutlineColor = F.chams and true or false, col, col
                    o.bb.Enabled = (F.names or F.health or F.distance) and true or false
                    if slow then
                        local parts = {}
                        if F.names then table.insert(parts, p.DisplayName) end
                        if F.health then table.insert(parts, math.floor(hum.Health) .. " HP") end
                        if F.distance then table.insert(parts, math.floor(dist) .. "m") end
                        o.txt.Text, o.txt.TextColor3 = table.concat(parts, "  |  "), col
                    end
                    if o.line then
                        if F.tracers and cam then
                            local pos, on = cam:WorldToViewportPoint(root.Position)
                            if on then
                                o.line.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                                o.line.To, o.line.Color, o.line.Visible = Vector2.new(pos.X, pos.Y), col, true
                            else
                                o.line.Visible = false
                            end
                        else
                            o.line.Visible = false
                        end
                    end
                end
            end
        end
    end
end)

Bind(LP.Idled, function()
    if F.antiafk then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

------------------------------------------------------------------------
-- TAB: Player
------------------------------------------------------------------------
local P = Window:AddTab("Player", "👤")
P:Section("Movement")
P:Toggle("Speed Hack", false, function(v)
    F.speed = v
    if not v then local h = Hum() if h then h.WalkSpeed = 16 end end
end)
P:Slider("Walk Speed", 16, 300, S.WalkSpeed, 1, function(v) S.WalkSpeed = v end)
P:Toggle("Super Jump", false, function(v)
    F.jump = v
    if not v then local h = Hum() if h then h.JumpPower = 50 end end
end)
P:Slider("Jump Power", 50, 400, S.JumpPower, 5, function(v) S.JumpPower = v end)
P:Toggle("Infinite Jump", false, function(v) F.infjump = v end)
P:Toggle("Noclip", false, function(v) F.noclip = v end)
P:Toggle("Fly  (WASD + Space/Ctrl)", false, function(v)
    F.fly = v
    if v then StartFly() else StopFly() end
end)
P:Slider("Fly Speed", 10, 300, S.FlySpeed, 5, function(v) S.FlySpeed = v end)
P:Section("Utility")
P:Toggle("Anti Void", false, function(v) F.antivoid = v end)
P:Toggle("Click TP  (Ctrl + Click)", false, function(v) F.clicktp = v end)
P:Button("Get Teleport Tool  (mobile)", GiveTPTool)
P:Button("Reset Character", function() local h = Hum() if h then h.Health = 0 end end)

------------------------------------------------------------------------
-- TAB: Visuals
------------------------------------------------------------------------
local V = Window:AddTab("Visuals", "👁")
V:Section("ESP")
V:Toggle("Enable ESP", false, function(v) F.esp = v end)
V:Toggle("Chams (Highlight)", true, function(v) F.chams = v end)
V:Toggle("Names", true, function(v) F.names = v end)
V:Toggle("Health", true, function(v) F.health = v end)
V:Toggle("Distance", true, function(v) F.distance = v end)
V:Toggle("Tracers  (needs Drawing API)", false, function(v)
    F.tracers = v
    if v and not Drawing then Notify("Tracers", "Executor has no Drawing API.", 4) end
end)
V:Toggle("Team Check", false, function(v) F.teamcheck = v end)
V:Toggle("Team Colors", false, function(v) F.teamcolor = v end)
V:Slider("Max Distance", 100, 5000, S.ESPDist, 50, function(v) S.ESPDist = v end)
V:Section("Camera")
V:Toggle("Custom FOV", false, function(v)
    F.fov = v
    if not v and Workspace.CurrentCamera then Workspace.CurrentCamera.FieldOfView = Orig.FOV end
end)
V:Slider("Field Of View", 30, 120, S.FOV, 1, function(v) S.FOV = v end)
V:Toggle("Unlock Camera Zoom", false, function(v)
    LP.CameraMaxZoomDistance = v and 1e5 or 128
    LP.CameraMinZoomDistance = 0.5
end)
V:Section("Lighting")
V:Toggle("Fullbright", false, function(v)
    F.fullbright = v
    if not v then
        Lighting.Brightness, Lighting.ClockTime, Lighting.GlobalShadows = Orig.Brightness, Orig.ClockTime, Orig.GlobalShadows
        Lighting.Ambient, Lighting.OutdoorAmbient = Orig.Ambient, Orig.OutdoorAmbient
    end
end)
V:Toggle("No Fog", false, function(v)
    F.nofog = v
    if not v then Lighting.FogEnd, Lighting.FogStart = Orig.FogEnd, Orig.FogStart end
end)

------------------------------------------------------------------------
-- TAB: World
------------------------------------------------------------------------
local W = Window:AddTab("World", "🌍")
W:Section("Physics")
local gravSlider = W:Slider("Gravity", 0, 400, math.floor(Orig.Gravity), 1, function(v) Workspace.Gravity = v end)
W:Button("Reset Gravity", function() gravSlider:Set(math.floor(Orig.Gravity)) Workspace.Gravity = Orig.Gravity end)
W:Section("Time")
W:Toggle("Freeze Time Of Day", false, function(v)
    F.freezetime = v
    if not v then Lighting.ClockTime = Orig.ClockTime end
end)
W:Slider("Clock Time", 0, 24, S.Clock, 0.5, function(v) S.Clock = v end)
W:Section("Performance")
W:Button("FPS Boost  (until rejoin)", function()
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    Lighting.GlobalShadows = false
    for _, o in ipairs(Workspace:GetDescendants()) do
        if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Smoke") or o:IsA("Fire") or o:IsA("Sparkles") then o.Enabled = false end
    end
    Notify("FPS Boost", "Effects disabled, quality lowered.", 3)
end)

------------------------------------------------------------------------
-- TAB: Teleport
------------------------------------------------------------------------
local TP = Window:AddTab("Teleport", "📍")
local function PlayerNames()
    local t = {}
    for _, p in ipairs(Players:GetPlayers()) do if p ~= LP then table.insert(t, p.Name) end end
    table.sort(t)
    return t
end
local selected
TP:Section("Players")
local playerDD = TP:Dropdown("Target Player", PlayerNames(), function(v) selected = v end)
Bind(Players.PlayerAdded, function() playerDD:SetOptions(PlayerNames()) end)
Bind(Players.PlayerRemoving, function() task.defer(function() playerDD:SetOptions(PlayerNames()) end) end)
TP:Button("Refresh Player List", function() playerDD:SetOptions(PlayerNames()) end)
TP:Button("Teleport To Player", function()
    local tp = selected and Players:FindFirstChild(selected)
    local tr = tp and tp.Character and tp.Character:FindFirstChild("HumanoidRootPart")
    local r = Root()
    if tr and r then r.CFrame = tr.CFrame * CFrame.new(0, 0, 3) else Notify("Teleport", "Select a valid player first.", 3) end
end)
TP:Toggle("Spectate Player", false, function(v)
    local cam = Workspace.CurrentCamera
    if v then
        local tp = selected and Players:FindFirstChild(selected)
        local th = tp and tp.Character and tp.Character:FindFirstChildOfClass("Humanoid")
        if th then cam.CameraSubject = th else Notify("Spectate", "Select a valid player first.", 3) end
    else
        cam.CameraSubject = Hum()
    end
end)
TP:Section("Waypoints")
local waypoints, wpNames, wpSel = {}, {}, nil
local wpDD = TP:Dropdown("Saved Waypoints", wpNames, function(v) wpSel = v end)
TP:Button("Save Current Position", function()
    local r = Root()
    if not r then return end
    local n = "Waypoint " .. (#wpNames + 1)
    waypoints[n] = r.CFrame
    table.insert(wpNames, n)
    wpDD:SetOptions(wpNames)
    Notify("Waypoint", n .. " saved.", 2)
end)
TP:Button("Teleport To Waypoint", function()
    local r = Root()
    if r and wpSel and waypoints[wpSel] then r.CFrame = waypoints[wpSel] else Notify("Waypoint", "Select a waypoint first.", 3) end
end)
TP:Button("Copy Current Position", function()
    local r = Root()
    if r and setclipboard then
        local p = r.Position
        setclipboard(string.format("%.1f, %.1f, %.1f", p.X, p.Y, p.Z))
        Notify("Position", "Copied to clipboard.", 2)
    end
end)

------------------------------------------------------------------------
-- TAB: Misc
------------------------------------------------------------------------
local M = Window:AddTab("Misc", "⚙")
M:Section("Session")
M:Toggle("Anti AFK", true, function(v) F.antiafk = v end)
M:Toggle("Stats HUD  (FPS / Ping)", false, function(v) HUD.Visible = v end)
M:Button("Rejoin Server", function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP) end)
M:Button("Server Hop", function()
    task.spawn(function()
        Notify("Server Hop", "Searching servers...", 3)
        local ok, res = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        end)
        if not ok or type(res) ~= "table" or not res.data then Notify("Server Hop", "Failed to fetch server list.", 4) return end
        local pool = {}
        for _, s in ipairs(res.data) do
            if s.id ~= game.JobId and s.playing < s.maxPlayers then table.insert(pool, s.id) end
        end
        if #pool == 0 then Notify("Server Hop", "No open servers found.", 4) return end
        TeleportService:TeleportToPlaceInstance(game.PlaceId, pool[math.random(#pool)], LP)
    end)
end)
M:Button("Copy Job ID", function() if setclipboard then setclipboard(game.JobId) Notify("Job ID", "Copied.", 2) end end)
M:Button("Copy Place ID", function() if setclipboard then setclipboard(tostring(game.PlaceId)) Notify("Place ID", "Copied.", 2) end end)

------------------------------------------------------------------------
-- TAB: Settings
------------------------------------------------------------------------
local ST = Window:AddTab("Settings", "🛠")
ST:Section("Interface")
ST:Keybind("Menu Toggle Key", S.MenuKey, function() SetOpen(not Menu.Open) end, function(k) S.MenuKey = k end)
local Themes = {
    Cyan = Color3.fromRGB(0, 200, 255), Purple = Color3.fromRGB(150, 80, 255), Crimson = Color3.fromRGB(255, 60, 90),
    Emerald = Color3.fromRGB(40, 220, 140), Amber = Color3.fromRGB(255, 180, 40), Pink = Color3.fromRGB(255, 90, 200),
}
ST:Dropdown("Accent Color", {"Cyan", "Purple", "Crimson", "Emerald", "Amber", "Pink"}, function(v) SetAccent(Themes[v]) end):Set("Cyan")
ST:Slider("Window Transparency", 0, 60, 4, 1, function(v) Main.BackgroundTransparency = v / 100 end)
ST:Section("Script")
ST:Label("CortexSite Universal v1.0\nSome features depend on the game and executor.")
ST:Button("Unload CortexSite", function() if env.CortexSite then env.CortexSite.Unload() end end)

------------------------------------------------------------------------
-- Unload
------------------------------------------------------------------------
CloseBtn.MouseButton1Click:Connect(function() SetOpen(false) Notify("CortexSite", "Hidden. Press " .. S.MenuKey.Name .. " or tap C.", 3) end)

local function Unload()
    for _, c in ipairs(Conns) do pcall(function() c:Disconnect() end) end
    table.clear(Conns)
    StopFly()
    for p in pairs(ESP) do DropESP(p) end
    RestoreWorld()
    local h = Hum()
    if h then h.WalkSpeed, h.JumpPower = 16, 50 end
    pcall(function() Gui:Destroy() end)
    env.CortexSite = nil
end
env.CortexSite = {Unload = Unload}

Notify("CortexSite", "Loaded. Menu key: " .. S.MenuKey.Name, 4)
