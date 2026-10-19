--[[
    CortexSite
    ==========
    Single-file clean-up of the deobfuscated hub (UI library + main script).
    Based on the "Venyx" hub (UI id VenyxSAE, game: Steal An Egg).

    Layout
      1. VM stub        - placeholder for helpers the dump no longer contains
      2. Library        - UI library (was proto f17)
      3. Main           - hub features   (was proto f60)

    Cleaned: Luraph VM wrapper + watermark comments removed, slots packed in the
    old upvalue table renamed (Shared.Game, Shared.LocalPlayer, ...), indentation fixed.
    Not recoverable: original local variable names (destroyed by the obfuscator).

    KNOWN GAP (216 call sites): the dump still calls VM helpers
      f:QT(...)  nested-closure factory (22 sites, bodies not in the dump)
      f:uT(...)  / f[N]  helper functions (41 / few sites)
      f:yT(...)  most likely SETLIST - table positional fill (153 sites)
    Their definitions lived in the part of the file that is cut off (it starts at "]").
    Until those are supplied, VM stub below raises a clear error instead of failing silently.
]]

-- 1. VM stub ---------------------------------------------------------------
local f = setmetatable({}, {
  __index = function(_, key)
    return function()
      error("CortexSite: unresolved VM helper '" .. tostring(key) .. "' (missing from dump)", 2)
    end
  end,
})
local p, y

-- 2. Library -----------------------------------------------------------------
local Library = (function()
  local s = {}
  local q = game
  s[1] = q
  local function q(G)
    local c = s[1]
    return c:GetService(G)
  end
  local G = q("UserInputService")
  local c = q("TweenService")
  local a = q("HttpService")
  s[10] = a
  local a = q("RunService")
  s[19] = a
  local a, i = q("Players").LocalPlayer, Enum
  s[4] = i
  local i = Color3.fromRGB
  local n = UDim2.new
  s[8] = n
  local n = UDim.new
  local M = Vector2.new
  local H, U = Font.new("rbxasset://fonts/families/Montserrat.json", s[4].FontWeight.SemiBold), Font.new("rbxasset://fonts/families/Montserrat.json", s[4].FontWeight.Bold)
  local L = Font.new("rbxasset://fonts/families/Montserrat.json", s[4].FontWeight.ExtraBold)
  local I = Font.new("rbxasset://fonts/families/RobotoMono.json", s[4].FontWeight.SemiBold)
  local t = Font.new("rbxassetid://12187365977", s[4].FontWeight.Bold)
  local B = {bg = i(16, 18, 40), tx = i(242, 244, 255), a1 = i(122, 162, 255), a2 = i(185, 139, 255), g1 = i(255, 229, 138), g2 = i(255, 155, 88), dk = i(42, 18, 0), mint = i(110, 255, 182), red = i(255, 110, 110), sky = i(143, 180, 255), pink = i(255, 158, 207), vio = i(199, 166, 255), gold = i(255, 210, 122), wh = i(255, 255, 255), val = i(217, 222, 255), dc = i(88, 101, 242), pn = i(24, 26, 54), w1 = i(36, 40, 86), w2 = i(14, 15, 34), gv = i(184, 255, 156), on = i(255, 255, 254)}
  local K = {{"Twilight", i(36, 40, 86), i(14, 15, 34), i(122, 162, 255), i(185, 139, 255)}, {"Aurora", i(10, 84, 82), i(4, 26, 38), i(63, 224, 176), i(127, 255, 216)}, {"Ocean", i(8, 70, 128), i(3, 20, 52), i(47, 185, 221), i(127, 220, 255)}, {"Midnight", i(52, 24, 112), i(10, 4, 36), i(118, 100, 226), i(160, 132, 240)}, {"Sakura", i(118, 44, 96), i(36, 12, 40), i(255, 140, 200), i(255, 196, 228)}, {"Onyx", i(58, 46, 22), i(8, 6, 2), i(255, 206, 110), i(255, 150, 80)}, {"Black", i(50, 50, 56), i(16, 16, 19), i(250, 251, 255), i(176, 182, 198), i(14, 14, 18)}, {"Mono", i(92, 94, 104), i(30, 31, 36), i(250, 251, 255), i(196, 200, 214), i(20, 21, 26)}}
  local P, C = {B.gold, B.mint, B.sky, B.pink, B.vio}, {LeftShift = "LShift", RightShift = "RShift", LeftControl = "LCtrl", RightControl = "RCtrl", LeftAlt = "LAlt", RightAlt = "RAlt"}
  local J = s[8](1, 0, 1, 0)
  local v = s[8](0.5, 0, 0.5, 0)
  local N = M(0.5, 0.5)
  local z = M(1, 0.5)
  local Y = s[4].TextXAlignment.Center
  local l = s[4].HorizontalAlignment.Center
  local u = s[4].FillDirection.Horizontal
  local j = s[4].AutomaticSize.Y
  local g = s[4].AutomaticSize.X
  local O = s[4].TextTruncate.AtEnd
  local h = s[4].VerticalAlignment.Center
  local R = s[8](1, 0, 0, 0)
  local _ = s[8](1, 0, 0.5, 0)
  local r = M(1, 0)
  s[7] = r
  local r = s[4].EasingStyle.Quint
  local V, k, F = s[4].EasingStyle.Back, 46, 54
  local function Q(D, T)
    local d = s[8]
    return d(0, D, 0, T)
  end
  local D, T = {}, {"home", "zap", "egg", "farm", "leaf", "eye", "user", "settings", "search", "minus", "x", "shield", "target", "crosshair", "key", "palette", "folder", "star", "check", "down", "gauge", "wind", "ghost", "clock", "coins", "pin", "info", "warn", "ok", "sliders", "grid", "server", "flame", "swords", "trash", "save", "copy", "plus", "refresh", "crown", "gem", "hand", "wand", "sparkles", "discord"}
  for d, e in ipairs(T) do
    D[e] = d - 1
  end
  local T, d = "tienkhanh1/venyx-assets@main/venyx-icons3.png"
  local e = f:QT(1, 2, {[1] = s}, p, y, nil)
  local function m()
    if d == nil then
      d = e("Venyx/icons3.png", {"https://raw.githubusercontent.com/" .. T:gsub("@", "/"), "https://cdn.jsdelivr.net/gh/tienkhanh1/venyx-assets@main/venyx-icons3.png"}) or false
    end
    local T = d
    return T
  end
  local T, d = {Opt = {}, Keys = {}, Alias = {}, th = K[1][1]}, {AutoLoad = true, AutoSave = true, Active = "Default", Theme = "Black", Cfg = 2}
  s[2] = T
  s[11] = d
  s[2].State = s[11]
  local T = {}
  local function d(x, b)
    local S = T
    S[#T + 1] = x:Connect(b)
  end
  local function x()
    local b = {}
    for S = 1, 10, 1 do
      b[S] = string.char(math.random(97, 122))
    end
    return table.concat(b)
  end
  s[3] = function(b, S)
    local w = Instance.new(b)
    w.Name = x()
    b = S.Parent
    S.Parent = nil
    for Z, W in next, S, nil do
      if type(Z) == "number" then
        W.Parent = w
      else
        w[Z] = W
      end
    end
    w.Parent = b
    return w
  end
  local b = {BackgroundTransparency = 1, BorderSizePixel = 0, BackgroundColor3 = B.wh}
  local function S(w, Z, W)
    local function A(X)
      local E = {Z, b}
      for b, b in ipairs(E) do
        for Z, o in next, b, nil do
          if X[Z] == nil then
            X[Z] = o
          end
        end
      end
      if W then
        if X.TextSize then
          X.TextSize = math.floor((X.TextSize * 1.18) + 0.5)
        end
      end
      local b = ((X.TextTruncate == O) and not X.AutomaticSize) and X.TextSize
      if b then
        X.TextTruncate = nil
      end
      E = s[3]
      local Z = E(w, X)
      if b then
        local function w()
          if Z.AbsoluteSize.X < 2 then
            return
          elseif Z:GetAttribute("nofit") then
            return
          elseif Z.TextSize == b then
            if Z.TextBounds.X <= Z.AbsoluteSize.X then
              return
            end
          end
          Z.TextSize = b
          local b = Z:GetAttribute("alt")
          if b then
            if Z.Text ~= b then
              if Z.TextBounds.X > Z.AbsoluteSize.X then
                Z.Text = b
                return
              end
            end
          end
          while true do
            local b, W = Z.TextBounds.X, Z.AbsoluteSize
            if not ((b > W.X) and (Z.TextSize > 8)) then
              break
            end
            Z.TextSize = Z.TextSize - 1
          end
        end
        Z:GetPropertyChangedSignal("Text"):Connect(w)
        Z:GetPropertyChangedSignal("AbsoluteSize"):Connect(w)
      end
      return Z
    end
    return A
  end
  local b, w = {FontFace = H, TextColor3 = B.tx, TextSize = 13, TextXAlignment = s[4].TextXAlignment.Left}, S("Frame", {})
  s[6] = w
  local w = S("Frame", {BackgroundTransparency = 0})
  local Z = S("TextButton", {Text = "", AutoButtonColor = false}, true)
  local W = S("TextLabel", b, true)
  local A = S("TextBox", {Text = "", PlaceholderColor3 = i(178, 180, 188), ClearTextOnFocus = false, FontFace = H, TextColor3 = B.tx, TextSize = 13, TextXAlignment = b.TextXAlignment}, true)
  local H = S("ScrollingFrame", {ScrollBarThickness = 2, ScrollBarImageTransparency = 0.6, CanvasSize = s[8](), AutomaticCanvasSize = j, ScrollingDirection = s[4].ScrollingDirection.Y})
  local b = S("ImageLabel", {})
  local function S(X)
    local E = D[X.Image]
    if E then
      local o = m()
      X.Image = o or ""
      if o then
        X.ImageRectOffset = M((E % 8) * 64, (E // 8) * 64)
        X.ImageRectSize = M(64, 64)
      end
    end
    return b(X)
  end
  local function m(X, E, o, fO)
    return S({AnchorPoint = N, Position = v, Size = Q(E, E), Image = X, ImageColor3 = o, ImageTransparency = fO})
  end
  local function X(E)
    return "rbxthumb://type=AvatarHeadShot&id=" .. (a.UserId .. ("&w=" .. (E .. ("&h=" .. E))))
  end
  local function E(o)
    local fO = s[3]
    return fO("UICorner", {CornerRadius = (o and n(0, o)) or n(1, 0)})
  end
  local function o(fO, pO)
    local yO, sO, qO = s[3], {Transparency = fO, Color = pO or B.wh}, s[4]
    sO.ApplyStrokeMode = qO.ApplyStrokeMode.Border
    return yO("UIStroke", sO)
  end
  local function fO(pO, yO, sO)
    local qO = s[3]
    return qO("UIGradient", {Color = ColorSequence.new(pO, yO), Rotation = sO or 0})
  end
  local function pO(yO, ...)
    local sO, qO = {}, {...}
    for GO, cO in ipairs(qO) do
      sO[GO] = NumberSequenceKeypoint.new(cO[1], cO[2])
    end
    qO = s[3]
    return qO("UIGradient", {Rotation = yO, Transparency = NumberSequence.new(sO)})
  end
  local function yO(sO, qO, GO, cO)
    local aO = s[3]
    return aO("UIPadding", {PaddingTop = n(0, sO), PaddingRight = n(0, qO or sO), PaddingBottom = n(0, GO or sO), PaddingLeft = n(0, (cO or qO) or sO)})
  end
  s[9] = function(sO, qO, GO, cO)
    local aO, iO, nO = s[3], {Padding = n(0, sO or 0), HorizontalAlignment = qO, VerticalAlignment = GO, FillDirection = cO}, s[4]
    iO.SortOrder = nO.SortOrder.LayoutOrder
    return aO("UIListLayout", iO)
  end
  local function n(sO, qO, GO)
    local cO = s[6]
    return cO({Parent = sO, Position = qO, Size = GO, BackgroundTransparency = 0.9})
  end
  local function sO(qO, GO, cO, aO, iO, nO)
    local MO, HO, UO, LO = TweenInfo.new, cO or 0.25, aO or r
    if iO then
      LO = iO
    else
      cO = s[4]
      LO = cO.EasingDirection.Out
    end
    iO = c:Create(qO, MO(HO, UO, LO, 0, false, nO or 0), GO)
    iO:Play()
    return iO
  end
  local function qO(GO, cO, aO)
    d(GO.MouseEnter, function()
      sO(GO, {BackgroundTransparency = cO}, 0.15)
    end)
    d(GO.MouseLeave, function()
      sO(GO, {BackgroundTransparency = aO or 1}, 0.25)
    end)
  end
  local function GO(cO, aO, iO)
    local function nO()
      if not (iO()) then
        aO.Visible = false
      end
    end
    cO.Completed:Connect(nO)
  end
  local function cO(aO, ...)
    if aO then
      pcall(aO, ...)
    end
  end
  local function aO(iO)
    local nO, nO, MO = s[4], iO.UserInputType == s[4].UserInputType.MouseButton1
    if nO then
      MO = nO
    else
      local nO
      nO, MO = s[4], iO.UserInputType == s[4].UserInputType.Touch
    end
    return MO
  end
  local iO = {p = Vector3.zero, t = 0, m = 0}
  d(G.InputBegan, function(nO)
    if aO(nO) then
      iO.p, iO.t = nO.Position, os.clock()
      iO.m = 0
      iO.s = false
    end
  end)
  d(G.InputChanged, function(nO)
    local MO, MO, HO = s[4], nO.UserInputType == s[4].UserInputType.Touch
    if MO then
      HO = MO
    else
      local MO
      MO, HO = s[4], nO.UserInputType == s[4].UserInputType.MouseMovement
    end
    if HO then
      iO.m = math.max(iO.m, (nO.Position - iO.p).Magnitude)
    end
  end)
  local function nO()
    return ((iO.m < 14) and ((os.clock() - iO.t) < 0.45)) and not iO.s
  end
  local function MO(HO, UO)
    d(HO.Activated, function(...)
      if nO() then
        UO(...)
      end
    end)
  end
  local function HO(UO)
    local LO = tostring(UO)
    local UO, IO = LO:match("^(%-?%d+)(.*)$")
    if not (UO) then
      return LO
    end
    return UO:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^(%-?),", "%1") .. IO
  end
  local function UO(LO, IO, tO, BO)
    local KO, PO, CO = LO.AnchorPoint, LO.Position, LO.Size
    if not (LO.Parent:FindFirstChildWhichIsA("UIGridStyleLayout")) then
      LO.AnchorPoint = N
      local JO = s[8]
      LO.Position = PO + JO((0.5 - KO.X) * CO.X.Scale, (0.5 - KO.X) * CO.X.Offset, (0.5 - KO.Y) * CO.Y.Scale, (0.5 - KO.Y) * CO.Y.Offset)
    end
    CO = s[3]
    local KO = CO("UIScale", {Parent = LO})
    tO = tO or LO
    d(tO.InputBegan, function(LO)
      if not (aO(LO)) then
        return
      end
      sO(KO, {Scale = IO or 0.96}, 0.12)
      if BO then
        BO(true)
      end
    end)
    d(tO.InputEnded, function(LO)
      if not (aO(LO)) then
        return
      end
      sO(KO, {Scale = 1}, 0.4, V)
      if BO then
        BO(false)
      end
    end)
  end
  local function LO(IO, tO)
    return {p = IO, v = M(), t = IO, a = tO}
  end
  local function IO(tO, BO)
    if (tO.t - tO.p).Magnitude < 0.03 then
      if tO.v.Magnitude < 0.03 then
        return
      end
    end
    BO = math.min(BO, 0.05)
    local KO = math.ceil(BO * 240)
    local PO = BO / KO
    for BO = 1, KO, 1 do
      tO.v = tO.v + ((((tO.t - tO.p) * 230) - (tO.v * 29)) * PO)
      tO.p = tO.p + (tO.v * PO)
    end
    tO.a(tO.p)
  end
  local function tO(BO, KO, PO)
    local CO, JO, vO, NO
    local function zO()
      local YO, lO = CO.UserInputType, s[4]
      return YO == lO.UserInputType.Touch
    end
    d(BO.InputBegan, function(BO)
      if not (CO) then
        if aO(BO) then
          local YO, lO = M(BO.Position.X, BO.Position.Y), KO.t
          CO, JO, vO, NO = BO, YO, lO, false
        end
      end
    end)
    d(G.InputChanged, function(BO)
      if not (CO) then
        return
      end
      if zO() and (BO ~= CO) then
        return
      elseif not (zO()) then
        local YO = s[4]
        if BO.UserInputType ~= YO.UserInputType.MouseMovement then
          return
        end
      end
      local YO = M(BO.Position.X, BO.Position.Y) - JO
      NO = NO or (YO.Magnitude > 5)
      if NO then
        KO.t = PO(vO + YO)
      end
    end)
    d(G.InputEnded, function(BO)
      if CO then
        if BO == CO then
          CO = nil
        elseif not (zO()) then
          local KO = s[4]
          if BO.UserInputType == KO.UserInputType.MouseButton1 then
            CO = nil
          end
        end
      end
    end)
    local function BO()
      local KO = NO
      return KO
    end
    return BO
  end
  local function BO(KO, PO, CO, JO, vO)
    local NO, zO, YO, lO, uO = {Parent = KO, AnchorPoint = vO, Position = JO, Size = Q(PO, CO)}, E(), fO(B.g1, B.g2, 45), {AnchorPoint = M(0.5, 1)}, s[8]
    lO.Position = uO(0.5, 0, 1, -((CO * 0.12) // 1))
    lO.Size = Q((PO * 0.45) // 1, (PO * 0.45) // 1)
    lO.BackgroundColor3 = i(255, 246, 214)
    f:yT(lO, 0, E())
    f:yT(NO, 0, zO, YO, w(lO))
    return w(NO)
  end
  local KO = {"Venyx/mark1.png", {"data:iVBORw0KGgoAAAANSUhEUgAAAIYAAACACAYAAADOIBGMAAAPWklEQVR4nOydedRd0xnGn8/qH6VKQtIEFVESJTGFGKrRIk1Lo9RUZZWlWLS0S9qaaQ1VStAGCdpGzFMQjURVUkPNpVTFGErNbRUd1Oo/PI+7b9Z1c+6Z9rvvOefe81trr/199557hr3f8+7pfd+9DGpqIlgGNTUR1IJRE8kSwXjvvfdWYLqOaRxq+grW+eZMVzMt2/xsiWAMDAz8i9kzTA/xgCNQ0xewrk9idh/TE5SB/zU/H2g76BPMXmb6CNPNTHvw4P+gpudgXQ9hNpvpc0z/ZxrGun6r+f2H+hj84m/MrnD/bs+0iCfYCjU9BetUdfsYGkIhLmoVChHV+Ty/5e8RTHfxRMegpidgXZ7FbD7TsJaPz28/binBoOTcy+yqto9P4QmvZFoONZWEdbcS0wL+OaXtK2mLR9qP7zRcPS/isz2ZHuXJx6OmUrDOvshsEdN2EV9Pj/pNpGBQgu5idm/EV2sxPcAL7Y2aSsC6+g6z3zANj/j6Ntb1g1G/i5vgOj3mu8t4we+jptSwjo5lNi3mkFM7fTGA+BO/xGy1mENOo8QdjZrSwbqbyizu5X2BdTey05dJU+KnJ3x/FG/gUtSUBg0QmG5EvFCI2LpN0hgrMnuVaVnEs5Bpx9aZs5ruw/r6OBr9ic8kHKpZ7lVYX+90OiBWY/CHb6NDr7UN9Xbn88Y+hppCYNkPQuMFTRIKcW6cUIhYjeEuqGny15GOu5m250X/jZquwTpamdltTOunOPxdptVZR/+IOyhx2d1Nk09DOjR9fqtTaTVdwL24v0c6oRBnJgmFSNQY7uJj0JhbT4tW6ybyBv6LmmCwXoYyu4Np3Qw/G816eSbpoFSGOjyRZs1uQXq2YJqDmmC4gYGmuLMIxdw0QiGyWHCdjWxM5M3/GjXmsFyXR2P0sQGycVbaA1M1JS03pOnTTZCN6ymlu6LGBGdl9VumzyIb97AeUptQZLX5nIXs7MKHqZsVO65BdqEQs7IcnFVjaNld0+SDkZ3zKLGHoiY3LP8LmR2I7GhkOTLLBGQmjeEmRc5EPg7hg30XNblg2R2OfEIhzsg6K51JYwg3uym70BWRj0m8yVtRkxqW+WRmc5EPzVloQuvdLD/K7Ffi5iauQH5m80HXQU0qWFZjmV2J/MzMKhQir8PR+cjPCmgIx6dQEwvLaCQanc3lkZ9fIAe5BIMS+Ciz3yE/eguuQk1H3FzFPGSbwGpnHutqMXLg46LoozXEeD58kr1HP3MJ03rwI+0a11Jk7ny2worV+skY+LEXpdqnDe05WK4nMvsh/Lif5boFcuLr1OzTCV1yDhbEhqj5AJbFV+AvFGI2PPDVGJro0tA1ycIrib8wbeT8Z/sW1yFX/83X4EleZav7uJd6aQxe+E1mF8GfNZkuRs1l8BcKcZGvz7FFfIxzYMPOzgeiL+GzH8lsS9hwLjzxakqauEWynWDD+pT2LEZBlYfltxGzh2HDNSy/r8ETq4g6vkPXVmaij3DzFVfDjhkwwEQwKKEyGklrMJyE5jdORv+gfsVo2PAc6+J2GGAZg+tU2HEchSOrQVDl4DN+AXZNsDCbMDTpYwg3dP0n7FA/Y3yeBaAq4JqQB+A35d3O8lYG2GYaww1dLSa8mmg95UfoXU6DrVBcbmmVb6YxBN+CbeC3uBbFBBeWoWdgOclzbwFs2dAtbppgKhiCD30/s81gxxNM43qlSXHGvHLHWBN2PMTy2RSGhAgAewlskbr9MXoHNSGWQiFy2VzEEUJjaEr3r0wrwZa1+VY8iwrDstEy+iLY8nemEdYa1VxjuA6QySRLGz9B9Unt8JOBs0M0s+YaQ/DNWB0NrWGN/GEXooKwTOR05bUU3oGhaZyUsxIkyDxv9EU0vKWs+Rmqy1TYMzeEUIiQuw+EUJtj+ebthorhohyOhD0hyvgDgjQlTVggMsAZCVue4lvyaVQIlsNzsB+JLGY5jEIgQu9XYrnq2mQdFnRlXB3dTg7WQiGs7GAiCa0xPsnsRdgjX8xRZTcFdIFNNMQOEWFoaKj+hQiqMXjjcoD+FexReKEjUX5OQBihODekUIigGkPwrVF/4AmEYZiLEVY6nGFvqAm5UXkdidISfE80PsCTzEI5MZdZa5yEMMwLLRQiuMYQfHt2R8MHMwRDWFBvoETweWWR9RTCsBOfN3gIq67sosgHuRZhZkLFQSgfUxCGxd0QCtHN7TVDaYzDnDVUKeC9rMLsYIQhVBkuRTcFI8ToRGhIaOHSZ8VRCIeFc1cqutLHaMK36ZfM9oc98rpareh5DW0vhUaMMl+XzShm8Pm+jS7RTY0hzkMY1JTsgeLRmkgIoRChyi6SrmoMwbdKIY63hj2P843yDcngBZ9NUXfXhj3z+WxfRhfptsYQeaP+JbGe89MoBF57R4QRCtH1ADNd1xiChagxvpX3VSsL+GYVIhx8pjuZTYA9hWjCIjSGCGWmN9Et3HUVXlO7S4YQClGIu2ZRgiEn3lCzld9C9wk1WniF2qKQIHaFCIYzXs0dOCyBvNFzc+H8RL6JMPwUBVGUxhASjBBbZA1lZXnHh8iAhsmDYI9cPs39RdJSmGBQayhOVCibxa5NBCHcWs3UInelLGRU0sTt/KeZwhC7L45w1urBCGhzISeiNQcK3DqsyKakqTV+jjB0Y9U11GLZmQMF7ydXqMYQzi4yhBXWoyzcoPFDA83H6GUZUfQWpYVqDMECkNoMsQ6wQcg5DZ5bztYhJummFS0UonDBcGTdiC8tSfub+xBiUx51NkMN4zNRCsFwXuwhjFD2RTj2hj3Ty2KmWHgfo0nAHv62LOzbYAjvdXtm82HPYNchL5yyNCXSGnLjCzGvEcLX9auw57SyCIUojcYQfBOHM3sVtrzGAl8FhvA+pe4tA8Oob7GG64iXgtJoDMGCeQ32HdHhrMgvwQieS3E5raMFTSuTUIhSCYZDgWStVeqesMPyXEJzOIUtlnWidILh3pzDYItJ9F0XX2xn2DLFxUgtFWXUGBIO7V1i6aA0iJW6C/zR7kMfhR3P8lktg+aaUUrBcFj7ilg0AdbNyNEoKaUalbTDt/xx2IVVlnHQsLy+JyFipfNe1kdJKbPGEEfADjUBPib41nMX30OJKbVg8I26CbbR/3w6oZYTZXPKvr99qZsS4bbefAQ2vMkKyTUHwfuQG6SVQdFo3sczKDFlb0qkNf4Eu+0pBrOCM5v58zeTYScUM8ouFKL0guE4Aw1zNwv2QXasjItlZ3ECKkAlBMMZxVptrZWpn0FtsRyzHWGD+kxDUAGqojEkHFpDeRL+DHV+pmnZgWlF+KNguNoPdRGvfyPTeBQAr7st02ym2HgllREMh5WXWZahp9Uw9TAK9z1o7PWmGdQHWDk3Ma2DLuAE4kH+qSD9Cnh/U9zxpR+VtMOHuwH+6xVvsZIGpzmQ13ub2Qrw40peby93vqhAdcfz+yCb9bidIKYzTW75eBGvNzbud1XTGEKhjHwj5wxK05y4gPa+QqEFsiVbk7tAdX9oO+ZkXuslJtMFOp7vODR2apzc9tWxSb+tnGCwYGWyPx3+7JXimDwjmHbOibDjjIrqtxrTDazME+GJgtUxaXFOnvLD276+nfdzY9I5KteUCBelT3MBw+HHqiykVztcYwSzF+CHvOxGR7ka8vxz0HmEpKH5xDy7IvK8mzOTh/zIDod8nue9I+E0lWxKpDU0C2nhnxq3FmMRfe+Qgc7+p3GuDXLCulMdRmSAx+ue70Nnobg0jVCISmqMJk5dfh35eYMFNSTivAoM/zL8AsTP4rn3izuA11FY6eMRz0E8z4UJ55EGlZaIWySU9hqTdnW5khqjhRPgx8qug9aObEF8dw1I01dQZKGkuZkLeI8dTf/4nfomdyN55XjfLCYHlRYMPujT8HeKPsZF8/0A/r0Gsx/Aj1N4b88nHeQCyGjkk7QL4hG8r1ntH/KzTZg9xLRBwu/lmpBpB+1KNyWChSM7C3VEffxUVbgKTqvpb3mvJRV0HM+zEjLtaMRnUESeNJGTZYKwm3xb+RtNvF2O5LiiC3n8RGSk8oIh3Pj/BpSDHVgRNyMjfAYtFKbRVH9EQ4jSOILLbnZcHrfHnhAMkbIjF5rjWAmnICd8Bu0sYLVgJyQUDyMHPSMYImBk3jT8mZXg0wQ13RM03BwLf3ZOM5HViaqPStopUmN4W7W7KDrboLES68M+PkIhekowXEzMzO27AVfx2nNggNsET9GN826Gtz/PcSk86ammRFAdr4rG3ECI3QujeJ1pXWtvMj7HODT2kstio7o778Nk//hea0r0xr3CrJsb9h44EMDFkOfU6GNehp9cbyUUoucEQ7CALkG2Qs3LTF5rLgJAjaFdrr+R4Se78DdmEYR6rilpwkLSGohWJ01jY7SgEdDGAwHCLvLeZb+RNxaXyS6LPSsYwu1fYumw1IqEwsrfZQm8Z5nd+TQJml6fwHt7EB70ZFPSxHl7hfAmPyOQUGwJ//vVEsHNbs0nNz2tMQQLaBgaoxSrQPCKFTZ2wDjON+9zY2baDMdqq1BZum2W14m7pzWGYMFoOGkZenH3AEKh/pA6sUlCIQMlLYhpJ8qke5D1+bXISc8LhmBFKvSiRbyNQ90w0prr0LD5jEPW6tvw+lotncm/t2NK6vhOirPliKPnm5JWWEjaWSnvNpwyi7MwDv4QKVdVNTcziddf1PbbTZndguRJsF352+uRgX4TDM2KKhhLVs8yNUdjBoyj9vJ+5HiUtKYhDTU5xmhZ+7EtQGc7T/EOGqOop5GSvmhKmrhZ0TRuA+0cEEAo1Bm+IOEwrXlM6CQUwoXb1sLbYzHnkQFSpt2S+kowhOtvZNn79RgXwMWaqYh3fzhYTRfTO0hAZoQubFOcmePWFMbUM6l91ZS0wkKSit444bB7WOBbwf7acgtY2OFr9SNkvpfLgZvnlkbUdHrUIqJWbEelCU3ddxqjBfmQxu0Lshj2MT2bdJru1sTZ2LxCIVx4SEUhujviaw2LU43O+lZjCL5dCnHQabEtSDgkXlMjm4vbPlbUoP3ymuHFXEvRAbT9d+v8SKq45f2sMZr9jagVyQMGwoVDavVqf8VdayNroRA85wxmo/DhtRdZlU9J+m1fC4ZwS/TntHx0Ij9LY8qfGb7BBzBTWAJ5hR3OtFaoazVR4H4mNZuT0JgmF4fyXmKH7H3dlDRxuy1rLuAlFmKwzXx5HbXvj2WdbDK+BzWfijE6l/fRcRRTC0ZNJH3flNREUwtGTSTvAwAA///2y1mvAAAABklEQVQDALNzu4AFm6hAAAAAAElFTkSuQmCC"}}
  local function PO(CO, JO, vO, NO, zO, YO)
    local lO = BO(CO, JO, vO, NO, zO)
    task.spawn(function()
      local BO = e(KO[1], KO[2])
      if BO then
        if not (CO.Parent) then
          return
        end
      else
        return
      end
      YO.Parent = CO
      YO.Image = BO
      S(YO)
      lO:Destroy()
    end)
  end
  local function e(BO, KO, CO)
    local JO = s[6]
    local vO, NO = JO({Parent = BO, AnchorPoint = z, Position = _, Size = Q(KO, CO), BackgroundTransparency = 0.84, E()}), s[6]
    local BO = NO({Parent = vO, Size = J, E(), fO(B.a1, B.a2)})
    NO, JO = {Parent = vO, AnchorPoint = M(0, 0.5)}, s[8]
    NO.Position = JO(0, 3, 0.5, 0)
    NO.Size = Q(CO - 6, CO - 6)
    NO.ZIndex = 2
    f:yT(NO, 0, E(), o(0.6, i(0, 0, 0)))
    local JO = w(NO)
    local function vO(NO, zO)
      local YO = (zO and 0) or 0.26
      sO(BO, {BackgroundTransparency = (NO and 0) or 1}, YO)
      local BO, zO = {}, s[8]
      BO.Position = zO(0, (NO and ((KO - CO) + 3)) or 3, 0.5, 0)
      sO(JO, BO, YO)
    end
    return vO
  end
  local function BO(KO, CO, JO, vO, NO)
    d(KO.Focused, function()
      sO(CO, {Transparency = JO, Color = B.a1}, 0.2)
    end)
    d(KO.FocusLost, function()
      sO(CO, {Transparency = vO, Color = B.wh}, 0.25)
      if NO then
        NO()
      end
    end)
  end
  local function KO(CO, JO)
    local vO = o(0.86)
    CO.BackgroundTransparency = CO.BackgroundTransparency or 0.92
    CO[1] = E(9)
    CO[2] = vO
    local NO, zO = {}, s[8]
    NO.Position = zO(0, 10, 0.5, -9)
    NO.Size = Q(18, 18)
    NO.Image = "search"
    NO.ImageTransparency = 0.3
    CO[3] = S(NO)
    CO.ClipsDescendants = true
    zO, NO = {}, s[6]
    zO.Parent = NO(CO)
    zO.Position = Q(35, 0)
    NO = s[8]
    zO.Size = NO(1, -43, 1, 0)
    zO.PlaceholderText = JO
    zO.TextSize = 14
    zO.ClipsDescendants = true
    NO = A(zO)
    BO(NO, vO, 0.55, 0.86)
    return NO
  end
  local CO, JO = {ok = B.mint, warn = B.gold, err = B.red}, {ok = "ok", err = "x", warn = "warn"}
  local function vO(NO)
    return CO[NO] or B.sky, JO[NO] or "info"
  end
  local function CO(JO)
    for NO, NO in ipairs(JO:GetChildren()) do
      if NO:IsA("GuiObject") then
        NO:Destroy()
      end
    end
  end
  local function JO(NO)
    return {Set = function(zO, YO, lO)
      zO = NO[YO]
      if zO then
        if zO.Text ~= lO then
          zO.Text = lO
        end
      end
    end, Icon = function(zO, YO, lO)
      zO = NO[YO] and NO[YO].Parent:FindFirstChildOfClass("ImageLabel")
      if zO then
        if zO.Image ~= lO then
          zO.Image = lO
        end
      end
    end}
  end
  local function NO(zO, YO, lO, uO, jO)
    local gO, OO = {Parent = zO}, s[8]
    gO.Position = OO(lO / uO, (lO * 8) / uO, 0, 0)
    lO = s[8]
    gO.Size = lO(1 / uO, (8 / uO) - 8, 1, 0)
    gO.BackgroundTransparency = (jO and 0) or 0.92
    lO, zO = E(13), jO and fO(B.a1, B.a2, 90)
    OO, uO = zO or o(0.84), jO and o(0.55, B.a1:Lerp(B.wh, 0.5))
    local zO, hO = uO or nil, {Size = J, Text = YO, FontFace = U, TextSize = 16}
    hO.TextColor3, hO.TextXAlignment = (jO and B.on) or B.wh, Y
    f:yT(gO, 0, lO, OO, zO, W(hO))
    jO = Z(gO)
    UO(jO)
    return jO
  end
  local zO = {}
  zO.__index = zO
  local function YO(lO)
    if lO.bq then
      return
    elseif lO.done == #lO.list then
      return
    end
    lO.bq = true
    task.defer(function()
      lO.bq = false
      local uO, jO, gO = {0, 0}, table.clone(lO.list), {}
      table.sort(jO, function(OO, hO)
        return OO.card.AbsoluteSize.Y > hO.card.AbsoluteSize.Y
      end)
      local OO, hO = true, true
      for RO, _O in ipairs(jO) do
        RO = _O.side or (((uO[1] <= uO[2]) and 1) or 2)
        if OO then
          local jO = _O.side
          OO = if jO then _O.side == 3 else not jO
        else
        end
        gO[_O] = RO
        if RO < 3 then
          uO[RO] = uO[RO] + (_O.card.AbsoluteSize.Y + 16)
        end
        hO = hO and (_O.card.AbsoluteSize.Y > 40)
      end
      OO = OO and (gO[lO.list[1]] == 2)
      for uO, jO in next, gO, nil do
        jO = ((OO and (jO < 3)) and (3 - jO)) or jO
        if uO.card.Parent ~= lO.cols[jO] then
          uO.card.Parent = lO.cols[jO]
        end
      end
      if hO then
        lO.done = #lO.list
      end
    end)
  end
  s[5] = function(lO)
    if not (pcall(function()
      lO.Parent = gethui()
    end)) then
      lO.Parent = q("CoreGui")
    end
  end
  local lO = f:QT(3, 4, {[2] = s, [3] = s, [4] = s, [5] = s, [6] = s, [7] = s, [8] = s, [9] = s}, p, y, nil)
  s[2].Window = function(uO, jO)
    jO = jO or {}
    local gO = {Tabs = {}}
    local OO, hO = jO.Key
    if OO then
      hO = OO
    else
      uO = s[4]
      hO = uO.KeyCode.RightControl
    end
    gO.Key = hO
    gO.us = 1
    gO.open = true
    local RO = lO(gO, tostring(jO.Id or "Venyx"))
    gO.Gui = RO
    local lO, _O, rO = 832, 510, s[6]
    gO.dim = rO({Parent = RO, Size = J, BackgroundColor3 = i(0, 0, 0)})
    pcall(function()
      gO.dim.Interactable = false
    end)
    gO.dz = 0.6
    rO = s[6]
    local VO = rO({Parent = RO, Active = true, ZIndex = 3, AnchorPoint = N, Position = v, Size = Q(lO, _O)})
    gO.Main = VO
    OO = s[3]
    local kO, FO = OO("UIScale", {Parent = VO}), s[3]
    OO, uO = {Parent = VO, Position = Q(-3, -3)}, s[8]
    OO.Size = uO(1, 6, 1, 6)
    OO.BackgroundTransparency = 1
    OO.Visible = false
    local QO, DO = FO("CanvasGroup", OO), s[6]
    local TO, dO = DO({Parent = VO, Size = J}), s[6]
    gO.bg = dO({Parent = TO, Size = J, BackgroundTransparency = 0.05, E(16), fO(B.w1, B.w2, 90)})
    DO = s[6]
    gO.tone = DO({Parent = TO, Size = J, BackgroundColor3 = i(0, 0, 0), E(16)})
    gO.Tint = function(eO)
      eO = s[11]
      local mO = (eO.Theme == "Black") and i(0, 0, 0)
      gO.bg:FindFirstChildOfClass("UIGradient").Color = ColorSequence.new(mO or B.w1, mO or B.w2)
    end
    gO.Tone = function(eO, eO)
      gO.tone.BackgroundColor3 = ((eO < 0) and B.wh) or i(0, 0, 0)
      gO.tone.BackgroundTransparency = 1 - ((math.abs(eO) / 100) * (((eO < 0) and 0.22) or 0.65))
    end
    gO:Tone(70)
    DO, dO = {Parent = TO}, s[8]
    DO.Size = dO(1, 0, 0.55, 0)
    f:yT(DO, 0, E(16), pO(90, {0, 0.86}, {1, 1}))
    w(DO)
    hO, dO = {Parent = TO, Position = Q(20, 1)}, s[8]
    hO.Size = dO(1, -40, 0, 1)
    f:yT(hO, 0, pO(0, {0, 1}, {0.5, 0.3}, {1, 1}))
    w(hO)
    DO, OO = o(0.7), s[6]
    OO({Parent = TO, Size = J, ZIndex = 5, E(16), DO})
    local function eO()
      local mO, xO = workspace.CurrentCamera.ViewportSize, ((G.TouchEnabled and not G.KeyboardEnabled) and 0.88) or 1
      return (math.clamp(math.min((mO.X - 60) / lO, (mO.Y - 20) / _O), 0.55, 1.3) * gO.us) * xO
    end
    local function mO()
      if gO.open then
        sO(kO, {Scale = eO()}, 0.3)
      end
    end
    d(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), mO)
    gO.SetScale = function(xO, xO)
      gO.us = xO
      mO()
    end
    FO, OO = {Parent = RO, AnchorPoint = N}, s[8]
    FO.Position = OO(0, 44, 0, 100 + (gO.slot * 60))
    FO.Size = Q(50, 50)
    FO.BackgroundTransparency = 0.12
    FO.BackgroundColor3 = B.bg
    FO.Visible = false
    f:yT(FO, 0, E(18), o(0.75))
    local mO, xO = Z(FO), s[3]
    local bO = xO("UIScale", {Parent = mO, Scale = 0})
    uO, hO = {AnchorPoint = N, Position = v, Size = Q(29, 28)}, s[4]
    uO.ScaleType = hO.ScaleType.Fit
    uO.ImageColor3 = B.tx
    PO(mO, 24, 30, v, N, uO)
    local SO = LO(M(), function(wO)
      local ZO = s[8]
      VO.Position = ZO(0.5, wO.X, 0.5, wO.Y)
    end)
    local wO = LO(M(44, 100 + (gO.slot * 60)), function(ZO)
      local WO = s[8]
      mO.Position = WO(0, ZO.X, 0, ZO.Y)
    end)
    local ZO, WO, AO = x(), s[19], s[4]
    OO, FO = AO.RenderPriority.Camera.Value, function(x)
      IO(SO, x)
      if mO.Visible then
        IO(wO, x)
      end
    end
    WO:BindToRenderStep(ZO, OO + 1, FO)
    rO, WO = {Parent = TO}, s[8]
    rO.Size = WO(1, 0, 0, k)
    rO.ClipsDescendants = true
    xO, FO, WO = s[6], {}, s[8]
    FO.Size = WO(1, 0, 1, 16)
    FO.BackgroundTransparency = 0.95
    f:yT(FO, 0, E(16))
    f:yT(rO, 0, xO(FO))
    DO = Z(rO)
    n(TO, Q(0, k), s[8](1, 0, 0, 1))
    rO = s[8]
    hO, dO, xO = rO(0, F / 2, 0.5, 0), {AnchorPoint = N}, s[8]
    dO.Position = xO(0, F / 2, 0.5, 0)
    dO.Size = Q(25, 24)
    WO = s[4]
    dO.ScaleType = WO.ScaleType.Fit
    dO.ImageColor3 = B.tx
    PO(DO, 21, 26, hO, N, dO)
    OO, xO, hO = s[6], {Parent = DO, Position = Q(F + 6, 0)}, s[8]
    xO.Size = hO(1, -F - 190, 1, 0)
    xO.ClipsDescendants = true
    AO = s[9]
    f:yT(xO, 0, AO(10, nil, h, u))
    AO = OO(xO)
    rO, xO = {Parent = AO}, s[8]
    rO.Size = xO(0, 0, 1, 0)
    rO.AutomaticSize = g
    rO.Text = (jO.Title or "Venyx"):upper()
    dO = nil
    dO, rO.FontFace = s[4], Font.new("rbxasset://fonts/families/Montserrat.json", s[4].FontWeight.Heavy)
    rO.TextSize = 22
    W(rO)
    FO, dO = {Parent = AO, LayoutOrder = 1}, s[8]
    FO.Size = dO(0, 0, 1, 0)
    FO.AutomaticSize = g
    FO.Text = "/"
    FO.TextSize = 13
    FO.TextTransparency = 0.6
    W(FO)
    dO, uO = {Parent = AO, LayoutOrder = 2}, s[8]
    dO.Size = uO(0, 0, 1, 0)
    dO.AutomaticSize = g
    dO.Text = jO.Game or ""
    dO.TextSize = 13
    dO.TextTransparency = 0.3
    dO.TextTruncate = O
    OO = s[3]
    f:yT(dO, 0, OO("UISizeConstraint", {MaxSize = M(170, 99)}))
    local x = W(dO)
    if jO.Version then
      W({Parent = AO, LayoutOrder = 3, Size = Q(0, 20), AutomaticSize = g, Text = jO.Version, FontFace = U, TextSize = 11, TextTransparency = 0.25, TextXAlignment = Y, BackgroundTransparency = 0.9, E(), yO(0, 8)})
    end
    local PO = w({Size = Q(7, 7), BackgroundColor3 = B.sky, E()})
    dO, xO = {Size = Q(0, 22), AutomaticSize = g, TextSize = 11, FontFace = U, TextColor3 = B.val, LayoutOrder = 1, TextTruncate = O}, s[3]
    f:yT(dO, 0, xO("UISizeConstraint", {MaxSize = M(270, 99)}))
    local XO, EO = W(dO), s[6]
    dO, FO = {Parent = AO, LayoutOrder = 4, Size = Q(0, 22), AutomaticSize = g, Visible = false, BackgroundTransparency = 0.9, BackgroundColor3 = B.sky}, s[9]
    f:yT(dO, 0, E(), yO(0, 10), FO(6, nil, h, u), PO, XO)
    local oO = EO(dO)
    gO.Status = function(f7, p7, y7)
      f7 = vO(y7)
      oO.Visible = (p7 ~= nil) and (p7 ~= "")
      if XO.Text == p7 then
        if PO.BackgroundColor3 == f7 then
          return
        end
      end
      XO.Text = p7 or ""
      PO.BackgroundColor3 = f7
      oO.BackgroundColor3 = f7
    end
    if not (jO.Game) then
      task.spawn(function()
        local PO, PO, jO = s[1], pcall(q("MarketplaceService").GetProductInfo, q("MarketplaceService"), s[1].PlaceId)
        x.Text = ((PO and jO) and jO.Name) or ""
      end)
    end
    xO, OO = {Parent = DO, AnchorPoint = z}, s[8]
    xO.Position = OO(1, -10, 0.5, 0)
    xO.Size = Q(26, 26)
    xO.BackgroundTransparency = 0.92
    f:yT(xO, 0, E(9), o(0.86), m("minus", 18))
    hO = Z(xO)
    UO(hO)
    uO, OO = {Parent = DO, AnchorPoint = z}, s[8]
    uO.Position = OO(1, -44, 0.5, 0)
    uO.Size = Q(128, 26)
    local x, PO = KO(uO, "Search"), s[6]
    uO, rO = {Parent = TO, Position = Q(0, k + 1)}, s[8]
    uO.Size = rO(0, F, 1, -k - 1)
    uO.ClipsDescendants = true
    dO, WO, EO = s[6], {Position = Q(0, -16)}, s[8]
    WO.Size = EO(1, 16, 1, 16)
    WO.BackgroundTransparency = 0.95
    f:yT(WO, 0, E(16))
    f:yT(uO, 0, dO(WO))
    WO, dO = PO(uO), s[8]
    n(WO, dO(1, -1, 0, 0), s[8](0, 1, 1, 0))
    PO, AO, EO = s[6], {Parent = WO, AnchorPoint = N}, s[8]
    AO.Position = EO(0.5, 0, 0, 29)
    AO.Size = Q(38, 38)
    AO.BackgroundTransparency = 0.82
    f:yT(AO, 0, E(12), o(0.68))
    local jO, XO = PO(AO), s[3]
    local oO = XO("UIScale", {Parent = jO})
    XO, xO = {Parent = WO, ZIndex = 2, Position = Q(0, 8)}, s[8]
    XO.Size = xO(1, 0, 1, -60)
    XO.ScrollBarThickness = 0
    uO = s[9]
    f:yT(XO, 0, yO(2, 0), uO(4, l))
    local uO = H(XO)
    XO, dO = {Parent = WO, AnchorPoint = M(0.5, 1)}, s[8]
    XO.Position = dO(0.5, 0, 1, -10)
    XO.Size = Q(32, 32)
    XO.Image = X(48)
    XO.BackgroundTransparency = 0
    XO.BackgroundColor3 = B.a2
    f:yT(XO, 0, E())
    S(XO)
    XO, FO = {Parent = TO, Position = Q(F + 18, k + 9)}, s[8]
    XO.Size = FO(1, -F - 36, 0, 26)
    XO.FontFace = U
    XO.TextSize = 20
    local FO, f7 = W(XO), s[6]
    dO, WO = {Parent = TO, Position = Q(F, k + 41)}, s[8]
    dO.Size = WO(1, -F, 1, -k - 49)
    dO.ClipsDescendants = true
    local p7 = f7(dO)
    tO(DO, SO, function(y7)
      local s7, q7 = workspace.CurrentCamera.ViewportSize, VO.AbsoluteSize
      local G7, c7 = ((s7.X / 2) + (q7.X / 2)) - 90, ((s7.Y / 2) + (q7.Y / 2)) - 60
      return M(math.clamp(y7.X, -G7, G7), math.clamp(y7.Y, -c7, c7))
    end)
    local y7 = tO(mO, wO, function(wO)
      local s7 = workspace.CurrentCamera.ViewportSize
      return M(math.clamp(wO.X, 30, s7.X - 30), math.clamp(wO.Y, 30, s7.Y - 30))
    end)
    dO, WO = {Parent = TO, AnchorPoint = M(1, 1)}, s[8]
    dO.Position = WO(1, -3, 1, -3)
    dO.Size = Q(22, 22)
    dO.ZIndex = 6
    AO, EO = Z(dO), {{14, 11}, {7, 16}}
    for wO, wO in ipairs(EO) do
      w({Parent = AO, AnchorPoint = N, Position = Q(wO[2], wO[2]), Size = Q(wO[1], 2), Rotation = -45, BackgroundTransparency = 0.4, ZIndex = 6, E()})
    end
    d(AO.InputBegan, function(wO)
      if not (aO(wO)) then
        return
      end
      local s7 = wO.Position
      local q7 = M(VO.Size.X.Offset, VO.Size.Y.Offset)
      local G7, c7 = kO.Scale
      local a7, i7 = SO.p - ((q7 * G7) / 2)
      i7, VO.AnchorPoint, VO.Position = s[8], M(), s[8](0.5, a7.X, 0.5, a7.Y)
      local function i7(n7)
        if n7 ~= wO then
          local M7 = s[4]
          if n7.UserInputType ~= M7.UserInputType.MouseMovement then
            return
          end
        end
        local M7, H7 = (n7.Position - s7) / G7, workspace.CurrentCamera.ViewportSize / G7
        VO.Size = Q(math.clamp(q7.X + M7.X, lO, math.max(lO, H7.X - 40)), math.clamp(q7.Y + M7.Y, _O, math.max(_O, H7.Y - 20)))
      end
      local lO = G.InputChanged:Connect(i7)
      local function _O(s7)
        local q7, i7 = s7 == wO
        if q7 then
          i7 = q7
        else
          local wO
          wO, i7 = s[4], s7.UserInputType == s[4].UserInputType.MouseButton1
        end
        if i7 then
          lO:Disconnect()
          c7:Disconnect()
          q7 = a7 + ((M(VO.Size.X.Offset, VO.Size.Y.Offset) * G7) / 2)
          VO.AnchorPoint = N
          SO.t = q7
          SO.p = q7
          SO.a(q7)
        end
      end
      c7 = G.InputEnded:Connect(_O)
    end)
    local lO = 0
    gO.Show = function(_O, SO)
      gO.open = SO
      lO += 1
      local wO = lO
      _O = eO()
      if TO.Parent ~= QO then
        local eO
        eO, TO.Position, TO.Size = s[8], Q(3, 3), s[8](1, -6, 1, -6)
        TO.Parent = QO
        QO.GroupTransparency = (SO and 1) or 0
      end
      kO.Scale = _O
      QO.Visible = true
      VO.Visible = true
      local eO, s7 = gO.dim, {}
      s7.BackgroundTransparency = (SO and (1 - gO.dz)) or 1
      sO(eO, s7, 0.3)
      eO, _O = s[4], s[4]
      sO(QO, {GroupTransparency = (SO and 0) or 1}, (SO and 0.28) or 0.18, s[4].EasingStyle.Sine, s[4].EasingDirection.Out)
      task.delay((SO and 0.3) or 0.2, function()
        if lO ~= wO then
          return
        end
        QO.Visible = false
        local lO = s[8]
        TO.Position = lO()
        TO.Size = J
        TO.Parent = VO
        if not (SO) then
          VO.Visible = false
        end
      end)
      if mO.Visible then
        bO.Scale = 0.85
        sO(bO, {Scale = 1}, 0.3, V)
      else
        mO.Visible = true
        bO.Scale = 0
        sO(bO, {Scale = 1}, 0.4, V)
      end
    end
    MO(hO, function()
      gO:Show(false)
    end)
    MO(mO, function()
      if not (y7()) then
        gO:Show(not gO.open)
      end
    end)
    d(G.InputBegan, function(lO, _O)
      if not (_O) then
        if lO.KeyCode == gO.Key then
          gO:Show(not gO.open)
        end
      end
    end)
    local lO = Z({Parent = TO, Size = J, BackgroundColor3 = i(5, 6, 16), ZIndex = 20, Visible = false, ClipsDescendants = true, E(16)})
    rO, hO = {Parent = lO}, s[7]
    rO.AnchorPoint = hO
    EO = s[8]
    rO.Position = EO(1, 420, 0, 6)
    WO = s[8]
    rO.Size = WO(0, 390, 1, -12)
    rO.BackgroundTransparency = 0.02
    rO.BackgroundColor3 = B.pn
    f:yT(rO, 0, E(14), o(0.84))
    local _O = Z(rO)
    PO, WO = {Parent = _O, Position = Q(18, 14)}, s[8]
    PO.Size = WO(1, -80, 0, 20)
    PO.FontFace = U
    PO.TextSize = 15
    local VO = W(PO)
    OO, EO = {Parent = _O, Position = Q(18, 34)}, s[8]
    OO.Size = EO(1, -80, 0, 14)
    OO.TextSize = 11
    OO.TextTransparency = 0.32
    local PO, QO, eO = W(OO), {Parent = _O}, s[7]
    QO.AnchorPoint = eO
    DO = s[8]
    QO.Position = DO(1, -12, 0, 10)
    QO.Size = Q(40, 40)
    QO.BackgroundTransparency = 0.92
    f:yT(QO, 0, E(12), m("x", 22))
    xO, DO, WO = Z(QO), {Parent = _O, Position = Q(14, 60)}, s[8]
    DO.Size = WO(1, -28, 0, 40)
    DO.BackgroundTransparency = 0.93
    local mO = KO(DO, "Filter")
    dO, f7, EO, rO, DO = {Parent = _O, Position = Q(12, 108)}, yO(3), s[3], {}, s[8]
    rO.CellSize = DO(0.5, -5, 0, 44)
    rO.CellPadding = Q(8, 8)
    WO = s[4]
    rO.SortOrder = WO.SortOrder.LayoutOrder
    f:yT(dO, 0, f7, EO("UIGridLayout", rO))
    local rO, bO = H(dO), s[6]
    OO, WO = {Parent = _O, AnchorPoint = M(0, 1)}, s[8]
    OO.Position = WO(0, 14, 1, -14)
    hO = s[8]
    OO.Size = hO(1, -28, 0, 44)
    local hO = bO(OO)
    eO, WO, XO = NO(hO, "Default", 0, 3), NO(hO, "Clear", 1, 3), NO(hO, "Select all", 2, 3, true)
    gO.Dialog = function(OO, dO)
      local SO = dO or {}
      if gO.dlg then
        gO.dlg.Close()
      end
      if not (gO.open) then
        gO:Show(true)
      end
      local dO, wO = vO(SO.Kind)
      OO = s[3]
      local EO = OO("UIScale", {Scale = 0.9})
      local f7 = Z({Parent = TO, Size = J, BackgroundColor3 = i(5, 6, 16), ZIndex = 30, E(16)})
      local y7, s7, q7, G7, c7 = {Parent = f7, AnchorPoint = N, Position = v, Size = Q(400, 0), AutomaticSize = j, BackgroundTransparency = 0.02, BackgroundColor3 = B.pn}, E(18), o(0.8), yO(22), s[9]
      local a7, i7, n7, M7 = c7(16), s[6], {}, s[8]
      n7.Size = M7(1, 0, 0, 46)
      M7 = s[6]
      local c7, H7, U7 = M7({Size = Q(46, 46), BackgroundTransparency = 0.8, BackgroundColor3 = dO, E(14), m(SO.Icon or wO, 24, dO)}), {Position = Q(60, 0)}, s[8]
      H7.Size = U7(1, -60, 1, 0)
      H7.Text = SO.Title or ""
      H7.FontFace = U
      H7.TextSize = 17
      H7.TextWrapped = true
      f:yT(n7, 0, c7, W(H7))
      f:yT(y7, 0, s7, q7, G7, a7, EO, i7(n7))
      local dO = Z(y7)
      if SO.Text then
        W({Parent = dO, LayoutOrder = 1, Size = R, AutomaticSize = j, Text = SO.Text, TextSize = 13, TextTransparency = 0.25, TextWrapped = true})
      end
      s7, q7, U7 = s[6], {Parent = dO, LayoutOrder = 2}, s[8]
      q7.Size = U7(1, 0, 0, 42)
      M7 = s7(q7)
      local y7
      y7 = {Close = function(s7)
        if gO.dlg == y7 then
          gO.dlg = nil
        end
        sO(EO, {Scale = 0.92}, 0.18)
        local q7, a7 = sO(f7, {BackgroundTransparency = 1}, 0.2), function()
          f7:Destroy()
        end
        q7.Completed:Connect(a7)
        dO.Visible = false
        cO(s7)
      end}
      G7 = SO.Buttons or {{"OK"}}
      for dO, s7 in ipairs(G7) do
        n7, c7, wO = s7[1], dO - 1, #G7
        i7, OO = NO(M7, n7, c7, wO, s7[3]), function()
          if nO() then
            y7.Close(s7[2])
          end
        end
        i7.Activated:Connect(OO)
      end
      local function OO()
        if SO.Cancel ~= false then
          y7.Close(SO.Cancel)
        end
      end
      f7.Activated:Connect(OO)
      gO.dlg = y7
      sO(f7, {BackgroundTransparency = 0.45}, 0.2)
      sO(EO, {Scale = 1}, 0.35, V)
      return y7
    end
    local function OO(dO, SO, wO, EO, f7, y7)
      gO:Dialog({Title = dO, Text = SO, Kind = wO, Buttons = {{y7 or "Cancel"}, {EO, f7, true}}})
    end
    local function dO()
      local SO = s[2]
      SO:Save()
      local SO, wO = s[2], s[11]
      SO:Notify("Config saved", wO.Active, "ok")
    end
    local function SO(wO, EO)
      local f7 = s[2]
      f7:Notify(EO, wO or "", (pcall(setclipboard, wO) and "ok") or "err")
    end
    UO(xO)
    local wO = {bt = {}, sel = {}}
    local function EO()
      wO.open = false
      sO(lO, {BackgroundTransparency = 1}, 0.22)
      local f7, y7 = {}, s[8]
      f7.Position = y7(1, 540, 0, 6)
      y7 = s[4]
      GO(sO(_O, f7, 0.28, r, y7.EasingDirection.In), lO, function()
        return wO.open
      end)
    end
    local function f7()
      for y7, s7 in next, wO.bt, nil do
        local q7 = wO.sel[y7] ~= nil
        sO(s7[1], {BackgroundTransparency = (q7 and 0.72) or 0.93, BackgroundColor3 = (q7 and B.a1) or B.wh}, 0.18)
        sO(s7[2], {Transparency = (q7 and 0.2) or 0.82, Color = (q7 and B.a1:Lerp(B.wh, 0.35)) or B.wh}, 0.18)
        local y7, G7 = s7[3], {}
        G7.ImageTransparency = (q7 and 0) or 1
        sO(y7, G7, 0.18)
      end
    end
    local function y7()
      f7()
      local s7 = {}
      for q7, q7 in ipairs(wO.o) do
        if wO.sel[q7] then
          s7[#s7 + 1] = q7
        end
      end
      cO(wO.d, s7)
    end
    gO.Sync = function(s7, s7)
      if wO.open then
        if not (wO.ob == s7) then
          return
        end
      else
        return
      end
      wO.sel = {}
      for q7, q7 in ipairs((s7.Multi and s7.Value) or {s7.Value}) do
        wO.sel[q7] = true
      end
      f7()
    end
    gO.Pick = function(s7, q7, G7, c7, a7, i7, n7, M7)
      wO.ob = M7
      VO.Text = q7
      PO.Text = (a7 and "Pick any") or "Pick one"
      mO.Text = ""
      CO(rO)
      s7 = n7 or {}
      wO.bt = {}
      wO.sel = {}
      wO.d = i7
      wO.o = {}
      wO.def = s7
      for PO, PO in ipairs((a7 and c7) or {c7}) do
        wO.sel[PO] = true
      end
      q7, M7 = type(G7[1]) == "table"
      M7, rO:FindFirstChildOfClass("UIGridLayout").CellSize = s[8], s[8](0.5, -5, 0, (q7 and 54) or 44)
      n7 = s[8]
      _O.Size = n7(0, (q7 and 500) or 390, 1, -12)
      M7 = ipairs
      for PO, VO in M7(G7) do
        local G7 = (q7 and VO.v) or VO
        wO.o[PO] = G7
        c7, s7 = o(0.82), s[6]
        n7 = s7({Parent = rO, LayoutOrder = PO})
        PO = Z({Parent = n7, AnchorPoint = N, Position = v, Size = J, BackgroundTransparency = 0.93, E(13), c7})
        if q7 then
          local H7, U7, L7, I7, t7, B7 = s[6], {Parent = PO, Position = Q(5, 5), Size = Q(44, 44), BackgroundTransparency = 0.72, BackgroundColor3 = VO.col or B.a1}, E(12), o(0.6, VO.col), {AnchorPoint = N, Position = v}, s[8]
          t7.Size = B7(1, 2, 1, 2)
          t7.Image = VO.img or ""
          B7 = s[4]
          t7.ScaleType = B7.ScaleType.Fit
          f:yT(U7, 0, L7, I7, b(t7))
          H7(U7)
          I7, t7 = {Parent = PO, Position = Q(56, 3)}, s[8]
          I7.Size = t7(1, -60, 0, 28)
          I7.Text = VO.t or tostring(G7)
          I7.FontFace = L
          I7.TextSize = 17
          I7.TextTruncate = O
          W(I7)
          B7, U7, L7 = s[6], {Parent = PO, Position = Q(57, 32)}, s[8]
          U7.Size = L7(1, -90, 0, 17)
          U7.ClipsDescendants = true
          t7 = s[9]
          f:yT(U7, 0, t7(6, nil, h, u))
          L7 = B7(U7)
          t7, H7 = {Parent = L7}, s[8]
          t7.Size = H7(0, 0, 1, 0)
          t7.AutomaticSize = g
          t7.Text = (VO.sub or ""):upper()
          t7.FontFace = t
          t7.TextSize = 12.5
          t7.TextColor3 = ((VO.grad and B.wh) or VO.col) or B.val
          I7 = s[3]
          f:yT(t7, 0, I7("UIStroke", {Thickness = 1.2, Color = i(0, 0, 0)}))
          local B7 = W(t7)
          if VO.grad then
            VO.grad:Clone().Parent = B7
          end
          if VO.note then
            H7, I7 = {Parent = L7, LayoutOrder = 1}, s[8]
            H7.Size = I7(1, -6, 1, 0)
            H7.Text = VO.note
            H7.FontFace = U
            H7.TextSize = 12.5
            H7.RichText = true
            H7.TextTruncate = O
            U7 = s[3]
            f:yT(H7, 0, U7("UIStroke", {Thickness = 1.2, Color = i(0, 0, 0)}))
            local U7 = W(H7)
            local function H7()
              local L7 = s[8]
              U7.Size = L7(1, -B7.AbsoluteSize.X - 6, 1, 0)
            end
            B7:GetPropertyChangedSignal("AbsoluteSize"):Connect(H7)
            H7()
          end
        else
          local H7, U7 = {Parent = PO, Position = Q(14, 0)}, s[8]
          H7.Size = U7(1, -40, 1, 0)
          H7.Text = tostring(G7)
          H7.FontFace = U
          H7.TextSize = 12
          H7.TextWrapped = true
          H7.LineHeight = 0.95
          W(H7)
        end
        local H7, U7, L7, I7 = wO.bt, {}, {Parent = PO, AnchorPoint = (q7 and M(1, 1)) or z}
        if q7 then
          local t7 = s[8]
          I7 = (t7(1, -9, 1, -8))
        else
          I7 = q7
        end
        local t7
        if I7 then
          t7 = I7
        else
          local I7 = s[8]
          t7 = (I7(1, -12, 0.5, 0))
        end
        L7.Position = t7
        L7.Size = Q(18, 18)
        L7.Image = "check"
        L7.ImageTransparency = 1
        f:yT(U7, 0, PO, c7, S(L7), n7, (tostring(G7) .. (" " .. ((q7 and ((VO.t or "") .. (" " .. ((VO.sub or "") .. (" " .. (VO.note or "")))))) or ""))):lower())
        H7[G7] = U7
        UO(PO, 0.95)
        MO(PO, function()
          if a7 then
            local PO, VO = wO.sel, wO.sel[G7]
            PO[G7] = if VO then nil else not VO
            y7()
          else
            wO.sel = {[G7] = true}
            f7()
            EO()
            cO(i7, G7)
          end
        end)
      end
      hO.Visible = a7 == true
      s7 = s[8]
      rO.Size = s7(1, -24, 1, (a7 and -176) or -120)
      f7()
      wO.open = true
      lO.Visible = true
      sO(lO, {BackgroundTransparency = 0.45}, 0.25)
      q7, M7 = {}, s[8]
      q7.Position = M7(1, -6, 0, 6)
      sO(_O, q7, 0.45)
    end
    d(mO:GetPropertyChangedSignal("Text"), function()
      local PO = mO.Text:lower()
      for hO, hO in next, wO.bt, nil do
        hO[4].Visible = hO[5]:find(PO, 1, true) ~= nil
      end
    end)
    MO(xO, EO)
    MO(lO, EO)
    local function PO(lO)
      wO.sel = {}
      for hO, hO in ipairs(lO) do
        wO.sel[hO] = true
      end
      y7()
    end
    MO(eO, function()
      PO(wO.def)
    end)
    MO(WO, function()
      PO({})
    end)
    MO(XO, function()
      PO(wO.o)
    end)
    local function PO(lO)
      return (29 + ((lO.i - 1) * 42)) - uO.CanvasPosition.Y
    end
    d(uO:GetPropertyChangedSignal("CanvasPosition"), function()
      if gO.Cur then
        local lO = s[8]
        jO.Position = lO(0.5, 0, 0, PO(gO.Cur))
      end
    end)
    local function lO(hO, _O, rO)
      local VO, eO, mO = s[6], {Parent = _O, LayoutOrder = rO, Size = R, AutomaticSize = j}, s[9]
      f:yT(eO, 0, mO(16))
      mO, rO = VO(eO), s[6]
      eO, VO = {Parent = mO, LayoutOrder = 1, Size = R, AutomaticSize = j}, s[9]
      f:yT(eO, 0, VO(16, nil, nil, u))
      _O = rO(eO)
      hO.cols = {}
      hO.list = {}
      hO.crow = mO
      for VO = 1, 2, 1 do
        local WO, XO, XO, EO, EO = hO.cols, s[6], {Parent = _O, LayoutOrder = VO}, s[8]
        XO.Size, XO.AutomaticSize, EO = s[8](0.5, -8, 0, 0), j, s[9]
        f:yT(XO, 0, s[9](16))
        WO[VO] = s[6](XO)
      end
      local VO, WO, WO, XO, XO = hO.cols, s[6], {Parent = mO, LayoutOrder = 2}, s[8]
      WO.Size, WO.AutomaticSize, WO.Visible, XO = s[8](0.5, -8, 0, 0), j, false, s[9]
      f:yT(WO, 0, s[9](16))
      VO[3] = s[6](WO)
      _O, XO, rO, eO = hO.cols, s[6], {Parent = mO, LayoutOrder = 0, Size = R, AutomaticSize = j, Visible = false}, s[9]
      f:yT(rO, 0, s[9](16))
      _O[4] = s[6](rO)
    end
    local function hO(_O, rO)
      local VO = _O.on and _O.on.chip
      if VO then
        if VO.AbsoluteSize.X == 0 then
          return
        end
      else
        return
      end
      local eO = {Position = Q((VO.AbsolutePosition.X - _O.row.AbsolutePosition.X) / kO.Scale, 0), Size = Q(VO.AbsoluteSize.X / kO.Scale, 24)}
      if rO then
        _O.hl.Position, _O.hl.Size = eO.Position, eO.Size
      else
        sO(_O.hl, eO, 0.38)
      end
    end
    local function _O(rO, VO)
      if rO.on == VO then
        return
      end
      rO.on = VO
      for eO, eO in ipairs(rO.subs) do
        local mO, WO = eO.chip, {}
        WO.TextTransparency = ((eO == VO) and 0) or 0.5
        sO(mO, WO, 0.2)
      end
      hO(rO)
    end
    local function rO(VO)
      if os.clock() < (VO.lock or 0) then
        return
      end
      local eO, mO, WO, XO = kO.Scale, VO.sc.AbsolutePosition.Y, VO.sc.AbsoluteCanvasSize.Y - VO.sc.AbsoluteWindowSize.Y, VO.subs[1]
      for EO, EO in ipairs(VO.subs) do
        XO = if (EO.g.AbsolutePosition.Y - mO) <= (40 * eO) then EO else XO
      end
      _O(VO, if WO > 0 then if VO.sc.CanvasPosition.Y >= (WO - 2) then VO.subs[#VO.subs] else XO else XO)
    end
    local function VO(eO, mO, WO)
      local XO = ((eO.CanvasPosition.Y + mO.AbsolutePosition.Y) - eO.AbsolutePosition.Y) - (WO * kO.Scale)
      sO(eO, {CanvasPosition = M(0, math.clamp(XO, 0, math.max(0, eO.AbsoluteCanvasSize.Y - eO.AbsoluteWindowSize.Y)))}, 0.45)
    end
    local function kO(eO, mO)
      eO.lock = os.clock() + 0.5
      VO(eO.sc, mO.g, 4)
      _O(eO, mO)
    end
    gO.Select = function(eO, mO)
      local WO = gO.Cur
      if WO == mO then
        return
      end
      x.Text = ""
      gO.Cur = mO
      for XO, XO in ipairs(mO.subs or {}) do
        YO(XO)
      end
      if mO.list then
        YO(mO)
      end
      for XO, EO in ipairs(gO.Tabs) do
        if EO.bar then
          EO.bar.Visible = EO == mO
          task.defer(hO, EO, true)
        end
        eO, XO = EO.im, {}
        XO.ImageTransparency = ((EO == mO) and 0) or 0.45
        sO(eO, XO, 0.3)
      end
      local XO, EO = {}, s[8]
      XO.Position = EO(0.5, 0, 0, PO(mO))
      sO(jO, XO, 0.42)
      oO.Scale = 0.86
      sO(oO, {Scale = 1}, 0.5, V)
      EO = (WO and (((WO.i > mO.i) and -1) or 1)) or 0
      if WO then
        WO.k = WO.k + 1
        local PO = WO.k
        local jO, XO, f7 = WO.fr, {}, s[8]
        XO.Position = s[8](-EO, 0, 0, 0)
        GO(sO(jO, XO, 0.5), WO.fr, function()
          return (WO.k ~= PO) or (gO.Cur == WO)
        end)
      end
      mO.k = mO.k + 1
      if not (mO.fr.Visible) then
        eO = nil
        eO, mO.fr.Position = s[8], s[8](EO, 0, 0, 0)
      end
      mO.fr.Visible = true
      local GO, PO, jO = mO.fr, {}, s[8]
      PO.Position = s[8]()
      sO(GO, PO, 0.5)
      FO.Text = mO.Title or mO.Name
      FO.Position = Q((F + 18) + (EO * 24), k + 9)
      FO.TextTransparency = 0.7
      sO(FO, {Position = Q(F + 18, k + 9), TextTransparency = 0}, 0.45)
    end
    gO.nest = {}
    gO.Grip = function(F, GO, PO)
      local function jO()
        return GO.AbsoluteCanvasSize.Y / math.max(GO.AbsoluteWindowSize.Y, 1)
      end
      local FO, eO = {Parent = PO}, s[7]
      FO.AnchorPoint = eO
      eO = s[8]
      FO.Position = eO(1, 0, 0, 0)
      eO = s[8]
      FO.Size = eO(0, 14, 1, 0)
      FO.ZIndex = 8
      FO.Visible = not G.TouchEnabled
      F, PO, eO = Z(FO), setmetatable, {__index = function()
        return M(0, GO.CanvasPosition.Y / jO())
      end, __newindex = function(FO, FO, FO)
        gO.goal = math.clamp(FO.Y * jO(), 0, math.max(0, GO.AbsoluteCanvasSize.Y - GO.AbsoluteWindowSize.Y))
        gO.gf = GO
        GO.CanvasPosition = M(0, gO.goal)
      end}
      tO(F, PO({}, eO), function(F)
        return F
      end)
    end
    gO.Tab = function(F, GO, tO, PO)
      local jO = {Name = GO, W = gO, Secs = {}, i = #gO.Tabs + 1, k = 0}
      jO.top = jO
      F = s[6]
      jO.fr = F({Parent = p7, Size = J, Visible = false})
      if PO then
        F = s[6]
        jO.sc = F({Parent = jO.fr, Size = J, yO(6, 16, 6)})
      else
        local F, FO = {Parent = jO.fr, Size = J, ScrollingEnabled = G.TouchEnabled, ScrollBarThickness = 3, ScrollBarImageColor3 = B.wh, ScrollBarImageTransparency = 0.7}, s[4]
        F.ElasticBehavior = FO.ElasticBehavior.Always
        FO = s[9]
        f:yT(F, 0, yO(4, 0, 12), FO(12, l))
        jO.sc = H(F)
        local F, FO, eO = s[6], {Parent = jO.sc}, s[8]
        FO.Size = eO(1, -36, 0, 0)
        FO.AutomaticSize = j
        jO.g = F(FO)
        d(jO.sc.InputChanged, function(F)
          local FO = s[4]
          if F.UserInputType == FO.UserInputType.MouseWheel then
            gO:Wheel(F.Position.Z)
          end
        end)
        gO:Grip(jO.sc, jO.fr)
        d(jO.sc.MouseWheelForward, function()
          gO:Wheel(1)
        end)
        d(jO.sc.MouseWheelBackward, function()
          gO:Wheel(-1)
        end)
        lO(jO, jO.g, 0)
        jO.subs = {}
      end
      PO = Z({Parent = uO, Size = Q(38, 38), LayoutOrder = jO.i})
      jO.im = S({Parent = PO, AnchorPoint = N, Position = v, Size = Q(24, 24), Image = tO or "grid", ImageTransparency = 0.45})
      UO(jO.im, 0.8, PO, function(F)
        if gO.Cur == jO then
          sO(oO, {Scale = (F and 0.9) or 1}, (F and 0.12) or 0.45, (F and r) or V)
        end
      end)
      MO(PO, function()
        gO:Select(jO)
      end)
      gO.Tabs[jO.i] = jO
      jO.Section = function(F, F, tO, PO)
        return zO.new(jO, F, tO, PO)
      end
      jO.Arrange = function(F, tO)
        for PO, uO in ipairs(tO) do
          for tO, FO in ipairs(uO) do
            for uO, uO in ipairs(F.Secs) do
              if uO.name == FO then
                uO.side, uO.card.LayoutOrder = PO, tO
              end
            end
          end
        end
        F.done = -1
        YO(F)
      end
      jO.Sub = function(F, tO)
        local PO = {Name = GO .. (" / " .. tO), W = gO, Secs = jO.Secs, i = #jO.subs + 1, sc = jO.sc, top = jO}
        if #jO.subs == 0 then
          jO.g.Visible = #jO.Secs > 0
          local GO, uO, FO = s[6], {Parent = TO}, s[7]
          uO.AnchorPoint = FO
          FO = s[8]
          uO.Position = FO(1, -18, 0, k + 7)
          uO.Size = Q(0, 30)
          uO.AutomaticSize = g
          uO.Visible = gO.Cur == jO
          uO.BackgroundTransparency = 0.95
          f:yT(uO, 0, E(), o(0.88), yO(3))
          jO.bar = GO(uO)
          FO = s[6]
          jO.hl = FO({Parent = jO.bar, Size = Q(0, 24), BackgroundTransparency = 0.84, E()})
          FO, F, uO = s[6], {Parent = jO.bar, Size = Q(0, 24), AutomaticSize = g, ZIndex = 2}, s[9]
          f:yT(F, 0, uO(4, nil, h, u))
          jO.row = FO(F)
          d(jO.row:GetPropertyChangedSignal("AbsoluteSize"), function()
            hO(jO, true)
          end)
          d(jO.sc:GetPropertyChangedSignal("CanvasPosition"), function()
            rO(jO)
          end)
        end
        local GO, uO = {}, s[8]
        GO.Size = uO(1, 0, 0, 18)
        local hO, rO = {}, s[8]
        hO.Size = rO(1, -30, 1, 0)
        hO.Text = tO:upper()
        hO.FontFace = L
        hO.TextSize = 12
        hO.TextTransparency = 0.35
        f:yT(GO, 0, W(hO))
        rO = Z(GO)
        GO, uO = {Parent = rO, AnchorPoint = N}, s[8]
        GO.Position = uO(1, -9, 0.5, 0)
        GO.Size = Q(13, 13)
        GO.Image = "down"
        GO.ImageTransparency = 0.55
        local hO, FO = S(GO), s[6]
        uO, F = {Parent = jO.sc, LayoutOrder = PO.i}, s[8]
        uO.Size = F(1, -36, 0, 0)
        uO.AutomaticSize = j
        GO = s[9]
        f:yT(uO, 0, GO(12), rO)
        PO.g = FO(uO)
        lO(PO, PO.g, 1)
        MO(rO, function()
          PO.crow.Visible = not PO.crow.Visible
          sO(hO, {Rotation = (PO.crow.Visible and 0) or -90}, 0.25)
        end)
        PO.chip = Z({Parent = jO.row, LayoutOrder = PO.i, Size = Q(0, 24), AutomaticSize = g, Text = tO, FontFace = U, TextSize = 12, TextColor3 = B.wh, TextTransparency = 0.5, BackgroundTransparency = 1, E(), yO(0, 12)})
        MO(PO.chip, function()
          kO(jO, PO)
        end)
        PO.Go = function(F)
          if not (gO.open) then
            gO:Show(true)
          end
          gO:Select(jO)
          task.delay(0.15, kO, jO, PO)
        end
        jO.subs[PO.i] = PO
        PO.Section = function(F, F, GO, tO)
          return zO.new(PO, F, GO, tO)
        end
        PO.Arrange = jO.Arrange
        if PO.i == 1 then
          _O(jO, PO)
        end
        return PO
      end
      if not (gO.Cur) then
        gO:Select(jO)
      end
      return jO
    end
    gO.All = {}
    AO, xO, DO = s[6], {Parent = TO}, s[7]
    xO.AnchorPoint = DO
    bO = s[8]
    xO.Position = bO(1, -44, 0, k - 4)
    xO.Size = Q(300, 0)
    xO.AutomaticSize = j
    xO.Visible = false
    xO.ZIndex = 15
    xO.BackgroundTransparency = 0.02
    xO.BackgroundColor3 = B.pn
    QO = s[9]
    f:yT(xO, 0, E(12), o(0.82), yO(6), QO(2))
    local k = AO(xO)
    local function F(GO)
      x.Text = ""
      gO:Select(GO.tab)
      task.delay(0.55, function()
        VO(GO.tab.sc, GO.r, 40)
        GO.r.BackgroundTransparency = 0.8
        sO(GO.r, {BackgroundTransparency = 1}, 1.4)
      end)
    end
    d(x:GetPropertyChangedSignal("Text"), function()
      local GO = x.Text:lower()
      CO(k)
      k.Visible = GO ~= ""
      if GO == "" then
        return
      end
      local x, tO, PO = ipairs, gO.All, 0
      for lO, uO in x(tO) do
        if PO < 8 then
          if uO.n:find(GO, 1, true) then
            lO = PO + 1
            local x, jO = {Parent = k, LayoutOrder = lO}, s[8]
            x.Size = jO(1, 0, 0, 42)
            local jO, hO, _O = E(9), {Position = Q(10, 4)}, s[8]
            hO.Size = _O(1, -20, 0, 18)
            hO.Text = uO.title
            hO.FontFace = U
            hO.TextTruncate = O
            local _O, rO, VO = W(hO), {Position = Q(10, 22)}, s[8]
            rO.Size = VO(1, -20, 0, 15)
            rO.Text = uO.path
            rO.TextSize = 11
            rO.TextTransparency = 0.45
            rO.TextTruncate = O
            f:yT(x, 0, jO, _O, W(rO))
            VO = Z(x)
            qO(VO, 0.92)
            local function x()
              if nO() then
                F(uO)
              end
            end
            VO.Activated:Connect(x)
            PO = lO
          else
          end
        else
        end
      end
      if PO == 0 then
        tO, GO = {Parent = k}, s[8]
        tO.Size = GO(1, 0, 0, 32)
        tO.Text = "No results"
        tO.TextTransparency = 0.45
        tO.TextXAlignment = Y
        W(tO)
      end
    end)
    gO.Home = function(k, F)
      local x = F or {}
      k = gO:Tab(x.Name or "Home", x.Icon or "home", true)
      k.Title = x.Title or "Dashboard"
      local F, GO, tO = s[6], {Parent = k.sc, Position = Q(-6, -6)}, s[8]
      GO.Size = tO(1, 12, 1, 12)
      local PO = F(GO)
      local function lO(uO, jO, hO, _O, rO, VO, kO)
        local FO, QO, DO = s[6], {Parent = PO}, s[8]
        QO.Position = DO(uO, 6, jO, 6)
        DO = s[8]
        QO.Size = DO(hO, -12, _O, -12)
        QO.BackgroundTransparency = rO or 0.93
        QO.BackgroundColor3 = VO or B.wh
        f:yT(QO, 0, E(18), o(kO or 0.86, VO and VO:Lerp(B.wh, 0.5)))
        return FO(QO)
      end
      local function uO(jO, hO, _O, rO)
        S({Parent = jO, Position = Q(14, 13), Size = Q(14, 14), Image = _O, ImageColor3 = rO})
        _O, rO = {Parent = jO, Position = Q(34, 12)}, s[8]
        _O.Size = rO(1, -48, 0, 16)
        _O.Text = hO:upper()
        _O.FontFace = L
        _O.TextSize = 11.5
        _O.TextTransparency = 0.15
        return W(_O)
      end
      tO = lO(0, 0, 0.6666666666666666, 0.3, 0.55)
      fO(i(255, 196, 120), i(150, 110, 255)).Parent = tO
      F, GO = {Parent = tO}, s[8]
      F.Position = GO(0, 16, 0.5, -28)
      F.Size = Q(56, 56)
      F.Image = X(150)
      F.BackgroundTransparency = 0
      F.BackgroundColor3 = B.a2
      f:yT(F, 0, E(), o(0.4))
      S(F)
      GO, k = {Parent = tO}, s[8]
      GO.Position = k(0, 86, 0.5, -34)
      k = s[8]
      GO.Size = k(1, -100, 0, 14)
      GO.Text = "Welcome back"
      GO.TextSize = 11
      GO.TextTransparency = 0.25
      W(GO)
      k, GO = {Parent = tO}, s[8]
      k.Position = GO(0, 86, 0.5, -19)
      F = s[8]
      k.Size = F(1, -100, 0, 24)
      k.Text = a.DisplayName
      k.FontFace = U
      k.TextSize = 21
      k.TextTruncate = O
      W(k)
      k, GO, F = s[6], {Parent = tO}, s[8]
      GO.Position = F(0, 86, 0.5, 10)
      tO = s[8]
      GO.Size = tO(1, -100, 0, 20)
      F = s[9]
      f:yT(GO, 0, F(6, nil, nil, u))
      local X, jO, hO = k(GO), x.Executor or (identifyexecutor and select(2, pcall(identifyexecutor))), ipairs
      tO = {{x.Game}, {(type(jO) == "string") and jO}, {x.Key, B.mint}}
      for _O, rO in hO(tO) do
        if rO[1] then
          F, k = {Parent = X, LayoutOrder = _O}, s[8]
          F.Size = k(0, 0, 1, 0)
          F.AutomaticSize = g
          F.Text = tostring(rO[1])
          F.TextSize = 11
          F.TextColor3 = rO[2] and rO[2]:Lerp(B.wh, 0.6)
          F.BackgroundTransparency = (rO[2] and 0.8) or 0.75
          F.BackgroundColor3 = rO[2] or i(0, 0, 0)
          F.TextXAlignment = Y
          f:yT(F, 0, E(), yO(0, 10))
          W(F)
        end
      end
      hO = x.Notice
      X = lO(0.6666666666666666, 0, 0.3333333333333333, 0.3, 0.78, (hO and B.a1) or B.dc, 0.55)
      w({Parent = X, Position = Q(14, 14), Size = Q(36, 36), BackgroundColor3 = (hO and B.a1) or B.dc, E(11), m((hO and "sparkles") or "discord", 22)})
      jO, k = {Parent = X, Position = Q(60, 15)}, s[8]
      jO.Size = k(1, -72, 0, 17)
      jO.Text = ((hO and hO[1]) or x.Community) or "Community"
      jO.FontFace = U
      jO.TextSize = 14
      jO.TextTruncate = O
      W(jO)
      if hO then
        tO, k = {Parent = X, Position = Q(14, 58)}, s[8]
        tO.Size = k(1, -28, 1, -70)
        tO.Text = hO[2]
        tO.TextSize = 11
        tO.TextTransparency = 0.22
        tO.TextWrapped = true
        GO = s[4]
        tO.TextYAlignment = GO.TextYAlignment.Top
        W(tO)
      else
        F, jO = {Parent = X, Position = Q(60, 33)}, s[8]
        F.Size = jO(1, -72, 0, 14)
        F.Text = "Updates, keys, support"
        F.TextSize = 11
        F.TextTransparency = 0.22
        W(F)
        local _O, rO = {Parent = X, AnchorPoint = M(0, 1)}, s[8]
        _O.Position = rO(0, 14, 1, -12)
        rO = s[8]
        _O.Size = rO(1, -28, 0, 32)
        _O.BackgroundTransparency = 0
        _O.BackgroundColor3 = B.dc
        _O.Text = "Copy invite"
        _O.FontFace = U
        _O.TextSize = 12
        _O.TextColor3 = B.wh
        f:yT(_O, 0, E(10))
        rO = Z(_O)
        UO(rO)
        MO(rO, function()
          SO(x.Discord, "Invite copied")
        end)
      end
      local _O = q("TeleportService")
      k, X = x.Actions
      if k then
        X = k
      else
        hO, jO, GO, tO, F = {}, {"Rejoin", "refresh", function()
          OO("Rejoin this server?", "You leave and join this same server again.", "warn", "Rejoin", function()
            local q = s[1]
            _O:TeleportToPlaceInstance(q.PlaceId, s[1].JobId, a)
          end)
        end}, {"Server hop", "server", function()
          OO("Hop to another server?", "You leave this server and join a different one.", "warn", "Hop", function()
            if x.Hop then
              x.Hop()
            else
              local q = s[1]
              _O:Teleport(q.PlaceId, a)
            end
          end)
        end}, {"Copy Job ID", "copy", function()
          local q = s[1]
          SO(q.JobId, "Job ID copied")
        end}, x.Unload
        local q, _O = (F and {"Unload hub", "trash", x.Unload}) or {"Save config", "save", dO}, x.Switch or (x.Discord and {"Discord", "discord", function()
          SO(x.Discord, "Discord invite copied")
        end})
        f:yT(hO, 0, jO, GO, tO, q, _O or {"Hide UI", "eye", function()
          gO:Show(false)
        end})
        X = hO
      end
      jO, GO, hO = s[6], {Parent = PO}, s[8]
      GO.Position = hO(0, 6, 0.3, 6)
      k = s[8]
      GO.Size = k(1, -12, 0.16, -12)
      k = s[9]
      f:yT(GO, 0, k(12, nil, nil, u))
      hO, F = jO(GO), ipairs
      for q, PO in F(X) do
        jO, tO, k, GO = P[((q - 1) % 5) + 1], s[6], {Parent = hO, LayoutOrder = q}, s[8]
        k.Size = GO(1 / #X, (12 / #X) - 12, 1, 0)
        local q, GO, hO, _O, rO, VO = {Parent = tO(k), AnchorPoint = N, Position = v, Size = J, BackgroundTransparency = 0.94}, E(14), o(0.88), s[6], {}, s[8]
        rO.Position = VO(0, 10, 0.5, -15)
        rO.Size = Q(30, 30)
        rO.BackgroundTransparency = 0.82
        rO.BackgroundColor3 = jO
        f:yT(rO, 0, E(9), m(PO[2], 16, jO))
        local tO, jO, VO = _O(rO), {Position = Q(48, 0)}, s[8]
        jO.Size = VO(1, -54, 1, 0)
        jO.Text = PO[1]
        jO.TextSize = 12
        jO.TextWrapped = true
        f:yT(q, 0, GO, hO, tO, W(jO))
        jO = Z(q)
        UO(jO, 0.95)
        MO(jO, function()
          cO(PO[3])
        end)
      end
      local q = lO(0, 0.46, 0.6666666666666666, 0.54)
      local GO = uO(q, "Session", "clock", B.gold)
      k = lO(0.6666666666666666, 0.46, 0.3333333333333333, 0.54)
      uO(k, "What's new", "sparkles", B.pink)
      X, F = {Parent = k, Position = Q(14, 40)}, s[8]
      X.Size = F(1, -24, 1, -50)
      F = s[9]
      f:yT(X, 0, yO(1, 4, 4, 1), F(10))
      local k, F = H(X), {}
      local function X(tO)
        local PO, lO = math.max(os.time() - tO, 0), {{86400, "day"}, {3600, "hour"}, {60, "minute"}}
        for uO, uO in ipairs(lO) do
          tO = PO // uO[1]
          if tO >= 1 then
            return ("%d %s%s ago"):format(tO, uO[2], ((tO > 1) and "s") or "")
          end
        end
        return "just now"
      end
      F.News = function(tO, PO)
        F.list = PO
        CO(k)
        tO = ipairs
        for CO, lO in tO(PO) do
          local tO, PO, uO = s[6], {Position = Q(44, 0)}, s[8]
          PO.Size = uO(1, -44, 0, 0)
          PO.AutomaticSize = j
          uO = s[9]
          f:yT(PO, 0, uO(2), W({Size = R, AutomaticSize = j, Text = lO[2], TextSize = 12, TextWrapped = true}))
          uO = tO(PO)
          if lO[3] or lO[4] then
            local jO, hO, _O = s[6], {Parent = uO, LayoutOrder = 1}, s[8]
            hO.Size = _O(1, 0, 0, 14)
            PO = s[9]
            f:yT(hO, 0, PO(5, nil, h, u))
            _O = jO(hO)
            if lO[3] then
              tO, hO = {Parent = _O}, s[8]
              tO.Size = hO(0, 0, 1, 0)
              tO.AutomaticSize = g
              tO.Text = lO[3]
              tO.FontFace = I
              tO.TextSize = 10
              tO.TextTransparency = 0.4
              W(tO)
            end
            if lO[4] then
              local tO, rO, VO = s[6], {Parent = _O, LayoutOrder = 1}, s[8]
              rO.Size = VO(0, 0, 1, 0)
              rO.AutomaticSize = g
              rO.BackgroundTransparency = 0.9
              jO = s[9]
              f:yT(rO, 0, E(), yO(0, 6), jO(3, nil, h, u))
              VO = tO(rO)
              S({Parent = VO, Size = Q(10, 10), Image = "clock", ImageTransparency = 0.3})
              rO, hO = {Parent = VO, LayoutOrder = 1}, s[8]
              rO.Size = hO(0, 0, 1, 0)
              rO.AutomaticSize = g
              rO.Text = X(lO[4])
              rO.FontFace = I
              rO.TextSize = 10
              rO.TextTransparency = 0.3
              W(rO)
            end
          end
          PO = s[6]
          PO({Parent = k, LayoutOrder = CO, Size = R, AutomaticSize = j, uO, W({Size = Q(0, 18), AutomaticSize = g, Text = lO[1], FontFace = I, TextSize = 9, TextColor3 = i(16, 20, 42), BackgroundTransparency = 0, BackgroundColor3 = ({NEW = B.mint, FIX = B.sky, IMP = B.gold, UPD = B.red})[lO[1]] or B.vio, TextXAlignment = Y, E(5), yO(0, 6)})})
        end
      end
      F.Stats = function(k, X, tO)
        GO.Text = X:upper()
        local GO, PO, CO = s[6], {Parent = q, Position = Q(12, 38)}, s[8]
        PO.Size = CO(1, -24, 1, -48)
        k, CO, X = s[3], {}, s[8]
        CO.CellSize = X(0.3333333333333333, -7, 0.333, -6)
        CO.CellPadding = Q(10, 8)
        X = s[4]
        CO.SortOrder = X.SortOrder.LayoutOrder
        f:yT(PO, 0, k("UIGridLayout", CO))
        k, X, CO = GO(PO), {}, ipairs
        for q, lO in CO(tO) do
          PO = s[6]
          GO = PO({Parent = k, LayoutOrder = q, BackgroundTransparency = 0.94, E(12)})
          if lO[2] then
            local k, tO = {Parent = GO, AnchorPoint = M(0, 0.5)}, s[8]
            k.Position = tO(0, 8, 0.5, 0)
            k.Size = Q(30, 30)
            k.Image = lO[2]
            tO = s[4]
            k.ScaleType = tO.ScaleType.Fit
            k.ImageColor3 = (D[lO[2]] and B.a1) or nil
            S(k)
          end
          local k, tO, PO = (lO[2] and 44) or 10, {Parent = GO}, s[8]
          tO.Position = PO(0, k, 0.5, -17)
          PO = s[8]
          tO.Size = PO(1, -k - 6, 0, 13)
          tO.Text = lO[1]:upper()
          tO.FontFace = L
          tO.TextSize = 9.5
          tO.TextTransparency = 0.38
          W(tO)
          PO, q, tO = lO[1], {Parent = GO}, s[8]
          q.Position = tO(0, k, 0.5, -2)
          tO = s[8]
          q.Size = tO(1, -k - 6, 0, 18)
          q.Text = "--"
          q.FontFace = I
          q.TextSize = 13.5
          q.TextTruncate = O
          X[PO] = W(q)
          if lO[3] then
            PO, q = {Parent = GO, AnchorPoint = M(1, 0)}, s[8]
            PO.Position = q(1, -8, 0, 8)
            PO.Size = Q(40, 16)
            PO.Text = "OPEN"
            PO.FontFace = L
            PO.TextSize = 9
            PO.TextColor3 = B.wh
            PO.BackgroundTransparency = 0.82
            PO.BackgroundColor3 = B.wh
            f:yT(PO, 0, E(), o(0.7))
            tO = Z(PO)
            UO(tO, 0.92)
            MO(tO, function()
              cO(lO[3])
            end)
          end
        end
        return JO(X)
      end
      if x.News then
        F:News(x.News)
      end
      return F
    end
    local function q(k, F, x)
      return ((type(k) == "table") and k) or gO:Tab(k or F, x)
    end
    gO.Settings = function(k, F)
      k = q(F, "Settings", "settings")
      F = k:Section("Interface", "sliders")
      F:Slider("UI scale", 60, 140, 100, function(x)
        gO:SetScale(x / 100)
      end, "%", 5)
      local function x(X)
        gO.Key = X
      end
      F:Key("Show / hide UI", gO.Key, nil, x)
      F:Slider("Opacity", 50, 100, 95, function(X)
        gO.bg.BackgroundTransparency = 1 - (X / 100)
      end, "%")
      F:Slider("Tone", -100, 100, 70, function(X)
        gO:Tone(X)
      end, "", 5)
      F:Slider("Dim the game", 0, 80, 60, function(X)
        gO.dz = X / 100
        if gO.open then
          gO.dim.BackgroundTransparency = 1 - gO.dz
        end
      end, "%", 5)
      F, x = k:Section("Theme", "palette"), s[6]
      local X, GO, tO, PO, CO = {Parent = F.f, LayoutOrder = 2, Name = "VenyxThemes", Size = R, AutomaticSize = j}, yO(2, 14, 14), s[3], {}, s[8]
      PO.CellSize = CO(0.25, -8, 0, 62)
      PO.CellPadding = Q(10, 10)
      CO = s[4]
      PO.SortOrder = CO.SortOrder.LayoutOrder
      f:yT(X, 0, GO, tO("UIGridLayout", PO))
      CO = x(X)
      F.n = F.n + 1
      F, GO = {}, ipairs
      for lO, uO in GO(K) do
        local GO, jO, hO, _O, rO, VO = o(0.86), {Parent = CO, LayoutOrder = lO, BackgroundTransparency = 0.95}, E(12), s[6], {Position = Q(6, 6)}, s[8]
        rO.Size = VO(1, -12, 0, 30)
        rO.BackgroundTransparency = 0
        x, X, PO, tO, VO = E(8), fO(uO[2], uO[4], 20), s[6], {AnchorPoint = M(0, 1)}, s[8]
        tO.Position = VO(0, 6, 1, -5)
        lO = s[8]
        tO.Size = lO(0.45, 0, 0, 6)
        tO.BackgroundTransparency = 0
        tO.BackgroundColor3 = uO[5]
        f:yT(tO, 0, E())
        f:yT(rO, 0, x, X, PO(tO))
        local x, X, PO = _O(rO), {Position = Q(8, 40)}, s[8]
        X.Size = PO(1, -26, 0, 16)
        X.Text = uO[1]
        X.FontFace = U
        X.TextSize = 11
        X.TextTruncate = O
        f:yT(jO, 0, hO, GO, x, W(X))
        X, lO, rO = Z(jO), uO[1], {}
        VO, x = {Parent = X, AnchorPoint = z}, s[8]
        VO.Position = x(1, -8, 0, 48)
        VO.Size = Q(12, 12)
        VO.Image = "check"
        VO.ImageColor3 = uO[5]
        VO.ImageTransparency = 1
        f:yT(rO, 0, GO, S(VO))
        F[lO] = rO
        UO(X, 0.95)
        MO(X, function()
          local x = s[2]
          x:Theme(uO[1])
        end)
      end
      gO.marks = F
      tO = k:Section("Defaults", "refresh")
      tO:Button("Reset to defaults", "Reset", function()
        OO("Reset every option?", "All options go back to their built-in values and your active config is saved that way.", "warn", "Reset", function()
          local F = s[2]
          F:Reset()
          F = s[2]
          F:Notify("Reset", "Every option is back to its default", "ok")
        end)
      end, "danger")
      tO:Button("Turn off all toggles", "Turn off", function()
        local F, x = s[2], s[2]
        F:Notify("Toggles off", x:Off() .. " switched off", "ok")
      end)
      return k
    end
    gO.Config = function(k, F)
      k = q(F, "Config", "save")
      F = k:Section("Config", "folder")
      local q = F:Stats({"Active", "Saved configs"})
      local x
      local function X()
        local GO = s[11]
        q:Set("Active", GO.Active)
        q:Set("Saved configs", tostring(#s[2]:Configs()))
        if x then
          x:Set(s[11].Active, true)
        end
      end
      local function q(GO, tO, PO, CO)
        local lO = GO:Dropdown(tO, function()
          local GO = s[2]
          return GO:Configs()
        end, nil, function(GO)
          if GO then
            if PO then
              PO(GO)
            end
          end
        end, CO)
        lO.Skip = true
        return lO
      end
      x = q(F, "Config", function(GO)
        local tO = s[11]
        if GO ~= tO.Active then
          local tO = s[2]
          tO:Notify("Config picked", GO .. " - press Set active to load it", "info")
        end
      end)
      F:Button("Set as active config", "Set active", function()
        local GO = x.Value
        if not (GO) then
          local x = s[2]
          return x:Notify("Nothing picked", "Choose a config first", "warn")
        end
        local x = s[2]
        if x:Load(GO) then
          X()
          local x = s[2]
          x:Notify("Active config", GO, "ok")
        end
      end, "gold")
      F:Button("Save changes", "Save", dO)
      local x = s[11]
      F:Toggle("Auto load", x.AutoLoad, function(GO)
        local tO = s[11]
        if tO.AutoLoad ~= GO then
          local PO, CO, lO = s[2], "Auto load " .. ((GO and "on") or "off")
          if GO then
            local uO = s[11]
            lO = uO.Active .. " loads every time Venyx starts"
          else
            lO = GO
          end
          PO:Notify(CO, lO or "Venyx starts with its default options", "info")
        end
        tO = s[11]
        tO.AutoLoad = GO
        tO = s[2]
        tO:Persist()
      end).Skip = true
      x = s[11]
      F:Toggle("Auto save", x.AutoSave, function(F)
        local GO = s[11]
        if GO.AutoSave == F then
          return
        end
        GO = s[11]
        GO.AutoSave = F
        GO = s[2]
        GO:Persist()
        if F then
          GO = s[2]
          GO:Save()
        end
        local tO, PO, CO = s[2], "Auto save " .. ((F and "on") or "off")
        if F then
          GO = s[11]
          CO = "Every change is saved to " .. GO.Active
        else
          CO = F
        end
        tO:Notify(PO, CO or "Press Save changes to keep your options", "info")
      end).Skip = true
      x = k:Section("Profiles", "copy")
      local F = x:Input("New config name", "Auto if empty")
      F.Skip = true
      x:Button("Create config", "Create", function()
        local GO = s[2]
        local tO, PO = GO:Name(F.Value)
        if not (tO) then
          GO = s[2]
          return GO:Notify("Config not created", PO, "err")
        end
        PO = s[2]
        PO:Save(tO)
        PO = s[11]
        PO.Active = tO
        PO = s[2]
        PO:Persist()
        F:Set("", true)
        X()
        GO = s[2]
        GO:Notify("Config created", tO .. " is now the active config", "ok")
      end, "gold")
      local F = q(x, "Pick to delete", nil, true)
      x:Button("Delete picked", "Delete", function()
        local GO, tO = {}, false
        for PO, PO in ipairs(F.Value) do
          if PO:lower() == "default" then
            tO = true
          else
            GO[#GO + 1] = PO
          end
        end
        if #GO == 0 then
          local PO = s[2]
          return PO:Notify("Nothing to delete", "Pick configs other than Default", "warn")
        end
        OO("Delete " .. (#GO .. " config(s)?"), table.concat(GO, ", ") .. ((tO and "\nDefault is kept.") or ""), "err", "Delete", function()
          local tO = ipairs
          for PO, CO in tO(GO) do
            PO = s[2]
            PO:Delete(CO)
          end
          F:Set({}, true)
          X()
          tO = s[2]
          tO:Notify(#GO .. " config(s) deleted", table.concat(GO, ", "), "ok")
        end)
      end, "danger")
      local F
      F = x:Dropdown("Restore deleted", function()
        local GO = s[2]
        return GO:Trash()
      end, nil, function(GO)
        if not (GO) then
          return
        end
        local tO = s[2]
        local PO = tO:Restore(GO)
        F:Set(nil, true)
        X()
        tO = s[2]
        tO:Notify((PO and "Config restored") or "Restore failed", PO or GO, (PO and "ok") or "err")
      end)
      F.Skip = true
      q(x, "Export config", function(q)
        local F, F, GO = s[2], pcall(setclipboard, s[2]:Export(q)), s[2]
        GO:Notify((F and "Config copied") or "Copy failed", (F and (q .. " is on your clipboard")) or "This executor cannot copy text", (F and "ok") or "err")
        gO:Dialog({Title = (F and "Config copied") or "Copy failed", Kind = (F and "ok") or "err", Text = (F and (q .. " is on your clipboard. Paste it to share it, then load it with Import config.")) or "This executor cannot copy text."})
      end)
      local q = x:Input("Import text", "Paste config text")
      q.Skip = true
      x:Button("Import config", "Import", function()
        local F = s[2]
        local x, GO = F:Import(q.Value)
        if not x then
          F = s[2]
          return F:Notify("Import failed", GO, "err")
        end
        q:Set("", true)
        OO("Config imported", x .. " was added to your configs. Apply it now?", "ok", "Apply now", function()
          local q = s[2]
          q:Load(x)
          X()
          q = s[2]
          q:Notify("Config loaded", x, "ok")
        end, "Later")
        GO = s[2]
        GO:Notify("Config imported", x .. " was added to your configs", "ok")
      end, "gold")
      X()
      return k
    end
    gO.Quick = function(q, k, F)
      local x, X, GO, tO, PO, CO, lO, uO = {pins = {}, keys = {}, at = {}, fold = {}}, {show = false, keys = true, size = 1}, {Value = ""}, {}, {}, {}
      local jO, hO = 0
      local function _O(rO)
        local VO = hO.tr
        hO.o:Set(hO.o.From(math.clamp((rO.Position.X - VO.AbsolutePosition.X) / VO.AbsoluteSize.X, 0, 1)), false, true)
      end
      local function rO(VO)
        local kO = s[2]
        return kO.Keys[VO].Name
      end
      local function VO(kO)
        local FO, QO, DO = {}, -#rO(kO) - 2, ""
        for dO in kO:sub(1, QO):gmatch("[^/]+") do
          dO = dO:match("^%s*(.-)%s*$")
          if dO:lower() ~= DO then
            DO, FO[#FO + 1] = dO:lower(), dO
          else
          end
        end
        return table.concat(FO, "  /  ")
      end
      local function kO(FO)
        local QO = x.keys[FO]
        return QO and (C[QO] or QO)
      end
      local function FO(QO, DO, dO)
        local eO
        if DO then
          local mO = s[3]
          eO = mO("UIScale", {Parent = QO})
        else
          eO = DO
        end
        local mO = QO.BackgroundTransparency
        local function bO(SO)
          if aO(SO) then
            sO(eO or QO, (eO and {Scale = DO}) or {BackgroundTransparency = mO - 0.06}, 0.12)
          end
        end
        QO.InputBegan:Connect(bO)
        local function DO(bO)
          if aO(bO) then
            sO(eO or QO, (eO and {Scale = 1}) or {BackgroundTransparency = mO}, 0.35)
          end
        end
        QO.InputEnded:Connect(DO)
        local function DO()
          if nO() then
            dO()
          end
        end
        QO.Activated:Connect(DO)
      end
      local function QO(DO, dO, eO)
        local mO = DO:GetDescendants()
        mO[#mO + 1] = DO
        local bO = ipairs
        for SO, WO in bO(mO) do
          SO = {}
          if WO:IsA("GuiObject") then
            SO.BackgroundTransparency = WO.BackgroundTransparency
          end
          if WO:IsA("TextLabel") then
            SO.TextTransparency = WO.TextTransparency
          elseif WO:IsA("TextButton") then
            SO.TextTransparency = WO.TextTransparency
          elseif WO:IsA("TextBox") then
            SO.TextTransparency = WO.TextTransparency
          end
          if WO:IsA("ImageLabel") then
            SO.ImageTransparency = WO.ImageTransparency
          end
          if WO:IsA("UIStroke") then
            SO.Transparency = WO.Transparency
          end
          local mO = {}
          for bO in next, SO, nil do
            mO[bO] = 1
          end
          if dO then
            for bO in next, SO, nil do
              WO[bO] = 1
            end
            sO(WO, SO, 0.3, nil, nil, eO)
          else
            local bO = s[4]
            sO(WO, mO, 0.26, r, bO.EasingDirection.In, eO)
          end
        end
        if not (dO) then
          DO.Active = false
          sO(DO, {Position = DO.Position + Q(0, 26)}, 0.3, r, s[4].EasingDirection.In, eO)
          task.delay(0.32 + eO, DO.Destroy, DO)
        end
      end
      local function DO()
        for dO, eO in ipairs(gO.All) do
          local mO = eO.k:sub(1, -#eO.title - 2)
          CO[mO], CO[eO.k] = CO[mO] or dO, CO[eO.k] or dO
        end
        local dO, eO = {}, s[2]
        for mO, bO in next, eO.Keys, nil do
          if bO.Kind then
            dO[#dO + 1] = mO
          end
        end
        table.sort(dO, function(eO, mO)
          local bO, SO = ((CO[eO:sub(1, -#rO(eO) - 2)] or 1000000000) * 10000) + (CO[eO] or 0), ((CO[mO:sub(1, -#rO(mO) - 2)] or 1000000000) * 10000) + (CO[mO] or 0)
          if bO == SO then
            return eO < mO
          end
          return bO < SO
        end)
        return dO
      end
      local function CO()
        local dO = s[10]
        GO:Set(dO:JSONEncode(x), true)
      end
      local function dO()
        x = {pins = {}, keys = {}, at = {}, fold = {}}
        local eO, mO = ipairs, f[53](DO())
        for bO, bO in eO(f:uT(mO)) do
          local eO, mO = ipairs, F or {}
          for F, F in eO(mO) do
            if bO:sub(-#F) == F then
              x.pins[bO] = 1
            end
          end
        end
      end
      local function F()
        for eO, mO in ipairs(PO) do
          eO = table.find(mO[1].ls, mO[2])
          if eO then
            table.remove(mO[1].ls, eO)
          end
        end
        table.clear(PO)
        for eO, mO in ipairs(tO) do
          QO(mO.f, false, (eO - 1) * 0.05)
        end
        table.clear(tO)
        if uO then
          uO()
        end
        if not (X.show) then
          return
        end
        local eO, mO, bO = workspace.CurrentCamera.ViewportSize, DO(), 220
        local SO, WO = math.clamp(eO.Y / 720, 0.75, 1.2) * X.size, 0
        for AO = 1, 5, 1 do
          local XO, EO = {}, tostring(AO)
          for oO, oO in ipairs(mO) do
            if x.pins[oO] == AO then
              XO[#XO + 1] = oO
            end
          end
          if #XO > 0 then
            WO += 1
            local mO = s[3]
            local oO, f7 = mO("UIScale", {Scale = SO}), s[9]
            local p7, y7 = f7(5), s[6]
            local s7, q7, G7 = y7({LayoutOrder = 1, Size = R, AutomaticSize = j, ClipsDescendants = true, yO(0, 7, 7), p7}), {AnchorPoint = N}, s[8]
            q7.Position = G7(1, -17, 0.5, 0)
            q7.Size = Q(12, 12)
            q7.Image = "down"
            q7.ImageTransparency = 0.4
            q7.Rotation = (x.fold[EO] and -90) or 0
            local c7, a7, i7 = S(q7), {}, s[8]
            a7.Size = i7(1, 0, 0, 34)
            i7, mO, G7 = S({Position = Q(12, 10), Size = Q(14, 14), Image = "zap", ImageColor3 = P[AO]}), {Position = Q(33, 0)}, s[8]
            mO.Size = G7(1, -90, 1, 0)
            mO.Text = "QUICK BAR " .. AO
            mO.FontFace = L
            mO.TextSize = 11
            G7, q7, y7 = W(mO), {AnchorPoint = z}, s[8]
            q7.Position = y7(1, -32, 0.5, 0)
            q7.Size = Q(0, 16)
            q7.AutomaticSize = g
            q7.Text = #XO
            q7.FontFace = U
            q7.TextSize = 9.5
            q7.TextXAlignment = Y
            q7.BackgroundTransparency = 0.88
            f:yT(q7, 0, E(), yO(0, 6))
            f:yT(a7, 0, c7, i7, G7, W(q7))
            mO, G7, y7, f7 = Z(a7), s[6], {Parent = gO.Gui, AnchorPoint = M(0.5, 0), Size = Q(bO, 0), AutomaticSize = j, BackgroundTransparency = 0.06, Active = true, ZIndex = 2}, s[9]
            f:yT(y7, 0, E(16), fO(B.w1, B.w2, 90), o(0.74), oO, f7(), mO, s7)
            local AO = G7(y7)
            local n7, M7 = {f = AO, u = oO, id = EO}, WO
            n7.place = function(H7, U7)
              local L7 = x.at[EO]
              L7 = (L7 and M(L7[1], L7[2])) or M(((H7.X - 18) - ((bO * U7) / 2)) - ((M7 - 1) * ((bO * U7) + 12)), math.max(H7.Y * 0.023, 8))
              n7.sp.t = M(math.clamp(L7.X, 40, H7.X - 40), math.clamp(L7.Y, 0, H7.Y - 40))
              oO.Scale = U7
            end
            n7.sp = LO(M(), function(LO)
              local oO = s[8]
              AO.Position = oO(0, LO.X, 0, LO.Y)
            end)
            n7.place(eO, SO)
            n7.sp.p = n7.sp.t + M(0, 14)
            tO[#tO + 1] = n7
            if x.fold[EO] then
              i7 = s[4]
              s7.AutomaticSize = i7.AutomaticSize.None
              s7.Size = R
            end
            mO.InputBegan:Connect(function(LO)
              if aO(LO) then
                lO = lO or {b = n7, i = LO, s = M(LO.Position.X, LO.Position.Y), p = n7.sp.t}
              end
            end)
            FO(mO, nil, function()
              local LO, eO = x.fold, x.fold[EO]
              LO[EO] = if eO then nil else not eO
              local LO, SO, oO, M7 = x.fold[EO], (p7.AbsoluteContentSize.Y / math.max(AO.AbsoluteSize.X / bO, 0.01)) + 7, s[4]
              M7, s7.AutomaticSize, s7.Size = s[8], oO.AutomaticSize.None, s[8](1, 0, 0, (LO and SO) or 0)
              sO(c7, {Rotation = (LO and -90) or 0}, 0.3)
              oO, eO = {}, s[8]
              oO.Size = eO(1, 0, 0, (LO and 0) or SO)
              sO(s7, oO, 0.32).Completed:Connect(function()
                if not (x.fold[EO]) then
                  s7.AutomaticSize = j
                end
              end)
              CO()
            end)
            f7 = ipairs
            for LO, eO in f7(XO) do
              i7 = s[2]
              local bO = i7.Keys[eO]
              a7 = kO(eO)
              local SO
              q7, mO, G7 = bO.Kind, {Parent = s7, LayoutOrder = LO}, s[8]
              mO.Size = G7(1, 0, 0, ((q7 == "slider") and 46) or 34)
              mO.BackgroundTransparency = 0.93
              f:yT(mO, 0, E(11))
              y7, LO = Z(mO), s[6]
              local mO, XO, EO, oO = LO({Parent = y7, Size = J, E(11), fO(B.a1, B.a2)}), s[6], {Parent = y7}, s[7]
              EO.AnchorPoint = oO
              oO = s[8]
              EO.Position = oO(1, -9, 0, 6)
              EO.Size = Q(160, 22)
              EO.ZIndex = 2
              oO, LO = s[9], s[4]
              f:yT(EO, 0, oO(6, LO.HorizontalAlignment.Right, h, u))
              local LO, f7, p7 = XO(EO), {Parent = y7, Position = Q(11, 6)}, s[8]
              f7.Size = p7(1, -((((q7 == "button") and 96) or ((q7 == "input") and 132)) or 60) - ((a7 and 44) or 0), 0, 22)
              f7.Text = rO(eO)
              f7.FontFace = U
              f7.TextSize = 12.5
              f7.TextTruncate = O
              f7.ZIndex = 2
              W(f7)
              if a7 then
                W({Parent = LO, Size = Q(0, 18), AutomaticSize = g, Text = a7, FontFace = I, TextSize = 10, TextXAlignment = Y, BackgroundTransparency = 0.86, E(6), yO(0, 6)})
              end
              if q7 == "toggle" then
                f7 = s[6]
                local eO = e(f7({Parent = LO, LayoutOrder = 1, Size = Q(38, 20)}), 38, 20)
                SO = function(EO, f7)
                  eO(EO, f7)
                  sO(mO, {BackgroundTransparency = (EO and 0.78) or 1}, (f7 and 0) or 0.25)
                end
                FO(y7, nil, function()
                  local eO = s[2]
                  eO.qb = true
                  bO:Set(not bO.Value)
                  eO = s[2]
                  eO.qb = nil
                end)
              else
                if q7 == "button" then
                  local eO = W({Parent = LO, LayoutOrder = 1, Size = Q(0, 22), AutomaticSize = g, Text = bO.Text, FontFace = U, TextSize = 11, TextColor3 = bO.Col:Lerp(B.wh, 0.55), BackgroundTransparency = 0.85, BackgroundColor3 = bO.Col, E(8), yO(0, 10), o(0.5, bO.Col)})
                  FO(y7, nil, function()
                    bO.Fire()
                    eO.BackgroundTransparency = 0.5
                    sO(eO, {BackgroundTransparency = 0.85}, 0.5)
                  end)
                else
                  if q7 == "input" then
                    local eO = A({Parent = LO, LayoutOrder = 1, Size = Q(116, 24), BackgroundTransparency = 0.7, BackgroundColor3 = i(0, 0, 0), PlaceholderText = "Type here", TextSize = 11.5, TextTruncate = O, ClipsDescendants = true, E(7), yO(0, 7), o(0.8)})
                    local function mO()
                      bO:Set(eO.Text)
                    end
                    eO.FocusLost:Connect(mO)
                    SO = function(mO)
                      if not (eO:IsFocused()) then
                        eO.Text = tostring(mO or "")
                      end
                    end
                  else
                    local eO, mO, EO, f7 = W({Parent = LO, LayoutOrder = 1, Size = Q(0, 22), AutomaticSize = g, FontFace = I, TextSize = 11, TextColor3 = B.val}), s[6], {Parent = y7}, s[8]
                    EO.Position = f7(0, 11, 1, -13)
                    oO = s[8]
                    EO.Size = oO(1, -22, 0, 5)
                    EO.BackgroundTransparency = 0.86
                    EO.ZIndex = 2
                    f:yT(EO, 0, E())
                    local LO = mO(EO)
                    XO, f7 = {Parent = LO}, s[8]
                    XO.Size = f7(0, 0, 1, 0)
                    f:yT(XO, 0, E(), fO(B.a1, B.a2))
                    local mO, EO, oO = w(XO), {Parent = LO, AnchorPoint = N}, s[8]
                    EO.Position = oO(0, 0, 0.5, 0)
                    EO.Size = Q(13, 13)
                    EO.ZIndex = 3
                    f:yT(EO, 0, E(), o(0.65, i(0, 0, 0)))
                    local XO = w(EO)
                    SO = function(EO, oO)
                      local f7, p7, s7 = math.clamp(bO.Frac(EO), 0, 1), {}, s[8]
                      p7.Size = s7(f7, 0, 1, 0)
                      sO(mO, p7, (oO and 0) or 0.1)
                      s7, p7 = {}, s[8]
                      s7.Position = p7(f7, 0, 0.5, 0)
                      sO(XO, s7, (oO and 0) or 0.1)
                      eO.Text = bO.Txt(EO)
                    end
                    y7.InputBegan:Connect(function(eO)
                      if aO(eO) then
                        hO = {o = bO, tr = LO, i = eO}
                        iO.s = true
                        _O(eO)
                      end
                    end)
                  end
                end
              end
              if SO then
                SO(bO.Value, true)
                bO.ls[#bO.ls + 1] = SO
                PO[#PO + 1] = {bO, SO}
              end
            end
            n7.sp.a(n7.sp.p)
            QO(AO, true, (WO - 1) * 0.06)
          else
          end
        end
      end
      local function LO()
        jO += 1
        local PO = jO
        task.delay(0.15, function()
          if PO == jO then
            F()
          end
        end)
      end
      q = s[19]
      d(q.Heartbeat, function(PO)
        for jO, jO in ipairs(tO) do
          IO(jO.sp, PO)
        end
      end)
      d(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), function()
        local IO = workspace.CurrentCamera.ViewportSize
        if IO.X < 300 then
          return
        elseif IO.Y < 200 then
          return
        end
        for PO, PO in ipairs(tO) do
          PO.place(IO, math.clamp(IO.Y / 720, 0.75, 1.2) * X.size)
        end
      end)
      d(G.InputChanged, function(IO)
        if hO then
          if IO == hO.i then
            _O(IO)
          else
            local PO = s[4]
            if hO.i.UserInputType == PO.UserInputType.MouseButton1 then
              local PO = s[4]
              if IO.UserInputType == PO.UserInputType.MouseMovement then
                _O(IO)
              end
            end
          end
        end
        if lO then
          if IO ~= lO.i then
            local PO = s[4]
            if IO.UserInputType ~= PO.UserInputType.MouseMovement then
              return
            end
          end
        else
          return
        end
        local PO, jO = M(IO.Position.X, IO.Position.Y) - lO.s, lO
        jO.mv = jO.mv or (PO.Magnitude > 6)
        if lO.mv then
          IO, jO = workspace.CurrentCamera.ViewportSize, lO.p + PO
          lO.b.sp.t = M(math.clamp(jO.X, 40, IO.X - 40), math.clamp(jO.Y, 0, IO.Y - 40))
        end
      end)
      d(G.InputEnded, function(IO)
        if hO then
          if IO == hO.i then
            hO = nil
          else
            local PO = s[4]
            if IO.UserInputType == PO.UserInputType.MouseButton1 then
              hO = nil
            end
          end
        end
        if lO then
          if IO ~= lO.i then
            local PO = s[4]
            if IO.UserInputType ~= PO.UserInputType.MouseButton1 then
              return
            end
          end
        else
          return
        end
        IO = lO
        lO = nil
        if IO.mv then
          x.at[IO.b.id] = {IO.b.sp.t.X, IO.b.sp.t.Y}
          CO()
        end
      end)
      local function IO(PO, lO)
        if lO then
          if gO.Key then
            if lO == gO.Key.Name then
              local jO, hO = s[2], (C[lO] or lO) .. " already shows and hides the menu"
              return jO:Notify("Key not set", hO, "warn")
            end
          end
        end
        local jO, hO = next, x.keys
        for _O, QO in jO, hO, nil do
          if lO then
            if QO == lO then
              if _O ~= PO then
                x.keys[_O] = nil
                local jO = s[2]
                jO:Notify("Key moved", (C[lO] or lO) .. (" now toggles " .. (rO(PO) .. (" instead of " .. rO(_O)))), "info")
              end
            end
          end
        end
        x.keys[PO] = lO
        CO()
        F()
      end
      function gO.Pin(PO, lO)
        PO = s[3]
        local jO, hO, _O, QO, eO = PO("UIScale", {Scale = 0.9}), false
        local mO = Z({Parent = TO, Size = J, BackgroundColor3 = i(5, 6, 16), ZIndex = 30, E(16)})
        local TO, bO, SO, WO, AO = {Parent = mO, AnchorPoint = N, Position = v, Size = Q(390, 0), AutomaticSize = j, BackgroundTransparency = 0.02, BackgroundColor3 = B.pn}, E(18), o(0.8), yO(20), s[9]
        local XO, EO, oO, f7 = AO(10), s[6], {}, s[8]
        oO.Size = f7(1, 0, 0, 46)
        f7 = s[6]
        local p7, y7, s7 = f7({Size = Q(46, 46), BackgroundTransparency = 0.8, BackgroundColor3 = B.a1, E(14), m("pin", 22, B.a1)}), {Position = Q(60, 3)}, s[8]
        y7.Size = s7(1, -60, 0, 22)
        y7.Text = rO(lO)
        y7.FontFace = U
        y7.TextSize = 17
        y7.TextTruncate = O
        PO, s7, AO = W(y7), {Position = Q(60, 26)}, s[8]
        s7.Size = AO(1, -60, 0, 16)
        s7.Text = VO(lO)
        s7.TextSize = 11.5
        s7.TextTransparency = 0.42
        s7.TextTruncate = O
        f:yT(oO, 0, p7, PO, W(s7))
        f:yT(TO, 0, bO, SO, WO, XO, jO, EO(oO))
        local q7 = Z(TO)
        local function G7(c7, a7)
          local i7, n7 = {Parent = q7, LayoutOrder = c7}, s[8]
          i7.Size = n7(1, 0, 0, 22)
          i7.Text = a7
          i7.FontFace = L
          i7.TextSize = 10
          i7.TextTransparency = 0.45
          a7 = s[4]
          i7.TextYAlignment = a7.TextYAlignment.Bottom
          W(i7)
        end
        G7(1, "SHOW ON QUICK BAR")
        XO, SO, WO = s[6], {Parent = q7, LayoutOrder = 2}, s[8]
        SO.Size = WO(1, 0, 0, 40)
        oO, p7, WO = s[3], {}, s[8]
        p7.CellSize = WO(0.16666666666666666, -7, 1, 0)
        p7.CellPadding = Q(8, 0)
        AO = s[4]
        p7.SortOrder = AO.SortOrder.LayoutOrder
        f:yT(SO, 0, oO("UIGridLayout", p7))
        local c7, a7 = XO(SO), {}
        local function i7(n7)
          for M7, H7 in next, a7, nil do
            local U7, L7, I7 = (x.pins[lO] or 0) == M7, H7[1], {}
            I7.BackgroundTransparency = (U7 and 0) or 1
            sO(L7, I7, (n7 and 0) or 0.2)
            sO(H7[2], {Transparency = (U7 and 0.45) or 0.84, Color = (U7 and B.a1) or B.wh}, (n7 and 0) or 0.2)
            H7[3].TextColor3 = (U7 and B.on) or B.wh
          end
        end
        for n7 = 0, 5, 1 do
          oO, TO = o(0.84), W({Size = J, Text = ((n7 == 0) and "Off") or n7, FontFace = L, TextSize = 13, TextXAlignment = Y, ZIndex = 2})
          AO, EO, WO = Z({Parent = c7, LayoutOrder = n7, BackgroundTransparency = 0.93, E(12), oO, TO}), {}, s[6]
          f:yT(EO, 0, WO({Parent = AO, Size = J, E(12), fO(B.a1, B.a2, 90)}), oO, TO)
          a7[n7] = EO
          FO(AO, 0.9, function()
            x.pins[lO] = ((n7 > 0) and n7) or nil
            i7()
            CO()
            F()
            if n7 > 0 then
              if not (X.show) then
                local WO = s[2]
                WO:Notify("Quick bars are hidden", "Turn on Show quick bars to see Quick bar " .. n7, "info")
              end
            end
          end)
        end
        i7(true)
        local function WO()
          QO.Text = ((hO and "Press any key  -  Esc cancels") or kO(lO)) or "Not set"
          QO.TextTransparency = ((hO or x.keys[lO]) and 0) or 0.45
          sO(eO, {Transparency = (hO and 0.3) or 0.82, Color = (hO and B.a1) or B.wh}, 0.2)
        end
        f7, SO = G.KeyboardEnabled
        if f7 then
          s7 = s[2]
          TO = s7.Keys[lO].Kind == "toggle"
          if TO then
            SO = TO
          else
            oO = s[2]
            SO = oO.Keys[lO].Kind == "button"
          end
        else
          SO = f7
        end
        local TO
        if SO then
          G7(3, "KEYBIND")
          eO = o(0.82)
          oO, EO, y7 = s[6], {Parent = q7, LayoutOrder = 4}, s[8]
          EO.Size = y7(1, 0, 0, 40)
          s7 = oO(EO)
          p7, AO = {Parent = s7}, s[8]
          p7.Size = AO(1, -98, 1, 0)
          p7.BackgroundTransparency = 0.92
          f:yT(p7, 0, E(12), eO)
          XO = Z(p7)
          QO = W({Parent = XO, Size = J, FontFace = I, TextSize = 14, TextXAlignment = Y})
          FO(XO, 0.96, function()
            local QO = s[2]
            hO = true
            QO.kw = true
            WO()
          end)
          f7, PO = {Parent = s7}, s[7]
          f7.AnchorPoint = PO
          bO = s[8]
          f7.Position = bO(1, 0, 0, 0)
          c7 = s[8]
          f7.Size = c7(0, 88, 1, 0)
          f7.BackgroundTransparency = 0.92
          f:yT(f7, 0, E(12), o(0.84), W({Size = J, Text = "Clear", FontFace = U, TextSize = 13, TextXAlignment = Y}))
          FO(Z(f7), 0.92, function()
            local QO = s[2]
            hO = false
            QO.kw = nil
            IO(lO)
            WO()
          end)
          _O = G.InputBegan:Connect(function(QO)
            if hO then
              local eO = s[4]
              if QO.UserInputType ~= eO.UserInputType.Keyboard then
                return
              end
            else
              return
            end
            hO = false
            task.defer(function()
              local eO = s[2]
              eO.kw = nil
            end)
            local eO = s[4]
            if QO.KeyCode ~= eO.KeyCode.Escape then
              IO(lO, QO.KeyCode.Name)
            end
            WO()
          end)
          WO()
          TO = _O
        else
          TO = _O
        end
        local function IO()
          if TO then
            TO:Disconnect()
          end
          if hO then
            local lO = s[2]
            lO.kw = nil
          end
          sO(jO, {Scale = 0.92}, 0.18)
          local lO, hO = sO(mO, {BackgroundTransparency = 1}, 0.2), function()
            mO:Destroy()
          end
          lO.Completed:Connect(hO)
          q7.Visible = false
        end
        XO, f7, G7 = s[6], {Parent = q7, LayoutOrder = 5}, s[8]
        f7.Size = G7(1, 0, 0, 52)
        f:yT(f7, 0, yO(10, 0, 0))
        G7, PO = NO(XO(f7), "Done", 0, 1, true), function()
          if nO() then
            IO()
          end
        end
        G7.Activated:Connect(PO)
        mO.Activated:Connect(IO)
        sO(mO, {BackgroundTransparency = 0.45}, 0.2)
        sO(jO, {Scale = 1}, 0.35, V)
      end
      q = k:Section("Quick bars", "zap")
      q:Toggle("Show quick bars", true, function(nO)
        X.show = nO
        LO()
      end)
      q:Toggle("Keybinds", true, function(nO)
        X.keys = nO
      end)
      q:Slider("Bar size", 60, 160, 100, function(nO)
        X.size = nO / 100
        for nO, nO in ipairs(tO) do
          nO.u.Scale = math.clamp(workspace.CurrentCamera.ViewportSize.Y / 720, 0.75, 1.2) * X.size
        end
      end, "%", 5)
      GO.Set = function(nO, IO, tO)
        nO.Value = tostring(IO or "")
        local IO, IO, IO, PO = s[10], s[10], pcall(s[10].JSONDecode, s[10], nO.Value)
        if (IO and (type(PO) == "table")) and (type(PO.pins) == "table") then
          nO = {"keys", "at", "fold"}
          for IO, IO in ipairs(nO) do
            PO[IO] = ((type(PO[IO]) == "table") and PO[IO]) or {}
          end
          x = PO
        else
          dO()
        end
        if not (tO) then
          LO()
        end
      end
      q:Reg("Quick bar layout", GO)
      local GO = k:Section("Pins and keybinds", "pin")
      GO:Text("Tip: you can also hold any option, or right-click it on PC, to pin it or set a key.")
      local nO, IO, tO = s[6], {Parent = GO.f, LayoutOrder = GO.n + 1, Size = R, AutomaticSize = j}, s[9]
      f:yT(IO, 0, yO(4, 14, 12), tO(8))
      tO = nO(IO)
      GO:Add(tO, "")
      local PO, NO, lO = s[6], {Parent = tO}, s[8]
      NO.Size = lO(1, 0, 0, 34)
      lO = PO(NO)
      PO, nO = {Parent = lO}, s[8]
      PO.Size = nO(1, -150, 1, 0)
      local jO, hO, _O, QO, TO = KO(PO, "Find an option"), "All", s[6], {Parent = lO}, s[7]
      QO.AnchorPoint = TO
      nO = s[8]
      QO.Position = nO(1, 0, 0, 0)
      lO = s[8]
      QO.Size = lO(0, 142, 1, 0)
      QO.BackgroundTransparency = 0.93
      f:yT(QO, 0, E(10), o(0.86), yO(3))
      NO = _O(QO)
      IO, _O = {Parent = NO}, s[8]
      IO.Size = _O(0.5, 0, 1, 0)
      f:yT(IO, 0, E(8), fO(B.a1, B.a2, 90))
      local KO, lO, _O = w(IO), {Parent = tO, LayoutOrder = 1}, s[8]
      lO.Size = _O(1, 0, 0, 300)
      QO = s[9]
      f:yT(lO, 0, QO(4))
      local IO = H(lO)
      gO.nest[IO] = k.top or k
      lO, nO = {Parent = IO}, s[8]
      lO.Size = nO(1, 0, 0, 60)
      lO.TextSize = 12
      lO.TextTransparency = 0.45
      lO.TextXAlignment = Y
      local k = W(lO)
      uO = function()
        for nO, nO in ipairs(IO:GetChildren()) do
          if nO:IsA("GuiObject") then
            if nO ~= k then
              nO:Destroy()
            end
          end
        end
        local nO, tO, lO = jO.Text:lower(), ipairs, f[53](DO())
        local DO
        local TO = 0
        for eO, mO in tO(f:uT(lO)) do
          if ((hO == "All") or x.pins[mO]) or x.keys[mO] then
            if mO:lower():find(nO, 1, true) then
              local nO, tO = x.pins[mO], kO(mO)
              eO = nil
              if VO(mO) ~= DO then
                local lO = VO(mO)
                eO = TO + 1
                local VO, kO = {Parent = IO, LayoutOrder = eO}, s[8]
                VO.Size = kO(1, -6, 0, 24)
                VO.Text = lO:upper()
                VO.FontFace = L
                VO.TextSize = 9.5
                VO.TextTransparency = 0.5
                kO = s[4]
                VO.TextYAlignment = kO.TextYAlignment.Bottom
                f:yT(VO, 0, yO(0, 0, 3, 6))
                W(VO)
                DO = lO
              else
                eO = TO
              end
              local lO, VO, kO = s[6], {AnchorPoint = z}, s[8]
              VO.Position = kO(1, -10, 0.5, 0)
              VO.Size = Q(170, 22)
              local DO, bO = s[9], s[4]
              local SO, WO, AO, XO, EO, oO, f7 = DO(6, bO.HorizontalAlignment.Right, h, u), {LayoutOrder = 1, Size = Q(0, 22), AutomaticSize = g, BackgroundTransparency = (nO and 0) or 0.9}, E(), yO(0, 9), (nO and fO(B.a1, B.a2, 90)) or nil, {}, s[8]
              oO.Size = f7(0, 0, 1, 0)
              oO.AutomaticSize = g
              oO.Text = (nO and ("QUICK BAR " .. nO)) or "+ PIN"
              oO.FontFace = L
              oO.TextSize = 9.5
              oO.TextTransparency = (nO and 0) or 0.4
              oO.TextColor3 = (nO and B.on) or B.wh
              f:yT(WO, 0, AO, XO, EO, W(oO))
              f:yT(VO, 0, SO, w(WO))
              f7 = lO(VO)
              if tO then
                W({Parent = f7, Size = Q(0, 22), AutomaticSize = g, Text = tO, FontFace = I, TextSize = 10.5, TextXAlignment = Y, BackgroundTransparency = 0.88, E(7), yO(0, 7)})
              end
              eO += 1
              WO, kO = {Parent = IO, LayoutOrder = eO}, s[8]
              WO.Size = kO(1, -6, 0, 38)
              WO.BackgroundTransparency = 0.955
              SO, DO, AO, oO = E(12), o(0.9), {Position = Q(12, 0)}, s[8]
              AO.Size = oO(1, -190, 1, 0)
              AO.RichText = true
              XO, bO = rO(mO), s[2]
              oO, VO = bO.Keys[mO].Kind ~= "toggle"
              if oO then
                nO = s[2]
                VO = "  <font transparency=\"0.6\">" .. (nO.Keys[mO].Kind .. "</font>")
              else
                VO = oO
              end
              AO.Text = XO .. (VO or "")
              AO.FontFace = U
              AO.TextSize = 13
              AO.TextTruncate = O
              f:yT(WO, 0, SO, DO, f7, W(AO))
              FO(Z(WO), 0.97, function()
                gO:Pin(mO)
              end)
              TO = eO
            else
            end
          else
          end
        end
        k.Visible, k.Text = TO == 0, ((hO == "All") and "No option matches") or "Nothing pinned or bound yet"
      end
      local k, nO, IO = {}, ipairs, {"All", "Pinned"}
      for tO, lO in nO(IO) do
        k[tO] = W({Size = J, Text = lO, FontFace = U, TextSize = 12, TextXAlignment = Y, TextColor3 = ((tO == 1) and B.on) or B.wh})
        _O, QO = {Parent = NO}, s[8]
        _O.Position = QO((tO - 1) / 2, 0, 0, 0)
        PO = s[8]
        _O.Size = PO(0.5, 0, 1, 0)
        _O.ZIndex = 2
        f:yT(_O, 0, k[tO])
        FO(Z(_O), 0.95, function()
          hO = lO
          for nO, IO in ipairs(k) do
            sO(IO, {TextColor3 = ((nO == tO) and B.on) or B.wh}, 0.2)
          end
          local k, nO = {}, s[8]
          k.Position = nO((tO - 1) / 2, 0, 0, 0)
          sO(KO, k, 0.3, V)
          uO()
        end)
      end
      local k = 0
      d(jO:GetPropertyChangedSignal("Text"), function()
        k += 1
        local nO = k
        task.delay(0.2, function()
          if nO == k then
            uO()
          end
        end)
      end)
      GO:Button("Clear all quick bars", "Clear", function()
        OO("Clear every quick bar?", "Options keep their state, they just leave the bars.", "warn", "Clear", function()
          x.pins = {}
          CO()
          F()
        end)
      end, "danger")
      GO:Button("Clear all keybinds", "Clear", function()
        OO("Clear every keybind?", "Keys stop toggling options until you set them again.", "warn", "Clear", function()
          x.keys = {}
          CO()
          F()
        end)
      end, "danger")
      d(G.InputBegan, function(k, F)
        if F then
          return
        else
          local GO = s[2]
          if GO.kw then
            return
          elseif X.keys then
            local X = s[4]
            if k.UserInputType ~= X.UserInputType.Keyboard then
              return
            end
          else
            return
          end
        end
        local X, GO = next, x.keys
        for x, nO in X, GO, nil do
          F = s[2]
          local X = F.Keys[x]
          if X then
            if nO == k.KeyCode.Name then
              if X.Kind == "button" then
                X.Fire()
                local k = s[2]
                k:Notify(rO(x), "Pressed", "ok", 2)
              else
                local k = s[2]
                k.qb = true
                X:Set(not X.Value)
                k = s[2]
                k.qb = nil
                k = s[2]
                k:Notify(rO(x), (X.Value and "Turned on") or "Turned off", (X.Value and "ok") or "info", 2)
              end
            end
          end
        end
      end)
      dO()
      LO()
      return q
    end
    gO.Wheel = function(q, k)
      q = gO.Cur and gO.Cur.sc
      if G.TouchEnabled then
        return
      elseif gO.open then
        if wO.open then
          return
        elseif gO.dlg then
          return
        elseif (os.clock() - (gO.wt or 0)) < 0.015 then
          return
        elseif q then
          if not (q:IsA("ScrollingFrame")) then
            return
          end
        else
          return
        end
      else
        return
      end
      gO.wt = os.clock()
      local F = G:GetMouseLocation() - ((gO.Gui.IgnoreGuiInset and M()) or M(0, 58))
      for x, X in next, gO.nest, nil do
        local GO, nO, LO = x.AbsolutePosition, x.AbsoluteSize, x.CanvasPosition.Y
        q = if x.Parent then if (gO.Cur.top or gO.Cur) == X then if F.X >= GO.X then if F.Y >= GO.Y then if F.X <= (GO.X + nO.X) then if F.Y <= (GO.Y + nO.Y) then if (k > 0) and (LO > 1) then x else if k < 0 then if LO < ((x.AbsoluteCanvasSize.Y - nO.Y) - 1) then x else q else q else q else q else q else q else q else q
      end
      local F, x, X = math.max(0, q.AbsoluteCanvasSize.Y - q.AbsoluteWindowSize.Y), gO.goal, q.CanvasPosition.Y
      x = if x then if gO.gf ~= q then X else if math.abs(x - X) > 300 then X else x else X
      gO.goal = math.clamp(x - (k * 120), 0, F)
      gO.gf = q
      sO(q, {CanvasPosition = M(0, gO.goal)}, 0.4)
    end
    d(G.InputChanged, function(q)
      local k, F = gO.Cur and gO.Cur.sc, s[4]
      if q.UserInputType ~= F.UserInputType.MouseWheel then
        return
      elseif k then
      else
        return
      end
      local F, x, X = G:GetMouseLocation() - ((gO.Gui.IgnoreGuiInset and M()) or M(0, 58)), k.AbsolutePosition, k.AbsoluteSize
      if F.X < x.X then
        return
      elseif F.Y < x.Y then
        return
      elseif F.X > (x.X + X.X) then
        return
      elseif F.Y > (x.Y + X.Y) then
        return
      end
      gO:Wheel(q.Position.Z)
    end)
    gO.Destroy = function(q)
      q = T
      for k, k in ipairs(q) do
        k:Disconnect()
      end
      T = {}
      local k, k = s[19], s[19]
      pcall(s[19].UnbindFromRenderStep, s[19], ZO)
      RO:Destroy()
      q = getgenv and getgenv().VenyxWindows
      if q then
        if q[gO.Id] == gO then
          q[gO.Id] = nil
        end
      end
    end
    gO.Notify = function(q, ...)
      q = s[2]
      return q:Notify(...)
    end
    xO = s[2]
    xO:Boot()
    gO:Show(true)
    return gO
  end
  zO.new = function(q, k, F, T)
    local x, X, GO = setmetatable({t = q, W = q.W, n = 0, name = k, side = T}, zO), {}, s[8]
    X.Size = GO(1, 0, 0, 42)
    local nO, LO, IO = S({Position = Q(14, 14), Size = Q(15, 15), Image = F or "grid", ImageColor3 = P[(#q.Secs % 5) + 1]}), {Position = Q(37, 12)}, s[8]
    LO.Size = IO(1, -76, 0, 18)
    LO.Text = k:upper()
    LO.FontFace = L
    LO.TextSize = 12
    LO.TextTransparency = 0.06
    LO.TextTruncate = O
    f:yT(X, 0, nO, W(LO))
    x.hd = Z(X)
    nO, IO = {Parent = x.hd, AnchorPoint = N}, s[8]
    nO.Position = IO(1, -22, 0, 21)
    nO.Size = Q(14, 14)
    nO.Image = "down"
    nO.ImageTransparency = 0.5
    x.ch = S(nO)
    k, X, GO = s[6], {LayoutOrder = 1, Size = R, AutomaticSize = j, ClipsDescendants = true}, s[9]
    f:yT(X, 0, GO())
    x.f = k(X)
    if T then
      if T > 2 then
        q.cols[T].Visible = true
      end
    end
    nO, GO, F = s[6], {Parent = q.cols[T or 1], Size = R, AutomaticSize = j, BackgroundTransparency = 0.95, LayoutOrder = #q.Secs + 1}, s[9]
    f:yT(GO, 0, E(16), o(0.88), F(), x.hd, x.f)
    x.card = nO(GO)
    MO(x.hd, function()
      x:Collapse(x.open ~= false)
    end)
    q.Secs[#q.Secs + 1] = x
    q.list[#q.list + 1] = x
    d(x.card:GetPropertyChangedSignal("AbsoluteSize"), function()
      YO(q)
    end)
    YO(q)
    return x
  end
  zO.Collapse = function(q, P)
    q.open = not P
    local k = q.f
    local F = math.max(q.hd.AbsoluteSize.Y / 42, 0.1)
    local T, x = k:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y / F, s[8]
    k.Size = x(1, 0, 0, k.AbsoluteSize.Y / F)
    F = s[4]
    k.AutomaticSize = F.AutomaticSize.None
    x, F = {}, s[8]
    x.Size = F(1, 0, 0, (P and 0) or T)
    F, T = sO(k, x, 0.35), function()
      if q.open then
        k.AutomaticSize = j
      end
    end
    F.Completed:Connect(T)
    F, x = q.ch, {}
    x.Rotation = (P and -90) or 0
    sO(F, x, 0.3)
  end
  zO.Add = function(q, P, k, F)
    if q.n > 0 then
      n(P, Q(14, 0), s[8](1, -28, 0, 1))
    end
    q.n = q.n + 1
    if F then
      local F = q.W.All
      local T, x = #F + 1, {r = P, n = k:lower(), title = k, tab = q.t.top, path = q.t.Name .. (" / " .. q.name)}
      x.k, F[T] = q.t.Name .. ("/" .. (q.name .. ("/" .. k))), x
    end
  end
  zO.Row = function(q, P, k, F)
    local T, x, X = (k and 48) or 42, {Parent = q.f}, s[8]
    x.Size = X(1, 0, 0, T)
    x.LayoutOrder = q.n + 1
    f:yT(x, 0, E(14))
    local GO = Z(x)
    q:Add(GO, P, true)
    qO(GO, 0.97)
    d(GO.InputBegan, function(qO)
      if aO(qO) then
        sO(GO, {BackgroundTransparency = 0.94}, 0.08)
      end
    end)
    d(GO.InputEnded, function(qO)
      if aO(qO) then
        sO(GO, {BackgroundTransparency = 1}, 0.35)
      end
    end)
    X, q, T = s[6], {Parent = GO, AnchorPoint = M(0, 0.5)}, s[8]
    q.Position = T(0, 14, 0.5, 0)
    x = s[8]
    q.Size = x(1, -F - 42, 0, (k and 42) or 21)
    x = s[9]
    local T, qO, nO = x(0, nil, h), {}, s[8]
    qO.Size, qO.Text, qO.TextSize, qO.TextTruncate = s[8](1, 0, 0, 21), P, 14.5, O
    f:yT(q, 0, T, W(qO))
    qO = X(q)
    if k then
      W({Parent = qO, LayoutOrder = 1, Size = R, AutomaticSize = j, Text = k, TextSize = 12, TextTransparency = 0.3, TextWrapped = true})
    end
    k, q, x = s[6], {Parent = GO, AnchorPoint = z}, s[8]
    q.Position = x(1, -14, 0.5, 0)
    q.Size = Q(F, 36)
    return GO, k(q), qO
  end
  zO.Reg = function(q, P, k)
    local F = k.Value
    k.Key, k.Name, k.Def = q.t.Name .. ("/" .. (q.name .. ("/" .. P))), P, ((type(F) == "table") and table.clone(F)) or F
    F, q = s[2]
    q, F.Opt[P], s[2].Keys[k.Key] = s[2], k, k
    local q = k.Set
    k.Set = function(P, ...)
      q(P, ...)
      P = s[11]
      if P.AutoSave then
        local q = s[2]
        if not (q.busy) then
          if not (k.Skip) then
            local q = s[2]
            q:Dirty()
          end
        end
      end
    end
    return k
  end
  zO.Hold = function(q, P, k)
    local F = 0
    d(P.InputEnded, function(T)
      if aO(T) then
        F += 1
      end
    end)
    d(P.InputBegan, function(P)
      local T = q.W
      if not (T.Pin) then
        return
      end
      local q = s[4]
      if P.UserInputType == q.UserInputType.MouseButton2 then
        local q = k.Key
        return T:Pin(q)
      end
      if not (aO(P)) then
        return
      end
      F += 1
      local q = F
      local x, x = s[4], P.UserInputType == s[4].UserInputType.MouseButton1
      task.delay(0.6, function()
        local X, qO = ((F == q) and (iO.m < 14)) and not iO.s
        if X then
          local q = x and G:IsMouseButtonPressed(P.UserInputType)
          if q then
            qO = q
          else
            local q = not x
            if x then
              qO = q
            else
              local q
              q, qO = s[4], P.UserInputState ~= s[4].UserInputState.End
            end
          end
        else
          qO = X
        end
        if qO then
          iO.s = true
          T:Pin(k.Key)
        end
      end)
    end)
  end
  zO.Toggle = function(q, P, k, F, T)
    local x, X = q:Row(P, T, 48)
    local T = e(X, 46, 24)
    local e
    e = {Value = not not k, ls = {}, Tab = q.t.Name, Kind = "toggle", Set = function(X, X, qO)
      X = not not X
      e.Value = X
      T(X)
      for GO, GO in ipairs(e.ls) do
        GO(X)
      end
      if not (qO) then
        cO(F, X)
      end
    end}
    MO(x, function()
      e:Set(not e.Value)
    end)
    q:Hold(x, e)
    T(e.Value, true)
    if k then
      cO(F, true)
    end
    return q:Reg(P, e)
  end
  local q = {K = 1000, M = 1000000, B = 1000000000, T = 1000000000000}
  zO.Slider = function(P, k, F, T, e, x, X, qO, GO)
    local nO, LO, IO = X == "log"
    if nO then
      F, T = 0, 1000
      LO, IO = F, T
    else
      LO, IO = F, T
    end
    local F = qO or 1
    local T, qO, tO = P:Row(k, GO, 200)
    local KO = tO:FindFirstChildOfClass("TextLabel")
    KO:SetAttribute("nofit", true)
    KO.TextSize = 17
    local PO = {w = 0}
    local function CO()
      local NO = s[8]
      tO.Size = NO(0, PO.w, tO.Size.Y.Scale, tO.Size.Y.Offset)
      NO = s[8]
      qO.Size = NO(1, -PO.w - 46, 0, 36)
    end
    PO[#PO + 1] = CO
    local function tO()
      local NO = KO.AbsoluteSize.Y / 21
      if NO <= 0 then
        return
      elseif KO.TextBounds.X <= 0 then
        return
      end
      local YO = math.max(math.ceil(KO.TextBounds.X / NO) + 6, (GO and math.min(150, (#GO * 6.3) + 6)) or 0)
      if YO <= PO.w then
        return CO()
      end
      PO.w = YO
      for GO, GO in ipairs(PO) do
        GO()
      end
    end
    d(KO:GetPropertyChangedSignal("TextBounds"), tO)
    task.defer(tO)
    local GO, KO, PO = s[6], {Parent = qO}, s[8]
    KO.Position = PO(0, 8, 0.5, -3)
    PO = s[8]
    KO.Size = PO(1, -70, 0, 6)
    KO.BackgroundTransparency = 0.88
    f:yT(KO, 0, E())
    local CO = GO(KO)
    PO, GO = {Parent = CO}, s[8]
    PO.Size = GO(0, 0, 1, 0)
    f:yT(PO, 0, E(), fO(B.a1, B.a2))
    local NO, YO, lO = w(PO), {Parent = CO, AnchorPoint = N}, s[8]
    YO.Position = lO(0, 0, 0.5, 0)
    YO.Size = Q(20, 20)
    YO.ZIndex = 2
    f:yT(YO, 0, E(), o(0.65, i(0, 0, 0)))
    local PO, lO = w(YO), s[3]
    local YO = lO("UIScale", {Parent = PO})
    GO = o(0.8)
    local uO = A({Parent = qO, AnchorPoint = z, Position = _, Size = Q(54, 28), FontFace = L, TextSize = 13, TextTruncate = O, TextColor3 = B.val, TextXAlignment = Y, BackgroundTransparency = 0.72, BackgroundColor3 = i(0, 0, 0), E(8), yO(4, 4), GO})
    local function jO(gO)
      if gO <= 0 then
        return 0
      end
      local OO = 10 ^ (3 + ((9 * gO) / 1000))
      gO = 10 ^ (math.floor(math.log10(OO)) - 2)
      return math.floor((OO / gO) + 0.5) * gO
    end
    local function gO(OO)
      return (nO and (((OO <= 0) and 0) or math.clamp(((math.log10(OO) - 3) / 9) * 1000, 0, 1000))) or OO
    end
    local function OO(hO, RO)
      local _O, rO = string.format, ((hO >= 100) and "%.0f") or ((hO >= 10) and "%.1f")
      local VO = _O(rO or "%.2f", hO)
      return ((VO:find("%.") and VO:gsub("0+$", ""):gsub("%.$", "")) or VO) .. RO
    end
    local function hO(RO, _O)
      if not (nO) then
        return ((type(X) == "function") and X(RO)) or (HO(RO) .. (X or ""))
      end
      if RO <= 0 then
        return (_O and "0") or "Off"
      end
      local X = (((RO < 1000000) and 1000) or ((RO < 1000000000) and 1000000)) or 1000000000
      return OO(RO / X, ((((X == 1000) and "K") or ((X == 1000000) and "M")) or "B") .. ((_O and "") or "/s"))
    end
    tO, KO = {Parent = qO, Position = Q(-4, -2)}, s[8]
    tO.Size = KO(1, -60, 1, 4)
    tO.ZIndex = 3
    lO = Z(tO)
    local X
    X = {ls = {}, Kind = "slider", Set = function(qO, HO, tO, KO)
      if type(HO) ~= "number" then
        local OO, RO = tostring(HO):upper():match("^([%d%.]+)(%a?)")
        local _O, rO = tonumber(OO) or 0, q[RO] or ((nO and 1000000) or 1)
        HO = _O * rO
      else
      end
      HO = (nO and jO(gO(HO))) or math.clamp((math.floor(((HO - LO) / F) + 0.5) * F) + LO, LO, IO)
      qO = HO ~= X.Value
      X.Value = HO
      local q, F, OO = (gO(HO) - LO) / (IO - LO), {}, s[8]
      F.Size = OO(q, 0, 1, 0)
      sO(NO, F, (KO and 0.08) or 0.3)
      OO, F = {}, s[8]
      OO.Position = F(q, 0, 0.5, 0)
      sO(PO, OO, (KO and 0.08) or 0.3)
      if not (uO:IsFocused()) then
        uO.Text = hO(HO)
      end
      for q, q in ipairs(X.ls) do
        q(HO)
      end
      if tO then
      elseif qO then
        cO(x, HO)
      end
    end}
    local q
    local function F(x)
      local qO = LO + ((IO - LO) * math.clamp((x - CO.AbsolutePosition.X) / CO.AbsoluteSize.X, 0, 1))
      X:Set((nO and jO(qO)) or qO, false, true)
    end
    local function x(qO)
      q = qO
      if P.t.cols then
        if G.TouchEnabled then
          P.t.sc.ScrollingEnabled = not qO
        end
      end
      sO(YO, {Scale = (qO and 1.25) or 1}, 0.22, V)
    end
    d(lO.InputBegan, function(qO)
      local HO = s[2]
      local tO = HO.drag
      if aO(qO) then
        if tO then
          if tO ~= X then
            if tO.d then
              HO = s[4]
              if tO.d.UserInputState ~= HO.UserInputState.End then
                return
              end
            end
          end
        end
      else
        return
      end
      tO = s[2]
      tO.drag = X
      X.d = qO
      iO.s = true
      x(qO)
      F(qO.Position.X)
    end)
    local function qO()
      local aO, iO = q.UserInputType, s[4]
      return aO == iO.UserInputType.MouseButton1
    end
    d(G.InputChanged, function(aO)
      local iO, HO = q
      if iO then
        local tO = aO == q
        if tO then
          HO = tO
        else
          local tO = qO()
          if tO then
            local KO
            KO, HO = s[4], aO.UserInputType == s[4].UserInputType.MouseMovement
          else
            HO = tO
          end
        end
      else
        HO = iO
      end
      if HO then
        F(aO.Position.X)
      end
    end)
    d(G.InputEnded, function(F)
      local aO, iO = q
      if aO then
        local HO = F == q
        if HO then
          iO = HO
        else
          local q = qO()
          if q then
            local qO
            qO, iO = s[4], F.UserInputType == s[4].UserInputType.MouseButton1
          else
            iO = q
          end
        end
      else
        iO = aO
      end
      if iO then
        F = s[2]
        F.drag = nil
        x(nil)
      end
    end)
    d(uO.Focused, function()
      uO.Text = (nO and hO(X.Value, true)) or tostring(X.Value)
      sO(uO, {BackgroundTransparency = 0.75}, 0.15)
    end)
    BO(uO, GO, 0.5, 0.8, function()
      sO(uO, {BackgroundTransparency = 0.9}, 0.2)
      local q = uO.Text:gsub("[%s,/]", ""):gsub("[sS]$", "")
      q = if nO then if q:lower() == "off" then "0" else q else q
      if q:match("^%-?[%d%.]+%a?$") then
        X:Set((nO and q) or tonumber(q))
      end
      uO.Text = hO(X.Value)
    end)
    X.Frac = function(q)
      return (gO(q) - LO) / (IO - LO)
    end
    X.Txt = hO
    X.From = function(q)
      q = LO + ((IO - LO) * q)
      return (nO and jO(q)) or q
    end
    P:Hold(T, X)
    X:Set(e, true)
    return P:Reg(k, X)
  end
  zO.Dropdown = function(q, P, k, F, T, e, x)
    local X, qO = q:Row(P, x, 176)
    local GO, aO, iO = s[6], {Parent = qO, AnchorPoint = M(0, 0.5)}, s[8]
    aO.Position = iO(0, 0, 0.5, 0)
    x = s[8]
    aO.Size = x(1, 0, 0, 32)
    aO.BackgroundTransparency = 0.93
    local x, iO, nO, HO = E(10), o(0.87), {AnchorPoint = z}, s[8]
    nO.Position = HO(1, -8, 0.5, 0)
    nO.Size = Q(13, 13)
    nO.Image = "down"
    f:yT(aO, 0, x, iO, S(nO))
    qO = GO(aO)
    aO, x = {Parent = qO, Position = Q(9, 0)}, s[8]
    aO.Size = x(1, -34, 1, 0)
    aO.FontFace = U
    aO.TextSize = 14
    aO.TextTruncate = O
    local x, iO, nO = W(aO), {Parent = qO, AnchorPoint = z}, s[8]
    iO.Position = nO(1, -26, 0.5, 0)
    iO.Size = Q(0, 18)
    iO.AutomaticSize = g
    iO.FontFace = U
    iO.TextSize = 11
    iO.TextColor3 = i(226, 229, 255)
    iO.BackgroundTransparency = 0.72
    iO.BackgroundColor3 = B.a1
    iO.TextXAlignment = Y
    f:yT(iO, 0, E(), yO(0, 6))
    local qO, aO = W(iO), {Options = k, Multi = e}
    local k = q.W
    aO.Set = function(iO, nO, HO)
      aO.Value = (e and (((type(nO) == "table") and nO) or {nO})) or nO
      nO = (e and (type(aO.Options) == "table")) and aO.Options
      if nO then
        local LO = {}
        for IO, tO in ipairs(nO) do
          LO[((type(tO) == "table") and tO.v) or tO] = IO
        end
        aO.Value = table.clone(aO.Value)
        table.sort(aO.Value, function(IO, tO)
          return (LO[IO] or 1000000000) < (LO[tO] or 1000000000)
        end)
      end
      iO = (e and #aO.Value) or 0
      x:SetAttribute("alt", ((iO > 1) and (aO.Value[1] .. "...")) or nil)
      x.Text = (e and (((iO == 0) and "None") or tostring(aO.Value[1]))) or tostring(aO.Value or "None")
      qO.Text = "+" .. (iO - 1)
      qO.Visible = iO > 1
      nO = s[8]
      x.Size = nO(1, ((iO > 1) and -70) or -34, 1, 0)
      x.TextTransparency = 0.6
      sO(x, {TextTransparency = 0}, 0.3)
      k:Sync(aO)
      if not (HO) then
        cO(T, aO.Value)
      end
    end
    aO.Refresh = function(k, k)
      aO.Options = k
    end
    MO(X, function()
      local k = ((type(aO.Options) == "function") and aO.Options()) or aO.Options
      q.W:Pick(P, k, aO.Value, e, function(k)
        aO:Set(k)
      end, aO.Default, aO)
    end)
    aO.Default = (e and table.clone(F or {})) or nil
    GO = e and (F or {})
    aO:Set(GO or F, true)
    return q:Reg(P, aO)
  end
  zO.Input = function(q, P, k, F, T)
    local e, x = q:Row(P, T, 176)
    local X, qO, GO = o(0.87), {Parent = x, AnchorPoint = M(0, 0.5)}, s[8]
    qO.Position = GO(0, 0, 0.5, 0)
    x = s[8]
    qO.Size = x(1, 0, 0, 26)
    qO.BackgroundTransparency = 0.8
    qO.BackgroundColor3 = i(0, 0, 0)
    qO.PlaceholderText = k or ""
    qO.TextSize = 13
    qO.TextTruncate = O
    T = s[4]
    qO.TextXAlignment = T.TextXAlignment.Left
    qO.ClipsDescendants = true
    f:yT(qO, 0, E(10), yO(0, 10), X)
    local k = A(qO)
    local T
    T = {Value = "", ls = {}, Kind = "input", Set = function(x, x, A)
      T.Value = tostring(x or "")
      k.Text = T.Value
      for x, x in ipairs(T.ls) do
        x(T.Value)
      end
      if not (A) then
        cO(F, T.Value)
      end
    end}
    q:Hold(e, T)
    BO(k, X, 0.5, 0.87, function()
      T:Set(k.Text)
    end)
    MO(e, function()
      k:CaptureFocus()
    end)
    return q:Reg(P, T)
  end
  zO.Key = function(q, P, k, F, T, e)
    local x, A = q:Row(P, e, 60)
    local e = o(0.82)
    local X, qO = {Parent = A, AnchorPoint = z, Position = _, Size = Q(0, 26), AutomaticSize = g, FontFace = I, TextXAlignment = Y, BackgroundTransparency = 0.92}, s[3]
    f:yT(X, 0, E(9), yO(0, 12), e, qO("UISizeConstraint", {MinSize = M(36, 26)}))
    local A, qO, GO = W(X), {}
    qO.Set = function(X, aO, iO)
      qO.Value = aO
      X = (aO and aO.Name) or "None"
      A.Text = C[X] or X
      sO(e, {Transparency = 0.82, Color = B.wh}, 0.2)
      if not (iO) then
        cO(T, aO)
      end
    end
    MO(x, function()
      local C = s[2]
      GO = true
      C.kw = true
      A.Text = "..."
      sO(e, {Transparency = 0.4, Color = B.a1}, 0.2)
    end)
    d(G.InputBegan, function(C, T)
      local e, x = GO
      if e then
        local A
        A, x = s[4], C.UserInputType == s[4].UserInputType.Keyboard
      else
        x = e
      end
      if x then
        GO = false
        task.defer(function()
          local e = s[2]
          e.kw = nil
        end)
        qO:Set(((C.KeyCode ~= s[4].KeyCode.Escape) and C.KeyCode) or nil)
      elseif T then
      elseif qO.Value then
        if C.KeyCode == qO.Value then
          cO(F)
        end
      end
    end)
    qO:Set(k, true)
    return q:Reg(P, qO)
  end
  zO.Button = function(q, P, C, k, F, T)
    local e, x, A = ({danger = B.red, gold = B.gold, mint = B.mint, pink = B.pink})[F] or B.sky, q:Row(P, T, 110)
    local X = W({Parent = A, AnchorPoint = z, Position = _, Size = Q(0, 26), AutomaticSize = g, Text = C or "Run", FontFace = U, TextSize = 13, TextTransparency = 1, yO(0, 14)})
    T, F = {Parent = X, AnchorPoint = N, Position = v}, s[8]
    T.Size = F(1, 28, 1, 0)
    T.Text = X.Text
    T.FontFace = U
    T.TextSize = 13
    T.TextColor3 = e:Lerp(B.wh, 0.55)
    T.TextXAlignment = Y
    T.BackgroundTransparency = 0.85
    T.BackgroundColor3 = e
    f:yT(T, 0, E(10), o(0.5, e))
    local _ = W(T)
    UO(_, 0.93, x, function(F)
      sO(_, {BackgroundTransparency = (F and 0.7) or 0.85}, 0.2)
    end)
    MO(x, function()
      cO(k)
    end)
    C, A = {Kind = "button", Skip = true, Text = X.Text, Col = e, Name = P, Key = q.t.Name .. ("/" .. (q.name .. ("/" .. P))), Fire = function()
      cO(k)
    end, Set = function(P, k)
      X.Text = k
      _.Text = k
      P.Text = k
    end}, s[2]
    A.Keys[C.Key] = C
    q:Hold(x, C)
    return C
  end
  zO.Stats = function(q, P)
    local C = s[6]
    local _, k = C({Parent = q.f, Size = R, AutomaticSize = j, LayoutOrder = q.n + 1}), s[6]
    local F, T, e, x, A = {Parent = _, Size = R, AutomaticSize = j}, yO(8, 14, 10), s[3], {}, s[8]
    x.CellSize = A(0.5, -6, 0, 40)
    x.CellPadding = Q(12, 6)
    C = s[4]
    x.SortOrder = C.SortOrder.LayoutOrder
    f:yT(F, 0, T, e("UIGridLayout", x))
    C = k(F)
    q:Add(_, "")
    x, e = {}, ipairs
    for X, qO in e(P) do
      _ = (type(qO) == "table") and qO[2]
      qO = ((type(qO) == "table") and qO[1]) or qO
      A, F = (_ and 40) or 10, s[6]
      q = F({Parent = C, LayoutOrder = X, BackgroundTransparency = 0.95, E(10)})
      if _ then
        T, X = {Parent = q, Position = Q(8, 7), Size = Q(26, 26), Image = _}, s[4]
        T.ScaleType = X.ScaleType.Fit
        T.ImageColor3 = (D[_] and B.a1) or nil
        S(T)
      end
      X, k = {Parent = q, Position = Q(A, 4)}, s[8]
      X.Size = k(1, -A - 8, 0, 14)
      X.Text = qO:upper()
      X.FontFace = L
      X.TextSize = 9.5
      X.TextTransparency = 0.38
      W(X)
      local P, C = {Parent = q, Position = Q(A, 19)}, s[8]
      P.Size = C(1, -A - 8, 0, 17)
      P.Text = "--"
      P.FontFace = I
      P.TextSize = 13
      P.TextTruncate = O
      x[qO] = W(P)
    end
    return JO(x)
  end
  zO.List = function(q, P, C)
    local _, k, F = s[6], {Parent = q.f, LayoutOrder = q.n + 1}, s[8]
    k.Size = F(1, 0, 0, (P * 64) + 12)
    P = _(k)
    q:Add(P, "")
    _, F = {Parent = P, Position = Q(10, 6)}, s[8]
    _.Size = F(1, -20, 1, -12)
    F = s[9]
    f:yT(_, 0, F(6))
    local k = H(_)
    q.W.nest[k] = q.t.top or q.t
    local q, _, F, T = W({Parent = P, Size = J, Text = C or "Nothing here", TextSize = 12, TextTransparency = 0.45, TextXAlignment = Y}), {}, {}
    local function P(C)
      local e = C.it and (C.it.id == T)
      C.s.Color = (e and B.a1) or B.wh
      C.s.Transparency = (e and 0.3) or 0.9
      C.r.BackgroundTransparency = (e and 0.9) or 0.955
    end
    local function C()
      local e, x, A = {s = o(0.9)}, {Parent = k}, s[8]
      x.Size = A(1, -6, 0, 58)
      x.BackgroundTransparency = 0.955
      f:yT(x, 0, E(15), e.s)
      e.r = Z(x)
      A = s[6]
      e.box = A({Parent = e.r, Position = Q(8, 8), Size = Q(42, 42), BackgroundTransparency = 0.8, E(13)})
      x, A = {Parent = e.box, AnchorPoint = N, Position = v, Size = Q(38, 38)}, s[4]
      x.ScaleType = A.ScaleType.Fit
      e.im = b(x)
      A, x = {Parent = e.r, Position = Q(60, 5)}, s[8]
      A.Size = x(1, -152, 0, 18)
      A.FontFace = U
      A.TextSize = 13.5
      A.TextTruncate = O
      e.a = W(A)
      local k, X, qO = s[6], {Parent = e.r, Position = Q(60, 24)}, s[8]
      X.Size = qO(1, -152, 0, 13)
      qO = s[9]
      f:yT(X, 0, qO(8, nil, h, u))
      qO = k(X)
      e.rar = W({Parent = qO, Size = Q(0, 13), AutomaticSize = g, FontFace = L, TextSize = 9.5})
      e.tg = W({Parent = qO, LayoutOrder = 1, Size = Q(0, 13), AutomaticSize = g, FontFace = U, TextSize = 9.5, TextColor3 = i(201, 194, 255)})
      A, k, qO = s[6], {Parent = e.r, Position = Q(60, 39)}, s[8]
      k.Size = qO(1, -152, 0, 15)
      X = s[9]
      f:yT(k, 0, X(8, nil, h, u))
      X = A(k)
      e.v = W({Parent = X, Size = Q(0, 15), AutomaticSize = g, FontFace = I, TextSize = 12, TextColor3 = B.gv})
      e.b = W({Parent = X, LayoutOrder = 1, Size = Q(0, 15), AutomaticSize = g, TextSize = 11, TextTransparency = 0.3})
      x, A = {Parent = e.r, AnchorPoint = z}, s[8]
      x.Position = A(1, -10, 0.5, 0)
      x.Size = Q(78, 32)
      x.BackgroundTransparency = 0
      f:yT(x, 0, E(11), fO(B.g1, B.g2), W({Size = J, FontFace = U, TextSize = 12, TextColor3 = B.dk, TextXAlignment = Y}))
      e.k = Z(x)
      e.kl = e.k:FindFirstChildOfClass("TextLabel")
      UO(e.k)
      MO(e.k, function()
        if e.it then
          if e.it.act then
            cO(e.it.act, e.it)
          end
        end
      end)
      MO(e.r, function()
        if not (e.it) then
          return
        end
        T = e.it.id
        for k, k in next, _, nil do
          P(k)
        end
        cO(e.it.pick, e.it)
      end)
      return e
    end
    F.Set = function(k, e)
      q.Visible = #e == 0
      k = {}
      for q, x in ipairs(e) do
        local e = _[x.id] or C()
        _[x.id], k[x.id] = e, true
        e.it = x
        e.r.LayoutOrder = q
        local q, C = {a = x.title, rar = x.rarity, tg = x.tags, v = x.value, b = x.sub, kl = x.button}, {"a", "rar", "tg", "v", "b", "kl"}
        for A, X in ipairs(C) do
          A = q[X] or ""
          if e[X].Text ~= A then
            e[X].Text = A
          end
        end
        e.k.Visible = x.button ~= nil
        if e.g ~= x.grad then
          C = e.rar:FindFirstChildOfClass("UIGradient")
          if C then
            C:Destroy()
          end
          e.g = x.grad
          if x.grad then
            x.grad:Clone().Parent = e.rar
          end
        end
        e.rar.TextColor3 = ((x.grad and B.wh) or x.color) or B.val
        e.box.BackgroundColor3 = x.color or B.a1
        if e.im.Image ~= (x.image or "") then
          e.im.Image = x.image or ""
        end
        P(e)
      end
      for q, C in next, _, nil do
        if not (k[q]) then
          C.r:Destroy()
          _[q] = nil
        end
      end
    end
    F.Select = function(q, q)
      T = q
      for q, q in next, _, nil do
        P(q)
      end
    end
    return F
  end
  local function q(P, C)
    local _ = P:FindFirstChildOfClass("UIGradient")
    if _ then
      _:Destroy()
    end
    if C then
      C:Clone().Parent = P
    end
  end
  local function P(C)
    C.FontFace, C.TextColor3 = t, C.TextColor3 or B.wh
    C.TextTruncate = O
    local O, _ = W(C), s[3]
    _("UIStroke", {Parent = O, Thickness = math.max(1.2, C.TextSize / 8), Color = i(0, 0, 0), Transparency = 0.05})
    return O
  end
  local C = ColorSequenceKeypoint.new
  local O = {COMMON = {i(30, 34, 42), i(104, 114, 132), i(214, 222, 236)}, UNCOMMON = {i(6, 44, 22), i(36, 168, 84), i(160, 255, 170)}, RARE = {i(6, 24, 78), i(36, 112, 255), i(140, 205, 255)}, EPIC = {i(34, 8, 74), i(146, 56, 255), i(220, 170, 255)}, LEGENDARY = {i(74, 30, 0), i(255, 146, 18), i(255, 228, 130)}, MYTHIC = {i(72, 0, 22), i(255, 38, 88), i(255, 168, 190)}, COSMIC = {i(22, 0, 40), i(128, 0, 154), i(236, 150, 255), i(92, 0, 190)}, SECRET = {i(0, 0, 0), i(52, 52, 64), i(255, 255, 255), stars = true}, ETERNAL = {i(4, 20, 56), i(30, 196, 220), i(255, 160, 255), i(196, 80, 255), shine = true}, DIVINE = {i(84, 54, 0), i(255, 196, 50), i(255, 252, 220), i(255, 236, 150), shine = true, star = i(255, 255, 255), rays = true}}
  local function _(k)
    local F, T, e = k.color or B.a1, O[k.rarity]
    if T then
      e = T
    else
      local O, k, T = {}, F:Lerp(i(0, 0, 0), 0.75), B.wh
      f:yT(O, 0, k, F, F:Lerp(T, 0.6))
      e = O
    end
    return e
  end
  local function O(k, F, T, e)
    F.Parent = k
    F.ClipsDescendants = true
    k = w(F)
    F = {f = k, g = fO(B.wh, B.wh, 120), h = {}, st = {}, ss = {}, sh = pO(30, {0, 1}, {0.4, 1}, {0.5, 0.55}, {0.6, 1}, {1, 1})}
    E(T).Parent, F.g.Parent = k, k
    for x, A in ipairs(e) do
      local X, pO = F.h, {Parent = k, AnchorPoint = N, Position = v, Size = Q(A, A)}
      pO.BackgroundTransparency = 0.96 - (x * 0.1)
      f:yT(pO, 0, E())
      X[x] = w(pO)
    end
    local x, A = ipairs, {{0.13, 0.28, 13}, {0.87, 0.2, 10}, {0.84, 0.72, 12}}
    for X, pO in x(A) do
      local x, A, qO, GO = Q((pO[3] * e[1]) / 95, (pO[3] * e[1]) / 95), F.ss, {Parent = k, AnchorPoint = N}, s[8]
      qO.Position = GO(pO[1], 1.5, pO[2], 1.5)
      qO.Size = x
      qO.Image = "sparkles"
      qO.ImageColor3 = i(90, 50, 0)
      qO.ZIndex = 2
      A[X] = S(qO)
      qO, T, A = F.st, {Parent = k, AnchorPoint = N}, s[8]
      T.Position = A(pO[1], 0, pO[2], 0)
      T.Size = x
      T.Image = "sparkles"
      T.ZIndex = 2
      qO[X] = S(T)
    end
    e = s[6]
    F.sf = e({Parent = k, Size = J, BackgroundColor3 = B.wh, BackgroundTransparency = 0, ZIndex = 4, F.sh})
    return F
  end
  local function k(F, T)
    F.g.Color = ColorSequence.new({C(0, T[2]), C(0.5, T[4] or T[1]:Lerp(T[2], 0.4)), C(1, T[1])})
    for e, e in ipairs(F.h) do
      e.BackgroundColor3 = T[3]
    end
    if T.rays then
      if not (F.ry) then
        local e, x = {Parent = F.f, AnchorPoint = N, Position = v}, s[8]
        e.Size = x(1.5, 0, 1.5, 0)
        x = s[4]
        e.SizeConstraint = x.SizeConstraint.RelativeXX
        e.Image = "rbxassetid://109516122757226"
        e.ImageColor3 = i(255, 250, 215)
        e.ImageTransparency = 0.3
        x = s[4]
        e.ScaleType = x.ScaleType.Fit
        F.ry = b(e)
      end
    end
    if F.ry then
      F.ry.Visible = T.rays == true
    end
    F.sf.Visible = F.live and (T.shine == true)
    for e, x in ipairs(F.st) do
      x.Visible, x.ImageColor3 = (T.shine or T.stars) or false, T.star or T[3]
      x.ImageTransparency = 0.15
      F.ss[e].Visible, F.ss[e].ImageTransparency = x.Visible and (T.star ~= nil), 0.55
    end
    for e, e in ipairs(F.tw or {}) do
      e:Cancel()
    end
    F.tw = {}
    if F.live then
      if not (T.shine) then
        if not (T.rays) then
          return
        end
      end
    else
      return
    end
    local function e(x, A, X, pO, qO)
      local GO, aO = TweenInfo.new
      if pO then
        local iO = s[4]
        aO = iO.EasingStyle.Sine
      else
        aO = pO
      end
      local iO
      if aO then
        iO = aO
      else
        local nO = s[4]
        iO = nO.EasingStyle.Linear
      end
      aO = s[4]
      local nO = c:Create(x, GO(A, iO, aO.EasingDirection.InOut, -1, pO == true, qO or 0), X)
      nO:Play()
      F.tw[#F.tw + 1] = nO
    end
    F.h[#F.h].BackgroundTransparency = 0.82
    e(F.h[#F.h], 1.3, {BackgroundTransparency = 0.62}, true)
    if T.rays then
      F.ry.Rotation = 0
      e(F.ry, 30, {Rotation = 360})
    end
    if T.shine then
      F.sh.Offset = M(-1, 0)
      e(F.sh, 1.2, {Offset = M(1, 0)}, false, 2.2)
      for c, T in ipairs(F.st) do
        T.ImageTransparency, F.ss[c].ImageTransparency = 0.4, 0.95
        e(T, 0.9 + (c * 0.25), {ImageTransparency = 0}, true)
        e(F.ss[c], 0.9 + (c * 0.25), {ImageTransparency = 0.55}, true)
      end
    end
  end
  local c = ColorSequence.new(i(26, 255, 0), i(0, 255, 0))
  local F = Font.new(t.Family, t.Weight, s[4].FontStyle.Italic)
  local function t(T)
    T.FontFace = F
    local F = s[3]
    F("UIGradient", {Parent = T, Color = c, Rotation = 90})
    return T
  end
  local function c(F, T, e)
    return ColorSequence.new({C(0, F), C(0.5, T), C(1, e)})
  end
  local F = {GOLDEN = c(i(255, 250, 190), i(255, 204, 40), i(255, 140, 0)), SILVER = c(i(255, 255, 255), i(196, 214, 246), i(120, 146, 196)), RAINBOW = ColorSequence.new({C(0, i(255, 70, 70)), C(0.25, i(255, 220, 60)), C(0.5, i(80, 255, 110)), C(0.75, i(80, 170, 255)), C(1, i(220, 90, 255))}), NITRO = c(i(255, 244, 130), i(255, 150, 30), i(255, 60, 20)), SCRAMBLED = c(i(240, 205, 255), i(186, 110, 255), i(130, 50, 240)), FRACTURED = c(i(255, 196, 186), i(255, 84, 84), i(200, 20, 40)), ENCHANTED = c(i(210, 255, 255), i(80, 225, 255), i(30, 150, 255)), BLOOM = c(i(255, 228, 244), i(255, 140, 210), i(240, 70, 160)), ["SPIRIT BLOOM"] = c(i(230, 255, 210), i(130, 245, 130), i(40, 190, 90)), PARASITE = c(i(236, 255, 180), i(150, 240, 70), i(70, 180, 30))}
  local function T(e)
    local x, A = e.c or B.a1, s[3]
    return A("UIGradient", {Color = F[e.n:gsub("^%+", "")] or c(x:Lerp(B.wh, 0.6), x, x:Lerp(i(0, 0, 0), 0.25)), Rotation = ((e.n == "RAINBOW") and 0) or 90})
  end
  local function c(F, e, x, A)
    for X, X in ipairs(F:GetChildren()) do
      if X:IsA("GuiObject") then
        X:Destroy()
      end
    end
    for X, pO in ipairs(e or {}) do
      local e = P({Parent = F, LayoutOrder = X, Size = Q(0, x), AutomaticSize = g, TextSize = A, Text = pO.n})
      e:FindFirstChildOfClass("UIStroke").Thickness = A / 5
      T(pO).Parent = e
    end
  end
  local function F(T, e)
    local x = D[e]
    T.ImageRectOffset = M((x % 8) * 64, (x // 8) * 64)
  end
  local function D(T, e, x, A, X)
    local pO, qO, GO = s[6], {Parent = T, LayoutOrder = X}, s[8]
    qO.Size = GO(1, 0, 0, x)
    X, T, GO = s[3], {}, s[8]
    T.CellSize = GO(1 / e, ((-A * (e - 1)) / e) - 1, 0, x)
    T.CellPadding = Q(A, A)
    GO = s[4]
    T.SortOrder = GO.SortOrder.LayoutOrder
    f:yT(qO, 0, X("UIGridLayout", T))
    return pO(qO)
  end
  local function T(e, x)
    local A = s[6]
    local X = A({Parent = e, Size = Q(0, x + 8), AutomaticSize = g, BackgroundTransparency = 0.05, E(), o(0.2), yO(0, 9)})
    return X, P({Parent = X, Size = Q(0, x + 8), AutomaticSize = g, TextSize = x, TextXAlignment = Y})
  end
  local function e(x, A, X, pO)
    x.BackgroundColor3 = X[1]
    x:FindFirstChildOfClass("UIStroke").Color = X[2]
    A.Text = pO.rarity or ""
    q(A, pO.grad)
    A.TextColor3 = ((pO.grad and B.wh) or pO.color) or B.tx
  end
  local function x(A, X)
    local pO = A.Keypoints
    for A = 2, #pO, 1 do
      if X <= pO[A].Time then
        local qO, GO, aO = pO[A - 1].Value, pO[A].Value, (X - pO[A - 1].Time) / math.max(pO[A].Time - pO[A - 1].Time, 0.0001)
        return qO:Lerp(GO, aO)
      end
    end
    return pO[#pO].Value
  end
  local A = {}
  local function X(pO, qO)
    local GO = ((qO.rarity == "ETERNAL") or (qO.rarity == "DIVINE")) and qO.grad
    if GO then
      if math.abs(GO.Rotation) == 90 then
        if not (A[GO]) then
          local qO, aO, iO = ((GO.Rotation < 0) and 0.53) or 0, ((GO.Rotation < 0) and 1) or 0.5, {}
          for nO = 0, 8, 1 do
            iO[#iO + 1] = C(nO / 8, x(GO.Color, qO + (((aO - qO) * nO) / 8)))
          end
          qO = s[3]
          A[GO] = qO("UIGradient", {Color = ColorSequence.new(iO), Rotation = GO.Rotation})
        end
        GO = A[GO]
      else
      end
    else
    end
    q(pO, GO or nil)
  end
  zO.Showcase = function(q, C, x, A, pO)
    local qO, GO, aO = q.t.top or q.t, q.W, 364
    local iO, nO = o(0.5), s[6]
    local HO = nO({Parent = q.f, LayoutOrder = q.n + 1, Size = R, AutomaticSize = j})
    q:Add(HO, "")
    local LO, IO, tO = s[6], {Parent = HO, Size = R, AutomaticSize = j}, s[9]
    f:yT(IO, 0, yO(2, 14, 6), tO(8))
    HO, q = LO(IO), s[6]
    IO, nO = {Parent = HO}, s[8]
    IO.Size = nO(1, 0, 0, 30)
    local BO, KO, PO, CO = q(IO), s[6], {Parent = HO, LayoutOrder = 1, Size = R, AutomaticSize = j}, s[9]
    f:yT(PO, 0, CO(14, nil, nil, u))
    HO, q, IO, CO = KO(PO), s[6], {}, s[6]
    IO.Parent = CO({Parent = HO, Size = Q(250, 370), yO(3, 0)})
    IO.Size = J
    IO.BackgroundTransparency = 0.45
    tO = s[9]
    f:yT(IO, 0, E(20), iO, yO(9), tO(6, l))
    local JO, NO, YO, lO = q(IO), {}, {}, s[8]
    YO.Size = lO(1, 0, 0, 145)
    NO.a = O(JO, YO, 14, {170, 126, 84})
    NO.a.live = true
    KO, q = {Parent = NO.a.f, AnchorPoint = N}, s[8]
    KO.Position = q(0.5, 0, 0.5, 2)
    KO.Size = Q(138, 138)
    LO = s[4]
    KO.ScaleType = LO.ScaleType.Fit
    KO.ZIndex = 3
    NO.im = b(KO)
    LO, lO, PO = s[6], {Parent = NO.a.f}, s[7]
    lO.AnchorPoint = PO
    nO = s[8]
    lO.Position = nO(1, -8, 0, 7)
    lO.Size = Q(0, 0)
    q = s[4]
    lO.AutomaticSize = q.AutomaticSize.XY
    lO.ZIndex = 5
    IO, q = s[9], s[4]
    f:yT(lO, 0, IO(2, q.HorizontalAlignment.Right))
    NO.mu = LO(lO)
    IO, KO = {Parent = JO, LayoutOrder = 1}, s[8]
    IO.Size = KO(1, 0, 0, 24)
    IO.Text = "Pick an egg"
    IO.TextSize = 21
    IO.TextXAlignment = Y
    NO.ti = P(IO)
    NO.rb, NO.ra = T(JO, 13)
    NO.rb.LayoutOrder = 2
    IO, lO = {Parent = JO, LayoutOrder = 3}, s[8]
    IO.Size = lO(1, 0, 0, 30)
    IO.TextSize = 26
    IO.TextXAlignment = Y
    NO.va = t(P(IO))
    local YO, uO, jO, gO = D(JO, 2, 34, 6, 4), {}, ipairs, {{"gauge", "Size"}, {"gem", "Weight"}}
    for OO, hO in jO(gO) do
      CO = s[6]
      nO = CO({Parent = YO, LayoutOrder = OO, BackgroundTransparency = 0.55, BackgroundColor3 = i(0, 0, 0), E(10)})
      PO, lO = {Parent = nO, AnchorPoint = M(0, 0.5)}, s[8]
      PO.Position = lO(0, 8, 0.5, 0)
      PO.Size = Q(15, 15)
      PO.Image = hO[1]
      S(PO)
      tO, q = {Parent = nO, Position = Q(29, 3)}, s[8]
      tO.Size = q(1, -34, 0, 16)
      tO.TextSize = 13
      uO[OO] = P(tO)
      IO, KO = {Parent = nO, Position = Q(29, 19)}, s[8]
      IO.Size = KO(1, -34, 0, 11)
      IO.Text = hO[2]:upper()
      IO.FontFace = L
      IO.TextSize = 8
      IO.TextTransparency = 0.45
      W(IO)
    end
    PO, CO, nO = s[6], {Parent = JO, LayoutOrder = 5}, s[8]
    CO.Size = nO(1, 0, 0, 22)
    CO.BackgroundTransparency = 0.55
    CO.BackgroundColor3 = i(0, 0, 0)
    CO.ClipsDescendants = true
    f:yT(CO, 0, E(8))
    KO = PO(CO)
    tO, q = {Parent = KO, AnchorPoint = M(0, 0.5)}, s[8]
    tO.Position = q(0, 8, 0.5, 0)
    tO.Size = Q(14, 14)
    tO.Image = "clock"
    NO.si = S(tO)
    tO, q = {Parent = KO, Position = Q(28, 0)}, s[8]
    tO.Size = q(1, -36, 1, 0)
    tO.TextSize = 11
    uO[3] = P(tO)
    lO, CO = {Parent = KO, AnchorPoint = M(0, 1)}, s[8]
    lO.Position = CO(0, 0, 1, 0)
    CO = s[8]
    lO.Size = CO(0, 0, 0, 3)
    NO.bf = w(lO)
    PO, YO, gO, jO = {}, s[6], {Parent = JO, LayoutOrder = 6}, s[8]
    gO.Size = jO(1, 0, 0, 34)
    PO.Parent = YO(gO)
    PO.Size = J
    PO.BackgroundTransparency = 0
    lO, jO, KO, gO, LO = E(12), fO(B.a1, B.a2, 90), B.a1, B.wh, s[9]
    f:yT(PO, 0, lO, jO, o(0.55, KO:Lerp(gO, 0.5)), LO(7, l, h, u))
    local q = Z(PO)
    local LO = S({Parent = q, Size = Q(17, 17), Image = "hand", ImageColor3 = B.on})
    local OO = W({Parent = q, LayoutOrder = 1, Size = Q(0, 34), AutomaticSize = g, FontFace = U, TextSize = 15, TextColor3 = B.on})
    UO(q)
    local hO
    MO(q, function()
      if hO then
        cO(pO, hO)
      end
    end)
    PO, jO, CO = s[6], {Parent = BO}, s[8]
    jO.Size = CO(1, -128, 1, 0)
    jO.BackgroundTransparency = 0.93
    f:yT(jO, 0, E(), o(0.9), yO(3))
    lO, nO, CO, IO = PO(jO), s[6], {Parent = BO}, s[7]
    CO.AnchorPoint = IO
    YO = s[8]
    CO.Position = YO(1, 0, 0, 0)
    CO.Size = Q(120, 30)
    CO.BackgroundTransparency = 0.8
    CO.BackgroundColor3 = i(60, 210, 80)
    jO = s[9]
    f:yT(CO, 0, E(), o(0.5, i(96, 238, 92)), jO(0, l, h, u))
    local pO, BO, PO = t(P({Parent = nO(CO), Size = Q(0, 30), AutomaticSize = g, Text = "--", TextSize = 14})), {Parent = lO}, s[8]
    BO.Size = PO(1 / #x, 0, 1, 0)
    f:yT(BO, 0, E(), fO(B.a1, B.a2))
    local fO, nO, PO = w(BO), {}, 1
    local BO, YO, jO = D(lO, #x, 24, 0), {}, ipairs
    for RO, _O in jO(x) do
      IO, lO = {Parent = BO, LayoutOrder = RO}, s[9]
      f:yT(IO, 0, lO(5, l, h, u))
      gO = Z(IO)
      YO[RO] = S({Parent = gO, Size = Q(14, 14), Image = _O[2], ImageColor3 = ((RO == 1) and B.dk) or B.tx})
      nO[RO] = W({Parent = gO, LayoutOrder = 1, Size = Q(0, 24), AutomaticSize = g, Text = _O[1]:upper(), FontFace = L, TextSize = 10, TextColor3 = ((RO == 1) and B.dk) or B.tx})
      MO(gO, function()
        nO[PO].TextColor3, YO[PO].ImageColor3 = B.tx, B.tx
        PO = RO
        nO[RO].TextColor3, YO[RO].ImageColor3, YO[RO].Size = B.dk, B.dk, Q(20, 20)
        sO(YO[RO], {Size = Q(14, 14)}, 0.45, V)
        local L, u = {}, s[8]
        L.Position = u((RO - 1) / #x, 0, 0, 0)
        sO(fO, L, 0.3)
        cO(A, _O[1])
      end)
    end
    KO, CO, IO = s[6], {Parent = HO, LayoutOrder = 1}, s[8]
    CO.Size = IO(1, -264, 0, 370)
    local L = KO(CO)
    local u = H({Parent = L, Size = J, ScrollingEnabled = G.TouchEnabled, ScrollBarThickness = 3, ScrollBarImageColor3 = B.wh, ScrollBarImageTransparency = 0.6})
    GO.nest[u] = qO
    GO:Grip(u, L)
    local G = D(u, C, 178, 8)
    C = nil
    C, G.Position, G.Size = s[8], Q(3, 3), s[8](1, -16, 0, 0)
    G.AutomaticSize = j
    yO(0, 0, 3, 0).Parent = G
    qO, tO = {Parent = u}, s[8]
    qO.Size = tO(1, 0, 0, 40)
    qO.Text = "No eggs yet"
    qO.TextSize = 12
    qO.TextTransparency = 0.45
    qO.TextXAlignment = Y
    local H, C, g, h = W(qO), {}, {}, {}
    local function V(D)
      local S = (hO ~= D) and (((if hO then not D else not hO) or (hO.id ~= D.id)) or (hO.muts ~= D.muts))
      hO = D
      D = D or {}
      local A = _(D)
      if S ~= false then
        k(NO.a, A)
        e(NO.rb, NO.ra, A, D)
        X(NO.ti, D)
        JO.BackgroundColor3, iO.Color = A[1], A[2]
      end
      if NO.m ~= D.muts then
        NO.m = D.muts
        c(NO.mu, D.muts, 20, 13)
      end
      NO.im.Image, NO.ti.Text, NO.va.Text = D.image or "", D.title or "Pick an egg", D.value or "--"
      local S, fO = ipairs, {D.size, D.weight, D.status}
      for qO, GO in S(fO) do
        uO[qO].Text = GO or "--"
      end
      S = (((D.kind == "Ready") and {"sparkles", B.mint}) or ((D.kind == "Growing") and {"clock", B.wh})) or {"egg", A[3]}
      F(NO.si, S[1])
      NO.si.ImageColor3, uO[3].TextColor3 = S[2], S[2]
      S = nil
      S, NO.bf.Size, NO.bf.BackgroundColor3 = s[8], s[8](((D.kind == "Growing") and D.pct) or 0, 0, 0, 3), A[3]
      q.Parent.Visible, OO.Text = D.label ~= nil, D.label or ""
      F(LO, ({["Hatch now"] = "sparkles", ["Go to egg"] = "pin"})[D.label] or "hand")
    end
    local function q()
      local F, D = u.AbsolutePosition.Y, u.AbsoluteSize.Y
      for S, A in next, C, nil do
        S = A.c.AbsolutePosition.Y - F
        local F = (S > (-A.c.AbsoluteSize.Y - 60)) and (S < (D + 60))
        if A.box.Visible ~= F then
          A.box.Visible = F
        end
      end
    end
    d(u:GetPropertyChangedSignal("CanvasPosition"), q)
    d(u:GetPropertyChangedSignal("AbsoluteSize"), q)
    local function u()
      local F = table.remove(g)
      if F then
        F.c.Visible = true
        return F
      end
      local F = {s = o(0.1)}
      F.c = Z({Parent = G, BackgroundTransparency = 0.3, E(18), F.s})
      local G = s[6]
      F.box = G({Parent = F.c, Size = J})
      local J, D, d = F.box, {Position = Q(5, 5)}, s[8]
      D.Size = d(1, -10, 0, 108)
      F.a = O(J, D, 14, {118, 86, 56})
      d, G = {Parent = F.a.f, AnchorPoint = N, Position = v, Size = Q(96, 96)}, s[4]
      d.ScaleType = G.ScaleType.Fit
      d.ZIndex = 3
      F.im = b(d)
      F.rk = P({Parent = F.a.f, Position = Q(7, 5), Size = Q(30, 15), TextSize = 12, ZIndex = 5})
      J, D = {Parent = F.a.f, AnchorPoint = M(0, 1)}, s[8]
      J.Position = D(0, 7, 1, -6)
      J.Size = Q(64, 15)
      J.TextSize = 12
      J.ZIndex = 5
      F.tm = P(J)
      J, D = {Parent = F.a.f, AnchorPoint = M(1, 1)}, s[8]
      J.Position = D(1, -7, 1, -6)
      J.Size = Q(48, 15)
      J.TextSize = 11
      G = s[4]
      J.TextXAlignment = G.TextXAlignment.Right
      J.ZIndex = 5
      F.sz = P(J)
      d, D, G = s[6], {Parent = F.a.f}, s[7]
      D.AnchorPoint = G
      J = s[8]
      D.Position = J(1, -5, 0, 4)
      D.Size = Q(0, 0)
      G = s[4]
      D.AutomaticSize = G.AutomaticSize.XY
      D.ZIndex = 5
      J, G = s[9], s[4]
      f:yT(D, 0, J(1, G.HorizontalAlignment.Right))
      F.mt = d(D)
      J, d = {Parent = F.box, Position = Q(8, 117)}, s[8]
      J.Size = d(1, -16, 0, 18)
      J.TextSize = 14
      J.TextXAlignment = Y
      F.ti = P(J)
      G, D, J = s[6], {Parent = F.box, Position = Q(8, 137)}, s[8]
      D.Size = J(1, -16, 0, 17)
      d = s[9]
      f:yT(D, 0, d(0, l))
      d = G(D)
      F.rb, F.ra = T(d, 10)
      F.rb.BackgroundTransparency, F.rb:FindFirstChildOfClass("UIStroke").Enabled = 1, false
      F.rb:FindFirstChildOfClass("UIPadding"):Destroy()
      J, D = {Parent = F.box, Position = Q(8, 156)}, s[8]
      J.Size = D(1, -16, 0, 17)
      J.TextSize = 14
      J.TextXAlignment = Y
      F.va = t(P(J))
      d, J = {Parent = F.a.f, AnchorPoint = M(0, 1)}, s[8]
      d.Position = J(0, 0, 1, 0)
      D = s[8]
      d.Size = D(0, 0, 0, 3)
      d.ZIndex = 5
      F.bf = w(d)
      MO(F.c, function()
        if not (F.it) then
          return
        end
        h.sel = F.it.id
        for G, G in next, C, nil do
          G.s.Thickness = ((G.it.id == h.sel) and 2.5) or 1.2
        end
        V(F.it)
      end)
      return F
    end
    h.Set = function(G, t, P, J)
      H.Visible, pO.Text = #t == 0, J or "--"
      for H, v in ipairs(x) do
        nO[H].Text = v[1]:upper() .. (((P and P[v[1]]) and ("  " .. P[v[1]])) or "")
      end
      P, G, J = {}, ipairs
      for H, v in G(t) do
        local G = C[v.id] or u()
        C[v.id], P[v.id] = G, true
        G.it = v
        G.c.LayoutOrder = H
        local N = _(v)
        if G.p ~= N then
          G.p = N
          k(G.a, N)
          e(G.rb, G.ra, N, v)
          X(G.ti, v)
          G.c.BackgroundColor3, G.s.Color = N[1], N[2]
        end
        G.s.Thickness = ((v.id == h.sel) and 2.5) or 1.2
        if G.im.Image ~= v.image then
          G.im.Image = v.image or ""
        end
        G.rk.Text, G.ti.Text, G.va.Text, G.tm.Text, G.sz.Text = "#" .. (v.rank or H), v.title, v.value, v.time or "", v.size or ""
        H = ""
        for Y, Y in ipairs(v.muts or {}) do
          H ..= Y.n .. ","
        end
        if G.mk ~= H then
          G.mk = H
          c(G.mt, v.muts, 14, 9)
        end
        H = nil
        H, G.bf.Size, G.bf.BackgroundColor3 = s[8], s[8](v.pct or 0, 0, 0, 3), (v.ready and B.mint) or N[3]
        J = if v.id == h.sel then v else J
      end
      for G, c in next, C, nil do
        if not (P[G]) then
          c.c.Visible = false
          c.it = nil
          c.p = nil
          c.mk = nil
          C[G], g[#g + 1] = nil, c
        end
      end
      task.defer(q)
      J = J or t[1]
      h.sel = J and J.id
      V(J)
    end
    h.Card = function(q, G)
      JO.Parent.Visible = G
      q = s[8]
      L.Size = q(1, (G and -264) or 0, 0, aO + 6)
    end
    V(nil)
    return h
  end
  zO.Order = function(q, G, c, H)
    local L, t = {Value = table.clone(c)}, s[6]
    local P, C = {Parent = q.f, LayoutOrder = q.n + 1}, s[8]
    P.Size = C(1, 0, 0, (#c * 34) + 12)
    C = t(P)
    q:Add(C, G, true)
    local J = {}
    t = #c
    for v = 1, t, 1 do
      local t, N, Y = s[6], {Parent = C, Position = Q(14, 6 + ((v - 1) * 34))}, s[8]
      N.Size = Y(1, -28, 0, 30)
      N.BackgroundTransparency = 0.95
      f:yT(N, 0, E(9))
      Y = t(N)
      W({Parent = Y, Position = Q(10, 0), Size = Q(20, 30), Text = tostring(v), FontFace = I, TextSize = 12, TextTransparency = 0.45})
      P, N = {Parent = Y, Position = Q(34, 0)}, s[8]
      P.Size = N(1, -110, 1, 0)
      P.FontFace = U
      P.TextSize = 13
      J[v] = W(P)
      N, t = ipairs, {-1, 1}
      for I, P in N(t) do
        local t, C = {Parent = Y, AnchorPoint = z}, s[8]
        t.Position = C(1, ((I == 1) and -38) or -6, 0.5, 0)
        t.Size = Q(28, 24)
        t.BackgroundTransparency = 0.9
        f:yT(t, 0, E(7), m("down", 14))
        C = Z(t)
        C:FindFirstChildWhichIsA("ImageLabel").Rotation = ((P < 0) and 180) or 0
        UO(C)
        MO(C, function()
          local I, t = L.Value, v + P
          if t < 1 then
            return
          elseif t > #I then
            return
          end
          I[v], I[t] = I[t], I[v]
          L:Set(I)
        end)
      end
    end
    L.Set = function(I, t, P)
      local C, v = {}, {}
      for N, N in ipairs(((type(t) == "table") and t) or {}) do
        if table.find(c, N) then
          if not (C[N]) then
            C[N] = true
            v[#v + 1] = N
          end
        end
      end
      for N, z in ipairs(c) do
        if not (C[z]) then
          I = #v + 1
          for C = N + 1, #c, 1 do
            t = table.find(v, c[C])
            if t then
              I = t
              break
            end
          end
          table.insert(v, I, z)
        end
      end
      L.Value = v
      for I, t in ipairs(J) do
        t.Text = v[I]
      end
      if not (P) then
        cO(H, v)
      end
    end
    L:Set(c, true)
    return q:Reg(G, L)
  end
  zO.Text = function(q, G)
    local c = W({Size = R, AutomaticSize = j, Text = G, TextSize = 12, TextTransparency = 0.22, TextWrapped = true})
    q.tn = (q.tn or 0) + 1
    local H, L, I = s[6], {Parent = q.f, Size = R, AutomaticSize = j, LayoutOrder = -1000 + q.tn, Visible = G ~= ""}, s[6]
    f:yT(L, 0, I({Size = R, AutomaticSize = j, yO(12, 14), c}))
    local G = H(L)
    if q.n >= q.tn then
      I = s[8]
      n(G, I(0, 14, 1, -1), s[8](1, -28, 0, 1))
    end
    q.n = q.n + 1
    return {Set = function(q, q)
      c.Text, G.Visible = q, q ~= ""
    end}
  end
  s[2].Notify = function(q, G, c, n, H)
    q = s[2]
    local L = q.W
    if not (L) then
      return
    end
    H = H or 4
    local I, t = vO(n)
    q = s[6]
    local P, C = q({Parent = L.nt, Size = R, AutomaticSize = j}), s[6]
    q, L = {Position = Q(42, 0)}, s[8]
    q.Size = L(1, -42, 0, 0)
    q.AutomaticSize = j
    L = s[9]
    local J, v, N = L(2), {}, s[8]
    v.Size = N(1, 0, 0, 17)
    v.Text = G or ""
    v.FontFace = U
    f:yT(q, 0, J, W(v))
    n = C(q)
    if c then
      if c ~= "" then
        W({Parent = n, LayoutOrder = 1, Size = R, AutomaticSize = j, Text = c, TextSize = 12, TextTransparency = 0.3, TextWrapped = true})
      end
    end
    N, C, G = s[6], {AnchorPoint = M(0, 1)}, s[8]
    C.Position = G(0, 0, 1, 10)
    L = s[8]
    C.Size = L(1, 0, 0, 3)
    C.BackgroundTransparency = 0.2
    C.BackgroundColor3 = I
    f:yT(C, 0, E())
    J, q, c, G = N(C), s[6], {Parent = P, Position = Q(360, 0), Size = R, AutomaticSize = j, BackgroundTransparency = 0.06, BackgroundColor3 = i(20, 22, 46)}, s[6]
    f:yT(c, 0, E(16), o(0.86), yO(14, 14, 18), n, J, G({Size = Q(30, 30), BackgroundTransparency = 0.8, BackgroundColor3 = I, E(10), m(t, 16, I)}))
    local G, n, M = q(c), {}, s[8]
    n.Position = M()
    sO(G, n, 0.5)
    sO(J, {Size = Q(0, 3)}, H, s[4].EasingStyle.Linear)
    task.delay(H, function()
      sO(G, {Position = Q(360, 0)}, 0.35, r, s[4].EasingDirection.In)
      task.delay(0.4, P.Destroy, P)
    end)
  end
  s[18] = function()
    local q = s[1]
    local G, c = q.GameId ~= 0
    if G then
      q = s[1]
      c = q.GameId
    else
      c = G
    end
    G = nil
    if c then
      G = c
    else
      q = s[1]
      G = q.PlaceId
    end
    q = s[2]
    local c, n = q.Id ~= "Venyx"
    if c then
      q = s[2]
      n = "/" .. q.Id
    else
      n = c
    end
    return "Venyx/" .. (G .. (n or ""))
  end
  s[17] = function()
    local q = s[18]
    return q() .. ("/" .. a.UserId)
  end
  s[13] = function(q)
    local G = s[17]
    return G() .. ("/" .. (q .. ".json"))
  end
  local q = f:QT(5, 6, {[10] = s}, p, y, nil)
  s[15] = q
  local q = f:QT(7, 6, {[10] = s}, p, y, nil)
  s[14] = q
  s[12] = function(q)
    if q == nil then
      return {z = 1}
    end
    return (((typeof(q) == "Color3") and {c = q:ToHex()}) or ((typeof(q) == "EnumItem") and {k = q.Name})) or q
  end
  local function q(G)
    if type(G) ~= "table" then
      return G
    end
    if G.z then
      return nil
    end
    local c, a = G.c and Color3.fromHex(G.c)
    if c then
      a = c
    else
      local c = G.k
      if c then
        local n = s[4]
        a = n.KeyCode[G.k]
      else
        a = c
      end
    end
    return a or G
  end
  local function G(c, a)
    local n, M, H, U = s[10], s[12], s[10], s[12]
    return n:JSONEncode(M(c)) == H:JSONEncode(U(a))
  end
  s[16] = function(c)
    local a = s[2]
    a.busy = true
    a = next
    for n, M in a, c, nil do
      local a = s[2]
      local H, U = a.Keys[n]
      if H then
        U = H
      else
        a = s[2]
        U = a.Opt[n]
      end
      a = nil
      if U then
        a = U
      else
        H = s[2]
        a = H.Alias[n]
      end
      M = q(M)
      if a then
        if not (a.Skip) then
          if not (G(M, a.Value)) then
            pcall(a.Set, a, M)
          end
        end
      end
    end
    c = s[2]
    c.busy = false
  end
  s[2].Persist = function(q)
    local q, c = s[14], s[17]
    q(c() .. "/_state.json", s[11])
  end
  s[2].Dir = s[17]
  s[2].Rd = s[15]
  s[2].Wr = s[14]
  s[2].Save = f:QT(8, 9, {[11] = s, [2] = s, [12] = s, [13] = s, [14] = s}, p, y, nil)
  s[2].Load = f:QT(10, 11, {[15] = s, [13] = s, [16] = s, [11] = s, [2] = s}, p, y, nil)
  s[2].Configs = f:QT(12, 13, {[17] = s}, p, y, nil)
  s[2].Delete = f:QT(14, 15, {[15] = s, [13] = s, [14] = s, [17] = s, [11] = s, [2] = s}, p, y, nil)
  s[2].Trash = function(q)
    local q = {}
    pcall(function()
      local c = s[17]
      for a, a in ipairs(listfiles(c() .. "/_trash")) do
        q[#q + 1] = a:match("([^/\\]+)%.json$")
      end
    end)
    table.sort(q)
    return q
  end
  s[2].Restore = f:QT(16, 17, {[17] = s, [15] = s, [2] = s}, p, y, nil)
  s[2].Name = function(q, c)
    c = tostring(c or ""):match("^%s*(.-)%s*$")
    if c ~= "" then
      if not (c:match("^[%w _%-]+$")) then
        return nil, "Use letters, numbers, spaces, - or _"
      end
    end
    if #c > 32 then
      return nil, "32 characters at most"
    end
    q = ((c ~= "") and c) or "Config"
    c = if c == "" then "Config 1" else c
    local a = 2
    while true do
      local n, M = isfile
      if n then
        local H
        H, M = s[13], isfile(s[13](c))
      else
        M = n
      end
      if not M then
        break
      end
      c, a = q .. (" " .. a), a + 1
    end
    return c
  end
  s[2].Export = f:QT(18, 19, {[10] = s, [15] = s, [13] = s}, p, y, nil)
  s[2].Import = f:QT(20, 21, {[10] = s, [2] = s, [13] = s}, p, y, nil)
  s[2].Dirty = function(q)
    local c, a = s[2], s[2]
    c.tok = (a.tok or 0) + 1
    q = s[2]
    local c = q.tok
    task.delay(1, function()
      local q = s[2]
      if q.tok == c then
        local q = s[2]
        q:Save()
      end
    end)
  end
  s[2].Reset = function(q)
    q = s[2]
    q.busy = true
    q = s[2]
    for c, c in next, q.Keys, nil do
      if not (c.Skip) then
        if not (G(c.Def, c.Value)) then
          pcall(c.Set, c, ((type(c.Def) == "table") and table.clone(c.Def)) or c.Def)
        end
      end
    end
    q = s[2]
    q.busy = false
    q = s[2]
    q:Save()
  end
  s[2].Off = function(q)
    local q, G = s[2], 0
    for c, c in next, q.Keys, nil do
      if c.Kind == "toggle" then
        if c.Value then
          if c.Skip then
          else
            c:Set(false)
            G += 1
          end
        else
        end
      else
      end
    end
    return G
  end
  s[2].Theme = function(q, G)
    q = nil
    for c, c in ipairs(K) do
      q = if c[1] == G then c else q
    end
    if not q then
      return
    end
    local c = s[2]
    local a, n = c.W, s[2]
    if n.th ~= G then
      c = s[2]
      c.th = G
      local M, H, U = {w1 = q[2], w2 = q[3], a1 = q[4], a2 = q[5], sky = q[4]:Lerp(B.wh, 0.2), g1 = q[5]:Lerp(B.wh, 0.35), g2 = q[4], val = q[5]:Lerp(B.wh, 0.7), pn = q[2]:Lerp(q[3], 0.55), bg = q[2]:Lerp(q[3], 0.75), on = q[6] or i(255, 255, 254)}, {}, {0.35, 0.4, 0.5}
      for i, i in ipairs(U) do
        H[B.a1:Lerp(B.wh, i):ToHex()] = M.a1:Lerp(B.wh, i)
      end
      H[B.sky:Lerp(B.wh, 0.55):ToHex()] = M.sky:Lerp(B.wh, 0.55)
      for i, L in next, M, nil do
        H[B[i]:ToHex()] = L
        B[i] = L
      end
      H[B.wh:ToHex()], H[B.tx:ToHex()] = nil, nil
      local function i(L)
        return H[L:ToHex()]
      end
      U, M = ipairs, {a and a.Gui, (a and a.nt) and a.nt.Parent}
      for H, H in U(M) do
        for M, U in ipairs((H and H:GetDescendants()) or {}) do
          if not (U:FindFirstAncestor("VenyxThemes") or (U.Parent == a.bg)) then
            if U:IsA("GuiObject") then
              U.BackgroundColor3 = i(U.BackgroundColor3) or U.BackgroundColor3
              if (U:IsA("TextLabel") or U:IsA("TextButton")) or U:IsA("TextBox") then
                U.TextColor3 = i(U.TextColor3) or U.TextColor3
              end
              if U:IsA("ImageLabel") or U:IsA("ImageButton") then
                U.ImageColor3 = i(U.ImageColor3) or U.ImageColor3
              end
            elseif U:IsA("UIStroke") then
              U.Color = i(U.Color) or U.Color
            elseif U:IsA("UIGradient") then
              M = {}
              for H, L in ipairs(U.Color.Keypoints) do
                M[H] = ColorSequenceKeypoint.new(L.Time, i(L.Value) or L.Value)
              end
              U.Color = ColorSequence.new(M)
            end
          end
        end
      end
    end
    c = s[11]
    c.Theme = G
    if a then
      a:Tint()
    end
    for i, M in next, (a and a.marks) or {}, nil do
      sO(M[1], {Transparency = ((i == G) and 0.3) or 0.86, Color = ((i == G) and q[4]) or B.wh}, 0.2)
      n, c = M[2], {}
      c.ImageTransparency = ((i == G) and 0) or 1
      sO(n, c, 0.2)
    end
    a = s[2]
    a:Persist()
  end
  s[2].Boot = f:QT(22, 23, {[15] = s, [17] = s, [18] = s, [14] = s, [11] = s, [19] = s, [13] = s, [2] = s}, p, y, nil)
  return s[2]
end)()

-- 3. Main --------------------------------------------------------------------
(function()
  local s = Library
  local Shared = {}
  local G = game
  Shared.Game = G
  local function G(c)
    local a = Shared.Game
    return a:GetService(c)
  end
  local c = G("Players")
  local a = G("ReplicatedStorage")
  local i = G("RunService")
  Shared.RunService = i
  local i = G("TeleportService")
  local n = G("HttpService")
  Shared.HttpService = n
  local n = c.LocalPlayer
  Shared.LocalPlayer = n
  local n = a:WaitForChild("Packages"):WaitForChild("Networking")
  local M = Vector3.new
  Shared.Vec3 = M
  local M = CFrame.new
  Shared.CFrameNew = M
  local M = Vector3.zero
  Shared.Vec3Zero = M
  local M = Shared.RunService.Heartbeat
  local H = (getgenv and getgenv()) or _G
  if H.VenyxSAE then
    pcall(H.VenyxSAE)
  end
  local U, L, I = true, {}, {cleanup = {}}
  Shared.Alive = U
  Shared.Core = I
  local function U(I, t)
    local B = I:Connect(t)
    L[#L + 1] = B
    return B
  end
  Shared.WaitHeartbeat = function()
    return M:Wait()
  end
  local function I(t, B)
    local K, P = Instance.new(t), Shared.HttpService
    K.Name = P:GenerateGUID(false):gsub("-", ""):sub(1, 14)
    for t, P in next, B, nil do
      if t ~= "Parent" then
        K[t] = P
      end
    end
    K.Parent = B.Parent
    return K
  end
  local t = {Egg = "Client.EggState", Assets = "Data.Assets", Mut = "Shared.Modules.Mutations", Save = "Shared.Save", Cycle = "Shared.Util.AreaEggCycle", Wall = "Client.AreaEggResetWall", Plot = "Client.PlotState", Rec = "Shared.Util.EggRecords", Fuse = "Shared.Util.FuseKernel", Bases = "Data.Bases", Tread = "Data.Treadmills", Trails = "Data.Trails", Gears = "Data.Gears", Areas = "Data.Areas", Wisp = "Data.WispQuests", Cat = "Shared.Modules.ButterflyCatalog", Fmt = "Packages.FormatNumber.Simple"}
  local B = setmetatable({}, {__index = function(K, P)
    local C = a
    for J in t[P]:gmatch("[^.]+") do
      C = C and (C:FindFirstChild(J))
    end
    local t, J = pcall(require, C)
    if t then
      if J then
        rawset(K, P, J)
        return J
      end
    end
  end})
  Shared.Modules = B
  Shared.Invoke = function(t, ...)
    local B = n:FindFirstChild(t)
    if not (B) then
      return false
    end
    return pcall(B.InvokeServer, B, ...)
  end
  local function t(B, ...)
    local K = n:FindFirstChild(B)
    if K then
      pcall(K.FireServer, K, ...)
    end
  end
  Shared.Fire = function(B, K, ...)
    local P = Shared.Modules
    local C = P[B]
    if C then
      if not (C[K]) then
        return nil
      end
    else
      return nil
    end
    local B, P, J = pcall(C[K], ...)
    if B then
      return P, J
    end
    return nil
  end
  Shared.s8 = function()
    local B = Shared.LocalPlayer
    local K, P = B.Character
    if K then
      B = Shared.LocalPlayer
      P = B.Character:FindFirstChildOfClass("Humanoid")
    else
      P = K
    end
    return P
  end
  Shared.s16 = function()
    local B = Shared.LocalPlayer
    local K, P = B.Character
    if K then
      B = Shared.LocalPlayer
      P = B.Character:FindFirstChild("HumanoidRootPart")
    else
      P = K
    end
    return P
  end
  local function B()
    local K = Shared.s8
    local P = K()
    local C, J = (P ~= nil) and (P.Health > 0)
    if C then
      K = Shared.s16
      J = K() ~= nil
    else
      J = C
    end
    return J
  end
  local function K()
    return workspace:GetServerTimeNow()
  end
  Shared.s27 = function()
    local P, P, P, C = Shared.LocalPlayer, Shared.LocalPlayer, pcall(Shared.LocalPlayer.GetNetworkPing, Shared.LocalPlayer)
    return (P and math.clamp(tonumber(C) or 0.2, 0, 1)) or 0.2
  end
  local P
  Shared.s14 = P
  Shared.s32 = function(P)
    local C = Shared.s16
    local J = C()
    if J then
      if J.Anchored then
        C = Shared.Core
        if (C.hold or 0) == 0 then
          if not (Shared.s14(function()
            local J = Shared.Alive
            return J
          end)) then
            return
          end
        end
      end
    else
      return
    end
    C = Shared.s16
    local J = C()
    if not J then
      return
    end
    pcall(function()
      J.CFrame = P
      local P = Shared.Vec3Zero
      J.AssemblyLinearVelocity = P
      P = Shared.Vec3Zero
      J.AssemblyAngularVelocity = P
    end)
  end
  local function P()
    local C = Shared.s8
    local J = C()
    return math.max((J and J.WalkSpeed) or 16, 16)
  end
  Shared.s22 = function(...)
    local C, J = {...}, workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
    for v, v in ipairs(C) do
      J = J and (J:FindFirstChild(v))
    end
    return J
  end
  local C
  Shared.s31 = function()
    if not (C and C.Parent) then
      local J = Shared.s22
      local v = J("Areas", "SeparationLine")
      C = ((v and v:IsA("BasePart")) and v) or nil
    end
    local J, v = C and C.Position
    if J then
      v = J
    else
      local C = Shared.Vec3
      v = (C(552.2, 67.67, 0))
    end
    return v
  end
  Shared.s37 = function()
    local C = Shared.s22
    local J = C("Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003")
    local v, N = J and (J:IsA("BasePart"))
    if v then
      C = nil
      C, N = Shared.Vec3, J.CFrame:PointToWorldSpace(Shared.Vec3(-26.776, 1.75, 18.665))
    else
      N = v
    end
    C = nil
    if N then
      C = N
    else
      v = Shared.Vec3
      C = (v(528.7, 70.57, -364.11))
    end
    return C
  end
  Shared.s17 = function(C)
    local J, J = Shared.s31, (C.X < Shared.s31().X) and (C.Y < 1000)
    return J
  end
  Shared.s58 = function()
    local C = Shared.Fire
    local J = C("Plot", "ResolvePlot")
    if type(J) == "table" then
      if J.PlotFolder then
        return J
      end
    end
  end
  local function C(J, v)
    pcall(firetouchinterest, J, v, 0)
    pcall(firetouchinterest, J, v, 1)
  end
  Shared.s34 = function()
    local J, J = Shared.LocalPlayer, tonumber(Shared.LocalPlayer:GetAttribute("RagdollEndTime")) or 0
    return J > K()
  end
  local function J()
    local v = workspace:GetAttribute("RaceRallyJoinEndsAt")
    return ((workspace:GetAttribute("RaceRallyRunning") == true) and (type(v) == "number")) and (K() < v)
  end
  local v = {}
  local function N(z)
    local Y = workspace:FindFirstChild("RaceTrack")
    if not (Y) then
      return false
    end
    local l = Y:FindFirstChild("PlayerLineUpArea")
    if l then
      if l:IsA("BasePart") then
        if (z - l.Position).Magnitude <= 500 then
          return true
        end
      end
    end
    if v.t ~= Y then
      local u, j = Shared.Vec3, Shared.Vec3
      local g, O = (u(1000000000, 1000000000, 1000000000)), (j(-1000000000, -1000000000, -1000000000))
      for u, u in ipairs(Y:GetDescendants()) do
        if u:IsA("BasePart") then
          g, O = (g:Min(u.Position)), O:Max(u.Position)
        else
        end
      end
      l, j = Shared.Vec3
      j, v.t, v.lo, v.hi = Shared.Vec3, Y, g - l(500, 1000, 500), O + Shared.Vec3(500, 1000, 500)
    end
    return (((((z.X >= v.lo.X) and (z.X <= v.hi.X)) and (z.Y >= v.lo.Y)) and (z.Y <= v.hi.Y)) and (z.Z >= v.lo.Z)) and (z.Z <= v.hi.Z)
  end
  local function v()
    local z, Y = pcall(function()
      local l = Shared.Modules
      return l.Save.Peek().RaceRally.LastRacedWindow
    end)
    return (z and (Y ~= nil)) and (Y == workspace:GetAttribute("RaceRallyWindow"))
  end
  local function z()
    local Y = Shared.LocalPlayer
    if Y:GetAttribute("RaceId") ~= nil then
      return true
    end
    local l, u = workspace:GetAttribute("RaceRallyJoinEndsAt"), Shared.s16
    Y = u()
    u = nil
    if Y then
      local j = Shared.LocalPlayer
      u = j:GetAttribute("RaceHeat") or (((type(l) == "number") and (K() < (l + 25))) and not v())
    else
      u = Y
    end
    return (u and N(Y.Position)) or false
  end
  Shared.Core.inRace = function()
    local v = Shared.LocalPlayer
    local N, Y = v:GetAttribute("RaceId") ~= nil
    if N then
      Y = N
    else
      v = Shared.LocalPlayer
      Y = v:GetAttribute("RaceRallyQueued") == true
    end
    return Y
  end
  Shared.Core.free = function(v)
    local N, Y = (v.ev ~= nil) and v.ev()
    if N then
      v = Shared.Core
      Y = not v.inRace()
    else
      Y = N
    end
    return Y
  end
  Shared.s68 = function(v, ...)
    local N = Shared.Invoke
    local Y, l = N(v, ...)
    return Y and (l ~= false)
  end
  local function v(N)
    N = math.max(math.floor(N), 0)
    return ((N >= 3600) and ("%dh %02dm"):format(N // 3600, (N % 3600) // 60)) or ("%dm %02ds"):format(N // 60, N % 60)
  end
  local function N(Y)
    local l, l, l = Shared.Fire, Shared.Fire, tonumber(Shared.Fire("Rec", "GrowthSecondsRemaining", Y, K(), Shared.Fire("Rec", "GrowthSpeedMultiplier", Y) or 1)) or 0
    return l
  end
  local Y, l = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Cosmic", "Secret", "Eternal", "Divine"}, {}
  for u = #Y, 1, -1 do
    l[#l + 1] = Y[u]
  end
  local u, j, g = {"Enchanted Forest", "Light Dark", "Titan Temple", "Cherry Blossom", "Cosmic", "Prehistoric", "Abyss Ocean", "Volcano", "Snow", "Jungle", "Desert", "Lake", "Forest"}, {Scrambled = "Scrambled", Golden = "Golden", Rainbow = "Rainbow", Silver = "Silver", Sakura = "Bloom", GreatBloom = "Spirit Bloom", Boss = "Fractured", Enchanted = "Enchanted", Monstrous = "Parasite", Nitro = "Nitro", Spectral = "Spectral"}, {"K", "M", "B", "T", "Qa", "Qi"}
  local function O(h)
    h = tonumber(h) or 0
    local R = 0
    while (h >= 1000) and (R < #g) do
      h, R = h / 1000, R + 1
    end
    local _, r = (R == 0) and tostring(math.floor(h))
    if _ then
      r = _
    else
      local _, V = string.format, ((h < 10) and "%.2f") or ((h < 100) and "%.1f")
      r = _(V or "%.0f", h)
    end
    return r .. (g[R] or "")
  end
  local function g(h)
    local R = Shared.Modules
    local _ = R.Assets
    return (_ and _.Directory) and _.Directory[h]
  end
  local function h(R)
    local _ = g(R)
    R = _ and _.Rarity
    return (R and tonumber(R.RarityNumber or R.Rank)) or 0
  end
  Shared.s67 = function(R)
    local _ = g(R)
    return (_ and _.DisplayName) or tostring(R)
  end
  local function R(_)
    local r, V = {}, {}
    local function k(F)
      if type(F) == "string" then
        if F ~= "" then
          if F ~= "Normal" then
            if F ~= "None" then
              if not (V[F]) then
                V[F] = true
                r[#r + 1] = F
              end
            end
          end
        end
      end
    end
    k(_.BaseMutation)
    if type(_.Mutations) == "table" then
      for F, Q in next, _.Mutations, nil do
        k((((type(F) == "string") and (Q == true)) and F) or Q)
      end
    end
    return r, V
  end
  local function _(r, V, k)
    local F = g(r)
    if not (F) then
      return 0
    end
    V = tonumber(V) or 1
    local Q, D = ((V > 5) and (((V / 5) ^ 1.2) * 19.637875755794113)) or (V ^ 1.85), Shared.Modules
    local V = D.Mut
    D, r = pcall(function()
      return V.EarningsFor(k or {})
    end)
    return ((tonumber(F.EarningRate) or 0) * Q) * ((D and tonumber(r)) or 1)
  end
  local function r(V, k)
    k = (k or V.AssetCategory) or V.Category
    local F, Q = R(V)
    local D = V.AssetScale or V.Scale
    local T, d = {cat = k, r = h(k), v = _(k, D, F), s = tonumber(D) or 1, m = F, ms = Q}, Shared.s67
    T.n = d(k)
    T.a = V.AreaId
    return T
  end
  local V = {Color3.fromRGB(190, 196, 220), Color3.fromRGB(120, 230, 140), Color3.fromRGB(110, 170, 255), Color3.fromRGB(190, 130, 255), Color3.fromRGB(255, 200, 90), Color3.fromRGB(255, 120, 150), Color3.fromRGB(110, 235, 255), Color3.fromRGB(240, 240, 255), Color3.fromRGB(255, 150, 90), Color3.fromRGB(255, 230, 140)}
  local function k(F)
    local Q = g(F)
    local D = (Q and Q.Rarity) and Q.Rarity.Color
    return (((((typeof(D) == "Color3") and select(3, D:ToHSV())) or 0) > 0.55) and D) or V[math.clamp(h(F), 1, 10)]
  end
  local V = {}
  local function F(Q)
    local D = g(Q)
    Q = (D and D.Rarity) and (D.Rarity._id or D.Rarity.DisplayName)
    if not Q then
      return
    end
    if V[Q] == nil then
      D = (a:FindFirstChild("Assets") and a.Assets:FindFirstChild("UI")) and a.Assets.UI:FindFirstChild("RarityGradients")
      local T = D and (D:FindFirstChild(Q))
      V[Q] = (T and ((T:IsA("UIGradient") and T) or T:FindFirstChildWhichIsA("UIGradient", true))) or false
    end
    return V[Q] or nil
  end
  local V = {money = "rbxassetid://119640363267627", candy = "rbxassetid://112785428441728", soul = "rbxassetid://83798853441239", night = "rbxassetid://123238464128459", egg = "rbxassetid://97499770821177", pet = "rbxassetid://112223455192501", scrambled = "rbxassetid://91260564167870", tread = "rbxassetid://137134884810647", essence = "rbxassetid://114750647204247", net = "rbxassetid://131116540264095", Golden = "rbxassetid://98126365702697", Purple = "rbxassetid://121235713836098", Blue = "rbxassetid://89995151383384", Green = "rbxassetid://107744695034799", star = "rbxassetid://79133579432887", timer = "rbxassetid://132534369464516", check = "rbxassetid://104873662023098", arrow = "rbxassetid://94178052551280", trap = "rbxassetid://113747761726323", pin = "rbxassetid://74684257299345", wisp = "rbxassetid://115565045229337", wisp3 = "rbxassetid://135449361680117", potion = "rbxassetid://98847011195862", luck = "rbxassetid://108988481469824", x2 = "rbxassetid://128234882192727", medal = "rbxassetid://116272961700800", trophy = "rbxassetid://119210375463488", fractured = "rbxassetid://74755693699202", scramble = "rbxassetid://134710848063255", nitro = "rbxassetid://134287739122547"}
  Shared.s59 = function()
    local Q = Shared.Modules
    local D = Q.Save
    local Q, T = pcall(function()
      return D.Peek()
    end)
    return ((Q and (type(T) == "table")) and T) or nil
  end
  Shared.s19 = function()
    local Q, D = pcall(function()
      local T = Shared.Modules
      return T.Egg.ReadFieldEggs()
    end)
    return ((Q and (type(D) == "table")) and D.Records) or {}
  end
  local function Q()
    local D = Shared.LocalPlayer
    return D:FindFirstChildOfClass("Backpack")
  end
  local function D()
    local T, d = pcall(function()
      local e, m = Shared.Modules, Shared.LocalPlayer
      return e.Egg.ReadOwnerEggs(m.UserId)
    end)
    return ((T and (type(d) == "table")) and d) or {}
  end
  local function T()
    local d, e = K(), Shared.Fire
    if e("Cycle", "IsNightPhase", d) then
      return 0
    else
      local m = Shared.Fire
      if m("Wall", "IsSealed") then
        return 0
      end
    end
    e = Shared.Fire
    local m = e("Cycle", "NextResetTime", d)
    return (m and ((m - 10) - d)) or 99
  end
  local function d()
    local e = Shared.Fire
    local m = e("Cycle", "NextResetTime", K())
    return (m and math.max(m - K(), 0)) or 0
  end
  local function e(m)
    local x, b, S, w, Z = {}, {}, {}, next, Shared.Modules
    local W, A = Z.Areas
    if W then
      Z = Shared.Modules
      A = Z.Areas.Directory
    else
      A = W
    end
    for X, X in w, A or {}, nil do
      for E, o in ipairs((((type(X) == "table") and (type(X.DropTable) == "table")) and X.DropTable) or {}) do
        E = (type(o) == "table") and (o[1] or o.Category)
        if E then
          Z = tonumber(o[2] or o.Weight)
          if Z then
            if Z > 0 then
              S[E] = true
            end
          else
            S[E] = true
          end
        end
      end
    end
    W, A = next, Shared.Modules
    Z, w = A.Assets
    if Z then
      A = Shared.Modules
      w = A.Assets.Directory
    else
      w = Z
    end
    A = w or {}
    for X, E in W, A, nil do
      Z, w = (type(E) == "table") and E.Rarity
      if Z then
        local W = (m == "all") or (m and m[X])
        if W then
          w = W
        else
          local W = not m
          if m then
            w = W
          else
            local m = E.DontRoll
            w = if m then S[X] else not m
          end
        end
      else
        w = Z
      end
      if w then
        local m = Shared.s67
        if not (b[m(X)]) then
          local m = Shared.s67
          b[m(X)] = true
          local m, b, S = #x + 1, {cat = X}, Shared.s67
          b.v = S(X)
          b.r = h(X)
          b.img = ((type(E.Icon) == "number") and ("rbxassetid://" .. E.Icon)) or E.Icon
          b.sub = E.Rarity.DisplayName
          b.grad = F(X)
          b.col = k(X)
          x[m] = b
        end
      end
    end
    table.sort(x, function(m, b)
      return (m.r > b.r) or ((m.r == b.r) and (m.v < b.v))
    end)
    return x
  end
  Shared.Core.allSp = function()
    return e("all")
  end
  do
    local m
    local function x(b)
      if not (m) then
        m = {}
        local S = Shared.Modules
        local w, Z = S.Assets
        if w then
          S = Shared.Modules
          Z = S.Assets.Directory
        else
          Z = w
        end
        local W = Z or {}
        local function A(X, E, o)
          if E > 5 then
            return
          elseif o[X] then
            return
          end
          o[X] = true
          for fO, pO in pairs(X) do
            if type(fO) == "string" then
              if W[fO] then
                m[fO] = true
              end
            end
            if type(pO) == "string" then
              if W[pO] then
                m[pO] = true
              end
            end
            if type(pO) == "table" then
              A(pO, E + 1, o)
            end
          end
        end
        w = {"ScrambleTradeIn", "ScrambleMastery"}
        for W, W in ipairs(w) do
          Z, S = pcall(function()
            return require(a.Data[W])
          end)
          if Z then
            if type(S) == "table" then
              A(S, 0, {})
            end
          end
        end
      end
      b = tostring(b)
      local S = ((m[b] == true) or (b:sub(1, 6) == "Mecha ")) or (b:find("Experiment", 1, true) ~= nil)
      return S
    end
    Shared.Core.eggSp = function()
      local m = {}
      for b, b in ipairs(e("all")) do
        if not (x(b.cat)) then
          if tostring(b.cat):find("Halloween", 1, true) then
            b.sub = tostring(b.cat) .. (" - " .. tostring(b.sub))
          end
          m[#m + 1] = b
        end
      end
      return m
    end
  end
  local m = {"None"}
  for x, x in next, j, nil do
    m[#m + 1] = x
  end
  table.sort(m, function(x, b)
    return (x == "None") or ((b ~= "None") and (x < b))
  end)
  local function x()
    local b, S = {"None"}, Shared.Fire
    for w, Z in ipairs(S("Mut", "RollTable") or {}) do
      if type(Z) == "table" then
        w = Z[2]
        if w then
          if w > 0 then
            if j[Z[1]] then
              b[#b + 1] = j[Z[1]]
            end
          end
        end
      end
    end
    return ((#b > 1) and b) or {"None", "Golden", "Silver", "Rainbow"}
  end
  local function b(S, w)
    if S then
      if #S == 0 then
        return nil
      end
    else
      return nil
    end
    local Z = {}
    for W, W in ipairs(S) do
      Z[(w and w[W]) or W] = true
    end
    return Z
  end
  local S, w = {}, {None = "None"}
  for Z, W in ipairs(Y) do
    S[W] = Z
  end
  for Z, W in next, j, nil do
    w[W] = Z
  end
  Shared.s63 = function(Z, W)
    if Z.rar then
      if not (Z.rar[W.r]) then
        return false
      end
    end
    if Z.sp then
      local A, X, E = Z.sp, W.n
      if X then
        E = X
      else
        local X = Shared.s67
        E = X(W.cat)
      end
      if not (A[E]) then
        return false
      end
    end
    if Z.no then
      local A, X, E = Z.no, W.n
      if X then
        E = X
      else
        local X = Shared.s67
        E = X(W.cat)
      end
      if A[E] then
        return false
      end
    end
    if W.v < (Z.minV or 0) then
      return false
    elseif Z.maxV then
      if W.v >= Z.maxV then
        return false
      end
    end
    if Z.mut then
      if #W.m == 0 then
        return Z.mut.None == true
      end
      for A, A in ipairs(W.m) do
        if Z.mut[A] then
          return true
        end
      end
      return false
    end
    return true
  end
  local Z
  local Z = s
  local s, W = Z:Window({Title = "Venyx", Version = "v1.1.0", Game = "Steal An Egg", Id = "VenyxSAE", Key = Enum.KeyCode.LeftControl}), {}
  local function A(X, E)
    W[X] = E
  end
  U(M, function()
    if next(W) then
      local X = W
      W = {}
      for W, W in next, X, nil do
        pcall(W)
      end
    end
  end)
  Shared.Core.press = function(W)
    return (W.UserInputType == Enum.UserInputType.MouseButton1) or (W.UserInputType == Enum.UserInputType.Touch)
  end
  Shared.Core.drags = function(W)
    return (W.UserInputType == Enum.UserInputType.MouseMovement) or (W.UserInputType == Enum.UserInputType.Touch)
  end
  Shared.s10 = function(W, X)
    local E = Shared.Core
    E.noteAt = os.clock()
    A("status", function()
      s:Status(W, X)
    end)
    local o, fO = Shared.Core, Shared.Core
    o.warned = fO.warned or {}
    if (X == "warn") or (X == "err") then
      if not (s.open) then
        o, fO = Shared.Core, os.clock() - (Shared.Core.warned[W] or -1000000000)
        if fO > 60 then
          E = Shared.Core
          E.warned[W] = os.clock()
          A("w" .. W, function()
            Z:Notify("Venyx", W, X)
          end)
        end
      end
    end
  end
  local function W(X, E, o)
    A("t" .. X, function()
      Z:Notify(X, E, o)
    end)
  end
  local function X(E, o)
    return function(fO)
      A(E, function()
        o:Set(fO)
      end)
    end
  end
  local function E(o, fO, pO)
    A(o, function()
      for o, yO in next, pO, nil do
        fO:Set(o, yO)
      end
    end)
  end
  local function o()
    local fO = Shared.Core
    if fO.poke then
      local fO = Shared.Core
      fO.poke()
    end
  end
  local function fO(pO, yO, sO)
    local qO = sO or {}
    if yO.rar then
      local sO = {}
      for GO, GO in ipairs(l) do
        if table.find(yO.rar, GO) then
          sO[#sO + 1] = GO
        end
      end
      qO.rar = b(sO, S)
      pO:Dropdown(yO.rarName or "Rarities", l, sO, function(sO)
        qO.rar = b(sO, S)
        o()
      end, true)
    end
    if yO.sp then
      local S, sO = yO.sp, yO.list
      local GO, cO = sO or e, function(sO)
        qO.sp = b(sO)
        o()
      end
      pO:Dropdown(S, GO, {}, cO, true)
    end
    if yO.no then
      local S, sO = yO.no, yO.list
      local GO, cO = sO or e, function(sO)
        qO.no = b(sO)
        o()
      end
      pO:Dropdown(S, GO, {}, cO, true)
    end
    if yO.mut then
      local S, sO = yO.mut, yO.wild
      local GO, cO = (sO and x) or m, function(m)
        qO.mut = b(m, w)
        o()
      end
      pO:Dropdown(S, GO, {}, cO, true)
    end
    if yO.minV then
      local function m(x)
        qO.minV = x
        o()
      end
      pO:Slider(yO.minV, 0, 0, 0, m, "log")
    end
    if yO.maxV then
      local function m(x)
        qO.maxV = ((x > 0) and x) or nil
        o()
      end
      pO:Slider(yO.maxV, 0, 0, 0, m, "log")
    end
    return qO
  end
  local m = {}
  Shared.s21 = m
  local function m(x, S, pO, yO, sO)
    local qO = Shared.s21
    qO[pO] = yO or false
    local function qO(GO)
      local cO = Shared.s21
      cO[pO] = GO
      if sO then
        sO(GO)
      end
      o()
    end
    return x:Toggle(S, yO, qO)
  end
  local function x(S, pO, yO, sO, qO, GO, cO, aO)
    local iO = Shared.s21
    iO[yO] = qO
    local iO
    iO = S:Dropdown(pO, sO, qO, function(S)
      if not (cO) then
        if type(S) == "string" then
          if not (table.find(sO, S)) then
            return task.defer(function()
              iO:Set(qO)
            end)
          end
        end
      end
      local pO = Shared.s21
      pO[yO] = S
      if GO then
        GO(S)
      end
      o()
    end, cO, aO)
    return iO
  end
  local function S(pO, yO, sO, qO, GO, cO, aO, iO, nO)
    local MO = Shared.s21
    MO[sO] = cO
    local function MO(HO)
      local UO = Shared.s21
      UO[sO] = HO
      if nO then
        nO(HO)
      end
    end
    return pO:Slider(yO, qO, GO, cO, MO, aO, iO)
  end
  local function pO(yO)
    task.defer(yO.Collapse, yO, true)
    return yO
  end
  local yO, sO = {}
  Shared.s4 = sO
  local function sO(qO)
    qO.at, qO.tok, qO.i = qO.at or 0, 0, #yO + 1
    yO[qO.i] = qO
    return qO
  end
  Shared.Core.poke = function()
    for qO, qO in ipairs(yO) do
      if qO.info then
        if not (qO.busy) then
          qO.at = 0
        end
      end
    end
  end
  local function qO(GO)
    GO.tok = GO.tok + 1
    GO.at = 0
  end
  local GO = os.clock()
  local cO = os.clock()
  U(Shared.LocalPlayer.CharacterAdded, function()
    GO = os.clock()
    local aO = Shared.Core
    aO.treadBad = nil
  end)
  local aO, iO = {on = false}, {last = "-", placed = 0, hatched = 0}
  Shared.s36 = iO
  Shared.s29 = function(iO)
    local nO, MO = aO.on
    if nO then
      local HO, UO = iO == nil
      if HO then
        local LO = Shared.Core
        UO = not LO.rag
      else
        UO = HO
      end
      MO = UO or (aO.uid == iO)
    else
      MO = nO
    end
    return MO
  end
  task.spawn(function()
    local iO = Shared.Modules
    local nO = iO.Egg
    if nO then
      if nO.CarryChanged then
        U(nO.CarryChanged, function(iO)
          if type(iO) == "table" then
            aO.on = iO.IsCarrying == true
            aO.uid = iO.Uid
          end
        end)
      end
    end
  end)
  Shared.s46 = function(aO, iO, nO)
    local MO = Shared.Core
    if MO.ready then
      local HO = Shared.Core
      HO.ready(iO)
    end
    nO = nO or (P() * 0.92)
    local HO, UO, LO, IO = math.huge, os.clock(), false, 0.016666666666666666
    while iO() do
      MO = Shared.s16
      local tO = MO()
      if not (tO) then
        return false
      end
      if tO.Anchored then
        if not (Shared.s14(iO)) then
          return false
        end
      end
      local iO = aO - tO.Position
      if iO.Magnitude < 3 then
        local MO, BO = Shared.s32, Shared.CFrameNew
        MO(BO(aO) * tO.CFrame.Rotation)
        return true
      end
      if iO.Magnitude < (HO - 3) then
        HO, UO = iO.Magnitude, os.clock()
      else
        local aO, MO = (os.clock() - UO) > 4
        if aO then
          local HO = Shared.Core
          MO = HO.respawn
        else
          MO = aO
        end
        if MO then
          aO = Shared.s10
          aO("Stuck in place, resetting the character")
          local aO = Shared.Core
          aO.respawn(true)
          return false
        elseif (os.clock() - UO) > 1 then
          if LO then
          else
            local aO = Shared.Invoke
            aO("RF/Treadmill/AskDoff")
            local aO, MO, HO = Shared.s32, Shared.CFrameNew, Shared.s37
            aO(MO(HO() + Shared.Vec3(0, 3, 0)))
            LO = true
          end
        else
        end
      end
      local aO, MO = Shared.s32, Shared.CFrameNew
      aO(MO(tO.Position + (iO.Unit * math.min(nO * IO, iO.Magnitude))) * tO.CFrame.Rotation)
      aO = nil
      aO, IO = Shared.WaitHeartbeat, math.clamp(Shared.WaitHeartbeat(), 0.004166666666666667, 0.05)
    end
    return false
  end
  Shared.s14 = function(aO)
    for iO = 1, 4, 1 do
      iO = Shared.s16
      local nO = iO()
      if not nO then
        return false
      end
      if not (nO.Anchored) then
        iO = Shared.Core
        if not (iO.onAdmin) then
          return true
        end
      end
      iO = Shared.Core
      local MO, HO = iO.onAdmin, Shared.Invoke
      local UO, LO, IO = HO("RF/Treadmill/AskDoff")
      iO = Shared.Core
      iO.onAdmin = false
      if MO and not nO.Anchored then
        HO = os.clock() + 0.4
        while (os.clock() < HO) and (aO()) do
          iO = Shared.WaitHeartbeat
          iO()
        end
        return aO()
      end
      if UO then
        if LO == false then
          if not (tostring(IO):lower():find("wait")) then
            pcall(function()
              nO.Anchored = false
            end)
          end
        end
      end
      iO, MO = Shared.s27, (os.clock() + 0.6) + (Shared.s27() * 2)
      while ((nO.Parent and nO.Anchored) and (os.clock() < MO)) and (aO()) do
        LO = Shared.WaitHeartbeat
        LO()
      end
      if not (aO()) then
        return false
      end
    end
    aO = Shared.s16
    local iO = aO()
    return (iO ~= nil) and not iO.Anchored
  end
  Shared.s15 = function(aO, iO)
    local nO = Shared.Core
    if nO.inFuse then
      local MO = Shared.Core
      if MO.inFuse() then
        local MO = Shared.Core
        if not (MO.leaveFuse()) then
          return false
        end
      end
    end
    nO = Shared.LocalPlayer
    local MO = nO:GetAttribute("InEnchantedTree")
    nO = nil
    if MO then
      local HO = Shared.Core
      nO = HO.leaveTree
    else
      nO = MO
    end
    if nO then
      MO = Shared.s10
      MO("Leaving the Enchanted Tree")
      local HO = Shared.Core
      HO.leaveTree()
      HO = os.clock() + 3
      while true do
        local UO, LO = (os.clock() < HO) and aO()
        if UO then
          local HO = Shared.LocalPlayer
          LO = (HO:GetAttribute("InEnchantedTree"))
        else
          LO = UO
        end
        if not LO then
          break
        end
        UO = Shared.WaitHeartbeat
        UO()
      end
    end
    MO = Shared.s16
    local HO, UO = MO(), Shared.s37
    MO = UO()
    if not (HO) then
      return false
    end
    nO, UO = not iO
    if iO then
      UO = nO
    else
      local LO = Shared.s17
      UO = LO(HO.Position)
    end
    if UO and ((HO.Position - MO).Magnitude > 69) then
      nO = Shared.s10
      nO("Moving to the safe zone")
      iO = Shared.Core
      local nO, UO, LO = (iO.cs and Shared.s4) and (Shared.s4.name == "Steal"), Shared.s46, Shared.Vec3
      if not (UO(MO + LO(0, 3, 0), aO, (nO and 400) or 250)) then
        return false
      end
      UO = os.clock()
      LO = nil
      if nO then
        local iO
        iO, LO = Shared.s27, math.clamp(0.3 + Shared.s27(), 0.3, 0.5)
      else
        LO = nO
      end
      nO = UO + (LO or 0.25)
      while (os.clock() < nO) and (aO()) do
        LO = Shared.s16
        HO = LO()
        if HO then
          UO = Shared.Vec3Zero
          HO.AssemblyLinearVelocity = UO
        end
        local aO = Shared.WaitHeartbeat
        aO()
      end
    end
    return true
  end
  local function aO(iO, nO)
    if not (Shared.s14(nO)) then
      return false
    end
    local MO = Shared.s16
    local HO = MO()
    if not (HO) then
      return false
    end
    MO = Shared.s17
    if MO(HO.Position) then
      local MO = Shared.s17
      if not (MO(iO)) then
        local MO = Shared.s15
        if not (MO(nO)) then
          return false
        end
      end
    else
      if HO.Position.Y > 1000 then
        local MO = Shared.s15
        if not (MO(nO)) then
          return false
        end
      else
        local MO = Shared.LocalPlayer
        if MO:GetAttribute("InEnchantedTree") then
          local MO = Shared.s15
          if not (MO(nO)) then
            return false
          end
        end
      end
      local MO = Shared.s16
      HO = MO()
      if HO then
        MO = Shared.s17
        if not (MO(HO.Position)) then
          local MO = Shared.s17
          if MO(iO) then
            local MO = Shared.s37
            local UO, UO = Shared.Vec3, MO() + Shared.Vec3(0, 3, 0)
            if (HO.Position - UO).Magnitude > 1500 then
              if T() > 0 then
                MO = Shared.s29
                if not (MO()) then
                  local LO = Shared.Core
                  if LO.ragTo then
                    local LO = Shared.Core
                    LO.ragTo(UO, nO)
                  end
                end
              end
            end
            MO = Shared.s46
            if not (MO(UO, nO, 400)) then
              return false
            end
          end
        end
      end
    end
    HO = Shared.s46
    return HO(iO, nO)
  end
  local function iO()
    local nO, MO = K(), Shared.Fire
    if MO("Cycle", "IsNightPhase", nO) then
      local HO = Shared.Fire
      local UO, LO = HO("Cycle", "NextResetTime", nO), Shared.Core
      local HO, IO = UO and (UO + 5)
      if HO then
        IO = HO
      else
        UO = Shared.Core
        IO = UO.fieldAt
      end
      LO.fieldAt = IO
    end
    MO = Shared.Fire
    if MO("Wall", "IsSealed") then
      local HO = Shared.Core
      return math.max((HO.fieldAt or nO) - nO, 0.3)
    end
    MO = Shared.Core
    local HO = (MO.fieldAt or 0) - nO
    return ((HO > 0) and HO) or 0
  end
  local function nO()
    local MO = workspace:GetAttribute("AdminBoost_Treadmill")
    if type(MO) == "number" then
      if MO > 1 then
        return true
      end
    end
    MO = Shared.LocalPlayer
    local HO = MO:FindFirstChild("PlayerGui")
    MO = HO and (HO:FindFirstChild("BottomUI"))
    MO = MO and (MO:FindFirstChild("BottomFrame"))
    MO = MO and (MO:FindFirstChild("Holder"))
    MO = MO and (MO:FindFirstChild("List"))
    MO = MO and (MO:FindFirstChild("AdminTreadmill"))
    return ((MO ~= nil) and MO:IsA("GuiObject")) and MO.Visible
  end
  Shared.s18 = function(MO, HO, UO)
    local LO, IO = false
    while MO() do
      local tO = iO()
      if tO <= 0 then
        if LO then
          local iO = os.clock() + (UO or 5)
          while os.clock() < iO do
            if not (MO()) then
              return false
            end
            local iO = Shared.WaitHeartbeat
            iO()
          end
        end
        return true
      end
      LO = true
      local iO = Shared.s16
      local MO = iO()
      if MO then
        IO = IO or MO.Position
        if (MO.Position - IO).Magnitude > 4 then
          local UO, LO = Shared.s32, Shared.CFrameNew
          UO(LO(IO))
        else
          iO = Shared.Vec3Zero
          MO.AssemblyLinearVelocity = iO
        end
      else
      end
      MO = Shared.s10
      MO((HO or "Waiting") .. (" - field opens in " .. (math.ceil(tO) .. "s")))
      iO = Shared.WaitHeartbeat
      iO()
    end
    return false
  end
  local function iO(MO)
    local HO = Shared.s22
    local UO = HO("Areas", "GuardAreas", tostring(MO), "Guard")
    MO = UO and (UO:FindFirstChild("HumanoidRootPart", true))
    return ((MO and MO:IsA("BasePart")) and MO) or nil
  end
  local function MO(HO, UO)
    local LO = Shared.LocalPlayer
    local IO, tO, BO = "FirstAreaEgg_" .. LO.UserId, pairs, Shared.s19
    LO = f[53](BO())
    local KO, PO
    for CO, JO in tO(f:uT(LO)) do
      BO = (type(JO) == "table") and (JO.Uid or CO)
      CO = (((type(BO) == "string") and not UO[BO]) and (typeof(JO.BottomCFrame) == "CFrame")) and (((JO.State == nil) or (JO.State == "Slot")) or (JO.State == "Dropped"))
      if CO then
        local UO = BO:sub(1, #IO) == IO
        local LO = if BO:sub(1, 13) == "FirstAreaEgg_" then UO and BO:match("_([%w ]+:Slot_%d+)$") else if type(JO.AreaId) == "string" then if type(JO.NestId) == "string" then JO.AreaId .. (":" .. JO.NestId) else nil else nil
        local IO = LO and (iO(JO.AreaId) or (UO and iO("Forest")))
        if IO then
          local iO, tO = JO.BottomCFrame.Position, Shared.Vec3
          UO = tO(iO.X - HO.X, 0, iO.Z - HO.Z).Magnitude
          if (UO <= 600) and (if KO then UO < KO else not KO) then
            KO, PO = UO, {uid = BO, slot = LO, guard = IO, at = iO}
          else
          end
        else
        end
      else
      end
    end
    return PO
  end
  local function iO(HO, UO)
    local LO, IO = n:FindFirstChild("RE/GuardPatrol/ForestStrike"), Shared.s16
    local tO = IO()
    if LO then
      if tO then
        IO = Shared.Modules
        if IO.Egg then
          local BO = Shared.s29
          if BO() then
            return false
          else
            local BO = Shared.s34
            if BO() then
              return false
            end
          end
        else
          return false
        end
      else
        return false
      end
    else
      return false
    end
    local BO = ((type(HO) == "function") and HO) or (function()
      return HO
    end)
    while true do
      IO = UO()
      local HO
      if IO then
        local KO
        KO, HO = Shared.Core, (os.clock() - (Shared.Core.dimLeftAt or -99)) < 1
      else
        HO = IO
      end
      if not HO then
        break
      end
      HO = Shared.WaitHeartbeat
      HO()
    end
    if not (Shared.s14(UO)) then
      return false
    end
    local HO, KO = {}, Shared.Core
    KO.rag = true
    IO = nil
    for PO = 1, 3, 1 do
      PO = Shared.s16
      KO = MO((PO() or tO).Position, HO)
      if KO then
        if not (UO()) then
          break
        end
      else
        break
      end
      PO = 0
      while true do
        local MO = Shared.s29
        local CO = MO(KO.uid)
        if not ((if CO then not CO else PO < 2.5) and UO()) then
          break
        end
        MO = Shared.s16
        CO = MO()
        MO = nil
        if CO then
          local JO = CO.Anchored
          if JO then
            MO = JO
          else
            local JO = Shared.Core
            MO = JO.onAdmin
          end
        else
          MO = CO
        end
        if MO then
          if not (Shared.s14(UO)) then
            CO = Shared.Core
            CO.rag = false
            return false
          end
        end
        MO, CO = Shared.s32, Shared.CFrameNew
        MO(CO(KO.at + Shared.Vec3(0, 3, 0)))
        local JO, JO, JO, vO = Shared.Modules, pcall(Shared.Modules.Egg.CarryFieldEgg, KO.uid, KO.slot)
        if JO ~= true then
          if type(vO) == "string" then
            if vO:lower():find("full") then
              CO = Shared.Core
              CO.rag = false
              return false
            end
          end
        end
        if JO ~= true then
          if type(vO) == "string" then
            if PO > 0.4 then
              if not (vO:lower():find("closer")) then
                break
              end
            end
          end
        end
        MO = Shared.WaitHeartbeat
        PO += MO()
      end
      PO = Shared.s29
      if PO(KO.uid) then
        IO = KO
        break
      end
      HO[KO.uid] = true
    end
    if not IO then
      tO = Shared.Core
      tO.rag = false
      return false
    end
    local MO, KO = false, Shared.LocalPlayer
    local PO, CO, JO, vO = KO:GetAttributeChangedSignal("RagdollEndTime"):Connect(function()
      if MO then
        return
      else
        local NO = Shared.s34
        if not (NO()) then
          return
        end
      end
      local NO = BO()
      if NO then
        MO = true
        local zO, YO = Shared.s32, Shared.CFrameNew
        zO(YO(NO))
      end
    end), pcall, LO.FireServer, {EggUid = IO.uid}
    vO.GuardCFrame = IO.guard.CFrame
    CO(JO, LO, vO)
    tO = 0
    while true do
      vO = not MO and (tO < 3)
      if not (vO and UO()) then
        break
      end
      LO = Shared.WaitHeartbeat
      tO += LO()
    end
    PO:Disconnect()
    JO = Shared.s29
    if JO(IO.uid) then
      HO = Shared.Fire
      HO("Egg", "DropFieldEgg", "PlayerRequest")
    end
    KO = Shared.Core
    KO.rag = false
    if MO then
      IO = Shared.Core
      if IO.burst then
        LO = Shared.Core
        LO.burst()
      end
      task.spawn(function()
        local HO = Shared.s8
        local UO, IO, KO = HO(), os.clock() + 1.5, {[Enum.HumanoidStateType.Freefall] = true, [Enum.HumanoidStateType.Physics] = true, [Enum.HumanoidStateType.Ragdoll] = true, [Enum.HumanoidStateType.FallingDown] = true, [Enum.HumanoidStateType.None] = true}
        while (UO and UO.Parent) and (os.clock() < IO) do
          if KO[UO:GetState()] then
            pcall(UO.ChangeState, UO, Enum.HumanoidStateType.GettingUp)
          end
          if UO.PlatformStand then
            if not Shared.s4 then
              UO.PlatformStand = false
            end
          end
          HO = Shared.WaitHeartbeat
          HO()
        end
      end)
    end
    LO, tO = BO(), Shared.s16
    vO = tO()
    JO = ((MO and (LO ~= nil)) and (vO ~= nil)) and ((vO.Position - LO).Magnitude <= 30)
    return JO
  end
  Shared.Core.ragTo = iO
  local function MO(HO, UO, LO, IO, tO)
    local BO = Shared.Core
    if BO.ready then
      local KO = Shared.Core
      KO.ready(UO)
    end
    local KO, PO, CO, JO = os.clock() + (IO or 30), math.huge, os.clock(), 1
    while UO() and (os.clock() < KO) do
      BO = Shared.s16
      IO = BO()
      if not IO then
        return false
      end
      if IO.Anchored then
        if not (Shared.s14(UO)) then
          return false
        end
      end
      local vO = Shared.Vec3
      local NO = vO(HO.X - IO.Position.X, 0, HO.Z - IO.Position.Z)
      if NO.Magnitude <= (LO or 6) then
        vO = Shared.Vec3Zero
        IO.AssemblyLinearVelocity = vO
        return true
      end
      if IO.Anchored then
        Shared.s14(UO)
      end
      if NO.Magnitude < (PO - 5) then
        PO, CO = NO.Magnitude, os.clock()
      else
      end
      vO = NO.Unit
      if (os.clock() - CO) > 2 then
        local HO = Shared.s8
        local LO = HO()
        if LO then
          LO.Jump = true
        end
        HO = Shared.Vec3
        vO = (vO + (HO(-vO.Z, 0, vO.X) * JO)).Unit
        if (os.clock() - CO) > 3.5 then
          CO, JO = (os.clock()), -JO
        else
        end
      else
      end
      local HO
      HO, IO.AssemblyLinearVelocity = Shared.Vec3, (vO * math.min(P() * (tO or 0.95), NO.Magnitude / 0.05)) + Shared.Vec3(0, IO.AssemblyLinearVelocity.Y, 0)
      NO = Shared.WaitHeartbeat
      NO()
    end
    KO = Shared.s16
    UO = KO()
    if UO then
      BO = Shared.Vec3Zero
      UO.AssemblyLinearVelocity = BO
    end
    return false
  end
  local HO = {}
  local function UO(LO, IO, tO)
    if HO[LO] then
      HO[LO]:Disconnect()
      HO[LO] = nil
    end
    if IO then
      HO[LO] = U(IO, tO)
    end
  end
  local HO = s:Home({Game = "Steal An Egg", Key = "Venyx SAE", Discord = "https://discord.gg/Gen7QdXVs6", Community = "Venyx Discord", Hop = function()
    local LO = Shared.Core
    LO.hop("Least players")
  end, Switch = {"Chilli Hub", "flame", function()
    s:Dialog({Title = "Switch to Chilli Hub", Kind = "warn", Text = "Venyx closes completely and Chilli Hub loads. You stay in this server.", Buttons = {{"Cancel"}, {"Switch", function()
      pcall(function()
        i:SetTeleportSetting("__VenyxAutoLoad", false)
      end)
      if H.VenyxSAE then
        pcall(H.VenyxSAE)
      end
      local LO, LO, LO, IO = Shared.Game, Shared.Game, pcall(Shared.Game.HttpGet, Shared.Game, "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua")
      local tO = LO and loadstring(IO)
      if tO then
        tO()
      end
    end, true}}})
  end}, Unload = function()
    s:Dialog({Title = "Unload Venyx", Kind = "warn", Text = "Every feature stops and the menu closes. You stay in this server.", Buttons = {{"Cancel"}, {"Unload", function()
      task.defer(function()
        if H.VenyxSAE then
          H.VenyxSAE()
        end
      end)
    end, true}}})
  end, News = {{"NEW", "v1.1.0: Halloween tasks follow Task order, Walk speed for monsters, pumpkins and ghosts, Use weapons picks every weapon, Lab and Race shop removed", "Venyx", 1792275372}, {"NEW", "Halloween: Dimension eggs, monsters, Ghost Dog quest, fishing, Phantom Express and Cursed Island Wars", "Venyx", 1792260000}, {"NEW", "Admin abuse works like Chilli: admin treadmill, Capture the egg, minigame eggs and Instant steal", "Venyx", 1792250000}, {"FIX", "Fixed lag back with the Tween delivery method", "Venyx", 1792163916}, {"NEW", "Welcome to Venyx 1.0.4! Join our Discord for updates and support", "Venyx", 1792080000}}})
  do
    local LO, IO = 666, "https://raw.githubusercontent.com/tienkhanh1/spicy/main/VenyxSAE.version"
    task.spawn(function()
      while true do
        local tO = Shared.Alive
        if not tO then
          break
        end
        local BO, BO, BO, KO = Shared.Game, Shared.Game, pcall(Shared.Game.HttpGet, Shared.Game, IO .. ("?t=" .. os.time()))
        tO = BO and tonumber(tostring(KO):match("^%s*(%d+)%s*$"))
        if tO and (tO > LO) then
          local LO = {{"UPD", "Update available: re-execute Venyx to get the new version", "Venyx", os.time()}}
          for IO, IO in ipairs(HO.list or {}) do
            LO[#LO + 1] = IO
          end
          A("upd", function()
            HO:News(LO)
          end)
          W("Update available", "Re-execute Venyx to get the new version", "warn")
          return
        end
        task.wait(300)
      end
    end)
  end
  local LO, IO, tO = {}, {}, {{"Steal", "egg", {"Auto Steal", "Egg Predictor"}}, {"Farm", "farm", {"Pen", "Treadmill", "Mutate", "Sell", "Fuse", "Priority"}}, {"Event", "sparkles", {"Halloween", "Star", "Butterfly", "AA"}}, {"Player", "user", {"ESP", "Move", "Combat"}}, {"System", "settings", {"Server", "Webhook", "Optimizer", "Interface", "Config"}}}
  for BO, KO in ipairs(tO) do
    BO = s:Tab(KO[1], KO[2])
    IO[KO[1]] = BO
    for PO, PO in ipairs(KO[3]) do
      LO[PO] = BO:Sub(PO)
    end
  end
  local function BO(KO)
    return s.open and (s.Cur == IO[KO])
  end
  local IO = {links = {}, rig = 0, body = 0, at = 0}
  Shared.s3 = IO
  local IO = {[Enum.HumanoidStateType.Running] = true, [Enum.HumanoidStateType.RunningNoPhysics] = true, [Enum.HumanoidStateType.Landed] = true}
  Shared.s5 = IO
  local IO = {Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Ragdoll, Enum.HumanoidStateType.Physics}
  Shared.s6 = function(KO)
    workspace.CurrentCamera.CameraSubject = KO
    pcall(function()
      local PO
      PO, require(Shared.LocalPlayer.PlayerScripts.PlayerModule):GetControls().humanoid = Shared.LocalPlayer, KO
    end)
    local KO = Shared.LocalPlayer
    local PO, CO = KO.Character
    if PO then
      KO = Shared.LocalPlayer
      CO = KO.Character:FindFirstChild("Animate")
    else
      CO = PO
    end
    if CO then
      task.spawn(function()
        CO.Enabled = false
        task.wait()
        CO.Enabled = true
      end)
    end
  end
  Shared.s7 = function()
    local KO = Shared.s3
    for PO, PO in ipairs(KO.links) do
      PO:Disconnect()
    end
    table.clear(Shared.s3.links)
    local KO, PO = Shared.s3, Shared.s3
    KO.o = nil
    PO.c = nil
  end
  Shared.s2 = function()
    local KO = Shared.s3
    local PO, CO = KO.c ~= nil
    if PO then
      local KO, JO = Shared.s3
      JO, CO = Shared.LocalPlayer, KO.c.Parent == Shared.LocalPlayer.Character
    else
      CO = PO
    end
    return CO
  end
  local function KO()
    local PO = Shared.s3
    local CO, JO = PO.o, Shared.s3
    local vO, NO = JO.c, Shared.LocalPlayer
    PO, JO = NO.Character, Shared.s7
    JO()
    if CO then
      if vO then
        if PO then
          if vO.Parent == PO then
            CO.Parent = PO
            JO = Shared.s6
            JO(CO)
            vO:Destroy()
          end
        end
      end
    end
  end
  local PO = f:QT(1, 2, {[1] = q, [2] = q, [3] = q, [4] = q, [5] = q, [6] = q, [7] = q}, p, y, nil)
  local function CO(JO)
    local vO = ipairs
    for NO, zO in vO(IO) do
      local IO, YO, lO = pcall, JO.SetStateEnabled, Shared.s21
      local uO, jO = lO.god
      if uO then
        jO = uO
      else
        NO = Shared.Core
        jO = NO.godHunt
      end
      IO(YO, JO, zO, not jO)
    end
    vO = Shared.s21
    if vO.god then
      if JO.Health > 0 then
        if JO.Health < JO.MaxHealth then
          JO.Health = JO.MaxHealth
        end
      end
    end
  end
  do
    local IO, JO = false, false
    local function vO(NO)
      IO = false
      if not (NO) then
        return
      end
      local function zO(YO)
        if YO:IsA("Humanoid") then
          YO.Died:Once(function()
            IO = true
          end)
        end
      end
      for YO, YO in ipairs(NO:GetChildren()) do
        zO(YO)
      end
      NO.ChildAdded:Connect(zO)
    end
    vO(Shared.LocalPlayer.Character)
    U(Shared.LocalPlayer.CharacterRemoving, function()
      JO = not IO
    end)
    U(Shared.LocalPlayer.CharacterAdded, function(IO)
      local NO = Shared.s7
      NO()
      vO(IO)
      local IO, vO, NO, zO = Shared.s3, Shared.s3, Shared.s3, JO
      IO.gate, vO.body, NO.at = zO, os.clock(), os.clock() + 1
      JO = false
    end)
    tO = n:FindFirstChild("RE/RigSync/Refresh")
    if tO then
      U(tO.OnClientEvent, function()
        local IO = Shared.s3
        IO.rig = os.clock()
      end)
    end
  end
  local function IO()
    local JO = Shared.Core
    local vO, NO = JO.invisBusy
    if vO then
      NO = vO
    else
      JO = z()
      if JO then
        local zO, YO = Shared.s4
        if zO then
          local lO = Shared.Core
          YO = lO.free(Shared.s4)
        else
          YO = zO
        end
        NO = not YO
      else
        NO = JO
      end
    end
    vO = nil
    if NO then
      vO = NO
    else
      JO = Shared.Core
      local NO = JO.realHum ~= nil
      if NO then
        local JO = Shared.Core
        vO = JO.realHum()
      else
        vO = NO
      end
    end
    return vO
  end
  Shared.Core.ready = function(JO, vO)
    local NO = os.clock() + (vO or 1.5)
    while true do
      vO = Shared.s2
      local zO = vO()
      if not (((if zO then not zO else not IO()) and (os.clock() < NO)) and JO()) then
        break
      end
      PO()
      zO = Shared.s2
      if zO() then
        return true
      end
      zO = Shared.WaitHeartbeat
      zO()
    end
    return true
  end
  local JO = sO({name = "Shield", gap = 0.25})
  JO.on = function()
    return true
  end
  JO.fn = function()
    local JO = Shared.Core
    if JO.agBusy then
      return
    end
    A("swap", function()
      if IO() then
        local IO = Shared.s2
        if IO() then
          KO()
        end
      else
        PO()
      end
      local IO = Shared.s8
      local PO = IO()
      if PO then
        CO(PO)
      end
    end)
  end
  local IO = sO({name = "Steal", mover = true, gap = 0.5, pri = 2, ev = function()
    local PO = Shared.Core
    return PO.mgUid ~= nil
  end})
  IO.on = function()
    local PO = Shared.s21
    local JO, vO = PO.steal
    if JO then
      vO = JO
    else
      PO = Shared.Core
      local JO = PO.wispSteals ~= nil
      if JO then
        local PO = Shared.Core
        vO = PO.wispSteals()
      else
        vO = JO
      end
    end
    return vO
  end
  do
    local PO = 0
    Shared.s38 = PO
    tO = n:FindFirstChild("RE/EggWorld/FieldEggRedeemVerdict")
    if tO then
      U(tO.OnClientEvent, function(PO)
        Shared.s38 = os.clock()
        if IO.cv then
          local JO = Shared.s36
          if IO.cv > (JO.best or 0) then
            local JO, vO = Shared.s36, Shared.s36
            JO.best, vO.bestCat = IO.cv, ((type(PO) == "table") and PO.AssetCategory) or nil
          end
        end
        local JO, vO, NO = Shared.s36, type(PO) == "table"
        if vO then
          local zO = PO.DisplayName
          if zO then
            NO = zO
          else
            local zO = Shared.s67
            NO = zO(PO.AssetCategory)
          end
        else
          NO = vO
        end
        JO.last = NO or "Egg"
        NO = Shared.s36
        NO.lastCat = ((type(PO) == "table") and PO.AssetCategory) or nil
        vO, NO = Shared.Core, Shared.Core
        vO.lastEgg, NO.lastEggAt = "field", os.clock()
        vO = Shared.Core
        if vO.onSteal then
          JO = Shared.Core
          JO.onSteal(PO)
        end
      end)
    end
    Shared.s21.runK = 0.95
    local PO = LO["Auto Steal"]:Section("Auto steal", "zap", 1)
    Shared.Core.stealSec = PO
    Shared.Core.stopSteal = function()
      local JO = Shared.Core
      if JO.curUid then
        local vO, NO = Shared.Core
        NO, vO.skip[Shared.Core.curUid] = Shared.Core, true
      end
      qO(IO)
      JO = Shared.Core
      JO.curUid = nil
    end
    Shared.Core.retarget = function()
      local JO = Shared.Core
      JO.fresh()
      JO = Shared.Core
      if JO.curUid then
        local JO = Shared.s29
        if not (JO()) then
          qO(IO)
          local JO = Shared.Core
          JO.curUid = nil
        end
      end
    end
    Shared.Core.unVis = function()
      local JO = Shared.Core
      if JO.stealVis then
        local JO, vO = Shared.Core, Shared.Core
        JO.stealVis = false
        vO.visibleUntil = 0
      end
    end
    Shared.Core.autoSteal = m(PO, "Auto steal", "steal", false, function(JO)
      if not (JO) then
        qO(IO)
        local vO = Shared.Core
        vO.curUid = nil
        table.clear(Shared.Core.pick)
        vO = Shared.Core
        vO.unVis()
      end
      JO = Shared.Core
      if JO.hud then
        local JO = Shared.Core
        JO.hud.Sync()
        JO = Shared.Core
        JO.hud.Refresh()
      end
    end)
    local JO
    x(PO, "Go to egg", "goMode", {"Tween", "Teleport to egg", "Light Dark zone", "Fast tween to egg"}, "Tween", function()
      JO()
    end)
    x(PO, "Delivery method", "carryMode", {"Tween", "Instant steps"}, "Tween", function()
      JO()
    end)
    Shared.s12 = function()
      local vO = Shared.s21
      return vO.goMode
    end
    local function vO()
      local NO = Shared.s12
      return NO() ~= "Tween"
    end
    Shared.Core.cmode = function()
      local NO, zO = vO() and "Fast tween"
      if NO then
        zO = NO
      else
        local NO = Shared.s21
        zO = NO.carryMode
      end
      return zO
    end
    Shared.Core.tpz = function(NO)
      if NO then
      else
        local zO = Shared.s12
        NO = (zO())
      end
      return (NO == "Teleport to egg") or (NO == "Fast tween to egg")
    end
    local NO = b({"Enchanted Forest", "Light Dark", "Titan Temple"})
    Shared.s13 = NO
    do
      local NO = {"Enchanted Forest", "Light Dark", "Titan Temple", "Cherry Blossom", "Cosmic", "Prehistoric"}
      Shared.s21.tpZones = table.clone(Shared.s13)
      local zO
      local YO = Shared.s21.tpZones
      zO = PO:Dropdown("Teleport zones", NO, {"Enchanted Forest", "Light Dark", "Titan Temple"}, function(lO)
        local uO, jO = ipairs, false
        for gO, OO in uO(lO) do
          if jO then
          else
            gO = Z.busy
            local uO, hO = not gO
            if gO then
              hO = uO
            else
              local uO = Shared.s13
              hO = not uO[OO]
            end
            jO = hO and not YO[OO]
          end
        end
        local uO, gO = YO, Shared.s21
        local OO, hO = b(lO) or {}, b(lO) or {}
        gO.tpZones = OO
        YO = hO
        if jO then
          local function YO()
            local lO = {}
            for jO, jO in ipairs(NO) do
              if uO[jO] then
                lO[#lO + 1] = jO
              end
            end
            zO:Set(lO)
          end
          s:Dialog({Title = "Teleport zones", Kind = "warn", Text = "Teleport to egg is made for the 3 far zones. In Cherry Blossom, Cosmic and Prehistoric it may bug (landing off the egg, eggs sent back to the nest).", Buttons = {{"Cancel", YO}, {"Use anyway", nil, true}}, Cancel = YO})
        end
      end, true)
    end
    PO:Slider("Tween speed", 70, 110, 95, function(NO)
      local zO = Shared.s21
      zO.runK = NO / 100
    end, "%", 5)
    Shared.s21.pullSpd = 3300
    local NO = PO:Slider("Delivery speed", 3000, 4500, 3300, function(zO)
      local YO = Shared.s21
      YO.pullSpd = zO
    end, "", 50, "Change if steal fails")
    Z.Alias[NO.Key:gsub("[^/]+$", "Fast tween speed")] = NO
    S(PO, "Instant steps", "stepsN", 1, 6, 3)
    JO = function()
      local zO, YO = {["Delivery method"] = not vO()}, Shared.Core
      zO["Teleport zones"] = YO.tpz()
      zO["Tween speed"] = not vO()
      zO["Delivery speed"] = vO()
      YO = vO()
      local lO, uO = not YO
      if YO then
        uO = lO
      else
        local YO = Shared.s21
        uO = YO.carryMode == "Instant steps"
      end
      zO["Instant steps"] = uO
      for YO, YO in ipairs(Z.W.All) do
        if zO[YO.title] ~= nil then
          if YO.path:find("Auto Steal / Auto steal$") then
            YO.r.Visible = zO[YO.title]
          end
        end
      end
    end
    task.defer(JO)
    m(PO, "Steal missing index eggs", "index", false)
    NO = m(PO, "Steal from other players", "thief", true)
    Z.Alias[NO.Key:gsub("[^/]+$", "Steal back from players")] = NO
    PO = LO.AA:Section("Admin abuse", "crown")
    Shared.Core.adminSec = PO
    local JO = X("adm", PO:Text("No admin boost right now"))
    NO = m(PO, "Instant steal", "adminSteal", true)
    Z.Alias[NO.Key:gsub("[^/]+$", "Instant steal (Admin Treadmill)")] = NO
    local NO = sO({name = "AdminInfo", gap = 2})
    NO.on = function()
      return BO("Event")
    end
    NO.fn = function()
      local NO, zO, YO, lO = {}, next, workspace:GetAttributes()
      for uO, jO in zO, YO, lO do
        if uO:find("^AdminBoost_") then
          if type(jO) == "number" then
            if jO > 1 then
              NO[#NO + 1] = uO:sub(12) .. (" x" .. jO)
            end
          end
        end
      end
      table.sort(NO)
      JO(((#NO > 0) and ("Live: " .. table.concat(NO, ", "))) or "No admin boost right now")
    end
    Shared.s39 = function()
      local JO = Shared.s21
      return JO.dropSafe == true
    end
    Shared.Core.openBag = function(JO)
      local NO = Shared.LocalPlayer
      local zO = NO.PlayerGui:FindFirstChild("HUD")
      NO = ((zO and zO:FindFirstChild("GameHUD")) and zO.GameHUD:FindFirstChild("RightButtons")) and zO.GameHUD.RightButtons:FindFirstChild(JO)
      if not NO then
        return W("Inventory", "The game's button is not there right now", "warn")
      end
      s:Show(false)
      for JO, JO in ipairs((getconnections and getconnections(NO.Activated)) or {}) do
        pcall(JO.Fire, JO)
      end
    end
    local JO, NO, zO, YO, lO, uO, jO, gO, OO, hO = {}, {"Candy Corn", V.candy}, {"Last egg", V.scrambled}, {"Placed", V.check}, {"Money /s", V.money}, {"Night in", V.night}, {"Session time", V.timer}, {"Best steal", V.trophy}, {}, V.luck
    f:yT(OO, 0, "Egg bag", hO, function()
      local RO = Shared.Core
      RO.openBag("EggsButton")
    end)
    hO, PO = {}, V.pet
    f:yT(hO, 0, "Pet bag", PO, function()
      local PO = Shared.Core
      PO.openBag("PetsButton")
    end)
    f:yT(JO, 0, NO, zO, YO, lO, uO, jO, gO, OO, hO)
    Shared.Core.stats = HO:Stats("Session", JO)
    JO = LO["Auto Steal"]:Section("Filter", "target", 2)
    local function HO(PO)
      local NO = Shared.s21
      NO.zones = nil
      NO = ipairs
      for zO, zO in NO(PO) do
        local PO, NO = Shared.s21, Shared.s21
        PO.zones = NO.zones or {}
        NO = Shared.s21
        NO.zones[zO:gsub("%s", "")] = true
      end
    end
    JO:Dropdown("Zones", u, {}, HO, true)
    x(JO, "Steal first", "order", {"Best value", "Lowest value", "Best rarity", "Best mutation", "Biggest", "Closest"}, "Best value")
    local HO = fO(JO, {mut = "Mutations", wild = true})
    fO(JO, {rar = Y, sp = "Only these eggs", minV = "Min value /s"}, HO)
    Shared.Core.stealFilter = HO
    m(JO, "Sell cheapest egg when bag is full", "bagSell", false, function(PO)
      if PO then
        local PO = Shared.Core
        if PO.bagCheck then
          task.defer(Shared.Core.bagCheck)
        end
      end
    end)
    JO:Slider("Only below /s", 0, 0, 0, function(PO)
      local JO = Shared.s21
      JO.bagMax = ((PO > 0) and PO) or nil
    end, "log")
    local function PO(JO)
      local NO = Shared.s31
      return math.max(NO().Y + 43.35, JO or 0)
    end
    Shared.s24 = function(JO, NO)
      local zO = Shared.Core
      zO.ready(NO)
      local YO, lO, uO, jO = os.clock() + 60, math.huge, os.clock(), false
      while NO() and (os.clock() < YO) do
        zO = Shared.s16
        local YO, gO = zO(), Shared.s8
        local zO = gO()
        if not (YO) then
          return false
        end
        if YO.Anchored then
          if not (Shared.s14(NO)) then
            return false
          end
        end
        gO = Shared.Vec3
        local NO = gO(JO.X - YO.Position.X, 0, JO.Z - YO.Position.Z)
        gO = NO.Magnitude
        if gO < (lO - 5) then
          lO, uO = gO, os.clock()
        else
          if if jO then not jO else (os.clock() - uO) > 0.8 then
            uO = os.clock()
            local lO = Shared.Invoke
            lO("RF/Treadmill/AskDoff")
            jO = true
          else
            if (os.clock() - uO) > 3 then
              local lO = Shared.Core
              if lO.respawn then
                local lO = Shared.s10
                lO("Stuck in place, resetting the character")
                lO = Shared.Core
                lO.respawn(true)
                return false
              end
            end
          end
        end
        if gO <= 2.5 then
          if (YO.Position.Y - JO.Y) < 4 then
            local lO = Shared.Vec3Zero
            YO.AssemblyLinearVelocity = lO
            return true
          end
        end
        local lO = JO.Y
        if math.abs(YO.Position.Y - lO) > 2 then
          local JO, JO, JO = Shared.LocalPlayer, Shared.LocalPlayer, Shared.CFrameNew
          pcall(Shared.LocalPlayer.Character.PivotTo, Shared.LocalPlayer.Character, Shared.CFrameNew(YO.Position.X, lO, YO.Position.Z) * YO.CFrame.Rotation)
        end
        local JO, uO = gO > 0.01
        if JO then
          lO = nil
          lO, uO = Shared.s21, NO.Unit * math.min(P() * Shared.s21.runK, gO / 0.05)
        else
          uO = JO
        end
        JO = nil
        if uO then
          JO = uO
        else
          lO = Shared.Vec3Zero
          JO = lO
        end
        YO.AssemblyLinearVelocity = JO
        if zO then
          JO, uO = (gO > 0.01) and NO.Unit
          if JO then
            uO = JO
          else
            YO = Shared.Vec3Zero
            uO = YO
          end
          zO:Move(uO, false)
        end
        JO = Shared.WaitHeartbeat
        JO()
      end
      return false
    end
    Shared.s45 = function(JO)
      if JO then
        if JO.done then
          return
        end
      else
        return
      end
      JO.done = true
      local NO, NO = Shared.RunService, Shared.RunService
      pcall(Shared.RunService.UnbindFromRenderStep, Shared.RunService, JO.n)
      if JO.c then
        pcall(JO.c.Destroy, JO.c)
      end
      local NO, zO = workspace.CurrentCamera, Shared.s8
      JO = zO()
      if NO then
        NO.CameraType = Enum.CameraType.Custom
        if JO then
          NO.CameraSubject = JO
        end
      end
    end
    Shared.s43 = function(JO, NO)
      local zO, YO = workspace.CurrentCamera, Shared.LocalPlayer
      local lO, uO = YO.Character, Shared.s16
      local jO = uO()
      if zO and lO then
        if not (jO) then
          return
        end
      else
        return
      end
      local gO, OO = {}, Shared.HttpService
      gO.n = OO:GenerateGUID(false)
      gO.t = os.clock() + 15
      pcall(function()
        local OO = lO.Archivable
        lO.Archivable = true
        local hO = lO:Clone()
        lO.Archivable = OO
        for lO, lO in ipairs(hO:GetDescendants()) do
          if lO:IsA("LuaSourceContainer") then
            lO:Destroy()
          elseif lO:IsA("ForceField") then
            lO:Destroy()
          elseif lO:IsA("Tool") then
            lO:Destroy()
          elseif lO:IsA("BasePart") then
            lO.Anchored = true
            lO.CanCollide = false
            lO.CanQuery = false
            lO.CanTouch = false
          end
        end
        OO = hO:FindFirstChildOfClass("Humanoid")
        if OO then
          OO.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        end
        gO.h = OO
        hO.Name = gO.n
        OO = nil
        if JO then
          local lO
          if NO then
            local RO
            RO, lO = Shared.Vec3, CFrame.lookAt(JO, Shared.Vec3(NO.X, JO.Y, NO.Z))
          else
            lO = NO
          end
          if lO then
            OO = lO
          else
            local NO = Shared.CFrameNew
            OO = NO(JO) * jO.CFrame.Rotation
          end
        else
          OO = JO
        end
        hO:PivotTo(OO or jO.CFrame)
        hO.Parent = workspace
        gO.c = hO
      end)
      uO, YO = Shared.RunService, Shared.RunService
      pcall(Shared.RunService.BindToRenderStep, Shared.RunService, gO.n, Enum.RenderPriority.Last.Value + 50, function()
        if os.clock() > gO.t then
          local JO = Shared.s45
          return JO(gO)
        end
        if gO.h then
          if zO.CameraSubject ~= gO.h then
            zO.CameraSubject = gO.h
          end
        end
      end)
      return gO
    end
    local function JO()
      local NO = Shared.s22
      local zO = NO("Build")
      local NO, YO = zO and (zO:FindFirstChild("FuseBiomeLanePortals")), zO and (zO:FindFirstChild("FuseBiomeZone"))
      return NO and (NO:FindFirstChildWhichIsA("BasePart")), YO and (YO:FindFirstChild("ExitPart", true))
    end
    local function NO(zO)
      pcall(function()
        firetouchinterest(Shared.s16(), zO, 0)
        firetouchinterest(Shared.s16(), zO, 1)
      end)
    end
    local function zO()
      local YO = Shared.LocalPlayer
      local lO, uO = YO:GetAttribute("InEnchantedTree") == true
      if lO then
        uO = lO
      else
        YO = Shared.LocalPlayer
        uO = YO:GetAttribute("InBossArena") == true
      end
      YO = nil
      if uO then
        YO = uO
      else
        lO = Shared.Core
        local uO = lO.highOk ~= nil
        if uO then
          local lO = Shared.Core
          YO = lO.highOk()
        else
          YO = uO
        end
      end
      return YO
    end
    Shared.s9 = function()
      local YO = Shared.s16
      local lO = YO()
      YO = nil
      if lO then
        local uO = Shared.s16
        YO = uO().Position.Y > 1000
      else
        YO = lO
      end
      return YO and not zO()
    end
    Shared.s11 = function(YO)
      local lO, lO = JO()
      local uO = Shared.LocalPlayer
      local jO, gO = uO.Character, os.clock() + 12
      while true do
        local OO, hO = lO and Shared.Alive
        if OO then
          uO = Shared.LocalPlayer
          hO = uO.Character == jO
        else
          hO = OO
        end
        local jO, OO = hO and (os.clock() < gO)
        if jO then
          hO = Shared.s9
          OO = (hO())
        else
          OO = jO
        end
        if not OO then
          break
        end
        OO, jO = Shared.s32, Shared.CFrameNew
        OO(jO(lO.Position))
        NO(lO)
        task.wait(YO or 0.1)
      end
      uO = Shared.s9
      return not uO()
    end
    Shared.Core.inFuse = Shared.s9
    Shared.Core.leaveFuse = Shared.s11
    local YO = sO({name = "FuseGuard", gap = 0.3})
    local lO
    YO.on = function()
      return true
    end
    YO.fn = function()
      local YO = Shared.s9
      if YO() and Shared.s4 then
        lO = lO or os.clock()
        local YO, YO = Shared.Core, ((os.clock() - lO) > ((Shared.Core.fuseBusy and 6) or 1)) and not z()
        if YO then
          local YO = Shared.Core
          if not (YO.fuseBusy) then
            qO(Shared.s4)
            local uO = os.clock() + 3
            while true do
              local jO = Shared.s4 and Shared.s4.busy
              if not (jO and (os.clock() < uO)) then
                break
              end
              task.wait()
            end
          end
          YO = Shared.s10
          YO("Leaving the portal zone")
          YO = Shared.s11
          YO()
        end
        return
      end
      lO = nil
    end
    local YO = sO({name = "NightHome", mover = true, soft = true, pri = 40, gap = 1})
    YO.on = function()
      local lO = Shared.s21
      local uO, jO = lO.steal
      if uO then
        jO = uO
      else
        lO = Shared.s21
        jO = lO.bloom
      end
      lO = nil
      if jO then
        lO = jO
      else
        uO = Shared.s21
        lO = uO.star
      end
      uO = nil
      if lO then
        uO = lO
      else
        jO = Shared.s21
        uO = jO.wisp
      end
      return uO and (T() <= 0)
    end
    YO.want = function()
      local lO = Shared.s16
      local uO, jO = lO(), Shared.Fire
      if YO.night == jO("Cycle", "NextResetTime", K()) then
        return
      elseif uO then
        lO = Shared.s29
        if lO() then
          return
        else
          local jO = Shared.s17
          if jO(uO.Position) then
            return
          elseif zO() then
            return
          end
        end
      else
        return
      end
      lO, uO = Shared.s37, Shared.Vec3
      return lO() + uO(0, 3, 0)
    end
    YO.run = function(zO, lO)
      local uO = Shared.Fire
      YO.night = uO("Cycle", "NextResetTime", K())
      uO = Shared.s10
      uO("Night, back to the safe zone")
      aO(zO, lO)
    end
    local function zO(YO, lO)
      local uO = Shared.Core
      uO.ready(lO)
      uO = 0.016666666666666666
      while lO() do
        local lO = Shared.s16
        local jO = lO()
        if not (jO) then
          return false
        end
        lO = jO.Position
        if math.abs(YO.X - lO.X) <= 4 then
          return true
        end
        local jO, jO, gO, OO = Shared.s21, lO.X + (math.sign(YO.X - lO.X) * math.min(Shared.s21.pullSpd * uO, 75, math.abs(YO.X - lO.X))), Shared.s32, Shared.CFrameNew
        gO(OO(jO, PO(YO.Y), lO.Z + ((YO.Z - lO.Z) * 0.1)))
        jO = Shared.WaitHeartbeat
        uO = (jO())
      end
      return false
    end
    Shared.s25 = function(PO, YO)
      local lO = Shared.Core
      lO.ready(YO)
      local uO, jO = JO()
      lO = Shared.s16
      local gO = lO()
      if uO then
        if jO then
          if firetouchinterest then
            if not (gO) then
              return nil
            end
          else
            return nil
          end
        else
          return nil
        end
      else
        return nil
      end
      local function OO(hO)
        local RO = Shared.Vec3
        return RO(PO.X - hO.X, 0, PO.Z - hO.Z).Magnitude
      end
      lO = Shared.s17
      if not (lO(gO.Position)) then
        if OO(gO.Position) < OO(uO.Position) then
          local hO = Shared.s24
          return hO(PO, YO)
        end
      end
      lO = Shared.s37
      local hO, hO, RO = Shared.Vec3, lO() + Shared.Vec3(0, 3, 0), Shared.s17
      if RO(gO.Position) and ((gO.Position - hO).Magnitude > 69) then
        lO = Shared.s10
        lO("Moving to the safe zone")
        OO = Shared.s46
        if not (OO(hO, YO, 400)) then
          return false
        end
        local _O, _O = Shared.s27, os.clock() + math.clamp(0.3 + Shared.s27(), 0.3, 0.5)
        while (os.clock() < _O) and (YO()) do
          local _O, rO = Shared.s32, Shared.CFrameNew
          _O(rO(hO) * Shared.s16().CFrame.Rotation)
          _O = Shared.WaitHeartbeat
          _O()
        end
        if not (YO()) then
          return false
        end
      end
      hO, RO = Shared.s43, Shared.Vec3
      OO, lO = hO(RO(uO.Position.X + 40, 71, -363), PO), Shared.LocalPlayer
      hO, RO = lO.Character, Shared.Core
      RO.fuseBusy = true
      for _O = 1, 3, 1 do
        if YO() then
          RO = Shared.LocalPlayer
          if RO.Character ~= hO then
            break
          end
        else
          break
        end
        lO = Shared.s10
        lO("Touching the lane portal (try " .. (_O .. ")"))
        _O = os.clock() + 5
        while true do
          local rO, VO = (os.clock() < _O) and YO()
          if rO then
            local kO = Shared.LocalPlayer
            VO = kO.Character == hO
          else
            VO = rO
          end
          rO = nil
          if VO then
            local kO = Shared.s9
            rO = not kO()
          else
            rO = VO
          end
          if not rO then
            break
          end
          VO = Shared.s16
          if VO() then
            local rO, kO = Shared.s32, Shared.CFrameNew
            rO(kO(uO.Position))
            NO(uO)
          end
          VO = Shared.WaitHeartbeat
          VO()
        end
        _O = Shared.s9
        if _O() then
          local _O = Shared.s10
          _O("Inside the Fuse Biome, touching its exit")
          _O = Shared.s11
          _O(0.25)
          _O = Shared.s16
          gO = _O()
          if gO then
            if (gO.Position - uO.Position).Magnitude < 200 then
              _O = Shared.Core
              _O.fuseBusy = false
              task.delay(0.2, Shared.s45, OO)
              local gO = Shared.s24
              return gO(PO, YO)
            end
          end
        else
          for PO = 1, 6, 1 do
            PO = Shared.s16
            if PO() then
              NO(jO)
            end
            task.wait(0.1)
          end
          task.wait(0.5)
        end
      end
      uO = Shared.Core
      uO.fuseBusy = false
      RO = Shared.s45
      RO(OO)
      OO = YO()
      uO = nil
      if OO then
        lO = Shared.LocalPlayer
        uO = lO.Character == hO
      else
        uO = OO
      end
      return (uO and nil) or false
    end
    Shared.s26 = function(PO, YO, lO)
      local uO = Shared.Core
      uO.ready(YO)
      local jO, gO = JO()
      if jO and gO then
        if not (firetouchinterest) then
          return nil
        end
      else
        return nil
      end
      if lO then
        if not (zO(PO, YO)) then
          return false
        end
      end
      lO = Shared.s43
      local JO = lO(PO)
      local zO = n:FindFirstChild("RE/FuseBiome/PortalTransition")
      local function OO(hO)
        local RO = Shared.Core
        RO.fuseBusy = true
        RO = Shared.s8
        local _O = RO()
        if hO then
          if _O then
            _O.PlatformStand = true
          end
          local rO, VO = os.clock() + 3
          while YO() and (os.clock() < rO) do
            RO = Shared.s16
            local kO = RO()
            if not (kO) then
              break
            end
            if (kO.Position - hO).Magnitude > 15 then
              local FO, QO = Shared.s32, Shared.CFrameNew
              FO(QO(hO))
              VO = nil
            else
              VO = VO or os.clock()
              if (os.clock() - VO) > 0.15 then
                break
              end
            end
            kO = Shared.WaitHeartbeat
            kO()
          end
          rO = 0
          while (rO < 0.05) and (YO()) do
            local VO = Shared.WaitHeartbeat
            rO += VO()
          end
        end
        local rO = false
        local VO, kO, FO = zO and zO.OnClientEvent:Once(function()
          rO = true
        end), os.clock() + 4, 0
        while true do
          local zO, QO = (os.clock() < kO) and YO()
          if zO then
            RO = Shared.s16
            QO = (RO())
          else
            QO = zO
          end
          zO = nil
          if QO then
            local DO = Shared.s9
            zO = not DO()
          else
            zO = QO
          end
          if not zO then
            break
          end
          if not rO then
            zO, QO = not hO
            if hO then
              local DO = Shared.s16
              QO = (DO().Position - hO).Magnitude > 15
            else
              QO = zO
            end
            if QO then
              local DO, TO = Shared.s32, Shared.CFrameNew
              DO(TO(hO or jO.Position))
            end
            if if hO then os.clock() >= FO else zO then
              FO = os.clock() + 0.1
              NO(jO)
            else
            end
          else
          end
          QO = Shared.WaitHeartbeat
          QO()
        end
        if VO then
          VO:Disconnect()
        end
        if _O then
          pcall(function()
            _O.PlatformStand = false
          end)
        end
        hO = os.clock() + 2
        while true do
          RO = nil
          if rO then
            kO = Shared.s9
            RO = not kO()
          else
            RO = rO
          end
          VO = RO and Shared.Alive
          if not (VO and (os.clock() < hO)) then
            break
          end
          local NO = Shared.WaitHeartbeat
          NO()
        end
        VO = Shared.s11
        VO()
        RO = Shared.s45
        RO(JO)
        kO = Shared.Core
        kO.fuseBusy = false
        RO = Shared.s16
        VO = RO()
        kO, RO = YO() and VO
        if kO then
          hO = Shared.s9
          RO = not hO()
        else
          RO = kO
        end
        return RO and VO
      end
      lO = OO(PO)
      uO = lO and ((lO.Position - PO).Magnitude <= 60)
      if lO then
        if uO then
        else
          local JO, NO, zO = (lO.Position - PO).Magnitude
          if JO <= 600 then
            NO = MO(PO, YO, 6, (JO / P()) + 2, 0.95)
            zO = lO
          else
            gO = Shared.s10
            gO("Landed off the egg, trying again")
            zO = OO(PO)
            NO = zO and ((zO.Position - PO).Magnitude <= 60)
          end
          if zO then
            if NO then
              uO = NO
            else
              JO = Shared.s10
              JO("Landed off the egg, going through the portal")
              local JO = OO(nil)
              if JO then
                local zO = Shared.s24
                uO = (zO(PO, YO))
              else
                uO = JO
              end
            end
          else
            uO = NO
          end
        end
      else
      end
      return uO or false
    end
    local PO = f:QT(3, 4, {[8] = q, [9] = q, [10] = q, [11] = q, [12] = q, [13] = q, [14] = q, [15] = q, [16] = q, [17] = q, [18] = q, [19] = q, [20] = q, [21] = q, [22] = q, [23] = q, [24] = q, [25] = q, [26] = q, [27] = q}, p, y, nil)
    Shared.s35 = function(JO)
      local NO, zO, YO, lO = ipairs, f[53](workspace:GetChildren()), 12
      for uO, jO in NO(f:uT(zO)) do
        local NO, zO = ((jO.Name == "SmartPromptPart") and jO:IsA("BasePart")) and jO:FindFirstChild("CarryAreaEgg")
        if NO then
          uO = Shared.Vec3
          zO = uO(jO.Position.X - JO.X, 0, jO.Position.Z - JO.Z).Magnitude
        else
          zO = NO
        end
        if zO then
          if zO < YO then
            YO, lO = zO, NO
          else
          end
        else
        end
      end
      return lO
    end
    local JO = f:QT(5, 6, {[28] = q, [29] = q, [30] = q, [23] = q, [16] = q, [31] = q, [21] = q, [32] = q, [33] = q, [20] = q, [1] = q, [34] = q, [35] = q, [8] = q}, p, y, nil)
    Shared.Core.stepTo = function(NO, zO)
      local YO = Shared.s16
      local lO = YO()
      if not (lO) then
        return false
      end
      local uO, jO = math.max(P() * 1.515, 40), Shared.Vec3
      YO = jO(lO.Position.X, math.max(lO.Position.Y, NO.Y) + 42, lO.Position.Z)
      while zO() do
        lO = Shared.Vec3
        jO = lO(NO.X - YO.X, 0, NO.Z - YO.Z)
        if jO.Magnitude <= uO then
          break
        end
        YO += jO.Unit * uO
        local jO = 0
        while (jO < 0.1) and (zO()) do
          local gO, OO = Shared.s32, Shared.CFrameNew
          gO(OO(YO))
          gO = Shared.WaitHeartbeat
          jO += gO()
        end
      end
      if not (zO()) then
        return false
      end
      lO, YO, uO = Shared.s32, Shared.CFrameNew, Shared.Vec3
      lO(YO(NO + uO(0, 3, 0)))
      return true
    end
    Shared.s41 = function(NO, zO, YO, lO, uO, jO)
      local gO
      if jO then
        gO = jO
      else
        local OO = Shared.Core
        gO = OO.cmode()
      end
      local OO, hO = gO == "Tween"
      if OO then
        jO = Shared.Core
        local RO = jO.agBusy
        if RO then
          hO = RO
        else
          local RO
          RO, hO = Shared.Core, (os.clock() - (Shared.Core.agAt or -99)) < 3
        end
      else
        hO = OO
      end
      while true do
        jO = Shared.Core
        local RO, _O = jO.agBusy
        if RO then
          OO = Shared.s29
          _O = (OO(NO))
        else
          _O = RO
        end
        if not (_O and (zO())) then
          break
        end
        RO = Shared.WaitHeartbeat
        RO()
      end
      jO = Shared.s16
      local RO, _O = jO(), 0
      if not (RO) then
        return
      end
      OO, jO = Shared.Core, Shared.Core
      local rO, VO = jO.flyY
      if rO then
        VO = rO
      else
        local kO, FO = gO == "Tween"
        if kO then
          jO = Shared.s31
          FO = jO().Y
        else
          FO = kO
        end
        VO = FO or (RO.Position.Y - 3)
      end
      OO.flyY = VO
      VO = Shared.Core
      rO = VO.flyY
      if hO then
        VO, jO = 0, 0
        while true do
          local hO, kO = VO < 10
          if hO then
            OO = Shared.s29
            kO = (OO(NO))
          else
            kO = hO
          end
          if not (kO and (zO())) then
            break
          end
          kO = Shared.s34
          hO = kO()
          kO = nil
          if hO then
            kO = hO
          else
            local FO = Shared.Core
            kO = FO.agBusy
          end
          if kO then
            hO = Shared.WaitHeartbeat
            jO, VO = 0, VO + hO()
          else
            local hO = Shared.WaitHeartbeat
            jO += hO()
            if jO >= 0.3 then
              break
            end
          end
        end
        local hO, kO = rO + 3, 0
        while true do
          local FO, QO = kO < 0.8
          if FO then
            local DO = Shared.s29
            QO = (DO(NO))
          else
            QO = FO
          end
          if not (QO and (zO())) then
            break
          end
          FO = Shared.s16
          RO = FO()
          if not (RO) then
            return
          end
          QO, FO = hO - RO.Position.Y, Shared.Vec3
          RO.AssemblyLinearVelocity = FO(0, ((kO < 0.6) and math.clamp(QO / math.max(0.6 - kO, 0.1), -120, 120)) or math.clamp(QO / 0.2, -30, 30), 0)
          FO = Shared.WaitHeartbeat
          kO = kO + FO()
        end
        _O = os.clock() + 1
      else
      end
      jO = lO
      if gO == "Instant steps" then
        lO = math.clamp(RO.Position.Z, -415, -305)
        local hO, kO, FO, QO, QO, DO = RO.Position.X, RO.Position.Y + 42, math.max(P() * 1.515, 40), Shared.s21, math.max(Shared.s21.stepsN or 3, 1), {}
        for TO = 1, QO - 1, 1 do
          DO[TO] = hO - (((hO - YO.X) * TO) / QO)
        end
        QO = 1
        while true do
          OO = Shared.s29
          if not ((OO(NO) and (zO())) and ((hO - FO) > YO.X)) then
            break
          end
          hO -= FO
          if DO[QO] then
            if hO <= DO[QO] then
              local FO, TO, dO = QO + 1, Shared.s32, Shared.CFrameNew
              TO(dO(hO, YO.Y, lO) * uO)
              VO = 0
              while true do
                TO = Shared.s27
                local eO, mO = VO < (0.19 + TO())
                if eO then
                  dO = Shared.s29
                  mO = (dO(NO))
                else
                  mO = eO
                end
                if not mO then
                  break
                end
                eO = Shared.WaitHeartbeat
                VO += eO()
              end
              dO = Shared.Fire
              dO("Egg", "DropFieldEgg", "PlayerRequest")
              VO = 0
              while true do
                dO = Shared.s29
                if not (dO(NO) and (VO < 1.5)) then
                  break
                end
                TO = Shared.WaitHeartbeat
                VO += TO()
              end
              dO = Shared.s29
              if not (dO(NO)) then
                TO = Shared.Core
                if not (TO.stealChase(NO, zO)) then
                  return
                end
              end
              TO = Shared.s16
              dO = TO()
              hO, VO = if dO then dO.Position.X else hO, 0
              while VO < 0.1 do
                dO = Shared.WaitHeartbeat
                VO += dO()
              end
              QO = FO
            else
            end
          else
          end
          local FO = Shared.CFrameNew
          local TO, dO = FO(hO, kO, lO) * uO, 0
          while true do
            local hO, eO = dO < 0.1
            if hO then
              FO = Shared.s29
              eO = (FO(NO))
            else
              eO = hO
            end
            if not eO then
              break
            end
            eO = Shared.s32
            eO(TO)
            hO = Shared.WaitHeartbeat
            dO += hO()
          end
        end
        kO = Shared.s29
        if kO(NO) then
          DO, QO = Shared.s32, Shared.CFrameNew
          DO(QO(YO) * uO)
        end
        return
      end
      lO = if gO ~= "Fast tween" then math.clamp(RO.Position.Z, -415, -305) else jO
      VO = 0.016666666666666666
      while true do
        OO = Shared.s29
        if not (OO(NO) and (zO())) then
          break
        end
        jO = Shared.s16
        RO = jO()
        if not (RO) then
          return
        end
        local NO = Shared.Core
        if NO.agBusy then
          local NO = Shared.WaitHeartbeat
          NO()
        else
          if gO == "Tween" then
            if (RO.Position.X - YO.X) <= 36 then
              break
            end
            local NO = rO + 3
            if math.abs(RO.Position.Y - NO) > 2 then
              local jO, jO, jO = Shared.LocalPlayer, Shared.LocalPlayer, Shared.CFrameNew
              pcall(Shared.LocalPlayer.Character.PivotTo, Shared.LocalPlayer.Character, Shared.CFrameNew(RO.Position.X, NO, RO.Position.Z) * RO.CFrame.Rotation)
            end
            local NO, jO = Shared.Vec3
            jO, RO.AssemblyLinearVelocity = Shared.s21, ((NO(-1, 0, math.clamp((lO - RO.Position.Z) * 0.03, -0.3, 0.3)).Unit * P()) * Shared.s21.runK) * (((os.clock() < _O) and 0.6) or 1)
            NO = Shared.WaitHeartbeat
            NO()
          else
            local NO = RO.Position
            if (NO.X - YO.X) <= 36 then
              break
            end
            local jO, jO, OO, hO = Shared.s21, NO.X - math.min(Shared.s21.pullSpd * VO, 75, NO.X - YO.X), Shared.s32, Shared.CFrameNew
            OO(hO(jO, rO, NO.Z + ((lO - NO.Z) * 0.03)) * uO)
            jO = Shared.WaitHeartbeat
            VO = (jO())
          end
        end
      end
      if gO == "Tween" then
        if RO then
          zO = Shared.Vec3Zero
          RO.AssemblyLinearVelocity = zO
        end
      end
    end
    Shared.s42 = function(NO, zO)
      local YO = Shared.LocalPlayer
      local lO, uO, jO = YO.Character, os.clock() + 10, 0
      while true do
        YO = zO()
        local zO
        if YO then
          local gO = Shared.LocalPlayer
          zO = gO.Character == lO
        else
          zO = YO
        end
        local YO, lO = zO and (os.clock() < uO)
        if YO then
          zO = Shared.s29
          lO = not zO(NO)
        else
          lO = YO
        end
        if not lO then
          break
        end
        zO, lO = workspace:FindFirstChild(NO), Shared.s16
        YO = lO()
        if zO then
          if zO:IsA("Model") then
            if not YO then
              return false
            end
          else
            return false
          end
        else
          return false
        end
        local gO, OO = zO:GetPivot().Position, Shared.Vec3
        lO = OO(gO.X - YO.Position.X, 0, gO.Z - YO.Position.Z)
        if lO.Magnitude > 600 then
          return false
        end
        if lO.Magnitude > 2 then
          gO = Shared.Core
          if not (gO.agBusy) then
            zO = nil
            zO, YO.AssemblyLinearVelocity = Shared.Vec3, (lO.Unit * math.min(P() * 0.95, lO.Magnitude / 0.05)) + Shared.Vec3(0, YO.AssemblyLinearVelocity.Y, 0)
          end
        end
        if (lO.Magnitude < 12) and (jO < 2) then
          jO += 1
          task.spawn(function()
            local YO = Shared.Fire
            YO("Egg", "CarryFieldEgg", NO)
            jO -= 1
          end)
        else
        end
        zO = Shared.WaitHeartbeat
        zO()
      end
      uO = Shared.s29
      return uO(NO)
    end
    Shared.Core.stealChase = Shared.s42
    local NO
    Shared.s44 = NO
    local NO = f:QT(7, 8, {[10] = q, [36] = q, [32] = q, [33] = q, [37] = q, [20] = q, [24] = q, [29] = q, [27] = q, [38] = q, [23] = q}, p, y, nil)
    Shared.s40 = NO
    local NO = f:QT(9, 10, {[28] = q, [29] = q, [23] = q, [1] = q, [31] = q, [16] = q, [37] = q, [20] = q, [39] = q, [17] = q, [40] = q, [10] = q, [36] = q, [41] = q, [32] = q, [33] = q, [42] = q, [27] = q, [30] = q, [43] = q, [44] = q, [45] = q}, p, y, nil)
    local function zO(YO)
      local lO = Shared.s19
      for uO, uO in pairs(lO()) do
        if type(uO) == "table" then
          if uO.Uid == YO then
            return uO.State == "Slot"
          end
        end
      end
      return false
    end
    Shared.s44 = function(YO, lO, uO, jO, gO, OO)
      if zO(YO) then
        return false, "Egg went back to its nest"
      end
      local zO
      if OO then
        zO = OO
      else
        local hO = Shared.Core
        zO = hO.cmode()
      end
      local hO, RO = ((zO ~= "Instant steps") and 10) or 0
      for _O = 1, hO, 1 do
        _O = Shared.s58
        zO = _O()
        RO = zO and zO.PlotFolder:FindFirstChild("TreadmillBottom")
        if RO then
          break
        end
        _O = Shared.WaitHeartbeat
        _O()
      end
      if RO then
        OO = Shared.s10
        OO("Resetting carry")
        zO, hO = Shared.s32, Shared.CFrameNew
        zO(hO(RO.Position.X, 72, RO.Position.Z))
        local RO, _O = Shared.Core, Shared.Core
        RO.hold = (_O.hold or 0) + 1
        local rO = false
        _O, RO = os.clock(), Shared.Core
        local VO, kO = RO.cs
        if VO then
          RO = nil
          RO, kO = Shared.s27, math.min(2 + (Shared.s27() * 3), 4)
        else
          kO = VO
        end
        RO = nil
        if kO then
          RO = kO
        else
          VO = nil
          VO, RO = Shared.s27, math.min(1 + (Shared.s27() * 2), 2)
        end
        local FO, QO = _O + RO, 0
        RO = 0
        while true do
          _O, VO = (os.clock() < FO) and lO()
          if _O then
            kO = Shared.s16
            local DO = kO()
            local TO
            if DO then
              local dO = Shared.s16
              TO = dO().Anchored
            else
              TO = DO
            end
            VO = not TO
          else
            VO = _O
          end
          if not VO then
            break
          end
          if (QO < 3) and (os.clock() >= RO) then
            QO += 1
            RO = os.clock() + 0.05
            task.spawn(function()
              local DO = Shared.Invoke
              local TO, dO, eO = DO("RF/Treadmill/AskWearStill")
              QO -= 1
              if TO then
                if dO == true then
                  rO = true
                elseif type(eO) == "string" then
                  if eO:lower():find("already") then
                    rO = true
                  end
                end
              end
            end)
          else
          end
          local DO = Shared.WaitHeartbeat
          DO()
        end
        _O = Shared.s16
        kO = _O()
        VO = nil
        if kO then
          _O = Shared.s16
          VO = _O().Anchored
        else
          VO = kO
        end
        FO = os.clock() + 0.3
        while true do
          kO, _O = rO and (os.clock() < FO)
          if kO then
            RO = Shared.s16
            _O = (RO())
          else
            _O = kO
          end
          local DO
          if _O then
            local TO = Shared.s16
            DO = not TO().Anchored
          else
            DO = _O
          end
          if not DO then
            break
          end
          DO = Shared.WaitHeartbeat
          DO()
        end
        RO = nil
        RO, FO = Shared.s27, (os.clock() + 1) + (Shared.s27() * 3)
        while true do
          RO = QO > 0
          if not (RO and (os.clock() < FO)) then
            break
          end
          kO = Shared.WaitHeartbeat
          kO()
        end
        VO = rO or VO
        if not VO then
          if lO() then
            _O = Shared.Core
            _O.treadBad = true
          end
        end
        VO = Shared.Core
        VO.hold = VO.hold - 1
        Shared.s14(lO)
      end
      zO = Shared.s10
      zO("Taking the egg back")
      local RO, _O, rO, VO, kO, FO = os.clock() + 25, os.clock() + 1, 0, 0, 0, jO
      hO = 0
      while true do
        OO = Shared.s29
        zO = OO(YO)
        if not ((if zO then not zO else os.clock() < RO) and lO()) then
          break
        end
        local QO = Shared.LocalPlayer
        if QO.Character ~= uO then
          return false
        end
        QO = workspace:FindFirstChild(YO)
        if QO then
          if QO:IsA("Model") then
            local DO, TO, dO = pcall(QO.GetBoundingBox, QO)
            if DO then
              local DO = Shared.Vec3
              FO = DO(TO.X, TO.Y - (dO.Y / 2), TO.Z)
            else
            end
          else
          end
        else
        end
        QO = Shared.Vec3
        if QO(FO.X - jO.X, 0, FO.Z - jO.Z).Magnitude > 400 then
          return false, "Egg went back to its nest"
        end
        QO = Shared.s16
        local DO = QO()
        if DO and DO.Anchored then
          Shared.s14(lO)
        else
          if (kO > 0) and ((os.clock() - kO) > 0.6) then
            kO = 0
            MO(FO, function()
              local TO = lO()
              local lO
              if TO then
                local dO = Shared.s29
                lO = not dO(YO)
              else
                lO = TO
              end
              return lO
            end, 3, 3, 0.95)
          else
            if DO then
              QO = Shared.s8
              local lO, TO, dO, eO = QO(), Shared.s32, Shared.CFrameNew, Shared.Vec3
              TO(dO(FO + eO(0, ((lO and lO.HipHeight) or 2) + 1, 0)) * gO)
            end
          end
        end
        if os.clock() >= hO then
          hO = os.clock() + 0.15
          local lO, TO = fireproximityprompt
          if lO then
            DO = Shared.s35
            TO = (DO(FO))
          else
            TO = lO
          end
          if TO then
            pcall(function()
              TO.HoldDuration = 0
              fireproximityprompt(TO)
            end)
          end
        else
        end
        if rO < 3 then
          rO += 1
          task.spawn(function()
            local lO = Shared.Fire
            local TO, TO = lO("Egg", "CarryFieldEgg", YO)
            rO -= 1
            TO = ((type(TO) == "string") and TO:lower()) or ""
            if TO:find("gameplay area") then
              if kO == 0 then
                kO = os.clock()
              end
            else
              kO = 0
            end
            if TO:find("trusted") or TO:find("closer") then
              if VO == 0 then
                VO = os.clock()
              end
            else
              VO = 0
            end
          end)
        else
        end
        if VO > 0 then
          if (os.clock() - VO) > 4 then
            return false, "Server pulled you back"
          end
        end
        if os.clock() >= _O then
          _O = os.clock() + 1
          QO, DO = Shared.s19, false
          for lO, lO in pairs(QO()) do
            DO = if type(lO) == "table" then if lO.Uid == YO then lO.State ~= "Slot" else DO else DO
          end
          if not DO then
            return false, "Egg went back to its nest"
          end
        else
        end
        DO = Shared.WaitHeartbeat
        DO()
      end
      hO = Shared.s29
      if not (hO(YO)) then
        return false
      end
      zO = Shared.s10
      zO("Crossing into base")
      for lO = 1, 2, 1 do
        hO, zO, lO, uO = os.clock(), Shared.s32, Shared.CFrameNew, Shared.s37
        zO(lO(uO()) * gO)
        while true do
          RO, lO, OO = Shared.s27, ((os.clock() - hO) < (1.5 + (Shared.s27() * 3))) and (Shared.s38 < hO)
          if lO then
            FO = Shared.s29
            OO = (FO(YO))
          else
            OO = lO
          end
          if not OO then
            break
          end
          local zO = Shared.WaitHeartbeat
          zO()
        end
        if Shared.s38 >= hO then
          return true
        end
        lO = Shared.s29
        if not (lO(YO)) then
          return nil
        end
        lO = Shared.s10
        lO("Not counted yet, crossing again")
        local zO, YO = Shared.s32, Shared.CFrameNew
        zO(YO(jO) * gO)
        YO = 0
        while true do
          lO = Shared.s27
          if not (YO < (0.3 + lO())) then
            break
          end
          zO = Shared.WaitHeartbeat
          YO += zO()
        end
      end
      return false
    end
    local zO, YO, lO, uO, jO, gO, OO = f:QT(11, 12, {[1] = q, [16] = q, [28] = q, [17] = q, [14] = q, [9] = q, [11] = q, [10] = q, [32] = q, [33] = q, [23] = q, [20] = q, [46] = q, [47] = q, [29] = q, [30] = q, [22] = q}, p, y, nil), {}, {}, 0, {}, 0, false
    local function hO()
      if os.clock() < gO then
        local RO = jO
        return RO
      end
      gO, jO = os.clock() + 5, {}
      local gO = Shared.s59
      local RO = gO()
      if not (RO) then
        gO = jO
        return gO
      end
      local _O, rO, VO = ((type(RO.Index) == "table") and RO.Index) or {}, {}, {"Inventory", "EggInventory"}
      for kO, kO in ipairs(VO) do
        for FO, FO in next, ((type(RO[kO]) == "table") and RO[kO]) or {}, nil do
          if type(FO) == "table" then
            rO[(FO.Category or FO.AssetCategory) or ""] = true
          end
        end
      end
      RO = Shared.Modules
      VO, gO = RO.Areas, next
      RO = ((type(VO) == "table") and VO.Directory) or {}
      for kO, FO in gO, RO, nil do
        VO, kO = ipairs, (((type(FO) == "table") and (type(FO.DropTable) == "table")) and FO.DropTable) or {}
        for gO, QO in VO(kO) do
          gO = (type(QO) == "table") and (QO[1] or QO.Category)
          local VO = gO and (g(gO))
          local kO, DO = VO and ((tonumber(QO[2] or QO.Weight) or 1) > 0)
          if kO then
            QO = VO.DontRoll
            DO = if QO then FO.IndexIncludeDontRoll else not QO
          else
            DO = kO
          end
          if DO then
            if _O[gO] ~= true then
              if not (rO[gO]) then
                jO[gO] = true
              end
            end
          end
        end
      end
      RO = jO
      return RO
    end
    Shared.Core.pick = {}
    Shared.Core.skip = {}
    local jO, gO = {["Lowest value"] = "lo", ["Best rarity"] = "r", ["Best mutation"] = "mv", Biggest = "s", Closest = "near"}, {}
    local RO = workspace:FindFirstChild("AreaEggSlotsClient")
    local function _O(rO)
      if (rO.State == "Dropped") or (rO.State == "Carried") then
        local VO = workspace:FindFirstChild(rO.Uid) or (RO and RO:FindFirstChild(rO.Uid))
        local RO, kO = pcall(function()
          return VO:GetPivot().Position
        end)
        if RO then
          if kO then
            return kO
          end
        end
      end
      return rO.BottomCFrame.Position
    end
    local function RO(rO, VO, kO, FO, QO, DO)
      local TO = gO[VO]
      if if TO then TO.r ~= rO else not TO then
        TO = {r = rO, e = r(rO)}
        gO[VO] = TO
      else
      end
      local dO, eO, eO = TO.e, Shared.Core, table.find(Shared.Core.pick, VO)
      local TO, mO = ((eO and "pick") or ((kO and kO[dO.cat]) and "index")) or (FO and (FO(dO)))
      if TO then
        mO = TO
      else
        FO = Shared.s63
        mO = FO(HO, dO) and "filter"
      end
      TO, FO = eO ~= nil
      if TO then
        FO = TO
      else
        kO = Shared.Core
        local HO = kO.skip[VO]
        local xO = if HO then not HO else mO
        if xO then
          HO = Shared.s21
          local bO = HO.zones
          local HO = not bO
          if bO then
            local bO = Shared.s21
            FO = bO.zones[tostring(rO.AreaId):gsub("%s", "")]
          else
            FO = HO
          end
        else
          FO = xO
        end
      end
      dO.tg = FO or false
      dO.kind = (dO.tg and mO) or nil
      kO, TO = (rO.State == "Carried") and tonumber(rO.CarrierUserId)
      if kO then
        FO = Shared.LocalPlayer
        TO = kO ~= FO.UserId
      else
        TO = kO
      end
      dO.held = (TO and c:GetPlayerByUserId(kO)) or nil
      local HO, FO, xO, bO = _O(rO), dO.n, dO.tg
      if xO then
        kO = Shared.Core
        bO = ((100 - (kO.rank["Steal:" .. mO] or 9)) * 1000) - (eO or 0)
      else
        bO = xO
      end
      kO, TO = bO or 0, -dO.v
      dO.Uid = VO
      dO.Pos = HO
      dO.Name = FO
      dO.b = kO
      dO.lo = TO
      if QO == "near" then
        mO = nil
        if DO then
          eO = Shared.Vec3
          mO = -eO(dO.Pos.X - DO.X, 0, dO.Pos.Z - DO.Z).Magnitude
        else
          mO = DO
        end
        dO.near = mO or 0
      end
      if QO == "mv" then
        if not (dO.mv) then
          dO.mv = ((#dO.m > 0) and (dO.v / math.max(_(dO.cat, dO.s, {}), 1))) or 1
        end
      end
      return dO
    end
    local function HO(rO, VO)
      local kO, FO = {}, os.clock()
      if if rO then not rO else T() <= 0 then
        uO = FO
        local QO = OO
        local DO, TO = not QO
        if QO then
          TO = DO
        else
          local dO = Shared.Fire
          TO = dO("Cycle", "IsNightPhase", K())
        end
        if TO then
          OO, lO = true, {}
          QO, DO = pairs, Shared.s19
          local TO = f[53](DO())
          for DO, dO in QO(f:uT(TO)) do
            if type(dO) == "table" then
              if dO.Uid then
                DO = lO
                DO[dO.Uid] = true
              end
            end
          end
        end
        if not (VO) then
          return kO
        end
      end
      if (FO - uO) > 8 then
        OO = false
      end
      local OO = Shared.s21
      local QO, DO = OO.index and hO(), Shared.Core
      local hO, TO = DO.wantEgg, Shared.s21
      local dO = jO[TO.order] or "v"
      OO, DO, TO = (FO - uO) > 8, {}, Shared.s16
      local uO = TO()
      TO = nil
      if uO then
        local eO = Shared.s16
        TO = eO().Position
      else
        TO = uO
      end
      local eO, mO = pairs, Shared.s19
      local xO, bO = f[53](mO()), 0
      for SO, wO in eO(f:uT(xO)) do
        mO = (type(wO) == "table") and wO.Uid
        uO, SO = type(mO) == "string"
        if uO then
          local eO, xO = (wO.State == "Slot") or (wO.State == "Dropped")
          if eO then
            xO = eO
          else
            local ZO = Shared.Core
            xO = ((mO == ZO.mgUid) and (wO.State ~= "Carried")) and (wO.State ~= "Claimed")
          end
          eO = nil
          if xO then
            eO = xO
          else
            local ZO
            if rO then
              local WO = Shared.Core
              ZO = mO == WO.curUid
            else
              ZO = rO
            end
            eO = ZO and (wO.State == "Carried")
          end
          if eO then
            SO = eO
          else
            local eO, ZO = wO.State == "Carried"
            if eO then
              xO = tonumber(wO.CarrierUserId)
              local WO
              if xO then
                WO = xO
              else
                local xO = Shared.LocalPlayer
                WO = xO.UserId
              end
              local xO = Shared.LocalPlayer
              ZO = WO ~= xO.UserId
            else
              ZO = eO
            end
            if ZO then
              eO = nil
              if rO then
                eO = rO
              else
                local xO = Shared.s21
                eO = xO.thief
              end
              if eO then
                SO = eO
              else
                local eO
                eO, SO = Shared.Core, table.find(Shared.Core.pick, mO)
              end
            else
              SO = ZO
            end
          end
        else
          SO = uO
        end
        if SO then
          if mO:find("^FirstAreaEgg") then
          else
            if typeof(wO.BottomCFrame) == "CFrame" then
              DO[mO] = true
              bO = if lO[mO] then bO + 1 else bO
              local eO
              if rO then
                eO = rO
              else
                local xO = (YO[mO] or 0) < FO
                if xO then
                  local SO = OO or not lO[mO]
                  if SO then
                    eO = SO
                  else
                    local lO
                    lO, eO = Shared.Core, table.find(Shared.Core.pick, mO)
                  end
                else
                  eO = xO
                end
              end
              if eO then
                local lO = RO(wO, mO, QO, hO, dO, TO)
                if rO then
                  kO[#kO + 1] = lO
                elseif lO.tg then
                  local RO = Shared.s21
                  if RO.steal then
                    kO[#kO + 1] = lO
                  elseif lO.kind == "wisp" then
                    kO[#kO + 1] = lO
                  elseif lO.kind == "pick" then
                    kO[#kO + 1] = lO
                  end
                end
              end
            else
            end
          end
        else
        end
      end
      if VO then
        hO = Shared.Core
        hO.fieldFresh = bO <= 2
      end
      for lO in next, gO, nil do
        if not (DO[lO]) then
          gO[lO] = nil
        end
      end
      OO = Shared.Core
      FO = #OO.pick
      for lO = FO, 1, -1 do
        mO = Shared.Core
        if not (DO[mO.pick[lO]]) then
          table.remove(Shared.Core.pick, lO)
        end
      end
      uO, hO = next, Shared.Core
      OO = hO.skip
      for lO in uO, OO, nil do
        if not (DO[lO]) then
          mO = Shared.Core
          mO.skip[lO] = nil
        end
      end
      table.sort(kO, function(lO, uO)
        if lO.b ~= uO.b then
          return lO.b > uO.b
        end
        if lO[dO] ~= uO[dO] then
          return lO[dO] > uO[dO]
        end
        return lO.v > uO.v
      end)
      return kO
    end
    Shared.Core.sortKey = function()
      local lO = Shared.s21
      return jO[lO.order] or "v"
    end
    local lO
    local uO = 0
    local function jO()
      if lO then
        if (os.clock() - uO) < 0.3 then
          local gO = lO
          return gO
        end
      end
      local gO, OO, hO = HO(false), os
      hO, lO = OO.clock(), gO
      uO = hO
      gO = lO
      return gO
    end
    Shared.Core.fresh = function()
      lO = nil
    end
    Shared.Core.targets = jO
    Shared.Core.targetsSoon = function()
      return HO(false, true)
    end
    Shared.Core.allEggs = function()
      return HO(true)
    end
    Shared.Core.reach = PO
    local HO = 115
    pcall(function()
      HO = tonumber(require(a.Shared.Types.Eggs).MAX_INVENTORY) or HO
    end)
    Shared.Core.bagMax = HO
    local lO = 0
    local function uO()
      local gO = 0
      for OO in pairs(D()) do
        gO += 1
      end
      local OO = HO
      return gO >= OO
    end
    local function HO(gO)
      if (os.clock() - lO) < 1 then
        return true
      end
      local OO, hO = pairs, f[53](D())
      local RO
      for rO, VO in OO(f:uT(hO)) do
        if type(VO) == "table" then
          if VO.Placement then
          else
            local hO = Shared.Core
            if hO.reserved[rO] then
            else
              local hO = Shared.Core
              local kO, FO = hO.protect
              if kO then
                hO = Shared.Core
                FO = hO.protect(rO, VO)
              else
                FO = kO
              end
              if FO then
              else
                kO = r(VO)
                if #kO.m == 0 then
                  if kO.v < gO then
                    hO = Shared.s21
                    if kO.v < (hO.bagMax or math.huge) then
                      local hO = kO.v
                      gO, RO = hO, rO
                    else
                    end
                  else
                  end
                else
                end
              end
            end
          end
        else
        end
      end
      if not (RO) then
        return false
      end
      t("RE/PetSatchel/SellSelection", {Eggs = {RO}, Assets = {}})
      lO = os.clock()
      OO = Shared.s10
      OO("Sold a cheap egg to make room", "ok")
      return true
    end
    local lO
    Shared.Core.bagCheck = function()
      lO = nil
      local gO = Shared.s21
      if gO.bagSell then
        if uO() then
          HO(math.huge)
        end
      end
    end
    if Shared.Modules.Egg then
      if Shared.Modules.Egg.OwnerRefreshed then
        U(Shared.Modules.Egg.OwnerRefreshed, function(gO)
          local OO = Shared.LocalPlayer
          if gO == OO.UserId then
            local gO = Shared.s21
            if gO.bagSell then
              if not (lO) then
                lO = true
                task.defer(Shared.Core.bagCheck)
              end
            end
          end
        end)
      end
    end
    IO.want = function()
      local lO, gO = T(), Shared.Core
      gO.curUid = nil
      gO = Shared.Core
      local OO, hO = gO.hwBest
      if OO then
        gO = Shared.Core
        hO = gO.hwBest()
      else
        hO = OO
      end
      if ((os.clock() - GO) < 1.5) or (lO <= 0) then
        if lO <= 0 then
          gO = Shared.Core
          gO.unVis()
          jO()
          if not (hO) then
            OO = Shared.s10
            OO("Waiting for daytime")
          end
        end
        return hO
      end
      if (IO.full or 0) > os.clock() then
        OO = Shared.s10
        return OO(IO.fullTx or "Bag full, retrying soon", "warn")
      end
      lO = jO()
      IO.empty = ((#lO == 0) and (IO.empty or os.clock())) or nil
      if #lO == 0 then
        gO = Shared.Core
        gO.unVis()
        if not (hO) then
          OO = Shared.s10
          OO("No egg matches your targets")
        end
        return hO
      end
      local GO, jO, RO = ipairs
      for rO, VO in GO(lO) do
        gO = VO.held
        rO, OO = not gO
        if gO then
          local kO = Shared.Core
          OO = kO.bat()
        else
          OO = rO
        end
        if OO then
          jO = jO or VO
          RO = if IO.again then if VO.Uid == IO.again.uid then if IO.again.n < 3 then if VO.b >= jO.b then VO else RO else RO else RO else RO
        else
        end
      end
      jO = RO or jO
      if not (jO) then
        gO = Shared.s10
        return gO("Matching eggs are in other players' hands")
      end
      if uO() then
        gO = Shared.s21
        if gO.bagSell then
          if HO(jO.v) then
            return
          end
        end
        IO.full = os.clock() + 30
        lO, OO = Shared.s10, Shared.s21
        return lO((OO.bagSell and "Bag is full, no cheaper egg to sell") or "Bag full, place or sell eggs", "warn")
      end
      if hO then
        OO = Shared.Core
        if OO.hwBeats(hO.r, hO.v, jO) then
          GO = Shared.Core
          if not (table.find(GO.pick, jO.Uid)) then
            return hO
          end
        end
      end
      OO = Shared.Core
      local uO, gO, RO, rO, VO = OO.rank["Steal:" .. jO.kind], ipairs, {}, {}, Shared.Core
      f:yT(rO, 0, "Star", VO.starWants, "Shooting Star")
      lO, GO = {}, Shared.Core
      f:yT(lO, 0, "Bloom", GO.bloomWants, "Butterfly")
      f:yT(RO, 0, rO, lO)
      for GO, OO in gO(RO) do
        if uO then
          if OO[2] then
            VO = Shared.Core
            if (VO.rank[OO[1]] or 99) < uO then
              if OO[2]() then
                GO = Shared.s10
                return GO(OO[3] .. " goes first (Task order)")
              end
            end
          end
        end
      end
      if uO then
        hO = Shared.Core
        if uO ~= hO.rank.Steal then
          lO = Shared.Core
          lO.rank.Steal = uO
          rO = Shared.Core
          rO.order()
        end
      end
      uO = Shared.Core
      if uO.stealVis then
        if not (jO.held) then
          gO = Shared.Core
          gO.unVis()
        end
      end
      return jO
    end
    local function GO(lO)
      local uO = Shared.s19
      local jO = uO()
      if type(jO[lO]) == "table" then
        return jO[lO]
      end
      for uO, uO in pairs(jO) do
        if type(uO) == "table" then
          if uO.Uid == lO then
            return uO
          end
        end
      end
    end
    local function lO(uO)
      local jO = GO(uO)
      local gO, OO = (jO and (jO.State == "Carried")) and c:GetPlayerByUserId(tonumber(jO.CarrierUserId) or 0)
      if gO then
        jO = Shared.LocalPlayer
        OO = gO ~= jO
      else
        OO = gO
      end
      jO = (OO and gO.Character) and gO.Character:FindFirstChild("HumanoidRootPart")
      if jO then
        return jO, gO
      end
      jO = workspace:FindFirstChild(uO)
      if not jO then
        return
      end
      gO, uO = ipairs, f[53](jO:GetDescendants())
      for hO, RO in gO(f:uT(uO)) do
        if (RO:IsA("JointInstance") or RO:IsA("WeldConstraint")) or RO:IsA("RigidConstraint") then
          hO, OO = ipairs, {RO.Part0, RO.Part1}
          for gO, RO in hO(OO) do
            local hO, rO = (RO and not RO:IsDescendantOf(jO)) and RO:FindFirstAncestorOfClass("Model")
            if hO then
              gO = Shared.LocalPlayer
              rO = hO ~= gO.Character
            else
              rO = hO
            end
            gO = rO and (c:GetPlayerFromCharacter(hO))
            if gO then
              return hO:FindFirstChild("HumanoidRootPart") or RO, gO
            end
          end
        end
      end
      OO = jO:FindFirstChild("Hitbox", true)
      local gO, hO, RO, rO, VO = (OO and OO.Position) or jO:GetPivot().Position, ipairs, f[53](c:GetPlayers()), 40
      for kO, kO in hO(f:uT(RO)) do
        jO = Shared.LocalPlayer
        OO = ((kO ~= jO) and kO.Character) and kO.Character:FindFirstChild("HumanoidRootPart")
        if OO then
          if (OO.Position - gO).Magnitude < rO then
            uO = (OO.Position - gO).Magnitude
            rO, VO = uO, kO
          else
          end
        else
        end
      end
      if VO then
        return VO.Character.HumanoidRootPart, VO
      end
    end
    local function uO(jO)
      local gO = GO(jO)
      local OO, hO = gO and (gO.State == "Carried")
      if OO then
        jO = nil
        jO, hO = Shared.LocalPlayer, (tonumber(gO.CarrierUserId) or 0) ~= Shared.LocalPlayer.UserId
      else
        hO = OO
      end
      return hO
    end
    local jO = {}
    local function gO(OO, hO, RO)
      local rO, VO = OO.Uid, Shared.LocalPlayer
      local kO, FO = VO.Character, Shared.s8
      local QO, DO = FO(), Shared.s21
      if DO.thief or (OO.kind == "pick") then
        FO = Shared.Core
        if FO.bat() then
          if (jO[rO] or 0) > os.clock() then
            return false, "Taken by someone"
          end
        else
          return false, "Taken by someone"
        end
      else
        return false, "Taken by someone"
      end
      FO = Shared.LocalPlayer
      if FO.Character then
        DO = Shared.LocalPlayer
        if DO.Character:GetAttribute("InvisApplied") then
          VO = Shared.s10
          VO("Turning visible to take " .. (OO.Name .. " back"))
          local TO, dO = Shared.Core, Shared.Core
          TO.stealVis, dO.visibleUntil = true, math.huge
          dO = Shared.Core
          if dO.respawn then
            TO = Shared.Core
            TO.respawn(true)
          end
          return false, "visible"
        end
      end
      if Shared.s14(hO) then
        VO = Shared.s15
        if not (VO(hO)) then
          return false, "Stuck on treadmill"
        end
      else
        return false, "Stuck on treadmill"
      end
      VO, FO = lO(rO), Shared.s16
      DO = FO()
      local TO, dO = VO and DO
      if TO then
        FO = Shared.Core
        dO = FO.cmode() == "Fast tween"
      else
        dO = TO
      end
      if dO and ((VO.Position - DO.Position).Magnitude > 300) then
        FO = Shared.s10
        FO("Ragdoll jump to the carrier")
        iO(function()
          local eO = lO(rO)
          local mO
          if eO then
            local xO
            xO, mO = Shared.Vec3, eO.Position + Shared.Vec3(0, 3, 0)
          else
            mO = eO
          end
          return mO
        end, hO)
      elseif VO and DO then
        local function eO()
          local mO, xO = lO(rO), Shared.s16
          local bO = xO()
          return (mO and bO) and ((mO.Position - bO.Position).Magnitude < 60)
        end
        TO = os.clock() + 30
        while (hO() and not eO()) and (os.clock() < TO) do
          local mO = lO(rO)
          if mO then
            local xO = Shared.s17
            if xO(mO.Position) then
              break
            end
          else
            break
          end
          local xO, bO = mO.Position, Shared.s10
          bO("Flying to the carrier")
          mO, bO = Shared.s24, Shared.Vec3
          mO(xO + bO(0, 3, 0), function()
            local bO = lO(rO)
            return ((hO() and bO) and ((bO.Position - xO).Magnitude < 40)) and not eO()
          end)
          mO = Shared.WaitHeartbeat
          mO()
        end
      end
      TO = Shared.Core
      TO.godHunt = true
      local eO
      FO = Shared.RunService
      local function mO(xO)
        if eO then
          pcall(Shared.Core.huntStep, eO[1], eO[2], xO)
        end
      end
      dO, TO, DO = FO.PreSimulation:Connect(mO), os.clock(), false
      FO, mO = 0, 0
      while true do
        local xO = hO()
        local bO
        if xO then
          local SO = Shared.LocalPlayer
          bO = SO.Character == kO
        else
          bO = xO
        end
        if not (bO and ((os.clock() - TO) < 90)) then
          break
        end
        xO, bO = Shared.s29, DO
        if xO(rO) then
          DO = true
          break
        end
        xO = GO(rO)
        if if xO then xO.State ~= "Carried" else not xO then
          DO = (xO ~= nil) and ((xO.State == "Slot") or (xO.State == "Dropped"))
          break
        end
        local SO, wO = lO(rO)
        local lO, ZO = SO and wO
        if lO then
          xO = Shared.s17
          ZO = not xO(SO.Position)
        else
          ZO = lO
        end
        eO = (ZO and {wO, SO}) or nil
        if not eO and QO then
          QO.PlatformStand = false
        end
        FO = (SO and 0) or FO
        ZO = Shared.s10
        ZO((SO and ((eO and ("Chasing %s for %s"):format(wO.DisplayName, OO.Name)) or "The carrier reached their base")) or "Looking for the egg carrier")
        wO = Shared.WaitHeartbeat
        lO = wO()
        if SO then
        else
          FO += lO
          if FO >= 3 then
            DO, VO = bO, SO
            break
          end
        end
        mO = ((SO and not eO) and (mO + lO)) or 0
        if mO > 1.5 then
          jO[rO] = os.clock() + 60
          DO, VO = bO, SO
          break
        end
        VO = SO
      end
      eO = nil
      dO:Disconnect()
      VO = Shared.Core
      VO.godHunt = false
      if QO then
        QO.PlatformStand = false
      end
      dO, FO = DO and (hO())
      if dO then
        mO = Shared.LocalPlayer
        FO = mO.Character == kO
      else
        FO = dO
      end
      if FO then
        local function lO(FO)
          local eO = Shared.s10
          eO(OO.Name .. " went back to its nest, going for it")
          OO.Pos = FO.BottomCFrame.Position
          FO, eO = PO(OO, hO)
          if FO then
            return JO(rO, hO, OO.Pos)
          end
          return FO, eO
        end
        QO = Shared.s29
        mO, dO = QO(rO), GO(rO)
        if (if mO then not mO else dO) and (dO.State == "Slot") then
          mO = (lO(dO))
        else
          if mO then
          else
            if dO then
              kO = Shared.s10
              kO("The egg fell, taking it")
              local kO, FO, QO, eO = _O(dO), Shared.s32, Shared.CFrameNew, Shared.Vec3
              FO(QO(kO + eO(0, 3, 0)))
              mO = (JO(rO, hO, kO))
            else
            end
          end
          if mO then
            TO = Shared.Fire
            TO("Egg", "DropFieldEgg", "PlayerRequest")
            VO = 0
            while true do
              local kO = Shared.WaitHeartbeat
              VO += kO()
              dO = GO(rO)
              kO = Shared.s27
              if ((VO > (1 + kO())) or not dO) or (dO.State ~= "Carried") then
                break
              end
            end
            if dO then
              if dO.State == "Dropped" then
                local VO
                mO, VO = JO(rO, hO, _O(dO)), GO(rO)
                dO = VO
              else
              end
            else
            end
            local GO = Shared.s29
            mO = if GO(rO) then mO else if dO then if dO.State == "Slot" then lO(dO) else mO else mO
          else
          end
        end
        if mO then
          local GO, lO = NO(rO, hO)
          if not (GO) then
            if hO() then
              if (RO or 0) < 4 then
                if uO(rO) then
                  return gO(OO, hO, (RO or 0) + 1)
                end
              end
            end
          end
          return GO, lO
        end
      end
      jO[rO] = math.max(jO[rO] or 0, os.clock() + 8)
      return false, (DO and "Could not take the fallen egg") or "The carrier got away with the egg"
    end
    IO.run = function(GO, lO)
      if GO.hw then
        local jO = Shared.Core
        return jO.hwSteal(GO, lO)
      end
      local jO = Shared.Core
      jO.flyY = nil
      local OO, hO = Shared.Core, vO()
      jO = nil
      if hO then
        local vO = Shared.s13
        jO = vO[tostring(GO.a)] == true
      else
        jO = hO
      end
      OO.cs = jO
      IO.cv = GO.v
      hO, OO = Shared.Core, Shared.Core
      hO.curUid, OO.stealKind = GO.Uid, GO.kind
      OO = Shared.Core
      if OO.hud then
        jO = Shared.Core
        jO.hud.Refresh()
      end
      jO = Shared.s29
      OO = jO()
      hO = nil
      if OO then
        jO = Shared.s29
        hO = not jO(GO.Uid)
      else
        hO = OO
      end
      if hO then
        OO = Shared.Fire
        OO("Egg", "DropFieldEgg", "PlayerRequest")
        jO = 0
        while true do
          local vO = Shared.s29
          if not (vO() and (jO < 1.5)) then
            break
          end
          vO = Shared.WaitHeartbeat
          jO += vO()
        end
      end
      hO = Shared.s36
      hO.cur = GO.Name
      hO = Shared.Core
      if hO.greenLight then
        OO = Shared.Core
        OO.greenLight(GO.Uid, lO)
      end
      hO = Shared.LocalPlayer
      local vO, RO, _O, rO, VO = hO.Character, lO, false
      OO = Shared.s21
      hO, jO = OO.adminSteal
      if hO then
        jO = hO
      else
        OO = nil
        OO, jO = Shared.Core, GO.Uid == Shared.Core.mgUid
      end
      OO, hO = jO and (nO())
      if OO then
        jO = Shared.s39
        hO = not jO()
      else
        hO = OO
      end
      if hO then
        rO = zO(GO, lO)
        if rO then
          jO = Shared.s10
          jO("Stole " .. GO.Name, "ok")
          return
        end
        OO = Shared.s29
        if OO() then
          local zO = Shared.Fire
          zO("Egg", "DropFieldEgg", "PlayerRequest")
        end
        if lO() then
          local zO = Shared.LocalPlayer
          if zO.Character ~= vO then
            return
          end
        else
          return
        end
      else
        local zO = Shared.s21
        if zO.adminSteal then
          local zO = Shared.s39
          if zO() then
          else
            local function zO()
              local kO = Shared.s29
              if not (kO()) then
                if nO() then
                  _O = true
                  return false
                end
              end
              return RO()
            end
            lO = zO
          end
        else
        end
      end
      if GO.held then
        VO = "Taken by someone"
      else
        for zO = 1, 2, 1 do
          jO, hO = PO(GO, lO)
          if jO then
            rO, VO = jO, hO
            break
          else
            OO = Shared.LocalPlayer
            if OO.Character ~= vO then
              rO, VO = jO, hO
              break
            elseif lO() then
              zO = Shared.s34
              if not (zO()) then
                rO, VO = jO, hO
                break
              end
            else
              rO, VO = jO, hO
              break
            end
          end
          zO = Shared.s10
          zO("Knocked down, trying again")
          zO = os.clock() + 6
          while true do
            local PO = Shared.s34
            if not (PO() and (os.clock() < zO)) then
              break
            end
            PO = Shared.WaitHeartbeat
            PO()
          end
          rO, VO = jO, hO
        end
        if rO then
          local PO = Shared.s19
          for zO, zO in pairs(PO()) do
            if type(zO) == "table" then
              if zO.Uid == GO.Uid then
                if zO.State ~= "Slot" then
                  if zO.State ~= "Dropped" then
                    local PO, zO = false, "Taken by someone"
                    rO, VO = PO, zO
                  else
                  end
                else
                end
              else
              end
            else
            end
          end
        else
        end
      end
      if VO == "Taken by someone" then
        rO, VO = gO(GO, lO)
      else
        if rO then
          hO, jO = JO(GO.Uid, lO, GO.Pos, true)
          if hO then
            rO, VO = NO(GO.Uid, lO)
          else
            rO, VO = hO, jO
          end
          if rO then
          else
            if lO() then
              OO = Shared.s21
              if OO.thief then
                if uO(GO.Uid) then
                  rO, VO = gO(GO, lO)
                else
                end
              else
              end
            else
            end
          end
        else
        end
      end
      hO = nil
      if _O then
        jO = Shared.s29
        hO = not jO()
      else
        hO = _O
      end
      if hO then
        if RO() then
          OO = Shared.LocalPlayer
          if OO.Character == vO then
            jO = Shared.s10
            jO("Admin treadmill is up, switching to Instant steal")
            return IO.run(GO, RO)
          end
        end
      end
      hO = Shared.s29
      if hO() then
        OO = Shared.LocalPlayer
        if OO.Character == vO then
          if not (rO) then
            jO = Shared.s39
            if not (jO()) then
              local PO = Shared.Fire
              PO("Egg", "DropFieldEgg", "PlayerRequest")
            end
          end
        end
      end
      if VO == "visible" then
        return
      end
      OO, jO = ((IO.again and (IO.again.uid == GO.Uid)) and IO.again.n) or 0, VO == "Egg went back to its nest"
      IO.again = (((rO == false) or (VO ~= nil)) and {uid = GO.Uid, n = (jO and 0) or (OO + 1)}) or nil
      local PO, PO = Shared.Core, table.find(Shared.Core.pick, GO.Uid)
      if rO then
        if PO then
          table.remove(Shared.Core.pick, PO)
        end
        local JO, NO = Shared.s10, Shared.s39
        JO((NO() and ("Dropped " .. (GO.Name .. " at the safe zone"))) or ("Stole " .. GO.Name), "ok")
        NO = Shared.s39
        if NO() then
          YO[GO.Uid] = os.clock() + 300
        end
      elseif (VO == nil) and (rO == nil) then
        hO = Shared.s10
        hO("Sent " .. (GO.Name .. " home"), "ok")
      else
        local JO = lO()
        local NO
        if JO then
          local zO = Shared.LocalPlayer
          NO = zO.Character == vO
        else
          NO = JO
        end
        if NO and (B()) then
          if ((((if PO then not PO else not jO) and (((OO + 1) >= 3) or (VO == "Taken by someone"))) or (VO == "Bag is full")) or (VO == "Pet bag is full")) or (VO == "Egg is gone") then
            YO[GO.Uid] = os.clock() + 20
            IO.again = nil
          end
          IO.fullTx = nil
          if VO == "Pet bag is full" then
            IO.full = os.clock() + 30
            IO.fullTx = "Pet bag is full, sell or fuse pets to steal again"
          elseif VO == "Bag is full" then
            JO = Shared.s21
            if JO.bagSell and HO(GO.v) then
              YO[GO.Uid] = nil
            else
              IO.full = os.clock() + 30
            end
          end
          local HO = Shared.s10
          HO((VO or "Steal failed") .. (" - " .. GO.Name), "warn")
          if jO and (os.clock() >= (IO.pingAt or 0)) then
            HO = 0
            for JO = 1, 10, 1 do
              JO = Shared.WaitHeartbeat
              HO += JO()
            end
            local JO, NO, zO = 10 / math.max(HO, 0.001), pcall(function()
              return G("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
            end)
            local HO = NO and zO
            if HO then
              zO = HO
            else
              NO = Shared.s27
              zO = NO() * 1000
            end
            if zO > 300 then
              IO.pingAt = os.clock() + 60
              W("High ping: egg went back to nest", ("Your ping is %d ms. Hop to a server with lower ping."):format(zO), "err")
            elseif JO < 15 then
              IO.pingAt = os.clock() + 60
              W("Low FPS: egg went back to nest", ("You run at %d FPS. Turn on Low graphics or close other apps."):format(JO), "err")
            end
          end
        end
      end
      OO = Shared.Core
      if OO.treadBad then
        PO = Shared.LocalPlayer
        if PO.Character == vO then
          if B() then
            jO = Shared.Core
            jO.treadBad = nil
            hO = Shared.s10
            hO("Treadmill did not take you, resetting", "warn")
            GO = Shared.Core
            GO.respawn(true)
          end
        end
      end
    end
  end
  do
    tO = Shared.Core.stealSec
    m(tO, "Anti guard", "antiGuard", false)
    local GO
    GO = m(tO, "Drop eggs at safe zone", "dropSafe", false, function(HO)
      if HO then
        if Z.busy then
          return
        elseif Z.qb then
          return
        end
      else
        return
      end
      s:Dialog({Title = "Drop eggs at safe zone", Kind = "warn", Cancel = function()
        GO:Set(false)
      end, Text = "Eggs will be dropped in front of the safe zone. They will NOT be stolen into your base.", Buttons = {{"Cancel", function()
        GO:Set(false)
      end}, {"Turn on", nil, true}}})
    end)
    local function GO(HO)
      return ((HO > 0) and (((math.random() * 2) - 1) * HO)) or 0
    end
    local HO = {off = Shared.Vec3Zero, freeze = true, hop = 0.085, hold = 0.395, steps = {}, rel = 1.52, busy = 2.5}
    for PO = 1, 25, 1 do
      HO.steps[PO] = {0.05 * (PO - 1)}
    end
    HO.steps[26] = {1.27, true}
    local PO, JO = {line = true, off = Shared.Vec3(-90, 45, -35), limp = true, hop = 0, hold = 0, steps = {{0.1}, {0.33}, {0.56}, {0.75, true}}, rel = 0.8, busy = 2.5}, {since = 0}
    Shared.s53 = function()
      local vO, NO, zO, YO = ipairs, {}, {}, Shared.Vec3
      f:yT(zO, 0, "GearGiver_Slap", "Podium", YO(-16.415, 21.072, -6.106))
      local YO, lO = {}, Shared.Vec3
      f:yT(YO, 0, "World", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003", lO(-26.776, 1.75, 18.665))
      f:yT(NO, 0, zO, YO)
      for zO, zO in vO(NO) do
        YO = workspace
        for vO = 1, #zO - 1, 1 do
          YO = YO and YO:FindFirstChild(zO[vO])
        end
        if YO then
          if YO:IsA("BasePart") then
            return YO.CFrame:PointToWorldSpace(zO[#zO])
          end
        end
      end
      YO = Shared.Vec3
      return YO(528.7, 70.57, -364.11)
    end
    Shared.s52 = function(vO)
      local NO = Shared.s22
      local zO = NO("Areas", "SeparationLine")
      if zO then
        if not (zO:IsA("BasePart")) then
          return
        end
      else
        return
      end
      local YO, lO = zO.CFrame, Shared.Vec3
      local uO, uO = Shared.Vec3, lO(0, 1, 0):Cross(((zO.Size.X >= zO.Size.Z) and YO.RightVector) or YO.LookVector) * Shared.Vec3(1, 0, 1)
      if uO.Magnitude <= 0.001 then
        return
      end
      uO = uO.Unit
      zO, NO = YO.Position + (((((vO - YO.Position):Dot(uO) >= 0) and -uO) or uO) * 8), Shared.Vec3
      return NO(zO.X, vO.Y + 0.5, zO.Z)
    end
    Shared.s50 = function()
      local vO, NO = JO.area
      if vO then
        NO = vO
      else
        local vO = Shared.LocalPlayer
        NO = (vO:GetAttribute("AreaId"))
      end
      return (((type(NO) == "string") and (NO:gsub("[^%a]", ""):lower() == "lightdark")) and PO) or HO
    end
    Shared.s51 = function(HO)
      if HO.hop <= 0 then
        if HO.hold <= 0 then
          return HO.steps, HO.rel
        end
      end
      local PO, vO, NO = {}, 0, 0
      for zO, YO in ipairs(HO.steps) do
        vO, NO = math.max((vO + math.max(YO[1] - NO, 0)) + GO((YO[2] and HO.hold) or HO.hop), 0), YO[1]
        PO[zO] = {vO, YO[2]}
      end
      return PO, vO + math.max(HO.rel - NO, 0)
    end
    Shared.s57 = function(GO, HO, PO, vO)
      pcall(GO.PivotTo, GO, Shared.CFrameNew(PO))
      if (HO.Position - PO).Magnitude > 3 then
        pcall(function()
          local NO = Shared.CFrameNew
          HO.CFrame = NO(PO)
        end)
      end
      if not (vO) then
        return
      end
      local HO, PO = ipairs, f[53](GO:GetDescendants())
      for GO, GO in HO(f:uT(PO)) do
        if GO:IsA("BasePart") then
          pcall(function()
            local HO, PO = Shared.Vec3Zero, Shared.Vec3Zero
            GO.AssemblyLinearVelocity = HO
            GO.AssemblyAngularVelocity = PO
          end)
        end
      end
    end
    local function GO()
      local HO = Shared.s16
      local PO = HO()
      for HO, HO in ipairs((PO and workspace:GetChildren()) or {}) do
        if HO:IsA("Model") and HO:FindFirstChild("Hitbox") then
          for vO, vO in ipairs(HO:GetDescendants()) do
            if (vO:IsA("JointInstance") or vO:IsA("WeldConstraint")) or vO:IsA("RigidConstraint") then
              if vO.Part0 == PO then
                return HO
              elseif vO.Part1 == PO then
                return HO
              end
            end
          end
        end
      end
    end
    local HO = {"LuaSourceContainer", "Sound", "ForceField", "JointInstance", "Constraint", "WeldConstraint", "BodyMover", "ProximityPrompt", "BillboardGui"}
    local function PO(vO, NO)
      local zO = {}
      for YO, YO in ipairs(vO:GetDescendants()) do
        zO[YO] = YO.Archivable
        YO.Archivable = true
      end
      local YO = vO.Archivable
      vO.Archivable = true
      local lO, uO = pcall(vO.Clone, vO)
      vO.Archivable = YO
      for vO, YO in next, zO, nil do
        pcall(function()
          vO.Archivable = YO
        end)
      end
      if lO then
        if not (uO) then
          return
        end
      else
        return
      end
      for vO, vO in ipairs(uO:GetDescendants()) do
        zO = false
        for YO, YO in ipairs(HO) do
          zO = zO or (vO:IsA(YO))
        end
        if zO then
          pcall(vO.Destroy, vO)
        elseif vO:IsA("BasePart") then
          vO.Anchored = true
          vO.CanCollide = false
          vO.CanQuery = false
          vO.CanTouch = false
        elseif vO:IsA("Humanoid") then
          vO.DisplayDistanceType, vO.HealthDisplayType = Enum.HumanoidDisplayDistanceType.None, Enum.HumanoidHealthDisplayType.AlwaysOff
        end
      end
      uO.Parent = NO
      return uO
    end
    local function HO()
      local vO = JO.dis
      if not vO then
        return
      end
      JO.dis = nil
      local NO, NO = Shared.RunService, Shared.RunService
      pcall(Shared.RunService.UnbindFromRenderStep, Shared.RunService, "VenyxAG")
      vO.beat:Disconnect()
      for NO, NO in ipairs(vO.hidden) do
        pcall(function()
          NO.LocalTransparencyModifier = 0
        end)
      end
      pcall(function()
        vO.cam.CameraType = vO.type
      end)
      for NO, NO in ipairs(vO.copies) do
        pcall(NO.Destroy, NO)
      end
    end
    Shared.s56 = function(vO)
      local NO = workspace.CurrentCamera
      if vO then
        if not NO then
          return
        elseif JO.dis then
          return
        end
      else
        return
      end
      local zO = {cam = NO, type = NO.CameraType, cf = NO.CFrame, copies = {}, hidden = {}}
      JO.dis = zO
      local YO = {vO, GO()}
      for lO, lO in ipairs(YO) do
        for uO, uO in ipairs(lO:GetDescendants()) do
          if uO:IsA("BasePart") then
            zO.hidden[#zO.hidden + 1] = uO
          elseif uO:IsA("Decal") then
            zO.hidden[#zO.hidden + 1] = uO
          elseif uO:IsA("Texture") then
            zO.hidden[#zO.hidden + 1] = uO
          end
        end
      end
      local function lO()
        for uO, uO in ipairs(zO.hidden) do
          pcall(function()
            uO.LocalTransparencyModifier = 1
          end)
        end
        pcall(function()
          NO.CameraType = Enum.CameraType.Scriptable
          NO.CFrame = zO.cf
        end)
      end
      lO()
      local uO, uO = Shared.RunService, Shared.RunService
      pcall(Shared.RunService.BindToRenderStep, Shared.RunService, "VenyxAG", Enum.RenderPriority.Last.Value + 1, lO)
      vO = Shared.RunService
      zO.beat = vO.Heartbeat:Connect(lO)
      for vO, vO in ipairs(YO) do
        zO.copies[#zO.copies + 1] = PO(vO, NO)
      end
    end
    Shared.s48 = function()
      HO()
      local HO = Shared.s8
      local PO = HO()
      if PO and PO.PlatformStand then
        pcall(function()
          PO.PlatformStand = false
        end)
      end
      HO = Shared.Core
      HO.agBusy = false
    end
    local HO, PO, vO, NO = f:QT(13, 14, {[1] = q, [16] = q, [8] = q, [48] = q, [49] = q, [50] = q, [51] = q, [52] = q, [53] = q, [54] = q, [55] = q, [56] = q, [57] = q}, p, y, nil), false, false, false
    local function zO()
      local YO = NO
      NO = PO or vO
      if NO then
        if not (YO) then
          local NO = Shared.s21
          if NO.antiGuard then
            local NO = Shared.Core
            if not (NO.agBusy) then
              local NO = Shared.Core
              if not (NO.rag) then
                local NO, YO = Shared.s4
                if NO then
                  local lO = Shared.s4.name ~= "Steal"
                  if lO then
                    YO = lO
                  else
                    local lO = Shared.Core
                    YO = lO.cmode() ~= "Tween"
                  end
                else
                  YO = NO
                end
                if not (YO) then
                  local NO, YO = Shared.Core, Shared.Core
                  NO.agBusy, JO.since, YO.agAt = true, os.clock(), os.clock()
                  task.spawn(function()
                    if not (pcall(HO, os.clock())) then
                      local HO = Shared.s48
                      HO()
                    end
                  end)
                end
              end
            end
          end
        end
      end
    end
    task.spawn(function()
      local HO = Shared.Modules
      local NO = HO.Egg
      if NO then
        if not (NO.CarryChanged) then
          return
        end
      else
        return
      end
      U(NO.CarryChanged, function(HO)
        PO = ((type(HO) == "table") and (HO.IsCarrying == true)) and (HO.GuardDisabled ~= true)
        JO.area = ((PO and (type(HO.AreaId) == "string")) and HO.AreaId) or nil
        zO()
      end)
    end)
    local HO = 0
    U(Shared.RunService.Heartbeat, function(PO)
      local NO = Shared.Core
      if NO.agBusy then
        local YO, lO, lO, lO = os.clock() - JO.since, Shared.s50, Shared.s50, math.max(Shared.s50().busy, Shared.s50().rel + 1)
        if YO > lO then
          local JO = Shared.s48
          JO()
        end
      end
      HO += PO
      NO = Shared.s21
      if NO.antiGuard then
        if HO < 0.03 then
          return
        end
      else
        return
      end
      HO = 0
      PO = GO() ~= nil
      if PO ~= vO then
        vO = PO
        zO()
      end
    end)
    table.insert(Shared.Core.cleanup, Shared.s48)
  end
  local GO = {Golden = Color3.fromRGB(255, 206, 84), Silver = Color3.fromRGB(205, 216, 236), Rainbow = Color3.fromRGB(255, 120, 220), Scrambled = Color3.fromRGB(186, 120, 255), Boss = Color3.fromRGB(255, 104, 104), Enchanted = Color3.fromRGB(104, 236, 255), Sakura = Color3.fromRGB(255, 166, 214), GreatBloom = Color3.fromRGB(176, 255, 166), Monstrous = Color3.fromRGB(150, 255, 110), Nitro = Color3.fromRGB(255, 150, 64), Spectral = Color3.fromRGB(110, 235, 220)}
  local function HO(PO)
    local JO = {}
    for vO, vO in ipairs(PO.m) do
      JO[#JO + 1] = {n = (j[vO] or vO):upper(), c = GO[vO]}
    end
    return JO
  end
  local function PO(JO)
    local vO = (g(JO) or {}).Icon
    return (((type(vO) == "number") and ("rbxassetid://" .. vO)) or vO) or ""
  end
  local function JO(vO)
    local NO, NO = Shared.Fire, tonumber(Shared.Fire("Rec", "WeightKgForScale", vO.cat, vO.s))
    return {id = vO.Uid or vO.uid, title = vO.n, rarity = (Y[vO.r] or "?"):upper(), grad = F(vO.cat), color = k(vO.cat), image = PO(vO.cat), value = "$" .. (O(vO.v) .. "/s"), size = ("x%.2f"):format(vO.s), weight = NO and (O(NO) .. " kg"), kg = NO or 0, muts = HO(vO)}
  end
  m(LO.Interface:Section("Game HUD", "star"), "Steal panel button on game HUD", "panelBtn", true, function(HO)
    local vO = Shared.Core
    vO.hud.Dock(HO)
  end)
  task.defer(function()
    local HO = Shared.Core
    HO.hud.Dock(Shared.s21.panelBtn)
  end)
  do
    local HO = game:GetService("TweenService")
    local vO = game:GetService("UserInputService")
    local NO = Color3.fromRGB
    local zO, YO, lO, uO = {on = {NO(60, 255, 0), NO(136, 255, 0), NO(11, 72, 0), NO(190, 255, 180)}, off = {NO(214, 17, 17), NO(253, 20, 20), NO(72, 0, 0), NO(255, 103, 103)}, vx = {NO(122, 162, 255), NO(185, 139, 255), NO(34, 18, 90), NO(214, 200, 255)}, gold = {NO(255, 196, 60), NO(255, 150, 40), NO(80, 40, 0), NO(255, 230, 160)}}, {STOP = "off", CANCEL = "gold", STEAL = "on", CHASE = "vx"}, {"Best value", "Best rarity", "Best mutation", "Biggest", "Lowest value", "Closest"}, {["Best value"] = "Value", ["Best rarity"] = "Rarity", ["Best mutation"] = "Mutation", Biggest = "Weight", ["Lowest value"] = "Cheap", Closest = "Distance"}
    local function jO()
      local gO = Z.Keys["Steal / Auto Steal/Filter/Steal first"]
      if gO then
        gO:Set(lO[((table.find(lO, Shared.s21.order) or 0) % #lO) + 1])
      end
    end
    local function lO(gO, OO, hO, RO, _O)
      HO:Create(gO, TweenInfo.new(hO, RO or Enum.EasingStyle.Quad, _O or Enum.EasingDirection.Out), OO):Play()
    end
    local function gO(OO, hO)
      local RO, _O = zO[hO], OO:FindFirstChildOfClass("UIGradient")
      if _O then
        _O.Color = ColorSequence.new(RO[1], RO[2])
      end
      for hO, hO in ipairs(OO:GetChildren()) do
        if hO:IsA("UIStroke") then
          hO.Color = ((hO.Name == "UIStrokeClr") and RO[4]) or RO[3]
        end
      end
    end
    local function OO(hO)
      return hO:FindFirstChild("Label") or hO:FindFirstChild("TextLabel")
    end
    local function hO(RO, _O)
      pcall(function()
        RO.Active = true
        RO.Interactable = true
      end)
      for rO, rO in ipairs(RO:GetDescendants()) do
        if rO:IsA("GuiObject") then
          rO.Active = false
        end
      end
      local rO = RO:FindFirstChildOfClass("UIScale") or I("UIScale", {Parent = RO})
      local function VO()
        lO(rO, {Scale = 1.06}, 0.16)
      end
      RO.MouseEnter:Connect(VO)
      local function VO()
        lO(rO, {Scale = 1}, 0.16)
      end
      RO.MouseLeave:Connect(VO)
      local function VO()
        rO.Scale = 0.92
        lO(rO, {Scale = 1}, 0.25, Enum.EasingStyle.Back)
        _O()
      end
      RO.Activated:Connect(VO)
    end
    local function RO(_O, rO)
      local VO, kO = _O.AbsoluteSize.X, _O.AbsoluteSize.Y
      if VO <= 0 then
        return
      end
      local FO = (kO * 0.44) / VO
      _O.Up.AnchorPoint, _O.Up.Position, _O.Up.Size = Vector2.new(1, 0.5), UDim2.fromScale(0.718, 0.27), UDim2.fromScale(FO, 0.44)
      _O.Down.AnchorPoint, _O.Down.Position, _O.Down.Size = Vector2.new(1, 0.5), UDim2.fromScale(0.718, 0.73), UDim2.fromScale(FO, 0.44)
      kO, VO = (rO and (0.706 - FO)) or 0.718, {"TextLabel", "SizeTag", "MoneyTag"}
      for FO, FO in ipairs(VO) do
        rO = _O[FO]
        rO.Size = UDim2.fromScale(kO - rO.Position.X.Scale, rO.Size.Y.Scale)
      end
    end
    local function _O(rO, VO)
      for kO, FO in ipairs(rO:GetDescendants()) do
        kO = FO:IsA("UIStroke") and FO:GetAttribute("r")
        if kO then
          FO.Thickness = kO * VO
        end
      end
    end
    local function rO(VO)
      local kO, FO = VO:FindFirstChild("Header"), VO:FindFirstChild("Close")
      for QO, DO in ipairs(VO:GetDescendants()) do
        if DO:IsA("UIStroke") then
          local VO, TO = DO.Parent
          if DO.Name == "UIStrokeClr" then
            TO = 0.00406
          else
            if DO.Name == "InnerUIStroke" then
              TO = 0.00406
            else
              if VO:IsA("TextLabel") then
                TO = (((VO.Parent == kO) and 0.00507) or (((VO.Parent == FO) or VO.Parent:IsA("GuiButton")) and 0.00609)) or 0.00406
              else
                if VO == FO then
                  TO = 0.00609
                else
                  if VO:IsA("GuiButton") then
                    TO = ((VO.Parent == kO) and 0.00812) or 0.00913
                  else
                    QO = true
                    for kO, kO in ipairs(VO:GetChildren()) do
                      QO = if kO ~= DO then if kO:IsA("UIStroke") then if kO.Name == DO.Name then if kO.Thickness > DO.Thickness then false else QO else QO else QO else QO
                    end
                    TO = (QO and (((VO.Name == "Spacer") and 0.00913) or 0.00812)) or 0.00406
                  end
                end
              end
            end
          end
          DO.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize
          DO:SetAttribute("r", TO)
        end
      end
    end
    local VO, kO, FO = {open = false}, {"ActivePets", "GrowingEggs"}
    Shared.Core.hud = VO
    local QO, DO, TO, dO, eO, mO
    local xO, bO, SO, wO, ZO = 0, {}, {}, {}, "<font transparency=\"1\">"
    local function WO(AO)
      local XO, EO, oO, f7, p7 = AO:Clone(), AO.Color.Keypoints, {}, math.abs((AO.Rotation % 180) - 90) < 1, Color3.new(1, 1, 1)
      AO = (f7 and 0.5) or 1
      for f7, f7 in ipairs(EO) do
        oO[#oO + 1] = ColorSequenceKeypoint.new(f7.Time * AO, f7.Value:Lerp(p7, 0.27))
      end
      if AO < 1 then
        oO[#oO + 1] = ColorSequenceKeypoint.new(1, EO[#EO].Value:Lerp(p7, 0.27))
      end
      XO.Color = ColorSequence.new(oO)
      return XO
    end
    local function AO(XO, EO, ...)
      local oO = {...}
      for f7, p7 in ipairs((((#oO > 0) and getconnections) and getconnections(XO)) or {}) do
        local y7, s7 = pcall(getconstants or debug.getconstants, p7.Function)
        if y7 and (type(s7) == "table") then
          f7 = true
          for y7, y7 in ipairs(oO) do
            f7 = f7 and (table.find(s7, y7) ~= nil)
          end
          if f7 then
            pcall(p7.Disconnect, p7)
          end
        end
      end
      wO[#wO + 1] = U(XO, EO)
    end
    local function XO()
      if not Shared.Alive then
        return false
      end
      if QO then
        if QO.Parent then
          return true
        end
      end
      local EO = Shared.LocalPlayer
      local oO = EO:FindFirstChild("PlayerGui")
      local f7, p7 = oO and (oO:FindFirstChild("ActivePets")), oO and (oO:FindFirstChild("HUD"))
      dO = (p7 and p7:FindFirstChild("GameHUD")) and p7.GameHUD:FindFirstChild("RightButtons")
      if f7 then
        if f7:FindFirstChild("Frame") then
          if not (dO) then
            return false
          end
        else
          return false
        end
      else
        return false
      end
      for y7, y7 in ipairs((((gethui and pcall(gethui)) and gethui()) or oO):GetChildren()) do
        if y7:IsA("ScreenGui") then
          if y7:FindFirstChild("EggsButton") then
            y7:Destroy()
          elseif y7.DisplayOrder == 34 then
            if y7:FindFirstChild("Frame") then
              if y7.Frame:FindFirstChild("Close") then
                y7:Destroy()
              end
            end
          end
        end
      end
      if dO:GetAttribute("vx") then
        EO = dO
        EO.Position = UDim2.fromScale(1, 0.5)
        dO:SetAttribute("vx", nil)
      end
      EO = vO.MouseEnabled
      local vO = not EO
      QO = I("ScreenGui", {IgnoreGuiInset = f7.IgnoreGuiInset, ScreenInsets = f7.ScreenInsets, ZIndexBehavior = f7.ZIndexBehavior, DisplayOrder = 34, ResetOnSpawn = false, Enabled = false})
      if not (pcall(function()
        local y7 = QO
        y7.Parent = gethui()
      end)) then
        QO.Parent = oO
      end
      DO = f7.Frame:Clone()
      rO(DO)
      f7 = DO
      for rO, rO in ipairs(f7:GetDescendants()) do
        if rO:IsA("LuaSourceContainer") then
          rO:Destroy()
        end
      end
      f7 = DO
      for rO, rO in ipairs(f7:GetChildren()) do
        if rO:IsA("GuiObject") then
          if rO.Name ~= "Header" then
            if rO.Name ~= "Close" then
              if rO.Name ~= "ScrollingFrame" then
                rO:Destroy()
              end
            end
          end
        end
      end
      local rO, y7, s7 = DO.ScrollingFrame, DO.Header, DO.Close
      rO.ScrollingDirection = Enum.ScrollingDirection.Y
      TO = rO.Template
      TO.Parent = nil
      f7 = TO.Spacer:FindFirstChild("Unequip", true)
      if f7 then
        if f7.Parent ~= TO.Spacer then
          local q7 = f7.Parent
          f7.Parent, f7.AnchorPoint = TO.Spacer, Vector2.new(1, 0.5)
          q7:Destroy()
        end
      end
      for q7, q7 in ipairs(rO:GetChildren()) do
        if q7:IsA("GuiObject") then
          if q7.Name ~= "EmptyLast" then
            q7:Destroy()
          end
        end
      end
      f7 = DO:FindFirstChildOfClass("UIAspectRatioConstraint") or I("UIAspectRatioConstraint", {Parent = DO})
      local q7 = 0.92 / f7.AspectRatio
      f7.AspectRatio, f7.AspectType = 0.92, Enum.AspectType.FitWithinMaxSize
      local G7, c7, a7, i7 = DO, DO, UDim2.fromScale((if EO then vO else 0.4) or 0.28, (if EO then vO else 0.86) or 0.66), NO(205, 200, 255)
      G7.Size = a7
      c7.ImageColor3 = i7
      y7.Size = UDim2.new(y7.Size.X.Scale, 0, y7.Size.Y.Scale * q7, 0)
      y7.Position = UDim2.new(y7.Position.X.Scale, 0, y7.Position.Y.Scale * q7, 0)
      s7.Size = UDim2.new(s7.Size.X.Scale, 0, s7.Size.Y.Scale * q7, 0)
      q7, i7 = y7.Position.Y.Scale + (y7.Size.Y.Scale * (1 - y7.AnchorPoint.Y)), rO.Size.X.Scale * TO.Spacer.Size.X.Scale
      f7 = I("Frame", {Parent = DO, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(rO.Position.X.Scale, q7 + 0.0297), Size = UDim2.fromScale(i7, 0.075)})
      I("UIListLayout", {Parent = f7, FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0.03, 0)})
      EO = q7 + 0.125
      rO.AnchorPoint, rO.Position, rO.Size = Vector2.new(0.5, 0), UDim2.fromScale(0.5, EO), UDim2.fromScale(rO.Size.X.Scale, 0.975 - EO)
      vO = y7:FindFirstChildOfClass("UIGradient")
      if vO then
        vO.Color = ColorSequence.new(zO.vx[1], zO.vx[2])
      end
      G7 = y7.Title
      G7.Text, G7.TextScaled, G7.TextXAlignment = "Steal Panel", true, Enum.TextXAlignment.Left
      G7.AnchorPoint, G7.Position, G7.Size = Vector2.new(0, 0.5), UDim2.fromScale(0.045, 0.5), UDim2.fromScale(0.75, 0.56)
      for NO, NO in ipairs(G7:GetChildren()) do
        if NO:IsA("UITextSizeConstraint") then
          NO:Destroy()
        end
      end
      q7 = y7.PlusEquip
      q7.AnchorPoint, q7.Position, q7.Size = Vector2.new(1, 0.5), UDim2.fromScale(0.975, 0.5), UDim2.fromScale(0.15, 0.68)
      OO(q7).Text = ""
      gO(q7, "vx")
      I("ImageLabel", {Parent = q7, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.88, 0.88), SizeConstraint = Enum.SizeConstraint.RelativeYY, Image = "rbxasset://textures/ui/Settings/MenuBarIcons/GameSettingsTab.png", ScaleType = Enum.ScaleType.Fit})
      hO(q7, function()
        LO["Auto Steal"]:Go()
      end)
      a7 = y7:FindFirstChild("Stroke")
      if a7 then
        a7:Destroy()
      end
      for NO, NO in ipairs(s7:GetDescendants()) do
        if NO:IsA("ImageLabel") then
          NO:Destroy()
        elseif NO:IsA("ImageButton") then
          NO:Destroy()
        end
      end
      q7 = OO(s7)
      if q7 then
        q7.Visible = true
        q7.Text = ">"
        q7.TextTransparency = 0
      end
      hO(s7, function()
        VO.Show(false)
      end)
      vO, a7 = TO.Spacer.Unequip, {{"steal", "Auto Steal", function()
        local NO = Shared.Core
        if NO.autoSteal then
          local NO = Shared.Core
          NO.autoSteal:Set(not Shared.s21.steal)
        end
      end}, {"hwEggs", "Halloween", function()
        local NO = Shared.Core
        if NO.hwEggsT then
          local NO = Shared.Core
          NO.hwEggsT:Set(not Shared.s21.hwEggs)
        end
      end}, {"hwmode", nil, function()
        VO.hw = ((((VO.hw or "All") == "All") and "Halloween") or ((VO.hw == "Halloween") and "Field")) or "All"
      end}}
      for NO, zO in ipairs(a7) do
        EO = vO:Clone()
        EO.AnchorPoint, EO.Size = Vector2.new(0.5, 0.5), UDim2.fromScale(0.31, 1)
        EO.LayoutOrder = NO
        EO.Parent = f7
        hO(EO, function()
          zO[3]()
          VO.Sync()
          VO.Refresh()
        end)
        bO[NO] = {EO, zO[1], zO[2]}
      end
      mO = OO(TO.Spacer):Clone()
      local NO, zO, s7, q7, c7, a7, n7, M7, H7, U7 = mO, mO, mO, mO, mO, mO, Vector2.new(0.5, 0.5), UDim2.fromScale(0.5, 0.45), UDim2.fromScale(0.8, 0.08), DO
      NO.AnchorPoint = n7
      zO.Position = M7
      s7.Size = H7
      q7.Text = "No eggs to show right now"
      c7.Visible = false
      a7.Parent = U7
      rO = mO:FindFirstChildOfClass("UIGradient")
      if rO then
        rO:Destroy()
      end
      rO = TO.Spacer
      rO.Icon.AnchorPoint, rO.Icon.Position, rO.Icon.Size = Vector2.new(0.5, 0.5), UDim2.fromScale(0.1, 0.5), UDim2.fromScale(0.17, 1.15)
      i7 = rO.TextLabel
      i7.AnchorPoint, i7.Position, i7.Size = Vector2.new(0, 0.5), UDim2.fromScale(0.223, 0.5), UDim2.fromScale(0.44, 0.62)
      i7.RichText = true
      EO = i7:Clone()
      for c7, c7 in ipairs(EO:GetChildren()) do
        if c7:IsA("UIGradient") then
          c7:Destroy()
        elseif c7:IsA("UIStroke") then
          c7:Destroy()
        end
      end
      EO.Name, EO.TextColor3, EO.ZIndex = "SizeTag", Color3.new(1, 1, 1), i7.ZIndex + 1
      EO.Parent = rO
      f7 = EO:Clone()
      f7.Name = "MoneyTag"
      f7.Parent = rO
      H7 = EO:Clone()
      H7.Name, H7.Parent, H7.AnchorPoint, H7.Position, H7.Size, H7.TextXAlignment = "Queue", rO, Vector2.new(0, 0), UDim2.fromScale(0.025, 0.06), UDim2.fromScale(0.16, 0.26), Enum.TextXAlignment.Left
      H7.Text = ""
      s7 = rO.Unequip
      s7.AnchorPoint, s7.Position, s7.Size = Vector2.new(1, 0.5), UDim2.fromScale(0.97, 0.5), UDim2.fromScale(0.24, 0.62)
      OO(s7).Text = "STEAL"
      gO(s7, "on")
      EO = {"Up", "Down"}
      for f7, c7 in ipairs(EO) do
        NO = s7:Clone()
        NO.Name = c7
        NO.Visible = false
        OO(NO).Text = ""
        gO(NO, "gold")
        I("ImageLabel", {Name = "Arrow", Parent = NO, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.72, 0.72), Image = V.arrow, ScaleType = Enum.ScaleType.Fit, Rotation = ((f7 == 1) and -90) or 90, ZIndex = NO.ZIndex + 2})
        NO.Parent = rO
      end
      G7.Size = UDim2.fromScale(0.56, 0.56)
      rO = vO:Clone()
      rO.AnchorPoint, rO.Position, rO.Size = Vector2.new(1, 0.5), UDim2.fromScale(0.81, 0.5), UDim2.fromScale(0.19, 0.62)
      rO.Parent = y7
      gO(rO, "gold")
      hO(rO, function()
        jO()
        VO.Sync()
        VO.Refresh()
      end)
      VO.sort = rO
      rO = TO
      rO.Size = UDim2.new(1, 0, 0.23, 0)
      DO.Parent = QO
      DO:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        _O(DO, DO.AbsoluteSize.X)
      end)
      _O(DO, ((DO.AbsoluteSize.X > 0) and DO.AbsoluteSize.X) or 556)
      if not (VO.cl) then
        VO.cl = true
        table.insert(Shared.Core.cleanup, function()
          if VO.open then
            VO.Show(false)
          end
          VO.open = false
          for vO, vO in ipairs(wO) do
            vO:Disconnect()
          end
          if dO then
            if dO:GetAttribute("vx") then
              local vO = dO
              vO.Position = UDim2.fromScale(1, 0.5)
              dO:SetAttribute("vx", nil)
            end
          end
          if QO then
            QO:Destroy()
          end
          if eO then
            eO.Parent:Destroy()
          end
        end)
      end
      for vO, vO in ipairs(wO) do
        vO:Disconnect()
      end
      table.clear(wO)
      a7 = dO:FindFirstAncestorOfClass("ScreenGui") or p7
      local vO = I("ScreenGui", {IgnoreGuiInset = a7.IgnoreGuiInset, ScreenInsets = a7.ScreenInsets, DisplayOrder = a7.DisplayOrder, ResetOnSpawn = false, Enabled = false})
      VO.bh = nil
      if not (pcall(function()
        vO.Parent = gethui()
      end)) then
        vO.Parent = oO
      end
      eO = dO:FindFirstChild("EggsButton") and dO.EggsButton:Clone()
      if eO then
        U7 = eO
        for NO, NO in ipairs(U7:GetChildren()) do
          if (NO:IsA("GuiObject") and (NO.Name ~= "Pattern")) and (NO.Name ~= "ImageLabel") then
            NO:Destroy()
          elseif NO:IsA("LuaSourceContainer") then
            NO:Destroy()
          end
        end
        eO.ImageLabel.Image = V.money
        gO(eO, "vx")
        q7, n7 = eO, eO
        q7.AnchorPoint = Vector2.new(0.5, 0.5)
        n7.Parent = vO
        hO(eO, function()
          VO.Show(not VO.open)
        end)
        p7 = Shared.RunService
        AO(p7.RenderStepped, function()
          if eO.Visible then
            FO()
          end
        end)
        AO(dO:GetPropertyChangedSignal("Position"), function()
          if Shared.Alive then
            if VO.open then
              if not (VO.sliding) then
                if dO.Position.X.Offset < (((VO.home and VO.home.X.Offset) or 0) + (xO * 0.95)) then
                  VO.Column(true)
                end
              end
            end
          end
        end, "open", "Offset")
        for vO, vO in ipairs(kO) do
          local NO = oO:FindFirstChild(vO)
          if NO then
            AO(NO:GetPropertyChangedSignal("Enabled"), function()
              if NO.Enabled then
                if VO.open then
                  VO.Show(false, true)
                end
              end
            end, "Show", "open", "Enabled")
          end
        end
        zO = false
        for vO, vO in ipairs(kO) do
          zO = zO or (oO:FindFirstChild(vO) and oO[vO].Enabled)
        end
        if not zO then
          if dO.Position.X.Offset > 0 then
            a7 = dO
            a7.Position = UDim2.fromScale(1, 0.5)
          end
        end
      end
      return true
    end
    VO.Sync = function()
      if not (DO) then
        return
      end
      local vO = ipairs
      for NO, zO in vO(bO) do
        if zO[2] == "hwmode" then
          gO(zO[1], ((VO.hw == "Halloween") and "gold") or "vx")
          OO(zO[1]).Text = "Eggs: " .. (VO.hw or "All")
        else
          NO = Shared.s21
          local jO = NO[zO[2]] == true
          gO(zO[1], (jO and "on") or "off")
          OO(zO[1]).Text = zO[3] .. ((jO and ": ON") or ": OFF")
        end
      end
      if VO.sort then
        vO = nil
        vO, OO(VO.sort).Text = Shared.s21, uO[Shared.s21.order] or "Value"
      end
    end
    FO = function()
      local vO, NO, zO = dO:FindFirstAncestorOfClass("ScreenGui"), dO:FindFirstChild("EggsButton"), dO:FindFirstChild("PetsButton")
      if vO then
        if vO.Enabled then
          if NO then
            if zO then
              if dO.Visible then
                if NO.Visible then
                  if NO.AbsoluteSize.X > 0 then
                    local vO = NO:FindFirstChildOfClass("UIScale")
                    local uO, jO, rO = ((vO and (vO.Scale > 0)) and vO.Scale) or 1, (NO.AbsolutePosition + (NO.AbsoluteSize / 2)) - Vector2.new((VO.home and (dO.Position.X.Offset - VO.home.X.Offset)) or 0, 0), eO.Parent.AbsolutePosition
                    VO.bh, VO.bs = UDim2.fromOffset(jO.X - rO.X, ((2 * jO.Y) - (zO.AbsolutePosition.Y + (zO.AbsoluteSize.Y / 2))) - rO.Y), UDim2.fromOffset(NO.AbsoluteSize.X / uO, NO.AbsoluteSize.Y / uO)
                  end
                end
              end
            end
          end
        end
      end
      zO = VO.bh and ((eO.Position ~= VO.bh) or (eO.Size ~= VO.bs))
      if zO then
        local vO, NO, zO, uO = eO, eO, VO.bh, VO.bs
        vO.Position = zO
        NO.Size = uO
      end
      eO.Parent.Enabled = VO.bh ~= nil
    end
    VO.Column = function(vO)
      VO.sliding = true
      xO = math.ceil(dO.AbsoluteSize.X * 1.03)
      if vO and not VO.home then
        VO.home = dO.Position
      end
      local NO = VO.home or UDim2.fromScale(1, 0.5)
      local zO = HO:Create(dO, TweenInfo.new((vO and 0.22) or 0.3, (vO and Enum.EasingStyle.Quad) or Enum.EasingStyle.Back, (vO and Enum.EasingDirection.In) or Enum.EasingDirection.Out), {Position = (vO and (NO + UDim2.fromOffset(xO, 0))) or NO})
      local function HO()
        VO.sliding = false
        if not (vO) then
          VO.home = nil
        end
      end
      zO.Completed:Connect(HO)
      zO:Play()
    end
    local function HO()
      local vO = ipairs
      for NO, zO in vO(kO) do
        NO = Shared.LocalPlayer
        local vO = NO.PlayerGui:FindFirstChild(zO)
        if vO and vO.Enabled then
          NO = vO:FindFirstChild("Frame") and vO.Frame:FindFirstChild("Close")
          for vO, vO in ipairs((NO and getconnections(NO.Activated)) or {}) do
            pcall(vO.Fire, vO)
          end
          return true
        end
      end
    end
    VO.Show = function(vO, NO)
      if not (XO()) then
        return
      end
      VO.open = vO
      if vO then
        if HO() then
          task.delay(0.27, function()
            if VO.open then
              VO.Show(true)
            end
          end)
          return
        end
      end
      local HO = UDim2.new(0.985, (DO.AbsoluteSize.X * 1.4) + 60, 0.5, 0)
      dO:SetAttribute("vx", vO or nil)
      if vO then
        local vO
        vO, QO.Enabled = DO, true
        vO.Position = HO
        VO.Sync()
        VO.Refresh()
        local vO, zO = DO, {}
        zO.Position = UDim2.fromScale(0.985, 0.5)
        lO(vO, zO, 0.3, Enum.EasingStyle.Back)
        VO.Column(true)
      else
        lO(DO, {Position = HO}, 0.24, nil, Enum.EasingDirection.In)
        if not (NO) then
          VO.Column(false)
        end
        task.delay(0.25, function()
          if not (VO.open) then
            QO.Enabled = false
          end
        end)
      end
    end
    VO.Dock = function(HO, vO)
      task.spawn(function()
        for NO = 1, (vO and 1) or 30, 1 do
          if XO() then
            break
          end
          task.wait(1)
        end
        if eO then
          eO.Visible = HO
          if HO then
            FO()
          end
        end
      end)
    end
    local HO, vO, NO = {}, {}, {}
    local function zO(lO)
      if not (lO) then
        return
      end
      if lO.hw then
        local uO = Shared.Core
        if uO.hwPick == lO.Uid then
          local uO = Shared.Core
          uO.hwPick = nil
          W("Halloween", "Removed " .. (lO.n .. " from the queue"), "info")
        else
          local uO = Shared.Core
          uO.hwPick = lO.Uid
          uO = Shared.s21
          if not (uO.hwEggs) then
            local uO = Shared.Core
            if uO.hwEggsT then
              local uO = Shared.Core
              uO.hwEggsT:Set(true)
            end
          end
          W("Halloween", "Stealing now: " .. lO.n, "info")
        end
        return VO.Refresh()
      end
      local uO, jO, jO = vO[lO.Uid], Shared.Core, table.find(Shared.Core.pick, lO.Uid)
      if uO == "STOP" then
        local rO = Shared.Core
        rO.stopSteal()
        W("Steal", "Stopped " .. (lO.n .. ", moving to the next egg"), "info")
      elseif uO == "CANCEL" then
        if jO then
          table.remove(Shared.Core.pick, jO)
        end
        NO[lO.Uid] = nil
        W("Steal", "Removed " .. (lO.n .. " from the queue"), "info")
      else
        local uO = Shared.Core
        uO.skip[lO.Uid] = nil
        NO[lO.Uid] = true
        if jO then
          table.remove(Shared.Core.pick, jO)
        end
        table.insert(Shared.Core.pick, 1, lO.Uid)
        uO = Shared.Core
        uO.rank.Steal = 0
        uO = Shared.Core
        if uO.order then
          local jO = Shared.Core
          jO.order()
        end
        uO = Shared.s21
        if not (uO.steal) then
          local jO = Shared.Core
          if jO.autoSteal then
            local jO = Shared.Core
            jO.autoSteal:Set(true)
          end
        end
        uO = Shared.Core
        uO.retarget()
        W("Steal", ((lO.held and "Chasing ") or "Stealing now: ") .. lO.n, "info")
      end
      VO.Refresh()
    end
    VO.Move = function(lO, uO)
      local jO = VO.queue or {}
      local rO = table.find(jO, lO)
      local kO = rO and (rO + uO)
      if kO then
        if not (jO[kO]) then
          return
        end
      else
        return
      end
      local FO, QO = HO[lO], HO[jO[kO]]
      local dO = (FO and FO.hw) or (QO and QO.hw)
      if dO then
        local xO = Shared.Core
        if xO.hwMove then
          local xO = Shared.Core
          xO.hwMove((FO and FO.hw) and lO, (QO and QO.hw) and jO[kO], uO)
        end
        return VO.Refresh()
      end
      jO[rO], jO[kO] = jO[kO], jO[rO]
      lO, dO = math.max(rO, kO), #jO
      for rO = 1, dO, 1 do
        uO = nil
        uO, lO = Shared.Core, if table.find(Shared.Core.pick, jO[rO]) then math.max(lO, rO) else lO
      end
      table.clear(Shared.Core.pick)
      for uO = 1, lO, 1 do
        kO = Shared.Core
        kO.pick[uO] = jO[uO]
      end
      FO = Shared.Core
      FO.rank.Steal = 0
      FO = Shared.Core
      if FO.order then
        dO = Shared.Core
        dO.order()
      end
      VO.Refresh()
    end
    VO.Set = function(lO)
      if DO then
        if not (VO.open) then
          return
        end
      else
        return
      end
      VO.Sync()
      local uO, jO, rO, kO, FO, QO = {}, {}, {}, {}, ipairs, 0
      for dO, xO in FO(lO) do
        if xO.hw then
          local bO, wO = xO.cur
          if bO then
            wO = bO
          else
            dO = Shared.Core
            wO = dO.hwPick == xO.Uid
          end
          if wO then
            table.insert(uO, 1, xO)
            QO += 1
          else
            bO = Shared.s21
            if bO.hwEggs then
              if xO.tg then
                rO[#rO + 1] = xO
              else
                jO[#jO + 1] = xO
              end
            else
              jO[#jO + 1] = xO
            end
          end
        else
          local dO = Shared.Core
          if xO.Uid == dO.curUid then
            table.insert(uO, 1, xO)
          else
            local dO = Shared.Core
            if table.find(dO.pick, xO.Uid) then
              QO += 1
              uO[#uO + 1] = xO
            else
              local dO = Shared.s21
              if dO.steal then
                if xO.tg then
                  kO[#kO + 1] = xO
                else
                  jO[#jO + 1] = xO
                end
              else
                jO[#jO + 1] = xO
              end
            end
          end
        end
      end
      table.sort(rO, function(dO, xO)
        local bO, wO = dO.o or math.huge, xO.o or math.huge
        if bO ~= wO then
          return bO < wO
        end
        return dO.v > xO.v
      end)
      FO = Shared.Core
      local dO, xO = FO.hwTurnNow
      if dO then
        lO = Shared.Core
        xO = lO.hwTurnNow()
      else
        xO = dO
      end
      dO, FO = 1, 1
      while rO[dO] or kO[FO] do
        local bO, wO = rO[dO] ~= nil
        if bO then
          lO = kO[FO]
          wO = (if lO then xO == true else not lO) or ((xO == nil) and (rO[dO].v > kO[FO].v))
        else
          wO = bO
        end
        bO = nil
        if wO then
          bO = rO[dO]
          dO = dO + 1
        else
          bO = kO[FO]
          FO = FO + 1
        end
        xO = not wO
        local xO = Shared.Core
        if QO < (#xO.pick + 8) then
          QO += 1
          uO[#uO + 1] = bO
        else
          jO[#jO + 1] = bO
        end
      end
      lO = Shared.Core
      rO, dO = lO.sortKey
      if rO then
        FO = Shared.Core
        dO = FO.sortKey()
      else
        dO = rO
      end
      local QO = dO or "v"
      table.sort(jO, function(xO, bO)
        local wO, AO = xO[QO] or 0, bO[QO] or 0
        if wO ~= AO then
          return wO > AO
        end
        return xO.v > bO.v
      end)
      kO = #uO
      for QO, QO in ipairs(jO) do
        uO[#uO + 1] = QO
      end
      rO = {}
      VO.queue = {}
      for QO = 1, kO, 1 do
        lO = Shared.Core
        if uO[QO].Uid ~= lO.curUid then
          VO.queue[#VO.queue + 1] = uO[QO].Uid
        end
      end
      jO, FO = math.min(#uO, 60), 0
      for QO = 1, jO, 1 do
        lO = uO[QO]
        dO = SO[lO.Uid]
        if dO then
        else
          dO = TO:Clone()
          dO.Visible, dO.Name = true, lO.Uid
          local jO = lO.Uid
          hO(dO.Spacer.Unequip, function()
            zO(HO[jO])
          end)
          hO(dO.Spacer.Up, function()
            VO.Move(jO, -1)
          end)
          hO(dO.Spacer.Down, function()
            VO.Move(jO, 1)
          end)
          dO.Parent = DO.ScrollingFrame
          SO[lO.Uid] = dO
          _O(dO, DO.AbsoluteSize.X)
        end
        rO[lO.Uid], HO[lO.Uid] = true, lO
        dO.LayoutOrder = QO
        local zO, jO = dO.Spacer, Shared.Core
        local hO, _O, TO = jO.curUid == lO.Uid, lO.hw
        if _O then
          local xO, bO = lO.cur and "STOP"
          if xO then
            bO = xO
          else
            jO = Shared.Core
            bO = (jO.hwPick == lO.Uid) and "CANCEL"
          end
          TO = bO or "STEAL"
        else
          TO = _O
        end
        jO, _O = TO or (hO and "STOP")
        if jO then
          _O = jO
        else
          local xO, bO = NO[lO.Uid]
          if xO then
            TO = nil
            TO, bO = Shared.Core, table.find(Shared.Core.pick, lO.Uid)
          else
            bO = xO
          end
          _O = bO and "CANCEL"
        end
        TO = (_O or (lO.held and "CHASE")) or "STEAL"
        vO[lO.Uid] = TO
        if dO:GetAttribute("k") ~= TO then
          dO:SetAttribute("k", TO)
          OO(zO.Unequip).Text = ((TO == "STOP") and "CANCEL") or TO
          gO(zO.Unequip, YO[TO])
        end
        FO = if QO <= kO then if hO then FO else FO + 1 else FO
        TO = ((QO <= kO) and not hO) and not lO.cur
        zO.Up.Visible, zO.Down.Visible = TO, TO
        zO.Up.Arrow.ImageTransparency, zO.Down.Arrow.ImageTransparency = ((FO > 1) and 0) or 0.6, ((FO < #VO.queue) and 0) or 0.6
        RO(zO, TO)
        zO.Queue.Text = ((QO <= kO) and ("<stroke color=\"#000000\" joins=\"round\" thickness=\"2\"><font color=\"#FFC83C\">%s</font></stroke>"):format((hO and "NOW") or ("#" .. FO))) or ""
        zO.Icon.Image = PO(lO.cat)
        QO = zO.TextLabel:FindFirstChildOfClass("UIStroke")
        _O = (QO and QO.Thickness) or 2
        zO.TextLabel.Text = lO.la .. (ZO .. (lO.hm .. (lO.z .. "</font>")))
        zO.SizeTag.Text = ("%s%s%s</font><stroke color=\"#000000\" joins=\"round\" thickness=\"%.1f\"><font color=\"#14FF00\">%s</font><font color=\"#B8C0CC\">%s</font></stroke>"):format(ZO, lO.la, lO.hm or "", _O, lO.m, lO.z)
        zO.MoneyTag.Text = (lO.hm and ("%s%s</font><stroke color=\"#000000\" joins=\"round\" thickness=\"%.1f\"><font color=\"#14FF00\">%s</font></stroke>%s%s</font>"):format(ZO, lO.la, _O, lO.hm, ZO, lO.z)) or ""
        QO = g(lO.cat)
        jO, hO = (QO and QO.Rarity) and QO.Rarity.RarityGradient, zO.TextLabel:FindFirstChildOfClass("UIGradient")
        if (typeof(jO) == "Instance") and (if hO then hO:GetAttribute("c") ~= lO.cat else not hO) then
          if hO then
            hO:Destroy()
          end
          hO = ((QO.Rarity._id == "Secret") and WO(jO)) or jO:Clone()
          hO:SetAttribute("c", lO.cat)
          hO.Parent = zO.TextLabel
        end
      end
      for zO, YO in next, SO, nil do
        if not (rO[zO]) then
          YO:Destroy()
          SO[zO] = nil
          HO[zO] = nil
          vO[zO] = nil
          NO[zO] = nil
        end
      end
      rO = mO
      rO.Visible = #uO == 0
      DO.Header.Title.Text = ((FO > 0) and ("Steal Panel (" .. (FO .. " in queue)"))) or "Steal Panel"
    end
    local HO = false
    VO.Refresh = function()
      if HO then
        return
      elseif not (VO.open) then
        return
      end
      HO = true
      task.delay(0.08, function()
        HO = false
        if not (VO.open) then
          return
        end
        local HO, vO = VO.hw == "Field"
        if HO then
          local NO = Shared.Core
          vO = NO.allEggs()
        else
          vO = HO
        end
        HO = nil
        if vO then
          HO = vO
        else
          local NO = Shared.Core
          local zO = NO.hwEggs
          if zO then
            NO = Shared.Core
            HO = NO.hwEggs()
          else
            HO = zO
          end
        end
        local NO = HO or {}
        if (VO.hw or "All") == "All" then
          HO = Shared.Core
          for zO, zO in ipairs(HO.allEggs()) do
            NO[#NO + 1] = zO
          end
        end
        vO = ipairs
        for zO, YO in vO(NO) do
          if not (YO.hm) then
            HO, zO = YO.n:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;") .. "\n", Shared.Fire
            YO.hm = "$" .. ((zO("Fmt", "FormatCompact", YO.v, ".#") or O(YO.v)) .. "/s  ")
            YO.la, YO.m, YO.z = HO, "", ("x%.2f"):format(YO.s) .. ((YO.hw and "  <font color=\"#FF9A3C\">Halloween</font>") or "")
          end
        end
        A("hud", function()
          VO.Set(NO)
        end)
      end)
    end
    task.spawn(function()
      local HO = Shared.Modules
      local vO, NO = HO.Egg, {"FieldShifted", "FieldGone", "FieldClaimed", "FieldRefreshed", "SnapshotRefreshed"}
      for HO, HO in ipairs(NO) do
        if vO then
          if vO[HO] then
            pcall(U, vO[HO], VO.Refresh)
          end
        end
      end
    end)
    local HO = sO({name = "HudPanel", gap = 2})
    HO.on = function()
      return VO.open
    end
    HO.fn = VO.Refresh
    local HO = sO({name = "HudIcon", gap = 1})
    HO.on = function()
      local vO = Shared.s21
      return vO.panelBtn ~= false
    end
    HO.fn = function()
      local HO, vO, NO = Shared.Core, -1
      for zO, zO in ipairs(HO.allEggs()) do
        if zO.v > vO then
          NO = zO.cat
          vO = zO.v
        else
        end
      end
      local HO = (NO and PO(NO)) or V.money
      A("hudIcon", function()
        local vO = eO and eO:FindFirstChild("ImageLabel")
        if vO then
          if vO.Image ~= HO then
            vO.Image = HO
          end
        end
      end)
    end
  end
  do
    local HO = Z.Dir() .. "/_hop.json"
    local vO = Z.Rd(HO) or {}
    vO.Visited = ((type(vO.Visited) == "table") and vO.Visited) or {}
    local function NO()
      Z.Wr(HO, vO)
    end
    tO = K() - 1800
    for HO, zO in next, vO.Visited, nil do
      if zO < tO then
        vO.Visited[HO] = nil
      end
    end
    vO.Visited[Shared.Game.JobId] = K()
    NO()
    local HO, zO = {}
    local YO, lO = 0
    local uO, jO = false
    U(i.TeleportInitFailed, function(gO)
      local OO = Shared.LocalPlayer
      if gO == OO then
        local gO = Shared.Core
        if gO.hopping then
          uO = false
          if lO then
            HO[lO] = true
          end
          task.spawn(jO, Shared.Core.hopping)
        end
      end
    end)
    U(Shared.LocalPlayer.OnTeleport, function(gO)
      if gO == Enum.TeleportState.Started then
        uO = true
      elseif gO == Enum.TeleportState.InProgress then
        uO = true
      end
    end)
    local function gO(OO)
      if zO then
        if (os.clock() - YO) < 60 then
          local hO = zO
          return hO
        end
      end
      local hO, RO, _O = {}, ((OO == "Random") and 3) or 6, ""
      for rO = 1, RO, 1 do
        rO = Shared.Game
        local VO = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=%s&excludeFullGames=true&limit=100%s"):format(rO.PlaceId, ((OO == "Most players") and "Desc") or "Asc", _O)
        local rO, rO, rO, kO = Shared.Game, Shared.Game, pcall(Shared.Game.HttpGet, Shared.Game, VO)
        local FO, FO, FO, QO = Shared.HttpService, Shared.HttpService, pcall(Shared.HttpService.JSONDecode, Shared.HttpService, (rO and kO) or "")
        if FO then
          if type(QO) ~= "table" then
            break
          end
        else
          break
        end
        VO, FO = ipairs, QO.data or {}
        for rO, rO in VO(FO) do
          kO = Shared.Game
          if rO.id ~= kO.JobId then
            hO[#hO + 1] = rO
          end
        end
        if #hO > 0 then
          if OO ~= "Random" then
            break
          elseif not (QO.nextPageCursor) then
            break
          end
        elseif not (QO.nextPageCursor) then
          break
        end
        _O = "&cursor=" .. QO.nextPageCursor
      end
      RO = nil
      RO, zO = os.clock(), hO
      YO = RO
      return hO
    end
    jO = function(YO)
      for OO = 1, 2, 1 do
        local hO, RO = ipairs, {2, 1}
        for _O, rO in hO(RO) do
          local hO, RO, VO = {}, ipairs, f[53](gO(YO))
          for gO, kO in RO(f:uT(VO)) do
            if ((kO.maxPlayers or 0) - (kO.playing or 0)) >= rO then
              gO = HO
              if not (gO[kO.id]) then
                if OO == 1 then
                  if not (vO.Visited[kO.id]) then
                    hO[#hO + 1] = kO
                  end
                else
                  hO[#hO + 1] = kO
                end
              end
            end
          end
          if #hO > 0 then
            table.sort(hO, function(gO, OO)
              if YO == "Most players" then
                return gO.playing > OO.playing
              end
              return gO.playing < OO.playing
            end)
            local gO = hO[math.random(1, ((YO == "Random") and #hO) or math.min(#hO, 100))]
            RO, rO, VO, _O = vO.Visited, gO.id, K(), gO.id
            RO[rO] = VO
            lO, uO = _O, false
            NO()
            local OO = Shared.Core
            OO.beforeTeleport()
            W("Server hop", ("Joining a server with %d players"):format(gO.playing or 0), "info")
            local OO, OO = Shared.Game, Shared.LocalPlayer
            pcall(i.TeleportToPlaceInstance, i, Shared.Game.PlaceId, gO.id, Shared.LocalPlayer)
            task.delay(6, function()
              local OO = Shared.Core
              if OO.hopping then
                local OO = lO
                if OO == gO.id then
                  if not (uO) then
                    local lO = HO
                    lO[gO.id] = true
                    jO(YO)
                  end
                end
              end
            end)
            return true
          end
        end
        HO, zO = {}, nil
      end
      local HO = Shared.Core
      HO.hopping = nil
      return false
    end
    Shared.Core.hop = function(HO)
      local zO = Shared.Core
      if zO.hopping then
        return true
      end
      local YO, lO = Shared.Core
      if HO then
        lO = HO
      else
        zO = Shared.s21
        lO = zO.hopMode
      end
      YO.hopping = lO or "Least players"
      HO = Shared.Core
      return jO(HO.hopping)
    end
    u = LO["Auto Steal"]:Section("Auto hop server", "server", 1)
    local HO = X("hop", u:Text(""))
    m(u, "Auto hop", "autoHop", false, function(zO)
      if not (zO) then
        HO("")
      end
    end)
    x(u, "Hop when", "hopWhen", {"No egg matches here", "After stealing a match", "A rare egg spawned"}, "After stealing a match")
    x(u, "Rare from", "hopRare", l, "Cosmic")
    S(u, "First hop after", "hopDelay", 3, 15, 5, "s")
    pO(u)
    local zO = os.clock()
    local YO = Shared.Core.onSteal
    Shared.Core.onSteal = function(lO)
      local uO = Shared.s21
      if uO.hopWhen == "After stealing a match" then
        if type(lO) == "table" then
          local uO, jO, gO = {cat = lO.AssetCategory, r = h(lO.AssetCategory), v = math.huge, m = {}}, Shared.s63, Shared.Core
          if jO(gO.stealFilter, uO) then
            local h = Shared.Fire
            vO.Window = h("Cycle", "NextNightTime", K()) or (K() + 300)
            NO()
          end
        end
      end
      if YO then
        YO(lO)
      end
    end
    local h = sO({name = "Hopper", gap = 0.5})
    h.on = function()
      local NO = Shared.s21
      return NO.autoHop
    end
    h.fn = function()
      local NO = T()
      if NO <= 0 then
        return HO("Night, waiting for the field to reset")
      end
      local YO = Shared.s21
      if (os.clock() - zO) < YO.hopDelay then
        return HO("Looking around this server")
      end
      YO = Shared.s29
      if YO() then
        return HO("Busy stealing")
      elseif Shared.s4 then
        if Shared.s4.name == "Steal" then
          return HO("Busy stealing")
        end
      end
      YO = Shared.Core
      if YO.starWants then
        local zO = Shared.Core
        if zO.starWants() then
          return HO("Catching a Shooting Star, hop waits")
        end
      end
      YO = Shared.Core
      local zO, lO, lO, uO, jO = YO.stealFilter, Shared.s21, table.find(Y, Shared.s21.hopRare) or 7, pairs, Shared.s19
      local gO, OO, hO, RO = f[53](jO()), false, 0, 0
      for _O, rO in uO(f:uT(gO)) do
        if type(rO) == "table" then
          if rO.State ~= "Claimed" then
            if rO.Uid then
              if rO.Uid:find("^FirstAreaEgg") then
              else
                _O = r(rO)
                OO = if _O.r >= lO then true else OO
                YO = Shared.s63
                jO = YO(zO, _O)
                local lO
                if jO then
                  local _O = Shared.s21
                  local VO = _O.zones
                  _O = not VO
                  if VO then
                    local VO = Shared.s21
                    lO = VO.zones[tostring(rO.AreaId):gsub("%s", "")]
                  else
                    lO = _O
                  end
                else
                  lO = jO
                end
                if lO then
                  if rO.State == "Carried" then
                    local lO = hO + 1
                    hO = lO
                  else
                    local lO = RO + 1
                    RO = lO
                  end
                else
                end
              end
            else
            end
          else
          end
        else
        end
      end
      if OO then
        zO = Shared.s21
        if zO.hopWhen == "A rare egg spawned" then
          gO = Shared.Fire
          vO.Window = gO("Cycle", "NextNightTime", K()) or (K() + 300)
        end
      end
      if RO > 0 then
        uO = Shared.s21
        if uO.steal then
          return HO(RO .. " matching egg(s) here")
        else
          YO = Shared.s21
          if YO.hopWhen == "No egg matches here" then
            return HO(RO .. " matching egg(s) here")
          end
        end
      end
      if hO > 0 then
        if (os.clock() - (h.seen or os.clock())) < 20 then
          h.seen = h.seen or os.clock()
          return HO("Someone is carrying a match, waiting")
        end
      end
      h.seen = nil
      if NO < 12 then
        return HO("Night is close, staying")
      end
      zO = Shared.s21
      if zO.hopWhen ~= "No egg matches here" then
        if K() > (vO.Window or 0) then
          return HO("Waiting for a reason to hop")
        end
      end
      HO("Hopping")
      jO = Shared.Core
      if not (jO.hop("Least players")) then
        task.wait(1.5)
      end
    end
  end
  Shared.Core.reserved = {}
  local function h(HO)
    local vO = {}
    for NO, NO in ipairs(((type(HO.EquippedAssets) == "table") and HO.EquippedAssets) or {}) do
      vO[NO] = true
    end
    return vO
  end
  local function HO()
    local vO = Shared.LocalPlayer
    local NO = vO.Character
    vO = NO and (NO:FindFirstChildOfClass("Tool"))
    return vO and (vO:GetAttribute("UID"))
  end
  local function vO(NO)
    local zO, YO = workspace:FindFirstChild("PlacedEggRenders"), Shared.LocalPlayer
    local lO = YO.UserId .. ("_" .. NO)
    NO, YO = zO and (zO:FindFirstChild(lO))
    if NO then
      YO = NO
    else
      zO = Shared.Core
      local NO = zO.hidden
      if NO then
        local zO = Shared.Core
        YO = zO.hidden:FindFirstChild(lO)
      else
        YO = NO
      end
    end
    return YO
  end
  Shared.Core.eggPos = function(NO)
    local zO, YO = vO(NO), Shared.s58
    local lO, uO = YO(), D()[NO]
    YO = ((type(uO) == "table") and (type(uO.Placement) == "table")) and uO.Placement.LocalCFrame
    return ((zO and zO:GetPivot().Position) or (((lO and lO.CenterPoint) and (typeof(YO) == "CFrame")) and (lO.CenterPoint.CFrame * YO).Position)) or nil
  end
  local function NO(zO)
    local YO = Shared.s68
    if not (YO("RF/EggWorld/AskHatch", zO)) then
      return false
    end
    task.wait(0.35)
    YO = Shared.Invoke
    YO("RF/EggWorld/AskFinishHatch", zO)
    return true
  end
  local function zO(YO, lO)
    local uO = ({Biggest = "s", ["Best rarity"] = "r"})[lO] or "v"
    table.sort(YO, function(jO, gO)
      if lO == "Smallest" then
        return jO.s < gO.s
      end
      if jO[uO] ~= gO[uO] then
        return jO[uO] > gO[uO]
      end
      return jO.v > gO.v
    end)
    return YO
  end
  do
    local YO = sO({name = "Place", mover = true, gap = 8, pri = 4, soft = true, bad = {}})
    tO = LO.Pen:Section("Auto place", "egg")
    m(tO, "Auto place", "place", false, function(lO)
      if not (lO) then
        qO(YO)
      end
    end)
    local lO = X("pen", tO:Text("Pen --"))
    x(tO, "Place when", "placeWhen", {"Always", "Steal is idle", "Right after a steal", "Only at night"}, "Always")
    x(tO, "Place first", "placeFirst", {"Best value", "Best rarity", "Biggest", "Smallest"}, "Best value")
    local uO, jO = fO(tO, {rar = Y, sp = "Only these eggs", mut = "Mutations", minV = "Min value /s", list = Shared.Core.eggSp}), 0
    local gO = Shared.Core.onSteal
    Shared.Core.onSteal = function(OO)
      jO = os.clock()
      if gO then
        gO(OO)
      end
    end
    local function gO()
      local OO = Shared.s58
      local hO, RO, _O, rO, VO = OO(), Shared.Vec3Zero, next, {}, Shared.Core
      f:yT(rO, 0, workspace:FindFirstChild("PlacedEggRenders"), VO.hidden)
      OO = 0
      for kO, FO in _O, rO, nil do
        VO, kO = ipairs, f[53](FO:GetChildren())
        for _O, rO in VO(f:uT(kO)) do
          if rO:IsA("Model") then
            _O, FO = Shared.LocalPlayer, rO.Name:find(Shared.LocalPlayer.UserId .. "_", 1, true)
            if FO == 1 then
              local _O, VO = OO + 1, RO + rO:GetPivot().Position
              OO, RO = _O, VO
            else
            end
          else
          end
        end
      end
      if OO > 0 then
        return RO / OO
      end
      return (hO and hO.PetArea) and hO.PetArea.Position
    end
    local OO = f:QT(15, 16, {[58] = q, [20] = q, [33] = q}, p, y, nil)
    local function hO(RO)
      local _O = Shared.Fire
      if _O("Egg", "WearEggTool", RO) == false then
        return false
      end
      _O = os.clock() + 2
      while os.clock() < _O do
        if HO() == RO then
          return true
        end
        if os.clock() > (_O - 1.3) then
          local _O, rO = ipairs, (Q() and Q():GetChildren()) or {}
          for VO, VO in _O(rO) do
            if VO:GetAttribute("UID") == RO then
              local RO, RO = Shared.s8, Shared.s8
              pcall(Shared.s8().EquipTool, Shared.s8(), VO)
            end
          end
        end
        task.wait(0.1)
      end
      return false
    end
    Shared.Core.wear = hO
    local function RO()
      local _O = Shared.s21
      local rO = _O.placeWhen
      if rO == "Steal is idle" then
        _O = Shared.s21
        local VO = _O.steal
        return if VO then IO.empty ~= nil else not VO
      end
      if rO == "Right after a steal" then
        _O = os.clock() - jO
        return _O < 12
      end
      if rO == "Only at night" then
        return T() < 14
      end
      return true
    end
    local function IO()
      local jO, _O, rO, VO = D(), {}, pairs, 0
      for kO, FO in rO(jO) do
        if type(FO) == "table" then
          if FO.Placement then
            VO += 1
          else
            if (YO.bad[kO] or 0) < os.clock() then
              local rO = Shared.Core
              if not (rO.reserved[kO]) then
                local rO = Shared.Core
                if not (rO.protect(kO, FO)) then
                  local rO, QO = r(FO), Shared.s21
                  if QO.place then
                    local FO = Shared.s63
                    if FO(uO, rO) then
                      rO.uid = kO
                      _O[#_O + 1] = rO
                    end
                  end
                end
              end
            end
          end
        else
        end
      end
      lO(("Pen %d/30  -  %d egg(s) ready to place"):format(VO, #_O))
      return VO, _O, jO
    end
    local lO = sO({name = "PlaceInfo", gap = 2, info = true})
    lO.on = function()
      return BO("Farm")
    end
    lO.fn = IO
    YO.want = function()
      local lO, uO, jO = IO()
      if lO >= 30 then
        return
      elseif #uO == 0 then
        return
      elseif not (RO()) then
        return
      end
      local IO, RO = {}, Shared.s21
      IO.list = zO(uO, RO.placeFirst)
      IO.room = 30 - lO
      IO.recs = jO
      return IO
    end
    YO.run = function(IO, lO)
      local uO = gO()
      if not (uO) then
        return
      end
      local jO = Shared.s10
      jO("Walking to your pen")
      jO = Shared.Vec3
      if not (aO(uO + jO(0, 3, 0), lO)) then
        return
      end
      local gO, RO, _O, rO = OO(IO.recs), math.min(IO.room, #IO.list), 0, 0
      for OO = 1, RO, 1 do
        if not (lO()) then
          break
        end
        uO = IO.list[OO]
        if hO(uO.uid) then
          OO = false
          for IO = 1, 8, 1 do
            _O += 1
            jO = gO[_O]
            if not jO then
              break
            end
            IO = Shared.s68
            if IO("RF/EggWorld/AskPlaceEgg", {Uid = uO.uid, LocalCFrame = jO[1]}) then
              rO += 1
              local IO = Shared.s36
              IO.placed = IO.placed + 1
              OO = true
              break
            end
          end
          if not OO then
            YO.bad[uO.uid] = os.clock() + 60
          end
          task.wait(0.25)
        else
          YO.bad[uO.uid] = os.clock() + 20
        end
      end
      jO = Shared.Fire
      jO("Egg", "DoffEggTool")
      if rO > 0 then
        lO = Shared.s10
        lO("Placed " .. (rO .. " egg(s)"), "ok")
      end
    end
    YO.on = function()
      local IO = Shared.s21
      return IO.place
    end
  end
  do
    local IO = sO({name = "Hatch", gap = 2, bad = {}, info = true})
    u = LO.Pen:Section("Auto hatch", "sparkles")
    m(u, "Auto hatch", "hatch", false)
    m(u, "Equip best pets", "equip", false)
    local YO = u:Stats({{"Ready now", V.egg}, {"Hatched", V.pet}})
    local lO = fO(u, {rar = Y, sp = "Only these eggs", mut = "Mutations", minV = "Min value /s", list = Shared.Core.eggSp})
    IO.on = function()
      local uO = Shared.s21
      return uO.hatch or BO("Farm")
    end
    IO.fn = function()
      local uO, jO, gO = {}, pairs, f[53](D())
      for OO, hO in jO(f:uT(gO)) do
        if type(hO) == "table" then
          if hO.Placement then
            local RO = Shared.Fire
            if RO("Egg", "IsReadyToHatch", OO) == true then
              uO[#uO + 1] = {OO, hO}
            end
          end
        end
      end
      gO, jO = {["Ready now"] = tostring(#uO)}
      jO, gO.Hatched = Shared.s36, tostring(Shared.s36.hatched)
      E("hs", YO, gO)
      jO = Shared.s21
      if not (jO.hatch) then
        return
      end
      gO, jO = ipairs, 0
      for YO, OO in gO(uO) do
        if jO >= 4 then
          break
        end
        YO = OO[1]
        if (IO.bad[YO] or 0) < os.clock() then
          local uO = Shared.s63
          if uO(lO, r(OO[2])) then
            local lO = Shared.Core
            if lO.protect(YO, OO[2]) then
            else
              local lO = jO + 1
              if NO(YO) then
                local uO = Shared.s36
                uO.hatched = uO.hatched + 1
              else
                IO.bad[YO] = os.clock() + 10
              end
              task.wait(0.2)
              jO = lO
            end
          else
          end
        else
        end
      end
    end
    local IO = sO({name = "Equip", gap = 8})
    IO.on = function()
      local YO = Shared.s21
      return YO.equip
    end
    IO.fn = function()
      local IO = Shared.Invoke
      local YO, lO = IO("RF/Haul/FetchWearBestStatus")
      if YO then
        if lO then
          IO = Shared.Invoke
          IO("RF/Haul/WearBest")
        end
      end
    end
  end
  do
    u = LO.Pen:Section("Keep eggs", "shield")
    pO(u)
    u:Text("Kept eggs are never placed, hatched or sold, in your bag or your pen.")
    local IO, YO = {}
    local lO, uO = {}, 0
    local function jO(gO)
      return ((gO >= 1000) and ("%.0f"):format(gO):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")) or ("%.2f"):format(gO)
    end
    local function gO(OO)
      local hO = Shared.Fire
      return tonumber(hO("Rec", "WeightKgForScale", OO.AssetCategory, OO.AssetScale))
    end
    local function OO()
      if (os.clock() - uO) < 2 then
        local hO = lO
        return hO
      end
      local hO
      hO, lO = os.clock(), {}
      uO = hO
      local uO, RO = {}, {}
      for _O, rO in pairs(D()) do
        if type(rO) == "table" then
          uO[#uO + 1] = {_O, rO, r(rO)}
        end
      end
      table.sort(uO, function(_O, rO)
        return _O[3].v > rO[3].v
      end)
      lO.rich = {}
      for _O, rO in ipairs(uO) do
        _O, hO = rO[3], gO(rO[2])
        local uO = _O.n .. ((hO and ("  " .. (jO(hO) .. " kg"))) or "")
        RO[uO] = (RO[uO] or 0) + 1
        uO = if RO[uO] > 1 then uO .. (" (" .. (RO[uO] .. ")")) else uO
        local jO = lO
        jO[rO[1]] = uO
        jO = lO
        jO[#jO + 1] = uO
        jO = {}
        for gO, gO in ipairs(_O.m) do
          jO[#jO + 1] = j[gO] or gO
        end
        local gO = {("x%.2f"):format(_O.s), "<font color=\"#14FF00\">$" .. (O(_O.v) .. "/s</font>")}
        if #jO > 0 then
          gO[#gO + 1] = table.concat(jO, " ")
        end
        lO.rich[#lO.rich + 1] = {v = uO, t = _O.n .. ((rO[2].Placement and "  (pen)") or ""), img = PO(_O.cat), sub = Y[_O.r] or "?", note = table.concat(gO, "  \194\183  "), grad = F(_O.cat), col = k(_O.cat)}
      end
      hO = lO
      return hO
    end
    local lO, uO = function()
      return OO().rich
    end, function(jO)
      IO = b(jO) or {}
    end
    local jO = u:Dropdown("Eggs to keep", lO, {}, uO, true)
    local lO = sO({name = "KeepPrune", gap = 5})
    lO.on = function()
      local uO = (next(IO) ~= nil) and ((os.clock() - cO) > 15)
      return uO
    end
    lO.fn = function()
      local lO, uO = OO(), {}
      if #lO == 0 then
        return
      end
      for gO, gO in ipairs(jO.Value or {}) do
        if table.find(lO, gO) then
          uO[#uO + 1] = gO
        end
      end
      if #uO < #(jO.Value or {}) then
        A("keep", function()
          jO:Set(uO)
        end)
      end
    end
    u:Slider("Min value /s", 0, 0, 0, function(lO)
      YO = ((lO > 0) and lO) or nil
      o()
    end, "log")
    Shared.Core.protect = function(lO, uO)
      if next(IO) then
        local jO = IO
        if jO[OO()[lO] or ""] then
          return true
        end
      end
      lO = ((YO ~= nil) and (type(uO) == "table")) and (r(uO).v >= YO)
      return lO
    end
  end
  do
    local IO = {Boss = "Fractured", Scrambled = "Scrambled", Enchanted = "Enchanted", Nitro = "Nitro", Spectral = "Spectral"}
    local YO = sO({name = "Mutate", mover = true, gap = 1, pri = 3, soft = true, bad = {}})
    tO = LO.Mutate:Section("Auto mutate", "wand")
    m(tO, "Auto mutate", "mutate", false, function(lO)
      if not (lO) then
        qO(YO)
      end
    end)
    local lO, uO = X("mst", tO:Text("Off")), {Boss = true, Scrambled = true, Enchanted = true, Nitro = true, Spectral = true}
    local jO = tO:Dropdown("Use items", {"Fractured", "Scrambled", "Enchanted", "Nitro", "Spectral"}, {"Fractured", "Scrambled", "Enchanted", "Nitro", "Spectral"}, function(gO)
      for OO, hO in next, IO, nil do
        uO[OO] = table.find(gO, hO) ~= nil
      end
    end, true)
    task.delay(5, function()
      local gO, OO = next, {Nitro = "VenyxSAE_nitro.txt", Spectral = "VenyxSAE_spectral.txt"}
      for hO, RO in gO, OO, nil do
        if Shared.Alive and not (pcall(isfile, RO) and isfile(RO)) then
          local gO = uO[hO]
          if if gO then not gO else next(uO) then
            local gO = table.clone(jO.Value or {})
            gO[#gO + 1] = IO[hO]
            A("add" .. hO, function()
              jO:Set(gO)
            end)
          end
          pcall(writefile, RO, "1")
        end
      end
    end)
    x(tO, "Mutate first", "mutFirst", {"Best value", "Best rarity", "Biggest"}, "Best value")
    u = LO.Mutate:Section("Mutate filter", "target")
    local jO, gO = fO(u, {rar = Y, sp = "Only these eggs", minV = "Min value /s", list = Shared.Core.allSp}), {}
    local OO, hO = {"Rainbow", "Golden", "Silver", "Fractured", "Scrambled", "Enchanted", "Nitro", "Spectral", "Bloom", "Spirit Bloom", "Parasite"}, function(RO)
      gO = b(RO, w) or {}
      o()
    end
    u:Dropdown("Skip eggs with", OO, {}, hO, true)
    local w = u:Stats({{"Fractured", V.fractured}, {"Scrambled", V.scramble}, {"Enchanted", V.essence}, {"Nitro", V.nitro}, {"Spectral", V.luck}})
    local function o()
      local OO, hO, RO, _O, rO, VO = {}, {Boss = 0, Scrambled = 0, Enchanted = 0, Nitro = 0, Spectral = 0}, ipairs, {}, Shared.LocalPlayer, Shared.LocalPlayer
      f:yT(_O, 0, rO.Character or (Q()), VO.Character and (Q()))
      for rO, rO in RO(_O) do
        for RO, _O in ipairs((rO and rO:GetChildren()) or {}) do
          if _O:IsA("Tool") then
            if _O:GetAttribute("ItemType") == "MutationConsumable" then
              RO = (_O:GetAttribute("MutationId") or _O:GetAttribute("MutationTemplate")) or "Boss"
              OO[RO] = OO[RO] or _O
              hO[RO] = (hO[RO] or 0) + ((tonumber(_O:GetAttribute("Uses")) or tonumber(_O.Name:match("%[X(%d+)%]"))) or 1)
            end
          end
        end
      end
      return OO, hO
    end
    local OO = sO({name = "Bag", gap = 2, info = true})
    OO.on = function()
      return BO("Farm")
    end
    OO.fn = function()
      local OO, OO = o()
      E("bag", w, {Fractured = tostring(OO.Boss), Scrambled = tostring(OO.Scrambled), Enchanted = tostring(OO.Enchanted), Nitro = tostring(OO.Nitro), Spectral = tostring(OO.Spectral)})
    end
    local function w(OO)
      OO = OO or (o())
      if not (next(OO)) then
        lO("No mutation items in your bag")
        return
      end
      local hO, RO, _O = {}, pairs, f[53](D())
      for rO, VO in RO(f:uT(_O)) do
        local RO, kO = (type(VO) == "table") and VO.Placement
        if RO then
          local FO = Shared.Core
          kO = not FO.reserved[rO]
        else
          kO = RO
        end
        if kO then
          local kO, FO = r(VO), ipairs
          local VO, QO = kO.m, false
          for DO, DO in FO(VO) do
            QO = QO or (gO[DO] == true)
          end
          RO = Shared.s63
          if RO(jO, kO) and not QO then
            for jO, gO in next, OO, nil do
              if uO[jO] then
                if not (kO.ms[jO]) then
                  if (YO.bad[rO .. jO] or 0) < os.clock() then
                    kO.uid = rO
                    kO.k = jO
                    kO.tool = gO
                    hO[#hO + 1] = kO
                    break
                  end
                end
              end
            end
          end
        end
      end
      if #hO == 0 then
        lO("Every egg that fits already has these mutations")
        return
      end
      lO(#hO .. " egg(s) can be mutated")
      _O = Shared.s21
      return zO(hO, _O.mutFirst)[1]
    end
    local zO = sO({name = "MutateInfo", gap = 2, info = true})
    zO.on = function()
      return BO("Farm")
    end
    zO.fn = function()
      w()
    end
    YO.want = function()
      local zO = w(o())
      if not (zO) then
        YO.at = os.clock() + 5
      end
      return zO
    end
    local o = {Boss = 10, Scrambled = 10, Nitro = 10, Enchanted = 100, Spectral = 25}
    pcall(function()
      local zO, uO = a.Shared:FindFirstChild("BossMasteryFlags", true), a.Shared:FindFirstChild("ScrambleMutationFlags", true)
      o.Boss = require(zO).MutationConsumableSuccessPercent:Get()
      o.Nitro = o.Boss
      o.Scrambled = require(uO).SuccessPercent:Get()
    end)
    local function zO(uO, jO)
      local gO, OO = vO(uO.uid), Shared.Core
      local hO = OO.eggPos(uO.uid)
      if gO then
      else
        if hO then
          lO("Going to " .. uO.n)
          OO = Shared.Vec3
          if not (aO(hO + OO(0, 3, 4), jO)) then
            return
          end
          local RO = gO
          for _O = 1, 15, 1 do
            RO = vO(uO.uid)
            if RO then
              break
            end
            task.wait(0.2)
          end
          gO = RO
        else
        end
      end
      if not (gO) then
        YO.bad[uO.uid .. uO.k] = os.clock() + 30
        return lO(uO.n .. " is not in your pen")
      end
      hO = Shared.Core
      if not (hO.needBody()) then
        return lO("Turning visible to use " .. IO[uO.k])
      end
      lO("Mutating " .. (uO.n .. (" with " .. IO[uO.k])))
      hO = Shared.s10
      hO("Mutating " .. uO.n)
      OO, hO = Shared.Vec3, gO:GetPivot().Position + Shared.Vec3(0, 3, 4)
      if not (aO(hO, jO)) then
        return
      end
      hO = Shared.s8
      jO = hO()
      if jO then
        pcall(jO.EquipTool, jO, uO.tool)
      end
      hO = Shared.LocalPlayer
      if uO.tool.Parent ~= hO.Character then
        pcall(function()
          local gO
          gO, uO.tool.Parent = Shared.LocalPlayer, Shared.LocalPlayer.Character
        end)
      end
      task.wait(0.3)
      local gO, OO = os.clock(), Shared.Invoke
      local hO, RO = OO("RF/BossMastery/AskUseMutationConsumable", uO.uid)
      if (hO and (type(RO) == "table")) and RO.Success then
        if RO.Mutated then
          lO(uO.n .. (" got " .. IO[uO.k]))
          W("Mutated", uO.n .. (" got " .. IO[uO.k]), "ok")
        else
          lO(("%s roll missed on %s (%s%% chance)"):format(IO[uO.k], uO.n, tostring(o[uO.k] or "?")))
        end
      else
        YO.bad[uO.uid .. uO.k] = os.clock() + 600
        lO(("%s refused on %s: %s"):format(IO[uO.k], uO.n, ((type(RO) == "table") and tostring(RO.Message or "no reason")) or "no answer"))
      end
      task.wait(math.max(0, 1 - (os.clock() - gO)))
      if jO then
        pcall(jO.UnequipTools, jO)
      end
      return true
    end
    YO.run = function(o, IO)
      local lO
      while o and (IO()) do
        lO = zO(o, IO)
        o = (lO and IO()) and w()
      end
      return lO
    end
    YO.on = function()
      local w = Shared.s21
      return w.mutate
    end
  end
  do
    local w = sO({name = "Treadmill", mover = true, gap = 2, pri = 9, soft = true})
    u = LO.Treadmill:Section("Treadmill", "gauge")
    m(u, "Auto treadmill", "tread", false, function(o)
      if not (o) then
        qO(w)
      end
    end)
    m(Shared.Core.adminSec, "Admin treadmill", "adminTread", false, function(o)
      if not (o) then
        qO(w)
      end
    end)
    m(u, "Auto upgrade treadmill", "upTread", false)
    local o, IO, zO, YO, lO = u:Stats({{"Speed power", "rbxassetid://78137530993637"}, {"Cash", V.money}}), 0, 0, 0
    local function uO()
      IO = os.clock()
      local jO = Shared.Core
      jO.treadAt = IO
      jO = Shared.Core
      if jO.onAdmin then
        YO = 0
      end
    end
    local jO = sO({name = "SpeedInfo", gap = 1, info = true})
    jO.on = function()
      return true
    end
    jO.fn = function()
      local jO = Shared.s59
      local gO = jO()
      jO = gO and tonumber(gO.Money)
      E("tst", o, {["Speed power"] = (gO and O(gO.SpeedPower)) or "--", Cash = (jO and ("$" .. O(jO))) or "--"})
      gO = Shared.LocalPlayer
      jO = gO:FindFirstChild("leaderstats")
      jO = jO and (jO:FindFirstChild("Speed"))
      jO = jO and tonumber(jO.Value)
      if jO then
        if lO then
          if jO > lO then
            uO()
          end
        end
      end
      lO = jO
    end
    local function o()
      local lO, jO = workspace:FindFirstChild("AdminTreadmill"), Shared.s21
      local gO = jO.adminTread and (lO or nO())
      if gO then
        jO = lO and (lO:FindFirstChild("Pad") or lO:FindFirstChildWhichIsA("BasePart", true))
        local OO, hO = jO and jO.Position
        if OO then
          hO = OO
        else
          local OO = Shared.Vec3
          hO = (OO(540.05, 68.6, -369.7))
        end
        return hO, true
      end
      gO = Shared.s58
      jO, lO = gO(), Shared.s21
      local OO, hO = (lO.tread and jO) and jO.PlotFolder:FindFirstChild("TreadmillBottom")
      if OO then
        gO = Shared.Vec3
        hO = gO(OO.Position.X, 72, OO.Position.Z)
      else
        hO = OO
      end
      return hO
    end
    local lO, jO = n:FindFirstChild("RE/Treadmill/SpeedGained"), n:FindFirstChild("RE/Treadmill/AssignedBeltShifted")
    if lO then
      U(lO.OnClientEvent, uO)
    end
    if jO then
      U(jO.OnClientEvent, function(lO, uO, gO, OO, hO, hO)
        uO = Shared.Core
        gO, OO = uO.onAdmin, Shared.Core
        OO.onAdmin = (lO ~= nil) and (hO == true)
        if gO then
          hO = Shared.Core
          if not (hO.onAdmin) then
            OO = Shared.s21
            if not (OO.tread) then
              if not (nO()) then
                task.spawn(Shared.Invoke, "RF/Treadmill/AskDoff")
              end
            end
          end
        end
      end)
    end
    w.want = function()
      local lO = Shared.s16
      local uO, gO, OO = lO(), o()
      if uO then
        if not (gO) then
          return
        end
      else
        return
      end
      if OO then
        lO = Shared.Core
        local OO = lO.onAdmin
        local lO = ((if OO then (os.clock() - IO) > 5 else not OO) and gO) or nil
        return lO
      end
      if uO.Anchored then
        return
      elseif (os.clock() - IO) < 3 then
        return
      end
      return gO
    end
    w.run = function(lO, uO)
      local gO, gO = o()
      if gO then
        local o = Shared.Core
        if o.onAdmin then
          YO += 1
          if YO >= 3 then
            local o = Shared.Core
            if o.respawn then
              YO = 0
              local o = Shared.s10
              o("Admin treadmill will not take you, respawning", "warn")
              o = Shared.Core
              return o.respawn()
            end
          end
          local o = Shared.s10
          o("Admin treadmill speed is not going up, getting back on", "warn")
          if not (Shared.s14(uO)) then
            return
          end
        end
      end
      local o = Shared.s10
      o((gO and "Going to the admin treadmill") or "Going to the treadmill")
      o = Shared.Vec3
      if not (aO(lO + o(0, 1, 0), uO)) then
        return
      end
      lO, o = Shared.Core, Shared.Core
      lO.hold = (o.hold or 0) + 1
      lO = os.clock() + ((gO and 2.5) or 3)
      IO = 0
      o = false
      while ((os.clock() < lO) and (uO())) and not o do
        if gO then
          local YO = Shared.Core
          o = YO.onAdmin == true
          if o then
          else
            if os.clock() > (lO - 0.1) then
              YO = Shared.Invoke
              local OO, hO, RO = YO("RF/Treadmill/AskWearStill")
              local _O, rO, VO = ((OO and ((hO == true) or ((type(RO) == "string") and RO:lower():find("already")))) and true) or false, Shared.Core, Shared.Core
              rO.onAdmin = VO.onAdmin or _O
              o = _O
            else
            end
          end
          if not o then
            YO = Shared.WaitHeartbeat
            YO()
          end
        else
          local YO = Shared.Invoke
          local OO, hO, RO = YO("RF/Treadmill/AskWearStill")
          YO = Shared.s16
          local _O = YO()
          YO = (_O and _O.Anchored) or (OO and ((hO == true) or ((type(RO) == "string") and RO:lower():find("already"))))
          o = YO or ((os.clock() - IO) < 3)
          if not o then
            task.wait(0.3)
          end
        end
      end
      lO = Shared.Core
      lO.hold = lO.hold - 1
      if not (uO()) then
        lO = Shared.s14
        return lO(function()
          return true
        end)
      end
      if o then
        zO = 0
        if gO then
          IO = os.clock()
        end
        lO = Shared.s10
        return lO((gO and "Training on the admin treadmill") or "Training speed", "ok")
      end
      zO += 1
      if zO >= 2 then
        gO = Shared.Core
        if gO.respawn then
          zO = 0
          uO = Shared.s10
          uO("Treadmill will not take you, respawning", "warn")
          lO = Shared.Core
          lO.respawn()
        end
      end
    end
    w.on = function()
      local w = Shared.s21
      local o, IO = w.tread
      if o then
        IO = o
      else
        w = Shared.s21
        IO = w.adminTread and (nO() or (workspace:FindFirstChild("AdminTreadmill") ~= nil))
      end
      return IO
    end
    jO = LO.Treadmill:Section("Progress", "crown")
    m(jO, "Auto upgrade base", "upBase", false)
    m(jO, "Auto buy trails", "trails", false)
    m(jO, "Auto claim offline cash", "claimCash", false)
    m(jO, "Auto claim index rewards", "claimIndex", false)
    local w = sO({name = "Progress", gap = 5, fail = {}})
    w.on = function()
      local o = Shared.s21
      local nO, IO = o.claimCash
      if nO then
        IO = nO
      else
        o = Shared.s21
        IO = o.claimIndex
      end
      o = nil
      if IO then
        o = IO
      else
        nO = Shared.s21
        o = nO.upBase
      end
      IO = nil
      if o then
        IO = o
      else
        nO = Shared.s21
        IO = nO.upTread
      end
      o = nil
      if IO then
        o = IO
      else
        nO = Shared.s21
        o = nO.trails
      end
      return o
    end
    local o = {{"LimitedEgg", "GravityDisruptor", "LimitedEgg", "MechaReroll"}, {"BrainrotEgg", "BeeLauncher", "BrainrotEgg"}, {"MonsterEgg", "BeeLauncher", "MonsterEgg", "Mecha"}}
    w.fn = function()
      local nO = Shared.s59
      local IO = nO()
      if not (IO) then
        return
      end
      local zO, YO = tonumber(IO.Money) or 0, Shared.s21
      if YO.claimCash then
        nO = Shared.Invoke
        local lO, uO = nO("RF/AwayEarnings/FetchSummary")
        if lO then
          if type(uO) == "table" then
            local lO = tonumber(uO.ClaimableAmount)
            if lO then
              if lO > 0 then
                local lO = Shared.Invoke
                lO("RF/AwayEarnings/AskCollect", {Kind = "Claim"})
              end
            end
          end
        end
      end
      nO = Shared.s21
      if nO.claimIndex then
        local lO, uO, jO = ((type(IO.Index) == "table") and IO.Index) or {}, ((type(IO.IndexClaimedCategories) == "table") and IO.IndexClaimedCategories) or {}, next
        for gO, OO in jO, lO, nil do
          if OO == true then
            if uO[gO] ~= true then
              YO = Shared.Invoke
              YO("RF/Codex/AskRedeemAll")
              break
            end
          end
        end
        jO, uO = ((type(IO.GearInventory) == "table") and IO.GearInventory) or {}, ipairs
        for gO, OO in uO(o) do
          if ((w.fail[OO[1]] or 0) < os.clock()) and ((tonumber(jO[OO[2]]) or 0) <= 0) then
            gO = a.Data:FindFirstChild(OO[3])
            local o, uO = pcall(require, gO)
            local jO, gO = true, false
            if o then
              if type(uO) == "table" then
                local o, hO, RO, _O = ipairs, {}, uO.Entries, OO[4] and (uO[OO[4] .. "Entries"] or ((type(uO[OO[4]]) == "table") and uO[OO[4]].Entries))
                f:yT(hO, 0, RO, _O)
                _O, RO = gO, jO
                for uO, uO in o(hO) do
                  for o, o in ipairs(((type(uO) == "table") and uO) or {}) do
                    _O, RO = true, if lO[o.AssetId] then RO else false
                  end
                end
                if _O then
                  if RO then
                    w.fail[OO[1]] = os.clock() + 60
                    hO = Shared.Invoke
                    hO("RF/Codex/AskRedeemLimitedEgg", OO[1])
                  end
                end
              end
            end
          end
        end
      end
      nO = Shared.s21
      if nO.upBase then
        YO = Shared.Modules
        local o, lO = YO.Bases, tonumber(IO.BaseUpgradeLevel) or 1
        local uO, jO = (o and o.BASES) and o.BASES[lO + 1], Shared.Fire
        o = jO("Bases", "GetMaxBaseLevel")
        if uO then
          if zO >= (tonumber(uO.Cost) or math.huge) then
            if o then
              if lO < o then
                t("RE/Homestead/AskBaseTierRaise")
                return
              end
            else
              t("RE/Homestead/AskBaseTierRaise")
              return
            end
          end
        end
      end
      nO = Shared.s21
      if nO.upTread then
        YO = Shared.Fire
        local o = YO("Tread", "GetByUpgradeLevel", (tonumber(IO.TreadmillUpgradeLevel) or 0) + 1)
        if type(o) == "table" then
          if o._id then
            if zO >= (tonumber(o.Price) or math.huge) then
              local lO = Shared.Invoke
              lO("RF/Treadmill/AskTierRaise", o._id)
              return
            end
          end
        end
      end
      nO = Shared.s21
      if nO.trails then
        local o, nO, lO = ((type(IO.TrailInventory) == "table") and IO.TrailInventory) or {}, next, Shared.Modules
        local IO, uO = lO.Trails
        if IO then
          YO = Shared.Modules
          uO = YO.Trails.Directory
        else
          uO = IO
        end
        IO = nil
        for YO, jO in nO, uO or {}, nil do
          lO = (type(jO) == "table") and tonumber(jO.Price)
          YO = ((type(jO) == "table") and jO._id) or YO
          IO = if lO then if lO <= zO then if o[YO] ~= true then if w.fail[YO] then IO else if IO then if lO < IO[2] then {YO, lO} else IO else {YO, lO} else IO else IO else IO
        end
        if IO then
          uO = Shared.s68
          if not (uO("RF/Trailwear/AskPurchase", IO[1])) then
            w.fail[IO[1]] = true
          end
        end
      end
    end
  end
  Shared.s61 = function(w, o)
    local nO, IO, zO, YO = h(w), HO(), {}, {}
    for HO, lO in next, ((type(w.Inventory) == "table") and w.Inventory) or {}, nil do
      if type(lO) == "table" then
        if not (lO.InFuse) then
          if not (lO.IsFavorite) then
            if not (nO[HO]) then
              local uO = r(lO)
              uO.uid = HO
              zO[#zO + 1] = uO
            end
          end
        end
      end
    end
    nO, w = pairs, (o and {}) or D()
    for HO, lO in nO(w) do
      if type(lO) == "table" then
        if not (lO.Placement) then
          if HO ~= IO then
            o = Shared.Core
            if not (o.reserved[HO]) then
              local w = Shared.Core
              if not (w.protect(HO, lO)) then
                local w = r(lO)
                w.uid = HO
                YO[#YO + 1] = w
              end
            end
          end
        end
      end
    end
    return zO, YO
  end
  do
    local w = sO({name = "Sell", gap = 5, info = true})
    local function o(nO, HO, IO, zO, YO, lO)
      local uO = LO.Sell:Section(nO, HO, zO)
      m(uO, "Auto sell " .. nO:lower(), IO, false)
      HO, zO, nO = uO:Text("--"), {rar = YO or {"Common", "Uncommon", "Rare"}, rarName = "Sell rarities", no = "Never sell", mut = "Only mutations", maxV = "Only below /s"}
      if lO then
        nO = lO
      else
        YO = Shared.Core
        nO = YO.allSp
      end
      zO.list = nO
      nO = fO(uO, zO)
      m(uO, "Keep mutated", IO .. "Keep", true)
      return nO, HO, uO
    end
    local nO, HO, IO = o("Pets", "coins", "sellPets", 1)
    local zO, YO, lO = o("Eggs", "egg", "sellEggs", 2)
    local function o(uO, jO, gO)
      local OO = {}
      if not (jO.rar) then
        return OO
      end
      local hO = ipairs
      for RO, _O in hO(uO) do
        RO = Shared.s63
        if RO(jO, _O) then
          local uO = Shared.s21
          if uO[gO] then
            if not (#_O.m > 0) then
              OO[#OO + 1] = _O.uid
            end
          else
            OO[#OO + 1] = _O.uid
          end
        end
      end
      return OO
    end
    local function uO(jO)
      local gO = Shared.s59
      local OO = gO()
      if not (OO) then
        return 0, 0
      end
      gO = Shared.s61
      local hO, RO = gO(OO)
      gO, OO = o(hO, nO, "sellPetsKeep"), o(RO, zO, "sellEggsKeep")
      local o = #gO
      local nO = #OO
      A("sellTx", function()
        HO:Set(o .. " pet(s) match")
        YO:Set(nO .. " egg(s) match")
      end)
      if jO then
        if jO == "pets" then
          OO = {}
        else
          gO = {}
        end
      else
        RO, hO = Shared.s21, Shared.s21
        gO, OO = if RO.sellPets then gO else {}, if hO.sellEggs then OO else {}
      end
      for o = 1, math.max(#gO, #OO), 50 do
        t("RE/PetSatchel/SellSelection", {Eggs = {table.unpack(OO, o, math.min(o + 49, #OO))}, Assets = {table.unpack(gO, o, math.min(o + 49, #gO))}})
        task.wait(0.3)
      end
      return #gO, #OO
    end
    w.on = function()
      local o = Shared.s21
      local nO, HO = o.sellPets
      if nO then
        HO = nO
      else
        o = Shared.s21
        HO = o.sellEggs
      end
      return HO or (BO("Farm"))
    end
    w.fn = uO
    IO:Button("Sell matching pets now", "Sell", function()
      task.spawn(function()
        local w = uO("pets")
        W("Sold", w .. " pet(s)", ((w > 0) and "ok") or "info")
      end)
    end, "gold")
    lO:Button("Sell matching eggs now", "Sell", function()
      task.spawn(function()
        local w, w = uO("eggs")
        W("Sold", w .. " egg(s)", ((w > 0) and "ok") or "info")
      end)
    end, "gold")
  end
  do
    local w = sO({name = "Favorite", gap = 3, pend = {}})
    tO = LO.Sell:Section("Favorite", "star", 2)
    m(tO, "Auto favorite", "fav", false)
    x(tO, "Match", "favMatch", {"All picked rules", "Any picked rule"}, "All picked rules")
    local o, nO = fO(tO, {rar = {}, mut = "Mutations", minV = "Min value /s"}), {}
    local function HO(IO)
      nO = b(IO) or {}
    end
    tO:Dropdown("Always favorite", e, {}, HO, true)
    m(tO, "Favorite equipped", "favEq", false)
    m(tO, "Unfavorite pets not matching", "unfav", false)
    w.on = function()
      local HO = Shared.s21
      local IO, zO = HO.fav
      if IO then
        zO = IO
      else
        HO = Shared.s21
        zO = HO.favEq
      end
      IO = nil
      if zO then
        IO = zO
      else
        HO = Shared.s21
        IO = HO.unfav
      end
      return IO
    end
    local function HO(IO)
      local zO, YO, lO = nO, IO.n
      if YO then
        lO = YO
      else
        local uO = Shared.s67
        lO = uO(IO.cat)
      end
      if zO[lO] then
        return true
      end
      zO, YO = 0, 0
      if o.rar then
        zO, YO = 1, YO + ((o.rar[IO.r] and 1) or 0)
      else
      end
      if o.mut then
        lO = Shared.s63
        zO, YO = zO + 1, YO + ((lO({mut = o.mut}, IO) and 1) or 0)
      else
      end
      lO = o.minV
      if lO then
        if lO > 0 then
          local uO, jO = zO + 1, YO + (((IO.v >= o.minV) and 1) or 0)
          zO, YO = uO, jO
        else
        end
      else
      end
      lO, IO = zO > 0
      if lO then
        local uO = Shared.s21
        IO = ((uO.favMatch == "Any picked rule") and (YO > 0)) or (YO == zO)
      else
        IO = lO
      end
      return IO
    end
    w.fn = function()
      local IO = Shared.s59
      local zO = IO()
      if not (zO) then
        return
      end
      local YO, lO, uO, jO, gO = h(zO), ((o.rar or o.mut) or ((o.minV or 0) > 0)) or (next(nO) ~= nil), next, ((type(zO.Inventory) == "table") and zO.Inventory) or {}, 0
      for o, nO in uO, jO, nil do
        if gO >= 25 then
          break
        end
        if type(nO) == "table" then
          if (w.pend[o] or 0) < os.clock() then
            IO = Shared.s21
            local uO, jO = IO.favEq and YO[o]
            if uO then
              jO = uO
            else
              zO = Shared.s21
              local IO, OO = zO.fav
              if IO then
                OO = IO
              else
                local IO = Shared.s21
                OO = IO.unfav
              end
              jO = OO and HO(r(nO))
            end
            uO = nil
            local HO = nO.IsFavorite
            local IO, zO = not HO
            if HO then
              zO = IO
            else
              local IO = Shared.s21
              local OO = IO.favEq and YO[o]
              if OO then
                zO = OO
              else
                IO = Shared.s21
                zO = IO.fav and jO
              end
            end
            if zO then
              uO = true
            else
              if nO.IsFavorite then
                HO = Shared.s21
                uO = if HO.unfav then if lO then if jO then uO else false else uO else uO
              else
              end
            end
            if uO ~= nil then
              zO = gO + 1
              w.pend[o] = os.clock() + 4
              t("RE/PetSatchel/WriteFavourite", o, uO)
              task.wait(0.12)
              gO = zO
            else
            end
          else
          end
        else
        end
      end
    end
  end
  do
    local w = sO({name = "Fuse", gap = 2, bad = {}, info = true})
    Shared.s62 = w
    u = LO.Fuse:Section("Fuse machine", "flame")
    m(u, "Auto fuse", "fuse", false)
    local w = X("fuseTx", u:Text("--"))
    Shared.s66 = w
    x(u, "Fuse first", "fuseFirst", {"Lowest rarity", "Highest rarity", "Most copies", "Lowest value"}, "Lowest rarity")
    x(u, "Use pets", "fuseUse", {"Lowest value first", "Highest value first"}, "Lowest value first")
    m(u, "Skip mutated", "fuseKeep", true)
    m(u, "Eject odd pets", "fuseEject", true)
    local w, o = fO(LO.Fuse:Section("Fuse filter", "target"), {rar = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic"}, sp = "Only these pets", no = "Never fuse", maxV = "Only below /s", list = Shared.Core.allSp}), {["Lowest rarity"] = function(nO)
      return (-nO.r * 1000) + #nO
    end, ["Highest rarity"] = function(nO)
      return (nO.r * 1000) + #nO
    end, ["Most copies"] = function(nO)
      return #nO
    end, ["Lowest value"] = function(nO)
      return -nO.v
    end}
    Shared.s64 = w
    Shared.s65 = o
    Shared.s62.on = function()
      local w = Shared.s21
      return w.fuse or BO("Farm")
    end
    Shared.s62.fn = f:QT(17, 18, {[59] = q, [21] = q, [28] = q, [60] = q, [61] = q, [62] = q, [63] = q, [64] = q, [65] = q, [66] = q, [67] = q, [30] = q, [68] = q}, p, y, nil)
  end
  do
    tO = LO.Fuse:Section("Fuse predictor", "sparkles")
    pO(tO)
    local w, o, nO = tO:Stats({{"Slots", V.pet}, {"Status", V.tread}, {"Likely size", V.x2}, {"Chance", V.luck}, {"Value", V.money}, {"Best case", V.medal}}), {{0.85, 1.05, 2000}, {1.45, 1.55, 250}, {1.9, 2.1, 125}, {2.85, 3.15, 62.5}, {3.8, 4.2, 31.25}, {0.3, 0.45, 18}, {0.1, 0.2, 5}, {5.8, 6.2, 15.625}, {9.5, 12.5, 3}, {12, 17, 0.05}, {20, 35, 0.0001}}
    local function HO()
      if nO then
        local IO = nO
        return IO
      end
      nO = o
      pcall(function()
        local o, IO, IO, zO = next, Shared.Modules, debug.getupvalues(Shared.Modules.Rec.DrawAssetScale)
        for YO, lO in o, IO, zO do
          if (((type(lO) == "table") and (type(lO[1]) == "table")) and lO[1].min) and lO[1].weight then
            nO = {}
            for o, IO in ipairs(lO) do
              YO = nO
              YO[o] = {IO.min, IO.max, IO.weight}
            end
          end
        end
      end)
      local o = nO
      return o
    end
    local o = sO({name = "FusePred", gap = 2, info = true})
    o.on = function()
      return BO("Farm")
    end
    o.fn = function()
      local o = Shared.s59
      local nO = o()
      if not (nO) then
        return
      end
      local IO, zO, YO = ((type(nO.Inventory) == "table") and nO.Inventory) or {}, {}, {}
      for lO, lO in ipairs(((type(nO.FusionSlots) == "table") and nO.FusionSlots) or {}) do
        o = (type(lO) == "string") and IO[lO]
        if type(o) == "table" then
          zO[#zO + 1] = o
        end
      end
      local lO, uO, jO = {Slots = #zO .. " / 3", Status = "Waiting for pets", ["Likely size"] = "--", Chance = "--", Value = "--", ["Best case"] = "--"}, (#zO < 3) and not nO.FusionLocked
      if uO then
        IO = Shared.Core
        jO = IO.fuseNext
      else
        jO = uO
      end
      zO = jO or zO
      for gO, gO in ipairs(zO) do
        YO[#YO + 1] = tonumber(gO.Scale) or 1
      end
      if nO.FusionEggReward then
        lO.Status = "Done, claim the egg"
      elseif nO.FusionLocked then
        o = (tonumber(nO.FusionDuration) or 0) - K()
        lO.Status = ((o > 0) and ("Fusing %dm %02ds"):format(o // 60, o % 60)) or "Fusing"
      end
      if #zO == 3 then
        local gO, OO, hO, RO, _O = ((YO[1] + YO[2]) + YO[3]) / 3, {}, ipairs, f[53](HO()), 0
        for HO, rO in hO(f:uT(RO)) do
          IO, nO = pcall(function()
            local VO = Shared.Modules
            return VO.Fuse.BandWeightBias(YO, rO[1], rO[2])
          end)
          nO = (IO and tonumber(nO)) or math.exp((math.log(gO, 2) * math.log((rO[1] + rO[2]) / 2, 2)) * 0.6)
          HO = rO[3] * nO
          _O += HO
          OO[#OO + 1] = {rO[1], rO[2], HO}
        end
        table.sort(OO, function(nO, HO)
          return nO[3] > HO[3]
        end)
        gO = OO[1]
        for nO, nO in ipairs(OO) do
          gO = if nO[2] > gO[2] then if (nO[3] / _O) > 1e-06 then nO else gO else gO
        end
        hO, o, uO = ipairs, 1
        for nO, HO in hO(zO) do
          RO, nO = ipairs, f[53](R(HO))
          for IO, YO in RO(f:uT(nO)) do
            HO, IO = pcall(function()
              local nO = Shared.Modules
              return nO.Mut.EarningsFor({YO})
            end)
            if HO then
              if tonumber(IO) then
                if IO > o then
                  o, uO = IO, YO
                else
                end
              else
              end
            else
            end
          end
        end
        RO, hO = zO[1].Category, OO[1]
        lO["Likely size"] = ("x%.2f - x%.2f"):format(hO[1], hO[2])
        lO.Chance = ("%.1f%%"):format((hO[3] / _O) * 100)
        lO.Value = "$" .. (O(_(RO, hO[1], {uO})) .. (" - " .. O(_(RO, hO[2], {uO}))))
        lO["Best case"] = ("x%.0f  $%s"):format(gO[2], O(_(RO, gO[2], {uO})))
        if lO.Status == "Waiting for pets" then
          OO = nil
          OO, lO.Status = Shared.s67, ((jO and "Next: ") or "") .. (((uO and ((j[uO] or uO) .. " ")) or "") .. Shared.s67(RO))
        end
      end
      E("fpred", w, lO)
    end
  end
  do
    Shared.s21.eggShow = "All"
    pO = LO["Egg Predictor"]:Section("Egg showcase", "egg", 4)
    local w, o
    x(pO, "Sort eggs", "eggSort", {"Value", "Rarity", "Weight", "Time left"}, "Value")
    local nO, HO = {}, {"Boss", "Scrambled", "Enchanted", "Nitro", "Spectral"}
    for IO, IO in ipairs(HO) do
      nO[#nO + 1] = j[IO]
      nO[j[IO]] = IO
    end
    x(pO, "Calculate mutations", "eggMut", table.clone(nO), {}, function()
      if o then
        task.spawn(o.fn)
      end
    end, true, "Cards show the value with these mutations added")
    local function HO(IO)
      local zO, YO, lO = IO.e, {}, ipairs
      for uO, jO in lO(nO) do
        uO = Shared.s21
        if table.find(uO.eggMut, jO) then
          if not (zO.ms[nO[jO]]) then
            YO[#YO + 1] = nO[jO]
          end
        end
      end
      if #YO == 0 then
        return
      end
      lO = table.concat(YO, ",")
      if not (IO[lO]) then
        local nO = table.clone(zO.m)
        table.move(YO, 1, #YO, #nO + 1, nO)
        IO[lO] = _(zO.cat, zO.s, nO)
      end
      return IO[lO], lO, YO
    end
    local _
    m(pO, "Preview card", "eggCard", true, function(nO)
      if _ then
        _:Card(nO)
      end
    end)
    _ = pO:Showcase(3, {{"All", "grid"}, {"Ready", "sparkles"}, {"Growing", "clock"}, {"In bag", "egg"}}, function(nO)
      local IO = Shared.s21
      IO.eggShow = nO
      if o then
        task.spawn(o.fn)
      end
    end, function(nO)
      task.spawn(function()
        if nO.kind == "Ready" then
          if NO(nO.id) then
            W("Hatched", nO.title, "ok")
          end
        elseif nO.kind == "In bag" then
          local IO = Shared.Core
          IO.wear(nO.id)
        else
          local IO = Shared.Core
          w = IO.eggPos(nO.id)
        end
      end)
    end)
    _:Card(Shared.s21.eggCard)
    local nO = sO({name = "GoTo", mover = true, gap = 0.5, pri = 0, soft = true})
    nO.on = function()
      local IO = w
      return IO ~= nil
    end
    nO.want = function()
      local IO = w
      return IO
    end
    nO.run = function(nO, IO)
      local NO = Shared.Vec3
      aO(nO + NO(0, 3, 4), IO)
      w = nil
    end
    local w = {Ready = "Hatch now", ["In bag"] = "Hold egg", Growing = "Go to egg"}
    o = sO({name = "Eggs", gap = 1})
    o.on = function()
      return BO("Steal")
    end
    local nO = {}
    o.fn = function()
      local o, IO, NO, zO, YO = {}, {All = 0, Ready = 0, Growing = 0, ["In bag"] = 0}, 0, {}, pairs
      local lO = f[53](D())
      for uO, jO in YO(f:uT(lO)) do
        if type(jO) == "table" then
          local gO, OO = ("%s|%s|%s"):format(tostring(jO.AssetCategory or jO.Category), tostring(jO.AssetScale or jO.Scale), table.concat(R(jO), ",")), nO[uO]
          OO = if if OO then OO.k ~= gO else not OO then {k = gO, e = r(jO)} else OO
          zO[uO] = OO
          gO = OO.e
          gO.uid, gO.kind, gO.left = uO, "In bag", math.huge
          gO.pct = 0
          gO.pv, gO.pk, gO.pa = HO(OO)
          if jO.Placement then
            local R = Shared.Fire
            if R("Egg", "IsReadyToHatch", uO) == true then
              gO.kind = "Ready"
              gO.left = 0
              gO.pct = 1
            else
              local R, R = Shared.Fire, tonumber(Shared.Fire("Rec", "GrowthDuration", jO)) or 0
              gO.kind, gO.left = "Growing", N(jO)
              gO.pct = ((R > 0) and math.clamp(1 - (gO.left / R), 0, 1)) or 0
            end
          end
          IO.All = IO.All + 1
          IO[gO.kind] += 1
          NO += gO.v
          o[#o + 1] = gO
        else
        end
      end
      table.sort(o, function(R, HO)
        return (R.pv or R.v) > (HO.pv or HO.v)
      end)
      local R = {}
      nO = zO
      YO = ipairs
      for HO, uO in YO(o) do
        lO, zO = #R < 40
        if lO then
          local jO = Shared.s21
          local gO = jO.eggShow == "All"
          if gO then
            zO = gO
          else
            jO = Shared.s21
            zO = jO.eggShow == uO.kind
          end
        else
          zO = lO
        end
        if zO then
          local jO = nO
          local nO = jO[uO.uid]
          nO.it = nO.it or JO(uO)
          local JO, jO, gO = nO.it, ((uO.kind == "Growing") and v(uO.left)) or nil, uO.pk and ("+" .. uO.pk)
          nO.base = nO.base or JO.muts
          if gO and not nO[gO] then
            nO[gO] = table.clone(nO.base)
            for OO, OO in ipairs(uO.pa) do
              local hO, RO, _O = table.insert, nO[gO], {}
              _O.n = "+" .. j[OO]:upper()
              hO(RO, _O)
            end
          end
          JO.muts, JO.value = (gO and nO[gO]) or nO.base, "$" .. (O(uO.pv or uO.v) .. "/s")
          JO.kind, JO.pct, JO.ready, JO.label, JO.rank, JO.time, JO.r, JO.left = uO.kind, uO.pct, uO.kind == "Ready", w[uO.kind], HO, jO, uO.r, uO.left
          JO.status = (jO and ("GROWING %d%%  \194\183  %s"):format(uO.pct * 100, jO)) or uO.kind:upper()
          R[#R + 1] = JO
        end
      end
      lO = Shared.s21
      zO, o = (lO.eggSort == "Rarity") and "r"
      if zO then
        o = zO
      else
        YO = Shared.s21
        o = (YO.eggSort == "Weight") and "kg"
      end
      local w
      if o then
        w = o
      else
        YO = Shared.s21
        w = (YO.eggSort == "Time left") and "left"
      end
      if w then
        table.sort(R, function(o, nO)
          return (o[w] ~= nO[w]) and ((w == "left") == (o[w] < nO[w]))
        end)
      end
      A("eggs", function()
        _:Set(R, IO, "$" .. (O(NO) .. "/s"))
      end)
    end
  end
  do
    local R, _, w = {"Steal filter eggs", "Shooting Star", "Phantom Express", "Pumpkin Moon", "Butterfly", "Steal wisp eggs", "Wisp", "Steal missing Halloween index", "Steal missing index", "Place", "Mutate", "Butterfly machine", "Ghost Dog quest", "Halloween monsters", "Halloween fishing", "Treadmill"}, {pick = "picked egg", index = "missing index", wisp = "wisp egg", filter = "filter egg"}, {["Steal missing index"] = "Steal:index", ["Steal missing Halloween index"] = "Steal:hwindex", ["Steal wisp eggs"] = "Steal:wisp", ["Steal filter eggs"] = "Steal:filter", ["Shooting Star"] = "Star", Butterfly = "Bloom", Wisp = "WispGo", Mutate = "Mutate", Place = "Place", ["Phantom Express"] = "Train", ["Butterfly machine"] = "Machine", Treadmill = "Treadmill"}
    Shared.Core.rank = {}
    local function o(nO)
      local HO = ipairs
      for IO, JO in HO(nO) do
        local NO = Shared.Core
        NO.rank[w[JO] or ("HW:" .. JO)] = IO
      end
      nO, HO = Shared.Core
      HO, nO.rank["HW:Halloween eggs"] = Shared.Core, Shared.Core.rank["Steal:filter"]
      local w, IO, JO, NO, zO, YO = Shared.Core
      IO, JO, NO, zO, YO, w.rank.Halloween = Shared.Core, Shared.Core, Shared.Core, Shared.Core, Shared.Core, math.min(Shared.Core.rank["HW:Pumpkin Moon"], Shared.Core.rank["HW:Ghost Dog quest"], Shared.Core.rank["HW:Halloween eggs"], Shared.Core.rank["HW:Halloween monsters"], Shared.Core.rank["HW:Halloween fishing"])
      IO, w = Shared.Core, Shared.Core
      IO.hwRank0 = w.rank.Halloween
      HO, nO, IO = Shared.Core
      nO, IO, HO.rank["Steal:pick"], Shared.Core.rank.Combat = Shared.Core, Shared.Core, 0, Shared.Core.rank.Treadmill - 0.5
      NO = Shared.Core
      w, HO = NO.rank, Shared.Core
      JO, nO = (#HO.pick > 0) and 0
      if JO then
        nO = JO
      else
        IO, zO, NO = nil
        IO, zO, NO, nO = Shared.Core, Shared.Core, Shared.Core, math.min(Shared.Core.rank["Steal:index"], Shared.Core.rank["Steal:wisp"], Shared.Core.rank["Steal:filter"])
      end
      w.Steal = nO
    end
    o(R)
    u = LO.Priority:Section("Task order", "sliders")
    u:Text("Top goes first. A carried egg is always delivered first, and before the field opens every task waits in the safe zone.")
    local w = u:Stats({{"Doing", V.tread}, {"Waiting", V.timer}})
    u:Order("Task order", R, function(R)
      o(R)
      R = Shared.Core
      if R.order then
        local R = Shared.Core
        R.order()
      end
    end)
    local R = sO({name = "PrioInfo", gap = 1, info = true})
    R.on = function()
      return BO("Farm")
    end
    R.fn = function()
      local R, o = {}, ipairs
      for nO, nO in o(yO) do
        if nO.mover then
          if nO ~= Shared.s4 then
            if nO.on then
              if nO.on() then
                if nO.name ~= "Stage" then
                  R[#R + 1] = nO.name
                end
              end
            end
          end
        end
      end
      local nO, HO, IO, JO = ((#R == 0) and "Nothing") or (table.concat(R, ", ", 1, math.min(#R, 2)) .. (((#R > 2) and (" +" .. (#R - 2))) or "")), {}, Shared.s4
      if IO then
        R, o = Shared.s4.name == "Steal"
        if R then
          local NO = Shared.Core
          o = NO.stealKind
        else
          o = R
        end
        local NO
        if o then
          local zO = Shared.Core
          NO = "Steal " .. _[zO.stealKind]
        else
          NO = o
        end
        JO = NO or Shared.s4.name
      else
        JO = IO
      end
      IO = nil
      if JO then
        IO = JO
      else
        R = nil
        R, IO = Shared.Core, ((os.clock() - (Shared.Core.treadAt or 0)) < 3) and "Treadmill"
      end
      HO.Doing = IO or "Idle"
      HO.Waiting = nO
      E("prio", w, HO)
    end
  end
  local function R(_)
    local w, o, nO = ipairs, {}, Shared.LocalPlayer
    f:yT(o, 0, nO.Character or (Q()), Q())
    for nO, nO in w(o) do
      for w, w in ipairs((nO and nO:GetChildren()) or {}) do
        if w:IsA("Tool") then
          if _(w) then
            return w
          end
        end
      end
    end
  end
  local _, w = {}, {}
  pcall(function()
    local o = Shared.Modules
    for nO, HO in next, o.Gears.Directory, nil do
      local o = (type(HO) == "table") and HO.BatControllerData
      if (o or (HO.ToolController == "Slap")) or tostring(nO):lower():find("scrambl") then
        _[nO] = (o and tonumber(o.RangeBonus)) or -1
        w[#w + 1] = nO
      end
    end
  end)
  table.sort(w, function(o, nO)
    return (_[o] > _[nO]) or ((_[o] == _[nO]) and (o < nO))
  end)
  Shared.Core.weaponId, Shared.Core.weaponName = {}, {}
  u = ipairs
  for o, nO in u(w) do
    pO = Shared.Modules.Gears.Directory[nO]
    o = ((type(pO) == "table") and pO.DisplayName) or nO
    Shared.Core.weaponName[nO], Shared.Core.weaponId[o] = o, nO
  end
  local function o(nO)
    return nO:GetAttribute("GearName") or nO.Name
  end
  Shared.Core.ownedWeapons = function()
    local nO = Shared.s59
    local HO = nO()
    local IO, JO, NO, zO, YO = (((type(HO) == "table") and (type(HO.GearInventory) == "table")) and table.clone(HO.GearInventory)) or {}, {}, ipairs, {}, Shared.LocalPlayer
    f:yT(zO, 0, YO.Character, Q())
    for HO, HO in NO(zO) do
      for NO, NO in ipairs((HO and HO:GetChildren()) or {}) do
        if NO:IsA("Tool") then
          IO[o(NO)] = true
        end
      end
    end
    zO = ipairs
    for HO, HO in zO(w) do
      if IO[HO] then
        nO = nil
        nO, JO[#JO + 1] = Shared.Core, Shared.Core.weaponName[HO]
      end
    end
    return JO
  end
  local function nO(HO)
    local IO, JO = (_[o(HO)] ~= nil) or (HO:GetAttribute("IsBat") == true)
    if IO then
      JO = IO
    else
      local IO = HO:GetAttribute("ItemType")
      JO = (if IO then not IO else not HO:GetAttribute("GearName")) and ((HO.Name:lower():find("bat") or HO.Name:lower():find("sword")) or HO.Name:lower():find("hammer"))
    end
    return JO
  end
  Shared.Core.scrambler = function(HO)
    return HO and (_[o(HO)] == -1)
  end
  local function HO(IO)
    return K() >= (tonumber(IO:GetAttribute("CooldownEndTime")) or 0)
  end
  local IO = {i = 1, at = 0}
  Shared.Core.bat = function()
    local JO, NO, zO, YO = {}, ipairs, {}, Shared.LocalPlayer
    f:yT(zO, 0, YO.Character or (Q()), Q())
    YO = nil
    local lO = -2
    for uO, jO in NO(zO) do
      local zO, gO = ipairs, (jO and jO:GetChildren()) or {}
      for OO, hO in zO(gO) do
        if hO:IsA("Tool") then
          if nO(hO) then
            OO, uO = _[o(hO)] or 0, Shared.s21
            if uO.weap then
              jO = Shared.s21
              if jO.weap[o(hO)] then
                if not (JO[o(hO)]) then
                  JO[o(hO)] = hO
                end
              end
            end
            if OO >= 0 then
              if YO then
                if OO > lO then
                  YO, lO = hO, OO
                else
                end
              else
                YO, lO = hO, OO
              end
            else
            end
          else
          end
        else
        end
      end
    end
    NO = {}
    for nO, nO in ipairs(w) do
      if JO[nO] then
        NO[#NO + 1] = JO[nO]
      end
    end
    if #NO == 0 then
      return YO, math.max(lO, 0)
    end
    if #NO > 1 then
      if IO.i > #NO then
        IO.i = 1
      end
      local w, nO, nO, JO = (IO.i % #NO) + 1, Shared.s21, (os.clock() - IO.at) >= (Shared.s21.swapT or 0.35)
      if nO then
        JO = nO
      else
        YO = HO(NO[IO.i])
        JO = if YO then not YO else HO(NO[w])
      end
      if JO then
        IO.i, IO.at = w, os.clock()
      end
    else
      IO.i = 1
    end
    YO = NO[IO.i]
    return YO, math.max(_[o(YO)] or 0, 0)
  end
  do
    local _, w = {Radiant = "Golden", Amethyst = "Purple", Sapphire = "Blue", Emerald = "Green"}, {Green = 1, Blue = 2, Purple = 3, Golden = 4}
    local nO = sO({name = "Bloom", mover = true, gap = 1, pri = 5, soft = true})
    u = LO.Butterfly:Section("Butterfly bloom", "wind")
    m(u, "Auto butterfly bloom", "bloom", false, function(HO)
      if not (HO) then
        qO(nO)
      end
    end)
    local HO, IO = u:Text("Off"), u:Stats({{"Emerald", V.Green}, {"Sapphire", V.Blue}, {"Amethyst", V.Purple}, {"Radiant", V.Golden}, {"Essence", V.essence}, {"Caught", V.net}})
    x(u, "Catch mode", "bfMode", {"Stand", "Patrol", "Circle", "Chase"}, "Stand")
    x(u, "Catch priority", "bfPri", {"Rarest", "Nearest"}, "Rarest")
    local JO = {Golden = true, Purple = true, Blue = true, Green = true}
    u:Dropdown("Catch", {"Radiant", "Amethyst", "Sapphire", "Emerald"}, {"Radiant", "Amethyst", "Sapphire", "Emerald"}, function(NO)
      JO = b(NO, _) or {}
    end, true)
    S(u, "Catch speed", "bfSpeed", 100, 600, 400, "", 10)
    local NO, zO = {}, {"Spawned", "Escaped"}
    for YO, lO in ipairs(zO) do
      YO = n:FindFirstChild("RE/Butterflies/" .. lO)
      if YO then
        U(YO.OnClientEvent, function(YO, lO)
          local uO = ((type(YO) == "table") and YO) or ((type(lO) == "table") and lO)
          if uO then
            if uO.Id then
              NO[uO.Id] = uO
            end
          end
        end)
      end
    end
    tO = n:FindFirstChild("RE/Butterflies/Removed")
    if tO then
      U(tO.OnClientEvent, function(YO)
        NO[YO] = nil
      end)
    end
    local YO, lO, uO, jO = 14, 0, 1800, 900
    pcall(function()
      local gO = require(a.Shared.Flags.ButterflyFlags)
      local OO, hO, RO = tonumber(gO.NetReach:Get()) or YO, tonumber(gO.IntervalSeconds:Get()) or uO, tonumber(gO.OffsetSeconds:Get()) or jO
      YO, uO, jO = OO, hO, RO
    end)
    local function gO()
      local OO = tonumber(workspace:GetAttribute("ButterflyBloomEndsAt"))
      return (workspace:GetAttribute("Event_ButterflyBloom") == true) and (if OO then K() < OO else not OO)
    end
    local function OO()
      local hO = tonumber(workspace:GetAttribute("ButterflyBloomEndsAt"))
      return math.min((hO and (hO - K())) or math.huge, T())
    end
    local function hO()
      local RO = Shared.s16
      local _O, rO, VO = RO(), OO() > 25
      if rO then
        VO = rO
      else
        if _O then
          RO = nil
          RO, VO = Shared.Vec3, (_O.Position - Shared.Vec3(6700, 74, -364)).Magnitude < 300
        else
          VO = _O
        end
      end
      return VO
    end
    Shared.Core.bloomWants = function()
      local RO = Shared.s21
      local _O, rO = RO.bloom
      if _O then
        RO = gO() and hO()
        if RO then
          rO = RO
        else
          local RO = jO
          rO = ((RO - K()) % uO) < 12
        end
      else
        rO = _O
      end
      return rO
    end
    local function uO()
      local jO = Shared.s22
      return jO("Areas", "ButterflyBloom", "Bounds")
    end
    local function jO()
      local RO = Shared.s59
      local _O = RO()
      return ((_O and (type(_O.Butterflies) == "table")) and _O.Butterflies) or {}
    end
    local RO = X("bf", HO)
    local function _O(rO)
      return ((rO:GetAttribute("ButterflyNet") == true) or (rO:GetAttribute("ItemType") == "ButterflyNet")) or (rO.Name == "Butterfly Net")
    end
    local rO = RaycastParams.new()
    rO.FilterType = Enum.RaycastFilterType.Exclude
    local function VO(kO)
      local FO, QO = {}, Shared.LocalPlayer
      f:yT(FO, 0, QO.Character, workspace:FindFirstChild("ButterflyBloomSwarm"))
      rO.FilterDescendantsInstances = FO
      local DO, DO, DO, TO = Shared.Vec3, Shared.Vec3, workspace:Raycast(kO + Shared.Vec3(0, 25, 0), Shared.Vec3(0, -120, 0), rO), Shared.s8
      FO = TO()
      TO = nil
      if DO then
        QO = Shared.Vec3
        TO = QO(kO.X, (DO.Position.Y + ((FO and FO.HipHeight) or 2)) + 1, kO.Z)
      else
        TO = DO
      end
      return TO or kO
    end
    local function rO(kO)
      local FO = Shared.s22
      local QO = FO("Machines", "ButterflyStation", kO)
      FO = QO and (QO:FindFirstChild("Anchor") or QO)
      return FO and ((FO:IsA("BasePart") and FO.Position) or (FO:IsA("Model") and FO:GetPivot().Position))
    end
    local function kO(FO, QO)
      local DO, DO = Shared.LocalPlayer, Shared.LocalPlayer
      pcall(Shared.LocalPlayer.RequestStreamAroundAsync, Shared.LocalPlayer, FO)
      local DO, TO, dO = Shared.s32, Shared.CFrameNew, Shared.Vec3
      DO(TO(FO + dO(0, 3, 4)))
      TO = os.clock() + 0.6
      while (os.clock() < TO) and (QO()) do
        local QO, DO, TO = Shared.s32, Shared.CFrameNew, Shared.Vec3
        QO(DO(FO + TO(0, 3, 4)))
        DO = Shared.WaitHeartbeat
        DO()
      end
    end
    local function FO(QO)
      local DO = rO("NetStand") or rO("ButterflyMachine")
      if not (DO) then
        return false
      end
      local TO = Shared.s15
      if not (TO(QO)) then
        return false
      end
      TO = Shared.s16
      local dO = TO()
      if dO then
        if (dO.Position - DO).Magnitude > 60 then
          TO = Shared.Core
          if not (TO.reach({Pos = DO, Name = "the net"}, QO)) then
            return false
          end
        end
      end
      for eO = 1, 5, 1 do
        if not (QO()) then
          return false
        end
        kO(DO, QO)
        dO = Shared.Invoke
        TO, eO = dO("RF/Butterflies/AskClaimNet")
        if TO then
          if eO == true then
            return true
          end
        end
        task.wait(0.8)
      end
      return jO().NetClaimed == true
    end
    local QO
    pcall(function()
      QO = require(a.Controllers.Game.AdminAbuseClientController.Events.ButterflyBloom.Swarm)
    end)
    local function DO(TO, dO)
      local eO, mO
      local xO = Shared.Modules
      local bO, SO, wO = xO.Cat, K(), {}
      local function ZO(WO, AO, XO)
        if typeof(XO) ~= "Vector3" then
          return
        else
          local EO = JO
          if not (EO[AO.Tier]) then
            return
          end
        end
        local JO, JO, JO = Shared.s21, Shared.s21, (((XO - TO).Magnitude / Shared.s21.bfSpeed) - (((Shared.s21.bfPri ~= "Nearest") and ((w[AO.Tier] or 0) * 1000)) or 0)) - (((WO == dO) and 1) or 0)
        if if eO then JO < mO else not eO then
          eO, mO = {id = WO, p = XO, f = AO}, JO
        end
      end
      if QO then
        if QO.Each then
          pcall(function()
            local w = QO
            for JO, QO in w.Each() do
              local w, TO = (type(QO) == "table") and QO.Flight, (type(QO) == "table") and QO.Body
              if type(w) == "table" then
                if typeof(TO) == "Instance" then
                  QO = w.Id or JO
                  wO[QO] = true
                  ZO(QO, w, (TO:IsA("BasePart") and TO.Position) or (TO:IsA("Model") and TO:GetPivot().Position))
                end
              end
            end
          end)
        end
      end
      if bO and not next(wO) then
        for w, JO in next, NO, nil do
          if not (wO[w]) then
            local NO, QO = pcall(bO.PositionAt, JO, SO)
            if NO then
              ZO(w, JO, QO)
            end
          end
        end
      end
      if eO then
        local w, JO = pcall(bO and bO.VelocityAt, eO.f, SO)
        local NO, QO = w and (typeof(JO) == "Vector3")
        if NO then
          w = Shared.Vec3
          QO = w(JO.X, 0, JO.Z)
        else
          QO = NO
        end
        xO = nil
        if QO then
          xO = QO
        else
          NO = Shared.Vec3Zero
          xO = NO
        end
        eO.v = xO
      end
      return eO
    end
    nO.want = function()
      if not (gO()) then
        return RO("Waiting for the next Butterfly Bloom")
      end
      if T() <= 0 then
        return RO("Night, waiting")
      end
      if not (hO()) then
        local w = f[53](math.max(OO(), 0))
        return RO(("Bloom ends in %ds, not worth the trip"):format(f:uT(w)))
      end
      return uO() or true
    end
    nO.run = function(w, JO)
      local NO = Shared.Core
      if not (NO.needBody()) then
        return
      end
      NO = Shared.s8
      local uO = NO()
      if not (jO().NetClaimed) then
        RO("Claiming the butterfly net")
        if Shared.s14(JO) then
          if not (FO(JO)) then
            return RO("Could not claim the net")
          end
        else
          return RO("Could not claim the net")
        end
      end
      local OO, hO = (typeof(w) == "Instance") and w.Position
      if OO then
        hO = OO
      else
        w = Shared.Vec3
        hO = (w(6700, 74, -364))
      end
      NO = Shared.s16
      OO = NO()
      if OO and ((OO.Position - hO).Magnitude > 300) then
        if os.clock() < lO then
          return RO("Ragdoll TP did not land, trying again soon")
        end
        pcall(uO.UnequipTools, uO)
        if Shared.s14(JO) then
          w = Shared.s15
          if not (w(JO)) then
            return RO("Stuck on treadmill")
          end
        else
          return RO("Stuck on treadmill")
        end
        NO = Shared.s16
        OO = NO()
        if OO then
          local FO = Shared.s17
          if FO(OO.Position) then
            local FO = Shared.s18
            if not (FO(JO, "Butterfly bloom")) then
              return
            end
          end
        end
        local FO = Shared.Vec3
        local QO, TO = VO(hO + FO(0, 0, 6)), false
        for dO = 1, 2, 1 do
          RO(("Ragdoll TP to the bloom (try %d/2)"):format(dO))
          TO = iO(function()
            return QO
          end, JO)
          if TO then
            break
          elseif not (JO()) then
            break
          end
          task.wait(0.5)
        end
        if TO then
        else
          if JO() then
            FO = Shared.Core
            TO = if FO.reach({Pos = QO, Name = "the bloom"}, JO) then true else TO
          else
          end
        end
        if not (TO) then
          lO = os.clock() + 10
          return RO("Ragdoll TP did not land, trying again soon")
        end
      end
      local lO, FO, QO = os.clock(), os.clock(), Shared.RunService
      w = U(QO.Stepped, function()
        local TO = Shared.s21
        if TO.bfMode ~= "Stand" then
          return
        end
        local dO, eO = ipairs, f[53](c:GetPlayers())
        for mO, mO in dO(f:uT(eO)) do
          TO = Shared.LocalPlayer
          for dO, dO in ipairs((((mO ~= TO) and mO.Character) and mO.Character:GetChildren()) or {}) do
            if dO:IsA("BasePart") then
              dO.CanCollide = false
            end
          end
        end
      end)
      NO = nil
      local TO, dO = 0
      while (JO() and (gO())) and (T() > 0) do
        QO = Shared.s16
        OO = QO()
        local JO = Shared.s8
        uO = JO()
        if OO then
          if uO then
            if (OO.Position - hO).Magnitude > 600 then
              break
            end
          else
            break
          end
        else
          break
        end
        JO = R(_O)
        if JO then
          local R = Shared.LocalPlayer
          if JO.Parent ~= R.Character then
            pcall(uO.EquipTool, uO, JO)
          end
        end
        JO = DO(OO.Position, NO)
        NO = JO and JO.id
        local R = Shared.s21
        local NO, _O = (R.bfMode == "Stick") and "Chase"
        if NO then
          _O = NO
        else
          R = Shared.s21
          _O = R.bfMode
        end
        if os.clock() >= TO then
          TO = os.clock() + 0.5
          RO(((_O == "Chase") and "Chasing butterflies") or "Catching butterflies")
        else
        end
        if _O == "Chase" then
          uO.PlatformStand = false
          NO, R = JO and JO.p
          if NO then
            R = NO
          else
            local RO = Shared.Vec3
            R = VO(hO + RO(0, 0, 6))
          end
          local RO = Shared.Vec3
          local QO, DO = RO(R.X - OO.Position.X, 0, R.Z - OO.Position.Z), OO.AssemblyLinearVelocity
          if dO then
          else
            RO = Shared.Core
            local TO, eO = RO.normalWalk
            if TO then
              local mO = Shared.Core
              eO = mO.normalWalk(uO)
            else
              eO = TO
            end
            dO = eO or math.max(uO.WalkSpeed, 16)
          end
          if JO and (QO.Magnitude <= 40) then
            RO = Shared.Vec3
            local TO, eO, mO = RO(R.X, math.max(VO(R).Y, (R.Y - YO) + 4), R.Z), ((JO.v.Magnitude > 1) and JO.v.Unit) or ((QO.Magnitude > 0.5) and QO.Unit)
            if eO then
              mO = eO
            else
              local YO = Shared.Vec3
              mO = YO(OO.CFrame.LookVector.X, 0, OO.CFrame.LookVector.Z)
            end
            local YO, RO = Shared.s32, Shared.CFrameNew
            YO(RO(TO, TO + mO))
            OO.AssemblyLinearVelocity = JO.v
            uO.WalkSpeed = math.max(JO.v.Magnitude, 16)
            uO:MoveTo(TO + JO.v)
            FO = os.clock()
          else
            if QO.Magnitude > 2 then
              local YO, YO = Shared.s21, math.clamp(QO.Magnitude * 8, 16, Shared.s21.bfSpeed)
              uO.WalkSpeed = YO
              uO:MoveTo(OO.Position + QO)
              local RO
              RO, OO.AssemblyLinearVelocity = Shared.Vec3, (QO.Unit * YO) + Shared.Vec3(0, DO.Y, 0)
              RO = Shared.Vec3
              FO = if RO(DO.X, 0, DO.Z).Magnitude > (YO * 0.3) then os.clock() else FO
            else
              uO:MoveTo(OO.Position)
              FO = os.clock()
            end
          end
          if (os.clock() - FO) > 0.5 then
            FO = os.clock()
            uO.Jump = true
          else
          end
          QO = Shared.WaitHeartbeat
          QO()
          continue
        end
        uO.PlatformStand = true
        R = Shared.Vec3
        JO, NO = VO(hO + R(0, 0, 6)), os.clock() - lO
        if _O == "Patrol" then
          local YO, lO = Shared.Vec3
          lO, JO = Shared.s21, VO(hO + YO(math.sin((NO * Shared.s21.bfSpeed) / 180) * 170, 0, 0))
        else
          if _O == "Circle" then
            local YO, lO, RO = Shared.Vec3
            lO, RO, JO = Shared.s21, Shared.s21, VO(hO + YO(math.cos(((NO * Shared.s21.bfSpeed) / 25) / 4) * 25, 0, math.sin(((NO * Shared.s21.bfSpeed) / 25) / 4) * 25))
          else
          end
        end
        R = JO - OO.Position
        if R.Magnitude > 8 then
          _O = nil
          _O, OO.AssemblyLinearVelocity = Shared.s21, R.Unit * math.min(Shared.s21.bfSpeed, R.Magnitude / 0.05)
        else
          local R, NO = Shared.s32, Shared.CFrameNew
          R(NO(JO))
        end
        JO = Shared.WaitHeartbeat
        JO()
      end
      w:Disconnect()
      if uO then
        uO.PlatformStand = false
        hO = Shared.Vec3Zero
        uO:Move(hO)
        if dO then
          uO.WalkSpeed = dO
        end
      end
    end
    nO.on = function()
      local R = Shared.s21
      if R.bloom then
        if Shared.s4 then
          if Shared.s4.name == "Steal" then
            local w = Shared.s29
            if not (w()) then
              local w, nO = Shared.Core, Shared.Core
              if (w.rank.Bloom or 5) < (nO.rank.Steal or 9) then
                local w = Shared.Core
                if w.bloomWants() then
                  qO(Shared.s4)
                end
              end
            end
          end
        end
      end
      R = Shared.s21
      return R.bloom
    end
    local R = sO({name = "BloomInfo", gap = 2})
    R.on = function()
      return BO("Event")
    end
    R.fn = function()
      local R = jO()
      local w, nO = R.Counts or {}, Shared.Core
      local JO = nO.bfRec or {}
      local function nO(NO)
        return tostring(w[NO] or 0) .. ((JO[NO] and (" / " .. JO[NO])) or "")
      end
      E("bst", IO, {Emerald = nO("Green"), Sapphire = nO("Blue"), Amethyst = nO("Purple"), Radiant = nO("Golden"), Essence = tostring(R.Essence or 0), Caught = O(R.TotalCaught or 0)})
    end
    HO = LO.Butterfly:Section("Butterfly machine", "sparkles")
    Shared.Core.bfT = m(HO, "Auto trade up", "bfTrade", false, function(R)
      if R then
        local R = Shared.s21
        if R.bfSmart then
          local R = Shared.Core
          R.bfS:Set(false)
        end
      end
    end)
    local R = {}
    pO, zO = {"Emerald to Sapphire", "Sapphire to Amethyst", "Amethyst to Radiant"}, function(w)
      R = {}
      for nO, IO in ipairs(w) do
        nO = R
        nO[#nO + 1] = _[IO:match("^(%a+)")]
      end
    end
    HO:Dropdown("Trade", pO, {}, zO, true)
    Shared.Core.bfS = m(HO, "Smart trade for essence", "bfSmart", false, function(_)
      if _ then
        local _ = Shared.s21
        if _.bfTrade then
          local _ = Shared.Core
          _.bfT:Set(false)
        end
      end
    end)
    m(HO, "Auto craft essence", "bfCraft", false)
    local _, w = {Green = 10, Blue = 10, Purple = 50}, {Green = 240, Blue = 115, Purple = 40, Golden = 1}
    pcall(function()
      local nO, HO = require(a.Shared.Flags.ButterflyFlags), {Green = "GreenToBlueCost", Blue = "BlueToPurpleCost", Purple = "PurpleToGoldenCost"}
      for IO, JO in next, HO, nil do
        _[IO] = tonumber(nO[JO]:Get()) or _[IO]
      end
      for HO in next, w, nil do
        w[HO] = tonumber(nO["Essence" .. HO]:Get()) or w[HO]
      end
    end)
    Shared.Core.bfRec = w
    local function nO(HO)
      for IO, JO in next, w, nil do
        if (HO[IO] or 0) < JO then
          return false
        end
      end
      return true
    end
    local function HO(IO)
      local JO, NO, zO, YO = IO.Green or 0, IO.Blue or 0, IO.Purple or 0, IO.Golden or 0
      for lO = 60, 1, -1 do
        IO = math.max(0, (lO * w.Golden) - YO)
        local YO = math.max(0, ((lO * w.Purple) + (_.Purple * IO)) - zO)
        local zO = math.max(0, ((lO * w.Blue) + (_.Blue * YO)) - NO)
        if JO >= ((lO * w.Green) + (_.Green * zO)) then
          return {Green = zO, Blue = YO, Purple = IO}
        end
      end
    end
    local IO = sO({name = "Machine", mover = true, gap = 20, pri = 6, soft = true})
    IO.on = function()
      local JO = Shared.s21
      local NO, zO = JO.bfTrade
      if NO then
        zO = NO
      else
        JO = Shared.s21
        zO = JO.bfSmart
      end
      NO = nil
      if zO then
        NO = zO
      else
        JO = Shared.s21
        NO = JO.bfCraft
      end
      return NO
    end
    IO.want = function()
      if gO() then
        return
      else
        local JO = Shared.LocalPlayer
        if JO:GetAttribute("EnchantedTreeUnlocked") ~= true then
          return
        end
      end
      local JO, NO = jO().Counts or {}, Shared.s21
      if NO.bfCraft then
        if nO(JO) then
          return true
        end
      end
      NO = Shared.s21
      if NO.bfSmart then
        local zO = HO(JO)
        return (zO and (((zO.Green + zO.Blue) + zO.Purple) > 0)) or nil
      end
      local zO, YO = ipairs, R
      for lO, lO in zO(YO) do
        NO = Shared.s21
        if NO.bfTrade then
          local NO, NO = Shared.s21, (JO[lO] or 0) - ((Shared.s21.bfCraft and w[lO]) or 0)
          if NO >= _[lO] then
            return true
          end
        end
      end
    end
    local function JO(NO)
      local zO = Shared.LocalPlayer
      if zO:GetAttribute("InEnchantedTree") then
        return true
      end
      zO = Shared.s22
      local YO = zO("Build", "EnchantedTreeInterior", "Markers", "EnterTrigger", "EnchantedTreeEntrance", "EnchantedTreePrompt")
      zO = YO and YO.Parent
      local lO = zO and ((zO:IsA("Attachment") and zO.WorldPosition) or (zO:IsA("BasePart") and zO.Position))
      if not (lO) then
        return false
      end
      zO = Shared.s15
      if not (zO(NO)) then
        return false
      end
      zO = Shared.s16
      local uO = zO()
      if uO then
        zO = Shared.s17
        if zO(uO.Position) then
          local gO = Shared.s18
          if not (gO(NO, "Enchanted Tree", 0.3)) then
            return false
          end
        end
      end
      uO = Shared.Vec3
      zO = lO + uO(0, 0, -12)
      for gO = 1, 2, 1 do
        gO = Shared.s16
        uO = gO()
        if uO then
          if NO() then
            if T() > 0 then
              if not ((uO.Position - zO).Magnitude > 500) then
                break
              end
            else
              break
            end
          else
            break
          end
        else
          break
        end
        gO = Shared.s10
        gO("Ragdoll TP to the Enchanted Tree")
        gO = Shared.Vec3
        iO(zO + gO(0, 3, 0), NO)
      end
      uO = Shared.s16
      local gO = uO()
      if gO then
        if (gO.Position - zO).Magnitude > 60 then
          uO = Shared.Core
          if not (uO.reach({Pos = zO, Name = "the tree"}, NO)) then
            return false
          end
        end
      end
      for OO = 1, 4, 1 do
        NO, zO, gO = Shared.s32, Shared.CFrameNew, Shared.Vec3
        NO(zO(lO + gO(0, 3, -6)))
        pcall(fireproximityprompt, YO)
        OO = os.clock() + 4
        while true do
          local NO, zO = os.clock() < OO
          if NO then
            uO = Shared.LocalPlayer
            zO = not uO:GetAttribute("InEnchantedTree")
          else
            zO = NO
          end
          if not zO then
            break
          end
          NO = Shared.WaitHeartbeat
          NO()
        end
        OO = Shared.LocalPlayer
        if OO:GetAttribute("InEnchantedTree") then
          return true
        end
      end
      return false
    end
    Shared.Core.enterTree = JO
    Shared.Core.leaveTree = function()
      local NO = Shared.s22
      local zO = NO("Build", "EnchantedTreeInterior", "Markers", "ExitTrigger")
      if zO then
        if zO:IsA("BasePart") then
          NO = Shared.LocalPlayer
          if not (NO:GetAttribute("InEnchantedTree")) then
            return
          end
        else
          return
        end
      else
        return
      end
      local YO, lO = Shared.s32, Shared.CFrameNew
      YO(lO(zO.Position + (zO.CFrame.LookVector * ((zO.Size.Z / 2) + 3))))
      lO = Shared.WaitHeartbeat
      lO()
      NO = Shared.s32
      NO(zO.CFrame)
      NO = os.clock() + 1.5
      while true do
        lO = Shared.LocalPlayer
        if not (lO:GetAttribute("InEnchantedTree") and (os.clock() < NO)) then
          break
        end
        YO = Shared.WaitHeartbeat
        YO()
      end
      NO = Shared.LocalPlayer
      if NO:GetAttribute("InEnchantedTree") then
        YO = Shared.s16
        C(YO(), zO)
      end
    end
    local function C(NO, zO, YO, ...)
      local lO = rO(zO)
      if not (lO) then
        return false
      end
      for zO = 1, 3, 1 do
        kO(lO, YO)
        zO = Shared.Invoke
        local YO, lO, uO = zO(NO, ...)
        if YO then
          if lO ~= false then
            return true
          end
        end
        if not (tostring(uO):lower():find("closer")) then
          return false
        end
      end
      return false
    end
    IO.run = function(IO, NO)
      IO = Shared.Core
      if not (IO.needBody()) then
        return
      end
      if Shared.s14(NO) then
        if not (JO(NO)) then
          IO = Shared.s10
          return IO("Could not enter the tree", "warn")
        end
      else
        local JO = Shared.s10
        return JO("Could not enter the tree", "warn")
      end
      IO = Shared.s21
      local JO, zO = IO.bfSmart and HO(jO().Counts or {}), ipairs
      IO = (JO and {"Green", "Blue", "Purple"}) or {}
      for HO, YO in zO(IO) do
        HO = JO[YO]
        for lO = 1, HO, 1 do
          lO = Shared.s21
          if lO.bfSmart then
            if NO() then
              if not (C("RF/Butterflies/AskTradeUp", "ButterflyMachine", NO, YO)) then
                break
              end
            else
              break
            end
          else
            break
          end
          task.wait(0.15)
        end
      end
      JO, IO = ipairs, Shared.s21
      zO = (IO.bfSmart and {}) or R
      for R, HO in JO(zO) do
        while true do
          IO = Shared.s21
          local zO, YO = (IO.bfTrade and NO()) and (jO().Counts or {})[HO]
          if zO then
            R = nil
            R, YO = Shared.s21, (jO().Counts[HO] - ((Shared.s21.bfCraft and w[HO]) or 0)) >= _[HO]
          else
            YO = zO
          end
          if not YO then
            break
          end
          if not (C("RF/Butterflies/AskTradeUp", "ButterflyMachine", NO, HO)) then
            break
          end
          task.wait(0.15)
        end
      end
      for R = 1, 50, 1 do
        JO = Shared.s21
        if JO.bfCraft then
          if NO() then
            if not (nO(jO().Counts or {})) then
              break
            end
          else
            break
          end
        else
          break
        end
        if not (C("RF/Butterflies/AskCraftEssence", "MutationShrine", NO)) then
          break
        end
        task.wait(0.3)
      end
      NO = Shared.Core
      NO.leaveTree()
    end
  end
  do
    local C, R = sO({name = "Wisp", gap = 3}), LO.Butterfly:Section("Wisp companion", "ghost")
    m(R, "Auto wisp quest", "wisp", false)
    m(R, "Auto banjo cricket", "banjo", false)
    local _ = X("wt", R:Text("Off"))
    Shared.Core.wispSay = _
    local w = R:Stats({{"Stage", V.wisp}, {"Progress", V.wisp3}})
    C.on = function()
      local R = Shared.s21
      return R.wisp or BO("Event")
    end
    local R = Shared.Modules.Wisp
    local function nO()
      local HO = Shared.s59
      local IO = HO()
      HO = IO and IO.WispCompanion
      return IO, ((type(HO) == "table") and HO) or nil
    end
    local function HO(IO)
      if IO then
        if IO.Accepted then
          if IO.Unlocked then
            return
          end
        else
          return
        end
      else
        return
      end
      return (((type(R) == "table") and R.List) or {})[tonumber(IO.Stage) or 1]
    end
    local function IO(JO, NO)
      return ((type(JO.Progress) == "table") and tonumber(JO.Progress[NO.Id])) or 0
    end
    local function JO(NO, zO)
      return (type(NO.Claimed) == "table") and NO.Claimed[zO.Id]
    end
    local NO = {}
    local function zO(YO)
      if not (NO[YO]) then
        local lO = {}
        pcall(function()
          for uO, uO in ipairs(require(a.Data.Areas.Configs[YO]).DropTable) do
            lO[tostring(uO[1] or uO.Category)] = true
          end
        end)
        NO[YO] = lO
      end
      return NO[YO]
    end
    local NO = {at = 0}
    local function YO(lO)
      if NO.q == lO then
        if (os.clock() - NO.at) < 2 then
          local uO = NO
          return uO
        end
      end
      local uO = Shared.s59
      local jO, gO = uO(), zO((type(lO.Match) == "table") and lO.Match.AreaId)
      local zO, OO, hO = h(jO or {}), {}, {}
      for h, RO in next, ((jO and (type(jO.Inventory) == "table")) and jO.Inventory) or {}, nil do
        uO = (type(RO) == "table") and tostring(RO.AssetCategory)
        if uO then
          if gO[uO] then
            if not (RO.IsFavorite) then
              if not (RO.InFuse) then
                if not (zO[h]) then
                  OO[uO] = OO[uO] or {}
                  table.insert(OO[uO], h)
                  hO[uO] = (hO[uO] or 0) + 1
                end
              end
            end
          end
        end
      end
      for h, h in pairs(D()) do
        jO = (type(h) == "table") and tostring(h.AssetCategory)
        if jO then
          if gO[jO] then
            hO[jO] = (hO[jO] or 0) + 1
          end
        end
      end
      NO = {q = lO, at = os.clock(), supply = 0}
      for h, uO in next, OO, nil do
        if #uO >= 3 then
          lO, jO = NO, NO
          lO.ready = {uO[1], uO[2], uO[3]}
          jO.cat = h
        end
      end
      for h, h in next, hO, nil do
        zO = NO
        zO.supply = math.max(NO.supply, h)
      end
      lO = NO
      return lO
    end
    local function h(zO)
      local lO, lO = nO()
      local uO = HO(lO)
      if uO then
        if JO(lO, uO) then
          return false
        end
      else
        return false
      end
      local jO = ((type(uO.Match) == "table") and uO.Match) or {}
      if uO.Event == "PetFused" then
        return (zO.a == jO.AreaId) and (YO(uO).supply < 3)
      end
      if uO.Event ~= "EggSecured" then
        return false
      elseif IO(lO, uO) >= (tonumber(uO.Target) or 1) then
        return false
      end
      for uO, gO in next, jO, nil do
        if uO == "AreaId" then
          if gO ~= zO.a then
            return false
          end
        elseif uO == "Rarity" then
          lO = g(zO.cat)
          lO = lO and lO.Rarity
          if lO then
            if not (lO.DisplayName == gO) then
              if not (lO._id == gO) then
                return false
              end
            end
          else
            return false
          end
        else
          return false
        end
      end
      return true
    end
    Shared.Core.wispSteals = function()
      local zO = Shared.s21
      if not (zO.wisp) then
        return false
      end
      local lO, lO = nO()
      zO = HO(lO)
      if zO then
        if JO(lO, zO) then
          return false
        end
      else
        return false
      end
      if zO.Event == "EggSecured" then
        return IO(lO, zO) < (tonumber(zO.Target) or 1)
      end
      return (zO.Event == "PetFused") and (YO(zO).supply < 3)
    end
    local zO = Shared.Core.wantEgg
    Shared.Core.wantEgg = function(lO)
      local uO = Shared.s21
      if uO.wisp then
        if h(lO) then
          return "wisp"
        end
      end
      return zO and (zO(lO))
    end
    local function h(...)
      local zO = Shared.s22
      local lO = zO("Build", ...)
      return lO and ((lO:IsA("BasePart") and lO.Position) or (lO:IsA("Model") and lO:GetPivot().Position))
    end
    local function zO(lO)
      local uO = Shared.s59
      local jO = uO()
      if not (jO) then
        return
      end
      if jO.FusionLocked then
        if type(jO.FusionEggReward) == "table" then
          uO = Shared.Invoke
          uO("RF/Fusery/FinishReveal")
        end
        return _("Fusing for the wisp quest")
      end
      uO = YO(lO)
      if not (uO.ready) then
        return _(((uO.supply >= 3) and "Hatching eggs for the fuse quest") or "Stealing eggs for the fuse quest")
      end
      local YO, lO = {}, {}
      for gO, gO in ipairs(uO.ready) do
        YO[gO] = true
      end
      local gO, OO = ipairs, ((type(jO.FusionSlots) == "table") and jO.FusionSlots) or {}
      for hO, RO in gO(OO) do
        if YO[RO] then
          lO[RO] = true
        else
          hO = Shared.Invoke
          hO("RF/Fusery/EjectPet", RO)
          task.wait(0.35)
        end
      end
      if jO.FusionInfoAcknowledged == false then
        YO = Shared.Invoke
        YO("RF/Fusery/ConfirmBriefing")
        task.wait(0.35)
      end
      YO, jO = ipairs, uO.ready
      for hO, hO in YO(jO) do
        if not (lO[hO]) then
          gO = Shared.Invoke
          gO("RF/Fusery/LoadPet", hO)
          task.wait(0.35)
        end
      end
      OO = Shared.Invoke
      OO("RF/Fusery/BeginFuse")
      NO.at = 0
      jO = Shared.s67
      _("Fusing 3 " .. (jO(uO.cat) .. " for the wisp quest"))
    end
    C.fn = function()
      local C, NO = nO()
      if not (NO) then
        return _("Reading quest")
      end
      local nO = ((type(R) == "table") and tonumber(R.StageCount)) or 4
      if NO.Unlocked then
        E("wst", w, {Stage = ("%d / %d"):format(nO, nO), Progress = "Complete"})
        return _("Done, the Enchanted Tree is open")
      end
      if not (NO.Accepted) then
        E("wst", w, {Stage = ("0 / %d"):format(nO), Progress = "Not accepted"})
      end
      local YO = HO(NO)
      if YO then
        E("wst", w, {Stage = ("%d / %d"):format(tonumber(NO.Stage) or 1, nO), Progress = ("%d / %d"):format(IO(NO, YO), tonumber(YO.Target) or 1)})
      end
      YO = Shared.s21
      if not (YO.wisp) then
        return _((NO.Accepted and "Off") or "Off - quest not accepted yet")
      end
      if C.FusionLocked then
        if type(C.FusionEggReward) == "table" then
          YO = Shared.Invoke
          YO("RF/Fusery/FinishReveal")
        end
      end
      if not (NO.Accepted) then
        YO = ((type(R) == "table") and tonumber(R.RequiredSpeedPower)) or 50000000000
        if (tonumber(C.SpeedPower) or 0) < YO then
          return _("Needs " .. (O(YO) .. " speed power to meet the wisp"))
        end
        local R = Shared.s22
        local w = R("Build")
        if w then
          if not (w:GetAttribute("EnchantedForestZoneRevealed")) then
            return _("Waiting for the Enchanted Forest to open")
          end
        else
          return _("Waiting for the Enchanted Forest to open")
        end
        R = Shared.Core
        R.wispGo = {h("EnchantedForestZone", "WispSpawn"), "Accept"}
        return _("Going to accept the quest")
      end
      C = HO(NO)
      if C then
        if not (JO(NO, C)) then
          if IO(NO, C) >= (tonumber(C.Target) or 1) then
            YO = Shared.Invoke
            YO("RF/WispCompanion/Request", "Claim", C.Id)
            return _("Claimed " .. tostring(C.Title))
          end
        end
      end
      if (tonumber(NO.Stage) or 1) >= nO then
        if not (NO.Returning) then
          YO = Shared.Invoke
          YO("RF/WispCompanion/Request", "BeginReturn")
        end
        local R = Shared.Core
        R.wispGo = {h("EnchantedForestZone", "Zone13Props", "EnchantedTree", "WispAnchor") or h("EnchantedForestZone", "WispAnchor"), "Return"}
        return _("Returning the wisp")
      end
      if not C then
        return _("Reading quest")
      end
      if C.Event == "PetFused" then
        return zO(C)
      end
      _(tostring(C.Title) .. ((((type(C.Match) == "table") and C.Match.Rarity) and " - waiting for that egg in this server") or ""))
    end
    local C = sO({name = "WispGo", mover = true, gap = 3, pri = 4})
    C.on = function()
      local h = Shared.s21
      return h.wisp
    end
    C.want = function()
      local h = Shared.Core
      local R, _ = h.wispGo
      if R then
        h = Shared.Core
        _ = h.wispGo[1]
      else
        _ = R
      end
      R = nil
      if _ then
        h = Shared.Core
        R = h.wispGo
      else
        R = _
      end
      return R or nil
    end
    C.run = function(C, h)
      local R = C[1]
      if Shared.s14(h) then
        local _ = Shared.s15
        if not (_(h)) then
          return
        end
      else
        return
      end
      local _ = Shared.s16
      local w = _()
      if w then
        _ = Shared.s17
        if _(w.Position) then
          local nO = Shared.s18
          if not (nO(h, "Wisp", 0.3)) then
            return
          end
        end
      end
      w, _ = Shared.LocalPlayer, Shared.LocalPlayer
      pcall(Shared.LocalPlayer.RequestStreamAroundAsync, Shared.LocalPlayer, R)
      local _ = Shared.s16
      local w = _()
      if not (w) then
        return
      end
      if (w.Position - R).Magnitude > 1200 then
        if T() > 0 then
          _ = Shared.Vec3
          iO(R + _(0, 3, 3), h)
        end
      end
      _ = Shared.s16
      w = _()
      if w then
        if (w.Position - R).Magnitude > 40 then
          local w, nO = Shared.Core, Shared.Vec3
          if not (w.stepTo(R + nO(0, 0, 3), h)) then
            return
          end
        end
      end
      _ = Shared.s8
      local w, nO = _(), 0
      while true do
        local HO, IO = (w and h()) and (nO < 3)
        if HO then
          _ = Shared.s16
          IO = (_())
        else
          IO = HO
        end
        HO = nil
        if IO then
          local _ = Shared.s16
          HO = (_().Position - R).Magnitude > 6
        else
          HO = IO
        end
        if not HO then
          break
        end
        w:MoveTo(R)
        nO += task.wait(0.2)
      end
      task.wait(0.5)
      h = Shared.Invoke
      h("RF/WispCompanion/Request", C[2])
      h = Shared.Core
      h.wispGo = nil
    end
  end
  do
    local C = {pay = nil, caught = 0, slipped = 0, tries = 0, askAt = 0, jumped = {}}
    local h = sO({name = "Star", mover = true, gap = 0.5, pri = 2})
    u = LO.Star:Section("Shooting Star", "star")
    local R = u:Stats({{"Star", V.star}, {"Lands in", V.timer}, {"Caught", V.check}, {"Doing", V.tread}})
    m(u, "Auto catch shooting star", "star", false, function(_)
      if not (_) then
        qO(h)
      end
    end)
    local _ = LO.Star:Section("Catch", "hand"):Stats({{"Expires in", V.timer}, {"Slipped", V.trap}, {"Tries", V.net}, {"Distance", V.pin}})
    local function w(nO)
      if type(nO) == "table" then
        if nO.Id ~= nil then
          if C.pay then
            if not (C.pay.Id == nO.Id) then
              C.slipped = 0
              C.tries = 0
            end
          else
            C.slipped = 0
            C.tries = 0
          end
          C.pay = nO
        end
      end
    end
    local function nO()
      C.askAt = os.clock() + 15
      task.spawn(function()
        local HO = Shared.Invoke
        local IO, JO = HO("RF/ShootingStar/AskState")
        if IO then
          w(JO)
        end
      end)
    end
    local function HO(IO, JO)
      local NO = n:FindFirstChild(IO)
      if NO then
        if NO:IsA("RemoteEvent") then
          U(NO.OnClientEvent, JO)
        end
      end
    end
    HO("RE/ShootingStar/Fall", w)
    HO("RE/ShootingStar/Wander", function(w, IO)
      if C.pay then
        if C.pay.Id == w then
          if type(IO) == "table" then
            C.pay.Leg = IO
          end
        end
      end
    end)
    HO("RE/ShootingStar/Slipped", function(w)
      if C.pay then
        if C.pay.Id == w then
          C.slipped = C.slipped + 1
          C.hold = nil
        end
      end
    end)
    HO("RE/ShootingStar/Claimed", function(w)
      if C.pay then
        if C.pay.Id == w then
          C.caught = C.caught + 1
          C.pay = nil
          qO(h)
          W("Shooting Star", "Caught a star", "ok")
        end
      end
    end)
    HO("RE/ShootingStar/Expired", function(w)
      if C.pay then
        if C.pay.Id == w then
          C.pay = nil
          qO(h)
        end
      end
    end)
    nO()
    local function w(HO)
      local IO = workspace:FindFirstChild("ShootingStarClient")
      local JO = IO and (IO:FindFirstChild("Buddy"))
      IO = JO and (JO:FindFirstChild("RootPart"))
      if IO then
        if IO:IsA("BasePart") then
          return IO.Position
        end
      end
      IO, JO = K(), HO.Leg
      if type(JO) == "table" then
        if typeof(JO.From) == "Vector3" then
          if typeof(JO.To) == "Vector3" then
            local NO = tonumber(JO.StartAt) or IO
            local zO = (tonumber(JO.ArriveAt) or NO) - NO
            local YO, lO = ((zO > 0) and math.clamp((IO - NO) / zO, 0, 1)) or 1, JO.To - JO.From
            local IO, zO, uO = JO.From:Lerp(JO.To, YO), (YO < 1) and (lO.Magnitude > 0.5)
            if zO then
              NO = Shared.Vec3
              uO = NO(lO.X, 0, lO.Z).Unit
            else
              uO = zO
            end
            return IO, uO or nil
          end
        end
      end
      JO = HO.Landing
      if typeof(JO) == "CFrame" then
        return JO.Position
      end
      return ((typeof(JO) == "Vector3") and JO) or nil
    end
    local function HO(IO)
      local JO = K()
      return (IO and (JO >= (tonumber(IO.LandAt) or JO))) and ((tonumber(IO.ExpiresAt) or math.huge) > JO)
    end
    Shared.Core.starWants = function()
      local IO = Shared.s21
      return IO.star and HO(C.pay)
    end
    h.on = function()
      if os.clock() >= C.askAt then
        nO()
      end
      if C.pay then
        if (tonumber(C.pay.ExpiresAt) or math.huge) <= K() then
          C.pay = nil
        end
      end
      local IO = Shared.s21
      return IO.star and HO(C.pay)
    end
    h.want = function()
      local HO = Shared.s29
      if HO() then
        return
      end
      return C.pay
    end
    h.run = function(HO, IO)
      local JO = Shared.LocalPlayer
      local NO = JO.Character
      local function zO()
        local YO, lO = IO() and (C.pay == HO)
        if YO then
          local IO = Shared.LocalPlayer
          lO = IO.Character == NO
        else
          lO = YO
        end
        return lO
      end
      if Shared.s14(zO) then
        JO = Shared.s15
        if not (JO(zO)) then
          return
        end
      else
        return
      end
      JO = Shared.s16
      local IO = JO()
      JO = nil
      if IO then
        local NO = Shared.s17
        JO = NO(IO.Position)
      else
        JO = IO
      end
      if JO then
        local NO = Shared.s18
        if not (NO(zO, "Shooting Star")) then
          return
        end
      end
      local function NO()
        local YO = w(HO)
        local lO
        if YO then
          local uO = Shared.Vec3
          lO = YO + uO(0, 3, 3)
        else
          lO = YO
        end
        return lO
      end
      local function YO()
        local lO, uO = NO(), Shared.s16
        local jO = uO()
        return ((lO and jO) and (jO.Position - lO).Magnitude) or math.huge
      end
      if YO() > 40 then
        if not (C.jumped[HO.Id]) then
          C.jumped[HO.Id] = true
          JO = Shared.s10
          JO("Ragdoll jump to the star")
          iO(NO, zO)
        end
      end
      if zO() then
        if YO() > 40 then
          JO = Shared.s10
          JO("Running to the star")
          local lO = NO()
          local NO
          if lO then
            NO = lO
          else
            local lO = Shared.Vec3Zero
            NO = lO
          end
          MO(NO, zO, 30, 40)
        end
      end
      JO, YO = (tonumber(HO.HoldSeconds) or 1.6) + 0.3, Shared.s27
      local MO, NO = 0.5 + (YO() * 2), os.clock()
      YO = false
      local lO
      local uO = 0
      while zO() do
        local jO, gO = w(HO)
        local OO = Shared.s16
        IO = OO()
        OO = Shared.s8
        local hO = OO()
        if jO then
          if IO then
            if not (hO) then
              return
            end
          else
            return
          end
        else
          return
        end
        if IO.Anchored then
          Shared.s14(zO)
        end
        OO = Shared.Vec3
        local zO, RO, _O = jO + OO(0, 3, 0), gO and (gO * 2)
        if RO then
          _O = RO
        else
          OO = Shared.Vec3
          _O = (OO(0, 0, 3))
        end
        gO = (zO + _O) - IO.Position
        if gO.Magnitude > 60 then
          return
        end
        hO.PlatformStand = true
        local OO, RO = gO * 10, Shared.Vec3
        local rO = RO(jO.X - IO.Position.X, 0, jO.Z - IO.Position.Z)
        if OO.Magnitude > 200 then
          OO = OO.Unit * 200
        else
        end
        pcall(function()
          if rO.Magnitude > 0.05 then
            local jO
            jO, IO.CFrame = Shared.CFrameNew, Shared.CFrameNew(IO.Position, IO.Position + rO.Unit)
          end
          local jO
          jO, IO.AssemblyLinearVelocity, IO.AssemblyAngularVelocity = Shared.Vec3Zero, OO, Shared.Vec3Zero
        end)
        if YO then
          if C.hold then
            if if lO then not lO else (os.clock() - C.hold) >= JO then
              uO += 1
              C.tries = C.tries + 1
              lO = os.clock()
              t("RE/ShootingStar/Catch", HO.Id)
              RO = Shared.s10
              RO("Catching the star (try " .. (uO .. ")"))
            else
              if lO then
                if (os.clock() - lO) >= 2 then
                  C.hold = nil
                  t("RE/ShootingStar/Hold", HO.Id, false)
                  if (uO % 3) == 0 then
                    nO()
                  end
                end
              end
            end
          else
            lO, C.hold = nil, os.clock()
            t("RE/ShootingStar/Hold", HO.Id, true)
            hO = Shared.s10
            hO("Holding the star" .. (((C.slipped > 0) and (" (slipped " .. (C.slipped .. ")"))) or ""))
          end
        else
          NO = if gO.Magnitude > 8 then os.clock() else NO
          YO = (os.clock() - NO) >= MO
          if not YO then
            _O = Shared.s10
            _O("At the star, letting the server catch up")
          end
        end
        zO = Shared.WaitHeartbeat
        zO()
      end
      if C.pay == HO then
        t("RE/ShootingStar/Hold", HO.Id, false)
      end
      C.hold = nil
    end
    local nO = sO({name = "StarInfo", gap = 1})
    nO.on = function()
      return BO("Event")
    end
    nO.fn = function()
      local nO, MO = C.pay, K()
      local HO, IO, JO, NO = nO and ((tonumber(nO.LandAt) or MO) - MO), nO and tonumber(nO.ExpiresAt), nO and (w(nO)), Shared.s16
      local w, zO, YO, lO = NO(), {Star = (nO and (((HO > 0) and "Falling") or "Landed")) or "None", ["Lands in"] = (nO and (((HO > 0) and (math.ceil(HO) .. "s")) or "now")) or "--", Caught = tostring(C.caught)}, (Shared.s4 == h) and "Catching"
      if YO then
        lO = YO
      else
        HO = Shared.s21
        lO = HO.star and "Waiting"
      end
      zO.Doing = lO or "Off"
      E("star", R, zO)
      E("starc", _, {["Expires in"] = (IO and v(math.max(IO - MO, 0))) or "--", Slipped = tostring(C.slipped), Tries = tostring(C.tries), Distance = ((JO and w) and tostring(math.floor((w.Position - JO).Magnitude))) or "--"})
    end
  end
  do
    local C = sO({name = "Stage", mover = true, gap = 0.5, pri = 50, soft = true})
    local function h()
      local R = Shared.s21
      if R.steal then
        local _ = Shared.Core
        if _.targetsSoon then
          local _, _, w = Shared.Core, pcall(Shared.Core.targetsSoon)
          if _ then
            if type(w) == "table" then
              if w[1] then
                local _ = Shared.Core
                if _.fieldFresh then
                  return true
                end
              end
            end
          end
        end
      end
      R = Shared.Core
      local _, w = R.starWants
      if _ then
        R = Shared.Core
        w = R.starWants()
      else
        w = _
      end
      _ = nil
      if w then
        _ = w
      else
        R = Shared.Core
        local w = R.bloomWants
        if w then
          local R = Shared.Core
          _ = R.bloomWants()
        else
          _ = w
        end
      end
      return _
    end
    C.on = function()
      local R = Shared.Fire
      local _ = R("Cycle", "IsNightPhase", K())
      local w, nO = not _
      if _ then
        nO = w
      else
        R = Shared.Fire
        nO = R("Wall", "IsSealed") == true
      end
      w, _ = (nO and 0.5) or 50, Shared.Core
      if _.rank.Stage ~= w then
        R = Shared.Core
        R.rank.Stage = w
        local R = Shared.Core
        if R.order then
          local R = Shared.Core
          R.order()
        end
      end
      return (nO and h()) or false
    end
    C.want = function()
      local h = Shared.s29
      if not (h()) then
        local h = Shared.s16
        if h() then
          local h, R = Shared.s37, Shared.Vec3
          return h() + R(0, 3, 0)
        end
      end
    end
    C.run = function(C, h)
      local R = Shared.Core
      if R.inFuse then
        local _ = Shared.Core
        if _.inFuse() then
          local _ = Shared.s10
          _("Leaving the portal zone before the field opens")
          _ = Shared.Core
          _.leaveFuse()
        end
      end
      if not (Shared.s14(h)) then
        return
      end
      R = Shared.s16
      local _ = R()
      if _ then
        R = Shared.s17
        if R(_.Position) then
          if (_.Position - C).Magnitude > 8 then
            local R = Shared.s10
            R("To the safe zone before the field opens")
            R = Shared.s46
            if not (R(C, h, 250)) then
              return
            end
          end
        end
      end
      C = Shared.s18
      C(h, "Ready in the safe zone", 0)
      _ = Shared.s10
      _("Field open, the top task goes first")
    end
  end
  do
    local function C(h)
      local R, _ = pcall(function()
        local w = Shared.Modules
        return w.Egg.ReadFieldEgg(h)
      end)
      if R then
        if type(_) == "table" then
          return _
        end
      end
      _ = Shared.s19
      R = _()
      if type(R[h]) == "table" then
        return R[h]
      end
      for _, _ in pairs(R) do
        if type(_) == "table" then
          if _.Uid == h then
            return _
          end
        end
      end
    end
    local function h(R)
      return (R and R:IsA("Model")) and R:GetPivot().Position
    end
    local function R()
      local _, w = ipairs, {"CaptureTheEggSpawn", "AdminAbuseEggSpawn"}
      for nO, MO in _(w) do
        nO = Shared.s22
        local _ = nO("Areas", MO)
        if _ then
          if _:IsA("BasePart") then
            return _.Position
          end
        end
      end
    end
    local function _(w, nO)
      local MO = workspace:FindFirstChild("AreaEggSlotsClient")
      return ((h(MO and MO:FindFirstChild(w)) or h(workspace:FindFirstChild(w))) or ((nO and (typeof(nO.BottomCFrame) == "CFrame")) and nO.BottomCFrame.Position)) or (R())
    end
    local function R(w)
      local nO = tonumber(w and w.CarrierUserId)
      return ((nO and (nO > 0)) and nO) or nil
    end
    local function w(nO, MO)
      local HO = Shared.s29
      local IO = HO(nO)
      HO = nil
      if IO then
        HO = IO
      else
        nO = nil
        nO, HO = Shared.LocalPlayer, R(MO) == Shared.LocalPlayer.UserId
      end
      return HO
    end
    local function nO(MO, HO, IO)
      local JO = Shared.s16
      local NO, zO = JO(), Shared.s8
      JO = zO()
      if not (NO) then
        return
      end
      if JO then
        JO.PlatformStand = true
      end
      zO = MO - NO.Position
      local YO, lO = ((zO.Magnitude > (HO * IO)) and (NO.Position + ((zO.Unit * HO) * IO))) or MO, Shared.Vec3
      MO, HO = lO(zO.X, 0, zO.Z), Shared.s32
      NO, JO = (MO.Magnitude > 0.5) and CFrame.lookAt(YO, YO + MO)
      if NO then
        JO = NO
      else
        IO = Shared.CFrameNew
        JO = (IO(YO))
      end
      HO(JO)
    end
    local function MO(HO, IO)
      local JO, NO, zO, YO, lO = ipairs, f[53](workspace:GetChildren()), 14
      for uO, jO in JO(f:uT(NO)) do
        uO = ((jO.Name == "SmartPromptPart") and jO:IsA("BasePart")) and jO:FindFirstChild("CarryAreaEgg")
        if uO then
          if uO:IsA("ProximityPrompt") then
            local gO = Shared.Vec3
            local OO = gO(jO.Position.X - IO.X, 0, jO.Position.Z - IO.Z).Magnitude
            if OO < zO then
              zO, YO, lO = OO, uO, jO
            else
            end
          else
          end
        else
        end
      end
      IO, NO = YO and workspace:FindFirstChild("AreaEggSlotsClient"), ipairs
      JO = (IO and IO:GetChildren()) or {}
      for uO, jO in NO(JO) do
        uO = (jO.Name ~= HO) and h(jO)
        if uO then
          IO = Shared.Vec3
          if (IO(uO.X - lO.Position.X, 0, uO.Z - lO.Position.Z).Magnitude + 1.5) < zO then
            return
          end
        end
      end
      return YO
    end
    local function h(HO, IO)
      local JO = Shared.s8
      local NO, zO = JO(), Shared.LocalPlayer
      JO = zO.Character
      if NO then
        if JO then
          if JO:FindFirstChildWhichIsA("Tool") then
            pcall(NO.UnequipTools, NO)
          end
        end
      end
      NO, zO = os.clock() + 1.4, 0
      while (os.clock() < NO) and (IO()) do
        JO = C(HO)
        if w(HO, JO) then
          return true
        end
        if R(JO) then
          return false
        end
        local IO = _(HO, JO)
        if IO then
          local NO, YO, lO = Shared.s32, Shared.CFrameNew, Shared.Vec3
          NO(YO(IO + lO(0, 2.5, 0)))
          if os.clock() >= zO then
            zO = os.clock() + 0.08
            local NO = fireproximityprompt and MO(HO, IO)
            if NO then
              pcall(function()
                NO.HoldDuration = 0
                fireproximityprompt(NO)
              end)
            else
              task.spawn(Shared.Fire, "Egg", "CarryFieldEgg", HO, ((JO and JO.AreaId) and JO.NestId) and (JO.AreaId .. (":" .. JO.NestId)))
            end
          else
          end
        else
        end
        IO = Shared.WaitHeartbeat
        IO()
      end
      return w(HO, C(HO))
    end
    u = LO.AA:Section("Capture the egg", "flag")
    local MO = X("cap", u:Text("Off"))
    local HO = sO({name = "Capture", mover = true, gap = 0.25, pri = -1, urgent = true, ev = function()
      return true
    end})
    m(u, "Auto capture event egg", "capture", false, function(IO)
      if not (IO) then
        qO(HO)
      end
    end)
    m(u, "Take it from the holder", "capTake", true)
    S(u, "Hold height", "capH", 20, 120, 45, "", 1)
    S(u, "Keep away", "capAway", 20, 150, 45, "", 1)
    local function IO()
      local JO = workspace:GetAttribute("Event_CaptureTheEggUid")
      return (((type(JO) == "string") and (JO ~= "")) and JO) or nil
    end
    local JO = {}
    local NO = -9
    local function zO()
      if (os.clock() - NO) < 5 then
        local YO = JO
        return YO
      end
      local YO
      YO, JO = os.clock(), {}
      NO = YO
      YO = Shared.s22
      local NO, lO = YO("Areas", "EggCarryBounds"), ipairs
      YO = (NO and NO:GetChildren()) or {}
      for uO, jO in lO(YO) do
        if (((jO:IsA("BasePart") and (jO.Name ~= "SafeZone")) and (jO.Position.Y > 0)) and (jO.Size.X > 60)) and (jO.Size.Z > 60) then
          uO = Shared.Vec3
          local lO, gO = uO(1000000000, 0, 1000000000), Shared.Vec3
          local uO, OO, hO, RO = gO(-1000000000, 0, -1000000000), jO.Size / 2, ipairs, {-1, 1}
          for _O, rO in hO(RO) do
            NO, gO = ipairs, {-1, 1}
            for VO, kO in NO(gO) do
              VO, _O = Shared.Vec3, jO.CFrame:PointToWorldSpace(Shared.Vec3(OO.X * rO, 0, OO.Z * kO))
              lO, uO = (lO:Min(_O)), (uO:Max(_O))
            end
          end
          gO = JO
          hO, RO = #gO + 1, {lo = lO, hi = uO}
          RO.y, gO[hO] = jO.Position.Y + OO.Y, RO
        end
      end
      YO = JO
      return YO
    end
    local function JO(NO, YO)
      YO = YO or 0
      for lO, lO in ipairs(zO()) do
        if NO.X >= (lO.lo.X + YO) then
          if NO.X <= (lO.hi.X - YO) then
            if NO.Z >= (lO.lo.Z + YO) then
              if NO.Z <= (lO.hi.Z - YO) then
                return lO
              end
            end
          end
        end
      end
    end
    local function NO(YO)
      local lO, uO, jO = math.huge, ipairs, f[53](c:GetPlayers())
      for gO, OO in uO(f:uT(jO)) do
        gO = Shared.LocalPlayer
        local uO, hO = ((OO ~= gO) and OO.Character) and OO.Character:FindFirstChild("HumanoidRootPart"), OO.Character and OO.Character:FindFirstChildOfClass("Humanoid")
        lO = if uO then if hO then if hO.Health > 0 then math.min(lO, (uO.Position - YO).Magnitude) else lO else lO else lO
      end
      jO = Shared.s22
      local uO, gO = jO("Areas", "GuardAreas"), ipairs
      jO = (uO and uO:GetChildren()) or {}
      for OO, hO in gO(jO) do
        uO = hO:FindFirstChild("Guard") and hO.Guard:FindFirstChild("HumanoidRootPart", true)
        if uO then
          OO, hO = nil
          OO, hO, lO = Shared.Vec3, Shared.s21, math.min(lO, (Shared.Vec3(uO.Position.X - YO.X, 0, uO.Position.Z - YO.Z).Magnitude * Shared.s21.capAway) / 32)
        else
        end
      end
      return lO
    end
    local function YO(lO)
      local uO, jO, gO = math.huge, ipairs, f[53](zO())
      local zO
      local OO, hO = -1
      for RO, _O in jO(f:uT(gO)) do
        local jO, gO = (_O.lo.Z + _O.hi.Z) / 2, (_O.hi.Z - _O.lo.Z) / 2
        local rO, VO, kO = math.min(40, math.max(0, gO - 14)), _O.lo.X + 14, _O.hi.X - 14
        for FO = VO, kO, 50 do
          RO, gO = ipairs, {jO - rO, jO, jO + rO}
          for jO, rO in RO(gO) do
            jO = Shared.Vec3
            local gO, gO = Shared.s21, jO(FO, _O.y + Shared.s21.capH, rO)
            local jO, RO, _O = NO(gO), (gO - lO).Magnitude, Shared.s21
            if jO >= (_O.capAway + 10) then
              if RO < uO then
                uO, zO = RO, gO
              else
              end
            else
            end
            if jO > OO then
              OO, hO = jO, gO
            else
              if jO == OO then
                if hO then
                  if RO < (hO - lO).Magnitude then
                    OO, hO = jO, gO
                  else
                  end
                else
                end
              else
              end
            end
          end
        end
      end
      return zO or hO
    end
    local zO
    local lO, uO = 0, ""
    tO = n:FindFirstChild("RE/EggCapture/StandingsRefreshed")
    if tO then
      U(tO.OnClientEvent, function(jO)
        local gO = (type(jO) == "table") and ((jO.Entries or jO.Standings) or jO)
        if type(gO) ~= "table" then
          return
        end
        uO = ""
        jO = ipairs
        for OO, hO in jO(gO) do
          if type(hO) == "table" then
            local jO = Shared.LocalPlayer
            if tonumber(hO.UserId) == jO.UserId then
              uO = ("  %.1fs  #%d"):format(tonumber(hO.Seconds) or 0, tonumber(hO.Rank) or OO)
              break
            end
          end
        end
      end)
    end
    HO.on = function()
      local jO = Shared.s21
      return jO.capture and (IO() ~= nil)
    end
    HO.want = function()
      local jO = IO()
      return (jO and C(jO)) and jO
    end
    HO.run = function(HO, jO)
      if not (Shared.s14(jO)) then
        return
      end
      local gO = Shared.Core
      gO.ready(jO, 3)
      local OO, hO = 0.016666666666666666, 0
      while jO() do
        local RO, _O = C(HO), Shared.s16
        gO = _O()
        if RO then
          if not gO then
            break
          end
        else
          break
        end
        local rO, VO = R(RO), Shared.Core
        VO.godHunt = false
        if w(HO, RO) then
          _O = zO
          local kO, FO = not _O
          if _O then
            VO = os.clock() >= lO
            if VO then
              local QO = JO(zO, 13)
              local DO = not QO
              if QO then
                local QO
                QO, FO = Shared.s21, NO(zO) < Shared.s21.capAway
              else
                FO = DO
              end
            else
              FO = VO
            end
          else
            FO = kO
          end
          if FO then
            zO = YO(gO.Position)
          end
          lO = os.clock() + 0.25
          local NO, YO, lO = JO(gO.Position), zO
          if YO then
            lO = YO
          else
            FO, kO = Shared.Vec3
            kO, lO = Shared.s21, FO(gO.Position.X, ((NO and NO.y) or gO.Position.Y) + Shared.s21.capH, gO.Position.Z)
          end
          nO(lO, 220, OO)
          MO("Holding the event egg" .. uO)
        else
          if rO then
            zO = nil
            local NO = c:GetPlayerByUserId(rO)
            local YO
            if NO then
              local lO = Shared.s21
              YO = lO.capTake
            else
              YO = NO
            end
            local lO
            if YO then
              local uO = Shared.Core
              lO = uO.bat()
            else
              lO = YO
            end
            YO = nil
            if lO then
              local uO = Shared.Core
              YO = uO.chase(NO, true)
            else
              YO = lO
            end
            if YO then
              lO = Shared.Core
              lO.godHunt = true
              MO("Taking the event egg from " .. NO.DisplayName)
            else
              local YO = _(HO, RO)
              if YO then
                if JO(YO) then
                  local lO = Shared.Vec3
                  nO(YO + lO(0, 25, 0), 400, OO)
                end
              end
              local lO, uO = (NO and NO.DisplayName) or "Someone", Shared.s21
              local NO, rO = uO.capTake
              if NO then
                YO = Shared.Core
                rO = not YO.bat()
              else
                rO = NO
              end
              MO(lO .. (" has the event egg" .. ((rO and ", get a bat to take it") or "")))
            end
          else
            if RO.State == "Carried" then
              MO("Someone has the event egg")
            else
              local NO = _(HO, RO)
              if not (NO) then
                break
              end
              local YO = Shared.Vec3
              local lO, uO = YO(NO.X - gO.Position.X, 0, NO.Z - gO.Position.Z).Magnitude, Shared.s17
              YO = uO(gO.Position)
              uO = nil
              if YO then
                local RO = Shared.s17
                uO = not RO(NO)
              else
                uO = YO
              end
              YO = nil
              if uO then
                local RO = Shared.Fire
                local rO = RO("Wall", "IsSealed")
                if rO then
                  YO = rO
                else
                  RO = Shared.Fire
                  YO = RO("Cycle", "IsNightPhase", K())
                end
              else
                YO = uO
              end
              if YO then
                MO("Field wall is up, waiting to go out")
              else
                if (lO > 220) and (os.clock() >= hO) then
                  MO("Ragdoll jump to the event egg")
                  hO = os.clock() + 4
                  if iO(function()
                    local iO = _(HO, C(HO))
                    local _
                    if iO then
                      local YO = Shared.Vec3
                      _ = iO + YO(0, 3, 0)
                    else
                      _ = iO
                    end
                    return _
                  end, jO) then
                    hO = os.clock() + 2
                    MO("Landed, grabbing the event egg")
                    local _ = os.clock() + 8
                    while (os.clock() < _) and (jO()) do
                      local _ = C(HO)
                      if _ then
                        if w(HO, _) then
                          break
                        elseif R(_) then
                          break
                        end
                      else
                        break
                      end
                      h(HO, jO)
                    end
                  else
                  end
                else
                  if uO then
                    MO("Leaving the base for the event egg")
                    local R, _ = Shared.s46, Shared.Vec3
                    R(NO + _(0, 2.5, 0), function()
                      return jO() and not w(HO, C(HO))
                    end, 400)
                  elseif lO <= 220 then
                    MO("Grabbing the event egg")
                    h(HO, jO)
                  else
                    local C = Shared.Vec3
                    nO(NO + C(0, 2.5, 0), 400, OO)
                    MO(("Going for the event egg  %d studs"):format(lO))
                  end
                end
              end
            end
          end
        end
        _O = nil
        _O, OO = Shared.WaitHeartbeat, math.clamp(Shared.WaitHeartbeat(), 0.004166666666666667, 0.05)
      end
      local C = Shared.Core
      zO = nil
      C.godHunt = false
      C = Shared.s16
      gO = C()
      C = gO and JO(gO.Position, -4)
      if C and (gO.Position.Y > (C.y + 8)) then
        local h = Shared.Vec3
        local R, _ = h(gO.Position.X, C.y + 3.5, gO.Position.Z), os.clock() + 1.5
        while true do
          local w, iO = os.clock() < _
          if w then
            h = Shared.s16
            iO = (h())
          else
            iO = w
          end
          w = nil
          if iO then
            local h = Shared.s16
            w = (h().Position - R).Magnitude > 1
          else
            w = iO
          end
          if not w then
            break
          end
          nO(R, 160, OO)
          w = nil
          w, OO = Shared.WaitHeartbeat, math.clamp(Shared.WaitHeartbeat(), 0.004166666666666667, 0.05)
        end
      end
      gO = Shared.s8
      C = gO()
      if C then
        C.PlatformStand = false
      end
    end
    local C = sO({name = "CaptureInfo", gap = 1})
    C.on = function()
      return BO("Event")
    end
    C.fn = function()
      local C, h = (IO() or workspace:GetAttribute("Event_CaptureTheEgg")) or workspace:GetAttribute("Event_CaptureTheEggGameplay"), Shared.s21
      if h.capture then
        if C then
          if Shared.s4 then
            if Shared.s4.name ~= "Capture" then
              if IO() then
                MO("Waiting for " .. (Shared.s4.name .. " to finish"))
              elseif not Shared.s4 then
                MO("Looking for the event egg")
              end
            elseif not Shared.s4 then
              MO("Looking for the event egg")
            end
          elseif not Shared.s4 then
            MO("Looking for the event egg")
          end
        else
          MO("Waiting for Capture the egg")
        end
      else
        MO("Off")
      end
    end
    pO = LO.AA:Section("Minigame eggs", "trophy")
    local C = X("mg", pO:Text("Off"))
    m(pO, "Auto steal minigame egg", "minigame", true)
    local h = {{"RedLightGreenLight", "RLGL"}, {"TrexRun", "TrexRun"}}
    local R, _, w = sO({name = "Minigame", gap = 0.5}), false, 0
    local function iO()
      local nO = Shared.Core
      if nO.mgUid then
        local MO, MO, MO = Shared.Core, Shared.Core, table.find(Shared.Core.pick, Shared.Core.mgUid)
        if MO then
          table.remove(Shared.Core.pick, MO)
        end
        MO = Shared.Core
        MO.mgUid = nil
      end
      if _ then
        nO = Shared.s29
        if not (nO()) then
          local nO = Shared.Core
          if nO.autoSteal then
            _ = false
            A("mgSteal", function()
              local nO = Shared.Core
              nO.autoSteal:Set(false)
            end)
          end
        end
      end
    end
    R.on = function()
      local nO = Shared.s21
      local MO, HO = nO.minigame
      if MO then
        HO = MO
      else
        nO = Shared.Core
        HO = nO.mgUid ~= nil
      end
      return HO
    end
    R.fn = function()
      local R
      for nO, nO in ipairs(h) do
        if (workspace:GetAttribute("Event_" .. nO[1]) == true) or (typeof(workspace:GetAttribute(nO[2] .. "_EggPosition")) == "Vector3") then
          R = nO[2]
          break
        end
      end
      local h = Shared.s21
      if not (h.minigame and R) then
        iO()
        local nO = Shared.s21
        return C((nO.minigame and "Waiting for Red Light Green Light or T-Rex Run") or "Off")
      end
      local nO, MO, HO = workspace:GetAttribute(R .. "_CarrierUserId"), workspace:GetAttribute(R .. "_EggPosition"), Shared.LocalPlayer
      if nO == HO.UserId then
        return C("Carrying the egg home")
      end
      if type(nO) == "number" then
        if nO > 0 then
          h = Shared.Core
          h.mgUid = nil
          return C("Another player has the egg")
        end
      end
      if typeof(MO) ~= "Vector3" then
        iO()
        return C("Waiting for the egg to land")
      end
      HO, h = pairs, Shared.s19
      local IO, JO, NO = f[53](h()), 40
      for zO, YO in HO(f:uT(IO)) do
        nO = (((type(YO) == "table") and (YO.State ~= "Carried")) and (YO.State ~= "Claimed")) and (YO.BottomCFrame or YO.BoundsCFrame)
        zO, h = typeof(nO) == "CFrame"
        if zO then
          local lO = Shared.Vec3
          h = lO(nO.Position.X - MO.X, 0, nO.Position.Z - MO.Z).Magnitude
        else
          h = zO
        end
        if h then
          if h < JO then
            zO = YO.Uid
            JO, NO = h, zO
          else
          end
        else
        end
      end
      if not (NO) then
        iO()
        return C("Egg landed, looking for it")
      end
      HO = Shared.Core
      if (NO ~= HO.mgUid) or ((os.clock() - w) > 2) then
        MO, nO = Shared.Core, os.clock()
        MO.mgUid = NO
        w = nO
        h, IO = Shared.Core, table.find(Shared.Core.pick, NO)
        if IO ~= 1 then
          if IO then
            table.remove(Shared.Core.pick, IO)
          end
          table.insert(Shared.Core.pick, 1, NO)
          local h = Shared.Core
          h.rank.Steal = 0
          h = Shared.Core
          h.order()
        end
        if Shared.s4 then
          if Shared.s4.name == "Steal" then
            local h = Shared.Core
            if h.curUid ~= NO then
              local h = Shared.s29
              if not (h()) then
                qO(Shared.s4)
              end
            end
          end
        end
        local h = Shared.s21
        if not (h.steal) then
          local h = Shared.Core
          if h.autoSteal then
            _ = true
            A("mgSteal", function()
              local h = Shared.Core
              h.autoSteal:Set(true)
            end)
          end
        end
      end
      C("Going for the " .. ((((R == "RLGL") and "Red Light Green Light") or "T-Rex Run") .. " egg"))
    end
    Shared.Core.greenLight = function(C, h)
      local R = os.clock() + 20
      while true do
        local _ = Shared.Core
        if not (((((C == _.mgUid) and (workspace:GetAttribute("Event_RedLightGreenLight") == true)) and (workspace:GetAttribute("RLGL_Light") ~= "Green")) and (os.clock() < R)) and (h())) then
          break
        end
        _ = Shared.s10
        _("Waiting for the green light")
        _ = Shared.WaitHeartbeat
        _()
      end
    end
  end
  do
    local C, h = {listen = 0, wrong = 0, acks = {}, next = 0}, {}
    local R, _, w, iO, nO = Shared.Vec3(6218.93, 17159.02, 16903.8), Shared.Vec3(6257.93, 17159.02, 16912.8), Shared.Vec3(6270.93, 17159.02, 16903.8), Shared.Vec3(6244.93, 17159.02, 16918.8), f[53](Shared.Vec3(6231.93, 17159.02, 16912.8))
    f:yT(h, 0, R, _, w, iO, f:uT(nO))
    local R = Shared.Vec3(6244.93, 17159.02, 16880)
    local _ = Shared.Vec3(6272.46, 17164.04, 16958.18)
    local iO = Shared.Vec3(6246.9, 17161, 16887)
    local nO = Shared.Vec3(6246.9, 17165, 16881.6)
    local MO = Shared.Vec3(5905.63, 17027.3, 15610.83)
    local HO = Shared.Vec3(6248.72, 17163, 16928)
    local IO = Shared.Vec3(6248.72, 17163, 16944)
    local JO = G("CollectionService")
    local function NO()
      local zO = Shared.s59
      local YO = zO()
      return ((YO and (type(YO.BanjoCricket) == "table")) and YO.BanjoCricket) or {}
    end
    local function zO(YO)
      local lO, uO = pcall(function()
        return require(a.Data.BanjoCricket).PlaybackSeconds(YO)
      end)
      return (lO and tonumber(uO)) or ((YO * 0.65) + 0.5)
    end
    w = n:FindFirstChild("RE/BanjoCricket/Effect")
    if w then
      U(w.OnClientEvent, function(w)
        if type(w) ~= "table" then
          return
        end
        if (w.Kind == "Playback") and (type(w.Notes) == "table") then
          C.notes, C.listen = w.Notes, os.clock() + zO(#w.Notes)
        elseif w.Kind == "Note" then
          table.insert(C.acks, {w.Mushroom, os.clock()})
          if #C.acks > 40 then
            table.remove(C.acks, 1)
          end
        elseif w.Kind == "Wrong" then
          C.wrong = os.clock()
          C.notes = nil
        elseif w.Kind == "Reset" then
          C.notes = nil
        elseif w.Kind == "Solved" then
          C.solved = true
        end
      end)
    end
    local function w(zO)
      for YO, YO in ipairs(JO:GetTagged("BanjoCricketMushroom")) do
        if YO:GetAttribute("MushroomIndex") == zO then
          local lO = YO:FindFirstChild("Hitbox") or YO:FindFirstChild("Hitbox Part")
          local uO, jO = pcall(function()
            return (lO and lO.Position) or YO:GetPivot().Position
          end)
          if uO then
            if jO then
              return jO
            end
          end
        end
      end
      return h[zO]
    end
    local function h()
      local zO, YO = pcall(function()
        return JO:GetTagged("BanjoCricketNpc")[1]:GetPivot().Position
      end)
      return (zO and YO) or _
    end
    local function _(...)
      local JO = Shared.s22
      local zO = JO("Build", "EnchantedTreeInterior", "Markers", ...)
      return (zO and zO:IsA("BasePart")) and zO.Position
    end
    local function JO()
      local zO = Shared.s16
      local YO = zO()
      return (YO ~= nil) and ((YO.Position - ((_("Passages", "SecretRoomSpawn") or _("SecretRoomSpawn")) or iO)).Magnitude < 120)
    end
    local function iO(zO)
      local YO, lO, uO = RaycastParams.new(), {}, Shared.LocalPlayer
      f:yT(lO, 0, uO.Character)
      YO.FilterDescendantsInstances, YO.FilterType = lO, Enum.RaycastFilterType.Exclude
      local jO, jO, jO = Shared.Vec3, Shared.Vec3, workspace:Raycast(zO + Shared.Vec3(0, 20, 0), Shared.Vec3(0, -80, 0), YO)
      lO = nil
      if jO then
        uO = nil
        uO, lO = Shared.Vec3, jO.Position + Shared.Vec3(0, 3, 0)
      else
        lO = jO
      end
      return lO or zO
    end
    local function zO(YO)
      local lO = Shared.s16
      local uO = lO()
      if uO then
        lO = Shared.s32
        lO(CFrame.lookAt(uO.Position, Shared.Vec3(YO.X, uO.Position.Y, YO.Z)))
      end
    end
    local function YO(lO, uO)
      local jO, gO = w(lO), Shared.Vec3
      local w = gO(jO.X - R.X, 0, jO.Z - R.Z)
      gO = (w.Magnitude > 0.1) and w.Unit
      if gO then
        w = gO
      else
        local R = Shared.Vec3
        w = (R(0, 0, 1))
      end
      gO = Shared.s46
      if not (gO(iO(jO + (w * 6.5)), uO, 60)) then
        return false
      end
      zO(jO)
      gO = Shared.Core
      jO, uO = gO.bat(), Shared.s8
      gO = uO()
      if jO then
        if not gO then
          return false
        end
      else
        return false
      end
      uO = Shared.LocalPlayer
      if jO.Parent ~= uO.Character then
        pcall(gO.EquipTool, gO, jO)
        task.wait(0.25)
      end
      t("RE/BanjoCricket/Aim", lO)
      uO = os.clock() + 2
      while ((os.clock() < uO) and (jO:GetAttribute("CooldownActive") == true)) and (K() < (tonumber(jO:GetAttribute("CooldownEndTime")) or 0)) do
        task.wait(0.05)
      end
      pcall(jO.Activate, jO)
      return true
    end
    local function R(w, lO, uO)
      local jO = os.clock() + uO
      while os.clock() < jO do
        if C.wrong > lO then
          return "wrong"
        end
        for uO, uO in ipairs(C.acks) do
          if uO[1] == w then
            if uO[2] > lO then
              return "ok"
            end
          end
        end
        task.wait(0.05)
      end
    end
    local function w(lO)
      local uO = os.clock() + 300
      C.notes = nil
      local jO, gO = 0, 0
      while lO() and (os.clock() < uO) do
        local uO = Shared.LocalPlayer
        if uO:GetAttribute("InEnchantedTree") then
          if not (JO()) then
            return false
          end
        else
          return false
        end
        if C.solved then
          return true
        elseif NO().Solved == true then
          return true
        end
        uO = C.notes
        if uO then
          if os.clock() < C.listen then
            task.wait(0.05)
          else
            gO = 0
            C.notes = nil
            local OO = Shared.s10
            OO(("Playing back %d notes"):format(#uO))
            OO = ipairs
            for hO, RO in OO(uO) do
              hO = nil
              for uO = 1, 2, 1 do
                uO = os.clock()
                if not (YO(RO, lO)) then
                  break
                end
                hO = R(RO, uO, 1.6)
                if hO then
                  break
                end
              end
              if hO ~= "ok" then
                RO = Shared.s10
                RO("Missed a note, starting over", "warn")
                break
              end
            end
            jO = os.clock()
          end
        else
          if (os.clock() - jO) > 4 then
            gO += 1
            if gO > 12 then
              local R = Shared.s10
              R("The mushrooms do not answer", "warn")
              return false
            end
            local R = Shared.s10
            R("Waking the mushrooms")
            YO(4, lO)
            jO = os.clock()
          else
          end
          task.wait(0.1)
        end
      end
      return false
    end
    local function R(YO)
      if JO() then
        return true
      end
      for lO = 1, 2, 1 do
        lO = Shared.s22
        local uO = lO("Build", "EnchantedTreeInterior", "SecretLeapHint", "Streaks")
        local jO, gO = ((uO and uO:IsA("BasePart")) and uO.Position) or MO, Shared.s16
        lO = gO()
        if not lO then
          return false
        end
        uO = Shared.s10
        uO("Flying to the Secret Leap")
        uO, gO = Shared.s46, Shared.Vec3
        if uO(gO(lO.Position.X, jO.Y + 18, lO.Position.Z), YO, 120) then
          local MO, lO = Shared.s46, Shared.Vec3
          if not (MO(jO + lO(0, 18, 0), YO, 120)) then
            return false
          end
        else
          return false
        end
        uO = Shared.s10
        uO("Taking the Secret Leap")
        jO = os.clock() + 8
        while ((os.clock() < jO) and (YO())) and not JO() do
          task.wait(0.1)
        end
        if JO() then
          task.wait(1)
          return true
        end
      end
      return false
    end
    local function MO(YO)
      task.wait(5)
      for lO = 1, 3, 1 do
        local uO, jO = h(), Shared.s16
        lO = jO()
        if lO and ((lO.Position - uO).Magnitude > 9) then
          jO = Shared.s10
          jO("Going to Jitterbug")
          local h = Shared.Vec3
          local gO = h(IO.X - uO.X, 0, IO.Z - uO.Z)
          h = (gO.Magnitude > 0.1) and gO.Unit
          if h then
            gO = h
          else
            local OO = Shared.Vec3
            gO = (OO(0, 0, -1))
          end
          local OO, hO = ipairs, {iO(HO), iO(IO), iO(uO + (gO * 6))}
          for iO, iO in OO(hO) do
            h = Shared.s46
            if not (h(iO, YO, 60)) then
              return false
            end
          end
          zO(uO)
        end
        lO = Shared.s10
        lO("Claiming Cricket's Banjo")
        jO = Shared.Invoke
        uO, lO = jO("RF/BanjoCricket/AskClaim")
        if lO == true then
          return true
        elseif NO().Claimed == true then
          return true
        end
        task.wait(1)
      end
      return NO().Claimed == true
    end
    local function h()
      local iO = Shared.s8
      local HO = iO()
      local function IO()
        return true
      end
      if HO then
        pcall(HO.UnequipTools, HO)
      end
      if JO() then
        iO, HO = _("Passages", "SecretRoomExit") or nO, Shared.s46
        HO(iO, IO, 60)
        local _ = os.clock() + 5
        while (os.clock() < _) and (JO()) do
          local _, nO = Shared.s32, Shared.CFrameNew
          _(nO(iO))
          task.wait(0.1)
        end
      end
      IO = Shared.Core
      IO.leaveTree()
    end
    local _ = sO({name = "Banjo", mover = true, gap = 3, pri = 6, soft = true})
    _.on = function()
      local iO = Shared.s21
      return iO.banjo and not C.done
    end
    local function iO(nO)
      local HO = Shared.Core
      if HO.wispSay then
        local HO = Shared.Core
        HO.wispSay("Banjo cricket: " .. nO)
      end
    end
    _.want = function()
      if NO().Claimed == true then
        C.done = true
        return iO("done, Cricket's Banjo is yours")
      end
      local nO = Shared.LocalPlayer
      if nO:GetAttribute("EnchantedTreeUnlocked") ~= true then
        return iO("needs the Enchanted Tree open (finish the wisp quest)")
      end
      nO = Shared.Core
      if not (nO.bat()) then
        return iO("needs a bat in your bag")
      end
      if os.clock() < C.next then
        return
      end
      return true
    end
    _.run = function(_, nO)
      _ = Shared.Core
      if not (_.needBody()) then
        return iO("leaving invisibility first")
      end
      C.next = os.clock() + 15
      if Shared.s14(nO) then
        _ = Shared.Core
        if not (_.enterTree(nO)) then
          return iO("could not get into the Enchanted Tree")
        end
      else
        return iO("could not get into the Enchanted Tree")
      end
      if not (R(nO)) then
        h()
        return iO("could not take the Secret Leap")
      end
      if NO().Solved ~= true then
        if not (C.solved) then
          if not (w(nO)) then
            h()
            return iO("puzzle not solved, trying again")
          end
        end
      end
      if MO(nO) then
        C.done = true
        W("Banjo", "Cricket's Banjo claimed", "ok")
        iO("done, Cricket's Banjo is yours")
      end
      h()
    end
  end
  (function()
    local C, h, R, _, w, iO, nO, MO, HO = G("CollectionService"), {bad = {}, fish = 0, hitAt = 0, buyAt = 0, fishAt = 0, dogAt = 0, doing = "Off"}, {at = 0, pc = {}, miss = {}}, {cd = {}, shot = 0, at = 0}, {Prep = true, Match = true, SuddenDeath = true}, {Intro = true, Reveal = true, Prep = true, Match = true, SuddenDeath = true, Win = true, Outro = true}, {Boarded = true, Departing = true, Returning = true, Respawning = true}, {"Pumpkin Moon", "Ghost Dog quest", "Halloween eggs", "Halloween monsters", "Halloween fishing"}, {"Meet the dog", "Find 4 memories", "Talk to the fisherman", "Catch the ghost dog", "Done"}
    local function IO(JO)
      local NO = Shared.LocalPlayer
      return NO:GetAttribute(JO)
    end
    local function JO(NO, zO)
      local YO, lO = pcall(function()
        return require(a.Shared.Flags[NO])[zO]:Get()
      end)
      if YO then
        return lO
      end
    end
    local function NO(zO)
      local YO = Shared.s59
      local lO = YO()
      return lO and lO[zO]
    end
    local function zO()
      return IO("InHalloweenDimension") == true
    end
    local function YO()
      return workspace:FindFirstChild("HalloweenDimension")
    end
    local function lO(uO)
      local jO = Shared.Vec3
      return jO(uO.X, 0, uO.Z)
    end
    local function uO(jO)
      if typeof(jO) ~= "Instance" then
        return nil
      end
      if jO:IsA("BasePart") then
        return jO.Position
      elseif jO:IsA("Attachment") then
        return jO.WorldPosition
      elseif jO:IsA("Model") then
        return jO:GetPivot().Position
      end
      return jO.Parent and uO(jO.Parent)
    end
    local function jO(gO)
      if gO.WalkSpeed >= 16 then
        return gO.WalkSpeed
      end
      local gO, OO = pcall(function()
        local hO = Shared.LocalPlayer
        return require(a.Shared.Util.TreadmillUtil).SpeedPowerToWalkSpeed(hO.leaderstats.Speed.Value)
      end)
      return (((gO and tonumber(OO)) and (OO >= 16)) and OO) or 16
    end
    local gO = Shared.Core
    gO.normalWalk = jO
    local function OO(hO, RO, _O)
      local rO = Shared.s16
      if rO() then
        if not (hO) then
          return
        end
      else
        return
      end
      pcall(function()
        hO.CanTouch = true
      end)
      local VO, kO, FO, QO = hO.CFrame.LookVector, (hO.Size.Z / 2) + 3, os.clock(), os.clock() + 10
      local function DO()
        return (RO() or (os.clock() > QO)) or (_O and not _O())
      end
      rO = 1
      repeat
        for _O = 0, 8, 1 do
          if RO and (RO()) then
            return
          end
          local QO, TO = Shared.s32, Shared.CFrameNew
          QO(TO(hO.Position + (((VO * kO) * rO) * (1 - (_O / 4)))))
          TO = Shared.WaitHeartbeat
          TO()
        end
        rO = -rO
      until (not RO or DO()) or ((os.clock() - FO) > 3)
      if not RO or DO() then
        return
      end
      rO, kO, FO = hO.CFrame.RightVector, Shared.Vec3, hO.Position - Shared.Vec3(0, (hO.Size.Y / 2) - 3, 0)
      local hO, RO = {{VO * 20, -VO * 20}, {-VO * 20, VO * 20}, {(VO * 15) - (rO * 12), (-VO * 15) + (rO * 12)}, {(VO * 15) + (rO * 12), (-VO * 15) - (rO * 12)}}, 0
      while not DO() do
        VO = Shared.s8
        rO = VO()
        if not rO then
          return
        end
        RO = (RO % #hO) + 1
        local _O, VO, kO = FO + hO[RO][1], FO + hO[RO][2], Shared.s32
        kO(CFrame.lookAt(_O, Shared.Vec3(VO.X, _O.Y, VO.Z)))
        kO = os.clock() + 3
        while (os.clock() < kO) and not DO() do
          rO:MoveTo(VO)
          _O = Shared.WaitHeartbeat
          _O()
        end
      end
    end
    local function hO(RO)
      if RO and fireproximityprompt then
        pcall(function()
          RO.HoldDuration = 0
          fireproximityprompt(RO)
        end)
      end
    end
    local function RO(_O)
      local rO, VO, kO, FO = ipairs, {}, Shared.LocalPlayer, Shared.LocalPlayer
      f:yT(VO, 0, kO.Character, FO:FindFirstChildOfClass("Backpack"))
      for kO, kO in rO(VO) do
        for rO, rO in ipairs((kO and kO:GetChildren()) or {}) do
          if rO:IsA("Tool") then
            if _O(rO) then
              return rO
            end
          end
        end
      end
    end
    local function _O(rO)
      local VO = Shared.s8
      local kO = VO()
      if rO then
        if kO then
          VO = Shared.LocalPlayer
          if rO.Parent ~= VO.Character then
            pcall(kO.EquipTool, kO, rO)
          end
        end
      end
      return rO
    end
    local function rO(VO, kO)
      local FO = os.clock() + VO
      while os.clock() < FO do
        if kO then
          if not (kO()) then
            return false
          end
        end
        VO = Shared.WaitHeartbeat
        VO()
      end
      return true
    end
    local function VO(kO, FO, QO)
      local DO = os.clock() + FO
      while os.clock() < DO do
        if kO() then
          return true
        end
        if QO then
          if not (QO()) then
            return false
          end
        end
        FO = Shared.WaitHeartbeat
        FO()
      end
      return kO()
    end
    local function kO(FO)
      local QO = Shared.s16
      local DO = QO()
      if DO and FO then
        local QO = lO(FO - DO.Position)
        if QO.Magnitude > 0.1 then
          pcall(function()
            local FO = Shared.CFrameNew
            DO.CFrame = FO(DO.Position, DO.Position + QO.Unit)
          end)
        end
      end
    end
    local function FO(QO)
      local function DO()
        local TO = Shared.s16
        local dO = TO()
        return ((dO ~= nil) and (QO ~= nil)) and ((dO.Position - QO).Magnitude > 12)
      end
      return DO
    end
    local QO, DO, TO = {}, {}, 0
    local function dO(eO)
      if eO then
        local eO, mO = ipairs, Shared.LocalPlayer
        local xO, bO = mO.Character
        if xO then
          mO = Shared.LocalPlayer
          bO = mO.Character:GetDescendants()
        else
          bO = xO
        end
        for SO, SO in eO(bO or {}) do
          if SO:IsA("BasePart") then
            if SO.CanCollide then
              QO[SO] = true
              SO.CanCollide = false
            end
          end
        end
        xO = Shared.s16
        eO = xO()
        if eO and ((os.clock() - TO) > 0.15) then
          TO = os.clock()
          local TO, SO, wO, ZO, WO = RaycastParams.new(), OverlapParams.new(), Enum.RaycastFilterType.Exclude, {}, Shared.LocalPlayer
          f:yT(ZO, 0, Shared.LocalPlayer.Character)
          TO.FilterType = wO
          TO.FilterDescendantsInstances = ZO
          mO, xO, bO = Enum.RaycastFilterType.Exclude, {}, Shared.LocalPlayer
          f:yT(xO, 0, Shared.LocalPlayer.Character)
          SO.FilterType = mO
          SO.FilterDescendantsInstances = xO
          ZO, wO = Shared.Vec3, workspace:Raycast(eO.Position, Shared.Vec3(0, -12, 0), TO)
          local TO, mO = (wO and wO.Position.Y) or (eO.Position.Y - 3), {}
          for xO, xO in ipairs(workspace:GetPartBoundsInRadius(eO.Position, 14, SO)) do
            if xO.CanCollide or DO[xO] then
              if xO ~= (wO and wO.Instance) then
                if (xO.Position.Y + (xO.Size.Y / 2)) > (TO + 1.5) then
                  mO[xO] = true
                  DO[xO] = true
                  xO.CanCollide = false
                end
              end
            end
          end
          for TO in next, DO, nil do
            if not (mO[TO]) then
              DO[TO] = nil
              if TO.Parent then
                TO.CanCollide = true
              end
            end
          end
        end
      else
        for TO in next, QO, nil do
          if TO.Parent then
            TO.CanCollide = true
          end
        end
        for TO in next, DO, nil do
          if TO.Parent then
            TO.CanCollide = true
          end
        end
        table.clear(QO)
        table.clear(DO)
      end
    end
    U(G("RunService").Stepped, function()
      if h.move then
        dO(true)
      elseif next(DO) then
        dO(false)
      end
    end)
    local function QO(DO)
      h.mv = (h.mv or 0) + 1
      h.move = true
      local TO, eO = pcall(DO)
      h.mv = h.mv - 1
      if h.mv == 0 then
        h.move = false
        dO(false)
      end
      if not (TO) then
        error(eO, 0)
      end
      return eO
    end
    local function DO(TO, eO, mO)
      local function xO()
        local bO = Shared.s46
        return bO(TO, eO, mO)
      end
      return QO(xO)
    end
    local function TO(eO, mO)
      local xO = n:FindFirstChild(eO)
      if xO then
        if xO:IsA("RemoteEvent") then
          U(xO.OnClientEvent, mO)
        end
      end
    end
    local function eO(mO)
      return function(xO)
        if xO then
          h.idleUntil = 0
        else
          qO(mO)
        end
      end
    end
    local function mO(xO, bO)
      local SO = Shared.s16
      local wO = SO()
      if wO then
        if not (xO) then
          return false
        end
      else
        return false
      end
      if (wO.Position - xO).Magnitude > 400 then
        SO = Shared.Vec3
        return aO(xO + SO(0, 3, 0), bO)
      end
      SO = Shared.Vec3
      return DO(xO + SO(0, 3, 0), bO)
    end
    local function xO(bO)
      if type(bO) == "table" then
        R.st, R.at = bO, os.clock()
      end
    end
    local function bO(SO)
      if type(SO) == "table" then
        _.snap, _.at = SO, os.clock()
      end
    end
    local function SO()
      local wO = IO("TrainEventPhase")
      if wO ~= nil then
        return wO
      end
      return ((R.st and ((os.clock() - R.at) < 10)) and R.st.Phase) or nil
    end
    _.me = function()
      local wO, ZO = _.snap, ipairs
      local WO = ((wO and (type(wO.Entries) == "table")) and wO.Entries) or {}
      for AO, AO in ZO(WO) do
        if type(AO) == "table" then
          wO = Shared.LocalPlayer
          if AO.UserId == wO.UserId then
            return AO
          end
        end
      end
    end
    _.held = function()
      local wO = _.snap
      return (((wO ~= nil) and (iO[wO.Phase] == true)) and ((os.clock() - _.at) < 30)) and (_.me() ~= nil)
    end
    gO = Shared.Core
    gO.inDim = zO
    local wO = Shared.Core
    wO.only = function()
      if _.held() then
        return "IslandWars"
      end
      local wO = SO()
      if nO[wO] then
        return "Train"
      elseif wO == "Town" then
        return "Train"
      else
        local ZO = Shared.LocalPlayer
        if ZO.Character then
          local ZO = Shared.LocalPlayer
          if ZO.Character:GetAttribute("TrainEventInForgottenTown") == true then
            return "Train"
          end
        end
      end
      wO = Shared.LocalPlayer
      if wO:GetAttribute("TrainEventTravelStage") == "Prepare" then
        return "Train"
      else
        local wO = Shared.Core
        if wO.trainBoard then
          local wO = Shared.Core
          if wO.trainBoard() then
            return "Train"
          end
        end
      end
      if h.busy then
        return "Halloween"
      elseif IO("GhostDogChase") ~= nil then
        return "Halloween"
      end
    end
    local wO = Shared.Core
    wO.realHum = function()
      return ((nO[SO()] == true) or _.held()) or zO()
    end
    local wO = Shared.Core
    wO.highOk = function()
      local wO = SO()
      local ZO, WO = ((zO() or (IO("InPumpkinArena") == true)) or (IO("GhostDogChase") ~= nil)) or ((wO ~= nil) and (wO ~= "Home"))
      if ZO then
        WO = ZO
      else
        wO = Shared.Core
        WO = wO.only() ~= nil
      end
      return WO
    end
    local function wO()
      local ZO = Shared.s59
      local WO = ZO()
      ZO = WO and WO.GuardTutorialProgress
      return (((WO ~= nil) and ((tonumber(WO.SpeedPower) or 0) >= (JO("HalloweenDimensionFlags", "SpeedPowerRequirement") or 2500000))) and (type(ZO) == "table")) and (ZO.Completed == true)
    end
    local function ZO(WO)
      if zO() then
        return true
      end
      local AO = Shared.s22
      local XO = AO("HalloweenDimensionPortal")
      AO = XO and (XO:FindFirstChild("Hitbox", true))
      if not (AO and (AO:IsA("BasePart"))) then
        XO = Shared.s10
        XO("Halloween portal is not here", "warn")
        return false
      end
      XO = Shared.s16
      local EO = XO()
      if EO then
        XO = Shared.s17
        if XO(EO.Position) then
          local oO = Shared.s18
          if not (oO(WO, "Halloween portal")) then
            return false
          end
        end
      end
      if not (Shared.s14(WO)) then
        return false
      end
      XO = Shared.s15
      if not (XO(WO, true)) then
        return false
      end
      local function oO(f7)
        VO(FO(f7), 6, WO)
        rO(1.5, WO)
        f7 = NO("HalloweenDimension")
        if type(f7) == "table" then
          if f7.TutorialSeen ~= true then
            task.spawn(Shared.Invoke, "RF/HalloweenDimension/AskTutorialSeen")
          end
        end
        return true
      end
      EO = Shared.s10
      EO("Teleporting to the Halloween portal")
      XO = Shared.s16
      EO = XO()
      if EO then
        if (EO.Position - AO.Position).Magnitude > 400 then
          local f7, f7 = Shared.Vec3, AO.Position + Shared.Vec3(0, 3, 0)
          if not (aO(f7, WO)) then
            return false
          end
        end
      end
      EO, XO = Shared.s32, Shared.CFrameNew
      EO(XO(AO.Position))
      OO(AO, zO, WO)
      if VO(zO, 2, WO) then
        return (oO(AO.Position))
      end
      if (os.clock() - (h.enterReset or -99)) > 20 then
        AO = Shared.Core
        if AO.respawn then
          h.enterReset = os.clock()
          oO = Shared.s10
          oO("The Halloween portal did not take you, resetting the character", "warn")
          XO = Shared.Core
          XO.respawn(true)
          return false
        end
      end
      AO = Shared.s10
      AO("The Halloween portal did not take you", "warn")
      return false
    end
    local aO = ((type(getgenv) == "function") and getgenv()) or _G
    local function WO(AO)
      h.entering = true
      aO.HalloweenPortalUse = os.clock() + 60
      local XO = Shared.s22
      local EO = XO("HalloweenDimensionPortal", "Hitbox")
      if EO then
        if EO:IsA("BasePart") then
          EO.CanTouch = true
        end
      end
      XO, EO = pcall(ZO, AO)
      h.entering = false
      aO.HalloweenPortalUse = 0
      if not XO then
        error(EO, 0)
      end
      return EO
    end
    local ZO
    local function AO()
      if ZO == nil then
        local XO = Shared.LocalPlayer
        local EO = XO:FindFirstChild("PlayerScripts")
        local oO
        if EO then
          XO = Shared.LocalPlayer
          oO = XO.PlayerScripts:FindFirstChild("PlayerModule")
        else
          oO = EO
        end
        if not oO then
          return false
        end
        EO, XO = pcall(function()
          return require(oO):GetControls()
        end)
        ZO = (EO and XO) or false
      end
      local XO, EO = pcall(function()
        local oO = ZO and ZO:GetMoveVector()
        return oO
      end)
      return (XO and (typeof(EO) == "Vector3")) and (EO.Magnitude > 0.1)
    end
    local ZO = {Halloween = true, Train = true, Ghouler = true, IslandWars = true}
    local function XO(EO)
      if h.entering then
        return true
      elseif (aO.HalloweenPortalUse or 0) > os.clock() then
        return true
      end
      if h.exitGuard then
        local aO = Shared.s16
        local oO = aO()
        if zO() then
          return false
        elseif oO then
          if (oO.Position - EO.Position).Magnitude < 20 then
            return false
          end
        else
          return false
        end
        h.exitGuard = false
      end
      EO = ((Shared.s4 == nil) or (ZO[Shared.s4.name] == true)) or AO()
      return EO
    end
    gO = Shared.LocalPlayer
    U(gO:GetAttributeChangedSignal("InHalloweenDimension"), function()
      if not (zO()) then
        h.exitGuard = true
        return
      end
      if not (h.entering) then
        if Shared.s4 then
          if not (ZO[Shared.s4.name]) then
            local aO = Shared.s10
            aO("Entered the dimension by accident, restarting " .. Shared.s4.name, "warn")
            qO(Shared.s4)
          end
        end
      end
    end)
    task.spawn(function()
      while true do
        local aO = Shared.Core
        if aO.hwPortalOff then
          break
        end
        aO = Shared.s22
        local ZO = aO("HalloweenDimensionPortal", "Hitbox")
        if ZO then
          if ZO:IsA("BasePart") then
            aO = XO(ZO)
            if ZO.CanTouch ~= aO then
              ZO.CanTouch = aO
            end
          end
        end
        ZO = Shared.WaitHeartbeat
        ZO()
      end
    end)
    local aO = Shared.Core
    aO.leaveDim = function(aO)
      for ZO = 1, 2, 1 do
        if not (zO()) then
          return true
        end
        local AO = YO()
        local XO = AO and (AO:FindFirstChild("ExitPortal", true))
        local EO = XO and (XO:FindFirstChild("Hitbox", true))
        if EO then
        else
          XO = AO and (AO:FindFirstChild("PortalHome", true))
          EO = XO and (XO:FindFirstChild("Portal") or XO:FindFirstChildWhichIsA("BasePart", true))
        end
        if not (EO) then
          break
        end
        AO = Shared.s10
        AO("Leaving the Halloween Dimension")
        XO, AO = Shared.s32, Shared.CFrameNew
        XO(AO(EO.Position))
        XO = uO(EO)
        OO(EO, function()
          return not zO()
        end, aO)
        if VO(function()
          return not zO()
        end, 10, aO) then
          h.idleUntil = math.max(h.idleUntil or 0, os.clock() + 3)
          VO(FO(XO), 6, aO)
          AO = Shared.Core
          AO.dimLeftAt = os.clock()
          rO(1.5, aO)
          return true
        end
        if ZO == 1 then
          if (os.clock() - (h.enterReset or -99)) > 20 then
            AO = Shared.Core
            if AO.respawn then
              h.enterReset = os.clock()
              XO = Shared.s10
              XO("The exit portal did not take you, resetting the character", "warn")
              local aO = Shared.Core
              aO.respawn(true)
              rO(1.5)
            end
          end
        end
      end
      return not zO()
    end
    local function aO(FO)
      local ZO = YO()
      local AO = ZO and (ZO:FindFirstChild("Zones"))
      AO = AO and (AO:FindFirstChild(FO))
      return ((AO and AO:IsA("BasePart")) and AO) or nil
    end
    local function FO(ZO, AO, XO)
      local EO = ZO.CFrame:PointToObjectSpace(AO)
      return (math.abs(EO.X) <= ((ZO.Size.X / 2) - (XO or 0))) and (math.abs(EO.Z) <= ((ZO.Size.Z / 2) - (XO or 0)))
    end
    local function ZO(AO)
      for XO = 3, 1, -1 do
        local EO = aO("Zone" .. XO)
        if EO then
          if FO(EO, AO) then
            return XO
          end
        end
      end
      return 0
    end
    local function AO()
      local XO, EO = aO("SafeZone"), Shared.s16
      local oO = EO()
      if XO then
        if not (oO) then
          return nil
        end
      else
        return nil
      end
      local EO, f7, p7 = XO.CFrame:PointToObjectSpace(oO.Position), math.max((XO.Size.X / 2) - 6, 0), math.max((XO.Size.Z / 2) - 6, 0)
      local y7, y7, s7 = Shared.Vec3, XO.CFrame:PointToWorldSpace(Shared.Vec3(math.clamp(EO.X, -f7, f7), EO.Y, math.clamp(EO.Z, -p7, p7))), Shared.Vec3
      return s7(y7.X, oO.Position.Y, y7.Z), XO
    end
    local XO = {}
    local function EO(oO)
      local f7, p7 = oO:GetAttribute("HalloweenEggUid"), oO:GetAttribute("PreparedSourceName")
      h.known = h.known or {}
      if f7 then
        if p7 then
          h.known[f7] = p7
        end
      end
      local y7 = (p7 or (f7 and h.known[f7])) or ("Mystery Egg (Zone " .. (tostring(oO:GetAttribute("Zone") or "?") .. ")"))
      if y7 == nil then
        return XO[y7] or y7
      elseif XO[y7] then
        return XO[y7] or y7
      end
      XO[y7] = y7
      pcall(function()
        local oO = require(a.Data.HalloweenPets).Specs
        if not (oO[y7]) then
          for f7, p7 in next, oO, nil do
            if type(p7) == "table" then
              if p7.EggSource == y7 then
                XO[y7] = p7.Id or f7
                break
              elseif p7.EggModel == y7 then
                XO[y7] = p7.Id or f7
                break
              end
            end
          end
        end
      end)
      return XO[y7]
    end
    local function XO(oO)
      local f7 = EO(oO)
      local p7, y7 = pcall(function()
        local s7 = Shared.Modules
        return s7.Assets.Directory[f7].EarningRate
      end)
      local f7 = (oO:IsA("Model") and (oO:GetScale())) or 1
      return ((p7 and tonumber(y7)) or 0) * (((f7 > 5) and (((f7 / 5) ^ 1.2) * 19.637875755794113)) or (f7 ^ 1.85))
    end
    local function oO(f7)
      if os.clock() >= (h.ixAt or 0) then
        h.ixAt = os.clock() + 5
        h.ix = {}
        local p7 = Shared.s59
        local y7 = p7() or {}
        local p7, s7, q7 = ((type(y7.Index) == "table") and y7.Index) or {}, {}, {"Inventory", "EggInventory"}
        for G7, G7 in ipairs(q7) do
          for q7, q7 in next, ((type(y7[G7]) == "table") and y7[G7]) or {}, nil do
            if type(q7) == "table" then
              s7[(q7.Category or q7.AssetCategory) or ""] = true
            end
          end
        end
        pcall(function()
          for y7, y7 in ipairs(require(a.Data.HalloweenIndex).GetSections()) do
            if y7.Category == "HalloweenWorldEggs" then
              for q7, q7 in ipairs(y7.Entries) do
                if p7[q7.AssetId] ~= true then
                  if not (s7[q7.AssetId]) then
                    h.ix[q7.AssetId] = true
                  end
                end
              end
            end
          end
        end)
      end
      return h.ix[f7] == true
    end
    local function f7(p7)
      local y7, s7 = EO(p7), Shared.s21
      if s7.hwEggOnly then
        local q7, G7 = Shared.s21, Shared.s67
        if not (q7.hwEggOnly[G7(y7)]) then
          return false
        end
      end
      s7 = Shared.s21
      if s7.hwMinV then
        local q7 = Shared.s21
        if XO(p7) < q7.hwMinV then
          return false
        end
      end
      p7 = Shared.s21
      if p7.hwRar then
        s7 = g(y7)
        local p7, y7 = (s7 and (type(s7.Rarity) == "table")) and (s7.Rarity.DisplayName or s7.Rarity._id), Shared.s21
        if not (y7.hwRar[p7]) then
          return false
        end
      end
      return true
    end
    local function p7(y7)
      local s7 = f7(y7)
      local f7
      if s7 then
        local q7 = Shared.Core
        f7 = q7.rank["Steal:filter"] or 9
      else
        f7 = s7
      end
      local s7, q7 = f7 or nil, Shared.s21
      if q7.hwIndex then
        if oO(EO(y7)) then
          f7 = nil
          f7, s7 = Shared.Core, math.min(s7 or 99, Shared.Core.rank["Steal:hwindex"] or 9)
        else
        end
      else
      end
      return s7
    end
    local function oO(f7)
      return p7(f7) ~= nil
    end
    local function f7()
      local y7, s7 = YO(), Shared.s16
      local q7, G7 = s7(), y7 and (y7:FindFirstChild("WorldEggs"))
      if G7 then
        if not (q7) then
          return nil
        end
      else
        return nil
      end
      local c7, a7, i7 = os.clock() < (h.retry or 0), ipairs, f[53](G7:GetChildren())
      for n7, M7 in a7(f:uT(i7)) do
        s7 = Shared.Core
        if s7.hwPick then
          n7 = Shared.Core
          if M7:GetAttribute("HalloweenEggUid") == n7.hwPick then
            y7 = M7:FindFirstChild("StealPrompt", true)
            if y7 then
              if y7.Enabled then
                h.pickRank = nil
                return M7, ZO(uO(M7))
              end
            end
            if c7 then
              return nil
            end
          end
        end
      end
      y7 = Shared.Core
      y7.hwPick = nil
      h.retry = 0
      i7, c7, y7, a7, s7 = nil
      for n7, M7 in ipairs(G7:GetChildren()) do
        n7 = M7:FindFirstChild("StealPrompt", true)
        local G7 = (((n7 and n7:IsA("ProximityPrompt")) and n7.Enabled) and ((h.bad[M7] or 0) < os.clock())) and p7(M7)
        if G7 then
          n7 = uO(M7)
          local p7 = n7 and (ZO(n7))
          if p7 then
            if p7 >= 1 then
              local p7, H7, U7 = (n7 - q7.Position).Magnitude, XO(M7), (h.oi or {})[M7:GetAttribute("HalloweenEggUid")] or math.huge
              if (if i7 then U7 < c7 else not i7) or ((U7 == c7) and ((G7 < y7) or ((G7 == y7) and ((H7 > a7) or ((H7 == a7) and (p7 < s7)))))) then
                i7, c7, y7, a7, s7 = M7, U7, G7, H7, p7
              else
              end
            else
            end
          else
          end
        else
        end
      end
      h.pickRank = y7
      return i7, (i7 and ZO(uO(i7))) or 0
    end
    local p7 = Shared.Core
    p7.hwBeats = function(p7, y7, s7)
      local q7 = Shared.Core
      if q7.hwPick then
        return true
      end
      q7 = Shared.Core
      local G7, c7 = q7.rank["Steal:" .. tostring(s7.kind)] or 99
      if p7 then
        c7 = p7
      else
        q7 = Shared.Core
        c7 = q7.rank["Steal:filter"]
      end
      p7 = c7 or 99
      if p7 ~= G7 then
        return p7 < G7
      end
      q7 = Shared.Core
      c7, G7 = q7.hwTurnNow
      if c7 then
        q7 = Shared.Core
        G7 = q7.hwTurnNow()
      else
        G7 = c7
      end
      return (G7 == true) or ((G7 == nil) and (y7 > s7.v))
    end
    local function p7(y7, s7)
      local q7 = YO()
      local G7 = q7 and (q7:FindFirstChild("WorldEggs"))
      task.spawn(Shared.Invoke, "RF/HalloweenDimension/AskDropEgg")
      local c7, a7, i7 = os.clock() + 3, false, 0
      while s7() and (os.clock() < c7) do
        if IO("HalloweenCarrying") ~= true then
          a7 = true
        else
          if a7 then
            return true
          end
        end
        q7 = nil
        for s7, s7 in ipairs((G7 and G7:GetChildren()) or {}) do
          q7 = if s7:GetAttribute("HalloweenEggUid") == y7 then s7 else q7
        end
        local y7 = q7 and (q7:FindFirstChild("StealPrompt", true))
        if a7 then
          if y7 then
            if y7.Enabled then
              if (os.clock() - i7) > 0.6 then
                local s7, G7, c7 = os.clock(), Shared.s32, Shared.CFrameNew
                G7(c7(uO(q7) + Shared.Vec3(0, 3, 0)))
                hO(y7)
                i7 = s7
              else
              end
            else
            end
          else
          end
        else
        end
        y7 = Shared.WaitHeartbeat
        y7()
      end
    end
    local function y7(s7, q7)
      local G7 = os.clock() + 15
      while (q7() and (IO("HalloweenCarrying") == true)) and (os.clock() < G7) do
        local q7 = Shared.s16
        local G7 = q7()
        if not (G7) then
          return
        end
        q7 = Shared.Vec3
        local c7 = q7(s7.X, G7.Position.Y, s7.Z) - G7.Position
        if c7.Magnitude < 2 then
          return true
        end
        local s7, q7 = Shared.s32, Shared.CFrameNew
        s7(q7(G7.Position + (c7.Unit * math.min(c7.Magnitude, Shared.s21.hwStep or 40))))
        q7 = Shared.WaitHeartbeat
        q7()
      end
    end
    local function s7(q7)
      local G7 = IO("HalloweenDelivered")
      local c7, a7, i7, n7, M7 = os.clock() + 60, {}, h.carryUid, aO("SafeZone"), Shared.s16
      local H7 = M7()
      h.doing = "Carrying an egg to safety"
      M7 = Shared.s10
      M7("Halloween: carrying the egg to safety")
      M7 = Shared.s21
      if (((M7.hwInstant and i7) and n7) and H7) and (IO("HalloweenCarrying") == true) then
        local U7, L7, I7 = n7.CFrame:PointToObjectSpace(H7.Position), (n7.Size.X / 2) + 10, (n7.Size.Z / 2) + 10
        h.doing = "Carrying: instant steal"
        local t7, t7 = Shared.Vec3, n7.CFrame:PointToWorldSpace(Shared.Vec3(math.clamp(U7.X, -L7, L7), 0, math.clamp(U7.Z, -I7, I7)))
        y7(t7, q7)
        for B7 = 1, 4, 1 do
          L7, U7 = os.clock() + 0.8, false
          while (q7() and (IO("HalloweenCarrying") == true)) and (os.clock() < L7) do
            B7 = Shared.s16
            I7 = B7()
            if I7 and (lO(I7.Position - t7).Magnitude >= 100) then
              U7 = true
              break
            end
            local L7 = Shared.WaitHeartbeat
            L7()
          end
          if not U7 then
            break
          end
          h.doing = "Pulled back, stepping to the safe zone edge again"
          y7(t7, q7)
        end
        if q7() then
          if p7(i7, q7) then
            rO(0.5, q7)
          end
        end
      end
      H7 = nil
      while (q7() and (IO("HalloweenCarrying") == true)) and (os.clock() < c7) do
        M7 = Shared.s16
        n7, i7 = M7(), aO("SafeZone")
        if n7 then
          if i7 then
            local p7 = Shared.LocalPlayer
            if not (p7.Character) then
              break
            end
          else
            break
          end
        else
          break
        end
        H7 = H7 or n7.Position.Y
        local p7 = Shared.LocalPlayer
        for y7, y7 in ipairs(p7.Character:GetDescendants()) do
          if y7:IsA("BasePart") then
            if y7.CanCollide then
              a7[y7] = true
              y7.CanCollide = false
            end
          end
        end
        local y7, U7 = i7.CFrame:PointToObjectSpace(n7.Position), Shared.s21
        p7 = (U7.hwInstant and 6) or 40
        local L7, I7 = math.max((i7.Size.X / 2) - p7, 0), math.max((i7.Size.Z / 2) - p7, 0)
        p7, U7 = Shared.Vec3, lO(i7.CFrame:PointToWorldSpace(Shared.Vec3(math.clamp(y7.X, -L7, L7), y7.Y, math.clamp(y7.Z, -I7, I7))) - n7.Position)
        y7, L7 = U7.Magnitude > 3
        if y7 then
          I7 = nil
          I7, L7 = Shared.s21, U7.Unit * math.min(P() * ((Shared.s21.hwInstant and 1) or 1.5), U7.Magnitude / 0.05)
        else
          L7 = y7
        end
        I7 = nil
        if L7 then
          I7 = L7
        else
          y7 = Shared.Vec3Zero
          I7 = y7
        end
        U7 = Shared.Vec3
        n7.AssemblyLinearVelocity = I7 + U7(0, (H7 - n7.Position.Y) * 8, 0)
        U7 = Shared.WaitHeartbeat
        U7()
      end
      q7 = Shared.s16
      H7 = q7()
      if H7 then
        M7 = Shared.Vec3Zero
        H7.AssemblyLinearVelocity = M7
      end
      for p7 in next, a7, nil do
        if p7.Parent then
          p7.CanCollide = true
        end
      end
      if IO("HalloweenCarrying") == true then
        if os.clock() >= c7 then
          M7 = Shared.Invoke
          M7("RF/HalloweenDimension/AskDropEgg")
        end
      end
      VO(function()
        return IO("HalloweenDelivered") ~= G7
      end, 0.6)
      if IO("HalloweenDelivered") ~= G7 then
        i7, a7 = Shared.Core, Shared.Core
        i7.lastEgg, a7.lastEggAt = "halloween", os.clock()
        H7 = Shared.s10
        H7("Halloween egg secured", "ok")
      end
    end
    local function p7(y7)
      return QO(function()
        return s7(y7)
      end)
    end
    local function y7(s7, q7)
      local G7, c7 = f7()
      local a7
      if q7 and q7.Parent then
        c7 = ZO(uO(q7))
        a7 = q7
      else
        a7 = G7
      end
      if not a7 then
        return false
      end
      local G7 = a7:FindFirstChild("StealPrompt", true)
      h.doing = "Stealing a zone " .. (c7 .. " egg")
      q7 = Shared.s10
      q7("Halloween: going to a zone " .. (c7 .. " egg"))
      local function i7()
        return ((s7() and (a7.Parent ~= nil)) and G7.Enabled) and (IO("HalloweenCarrying") ~= true)
      end
      q7 = a7:GetAttribute("HalloweenEggUid")
      h.cur = {Uid = q7, n = EO(a7), cat = EO(a7), v = XO(a7), s = (a7:IsA("Model") and a7:GetScale()) or 1, tg = true, hw = true, zone = c7, cur = true}
      for c7 = 1, 3, 1 do
        c7 = uO(a7)
        if c7 then
          if not (i7()) then
            break
          end
        else
          break
        end
        local n7 = Shared.s21
        if n7.hwInstant then
          local M7 = os.clock() + 3
          while i7() and (os.clock() < M7) do
            local M7 = Shared.s16
            local H7, U7 = M7(), uO(a7)
            if H7 then
              if not (U7) then
                break
              end
            else
              break
            end
            M7 = Shared.Vec3
            local L7 = (U7 + M7(0, 3, 0)) - H7.Position
            if L7.Magnitude < 3 then
              break
            end
            M7, U7 = Shared.s32, Shared.CFrameNew
            M7(U7(H7.Position + (L7.Unit * math.min(L7.Magnitude, Shared.s21.hwStep or 40))))
            H7 = Shared.WaitHeartbeat
            H7()
          end
        end
        n7 = Shared.s16
        local M7 = n7()
        if if M7 then (M7.Position - c7).Magnitude > 20 else not M7 then
          n7 = Shared.Vec3
          if not (DO(c7 + n7(0, 3, 0), i7)) then
            break
          end
        end
        c7, M7 = os.clock() + 4, 0
        while i7() and (os.clock() < c7) do
          n7 = uO(a7)
          if n7 then
            local c7, H7, U7 = Shared.s32, Shared.CFrameNew, Shared.Vec3
            c7(H7(n7 + U7(0, 3, 0)))
          end
          if (os.clock() - M7) > 0.6 then
            M7 = os.clock()
            hO(G7)
          else
          end
          local G7 = Shared.WaitHeartbeat
          G7()
        end
        if IO("HalloweenCarrying") == true then
          break
        end
      end
      if IO("HalloweenCarrying") == true then
        i7 = Shared.Core
        if i7.hwPick == q7 then
          local G7 = Shared.Core
          G7.hwPick = nil
        end
        h.carryUid = q7
        local G7 = Shared.Core
        local c7 = G7.lastEggAt
        p7(s7)
        if (IO("HalloweenCarrying") ~= true) and ((h.qd or 0) >= 2) then
          h.bad[a7] = os.clock() + 60
          h.qd = 0
          G7 = Shared.s10
          G7("Halloween: that egg keeps dropping, skipping it", "warn")
        elseif IO("HalloweenCarrying") ~= true then
          local s7 = Shared.Core
          if s7.lastEggAt == c7 then
            if a7.Parent then
              local s7 = Shared.Core
              s7.hwPick, h.retry = q7, os.clock() + 60
              s7 = Shared.s10
              s7("Halloween: dropped the egg, going back for it")
            end
          end
        end
        G7 = Shared.Core
        if G7.lastEggAt ~= c7 then
          local s7 = Shared.Core
          s7.hwPick = nil
          h.retry = 0
        end
      elseif a7.Parent then
        h.bad[a7] = os.clock() + 30
      end
      h.cur = nil
      return true
    end
    gO = Shared.LocalPlayer
    U(gO:GetAttributeChangedSignal("HalloweenCarrying"), function()
      if IO("HalloweenCarrying") == true then
        h.ca = os.clock()
      elseif h.ca then
        h.qd = (((os.clock() - h.ca) < 0.6) and ((h.qd or 0) + 1)) or 0
        h.ca = nil
      end
    end)
    local function s7(q7, G7)
      local c7, a7 = pcall(QO, function()
        return y7(q7, G7)
      end)
      h.cur = nil
      if not (c7) then
        error(a7, 0)
      end
      return a7
    end
    local function y7(q7)
      local G7 = AO()
      if not (G7) then
        return
      end
      h.doing = "Healing in the safe zone"
      local c7 = Shared.s10
      c7("Halloween: low health, healing in the safe zone")
      DO(G7, q7)
      VO(function()
        local G7 = Shared.s8
        local c7 = G7()
        return if c7 then c7.Health >= (c7.MaxHealth * 0.85) else not c7
      end, 25, q7)
    end
    TO("RE/HalloweenDimension/MonsterHit", function()
      h.hitAt = os.clock()
    end)
    local function q7(G7)
      local c7, a7 = RaycastParams.new(), YO()
      c7.FilterType = Enum.RaycastFilterType.Exclude
      local i7, n7 = {}, Shared.LocalPlayer
      f:yT(i7, 0, n7.Character, a7 and (a7:FindFirstChild("Monsters")), a7 and (a7:FindFirstChild("Ghosts")))
      c7.FilterDescendantsInstances = i7
      n7, a7, i7 = Shared.Vec3, Shared.Vec3, workspace:Raycast(G7 + Shared.Vec3(0, 25, 0), Shared.Vec3(0, -80, 0), c7)
      c7 = nil
      if i7 then
        local a7 = Shared.Vec3
        c7 = a7(G7.X, i7.Position.Y + 3, G7.Z)
      else
        c7 = i7
      end
      return c7 or G7
    end
    local function G7(c7, a7)
      local i7 = Shared.s16
      local n7, M7 = i7(), Shared.s8
      i7 = M7()
      if n7 then
        if not i7 then
          return
        end
      else
        return
      end
      M7 = lO(c7 - n7.Position)
      h.ws0 = h.ws0 or jO(i7)
      local H7 = c7.Y - n7.Position.Y
      local U7 = ((H7 > 2) and math.min(H7 * 6, 40)) or math.min(n7.AssemblyLinearVelocity.Y, 8)
      if M7.Magnitude > 2 then
        i7.WalkSpeed = a7
        H7 = Shared.Vec3
        i7:MoveTo(H7(c7.X, n7.Position.Y, c7.Z))
        local c7
        c7, n7.AssemblyLinearVelocity = Shared.Vec3, (M7.Unit * math.min(a7, M7.Magnitude / 0.05)) + Shared.Vec3(0, U7, 0)
      else
        i7:MoveTo(n7.Position)
        local c7 = Shared.Vec3
        n7.AssemblyLinearVelocity = c7(0, U7, 0)
      end
    end
    local function c7()
      local a7 = Shared.s8
      local i7, n7 = a7(), Shared.s16
      a7 = n7()
      if a7 then
        n7 = Shared.Vec3
        a7.AssemblyLinearVelocity = n7(0, math.min(a7.AssemblyLinearVelocity.Y, 0), 0)
      end
      if i7 then
        i7:MoveTo((a7 and a7.Position) or i7.WalkToPoint)
        if h.ws0 then
          i7.WalkSpeed = h.ws0
          h.ws0 = nil
        end
      end
    end
    local function a7(i7, n7, M7)
      local H7 = os.clock() + 25
      while n7() and (os.clock() < H7) do
        local H7 = Shared.s16
        local U7 = H7()
        if U7 then
          if lO(i7 - U7.Position).Magnitude < 3 then
            if (i7.Y - U7.Position.Y) < 2 then
              break
            end
          end
        else
          break
        end
        G7(i7, M7)
        U7 = Shared.WaitHeartbeat
        U7()
      end
      c7()
      return n7()
    end
    local function i7()
      if not (h.bats) then
        h.bats = {}
        h.wpn = {}
        local n7, M7 = next, Shared.Core
        local H7 = M7.weaponName
        for U7 in n7, H7, nil do
          M7 = Shared.Modules
          local n7 = M7.Gears.Directory[U7]
          if type(n7) == "table" then
            h.bats[U7] = (n7.BatControllerData ~= nil) or nil
            h.wpn[U7] = ((n7.BatControllerData or (n7.ToolController == "Slap")) and true) or nil
          end
        end
      end
      local n7 = Shared.s21
      local M7, H7, U7 = n7.hwWeap or h.wpn, {}, Shared.LocalPlayer
      local L7, I7, t7, B7 = U7.Character, ipairs, {}, Shared.LocalPlayer
      f:yT(t7, 0, L7, B7:FindFirstChildOfClass("Backpack"))
      for K7, K7 in I7(t7) do
        for P7, P7 in ipairs((K7 and K7:GetChildren()) or {}) do
          if P7:IsA("Tool") then
            if M7[o(P7)] then
              if h.wpn[o(P7)] then
                H7[#H7 + 1] = P7
              end
            end
          end
        end
      end
      if #H7 == 0 then
        I7 = Shared.Core
        return I7.bat()
      end
      table.sort(H7, function(M7, K7)
        return M7.Name < K7.Name
      end)
      t7 = L7 and (L7:FindFirstChildOfClass("Tool"))
      L7 = t7 and table.find(H7, t7)
      local function M7(K7)
        return tonumber(K7:GetAttribute("CooldownEndTime")) or 0
      end
      I7 = H7[1]
      if L7 then
        if #H7 == 1 then
          return t7
        elseif not ((os.clock() - (h.wAt or 0)) >= 0.5) then
          if M7(t7) == h.wCd then
            return t7
          end
        end
        n7 = nil
        for t7 = 1, #H7 - 1, 1 do
          B7 = H7[(((L7 + t7) - 1) % #H7) + 1]
          U7 = M7(B7) - K()
          if U7 <= 0 then
            I7 = B7
            break
          end
          if n7 then
            if U7 < n7 then
              I7, n7 = B7, U7
            else
            end
          else
            I7, n7 = B7, U7
          end
        end
      else
      end
      h.wAt, h.wCd = os.clock(), M7(I7)
      return I7
    end
    local n7 = Shared.Core
    n7.hwNeedVis = function()
      return os.clock() < (h.visUntil or 0)
    end
    local function n7(M7, H7)
      h.visUntil = os.clock() + 20
      local U7 = Shared.Core
      if U7.needBody then
        local U7 = Shared.Core
        if not (U7.needBody()) then
          h.doing = "Turning visible " .. M7
          rO(0.5, H7)
          return false
        end
      end
      return true
    end
    local function M7(H7)
      if not (n7("to farm monsters", H7)) then
        return true
      end
      local U7 = Shared.Core
      local L7, I7 = U7.bat(), Shared.s8
      U7 = I7()
      if not (L7) then
        h.doing = "Get a bat to fight monsters"
        return false
      end
      if U7 then
        if U7.Health < (U7.MaxHealth * 0.4) then
          y7(H7)
          return true
        end
      end
      U7 = Shared.s16
      I7 = U7()
      if not I7 then
        return false
      end
      local y7
      local t7, B7, K7, P7 = math.huge, {Small = 12, Medium = 28, Large = 65}, ipairs, f[53](C:GetTagged("HalloweenMonster"))
      for C7, J7 in K7(f:uT(P7)) do
        U7, C7 = J7:IsDescendantOf(workspace) and (J7:GetAttribute("KilledBy") == nil)
        if U7 then
          local v7 = Shared.s21
          local N7 = v7.hwMonKinds
          v7 = not N7
          if N7 then
            local N7 = Shared.s21
            C7 = N7.hwMonKinds[J7.Name]
          else
            C7 = v7
          end
        else
          C7 = U7
        end
        local v7 = C7 and (uO(J7))
        local N7, z7 = v7 and (v7 - I7.Position).Magnitude
        if N7 then
          C7 = Shared.s21
          z7 = ((C7.hwMonOrder == "Most tokens") and (N7 - ((B7[J7:GetAttribute("MonsterSize")] or 0) * 1000))) or N7
        else
          z7 = N7
        end
        if (z7 and (z7 < t7)) and not (aO("SafeZone") and FO(aO("SafeZone"), v7)) then
          y7 = J7
          t7 = z7
        else
        end
      end
      t7 = (y7 and (uO(y7) - I7.Position).Magnitude) or t7
      if not y7 then
        return false
      end
      h.doing = "Fighting " .. (tostring(y7:GetAttribute("MonsterSize") or "a") .. " monster")
      local function aO()
        local C7, J7 = ((H7() and (y7.Parent ~= nil)) and (y7:GetAttribute("KilledBy") == nil)) and (IO("HalloweenCarrying") ~= true)
        if C7 then
          local H7 = Shared.s8
          local v7 = H7()
          H7 = not v7
          if v7 then
            local v7, N7 = Shared.s8
            N7, J7 = Shared.s8, v7().Health >= (Shared.s8().MaxHealth * 0.4)
          else
            J7 = H7
          end
        else
          J7 = C7
        end
        return J7
      end
      K7 = uO(y7)
      if t7 > 30 then
        B7 = Shared.s21
        if not (a7(q7(K7), aO, B7.hwMonSp)) then
          return true
        end
      end
      U7 = os.clock() + 15
      while aO() and (os.clock() < U7) do
        K7, I7 = uO(y7), Shared.s16
        P7 = I7()
        if K7 then
          if not P7 then
            break
          end
        else
          break
        end
        B7 = lO(P7.Position - K7)
        local aO, y7 = (B7.Magnitude > 0.1) and B7.Unit
        if aO then
          y7 = aO
        else
          local H7 = Shared.Vec3
          y7 = (H7(0, 0, 1))
        end
        aO = Shared.s21
        G7(q7(K7 + (y7 * 4)), aO.hwMonSp)
        kO(K7)
        y7 = i7() or L7
        _O(y7)
        if h.bats then
          if not (h.bats[o(y7)]) then
            aO = Shared.LocalPlayer
            if y7.Parent == aO.Character then
              if K() >= (tonumber(y7:GetAttribute("CooldownEndTime")) or 0) then
                if (os.clock() - (h.trig or 0)) > 0.1 then
                  if (os.clock() - (h.wAt or 0)) > 0.15 then
                    h.trig = os.clock()
                    t("RE/ToolTrigger/Trigger", y7)
                  end
                end
              end
            end
          end
        end
        y7 = Shared.WaitHeartbeat
        y7()
      end
      c7()
      return true
    end
    local function o(aO)
      return QO(function()
        return M7(aO)
      end)
    end
    local function aO(y7)
      local q7 = YO()
      if not (q7) then
        return false
      end
      local i7 = q7:FindFirstChild("Altar")
      i7 = i7 and (i7:FindFirstChild("PumpkinDeposit"))
      if IO("HalloweenPumpkinCarrying") == true then
        h.doing = "Bringing a pumpkin to the altar"
        if i7 and (i7:GetAttribute("Open") ~= false) then
          local function M7()
            return y7() and (IO("HalloweenPumpkinCarrying") == true)
          end
          local H7, H7 = Shared.Vec3, (uO(i7:FindFirstChild("Target")) or i7.Position) + Shared.Vec3(0, 3, 0)
          QO(function()
            local U7 = Shared.s21
            return a7(H7, M7, U7.hwPumpSp)
          end)
          for H7 = 1, 4, 1 do
            if not (M7()) then
              break
            end
            local H7, U7 = Shared.s32, Shared.CFrameNew
            H7(U7(i7.Position + Shared.Vec3(0, 3, 0)))
            OO(i7)
            hO(i7:FindFirstChildWhichIsA("ProximityPrompt", true))
            rO(0.3, M7)
          end
        else
          rO(0.5, y7)
        end
        return true
      end
      local OO, i7 = q7:FindFirstChild("RunawayPumpkins"), Shared.s16
      local M7, H7, U7 = i7(), math.huge
      for L7, I7 in ipairs((OO and OO:GetChildren()) or {}) do
        q7 = I7:IsA("Model") and I7:FindFirstChild("CatchPrompt", true)
        i7 = (q7 and q7.Enabled) and uO(I7)
        L7 = (i7 and M7) and (i7 - M7.Position).Magnitude
        if L7 then
          if L7 < H7 then
            H7, U7 = L7, I7
          else
          end
        else
        end
      end
      if not (U7) then
        h.doing = "Looking for pumpkins"
        return false
      end
      h.doing = "Catching a pumpkin"
      M7 = os.clock() + 10
      h.move = true
      while (((y7() and U7.Parent) and (U7:FindFirstChild("CatchPrompt", true))) and (os.clock() < M7)) and (IO("HalloweenPumpkinCarrying") ~= true) do
        i7, OO = uO(U7), Shared.s16
        q7 = OO()
        if i7 then
          if not q7 then
            break
          end
        else
          break
        end
        local y7, H7 = i7 - q7.Position, U7:FindFirstChild("CatchPrompt", true)
        if H7 then
          if H7:IsA("ProximityPrompt") then
            if y7.Magnitude <= (H7.MaxActivationDistance + 2) then
              hO(H7)
            end
          end
        end
        H7 = Shared.s21
        G7(i7, H7.hwPumpSp)
        H7 = Shared.WaitHeartbeat
        H7()
      end
      h.move = false
      dO(false)
      c7()
      M7 = Shared.s16
      OO = M7()
      if OO then
        q7 = Shared.Vec3Zero
        OO.AssemblyLinearVelocity = q7
      end
      return true
    end
    local function OO(y7)
      local q7 = YO()
      local G7 = q7 and (q7:FindFirstChild("GhostDogQuest"))
      G7 = G7 and (G7:FindFirstChild("Markers"))
      q7 = G7 and (G7:FindFirstChild(y7))
      return ((q7 and q7:IsA("BasePart")) and q7) or nil
    end
    local function y7(q7, G7)
      local c7 = OO(q7)
      local i7, M7 = c7 ~= nil
      if i7 then
        q7 = nil
        q7, M7 = Shared.Vec3, DO(c7.Position + Shared.Vec3(0, 3, 0), G7)
      else
        M7 = i7
      end
      return M7
    end
    local function q7(G7, c7, i7)
      local M7, H7
      for U7 = 1, 3, 1 do
        local U7, L7, I7 = Shared.Invoke
        L7, L7, I7 = U7("RF/GhostDogQuest/Talk", c7)
        if L7 then
          M7, H7 = L7, I7
          break
        elseif type(I7) == "string" then
          if not (I7:lower():find("closer")) then
            M7, H7 = L7, I7
            break
          end
        else
          M7, H7 = L7, I7
          break
        end
        y7(G7, i7)
        rO(0.4, i7)
        M7, H7 = L7, I7
      end
      return M7, H7
    end
    local function G7()
      local c7 = NO("GhostDogQuest")
      return ((type(c7) == "table") and tonumber(c7.Stage)) or 0, ((type(c7) == "table") and c7) or {}
    end
    local function c7()
      return RO(function(i7)
        return i7:GetAttribute("GhostDogRod") == true
      end)
    end
    local function i7()
      local M7, H7 = G7()
      local U7 = 0
      for L7 in next, ((type(H7.Artifacts) == "table") and H7.Artifacts) or {}, nil do
        U7 += 1
      end
      return ((M7 * 10) + U7) + ((c7() and 5) or 0)
    end
    local function M7(H7, U7, L7)
      local I7, t7 = pcall(require, a.Data.GhostDogQuest)
      local function B7(K7)
        local P7, C7 = pcall(t7.ChaseFrame, H7, K7)
        return ((P7 and (typeof(C7) == "CFrame")) and C7) or nil
      end
      if I7 then
        if type(t7) == "table" then
          if not (B7(0)) then
            return false
          end
        else
          return false
        end
      else
        return false
      end
      h.busy = true
      h.doing = "Underwater chase"
      I7 = Shared.s10
      I7("Ghost Dog: underwater chase")
      local H7, t7 = pcall(function()
        VO(function()
          local K7 = Shared.s16
          local P7, C7 = K7(), B7(0)
          return (P7 and C7) and ((P7.Position - C7.Position).Magnitude < 40)
        end, 8, L7)
        local K7 = Shared.s8
        local P7, C7 = K7(), CFrame.Angles(-1.2566, 0, 0)
        if P7 then
          P7.PlatformStand = true
        end
        P7 = os.clock() + 4
        while L7() and (os.clock() < P7) do
          K7 = Shared.s32
          K7(B7(0) * C7)
          local J7 = Shared.WaitHeartbeat
          J7()
        end
        P7, K7 = os.clock(), U7 * (JO("GhostDogQuestFlags", "ChaseSpeed") or 58)
        while L7() and (IO("GhostDogChase") ~= nil) do
          local U7 = math.min((os.clock() - P7) * (JO("GhostDogQuestFlags", "ChaseSpeed") or 58), K7)
          local L7 = B7(U7)
          if L7 then
            local J7 = Shared.s32
            J7(L7 * C7)
          end
          if U7 >= K7 then
            break
          end
          U7 = Shared.WaitHeartbeat
          U7()
        end
        P7 = false
        for U7 = 1, 8, 1 do
          local L7 = Shared.Invoke
          local J7, J7 = L7("RF/GhostDogQuest/Claim")
          if J7 == true then
            P7 = true
            break
          end
          if U7 == 4 then
            L7 = os.clock() + 5
            while os.clock() < L7 do
              J7 = B7(K7)
              if J7 then
                local U7 = Shared.s32
                U7(J7 * C7)
              end
              local U7 = Shared.WaitHeartbeat
              U7()
            end
          else
            task.wait(0.7)
          end
        end
        task.wait((P7 and 3) or 0.5)
        for U7 = 1, 3, 1 do
          C7 = Shared.Invoke
          U7, K7 = C7("RF/GhostDogQuest/Surface")
          if K7 == true then
            break
          end
          task.wait(0.5)
        end
        VO(function()
          local U7, L7 = OO("ReturnSpot"), Shared.s16
          local B7 = L7()
          return if U7 then B7 and ((B7.Position - U7.Position).Magnitude < 25) else not U7
        end, 6)
        return P7
      end)
      I7 = Shared.s8
      local U7 = I7()
      if U7 then
        U7.PlatformStand = false
      end
      I7 = Shared.Invoke
      I7("RF/GhostDogQuest/Abort")
      h.busy = false
      return H7 and t7
    end
    local function H7(U7)
      local L7, I7 = pcall(require, a.Controllers.Game.FishingController[U7])
      return (L7 and I7) or nil
    end
    local function U7(L7, I7)
      local t7 = Shared.s16
      if not (t7()) then
        return nil
      end
      kO(L7)
      local B7, B7, K7, P7, C7 = Shared.s21, 1.2 * ((({["x1.2"] = 1, ["x1.1"] = 0.5, ["x1.0 Fastest"] = 0.02})[Shared.s21.hwLuck] or 0.875) ^ 0.7142857142857143), H7("Ui"), pcall(require, a.Shared.Util.Fishing)
      local J7, v7 = pcall(require, a.Shared.Flags.FishingFlags)
      t("RE/Fishing/Hold")
      local N7, z7 = os.clock(), false
      while (os.clock() - N7) < B7 do
        if not (I7()) then
          if K7 then
            pcall(K7.ShowCharge, false)
          end
          return nil
        end
        t7 = (((os.clock() - N7) - B7) + 0.25) / 0.2
        if K7 then
          if P7 then
            if t7 >= 0 then
              if z7 then
              else
                pcall(K7.ShowCharge, true, (J7 and v7.PerfectMin:Get()) or 0.8, (J7 and v7.PerfectMax:Get()) or 0.95)
                z7 = true
              end
              local z7, Y7 = C7.ChargeAt(B7) * math.min(t7, 1), Shared.LocalPlayer
              local l7, u7 = Y7.Character
              if l7 then
                Y7 = Shared.LocalPlayer
                u7 = Y7.Character:FindFirstChild("Head")
              else
                u7 = l7
              end
              l7 = workspace.CurrentCamera
              Y7 = u7 and l7:WorldToViewportPoint(u7.Position)
              pcall(K7.SetCharge, z7, C7.LuckText(C7.LuckFor(z7)), C7.IsPerfect(z7), Y7 and Vector2.new(Y7.X / l7.ViewportSize.X, Y7.Y / l7.ViewportSize.Y))
            else
            end
          else
          end
        else
        end
        local z7 = Shared.WaitHeartbeat
        z7()
      end
      if K7 then
        pcall(K7.ShowCharge, false)
        J7 = Shared.LocalPlayer
        N7, v7 = J7.Character
        if N7 then
          t7 = Shared.LocalPlayer
          v7 = t7.Character:FindFirstChild("Head")
        else
          v7 = N7
        end
        if v7 then
          if P7 then
            if C7.IsPerfect(C7.ChargeAt(B7)) then
              I7 = workspace.CurrentCamera
              local C7, C7 = Shared.Vec3, I7:WorldToViewportPoint(v7.Position + Shared.Vec3(0, 2.6, 0))
              pcall(K7.Perfect, Vector2.new(C7.X / I7.ViewportSize.X, C7.Y / I7.ViewportSize.Y))
            end
          end
        end
      end
      P7 = Shared.Invoke
      J7, I7, t7 = P7("RF/Fishing/Cast", B7, L7)
      if type(I7) ~= "table" then
        P7 = Shared.s10
        P7("Fishing: " .. tostring(t7 or "no answer"), "warn")
      end
      return ((type(I7) == "table") and I7) or nil, t7
    end
    local function L7(I7, t7, B7)
      if not (rO(3.5, B7)) then
        local K7 = Shared.Invoke
        K7("RF/GhostDogQuest/Abort")
        return false
      end
      local K7 = Shared.Invoke
      K7("RF/GhostDogQuest/Dive")
      return M7(I7, t7, B7)
    end
    local function M7(I7, t7)
      if not (rO((tonumber(I7.Wait) or 3) + 0.45, t7)) then
        return
      end
      local B7 = Shared.Invoke
      local K7, K7 = B7("RF/GhostDogQuest/Cast", I7.Id)
      if type(K7) ~= "number" then
        B7 = Shared.Invoke
        B7("RF/GhostDogQuest/Abort")
        return
      end
      if L7(K7, JO("GhostDogQuestFlags", "FishChaseSeconds") or 25, t7) then
        W("Fishing", "Caught a Ghost Fish!", "ok")
      end
    end
    local function I7(t7)
      local B7, K7 = G7()
      local P7 = i7()
      local C7
      h.doing = "Ghost Dog quest, step " .. (B7 + 1)
      if B7 == 0 then
        if y7("DogSpot", t7) then
          C7 = q7("DogSpot", "Dog", t7)
          VO(function()
            return G7() >= 1
          end, 5, t7)
        else
        end
      else
        if B7 == 1 then
          local J7, v7, N7 = ipairs, {"Collar", "Bone", "Toy", "Photo"}, true
          for z7, Y7 in J7(v7) do
            if (type(K7.Artifacts) == "table") and K7.Artifacts[Y7] then
            else
              N7 = false
              if t7() then
                if y7("Artifact_" .. Y7, t7) then
                  rO(0.3, t7)
                  z7 = Shared.Invoke
                  local K7, K7 = z7("RF/GhostDogQuest/Collect", Y7)
                  rO(0.5, t7)
                  C7 = K7
                else
                end
              else
              end
            end
          end
          if N7 then
            if y7("DogSpot", t7) then
              J7 = q7("DogSpot", "Dog", t7)
              VO(function()
                return G7() >= 2
              end, 5, t7)
              C7 = J7
            else
            end
          else
          end
        else
          local K7 = (B7 == 2) or ((B7 == 3) and not c7())
          if K7 then
            if y7("FishermanSpot", t7) then
              C7 = q7("FishermanSpot", "Fisherman", t7)
              if (C7 == "FisherReunion") or (C7 == "FisherHint") then
                rO(2.5, t7)
                C7 = q7("FishermanSpot", "Rod", t7)
                VO(function()
                  return c7() ~= nil
                end, 5, t7)
              else
              end
            else
            end
          else
            if B7 == 3 then
              local q7 = OO("CastTarget")
              if q7 then
                if y7("CastSpot", t7) then
                  _O(c7())
                  rO(0.5, t7)
                  local y7 = U7(q7.Position, t7)
                  if y7 and (y7.Mode == "Quest") then
                    rO((tonumber(y7.Wait) or 3) + 0.45, t7)
                    t("RE/Fishing/Cancel", y7.Id)
                    local q7 = Shared.Invoke
                    local B7, B7 = q7("RF/GhostDogQuest/Cast")
                    if type(B7) == "number" then
                      if L7(B7, JO("GhostDogQuestFlags", "ChaseSeconds") or 50, t7) then
                        W("Ghost Dog", "Phantom Express Ticket unlocked", "ok")
                      end
                    end
                  elseif y7 then
                    if y7.Id then
                      t("RE/Fishing/Cancel", y7.Id)
                    end
                  end
                end
              end
            end
          end
        end
      end
      if i7() == P7 then
        h.dogAt = os.clock() + 20
        if type(C7) == "string" then
          t7 = Shared.s10
          t7("Ghost Dog: " .. C7, "warn")
        end
      end
      return true
    end
    local function JO(y7)
      local q7 = RaycastParams.new()
      q7.FilterType = Enum.RaycastFilterType.Exclude
      local i7, L7 = {}, Shared.LocalPlayer
      f:yT(i7, 0, L7.Character)
      for t7 = 1, 6, 1 do
        q7.FilterDescendantsInstances = i7
        local t7, t7, t7 = Shared.Vec3, Shared.Vec3, workspace:Raycast(y7 + Shared.Vec3(0, 40, 0), Shared.Vec3(0, -180, 0), q7)
        if not (t7) then
          return nil
        end
        L7 = t7.Instance
        if t7.Material == Enum.Material.Water then
          return t7.Position
        elseif L7:GetAttribute("TerrainRole") == "Basin" then
          return t7.Position
        elseif L7:GetAttribute("FishingWater") then
          return t7.Position
        elseif C:HasTag(L7, "FishingWater") then
          return t7.Position
        end
        if L7:IsA("BasePart") then
          if not (L7.Transparency >= 0.95) then
            return nil
          end
        else
          return nil
        end
        i7[#i7 + 1] = L7
      end
    end
    local C, y7 = {}, Shared.RunService
    U(y7.Stepped, function()
      if h.pin then
        local q7, i7 = ipairs, f[53](c:GetPlayers())
        for L7, t7 in q7(f:uT(i7)) do
          L7 = Shared.LocalPlayer
          local q7 = (t7 ~= L7) and t7.Character
          if q7 then
            for i7, i7 in ipairs(q7:GetChildren()) do
              if i7:IsA("BasePart") then
                if i7.CanCollide then
                  C[i7] = true
                  i7.CanCollide = false
                end
              end
            end
          end
        end
      elseif next(C) then
        for q7 in next, C, nil do
          if q7.Parent then
            q7.CanCollide = true
          end
        end
        table.clear(C)
      end
    end)
    gO = Shared.RunService
    U(gO.Stepped, function()
      local C, q7, i7 = h.pin, h.pin
      if q7 then
        local L7 = Shared.s16
        i7 = (L7())
      else
        i7 = q7
      end
      if i7 then
        i7.CFrame = C
        q7 = Shared.Vec3Zero
        i7.AssemblyLinearVelocity = q7
        local C = Shared.Vec3Zero
        i7.AssemblyAngularVelocity = C
      end
    end)
    local function C(q7, i7)
      local L7, t7 = RaycastParams.new(), {}
      for B7, B7 in ipairs(c:GetPlayers()) do
        if B7.Character then
          t7[#t7 + 1] = B7.Character
        end
      end
      L7.FilterType = Enum.RaycastFilterType.Exclude
      L7.FilterDescendantsInstances = t7
      L7.RespectCanCollide = true
      local B7, B7, B7, K7 = Shared.Vec3, Shared.Vec3, workspace:Raycast(q7.Position + Shared.Vec3(0, 4, 0), Shared.Vec3(0, -20, 0), L7), Shared.s8
      t7 = K7()
      L7, K7 = (B7 and ((B7.Position.Y + ((t7 and t7.HipHeight) or 2)) + (q7.Size.Y / 2))) or q7.Position.Y, Shared.Vec3
      B7 = K7(q7.Position.X, L7, q7.Position.Z)
      if t7 then
        K7 = Shared.Vec3Zero
        t7:Move(K7)
        t7:MoveTo(B7)
      end
      q7 = Shared.Vec3
      return CFrame.lookAt(B7, q7(i7.X, L7, i7.Z))
    end
    local q7
    local function i7(L7)
      local t7, B7 = pcall(q7, L7)
      h.pin = nil
      if not (t7) then
        error(B7, 0)
      end
      return B7
    end
    q7 = function(q7)
      if not (n7("to fish", q7)) then
        return true
      end
      if G7() == 3 then
        h.doing = "Ghost Dog quest blocks fishing, casting at the ripples"
        return I7(q7)
      end
      local L7, t7 = 0, false
      local function B7()
        local K7 = Shared.s21
        if K7.hwEggs then
          local P7, C7 = Shared.Core, Shared.Core
          if P7.rank["HW:Halloween eggs"] < C7.rank["HW:Halloween fishing"] then
            if os.clock() >= L7 then
              local P7, C7 = os.clock() + 0.5, f7() ~= nil
              L7, t7 = P7, C7
            end
          end
        end
        K7 = q7() and not t7
        return K7
      end
      local q7 = c7()
      if not (q7) then
        return false
      end
      if os.clock() < h.fishAt then
        if (h.fishAt - os.clock()) > 5 then
          return false
        end
        rO(h.fishAt - os.clock(), B7)
        return true
      end
      local c7 = Shared.s16
      local L7, t7 = c7(), OO("ReturnSpot")
      if not (L7) then
        return false
      end
      c7 = t7 and ((lO(L7.Position - t7.Position).Magnitude > 8) or ((t7.Position.Y + 1) > L7.Position.Y))
      if c7 then
        h.doing = "Going to the fishing spot"
        local function K7()
          local P7, P7 = Shared.Vec3, t7.Position + Shared.Vec3(0, 3, 0)
          return a7(P7, B7, 300)
        end
        return QO(K7)
      end
      local QO, a7 = OO("CastTarget"), workspace:FindFirstChild("GhostFisherman")
      local K7
      local P7, C7 = ((a7 and a7:IsA("Model")) and a7:GetPivot().LookVector) or (t7 and t7.CFrame.LookVector)
      if P7 then
        C7 = P7
      else
        c7 = Shared.Vec3
        C7 = (c7(0, 0, -1))
      end
      c7 = math.atan2(C7.Z, C7.X)
      for t7 = 0, 12, 1 do
        P7 = c7 + (((((((t7 % 2) == 0) and 1) or -1) * math.ceil(t7 / 2)) * 3.141592653589793) / 18)
        C7, a7, t7 = Shared.Vec3, Shared.s21, JO(L7.Position + (Shared.Vec3(math.cos(P7), 0, math.sin(P7)) * (10 + (32 * (({["x1.2"] = 1, ["x1.1"] = 0.5, ["x1.0 Fastest"] = 0.02})[Shared.s21.hwLuck] or 0.875)))))
        if t7 and not (QO and (lO(t7 - QO.Position).Magnitude < 12)) then
          K7 = t7
          break
        end
      end
      if not K7 then
        h.doing = "Looking for water to fish"
        rO(1, B7)
        return true
      end
      h.pin = C(L7, K7)
      QO = Shared.s21
      h.doing = "Casting (" .. ((QO.hwLuck or "x1.5 Perfect") .. ")")
      _O(q7)
      P7, c7 = U7(K7, B7)
      h.fishAt = os.clock() + 1.2
      if not P7 then
        h.fishAt = os.clock() + ((tostring(c7):lower():find("closed") and 30) or 3)
        return true
      end
      local C, JO = tonumber(P7.Wait) or 3, H7("Line")
      local a7, U7 = H7("Ui"), q7:FindFirstChild("RodTip", true)
      local H7, t7 = (U7 and U7:IsA("Attachment")) and U7.WorldPosition
      if H7 then
        t7 = H7
      else
        q7 = nil
        q7, t7 = Shared.Vec3, L7.Position + Shared.Vec3(0, 4, 0)
      end
      local C7, J7 = false
      if JO then
        C7, J7 = pcall(JO.Spawn, U7, t7)
      else
      end
      J7 = C7 and J7
      local C7, v7, N7 = J7 or nil, true, false
      if C7 then
        task.spawn(function()
          pcall(JO.Fly, C7, t7, K7, 0.75, function()
            return v7
          end)
          local t7 = os.clock()
          while v7 and C7.Parent do
            pcall((N7 and JO.Thrash) or JO.Float, C7, K7, (N7 and 1) or (os.clock() - t7), 0)
            task.wait((N7 and 0.06) or nil)
          end
        end)
      end
      h.doing = "Waiting for a bite"
      if P7.Mode == "GhostFish" then
        M7(P7, B7)
      else
        if ((P7.Mode == "Nothing") or (P7.Mode == "Hint")) or (P7.Mode == "Quest") then
          rO(C, B7)
          t("RE/Fishing/Cancel", P7.Id)
        else
          if rO(C, B7) then
            N7 = true
            h.doing = "Reeling in"
            QO, c7 = os.clock(), false
            while ((os.clock() - QO) < 1.2) and (B7()) do
              L7 = ((os.clock() - QO) - 1.05) / 0.15
              if a7 then
                if L7 >= 0 then
                  if c7 then
                  else
                    pcall(a7.ShowReel, true, "Click Fast!")
                    c7 = true
                  end
                  pcall(a7.SetReel, math.min(L7, 1), math.floor(math.min(L7, 1) * 16), "Click Fast!")
                  pcall(a7.PunchReel)
                else
                end
              else
              end
              task.wait()
            end
            if a7 then
              pcall(a7.ShowReel, false)
            end
            H7 = Shared.Invoke
            local C, C, QO = H7("RF/Fishing/Reel", P7.Id, "Caught", 16)
            if C then
              if type(QO) == "table" then
                h.fish = h.fish + 1
                q7 = Shared.s10
                q7("Caught " .. (tostring(QO.DisplayName) .. (" x" .. tostring(QO.Amount))), "ok")
                if a7 then
                  task.spawn(pcall, a7.Reveal, QO, 2.6)
                end
              end
            end
          else
            t("RE/Fishing/Cancel", P7.Id)
          end
        end
      end
      v7 = false
      if C7 then
        task.spawn(function()
          pcall(JO.Return, C7, U7, 0.3)
          C7:Destroy()
        end)
      end
      h.doing = "Fishing, " .. (h.fish .. " caught")
      h.fishAt = os.clock()
      return true
    end
    local C = Shared.Core
    C.hwEggs = function()
      local C, JO = YO(), {h.cur}
      local QO = C and (C:FindFirstChild("WorldEggs"))
      for C, q7 in ipairs((QO and QO:GetChildren()) or {}) do
        local QO, c7, a7, M7 = q7:GetAttribute("HalloweenEggUid"), EO(q7), q7:FindFirstChild("StealPrompt", true), uO(q7)
        if QO then
          if c7 then
            if M7 then
              if a7 then
                if a7.Enabled then
                  if not (h.cur and (h.cur.Uid == QO)) then
                    C = ZO(M7)
                    JO[#JO + 1] = {Uid = QO, n = c7, cat = c7, v = XO(q7), s = (q7:IsA("Model") and q7:GetScale()) or 1, tg = oO(q7) and (C >= 1), hw = true, zone = C, o = (h.oi or {})[QO]}
                  end
                end
              end
            end
          end
        end
      end
      return JO
    end
    local C = Shared.Core
    C.hwTurnNow = function()
      if h.turn then
        local C = Shared.Core
        if (C.lastEggAt or 0) < h.turnAt then
          return h.turn == "halloween"
        end
      end
      local C = Shared.Core
      if C.lastEgg == "field" then
        return true
      else
        local C = Shared.Core
        if C.lastEgg == "halloween" then
          return false
        end
      end
    end
    local C = Shared.Core
    C.hwMove = function(C, JO, QO)
      local ZO, oO, q7 = {}, {}, Shared.Core
      for c7, c7 in ipairs(q7.hwEggs()) do
        if not (c7.cur) then
          ZO[#ZO + 1] = c7
        end
      end
      table.sort(ZO, function(c7, a7)
        local M7, H7 = c7.o or math.huge, a7.o or math.huge
        if M7 ~= H7 then
          return M7 < H7
        end
        return c7.v > a7.v
      end)
      for c7, c7 in ipairs(ZO) do
        oO[#oO + 1] = c7.Uid
      end
      if C and JO then
        ZO, q7 = table.find(oO, C), table.find(oO, JO)
        if ZO then
          if q7 then
            oO[ZO], oO[q7] = oO[q7], oO[ZO]
          end
        end
      else
        local ZO = (C ~= nil) == (QO < 0)
        h.turn, h.turnAt = (ZO and "halloween") or "field", os.clock()
        local QO = ZO and table.find(oO, C or JO)
        if QO then
          table.insert(oO, 1, table.remove(oO, QO))
        end
      end
      h.oi = {}
      for C, JO in ipairs(oO) do
        h.oi[JO] = C
      end
    end
    local C = sO({name = "Halloween", mover = true, gap = 1, pri = 8, soft = true})
    local function JO()
      local QO = ipairs
      for ZO, oO in QO(yO) do
        if oO.mover then
          local QO, q7 = pcall(oO.on)
          if QO then
            if q7 then
              local QO, q7 = pcall(oO.want)
              if QO then
                if q7 then
                  local QO, q7 = (oO == C) or (oO.name == "Train")
                  if QO then
                    q7 = QO
                  else
                    ZO = Shared.Core
                    local QO = ZO.TOOLV ~= nil
                    if QO then
                      local ZO = Shared.Core
                      q7 = ZO.TOOLV[oO.name] == true
                    else
                      q7 = QO
                    end
                  end
                  return q7
                end
              end
            end
          end
        end
      end
      return false
    end
    local QO = Shared.Core
    QO.hwBest = function()
      local QO = Shared.s21
      if QO.hwEggs then
        if not (zO()) then
          if wO() then
            local ZO = Shared.s22
            if not (ZO("HalloweenDimensionPortal")) then
              return
            end
          else
            return
          end
        end
      else
        return
      end
      QO = f7()
      if not QO then
        return
      end
      return {hw = true, e = QO, Uid = QO:GetAttribute("HalloweenEggUid"), Name = EO(QO), v = XO(QO), r = h.pickRank}
    end
    local QO = Shared.Core
    QO.hwSteal = function(QO, ZO)
      local function EO()
        return ZO() and ((T() > 0) or (IO("HalloweenCarrying") == true))
      end
      if not (WO(ZO)) then
        return
      end
      while (ZO() and (T() <= 0)) and (IO("HalloweenCarrying") ~= true) do
        h.doing = "Night, waiting in the Halloween safe zone for " .. tostring(QO.Name)
        local oO = Shared.s10
        oO(h.doing)
        local q7, c7 = AO()
        oO = Shared.s16
        local a7 = oO()
        if q7 then
          if a7 then
            if FO(c7, a7.Position) then
              rO(1, ZO)
            else
              DO(q7, ZO)
            end
          else
            rO(1, ZO)
          end
        else
          rO(1, ZO)
        end
      end
      local ZO = Shared.s36
      ZO.cur = QO.Name
      s7(EO, QO.e)
      if IO("HalloweenCarrying") == true then
        p7(EO)
      end
    end
    local function QO()
      local ZO = Shared.s21
      local EO, oO = ZO.hwEggs
      if EO then
        ZO = Shared.s21
        local q7 = ZO.steal
        oO = if q7 then (T() <= 0) and (f7() ~= nil) else not q7
      else
        oO = EO
      end
      ZO = nil
      if oO then
        ZO = oO
      else
        EO = Shared.s21
        ZO = EO.hwMon
      end
      EO = nil
      if ZO then
        EO = ZO
      else
        oO = Shared.s21
        EO = oO.hwDog
      end
      ZO = nil
      if EO then
        ZO = EO
      else
        oO = Shared.s21
        ZO = oO.hwFish
      end
      oO = nil
      if ZO then
        oO = ZO
      else
        EO = Shared.s21
        oO = EO.hwPump and (workspace:GetAttribute("HalloweenWorldEvent") == "PumpkinMoon")
      end
      return oO
    end
    local function ZO()
      local EO = Shared.s21
      local oO, q7 = EO.hwMon
      if oO then
        q7 = oO
      else
        EO = Shared.s21
        q7 = EO.hwFish
      end
      EO = nil
      if q7 then
        EO = q7
      else
        oO = Shared.s21
        EO = oO.hwDog and (G7() < 4)
      end
      oO = nil
      if EO then
        oO = EO
      else
        q7 = Shared.s21
        oO = q7.hwPump and (workspace:GetAttribute("HalloweenWorldEvent") == "PumpkinMoon")
      end
      return ((oO or ((h.cur ~= nil) or (os.clock() < (h.retry or 0)))) or (IO("HalloweenCarrying") == true)) or (f7() ~= nil)
    end
    local function EO()
      local oO = Shared.s21
      if not (oO.steal) then
        return false
      end
      local q7, c7 = T() > 0
      if q7 then
        oO = Shared.Core
        c7 = oO.targets()
      else
        c7 = q7
      end
      oO = nil
      if c7 then
        oO = c7
      else
        q7 = Shared.Core
        oO = q7.targetsSoon()
      end
      c7, q7 = oO[1], f7()
      if c7 then
        if T() <= 0 then
          oO = Shared.Core
          if not (oO.fieldFresh) then
            return false
          end
        end
      else
        return false
      end
      if not q7 then
        return true
      end
      oO = Shared.Core
      return not oO.hwBeats(h.pickRank, XO(q7), c7)
    end
    local function XO()
      local oO, q7 = ipairs, 99
      for c7, a7 in oO(MO) do
        c7 = Shared.Core
        local oO, M7, H7 = c7.rank["HW:" .. a7] or 99, a7 == "Halloween eggs"
        if M7 then
          c7 = Shared.s21
          H7 = c7.hwEggs
        else
          H7 = M7
        end
        M7 = nil
        if H7 then
          c7 = Shared.s21
          M7 = not c7.steal
        else
          M7 = H7
        end
        c7 = M7 and ((((h.cur ~= nil) or (os.clock() < (h.retry or 0))) or (IO("HalloweenCarrying") == true)) or (f7() ~= nil))
        oO = if c7 then if h.pickRank then h.pickRank else oO else oO
        if oO < q7 then
          M7, H7 = a7 == "Pumpkin Moon"
          if M7 then
            local U7 = Shared.s21
            H7 = U7.hwPump
          else
            H7 = M7
          end
          local M7, U7 = H7 and (workspace:GetAttribute("HalloweenWorldEvent") == "PumpkinMoon")
          if M7 then
            U7 = M7
          else
            local H7, L7 = a7 == "Ghost Dog quest"
            if H7 then
              local t7 = Shared.s21
              L7 = t7.hwDog
            else
              L7 = H7
            end
            U7 = L7 and (G7() < 4)
          end
          local H7, L7 = U7 or c7
          if H7 then
            L7 = H7
          else
            U7 = a7 == "Halloween monsters"
            if U7 then
              M7 = Shared.s21
              L7 = M7.hwMon
            else
              L7 = U7
            end
          end
          if L7 then
            q7 = oO
          else
            if a7 == "Halloween fishing" then
              M7 = Shared.s21
              q7 = if M7.hwFish then oO else q7
            else
            end
          end
        else
        end
      end
      return q7
    end
    local function oO()
      local q7 = Shared.Core
      q7.rank.Halloween = XO()
      q7 = Shared.Core
      if q7.order then
        local q7 = Shared.Core
        q7.order()
      end
      return JO()
    end
    local function JO()
      local q7 = Shared.Core
      local c7, a7 = q7.bloomWants ~= nil
      if c7 then
        q7 = Shared.Core
        a7 = q7.bloomWants()
      else
        a7 = c7
      end
      q7 = nil
      if a7 then
        c7 = Shared.Core
        q7 = (c7.rank.Bloom or 99) < XO()
      else
        q7 = a7
      end
      return q7
    end
    C.on = function()
      if not (C.busy) then
        local q7 = Shared.Core
        q7.rank.Halloween = XO()
      end
      local q7 = JO()
      local c7, a7 = if q7 then not q7 else QO()
      if c7 then
        q7 = zO()
        if q7 then
          a7 = q7
        else
          local QO, q7 = T() > 0
          if QO then
            q7 = QO
          else
            local QO = Shared.s21
            q7 = QO.hwEggs and (f7() ~= nil)
          end
          a7 = (q7 and wO()) and ZO()
        end
      else
        a7 = c7
      end
      return a7 and (os.clock() >= (h.idleUntil or 0))
    end
    C.want = function()
      local QO = Shared.s29
      if QO() then
        return
      end
      QO = zO()
      local wO
      if QO then
        wO = QO
      else
        local QO = Shared.s22
        wO = QO("HalloweenDimensionPortal") ~= nil
      end
      return wO
    end
    C.run = function(QO, wO)
      local function ZO()
        return (wO() and ((T() > 0) or (IO("HalloweenCarrying") == true))) and ((((h.cur ~= nil) or (os.clock() < (h.retry or 0))) or (IO("HalloweenCarrying") == true)) or not JO())
      end
      if not (zO()) then
        QO = table.clone(MO)
        table.sort(QO, function(JO, q7)
          local c7, a7 = Shared.Core, Shared.Core
          return c7.rank["HW:" .. JO] < a7.rank["HW:" .. q7]
        end)
        local JO = ipairs
        for q7, c7 in JO(QO) do
          local JO, a7 = c7 == "Pumpkin Moon"
          if JO then
            q7 = Shared.s21
            a7 = q7.hwPump
          else
            a7 = JO
          end
          JO, q7 = a7 and (workspace:GetAttribute("HalloweenWorldEvent") == "PumpkinMoon")
          if JO then
            q7 = JO
          else
            local M7, H7 = c7 == "Ghost Dog quest"
            if M7 then
              a7 = Shared.s21
              H7 = a7.hwDog
            else
              H7 = M7
            end
            q7 = H7 and (G7() < 4)
          end
          if q7 then
            break
          elseif c7 == "Halloween eggs" then
            JO = Shared.s21
            if JO.hwEggs then
              a7 = Shared.s21
              if not (a7.steal) then
                break
              end
            end
          end
          JO, q7 = c7 == "Halloween monsters"
          if JO then
            a7 = Shared.s21
            q7 = a7.hwMon
          else
            q7 = JO
          end
          a7 = nil
          if q7 then
            a7 = q7
          else
            JO = c7 == "Halloween fishing"
            if JO then
              local q7 = Shared.s21
              a7 = q7.hwFish
            else
              a7 = JO
            end
          end
          if a7 then
            if not (n7("before entering the dimension", wO)) then
              return
            end
            break
          end
        end
      end
      local JO = zO()
      if not (WO(wO)) then
        return
      end
      if not (JO) then
        rO(1, wO)
      end
      QO = nil
      while wO() and (zO()) do
        JO = false
        if IO("HalloweenCarrying") == true then
          local q7 = Shared.Core
          q7.rank.Halloween = 0
          p7(ZO)
          JO = true
        else
          local p7, q7 = T() <= 0
          if p7 then
            local c7 = Shared.Fire
            q7 = not c7("Cycle", "IsNightPhase", K())
          else
            q7 = p7
          end
          p7 = nil
          if q7 then
            local c7 = Shared.Core
            p7 = (c7.rank.Steal or 9) < XO()
          else
            p7 = q7
          end
          if p7 and (EO()) then
            h.doing, h.idleUntil = "Eggs reset, leaving to wait for Auto Steal", os.clock() + 30
            q7 = Shared.Core
            q7.leaveDim(wO)
            break
          elseif T() <= 0 then
            QO = nil
            h.doing = "Night, waiting in the safe zone"
            local p7, q7 = AO()
            local AO = Shared.s16
            local c7, a7 = AO(), OO("ReturnSpot")
            if (a7 and c7) and (lO(c7.Position - a7.Position).Magnitude < 40) then
              h.doing = "Night, waiting at the fishing spot"
              rO(1, wO)
            elseif p7 then
              if c7 then
                if FO(q7, c7.Position) then
                  rO(1, wO)
                else
                  DO(p7, wO)
                end
              else
                rO(1, wO)
              end
            else
              rO(1, wO)
            end
            JO = true
          else
          end
        end
        local OO = Shared.s21
        if OO.hwEggs then
          f7()
          local FO = Shared.Core
          local AO, f7, p7 = FO.rank, h.pickRank
          if f7 then
            p7 = f7
          else
            FO = Shared.Core
            p7 = FO.rank["Steal:filter"]
          end
          AO["HW:Halloween eggs"] = p7
        end
        OO = table.clone(MO)
        table.sort(OO, function(MO, FO)
          local AO, f7 = Shared.Core, Shared.Core
          return AO.rank["HW:" .. MO] < f7.rank["HW:" .. FO]
        end)
        local MO = ipairs
        for FO, AO in MO(OO) do
          if JO then
            break
          end
          local function f7()
            local p7, q7 = Shared.Core
            q7, p7.rank.Halloween = Shared.Core, Shared.Core.rank["HW:" .. AO]
            if AO ~= "Halloween monsters" then
              if AO ~= "Halloween fishing" then
                h.visUntil = 0
              end
            end
            return true
          end
          local p7, q7 = AO == "Pumpkin Moon"
          if p7 then
            FO = Shared.s21
            q7 = FO.hwPump
          else
            q7 = p7
          end
          if (q7 and (workspace:GetAttribute("HalloweenWorldEvent") == "PumpkinMoon")) and f7() then
            JO = (aO(ZO))
          else
            FO, p7 = AO == "Ghost Dog quest"
            if FO then
              local aO = Shared.s21
              p7 = aO.hwDog
            else
              p7 = FO
            end
            if ((p7 and (G7() < 4)) and (os.clock() >= h.dogAt)) and f7() then
              JO = (I7(ZO))
            else
              local aO, FO = AO == "Halloween eggs"
              if aO then
                local p7 = Shared.s21
                FO = p7.hwEggs
              else
                FO = aO
              end
              if (FO and not EO()) and f7() then
                JO = (s7(ZO))
              else
                local FO, p7 = AO == "Halloween monsters"
                if FO then
                  aO = Shared.s21
                  p7 = aO.hwMon
                else
                  p7 = FO
                end
                if p7 and (f7()) then
                  JO = (o(ZO))
                else
                  if AO == "Halloween fishing" then
                    FO = Shared.s21
                    JO = if FO.hwFish then if f7() then (i7(ZO)) else JO else JO
                  else
                  end
                end
              end
            end
          end
        end
        if JO then
        else
          MO = Shared.s21
          if MO.hwEggs then
            if os.clock() < (h.retry or 0) then
              h.doing = "Waiting to grab the dropped egg again"
              rO(0.3, ZO)
              JO = true
            else
            end
          else
          end
        end
        if not JO then
          OO = Shared.Core
          OO.rank.Halloween = XO() + ((EO() and 0.5) or 0)
        end
        QO = (if JO then not JO else QO or os.clock()) or nil
        OO = false
        if QO then
          if (os.clock() - QO) > 6 then
            local o, aO = ipairs, OO
            for OO, FO in o(yO) do
              if (((FO.mover and (FO ~= C)) and FO.on) and (FO.name ~= "Stage")) and (FO.name ~= "NightHome") then
                OO, MO = pcall(FO.on)
                local AO, XO = false
                if OO then
                  if MO then
                    AO, XO = pcall(FO.want)
                  else
                  end
                else
                end
                XO = AO and XO
                local OO
                if XO then
                  local AO = FO.name ~= "Steal"
                  if AO then
                    OO = AO
                  else
                    local FO = T() > 0
                    if FO then
                      local AO = Shared.Core
                      OO = #AO.targets() > 0
                    else
                      OO = FO
                    end
                  end
                else
                  OO = XO
                end
                if OO then
                  aO = true
                  break
                end
              end
            end
            if aO then
              h.doing, h.idleUntil = "Nothing to do, back to other tasks", os.clock() + 45
              o = Shared.Core
              o.leaveDim(wO)
              break
            end
          end
        end
        if not JO then
          h.doing = "Nothing to do yet, free to move"
          rO(0.5, wO)
        end
        MO = Shared.WaitHeartbeat
        MO()
      end
      ZO, QO = Shared.Core
      QO, h.doing, ZO.rank.Halloween = Shared.Core, "Off", Shared.Core.hwRank0
      if not (oO()) then
        h.visUntil = 0
      end
    end
    local o = sO({name = "HwStuck", gap = 1})
    local aO
    o.on = function()
      return true
    end
    o.fn = function()
      if Shared.s4 and (Shared.s4.name == "Train") then
        aO = nil
        return
      else
        local o = Shared.LocalPlayer
        if o:GetAttribute("TrainEventTravelStage") == "Prepare" then
          aO = nil
          return
        end
      end
      local o = Shared.s16
      local MO, JO = o(), YO()
      o = JO and (JO:FindFirstChild("PortalHome", true))
      JO = o and (o:FindFirstChild("Portal") or o:FindFirstChildWhichIsA("BasePart", true))
      if MO then
        if JO then
          if zO() then
            aO = nil
            return
          elseif (SO() or "Home") == "Home" then
            if not ((MO.Position - JO.Position).Magnitude < 2000) then
              aO = nil
              return
            end
          else
            aO = nil
            return
          end
        else
          aO = nil
          return
        end
      else
        aO = nil
        return
      end
      aO = aO or os.clock()
      if (os.clock() - aO) < 4 then
        return
      end
      aO = nil
      JO = Shared.s10
      JO("Stuck in the dimension after leaving, resetting the character", "warn")
      MO = Shared.Core
      if MO.respawn then
        JO = Shared.Core
        JO.respawn(true)
      end
    end
    local o = sO({name = "HalloweenBuy", gap = 5})
    o.on = function()
      local aO = Shared.s21
      return aO.hwBuy and (os.clock() >= h.buyAt)
    end
    o.fn = function()
      local o, aO = pcall(function()
        return require(a.Data.HalloweenDimensionEgg).Price
      end)
      aO = (o and tonumber(aO)) or 2250
      if (tonumber(NO("HalloweenTokens")) or 0) < aO then
        return
      end
      o = Shared.Invoke
      local aO, aO, MO = o("RF/HalloweenDimension/AskBuyEgg")
      if aO == true then
        W("Halloween", "Bought a Halloween Dimension Egg", "ok")
      else
        h.buyAt = os.clock() + 30
        o = Shared.s10
        o("Egg shop: " .. tostring(MO or "refused"), "warn")
      end
    end
    local function o(...)
      local aO = Shared.Invoke
      return aO("RF/TrainEvent/Action", ...)
    end
    local function aO()
      local MO, MO, JO = o("Status")
      if MO then
        xO(JO)
      end
      return R.st
    end
    TO("RE/TrainEvent/State", xO)
    TO("RE/TrainEvent/CaptureState", function(MO)
      if type(MO) == "table" then
        if R.st then
          R.st.Invasion = MO
        end
      end
    end)
    TO("RE/GhostBoss/Defeated", function(MO)
      if type(MO) == "table" then
        W("Ghouler", "+" .. (tostring(MO.Souls or 0) .. " Souls"), "ok")
      end
    end)
    local function MO(JO, YO)
      local OO = R.pc[JO .. tostring(YO)]
      if OO then
        if OO.Parent then
          return OO
        end
      end
      if os.clock() < (R.miss[JO .. tostring(YO)] or 0) then
        return nil
      end
      R.miss[JO .. tostring(YO)] = os.clock() + 5
      local OO, FO = ipairs, {workspace:FindFirstChild("TrainEventRuntime"), workspace:FindFirstChild("TrainEventAssets"), workspace}
      for QO, QO in OO(FO) do
        for OO, OO in ipairs((QO and QO:GetDescendants()) or {}) do
          if OO:IsA("ProximityPrompt") and (((JO == "Name") and (OO.Name == YO)) or (OO:GetAttribute(JO) == YO)) then
            R.pc[JO .. tostring(YO)] = OO
            return OO
          end
        end
      end
    end
    local function JO(YO, OO, FO)
      local QO = Shared.s16
      local xO, wO, ZO = QO(), YO:GetAttribute(OO), YO:GetAttribute(FO)
      if xO then
        if typeof(wO) == "Vector3" then
          if typeof(ZO) == "Vector3" then
            OO = ZO - wO
            return wO + (OO * (((OO.Magnitude > 0) and math.clamp((xO.Position - wO):Dot(OO) / OO:Dot(OO), 0, 1)) or 0))
          end
        end
      end
      return uO(YO.Parent)
    end
    local function YO()
      return RO(function(OO)
        return OO:GetAttribute("ConductorTicket") == true
      end)
    end
    local function OO()
      local FO = NO("TrainEvent")
      return (type(FO) == "table") and (((FO.AccessUnlocked == true) or ((tonumber(FO.Tickets) or 0) > 0)) or (YO() ~= nil))
    end
    local function FO()
      local QO = R.st
      return ((QO and (QO.ArrivalOpen == true)) and (K() < (tonumber(QO.DepartureAt) or 0))) and ((QO.Phase == "Home") or (QO.Phase == nil))
    end
    local function QO(xO)
      local wO = a:FindFirstChild("GhostBossState")
      local ZO = wO and (wO:GetAttribute("Phase"))
      return (((((wO ~= nil) and (wO:GetAttribute("BossId") ~= "")) and ((ZO == "Alive") or (ZO == "Spawning"))) and (wO:GetAttribute("Realm") == xO)) and wO) or nil
    end
    local function xO(wO)
      return RO(function(ZO)
        return (ZO:GetAttribute("GhostVacuum") == true) or (wO and (ZO:GetAttribute("GhostBossVacuum") ~= nil))
      end)
    end
    local function wO(ZO, ...)
      if (os.clock() - (R.suckAt or 0)) >= (((ZO == "RE/GhostBoss/Suction") and 0.25) or 0.2) then
        R.suckAt = os.clock()
        t(ZO, ...)
      end
    end
    local function ZO(AO)
      local XO, EO = AO:GetAttribute("Ground"), Shared.s16
      local f7 = EO()
      if typeof(XO) ~= "Vector3" then
        return
      elseif f7 then
      else
        return
      end
      local p7, s7 = AO:GetAttribute("Velocity"), tonumber(AO:GetAttribute("MovedAt")) or K()
      XO = if typeof(p7) == "Vector3" then XO + (p7 * math.clamp(K() - s7, 0, 0.3)) else XO
      s7 = lO(f7.Position - XO)
      AO, EO = (s7.Magnitude > 0.5) and s7.Unit
      if AO then
        EO = AO
      else
        p7 = Shared.Vec3
        EO = (p7(1, 0, 0))
      end
      AO, s7 = Shared.Vec3, (XO + (EO * 42)) + Shared.Vec3(0, 3, 0)
      local AO, EO, q7 = s7 - f7.Position, Shared.s32, Shared.CFrameNew
      EO(q7(f7.Position + (((AO.Magnitude > 2) and (AO.Unit * math.min(AO.Magnitude, 1.3333333333333333))) or AO), Shared.Vec3(XO.X, f7.Position.Y, XO.Z)))
      p7 = Shared.Vec3
      wO("RE/GhostBoss/Suction", true, ((XO + p7(0, 8, 0)) - f7.Position).Unit)
    end
    local function wO(AO)
      return ((type(AO) == "table") and AO.CanTrade) and ((tonumber(AO.Souls) or 0) >= (tonumber(AO.Cost) or math.huge))
    end
    local function AO(XO)
      local EO = MO("TrainEventAction", "OpenSoulShop")
      if EO then
        local f7, f7, p7 = Shared.Vec3, uO(EO.Parent) + Shared.Vec3(0, 3, 0), Shared.s21
        if DO(f7, XO, p7.hwGhostSp or 300) then
          hO(EO)
          rO(0.5, XO)
        end
      end
      local DO, DO, DO = o("OpenSoulShop")
      EO = ((type(DO) == "table") and DO.SoulShop) or (R.st and R.st.SoulShop)
      for DO = 1, 200, 1 do
        if type(EO) == "table" then
          if EO.CanTrade then
            if not ((tonumber(EO.Souls) or 0) >= (tonumber(EO.Cost) or math.huge)) then
              break
            end
          else
            break
          end
        else
          break
        end
        local f7, f7, p7 = o("TradeSouls", EO.Cost)
        if not (f7) then
          break
        end
        DO = ((type(p7) == "table") and (p7.SoulShop or ((p7.Souls ~= nil) and p7))) or nil
        if (type(DO) == "table") and (DO.Souls ~= nil) then
          EO = DO
        else
          EO.Souls = (tonumber(EO.Souls) or 0) - (tonumber(EO.Cost) or 0)
        end
        rO(0.3, XO)
      end
    end
    local function DO(XO)
      for EO = 1, 4, 1 do
        AO(XO)
        local AO, AO, AO = o("Status")
        if XO() then
          if type(AO) == "table" then
            if not (wO(AO.SoulShop)) then
              return
            end
          else
            return
          end
        else
          return
        end
        h.doing = "Souls left, trading again"
      end
    end
    local function wO()
      if IO("HalloweenCarrying") == true then
        return true
      end
      local IO = Shared.Core
      local AO, XO = IO.rank.Train or 99, Shared.s21
      if XO.hwEggs then
        IO = Shared.s21
        local EO, f7 = IO.steal
        if EO then
          local p7 = Shared.Core
          f7 = p7.rank.Steal
        else
          f7 = EO
        end
        EO = nil
        if f7 then
          EO = f7
        else
          local p7 = Shared.Core
          EO = p7.rank["HW:Halloween eggs"]
        end
        if EO < AO then
          if h.cur ~= nil then
            return true
          elseif os.clock() < (h.retry or 0) then
            return true
          else
            f7 = Shared.Core
            if f7.hwBest() then
              return true
            end
          end
        end
      end
      IO = Shared.s21
      local EO, f7 = IO.steal
      if EO then
        IO = Shared.Core
        f7 = IO.rank.Steal < AO
      else
        f7 = EO
      end
      AO = nil
      if f7 then
        IO = (T() <= 0) and (SO() ~= "Town")
        if IO then
          AO = IO
        else
          XO = Shared.Core
          AO = #XO.targets() > 0
        end
      else
        AO = f7
      end
      return AO
    end
    local function T(IO)
      local function AO()
        return IO() and (SO() == "Town")
      end
      local IO
      R.left = nil
      R.vis = false
      local function XO()
        R.left = true
        if (os.clock() - (R.retAt or -99)) < 15 then
          return
        else
          local EO = Shared.LocalPlayer
          if EO:GetAttribute("TrainEventTravelStage") == "Prepare" then
            return
          end
        end
        R.retAt = os.clock()
        local EO = MO("Name", "TrainReturn")
        if EO then
          mO(JO(EO, "ReturnRailStart", "ReturnRailEnd"), AO)
        end
        o("Return")
      end
      local EO = 0
      while AO() do
        local f7, p7 = R.soulRide
        if f7 then
          local s7 = Shared.s21
          local q7 = s7.train
          p7 = if q7 then R.leftEgg == (R.st and R.st.DepartureAt) else not q7
        else
          p7 = f7
        end
        if p7 then
          if not (R.left) then
            h.doing = "Trading souls"
            DO(AO)
          end
          h.doing = "Souls traded, riding back home"
          XO()
          rO(1, AO)
          continue
        end
        if R.vis then
          h.visUntil = os.clock() + 10
        end
        if R.left then
        else
          if os.clock() >= EO then
            p7 = os.clock() + 2
            if wO() then
              h.doing = "Leaving town to steal an egg"
              R.leftEgg = R.st and R.st.DepartureAt
              XO()
            end
            EO = p7
          else
          end
        end
        local EO, s7, q7 = ((R.st and (type(R.st.Invasion) == "table")) and R.st.Invasion) or {}, xO(true), Shared.s21
        p7, f7 = q7.hwBoss and QO("Town"), xO(false)
        if if f7 then not f7 else not EO.VacuumOwned then
          h.doing = "Picking up the Ghost Vacuum"
          q7 = MO("TrainEventAction", "PickupVacuum")
          if q7 then
            if mO(uO(q7.Parent), AO) then
              hO(q7)
              VO(function()
                return xO(false) ~= nil
              end, 3, AO)
            else
              rO(1, AO)
            end
          else
            rO(1, AO)
          end
        else
          if (p7 and s7) and not n7("to vacuum Ghouler", AO) then
          else
            if p7 and s7 then
              R.vis = true
              h.doing = "Sucking in Ghouler"
              _O(s7)
              h.move = true
              ZO(p7)
            else
              if ((EO.Phase == "Active") and xO(false)) and not n7("to vacuum ghosts", AO) then
              else
                if (EO.Phase == "Active") and xO(false) then
                  R.vis = true
                  _O(xO(false))
                  local hO, f7 = workspace:FindFirstChild("TrainGhostVisuals"), Shared.s16
                  local s7 = f7()
                  if IO and IO.Parent then
                  else
                    IO = nil
                    local q7, c7, a7 = -math.huge, ipairs, (hO and hO:GetChildren()) or {}
                    for i7, M7 in c7(a7) do
                      f7 = M7:GetAttribute("TrainGhost") and uO(M7)
                      local c7, a7 = (f7 and s7) and (f7 - s7.Position).Magnitude
                      if c7 then
                        i7 = Shared.s21
                        a7 = ((i7.hwGhost == "Closest") and -c7) or (((((M7.Name:find("Vengeful") and 3) or (M7.Name:find("Haunted") and 2)) or 1) * 100000) - c7)
                      else
                        a7 = c7
                      end
                      if a7 and (a7 > q7) then
                        IO = M7
                        q7 = a7
                      else
                      end
                    end
                  end
                  f7 = IO and uO(IO)
                  if f7 and s7 then
                    h.doing = ("Vacuuming ghosts %s/%s"):format(tostring(EO.Captured or 0), tostring(EO.Goal or 50))
                    local q7 = Shared.s8
                    local c7, a7 = q7(), math.clamp(tonumber(IO:GetAttribute("ServerCaptureProgress")) or 0, 0, 1)
                    q7 = (((a7 >= 0.75) and 7) or ((a7 >= 0.5) and 10)) or 15
                    h.move = true
                    local i7, M7, H7, U7 = RaycastParams.new(), Enum.RaycastFilterType.Exclude, {}, Shared.LocalPlayer
                    f:yT(H7, 0, Shared.LocalPlayer.Character, hO)
                    i7.FilterType = M7
                    i7.FilterDescendantsInstances = H7
                    M7, a7 = nil
                    for U7 = 0, 15, 1 do
                      H7 = Shared.Vec3
                      local L7, I7 = f7 + (H7(math.cos((U7 * 3.141592653589793) / 8), 0, math.sin((U7 * 3.141592653589793) / 8)) * q7), 12
                      for t7, B7 in ipairs(hO:GetChildren()) do
                        t7 = (B7 ~= IO) and uO(B7)
                        I7 = if t7 then math.min(I7, lO(L7 - t7).Magnitude) else I7
                      end
                      U7 = ((I7 * 10) - lO(L7 - s7.Position).Magnitude) - ((workspace:Raycast(f7, L7 - f7, i7) and 1000) or 0)
                      if M7 then
                        if U7 > M7 then
                          M7, a7 = U7, L7
                        else
                        end
                      else
                        M7, a7 = U7, L7
                      end
                    end
                    i7, M7, H7 = math.clamp(tonumber(IO:GetAttribute("ServerCaptureProgress")) or 0, 0, 1), (s7.Position - f7).Magnitude < 24, math.min(os.clock() - (h.gT or 0), 0.1)
                    h.gT = os.clock()
                    local U7 = Shared.s21
                    local L7 = (U7.hwGhostSp or 150) * (1 - (0.9 * i7))
                    if i7 > 0.5 then
                      local function I7(t7)
                        local B7 = 12
                        for K7, P7 in ipairs(hO:GetChildren()) do
                          K7 = (P7 ~= IO) and uO(P7)
                          B7 = if K7 then math.min(B7, lO(t7 - K7).Magnitude) else B7
                        end
                        return B7
                      end
                      U7 = nil
                      for IO = 0, 15, 1 do
                        local hO = Shared.Vec3
                        local t7, t7 = Shared.Vec3, hO(f7.X, s7.Position.Y, f7.Z) + (Shared.Vec3(math.cos((IO * 3.141592653589793) / 8), 0, math.sin((IO * 3.141592653589793) / 8)) * q7)
                        IO = (I7(t7) * 10) - lO(t7 - s7.Position).Magnitude
                        if U7 then
                          if IO > U7 then
                            U7, a7 = IO, t7
                          else
                          end
                        else
                          U7, a7 = IO, t7
                        end
                      end
                      M7, L7 = true, ((I7(s7.Position) < 12) and 60) or 6
                    else
                    end
                    if c7 then
                      q7 = lO(a7 - s7.Position)
                      h.ws0 = h.ws0 or jO(c7)
                      c7.AutoRotate = false
                      if q7.Magnitude > 2 then
                        i7, U7 = M7 and L7
                        if i7 then
                          U7 = i7
                        else
                          local IO = Shared.s21
                          U7 = IO.hwGhostSp
                        end
                        local IO = math.clamp(q7.Magnitude * 8, math.min(8, U7), U7)
                        c7.WalkSpeed = IO
                        local jO = Shared.Vec3
                        c7:MoveTo(jO(a7.X, s7.Position.Y, a7.Z))
                        jO = nil
                        jO, s7.AssemblyLinearVelocity = Shared.Vec3, (q7.Unit * IO) + Shared.Vec3(0, math.min(s7.AssemblyLinearVelocity.Y, 8), 0)
                      else
                        c7:MoveTo(s7.Position)
                        local IO = Shared.Vec3
                        s7.AssemblyLinearVelocity = IO(0, math.min(s7.AssemblyLinearVelocity.Y, 8), 0)
                      end
                      local IO, jO = Shared.CFrameNew
                      jO, s7.CFrame = Shared.Vec3, IO(s7.Position, Shared.Vec3(f7.X, s7.Position.Y, f7.Z))
                    else
                      local IO = a7 - s7.Position
                      a7 = if M7 then if IO.Magnitude > (L7 * H7) then s7.Position + ((IO.Unit * L7) * H7) else a7 else a7
                      local IO, jO, hO = Shared.s32, Shared.CFrameNew, Shared.Vec3
                      IO(jO(a7, hO(f7.X, a7.Y, f7.Z)))
                    end
                  else
                    h.doing = "Waiting for ghosts"
                    h.move = false
                    dO(false)
                  end
                else
                  if (EO.Phase == "Warmup") or (EO.Phase == nil) then
                    h.doing = "Invasion starts soon"
                    rO(0.5, AO)
                  elseif EO.Phase == "Active" then
                    h.doing = "Waiting for the Ghost Vacuum"
                    rO(0.5, AO)
                  else
                    local IO = R.st and R.st.DepartureAt
                    if R.tradeDep ~= IO then
                      R.tradeDep = IO
                      local IO = Shared.s8
                      local jO = IO()
                      if jO then
                        jO:UnequipTools()
                      end
                      IO = Shared.s21
                      if IO.hwSouls then
                        h.doing = "Trading souls"
                        DO(AO)
                      end
                    end
                    if not (R.left) then
                      R.doneDep = R.st and R.st.DepartureAt
                    end
                    h.doing = "Riding back home"
                    XO()
                    rO(1, AO)
                  end
                end
              end
            end
          end
        end
        p7 = Shared.WaitHeartbeat
        p7()
      end
      h.move = false
      XO = Shared.s8
      local IO = XO()
      if IO then
        IO:UnequipTools()
        IO.AutoRotate = true
        if h.ws0 then
          IO.WalkSpeed = h.ws0
          h.ws0 = nil
        end
      end
      dO(false)
      if R.vis then
        if not (oO()) then
          h.visUntil = 0
        end
      end
    end
    local function IO()
      local jO = Shared.LocalPlayer
      return jO:GetAttribute("TrainEventTravelStage") == "Prepare"
    end
    local function jO(hO)
      if IO() then
        h.doing = "Already boarding, waiting for the Phantom Express"
        VO(function()
          return not IO()
        end, 30, hO)
        R.fail = os.clock() + 30
        return
      end
      if not (n7("before boarding", hO)) then
        return
      end
      local DO = R.st
      h.doing = "Boarding the Phantom Express"
      if not (zO()) then
        if not (WO(hO)) then
          R.fail = os.clock() + 10
          return
        end
      end
      if DO then
        if not (DO.AtStation) then
          if (os.clock() - (R.stAt or -99)) > 10 then
            R.stAt = os.clock()
            local dO = Shared.s10
            dO("Phantom Express: going to the station")
            o("Station")
            rO(3, hO)
            aO()
          end
        end
      end
      DO = MO("Name", "TrainBoard")
      if not DO then
        local MO = Shared.s10
        MO("Phantom Express: boarding prompt not found", "warn")
        R.fail = os.clock() + 20
        return
      end
      if not (mO(JO(DO, "BoardRailStart", "BoardRailEnd"), hO)) then
        return
      end
      DO = NO("TrainEvent")
      if not ((type(DO) == "table") and DO.AccessUnlocked) then
        _O(YO())
        rO(0.4, hO)
      end
      if IO() then
        return
      end
      local MO, MO, JO = o("Board")
      if MO then
        DO = Shared.s10
        DO("Boarded the Phantom Express", "ok")
      else
        R.fail = os.clock() + 30
        local o = Shared.s10
        o("Phantom Express: " .. tostring(JO or "could not board"), "warn")
        VO(function()
          return not IO()
        end, 30, hO)
      end
      if MO then
        h.doing = "Boarded, waiting for the Phantom Express to leave"
        VO(function()
          local o, MO = SO(), Shared.LocalPlayer
          local IO = MO:GetAttribute("TrainEventTravelStage")
          return (IO == "Failed") or ((IO ~= "Prepare") and (((o == "Departing") or (o == "Town")) or (o == "Returning")))
        end, 25, hO)
      end
    end
    local o = sO({name = "Train", mover = true, gap = 1, pri = 3})
    o.on = function()
      local MO, IO = R.st and R.st.SoulShop, Shared.s21
      local JO, YO, hO = ((IO.hwSouls and (type(MO) == "table")) and (MO.CanTrade == true)) and ((tonumber(MO.Souls) or 0) >= (tonumber(MO.Cost) or math.huge)), SO(), Shared.s21
      if hO.train then
      elseif JO then
      elseif R.soulRide then
        if not (YO == "Town") then
          if not (nO[YO]) then
            return false
          end
        end
      else
        return false
      end
      YO = Shared.s21
      if not (YO.train) then
        if FO() then
          R.soulRide = JO or nil
        end
      end
      if R.leftEgg ~= nil then
        if FO() then
          if R.leftEgg == R.st.DepartureAt then
            IO = R.st.Invasion
            if type(IO) ~= "table" then
              R.soulRide = nil
            elseif IO.Phase == nil then
              R.soulRide = nil
            elseif IO.Phase == "Active" then
              R.soulRide = nil
            elseif IO.Phase == "Warmup" then
              R.soulRide = nil
            elseif JO then
              R.soulRide = true
            else
              return false
            end
          end
        end
      end
      return (SO() == "Town") or ((((FO() and (os.clock() >= (R.fail or 0))) and OO()) and not wO()) and (R.doneDep ~= R.st.DepartureAt))
    end
    o.want = function()
      local MO = Shared.s29
      if MO() then
        return
      end
      return ((SO() == "Town") and "town") or "board"
    end
    local MO, IO, JO = 0, false, Shared.Core
    JO.trainBoard = function()
      if (os.clock() - MO) >= 0.5 then
        MO = os.clock()
        local MO = o.on()
        local JO
        if MO then
          local YO = Shared.s29
          JO = not YO()
        else
          JO = MO
        end
        IO = JO
      end
      local MO = IO
      return MO
    end
    o.run = function(MO, IO)
      if MO == "town" then
        T(IO)
      else
        jO(IO)
      end
    end
    local T = Shared.Core
    T.hwKeep = function()
      local T, MO = SO(), Shared.s21
      local IO, JO = MO.train or R.soulRide
      if IO then
        local YO, jO = (T == "Town") or (nO[T] == true)
        if YO then
          jO = YO
        else
          MO = Shared.LocalPlayer
          local T = MO.Character
          if T then
            local MO = Shared.LocalPlayer
            jO = MO.Character:GetAttribute("TrainEventInForgottenTown") == true
          else
            jO = T
          end
        end
        JO = jO or o.on()
      else
        JO = IO
      end
      return JO
    end
    local T = sO({name = "Ghouler", mover = true, gap = 1, pri = 2})
    T.on = function()
      local MO = Shared.s21
      return (((MO.hwBoss and (SO() ~= "Town")) and not zO()) and (QO("World") ~= nil)) and (xO(true) ~= nil)
    end
    T.want = function()
      local MO = Shared.s29
      if MO() then
        return
      end
      return QO("World")
    end
    T.run = function(MO, IO)
      local JO = MO:GetAttribute("Ground")
      if typeof(JO) == "Vector3" then
        local zO = Shared.Vec3
        if not (mO(JO + zO(42, 0, 0), IO)) then
          return
        end
      end
      while IO() and (QO("World")) do
        _O(xO(true))
        h.doing = "Sucking in Ghouler"
        ZO(MO)
        JO = Shared.WaitHeartbeat
        JO()
      end
      t("RE/GhostBoss/Suction", false)
    end
    local MO = sO({name = "TrainInfo", gap = 3})
    MO.on = function()
      local IO = Shared.s21
      if not (IO.train) then
        if not (o.busy) then
          if SO() ~= "Town" then
            if not (nO[SO()]) then
              if not (FO()) then
                R.soulRide = nil
              end
            end
          end
        end
      end
      IO = Shared.s21
      local nO, JO = IO.train
      if nO then
        JO = nO
      else
        IO = Shared.s21
        JO = IO.hwBoss
      end
      IO = nil
      if JO then
        IO = JO
      else
        nO = Shared.s21
        IO = nO.hwSouls
      end
      return IO
    end
    MO.fn = function()
      aO()
    end
    local function aO()
      local nO = Shared.Invoke
      local MO, MO = nO("RF/IslandWars/Fetch")
      bO(MO)
    end
    TO("RE/LiveEvents/Began", function(nO)
      if nO == "CursedIslandWars" then
        _.sd = false
        _.col = nil
        task.spawn(aO)
      end
    end)
    TO("RE/LiveEvents/Ended", function(nO)
      if nO == "CursedIslandWars" then
        _.snap = nil
        _.sd = false
        _.col = nil
      end
    end)
    local nO = sO({name = "IslandWarsInfo", gap = 5})
    nO.on = function()
      return (_.snap ~= nil) and (iO[_.snap.Phase] == true)
    end
    nO.fn = aO
    TO("RE/IslandWars/State", bO)
    TO("RE/IslandWars/Moment", function(iO, nO, MO)
      if (iO == "Cooldown") and (type(nO) == "string") then
        _.cd[nO] = tonumber(MO) or 0
      elseif ((iO == "SuddenDeath") or (iO == "EarlySuddenDeath")) or (((iO == "Warning") and tonumber(nO)) and (tonumber(nO) <= 15)) then
        _.sd = true
      elseif (iO == "CollapseWarn") and (type(nO) == "table") then
        _.col, _.colAt = nO, os.clock()
      elseif iO == "Win" then
        _.sd = false
      elseif iO == "Outro" then
        _.sd = false
      end
    end)
    task.spawn(function()
      local iO = Shared.Invoke
      local nO, nO = iO("RF/LiveEvents/FetchRunning")
      if type(nO) == "table" then
        if nO.CursedIslandWars then
          aO()
        end
      end
    end)
    local function aO(iO)
      pcall(function()
        local nO = require(a.Controllers.Game.AdminAbuseClientController.Events.CursedIslandWars.Input)
        _.k0 = _.k0 or nO.Knock
        nO.Knock = (iO and (function()
        end)) or _.k0
      end)
    end
    gO, TO = Shared.Core, Shared.Core
    gO.cleanup = TO.cleanup or {}
    table.insert(Shared.Core.cleanup, function()
      aO(false)
    end)
    table.insert(Shared.Core.cleanup, function()
      local iO = Shared.Core
      iO.hwPortalOff = true
      iO = Shared.s22
      local nO = iO("HalloweenDimensionPortal", "Hitbox")
      if nO then
        nO.CanTouch = true
      end
    end)
    local function iO()
      local nO = Shared.s16
      local MO = nO()
      if MO then
        if _.col then
          if not ((os.clock() - _.colAt) < 8) then
            return false
          end
        else
          return false
        end
      else
        return false
      end
      nO = RaycastParams.new()
      nO.FilterType = Enum.RaycastFilterType.Include
      nO.FilterDescendantsInstances = _.col
      local IO, IO = Shared.Vec3, workspace:Raycast(MO.Position, Shared.Vec3(0, -14, 0), nO)
      return IO ~= nil
    end
    local function nO(MO)
      return RO(function(IO)
        return IO.Name == MO
      end)
    end
    local MO = sO({name = "IslandWars", mover = true, gap = 0.3, pri = -2, urgent = true, ev = function()
      return true
    end})
    MO.on = function()
      local IO, JO, zO = _.snap, _.me(), Shared.s21
      return ((((zO.ciw and (IO ~= nil)) and (w[IO.Phase] == true)) and (JO ~= nil)) and (JO.State == "Alive")) and ((os.clock() - _.at) < 30)
    end
    MO.want = function()
      return true
    end
    MO.run = function(IO, JO)
      aO(true)
      while JO() do
        local JO, zO, YO = _.snap, _.me(), Shared.s16
        IO = YO()
        if JO then
          if zO then
            if IO then
              if zO.State == "Alive" then
                if not (w[JO.Phase]) then
                  break
                end
              else
                break
              end
            else
              break
            end
          else
            break
          end
        else
          break
        end
        local w, jO, OO = ((zO.Team == "Red") and "Blue") or "Red", K(), JO.Island and JO.Island:FindFirstChild("Centre")
        YO = uO(OO and (OO:FindFirstChild("Top")))
        zO = YO and ((_.sd or (JO.Phase == "SuddenDeath")) or iO())
        if zO then
          if lO(IO.Position - YO).Magnitude > 18 then
            h.doing = "Island Wars: moving to the centre"
            local iO, OO = lO(YO - IO.Position).Unit
            OO, IO.AssemblyLinearVelocity = Shared.Vec3, (iO * math.max(P(), 30)) + Shared.Vec3(0, IO.AssemblyLinearVelocity.Y, 0)
          end
        end
        zO, YO = 25
        for iO, lO in ipairs(((type(JO.Entries) == "table") and JO.Entries) or {}) do
          iO = ((((type(lO) == "table") and (lO.Team == w)) and (lO.State == "Alive")) and (typeof(lO.Model) == "Instance")) and lO.Model:FindFirstChild("HumanoidRootPart")
          lO = iO and (iO.Position - IO.Position).Magnitude
          if lO then
            if lO < zO then
              zO, YO = lO, iO
            else
            end
          else
          end
        end
        local iO = Shared.s21
        YO = if iO.ciwT == "Walls and crystal" then nil else YO
        if JO.Phase ~= "Prep" then
          local lO, OO = nO("Bat"), nO("PumpkinLauncher")
          if ((YO and (zO <= 10)) and lO) and (jO >= (_.cd.Bat or 0)) then
            h.doing = "Island Wars: hitting an enemy"
            _O(lO)
            kO(YO.Position)
            t("RE/IslandWars/Use", "Swing", YO)
            _.cd.Bat = math.max(_.cd.Bat or 0, jO + 0.75)
          elseif OO then
            if jO >= (_.cd.PumpkinLauncher or 0) then
              local nO, lO = (type(JO.Barriers) == "table") and JO.Barriers[w], (type(JO.Crystals) == "table") and JO.Crystals[w]
              iO = ((YO and (YO.Position + (YO.AssemblyLinearVelocity * (zO / 110)))) or (((nO and ((tonumber(nO.Health) or 0) > 0)) and (typeof(nO.Model) == "Instance")) and uO(nO.Model:FindFirstChild("Hitbox") or nO.Model))) or (((lO and ((tonumber(lO.Health) or 0) > 0)) and (typeof(lO.Model) == "Instance")) and uO(lO.Model:FindFirstChild("Pivot", true) or lO.Model))
              if iO then
                h.doing = (YO and "Island Wars: shooting an enemy") or "Island Wars: shooting the enemy base"
                _O(OO)
                kO(iO)
                nO = OO:FindFirstChild("Handle") and OO.Handle:FindFirstChild("Muzzle")
                local w, zO = (nO and nO:IsA("Attachment")) and nO.WorldPosition
                if w then
                  zO = w
                else
                  lO = nil
                  lO, zO = Shared.Vec3, IO.Position + Shared.Vec3(0, 1.5, 0)
                end
                if (iO - zO).Magnitude > 1 then
                  _.shot = _.shot + 1
                  t("RE/IslandWars/Use", "Launch", _.shot, zO, (iO - zO).Unit)
                  _.cd.PumpkinLauncher = math.max(_.cd.PumpkinLauncher or 0, jO + 1.25)
                end
              end
            end
          end
        end
        JO = Shared.WaitHeartbeat
        JO()
      end
    end
    gO, y7 = LO.Halloween:Section("Halloween Dimension", "ghost"), Shared.Core
    y7.hwEggsT = m(gO, "Auto steal Halloween eggs", "hwEggs", false, (eO(C)))
    m(gO, "Instant steal Halloween eggs", "hwInstant", true)
    m(gO, "Steal missing Halloween index", "hwIndex", false, function()
      h.ixAt = 0
      h.idleUntil = 0
    end)
    S(gO, "Steal speed", "hwStep", 10, 100, 40, " st", 5)
    TO, y7 = function()
      local w = {}
      pcall(function()
        for iO, nO in next, require(a.Data.HalloweenPets).Specs, nil do
          w[((type(nO) == "table") and nO.Id) or iO] = true
        end
      end)
      return e(w)
    end, function(e)
      local w = Shared.s21
      w.hwEggOnly = nil
      w = ipairs
      for iO, iO in w(e) do
        local e, w = Shared.s21, Shared.s21
        e.hwEggOnly = w.hwEggOnly or {}
        e = Shared.s21
        e.hwEggOnly[iO] = true
      end
    end
    gO:Dropdown("Halloween eggs", TO, {}, y7, true)
    local function e(w)
      local iO = Shared.s21
      iO.hwRar = nil
      iO = ipairs
      for nO, nO in iO(w) do
        local w, iO = Shared.s21, Shared.s21
        w.hwRar = iO.hwRar or {}
        iO = Shared.s21
        iO.hwRar[nO] = true
      end
    end
    gO:Dropdown("Halloween rarities", l, {}, e, true)
    gO:Slider("Min value /s", 0, 0, 0, function(l)
      local w = Shared.s21
      w.hwMinV = ((l > 0) and l) or nil
    end, "log")
    m(gO, "Auto Pumpkin Moon", "hwPump", true)
    S(gO, "Walk speed", "hwPumpSp", 100, 1000, 300, " st/s", 10)
    m(gO, "Auto buy Halloween Dimension Egg", "hwBuy", false)
    e = LO.Halloween:Section("Monsters", "swords")
    m(e, "Auto farm monsters", "hwMon", false, (eO(C)))
    y7, TO = {}, {{"Candy Corn", 12, 95288958121268}, {"Hollow Bat", 12, 74981089555029}, {"Scarecrow", 28, 116705851588512}, {"Chest Mimic", 28, 127208298529364}, {"Pumpkin Golem", 65, 84950520721038}, {"Soul Phantom", 65, 139447998862041}}
    for l, l in ipairs(TO) do
      y7[#y7 + 1] = {v = l[1], t = l[1], img = "rbxassetid://" .. l[3], note = "+" .. (l[2] .. " Candy Corn")}
    end
    local function l(w)
      local iO = Shared.s21
      iO.hwMonKinds = nil
      iO = ipairs
      for nO, nO in iO(w) do
        local w, iO = Shared.s21, Shared.s21
        w.hwMonKinds = iO.hwMonKinds or {}
        w = Shared.s21
        w.hwMonKinds[nO] = true
      end
    end
    e:Dropdown("Monsters", y7, {}, l, true)
    x(e, "Monster order", "hwMonOrder", {"Closest", "Most tokens"}, "Closest")
    S(e, "Walk speed", "hwMonSp", 100, 1000, 300, " st/s", 10)
    local function w()
      local iO, nO, IO = {}, ipairs, Shared.Core
      local JO = f[53](IO.ownedWeapons())
      for zO, zO in nO(f:uT(JO)) do
        IO = Shared.Modules
        local nO, nO = Shared.Core, IO.Gears.Directory[Shared.Core.weaponId[zO] or zO]
        if type(nO) == "table" then
          if nO.BatControllerData then
            iO[#iO + 1] = zO
          elseif nO.ToolController == "Slap" then
            iO[#iO + 1] = zO
          end
        end
      end
      return iO
    end
    local function iO(nO)
      local IO = Shared.s21
      IO.hwWeap = nil
      IO = ipairs
      for JO, JO in IO(nO) do
        local nO, IO = Shared.s21, Shared.s21
        nO.hwWeap = IO.hwWeap or {}
        nO, IO = Shared.s21
        IO, nO.hwWeap[Shared.Core.weaponId[JO] or JO] = Shared.Core, true
      end
    end
    e:Dropdown("Use weapons", w, w(), iO, true)
    l = LO.Halloween:Section("Ghost Dog and fishing", "hand")
    local e = l:Stats({{"Quest", V.check}, {"Fish caught", V.net}})
    m(l, "Auto Ghost Dog quest", "hwDog", false, (eO(C)))
    m(l, "Auto fishing", "hwFish", false, (eO(C)))
    x(l, "Cast luck", "hwLuck", {"x1.5 Perfect", "x1.2", "x1.1", "x1.0 Fastest"}, "x1.5 Perfect")
    w = LO.Halloween:Section("Phantom Express", "zap")
    local l = w:Stats({{"Train", V.timer}, {"Souls", V.soul}})
    m(w, "Auto Phantom Express", "train", false, (eO(o)))
    m(w, "Auto vacuum Ghouler boss", "hwBoss", true)
    x(w, "Ghost target", "hwGhost", {"Rarest first", "Closest"}, "Rarest first")
    S(w, "Walk speed", "hwGhostSp", 100, 1000, 300, " st/s", 10)
    m(w, "Auto trade souls", "hwSouls", false)
    gO = LO.AA:Section("Cursed Island Wars", "swords")
    local w = X("ciw", gO:Text("Waiting for Cursed Island Wars"))
    m(gO, "Auto play Cursed Island Wars", "ciw", true, function(X)
      aO(X and _.held())
      if not (X) then
        qO(MO)
      end
    end)
    x(gO, "Island Wars target", "ciwT", {"Enemies and base", "Walls and crystal"}, "Enemies and base")
    local X = sO({name = "HalloweenNote", gap = 0.5, info = true})
    X.on = function()
      local aO = (Shared.s4 ~= nil) and ((((Shared.s4 == C) or (Shared.s4 == o)) or (Shared.s4 == T)) or (Shared.s4 == MO))
      return aO and (h.doing ~= h.noted)
    end
    X.fn = function()
      h.noted = h.doing
      local C = Shared.s10
      C(h.doing)
    end
    local C = sO({name = "HalloweenInfo", gap = 1})
    C.on = function()
      return BO("Event")
    end
    C.fn = function()
      local C, T, X, o = NO("TrainEvent"), R.st, K(), SO()
      E("hwb", e, {Quest = HO[G7() + 1] or "Done", ["Fish caught"] = tostring(h.fish)})
      E("hwc", l, {Train = (((o and (o ~= "Home")) and o) or (FO() and ("Boarding " .. v(math.max((tonumber(T.DepartureAt) or X) - X, 0))))) or "Not here", Souls = ((type(C) == "table") and O(tonumber(C.Souls) or 0)) or "--"})
      o, C, T = _.snap, _.me(), Shared.s21
      X = T.ciw
      w((((if X then not X else "Off") or ((o and C) and (o.Phase .. (" | Team " .. (tostring(C.Team) .. (" | " .. tostring(C.State))))))) or (o and "Watching, you are not on a team")) or "Waiting for Cursed Island Wars")
    end
  end)()
  do
    local C = G("TweenService")
    local l = I("Folder", {Parent = (gethui and gethui()) or G("CoreGui")})
    table.insert(Shared.Core.cleanup, function()
      l:Destroy()
    end)
    local h = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold)
    local R = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    local _, T = Color3.new(1, 1, 1), "#7CFF7A"
    local e = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    Shared.s21.tagSize = 100
    Shared.s21.espFixed = false
    local function w(X)
      return ("#%02X%02X%02X"):format(X.R * 255, X.G * 255, X.B * 255)
    end
    local function X(o, aO, iO, nO)
      local MO = I("TextLabel", {Parent = o, LayoutOrder = nO, BackgroundTransparency = 1, Size = UDim2.fromScale(1, iO / 42), FontFace = aO, TextScaled = true, TextColor3 = _, RichText = true, Text = "", TextTransparency = 1})
      I("UITextSizeConstraint", {Parent = MO, MaxTextSize = iO, MinTextSize = 1})
      return MO, (I("UIStroke", {Parent = MO, Color = Color3.new(0, 0, 0), Thickness = 1.6, Transparency = 1, LineJoinMode = Enum.LineJoinMode.Round}))
    end
    local function _(o)
      local aO = Shared.s21
      local iO, nO = aO.tagSize / 100, Shared.s21
      o.Size = (nO.espFixed and UDim2.new(5 * iO, 130 * iO, 1.25 * iO, 34 * iO)) or UDim2.fromOffset(240, 60)
    end
    local function o(aO, iO, nO, MO, HO, IO, BO)
      local JO, NO = {Parent = l, Adornee = aO, AlwaysOnTop = true, LightInfluence = 0}, Shared.Vec3
      JO.StudsOffsetWorldSpace = NO(0, HO or 3, 0)
      JO.MaxDistance = 3000
      local l = I("BillboardGui", JO)
      _(l)
      HO = Shared.s21
      JO, NO = HO.espFixed and 1
      if JO then
        NO = JO
      else
        aO = Shared.s21
        NO = aO.tagSize / 100
      end
      aO, JO = I("UIScale", {Parent = l, Scale = NO * 0.8}), I("Frame", {Parent = l, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1)})
      I("UIListLayout", {Parent = JO, SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Bottom})
      local zO = I("ImageLabel", {Parent = JO, LayoutOrder = 0, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.42857142857142855), ScaleType = Enum.ScaleType.Fit, ImageTransparency = 1, Visible = false})
      local YO, lO = X(JO, h, 11, 1)
      local uO, jO = X(JO, h, 16, 2)
      local h, gO = X(JO, R, 12, 3)
      local R = {b = l, s = aO, paint = function(X, JO, OO, hO)
        if zO.Image ~= (hO or "") then
          zO.Image, zO.Visible = hO or "", hO ~= nil
        end
        if YO.Text ~= X then
          YO.Text, YO.Visible = X, X ~= ""
        end
        if uO.Text ~= JO then
          uO.Text = JO
        end
        if h.Text ~= OO then
          h.Text = OO
        end
      end, grad = function(X)
        local JO = uO:FindFirstChildOfClass("UIGradient")
        if JO then
          if JO:GetAttribute("src") == X then
            return
          end
        end
        if JO then
          JO:Destroy()
        end
        if X then
          JO = X:Clone()
          JO:SetAttribute("src", X)
          JO.Parent = uO
        end
      end}
      R.paint(iO, nO, MO, BO)
      R.grad(IO)
      C:Create(zO, e, {ImageTransparency = 0}):Play()
      HO = {YO, uO, h}
      for X, X in ipairs(HO) do
        C:Create(X, e, {TextTransparency = 0}):Play()
      end
      BO = {lO, jO, gO}
      for X, X in ipairs(BO) do
        C:Create(X, e, {Transparency = 0.35}):Play()
      end
      C:Create(aO, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Scale = NO}):Play()
      R.drop = function()
        C:Create(zO, e, {ImageTransparency = 1}):Play()
        local X = {YO, uO, h}
        for h, h in ipairs(X) do
          C:Create(h, e, {TextTransparency = 1}):Play()
        end
        X = {lO, jO, gO}
        for h, h in ipairs(X) do
          C:Create(h, e, {Transparency = 1}):Play()
        end
        task.delay(0.26, function()
          l:Destroy()
        end)
      end
      return R
    end
    local C = {}
    local l = sO({name = "ESP", gap = 0.5})
    local function h()
      l.clear = true
    end
    local function R(e, X)
      local aO = C[e] or {}
      C[e] = aO
      for iO, nO in next, X, nil do
        e = aO[iO]
        if e then
          if e.b.Adornee ~= nO[1] then
            e.drop()
            e = nil
          else
          end
        else
        end
        if e then
          e.paint(nO[2], nO[3], nO[4], nO[7])
          e.grad(nO[6])
        else
          aO[iO] = o(nO[1], nO[2], nO[3], nO[4], nO[5], nO[6], nO[7])
        end
      end
      for e, o in next, aO, nil do
        if not (X[e]) then
          o.drop()
          aO[e] = nil
        end
      end
    end
    tO = LO.ESP:Section("Field eggs", "eye", 1)
    m(tO, "Egg ESP", "espEggs", false, h)
    local e = {Name = true, Value = true, Mutation = true}
    tO:Dropdown("Show", {"Icon", "Name", "Rarity", "Value", "Mutation", "Size", "Weight", "Area"}, {"Name", "Value", "Mutation"}, function(X)
      e = b(X) or {}
    end, true)
    local b = fO(tO, {rar = {"Mythic", "Cosmic", "Secret", "Eternal", "Divine"}, mut = "Mutations", wild = true, minV = "Min value /s"})
    pO = LO.ESP:Section("Others", "shield", 2)
    m(pO, "Pen egg ESP", "espPen", false, h)
    m(pO, "Other pens ESP", "espPens", false, h)
    m(pO, "Guard ESP", "espGuards", false, h)
    m(pO, "Hide sleeping guards", "espAwake", true, h)
    m(pO, "Player ESP", "espPlayers", false, h)
    local function h(X)
      for o, o in next, C, nil do
        for C, C in next, o, nil do
          X(C)
        end
      end
    end
    m(tO, "Fixed size", "espFixed", false, function()
      h(function(C)
        local X, o = C.s, Shared.s21
        local aO, iO = o.espFixed and 1
        if aO then
          iO = aO
        else
          o = Shared.s21
          iO = o.tagSize / 100
        end
        X.Scale = iO
        _(C.b)
      end)
    end)
    S(pO, "ESP size", "tagSize", 60, 160, 100, "%", 5, function(C)
      h(function(h)
        local X
        X, h.s.Scale = Shared.s21, (Shared.s21.espFixed and 1) or (C / 100)
        _(h.b)
      end)
    end)
    local function C(h)
      local _ = {}
      for X, o in ipairs(h.m) do
        X = GO[o]
        _[#_ + 1] = ("<font color=\"%s\">%s</font>"):format((X and w(X)) or "#FFFFFF", (j[o] or o):upper())
      end
      return table.concat(_, "  ")
    end
    local function h(_)
      local X = f[53](O(_))
      return ("<font color=\"%s\">$%s/s</font>"):format(T, f:uT(X))
    end
    local function _(X)
      local o, GO = w(k(X.cat)), Y[X.r] or "?"
      return ("<font color=\"%s\">%s</font>"):format(o, GO)
    end
    local function k(X, o)
      local GO = {}
      if e.Rarity then
        GO[#GO + 1] = _(X)
      end
      if e.Value then
        GO[#GO + 1] = h(X.v)
      end
      if e.Size then
        GO[#GO + 1] = ("x%.2f"):format(X.s)
      end
      if e.Weight then
        local h = Shared.Fire
        local _ = h("Rec", "WeightKgForScale", X.cat, X.s)
        if _ then
          GO[#GO + 1] = O(_) .. "kg"
        end
      end
      if e.Area then
        if o.AreaId then
          GO[#GO + 1] = tostring(o.AreaId)
        end
      end
      local h, _ = (e.Mutation and C(X)) or "", (e.Name and X.n) or ""
      return h, _, table.concat(GO, "  ")
    end
    local function C(h, _, X)
      local o
      if X then
        local GO = Shared.Fire
        o = GO("Egg", "IsReadyToHatch", _.Uid) == true
      else
        o = X
      end
      X = (o and 0) or N(_)
      local N, o, GO, aO = ((X <= 0) and ("<font color=\"%s\">READY</font>"):format(T)) or v(X), k(h, _)
      return o, GO, (((aO ~= "") and (aO .. "  ")) or "") .. N
    end
    local function N(h)
      if not (e.Icon) then
        return
      end
      local _ = (g(h.cat) or {}).Icon
      return ((type(_) == "number") and ("rbxassetid://" .. _)) or _
    end
    local h = {Sleeping = {"Sleeping", Color3.fromRGB(120, 230, 160)}, Waking = {"Waking up", Color3.fromRGB(255, 205, 100)}, Chasing = {"Chasing", Color3.fromRGB(255, 100, 110)}}
    l.on = function()
      local _ = Shared.s21
      local T, e = _.espEggs
      if T then
        e = T
      else
        _ = Shared.s21
        e = _.espPen
      end
      _ = nil
      if e then
        _ = e
      else
        T = Shared.s21
        _ = T.espPens
      end
      T = nil
      if _ then
        T = _
      else
        e = Shared.s21
        T = e.espGuards
      end
      _ = nil
      if T then
        _ = T
      else
        e = Shared.s21
        _ = e.espPlayers
      end
      return _ or l.clear
    end
    l.fn = function()
      l.clear = false
      local l, _ = {eggs = {}, pen = {}, pens = {}, guards = {}, players = {}}, Shared.s21
      if _.espEggs then
        local T, e, X = workspace:FindFirstChild("AreaEggSlotsClient"), pairs, Shared.s19
        local o = f[53](X())
        for GO, aO in e(f:uT(o)) do
          GO = (type(aO) == "table") and aO.Uid
          X = GO and aO.State
          local e = (((X == "Slot") or (X == "Dropped")) or (X == "Carried")) and ((T and T:FindFirstChild(GO)) or workspace:FindFirstChild(GO))
          local T = e and (e:FindFirstChild("Hitbox") or e:FindFirstChildWhichIsA("BasePart", true))
          if T then
            local e, o = r(aO), Shared.s63
            if o(b, e) then
              local b, o, iO = k(e, aO)
              local k = (X == "Carried") and tonumber(aO.CarrierUserId)
              local aO = k and (c:GetPlayerByUserId(k))
              if aO then
                k = Shared.LocalPlayer
                iO ..= ("  <font color=\"#FF8A5C\">%s</font>"):format(((aO == k) and "you have it") or (aO.DisplayName .. " has it"))
              else
                iO = if X == "Dropped" then iO .. "  <font color=\"#FFD25C\">dropped</font>" else iO
              end
              l.eggs[GO] = {T, b, o, iO, 3.4, F(e.cat), N(e)}
            end
          end
        end
      end
      _ = Shared.s21
      if _.espPen then
        for k, T in pairs(D()) do
          if type(T) == "table" then
            if T.Placement then
              local e = vO(k)
              local b = e and (e.PrimaryPart or e:FindFirstChildWhichIsA("BasePart", true))
              if b then
                e = r(T)
                local X, o, GO = C(e, T, true)
                l.pen[k] = {b, X, o, GO, 3.2, F(e.cat), N(e)}
              end
            end
          end
        end
      end
      _ = Shared.s21
      if _.espPens then
        local k, T, e = workspace:FindFirstChild("PlacedEggRenders"), ipairs, f[53](c:GetPlayers())
        for b, X in T(f:uT(e)) do
          b = Shared.LocalPlayer
          if (X ~= b) and k then
            local T = Shared.Fire
            local e = T("Egg", "ReadOwnerEggs", X.UserId)
            for b, o in pairs(((type(e) == "table") and e) or {}) do
              T = (type(o) == "table") and (o.Uid or b)
              b = o.Placement and k:FindFirstChild(X.UserId .. ("_" .. tostring(T)))
              local k = b and (b.PrimaryPart or b:FindFirstChildWhichIsA("BasePart", true))
              if k then
                b = r(o)
                local e, GO, aO = C(b, o, false)
                l.pens[X.UserId .. ("_" .. tostring(T))] = {k, e, GO, aO .. ("  " .. X.DisplayName), 3.2, F(b.cat), N(b)}
              end
            end
          end
        end
      end
      _ = Shared.s21
      if _.espGuards then
        local C = Shared.s22
        local N, k = C("Areas", "GuardAreas"), ipairs
        C = (N and N:GetChildren()) or {}
        for F, T in k(C) do
          F = T:FindFirstChild("Guard")
          N = F and (F:FindFirstChild("HumanoidRootPart") or F.PrimaryPart)
          if N then
            local C = Shared.s21
            if not (C.espAwake and (F:GetAttribute("GuardState") == "Sleeping")) then
              local C, k = h[F:GetAttribute("GuardState")] or {tostring(F:GetAttribute("GuardState") or "Idle"), Color3.fromRGB(160, 170, 210)}, tostring(F:GetAttribute("TargetPlayer") or "")
              local h, F = (k ~= "") and c:GetPlayerByUserId(tonumber(k) or 0), w(C[2])
              k = ("<font color=\"%s\">%s</font>"):format(F, C[1])
              F = nil
              if h then
                C = Shared.LocalPlayer
                F = ((h == C) and "  you") or ("  " .. h.DisplayName)
              else
                F = h
              end
              h = k .. (F or "")
              l.guards[T.Name] = {N, "", T.Name .. " guard", h, 4.2}
            end
          end
        end
      end
      _ = Shared.s21
      if _.espPlayers then
        local C = Shared.s16
        local N, h, _ = C(), ipairs, f[53](c:GetPlayers())
        for k, F in h(f:uT(_)) do
          C = Shared.LocalPlayer
          k = (F ~= C) and F.Character
          local C = k and (k:FindFirstChild("Head") or k:FindFirstChild("HumanoidRootPart"))
          if C then
            local h, _ = F.Character:FindFirstChildOfClass("Tool"), (N and math.floor((C.Position - N.Position).Magnitude)) or 0
            l.players[F.Name] = {C, "", F.DisplayName, _ .. (" studs" .. (((h and ("  " .. h.Name)) or "") .. (((C.Name ~= "Head") and "  invisible") or ""))), 2.6}
          end
        end
      end
      A("esp", function()
        for C, N in next, l, nil do
          R(C, N)
        end
      end)
    end
  end
  do
    local C, N = LO.Move:Section("Movement", "wind"), false
    m(C, "Speed boost", "boostOn", false, function(l)
      UO("boost", l and M, function()
        local l = Shared.s8
        local h, R = l(), Shared.s16
        l = R()
        if Shared.s4 then
          N = false
          return
        elseif h then
          if l then
            if l.Anchored then
              N = false
              return
            elseif h.Sit then
              N = false
              return
            elseif h.PlatformStand then
              N = false
              return
            else
              R = Shared.s34
              if R() then
                N = false
                return
              end
            end
          else
            N = false
            return
          end
        else
          N = false
          return
        end
        local _, k = h.MoveDirection, l.AssemblyLinearVelocity.Y
        if _.Magnitude > 0.1 then
          local F, T, e, e, e = Shared.Vec3, _.X, Shared.s21, Shared.Vec3
          e, N = (F(T, 0, _.Z).Unit * Shared.s21.boost) + Shared.Vec3(0, k, 0), true
          l.AssemblyLinearVelocity = e
        elseif N then
          h, R = Shared.Vec3
          R, N = h(0, k, 0), false
          l.AssemblyLinearVelocity = R
        end
      end)
    end)
    S(C, "Boost speed", "boost", 30, 1000, 120, "", 5)
    local N, l = false, 0
    U(M, function()
      local h = Shared.s8
      local R, _ = h(), Shared.s16
      local k, F = _(), (R and R.Jump) or false
      _, h = F and k
      if _ then
        local T = N
        local e = not T
        if T then
          local T = Shared.s21
          h = T.jump and (os.clock() > l)
        else
          h = e
        end
      else
        h = _
      end
      if h then
        l = os.clock() + 0.25
        local l, h = k.Anchored and not Shared.s4
        if l then
          _ = Shared.Core
          h = (_.hold or 0) == 0
        else
          h = l
        end
        l = nil
        if h then
          local _
          _, l = Shared.Core, os.clock() > ((Shared.Core.doffAt or 0) + 0.6)
        else
          l = h
        end
        if l then
          h = Shared.Core
          h.doffAt = os.clock()
          task.spawn(Shared.Invoke, "RF/Treadmill/AskDoff")
        else
          local l = Shared.s21
          if l.jump then
            if not (z()) then
              if not (k.Anchored) then
                R:ChangeState(Enum.HumanoidStateType.Jumping)
              end
            end
          end
        end
      end
      N = F
    end)
    m(C, "Infinite jump", "jump", false)
    m(C, "God mode", "god", false, function(C)
      local N = Shared.s8
      local l = N()
      if l then
        if not (C) then
          CO(l)
        end
      end
    end)
    local C, N = pcall(require, a.Shared.Modules.Ragdoll)
    local a = {[Enum.HumanoidStateType.Physics] = true, [Enum.HumanoidStateType.Ragdoll] = true, [Enum.HumanoidStateType.FallingDown] = true}
    local function l()
      if z() then
        return true
      end
      local h = Shared.s22
      local R, _ = h("RaceRallyPortal"), Shared.s16
      local h, k = _(), R and (R:FindFirstChild("Hitbox"))
      return (((J() and k) and h) and ((h.Position - k.Position).Magnitude <= 40)) or false
    end
    local function J()
      local h = Shared.LocalPlayer
      local R, _ = h.Character, Shared.s8
      local k, F = _(), Shared.s16
      _ = F()
      if R then
        if k then
          if _ then
            if l() then
              return
            else
              h = Shared.Core
              if h.agBusy then
                return
              else
                F = Shared.LocalPlayer
                if F:GetAttribute("TrainEventTravelStage") == "Prepare" then
                  return
                else
                  local l = Shared.Core
                  if l.only then
                    local l = Shared.Core
                    if l.only() == "Train" then
                      return
                    end
                  end
                end
              end
            end
          else
            return
          end
        else
          return
        end
      else
        return
      end
      F, h = _.AssemblyLinearVelocity, Shared.Vec3
      local l, T = h(F.X, 0, F.Z), P() + 5
      l = if l.Magnitude > T then l.Unit * T else l
      T = Shared.Vec3
      _.AssemblyLinearVelocity = T(l.X, math.min(F.Y, 0), l.Z)
      if C then
        pcall(N.ClearClientRagdoll)
        pcall(N.Unragdoll, R)
      end
      for P, P in ipairs(R:GetDescendants()) do
        if P:IsA("BallSocketConstraint") then
          P:Destroy()
        elseif P:IsA("NoCollisionConstraint") then
          P:Destroy()
        elseif P:IsA("HingeConstraint") then
          P:Destroy()
        elseif P:IsA("Motor6D") then
          if not (P.Enabled) then
            P.Enabled = true
          end
        elseif P:IsA("AnimationConstraint") then
          if not (P.Enabled) then
            P.Enabled = true
          end
        end
      end
      if a[k:GetState()] then
        k:ChangeState(Enum.HumanoidStateType.Running)
      end
      if not Shared.s4 then
        k.PlatformStand = false
      end
      workspace.CurrentCamera.CameraSubject = k
    end
    local function a()
      local P = Shared.Core
      if P.rag then
        return
      end
      task.spawn(function()
        for P = 1, 15, 1 do
          pcall(J)
          task.wait(0.033)
        end
      end)
    end
    Shared.Core.burst = a
    u = LO.Move:Section("Protection", "shield")
    Shared.Core.prot = u
    m(u, "Anti ragdoll", "antiRag", true, function(P)
      local J
      if P then
        local l = Shared.LocalPlayer
        J = (l:GetAttributeChangedSignal("RagdollEndTime"))
      else
        J = P
      end
      UO("ragAttr", J, function()
        local J = Shared.s34
        if J() then
          a()
        end
      end)
      UO("ragRemote", ((P and C) and N.ClientRagdollRemote) and N.ClientRagdollRemote.OnClientEvent, a)
    end)
    local a = {}
    local function P(C)
      local J = Shared.LocalPlayer
      if C:GetAttribute("Owner") == J.Name then
        return
      end
      local J, N = ipairs, {C, table.unpack(C:GetDescendants())}
      for C, C in J(N) do
        if C:IsA("BasePart") then
          if C.CanTouch then
            a[C] = true
            C.CanTouch = false
          end
        end
      end
    end
    local C = G("CollectionService")
    m(u, "Ignore traps", "traps", true, function(J)
      UO("trap", J and C:GetInstanceAddedSignal("PlacedTrap"), function(N)
        task.defer(pcall, P, N)
      end)
      if J then
        for J, J in ipairs(C:GetTagged("PlacedTrap")) do
          pcall(P, J)
        end
      else
        local P = a
        for C in next, P, nil do
          if C.Parent then
            C.CanTouch = true
          end
        end
        a = {}
      end
    end)
    local a, P, C, J = {}, {ClaimLostPart = true, CatchPrompt = true}, {}, false
    local function N(l)
      if not (l:IsA("ProximityPrompt")) then
        return
      end
      if l.Name == "CatchPrompt" then
        local h, R = ipairs, (getconnections and getconnections(l.PromptButtonHoldEnded)) or {}
        for _, _ in h(R) do
          if not (C[_]) then
            C[_] = true
            pcall(_.Disable, _)
          end
        end
      elseif l.HoldDuration > 0 then
        if not (P[l.Name]) then
          local P = a
          P[l] = P[l] or l.HoldDuration
          l.HoldDuration = 0
        end
      end
    end
    local function P(l)
      if l.Name ~= "CatchPrompt" then
        return
      elseif J then
        return
      end
      N(l)
      J = true
      task.spawn(function()
        local h = Shared.Invoke
        local R, _ = h("RF/ShootingStar/AskState")
        if (R and (type(_) == "table")) and _.Id then
          local R, k = os.clock(), true
          while true do
            local F, T = os.clock() - R, tonumber
            if not (F < ((T(_.HoldSeconds) or 1.6) + 0.3)) then
              break
            end
            T = Shared.s16
            h, F = T(), l.Parent
            T = (h and F) and F:IsA("BasePart")
            if if T then (h.Position - F.Position).Magnitude > (l.MaxActivationDistance + 2) else not T then
              k = false
              break
            end
            task.wait(0.1)
          end
          if k then
            t("RE/ShootingStar/Catch", _.Id)
          else
            t("RE/ShootingStar/Hold", _.Id, false)
          end
        end
        J = false
      end)
    end
    m(u, "Instant prompts", "prompts", true, function(J)
      local l = G("ProximityPromptService")
      UO("prompt", J and l.PromptShown, N)
      UO("starTap", J and l.PromptButtonHoldBegan, P)
      if not (J) then
        l = a
        for P, J in next, l, nil do
          if P.Parent then
            P.HoldDuration = J
          end
        end
        local P = C
        for J in next, P, nil do
          pcall(J.Enable, J)
        end
        a, C = {}, {}
      end
    end)
    local a, P, C = {idle = {}, hop = {}}, setmetatable, {__index = function()
      return function()
      end
    end}
    local J = P({}, C)
    local function P()
      a.act = {}
      local C, N = pcall(getgc, false)
      for l, h in ipairs((C and N) or {}) do
        if (l % 400) == 0 then
          task.wait()
        end
        if (type(h) == "function") and islclosure(h) then
          local C, N = pcall(debug.info, h, "s")
          if (C and (type(N) == "string")) and N:find("AntiAFK", 1, true) then
            local C, C = pcall(debug.info, h, "n")
            if (C == "markActive") or (C == "reportActiveFromInput") then
              a.act[#a.act + 1] = h
            end
            C, l = pcall(debug.getupvalues, h)
            for N, R in next, (C and l) or {}, nil do
              if typeof(R) == "Instance" then
                if R.ClassName == "TeleportService" then
                  if pcall(debug.setupvalue, h, N, J) then
                    a.hop[#a.hop + 1] = {h, N, R}
                  end
                end
              end
            end
          end
        end
      end
    end
    local function C(J)
      if J then
        local J, N, l = ipairs, getconnections
        if N then
          local h
          h, l = Shared.LocalPlayer, getconnections(Shared.LocalPlayer.Idled)
        else
          l = N
        end
        for N, N in J(l or {}) do
          if pcall(N.Disable, N) then
            a.idle[#a.idle + 1] = N
          end
        end
        return
      end
      for J, J in ipairs(a.idle) do
        pcall(J.Enable, J)
      end
      for J, J in ipairs(a.hop) do
        pcall(debug.setupvalue, J[1], J[2], J[3])
      end
      a.idle = {}
      a.hop = {}
      a.act = nil
    end
    m(u, "Anti AFK", "afk", true, C)
    table.insert(Shared.Core.cleanup, function()
      C(false)
    end)
    local J = sO({name = "Afk", gap = 120, at = os.clock() + 20})
    J.on = function()
      local N = Shared.s21
      return N.afk
    end
    J.fn = function()
      C(true)
      local J = a.act
      if if J then (#a.act == 0) and ((a.tries or 0) < 6) else not J then
        a.tries = (a.tries or 0) + 1
        P()
      end
      for P, P in ipairs(a.act) do
        pcall(P)
      end
    end
    U(Shared.LocalPlayer.CharacterAdded, function()
      local a = Shared.s21
      if a.afk then
        task.delay(1, C, true)
      end
    end)
  end
  do
    local a, P = Shared.Core.prot
    local C = false
    m(a, "Invisible", "invis", false, function(a)
      UO("invisPin", a and M, P)
    end)
    local a = {Mutate = true, Mech = true, Bloom = true, Combat = true, Machine = true, Banjo = true}
    Shared.Core.TOOLV = a
    Shared.Core.doneVis = function(J)
      local N = Shared.s21
      if N.invis then
        if not (a[J.name]) then
          return
        end
      else
        return
      end
      if not (J.acted) then
        if (os.clock() - (J.t0 or 0)) < 5 then
          local l, h = pcall(J.want)
          if l then
            if h then
              J.at = math.max(J.at, os.clock() + 30)
            end
          end
        end
      end
      for l, l in ipairs(yO) do
        if l.mover then
          if l.want then
            if l.at <= (os.clock() + 3) then
              if l.on() then
                J, N = pcall(l.want)
                if J then
                  if N then
                    if a[l.name] then
                      return
                    end
                    break
                  end
                end
              end
            end
          end
        end
      end
      N = Shared.Core
      N.visibleUntil = 0
    end
    local function J(N)
      local l = Shared.s8
      local h = l()
      if h then
        pcall(h.UnequipTools, h)
      end
      for l, l in ipairs(N:GetChildren()) do
        if l:IsA("Tool") then
          if Q() then
            l.Parent = Q()
          end
        end
      end
      for l = 1, 3, 1 do
        N = Shared.WaitHeartbeat
        N()
      end
    end
    local function N(l)
      local h = Shared.LocalPlayer
      local R, _ = h.Character, Shared.s8
      local k = _()
      if R and k then
        if z() then
          if not (l) then
            return
          end
        end
      else
        return
      end
      h = Shared.Core
      h.invisBusy = true
      KO()
      J(R)
      _ = Shared.Invoke
      _("RF/Treadmill/AskDoff")
      pcall(function()
        k:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        k.BreakJointsOnDeath = true
        k.RequiresNeck = true
        k.Health = 0
        k:ChangeState(Enum.HumanoidStateType.Dead)
        R:BreakJoints()
      end)
      h = os.clock() + 60
      while true do
        l = Shared.LocalPlayer
        if not ((l.Character == R) and (os.clock() < h)) then
          break
        end
        t("RE/RigSync/AskRigWipe", R)
        _ = os.clock() + 8
        while true do
          local J = Shared.LocalPlayer
          if not ((J.Character == R) and (os.clock() < _)) then
            break
          end
          task.wait(0.2)
        end
      end
      h = Shared.Core
      h.invisBusy = C
    end
    Shared.Core.respawn = N
    local J = false
    local function l()
      if J then
        return
      end
      J = true
      local J = {"RE/GearSatchel/Lost", "RE/GearSatchel/Gained", "RE/RigSync/ProbeSatchel", "RE/RigSync/SeedSatchel", "RE/RigSync/CorrectionBegan", "RE/RigSync/Refresh", "RE/ToolTrigger/Trigger", "RE/BatSwing/Trigger"}
      for h, R in ipairs(J) do
        h = n:FindFirstChild(R)
        if h then
          U(h.OnClientEvent, function()
          end)
        end
      end
      J = Q()
      if J then
        U(J.ChildAdded, function()
        end)
        U(J.ChildRemoved, function()
        end)
      end
    end
    local function n(J)
      local h = Shared.Core
      h.invisBusy = true
      local R, _ = J:WaitForChild("Humanoid", 10), J:WaitForChild("HumanoidRootPart", 10)
      J:WaitForChild("Head", 10)
      if R then
        if not (_) then
          h = Shared.Core
          C = false
          h.invisBusy = false
          return
        end
      else
        local k = Shared.Core
        C = false
        k.invisBusy = false
        return
      end
      task.wait(0.05)
      pcall(R.UnequipTools, R)
      pcall(R.UnequipTools, R)
      for k = 1, 2, 1 do
        pcall(replicatesignal, R.ServerBreakJoints)
      end
      local k, F = R.HipHeight, _.CFrame
      _.Anchored = true
      R.HipHeight = 999
      for Q, Q in ipairs(J:GetDescendants()) do
        if Q:IsA("Accessory") then
          Q.Parent = nil
        elseif Q:IsA("BasePart") then
          if Q ~= _ then
            if not (Q:FindFirstAncestorOfClass("Accessory")) then
              Q.Parent = nil
            end
          end
        end
      end
      task.wait(0.12)
      R, h = Instance.new("Part"), Shared.Vec3
      R.Name, R.Size = "RightHand", h(0.2, 0.2, 0.2)
      R.Transparency = 1
      R.CanCollide = false
      R.CanTouch = false
      R.CanQuery = false
      R.Massless = true
      R.Parent = J
      local h, Q = Instance.new("Motor6D"), Shared.CFrameNew
      h.Name, h.C0 = "RightWrist", Q(1.2, 0, 0)
      h.Part0 = _
      h.Part1 = R
      h.Parent = _
      _.CanCollide = false
      task.delay(0.2, function()
        if _.Parent then
          _.CanCollide = true
        end
      end)
      for R, R in ipairs(J:GetChildren()) do
        if R:IsA("Humanoid") then
          R.AutomaticScalingEnabled = false
          R.HipHeight = k
        end
      end
      J:SetAttribute("InvisHip", k)
      if _.Position.Y > (F.Y + 5) then
        _.CFrame = F
      end
      h = Shared.Vec3Zero
      _.AssemblyLinearVelocity = h
      _.Anchored = false
      J:SetAttribute("InvisApplied", true)
      Q = Shared.Core
      Q.invisSettle = os.clock() + 3.5
      J = Shared.Core
      C = false
      J.invisBusy = false
      task.delay(1, l)
    end
    Shared.Core.visibleUntil = 0
    local function J()
      local l = Shared.s21
      local h, R = l.invis
      if h then
        l = nil
        l, R = Shared.Core, os.clock() > Shared.Core.visibleUntil
      else
        R = h
      end
      h, l = R and not (Shared.s4 and a[Shared.s4.name])
      if h then
        R = Shared.Core
        local _, k = R.hwNeedVis
        if _ then
          local F = Shared.Core
          k = F.hwNeedVis()
        else
          k = _
        end
        l = not k
      else
        l = h
      end
      h = nil
      if l then
        R = Shared.Core
        local _, k = R.hwKeep
        if _ then
          local F = Shared.Core
          k = F.hwKeep()
        else
          k = _
        end
        h = not k
      else
        h = l
      end
      l = nil
      if h then
        R = Shared.Core
        local _, k = R.inDim
        if _ then
          local R = Shared.Core
          k = R.inDim()
        else
          k = _
        end
        l = not k
      else
        l = h
      end
      return l
    end
    Shared.Core.invisWant = J
    local l, h
    local R = sO({name = "VisSettle", gap = 0.1})
    R.on = function()
      return true
    end
    R.fn = function()
      local R = Shared.LocalPlayer
      local _ = R.Character
      R = (_ ~= nil) and (_:GetAttribute("InvisApplied") == true)
      if (_ ~= l) or (R ~= h) then
        if l then
          local k, F = Shared.Core
          F, k.invisSettle = Shared.Core, math.max(Shared.Core.invisSettle or 0, os.clock() + 1)
        end
        l, h = _, R
      end
    end
    Shared.Core.needBody = function()
      local l = Shared.LocalPlayer
      local h = l.Character
      if h then
        if h:GetAttribute("InvisApplied") then
          local h, R = Shared.Core
          R, h.visibleUntil = Shared.Core, math.max(Shared.Core.visibleUntil, os.clock() + 25)
          return false
        end
      end
      l = Shared.s21
      if l.invis then
        local l, h = Shared.Core
        h, l.visibleUntil = Shared.Core, math.max(Shared.Core.visibleUntil, os.clock() + 25)
      end
      return true
    end
    U(Shared.LocalPlayer.CharacterAdded, function(l)
      if J() then
        if not (z()) then
          local h = Shared.Core
          C = true
          h.invisBusy = true
          task.defer(n, l)
        end
      end
    end)
    P = function()
      local n = Shared.LocalPlayer
      local P = n.Character
      if P then
        if not (P:GetAttribute("InvisApplied")) then
          return
        end
      else
        return
      end
      local C, l = P:FindFirstChild("RightHand"), P:FindFirstChildOfClass("Tool")
      P = l and (l:FindFirstChild("Handle"))
      if C and P then
        for h, h in ipairs(C:GetChildren()) do
          if h:IsA("JointInstance") then
            if h.Name == "RightGrip" then
              h.Enabled = false
            end
          end
        end
        P.CFrame = C.CFrame
        l = Shared.Vec3Zero
        P.AssemblyLinearVelocity = l
      end
      l = Shared.s8
      P, C = l(), Shared.s16
      n = C()
      if P then
        if n then
          if Shared.s4 then
            if P then
              P.AutoRotate = true
            end
          elseif n.Anchored then
            if P then
              P.AutoRotate = true
            end
          elseif P.MoveDirection.Magnitude > 0.1 then
            P.AutoRotate = false
            n.CFrame = CFrame.lookAt(n.Position, n.Position + P.MoveDirection)
          elseif P then
            P.AutoRotate = true
          end
        elseif P then
          P.AutoRotate = true
        end
      elseif P then
        P.AutoRotate = true
      end
    end
    local n
    Shared.Core.invisFirst = function(P)
      local C = Shared.LocalPlayer
      local l, h = C.Character
      if l then
        C = Shared.LocalPlayer
        h = C.Character:GetAttribute("InvisApplied")
      else
        h = l
      end
      if a[P.name] then
        l = Shared.s21
        C = l.invis and h
        local l, R = not C
        if C then
          local _ = Shared.s29
          R = (_())
        else
          R = l
        end
        l = (R or z()) or (Shared.s4 and not Shared.s4.soft)
        if l then
          return false
        elseif not (P.on()) then
          return false
        end
        R, l = pcall(P.want)
        if R then
          if not l then
            return false
          end
        else
          return false
        end
        l, R = Shared.Core
        R, l.visibleUntil, P.at = Shared.Core, math.max(Shared.Core.visibleUntil, os.clock() + 25), os.clock() + 0.5
        return true
      end
      P = Shared.s21
      if P.invis then
        if J() then
          C = Shared.s29
          if C() then
            n = nil
            return false
          elseif z() then
            n = nil
            return false
          elseif h then
            n = nil
            return false
          end
        else
          n = nil
          return false
        end
      else
        n = nil
        return false
      end
      n = n or os.clock()
      h = os.clock() - n
      return h < 10
    end
    local n, P = sO({name = "Invis", gap = 1}), {}
    n.on = function()
      local C = Shared.s21
      local l, h = C.invis
      if l then
        h = l
      else
        C = Shared.LocalPlayer
        local l = C.Character
        if l then
          local C = Shared.LocalPlayer
          h = C.Character:GetAttribute("InvisApplied")
        else
          h = l
        end
      end
      return h
    end
    n.fn = function()
      local n = Shared.LocalPlayer
      local C, l, h = n.Character, Shared.s4 and a[Shared.s4.name]
      if l then
        n = Shared.s21
        h = n.invis
      else
        h = l
      end
      if h then
        n, l = Shared.Core
        l, n.visibleUntil = Shared.Core, math.max(Shared.Core.visibleUntil, os.clock() + 5)
      else
        local R, R, _ = Shared.Core, os.clock() < Shared.Core.visibleUntil
        if R then
          local k = Shared.Core
          local F, Q = k.stealVis
          if F then
            Q = F
          else
            k = Shared.s21
            Q = k.aura
          end
          _ = not Q
        else
          _ = R
        end
        if _ then
          R = nil
          for _, _ in ipairs(yO) do
            if a[_.name] then
              if _.on() then
                local k, F = pcall(_.want)
                R = R or (k and F)
              else
              end
            else
            end
          end
          if not R then
            local R = Shared.Core
            if R.hwNeedVis then
              local R = Shared.Core
              if not (R.hwNeedVis()) then
                local R = Shared.Core
                R.visibleUntil = 0
              end
            else
              local R = Shared.Core
              R.visibleUntil = 0
            end
          end
        end
      end
      l, n = C and (C:GetAttribute("InvisApplied") == true), Shared.Core
      if n.hwKeep then
        C = Shared.Core
        if C.hwKeep() then
          h = Shared.Core
          if h.hwNeedVis then
            local R = Shared.Core
            if not (R.hwNeedVis()) then
              return
            end
          else
            return
          end
        end
      end
      C = Shared.Core
      if C.inDim then
        n = Shared.Core
        if n.inDim() then
          h = Shared.Core
          if h.hwNeedVis then
            local R = Shared.Core
            if not (R.hwNeedVis()) then
              return
            end
          else
            return
          end
        end
      end
      n = Shared.Core
      if n.invisBusy then
        return
      else
        C = Shared.s29
        if C() then
          return
        elseif J() == l then
          return
        elseif z() then
          return
        elseif Shared.s4 then
          if a[Shared.s4.name] then
            return
          elseif not (Shared.s4.soft) then
            h = Shared.Core
            if h.hwNeedVis then
              local a = Shared.Core
              if not (a.hwNeedVis()) then
                return
              end
            else
              return
            end
          end
        end
      end
      h = os.clock()
      while P[1] and ((h - P[1]) > 60) do
        table.remove(P, 1)
      end
      if #P >= 6 then
        return
      end
      P[#P + 1] = h
      if Shared.s4 then
        qO(Shared.s4)
      end
      N()
    end
  end
  do
    local a, n, P, C = LO.Combat:Section("Hit aura", "swords"), 0, 0, 0
    local function J(N, l)
      local h = Shared.LocalPlayer
      if N == h then
        return
      elseif N.Parent ~= c then
        return
      end
      h = N.Character
      local R, _ = h and (h:FindFirstChildOfClass("Humanoid")), h and (h:FindFirstChild("HumanoidRootPart"))
      if R then
        if _ then
          if R.Health <= 0 then
            return
          elseif h:GetAttribute("IsTrapped") then
            return
          elseif N:GetAttribute("InBossArena") then
            return
          else
            local h = Shared.s17
            if h(_.Position) then
              return
            end
          end
        else
          return
        end
      else
        return
      end
      if not (l) then
        if (tonumber(N:GetAttribute("RagdollEndTime")) or 0) > K() then
          return
        end
      end
      return _
    end
    local function N(l)
      if l then
      else
        local h = Shared.Core
        local R, R = h.bat()
        l = R
      end
      return ((17 + (l or 0)) * ((workspace:GetAttribute("DragonEggEventActive") and 2.5) or 1)) - 1
    end
    local function l(h, R)
      if workspace:GetAttribute("PvPDisabled") then
        return
      end
      local _ = Shared.Core
      local k, F = _.bat()
      _ = Shared.s16
      local Q, T = _(), N(F)
      if k then
        if Q then
          F = Shared.Core
          if not (F.needBody()) then
            return
          end
        else
          return
        end
      else
        return
      end
      _ = Shared.s8
      local e, b = _(), Shared.LocalPlayer
      if k.Parent ~= b.Character then
        if e then
          pcall(e.EquipTool, e, k)
        end
      end
      _ = Shared.LocalPlayer
      if k.Parent ~= _.Character then
        return
      end
      _ = Shared.Core
      if _.scrambler(k) then
        if (os.clock() - C) > 0.3 then
          C = os.clock()
          pcall(k.Activate, k)
        end
        return
      end
      e = Shared.s27
      _, F = e(), Q.Position - (Q.AssemblyLinearVelocity * 0.18)
      if ((R.Position + (R.AssemblyLinearVelocity * _)) - F).Magnitude > T then
        if (R.Position - F).Magnitude > T then
          return
        end
      end
      if K() < ((tonumber(k:GetAttribute("CooldownEndTime")) or 0) - (_ * 0.5)) then
        return
      end
      if (os.clock() - P) < math.max(0.12, _ * 1.5) then
        return
      end
      P = os.clock()
      n += 1
      _ = Shared.LocalPlayer
      t("RE/BatSwing/Trigger", h, ("%d:%d:%d"):format(_.UserId, n, math.floor(K() * 1000)))
      pcall(k.Activate, k)
    end
    Shared.Core.chase = function(n, t)
      local K, P = J(n, t), Shared.s16
      local C, h = P(), Shared.s8
      t = h()
      if K then
        if C then
          if not t then
            return false
          end
        else
          return false
        end
      else
        return false
      end
      t.PlatformStand = true
      t, h, P = Shared.s27, Shared.Vec3, (K.Position + (K.AssemblyLinearVelocity * (Shared.s27() + 0.2))) + Shared.Vec3(0, 1.5, 0)
      local t, h = K.AssemblyLinearVelocity + ((P - C.Position) / 0.12), Shared.s21
      if t.Magnitude > (h.chase * 1.8) then
        P = nil
        P, t = Shared.s21, (t.Unit * Shared.s21.chase) * 1.8
      else
      end
      h = nil
      h, C.CFrame = Shared.Vec3, CFrame.lookAt(C.Position, Shared.Vec3(K.Position.X, C.Position.Y, K.Position.Z))
      P = Shared.Vec3Zero
      C.AssemblyLinearVelocity = t
      C.AssemblyAngularVelocity = P
      l(n, K)
      return true
    end
    u, tO = setmetatable, {__mode = "k"}
    local n = u({}, tO)
    Shared.Core.huntStep = function(t, K, P)
      local C = Shared.s16
      local h, R = C(), Shared.s8
      C = R()
      if h then
        if not C then
          return
        end
      else
        return
      end
      C.PlatformStand = true
      C = n[t] or {}
      n[t] = C
      local n, n = Shared.Vec3, K.AssemblyLinearVelocity * Shared.Vec3(1, 0, 1)
      C.s = (C.s and C.s:Lerp(n, 0.25)) or n
      if C.s.Magnitude > 1 then
        C.hd = ((C.hd and C.hd:Lerp(C.s.Unit, 0.25)) or C.s.Unit).Unit
      end
      local _, k, k, F, Q = C.s.Magnitude, Shared.Vec3, (h.Position - K.Position) * Shared.Vec3(1, 0, 1), C.hd
      if F then
        Q = F
      else
        n = (k.Magnitude > 0.1) and k.Unit
        if n then
          Q = n
        else
          R = Shared.Vec3
          Q = (R(0, 0, 1))
        end
      end
      F = Shared.s27
      n, R, k = K.Position + (C.s * (F() + 0.105)), (_ > 1) and (C.s.Unit * 3.6)
      if R then
        k = R
      else
        F = Shared.Vec3Zero
        k = F
      end
      R, F = n + k, Shared.Vec3
      n = F(-Q.Z, 0, Q.X)
      n = if n:Dot(h.Position - R) < 0 then -n else n
      F = (os.clock() * 2) * 3.141592653589793
      local T, T, e = Shared.Vec3, ((R + (((Q * ((math.sin(F / 1.1) * 0.5) + 0.5)) * math.max(5, math.min(N() * 0.7, 6 + (_ * 0.07)))) * 0.6)) + (n * (((_ < 35) and 3) or 1.5))) + Shared.Vec3(0, math.sin(F / 0.8) * 2.5, 0), Shared.s34
      k, Q = e() and 1500
      if k then
        Q = k
      else
        n, F = nil
        n, F, Q = Shared.s21, Shared.s21, math.min(Shared.s21.chase + _, math.max(Shared.s21.chase, 1000))
      end
      R = C.s + ((T - h.Position) / math.max(0.12, P))
      R = if R.Magnitude > Q then R.Unit * Q else R
      C, Q = Shared.Vec3, (K.Position - h.Position) * Shared.Vec3(1, 0, 1)
      if Q.Magnitude > 0.05 then
        h.CFrame = CFrame.lookAt(h.Position, h.Position + Q.Unit)
      end
      F, e = Shared.Vec3
      e, h.AssemblyLinearVelocity = Shared.Vec3Zero, R + F(0, (workspace.Gravity * P) * 0.5, 0)
      h.AssemblyAngularVelocity = e
      l(t, K)
    end
    local n, t = setmetatable, {__mode = "k"}
    local K = n({}, t)
    local function n(P)
      task.spawn(function()
        local C, C, C, h = Shared.LocalPlayer, Shared.LocalPlayer, pcall(Shared.LocalPlayer.IsFriendsWith, Shared.LocalPlayer, P.UserId)
        K[P] = C and h
      end)
    end
    UO("friends", c.PlayerAdded, n)
    for P, P in ipairs(c:GetPlayers()) do
      n(P)
    end
    local function P(C)
      local h = Shared.s21
      return not (h.skipFr and K[C])
    end
    local function K(C, h)
      local R = Shared.s16
      local _, k = R(), C or math.huge
      if not (_) then
        return
      end
      R, C = nil
      for F, Q in ipairs(c:GetPlayers()) do
        F = ((if h then h[Q] else not h) and P(Q)) and J(Q)
        if F then
          if (F.Position - _.Position).Magnitude < k then
            local P = (F.Position - _.Position).Magnitude
            k, R, C = P, Q, F
          else
          end
        else
        end
      end
      return R, C
    end
    local P = 0
    m(a, "Hit aura", "aura", false, function(C)
      UO("aura", C and M, function()
        if (os.clock() - P) < 0.05 then
          return
        elseif Shared.s4 then
          if Shared.s4.name == "Steal" then
            return
          elseif Shared.s4.name == "Bloom" then
            return
          end
        end
        P = os.clock()
        local M, P = K(N() + 6)
        if M then
          l(M, P)
        end
      end)
    end)
    m(a, "Skip friends", "skipFr", true)
    pO, n, t = LO.Combat:Section("Weapons", "swords", 2), Shared.Core.ownedWeapons, function(M)
      local P = Shared.s21
      P.weap = nil
      P = ipairs
      for C, J in P(M) do
        local M, P = Shared.s21, Shared.s21
        M.weap = P.weap or {}
        M, C = Shared.s21
        C, M.weap[Shared.Core.weaponId[J] or J] = Shared.Core, true
      end
    end
    pO:Dropdown("Use weapons", n, {}, t, true)
    S(pO, "Hold each", "swapT", 0.2, 0.75, 0.35, function(n)
      return ("%.2fs"):format(n)
    end, 0.05)
    local n = sO({name = "Combat", mover = true, gap = 0.5, pri = 7, soft = true})
    a = LO.Combat:Section("Auto hit", "target")
    m(a, "Auto hit", "combat", false, function(M)
      if not (M) then
        qO(n)
      end
    end)
    x(a, "Hit who", "hitWho", {"Nearest player", "Egg holders", "Chosen player"}, "Nearest player")
    local M
    local t = a:Dropdown("Chosen player", function()
      local P, C, J = {}, ipairs, f[53](c:GetPlayers())
      for N, l in C(f:uT(J)) do
        N = Shared.LocalPlayer
        if l ~= N then
          P[#P + 1] = l.DisplayName
        end
      end
      return P
    end, nil, function(P)
      M = P
    end)
    t.Skip = true
    U(c.PlayerRemoving, function(P)
      if P.DisplayName == M then
        M = nil
        A("chosen", function()
          t:Set(nil)
        end)
      end
    end)
    S(a, "Chase speed", "chase", 100, 1000, 400, "", 10)
    local function a()
      local t, P, C = {}, pairs, Shared.s19
      local J = f[53](C())
      for N, l in P(f:uT(J)) do
        N, C = ((type(l) == "table") and (l.State == "Carried")) and tonumber(l.CarrierUserId)
        if N then
          l = Shared.LocalPlayer
          C = N ~= l.UserId
        else
          C = N
        end
        l = C and (c:GetPlayerByUserId(N))
        if l then
          t[l] = true
        end
      end
      return t
    end
    local function t()
      local P = Shared.s21
      if P.hitWho == "Egg holders" then
        return K(nil, a())
      end
      P = Shared.s21
      if P.hitWho == "Chosen player" then
        local a, P = ipairs, f[53](c:GetPlayers())
        local C
        for J, N in a(f:uT(P)) do
          J = Shared.LocalPlayer
          C = if N ~= J then if N.DisplayName == M then N else C else C
        end
        return K(nil, {[C or 0] = (C and true) or nil})
      end
      return K()
    end
    n.on = function()
      local a = Shared.s21
      return a.combat
    end
    n.want = function()
      return t()
    end
    n.run = function(a, n)
      local M = Shared.Core
      if M.needBody() then
        if Shared.s14(n) then
          local K = Shared.s15
          if not (K(n)) then
            return
          end
        else
          return
        end
      else
        return
      end
      M = os.clock()
      while n() do
        if (os.clock() - M) > 0.3 then
          M, a = os.clock(), t()
          if not (a) then
            break
          end
        else
        end
        local t = Shared.Core
        if not (t.chase(a)) then
          break
        end
        t = Shared.WaitHeartbeat
        t()
      end
      M = Shared.s8
      n = M()
      if n then
        n.PlatformStand = false
      end
    end
  end
  do
    u = LO.Server:Section("Server", "server")
    local a = u:Text("--")
    x(u, "Hop to", "hopMode", {"Least players", "Most players", "Random"}, "Least players")
    u:Button("Hop server", "Hop", function()
      task.spawn(Shared.Core.hop)
    end, "gold")
    u:Button("Rejoin this server", "Rejoin", function()
      local n, n, n = Shared.Game, Shared.Game, Shared.LocalPlayer
      pcall(i.TeleportToPlaceInstance, i, Shared.Game.PlaceId, Shared.Game.JobId, Shared.LocalPlayer)
    end)
    u:Button("Copy Job ID", "Copy", function()
      pcall(setclipboard, Shared.Game.JobId)
      local n = Shared.Game
      W("Job ID copied", n.JobId, "ok")
    end)
    tO = LO.Server:Section("Join and stay", "refresh")
    local n = tO:Input("Job ID", "Paste a Job ID")
    n.Skip = true
    tO:Button("Join that server", "Join", function()
      local M = tostring(n.Value):match("%x+%-%x+%-%x+%-%x+%-%x+")
      if M then
        local n, n = Shared.Game, Shared.LocalPlayer
        pcall(i.TeleportToPlaceInstance, i, Shared.Game.PlaceId, M, Shared.LocalPlayer)
      end
    end)
    local n, M = false, 0
    U(Shared.LocalPlayer.OnTeleport, function()
      M = os.clock()
    end)
    m(tO, "Rejoin on kick", "rejoin", true, function(t)
      UO("kick", t and G("GuiService").ErrorMessageChanged, function(t)
        local K = tostring(t):lower()
        if n then
          return
        else
          local t = Shared.Core
          if t.hopping then
            return
          elseif K == "" then
            return
          elseif K:find("teleport") then
            return
          elseif K:find("full") then
            return
          elseif K:find("ban") then
            return
          elseif K:find("same account") then
            return
          elseif K:find("duplicate") then
            return
          elseif (os.clock() - M) < 60 then
            return
          end
        end
        n = true
        task.spawn(function()
          local n = (K:find("shut") or K:find("no longer")) or K:find("closed")
          for M = 1, 1000, 1 do
            if n or (M > 2) then
              local M, M = Shared.Game, Shared.LocalPlayer
              pcall(i.Teleport, i, Shared.Game.PlaceId, Shared.LocalPlayer)
            else
              local M, M, M = Shared.Game, Shared.Game, Shared.LocalPlayer
              pcall(i.TeleportToPlaceInstance, i, Shared.Game.PlaceId, Shared.Game.JobId, Shared.LocalPlayer)
            end
            task.wait((n and 5) or 4)
          end
        end)
      end)
    end)
    local n = ((queue_on_teleport or queueonteleport) or (syn and syn.queue_on_teleport)) or (fluxus and fluxus.queue_on_teleport)
    local function M(t)
      pcall(function()
        i:SetTeleportSetting("__VenyxAutoLoad", t == true)
      end)
      if t and n then
        if rawget(H, "__VenyxAutoQueued") ~= true then
          if pcall(n, "local ok, on = pcall(function() return game:GetService(\"TeleportService\"):GetTeleportSetting(\"__VenyxAutoLoad\") end)\nif ok and on == true then\n  if not game:IsLoaded() then game.Loaded:Wait() end\n  loadstring(game:HttpGet(\"https://raw.githubusercontent.com/tienkhanh1/Venyx/refs/heads/main/VenyxHub\"))()\nend") then
            H.__VenyxAutoQueued = true
          end
        end
      end
    end
    m(tO, "Auto load script", "autoExec", true, function(i)
      M(i)
      if i then
        if not (n) then
          W("Auto load", "This executor cannot queue a script for the next server", "warn")
        end
      end
    end)
    Shared.Core.beforeTeleport = function()
      local i = Shared.s21
      M(i.autoExec)
    end
    U(Shared.LocalPlayer.OnTeleport, function(i)
      if i == Enum.TeleportState.Started then
        local i = Shared.Core
        i.beforeTeleport()
      end
    end)
    local i = Shared.Core.tick
    Shared.Core.tick = function()
      a:Set(("%d / %d players  -  %s"):format(#c:GetPlayers(), c.MaxPlayers, Shared.Game.JobId:sub(1, 13)))
      if i then
        i()
      end
    end
  end
  do
    tO = LO.Webhook:Section("Discord webhook", "discord")
    local c = tO:Input("Webhook URL", "https://discord.com/api/webhooks/...")
    local a = m(tO, "Ping everyone", "whPing", false)
    local function i(n)
      return tostring(n or ""):match("%d%d%d%d%d+")
    end
    local function n(M)
      if i(M) then
        local M = Shared.s21
        if M.whPing then
          a:Set(false)
        end
      end
    end
    local a = tO:Input("Ping user ID", "Discord user ID", n)
    local M = tO:Input("Ping role ID", "Discord role ID", n)
    local t = tO:Stats({{"Posted", V.check}, {"Waiting", V.timer}})
    local function K()
      return (tostring(c.Value):match("^%s*(.-)%s*$"))
    end
    local c = 0
    pO = LO.Webhook:Section("What to post", "star")
    m(pO, "Post stolen eggs", "whSteal", false)
    m(pO, "Post fused eggs", "whFuse", false)
    m(pO, "Post when bag is full", "whFull", false)
    local P = fO(pO, {rar = Y, minV = "Min value /s"})
    tO:Button("Send a test post", "Test", function()
      local C = Shared.Core
      C.whTest = true
    end)
    local C = sO({name = "WebhookTest", gap = 0.3})
    C.on = function()
      local J = Shared.Core
      return J.whTest
    end
    C.fn = function()
      local C = Shared.Core
      C.whTest = nil
      local C, J = Shared.Core
      for N, N in ipairs(C.allEggs()) do
        J = if J then if N.v > J.v then N else J else N
      end
      C = Shared.Core
      if C.post("Egg Stolen! (test)", J or {cat = "Test", n = "Venyx test", r = 7, v = 1000000000, s = 1, m = {}}, (J and J.a) or "Test") == false then
        return W("Webhook", ((K() == "") and "Paste your Discord webhook link first") or "Check the webhook link", "warn")
      end
      W("Webhook", "Test post sent, check your Discord channel", "ok")
    end
    local C, J, N, l, h, R = ((request or http_request) or (syn and syn.request)) or (http and http.request), {}, false, {}, {}
    local _ = {}
    for V = 0, 255, 1 do
      n = V
      for k = 1, 8, 1 do
        n = ((bit32.band(n, 1) == 1) and bit32.bxor(3988292384, bit32.rshift(n, 1))) or bit32.rshift(n, 1)
      end
      _[V] = n
    end
    local function n(V, k, F)
      local Q = 4294967295
      for T = k, F, 1 do
        Q = bit32.bxor(_[bit32.band(bit32.bxor(Q, buffer.readu8(V, T)), 255)], bit32.rshift(Q, 8))
      end
      return bit32.bxor(Q, 4294967295)
    end
    local function _(V, k, F)
      local Q = (k * 4) + 1
      local T = Q * F
      local e = ((2 + (math.ceil(T / 65535) * 5)) + T) + 4
      local b, w = buffer.create((45 + e) + 12), 0
      local function X(o)
        buffer.writeu8(b, w, o)
        w += 1
      end
      local function o(fO)
        for GO = 24, 0, -8 do
          X(bit32.band(bit32.rshift(fO, GO), 255))
        end
      end
      local fO = {137, 80, 78, 71, 13, 10, 26, 10}
      for GO, GO in ipairs(fO) do
        X(GO)
      end
      o(13)
      fO = w
      o(1229472850)
      o(k)
      o(F)
      local GO = {8, 6, 0, 0, 0}
      for aO, aO in ipairs(GO) do
        X(aO)
      end
      o(n(b, fO, w - 1))
      GO = buffer.create(T)
      for aO = 0, F - 1, 1 do
        buffer.copy(GO, (aO * Q) + 1, V, (aO * k) * 4, k * 4)
      end
      o(e)
      fO = w
      o(1229209940)
      X(120)
      X(1)
      e = 0
      while e < T do
        F = math.min(65535, T - e)
        X((((e + F) >= T) and 1) or 0)
        X(bit32.band(F, 255))
        X(bit32.rshift(F, 8))
        k = bit32.band(bit32.bnot(F), 65535)
        X(bit32.band(k, 255))
        X(bit32.rshift(k, 8))
        buffer.copy(b, w, GO, e, F)
        w += F
        e = e + F
      end
      e, k = 1, 0
      for V = 0, T - 1, 1 do
        e = (e + buffer.readu8(GO, V)) % 65521
        k = (k + e) % 65521
      end
      o((k * 65536) + e)
      o(n(b, fO, w - 1))
      o(0)
      fO = w
      o(1229278788)
      o(n(b, fO, w - 1))
      return buffer.tostring(b)
    end
    local function n(V)
      if l[V] == nil then
        local k, F = pcall(function()
          local Q = G("AssetService"):CreateEditableImageAsync(Content.fromUri("rbxassetid://" .. V))
          local T = Q.Size
          local e, b, w = math.floor(T.X), math.floor(T.Y), Q:ReadPixelsBuffer(Vector2.zero, T)
          pcall(Q.Destroy, Q)
          Q = math.min(1, 200 / math.max(e, b))
          local X, o = math.max(1, math.floor(e * Q)), math.max(1, math.floor(b * Q))
          T = buffer.create((X * o) * 4)
          for fO = 0, o - 1, 1 do
            local GO = math.min(b - 1, math.floor(fO / Q))
            for b = 0, X - 1, 1 do
              buffer.copy(T, ((fO * X) + b) * 4, w, ((GO * e) + math.min(e - 1, math.floor(b / Q))) * 4, 4)
            end
          end
          return _(T, X, o)
        end)
        l[V] = ((k and (type(F) == "string")) and F) or false
      end
      return l[V] or nil
    end
    local function l(_, V)
      local k, k, k, F = Shared.Game, Shared.Game, pcall(Shared.Game.HttpGet, Shared.Game, _)
      local Q, Q, Q, T = Shared.HttpService, Shared.HttpService, pcall(Shared.HttpService.JSONDecode, Shared.HttpService, (k and F) or "")
      k = ((Q and (type(T) == "table")) and (type(T.data) == "table")) and T.data[1]
      _ = ((type(k) == "table") and (k.state == "Completed")) and k.imageUrl
      return (((type(_) == "string") and (if V then _:find("/Image/", 1, true) else not V)) and _) or nil
    end
    local function _(V)
      if h[V] == nil then
        h[V] = l("https://thumbnails.roblox.com/v1/assets?assetIds=" .. (V .. "&returnPolicy=PlaceHolder&size=420x420&format=Png&isCircular=false"), true) or false
      end
      return h[V] or nil
    end
    local function h()
      if R == nil then
        local V = Shared.LocalPlayer
        R = l("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. (V.UserId .. "&size=150x150&format=Png&isCircular=false")) or false
      end
      local l = R or nil
      return l
    end
    local function l()
      if N then
        return
      end
      N = true
      while #J > 0 do
        local R, V = table.remove(J, 1), {Url = K(), Method = "POST"}
        if R.png then
          local k = Shared.HttpService
          local F = "Venyx" .. k:GenerateGUID(false):gsub("-", "")
          V.Headers = {["Content-Type"] = "multipart/form-data; boundary=" .. F}
          local k, Q, T = table.concat, {}, Shared.HttpService
          f:yT(Q, 0, "--", F, "\013\nContent-Disposition: form-data; name=\"payload_json\"\013\nContent-Type: application/json\013\n\013\n", Shared.HttpService:JSONEncode(R.p), "\013\n--", F, "\013\nContent-Disposition: form-data; name=\"files[0]\"; filename=\"egg.png\"\013\nContent-Type: image/png\013\n\013\n", R.png, "\013\n--", F, "--\013\n")
          V.Body = k(Q)
        else
          V.Headers = {["Content-Type"] = "application/json"}
          local k = Shared.HttpService
          V.Body = k:JSONEncode(R.p)
        end
        local k, F = pcall(C, V)
        V = (k and (type(F) == "table")) and tonumber(F.StatusCode)
        if (V == 429) and ((R.n or 0) < 3) then
          R.n = (R.n or 0) + 1
          table.insert(J, 1, R)
          task.wait(3)
        elseif V ~= 200 then
          if V ~= 204 then
            if R.png then
              R.png, R.p.attachments = nil, nil
              R.p.embeds[1].thumbnail = (R.alt and {url = R.alt}) or nil
              table.insert(J, 1, R)
            else
              c += 1
            end
          else
            c += 1
          end
        else
          c += 1
        end
        task.wait(1.2)
        E("wst", t, {Posted = tostring(c), Waiting = tostring(#J)})
      end
      N = false
    end
    local c = "  " .. (utf8.char(183) .. "  ")
    local function t(N)
      local R = ((N >= 1000) and ("%.0f"):format(N)) or ("%.2f"):format(N)
      local N, V = R:match("^(%d+)(.*)$")
      return N:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. (V .. " kg")
    end
    local function N(R)
      local V = Shared.Modules
      local k, F = V.Areas
      if k then
        V = Shared.Modules
        F = V.Areas.Directory
      else
        F = k
      end
      k = ((type(F) == "table") and R) and F[R]
      return (((type(k) == "table") and tostring(k.DisplayName or R)) or (R and tostring(R))) or "Field"
    end
    local function R()
      return C and K():match("^https://[%w%.]*discord[%w]*%.com/api/webhooks/%d+/[%w%-_]+/?%??[%w=&_%-]*$")
    end
    local function K(C, V)
      local k, F = {}, Shared.LocalPlayer
      k.name = F.DisplayName
      k.icon_url = h()
      C.author = k
      k, F = DateTime.now():ToIsoDate(), {}
      F.text, F.icon_url, C.timestamp = "Venyx" .. (c .. "Steal An Egg"), "https://media.discordapp.net/attachments/1181785068637790221/1560058241839398993/Venyx_Vx_icon_vector_3.png?ex=6ad154f5&is=6ad00375&hm=102a2e09b0f71280eb8cf126aeda932ed9aafcdf743248ef779ce62247b110c2&=&format=webp&quality=lossless", k
      C.footer = F
      local h, Q, T = {username = "Venyx", avatar_url = "https://media.discordapp.net/attachments/1181785068637790221/1560058241839398993/Venyx_Vx_icon_vector_3.png?ex=6ad154f5&is=6ad00375&hm=102a2e09b0f71280eb8cf126aeda932ed9aafcdf743248ef779ce62247b110c2&=&format=webp&quality=lossless", embeds = {C}}, V and (n(V)), V and (_(V))
      if Q then
        C.thumbnail = {url = "attachment://egg.png"}
        h.attachments = {{id = 0, filename = "egg.png"}}
      elseif T then
        C.thumbnail = {url = T}
      end
      F, k = i(a.Value), i(M.Value)
      if F or k then
        h.content, h.allowed_mentions = ((F and ("<@" .. (F .. "> "))) or "") .. ((k and ("<@&" .. (k .. ">"))) or ""), {users = {F}, roles = {k}}
      else
        C = Shared.s21
        if C.whPing then
          h.content, h.allowed_mentions = "@everyone", {parse = {"everyone"}}
        end
      end
      if #J >= 20 then
        table.remove(J, 1)
      end
      J[#J + 1] = {p = h, png = Q, alt = T}
      task.spawn(l)
    end
    Shared.Core.post = function(a, i, n, M)
      if not (R()) then
        return false
      end
      task.spawn(function()
        local C = g(i.cat)
        local J, l = (C and C.Rarity) and C.Rarity.Color, {}
        for g, g in ipairs(i.m) do
          l[#l + 1] = j[g] or g
        end
        local j, g, g = ("x%.2f"):format(i.s), Shared.Fire, tonumber(Shared.Fire("Rec", "WeightKgForScale", i.cat, i.s))
        j = if g then j .. (c .. t(g)) else j
        local t, h, _, V, k, F = C and (((M and C.Egg) and C.Egg.Icon) or C.Icon), {title = a, color = ((typeof(J) == "Color3") and (((math.floor((J.R * 255) + 0.5) * 65536) + (math.floor((J.G * 255) + 0.5) * 256)) + math.floor((J.B * 255) + 0.5))) or 9134335}, table.concat, {}, i.n, Y[i.r]
        C, J = ("**%s**%s%s"):format(k, c, F or "?"), f[53](O(i.v))
        F, k, g = ("<:sae_value:1551645680718581871> **Value:** $%s/s"):format(f:uT(J)), ("<:sae_size:1551645444285800558> **Size:** %s"):format(j), (#l > 0) and table.concat(l, ", ")
        J, l = ("<:sae_mutation:1551677914146275478> **Mutation:** %s"):format(g or "None"), f[53](N(n))
        f:yT(V, 0, C, F, k, J, ("<:sae_area:1551675973328441416> **Area:** %s"):format(f:uT(l)))
        h.description = _(V, "\n")
        K(h, tonumber(tostring(t or ""):match("%d+")))
      end)
    end
    local c, a
    task.spawn(function()
      local i = Shared.Modules
      local n = i.Egg
      if n then
        if n.CarryChanged then
          U(n.CarryChanged, function(i)
            if (type(i) == "table") and i.IsCarrying then
              local n = Shared.s21
              local M = n.whSteal and (if c then c.endAt else not c)
              if M then
                a = {}
                local n, M = pairs, f[53](D())
                for U in n(f:uT(M)) do
                  a[U] = true
                end
              end
              c = {cat = tostring(i.AssetCategory), uid = tostring(i.Uid), area = i.AreaId}
            elseif c then
              local i = c
              i.endAt = i.endAt or os.clock()
            end
          end)
        end
      end
    end)
    local i = false
    local n = sO({name = "WebhookFull", gap = 2})
    n.on = function()
      local M = Shared.s21
      return M.whFull
    end
    n.fn = function()
      local n = Shared.s59
      local M, U = n(), 0
      for t in next, ((M and (type(M.EggInventory) == "table")) and M.EggInventory) or {}, nil do
        U += 1
      end
      n = Shared.Core
      M = U >= (n.bagMax or 115)
      if M then
        if not (i) then
          if R() then
            local n, t = {title = "Egg Bag Full!", color = 16732245}, Shared.Core
            n.description = ("**Eggs:** %d / %d\nPlace, hatch or sell to make room."):format(U, t.bagMax or 115)
            K(n)
          end
        end
      end
      i = M
    end
    local i = {}
    for n in pairs((D())) do
      i[n] = true
    end
    local n = sO({name = "WebhookSteal", gap = 1.5})
    n.on = function()
      local M = Shared.s21
      local U = ((M.whSteal and a) and c) and not (c.endAt and ((os.clock() - c.endAt) > 20))
      return U
    end
    n.fn = function()
      local n, M, U, t = c, {}, pairs, f[53](D())
      for K, C in U(f:uT(t)) do
        if not (a[K]) then
          if type(C) == "table" then
            a[K] = true
            M[#M + 1] = {K, C}
          end
        end
      end
      if #M == 0 then
        return
      end
      t = Shared.s59
      U = t()
      local a, K = (U and (type(U.FusionEggReward) == "table")) and U.FusionEggReward.Uid, ipairs
      for C, J in K(M) do
        U = (J[1] ~= a) and ((J[1] == n.uid) or (tostring(J[2].AssetCategory) == n.cat))
        if U then
          c = nil
          t, C = r(J[2]), Shared.s63
          if C(P, t) then
            local c = Shared.Core
            c.post("Egg Stolen!", t, n.area or J[2].AreaId)
          end
          return
        end
      end
    end
    local c = sO({name = "Webhook", gap = 2})
    c.on = function()
      local a = Shared.s21
      return a.whFuse
    end
    c.fn = function()
      local c = Shared.s59
      local a = c()
      local n, M = (a and (type(a.FusionEggReward) == "table")) and a.FusionEggReward
      if n then
        M = n
      else
        a = Shared.Core
        M = a.fuseRw
      end
      n = Shared.Core
      n.fuseRw = nil
      n = M and M.Uid
      if n then
        if i[n] then
          return
        end
      else
        return
      end
      i[n] = true
      a = D()[n] or M.Egg
      if type(a) == "table" then
        M, n = r(a), Shared.s63
        if n(P, M) then
          c = Shared.Core
          c.post("Egg Fused!", M, "Fuse machine", true)
        end
      end
    end
  end
  do
    pO, tO, u = LO.Optimizer:Section("Graphics", "eye", 1), LO.Optimizer:Section("Frame rate", "gauge", 2), LO.Optimizer:Section("Bases", "farm", 2)
    S(tO, "FPS cap", "fpsCap", 30, 360, 240, "", 10, function(c)
      pcall(setfpscap, (Shared.s21.no3d and math.min(c, 40)) or c)
    end)
    local c, a = setmetatable, {__mode = "k"}
    local i = c({}, a)
    local function c(a, n, M)
      local U, t = pcall(function()
        return a[n]
      end)
      if not (U) then
        return
      end
      U = i[a] or {}
      i[a] = U
      if U[n] == nil then
        U[n] = t
      end
      pcall(function()
        a[n] = M
      end)
    end
    local a = {"ParticleEmitter", "Trail", "Beam", "Fire", "Smoke", "Sparkles", "Light", "PostEffect"}
    local function n(M)
      for U, U in ipairs(a) do
        if M:IsA(U) then
          if U == "ParticleEmitter" then
            c(M, "Rate", 0)
          elseif U == "Light" then
            c(M, "Brightness", 0)
          end
          return c(M, "Enabled", false)
        end
      end
      if (M:IsA("Decal") or M:IsA("Texture")) and (M.Name ~= "face") then
        c(M, "Transparency", 1)
      elseif M:IsA("SurfaceAppearance") then
        c(M, "Parent", nil)
      elseif M:IsA("BillboardGui") then
        c(M, "Enabled", false)
      elseif M:IsA("SurfaceGui") then
        c(M, "Enabled", false)
      else
        local a = M:IsA("Accessory")
        local U
        if a then
          local t = Shared.LocalPlayer
          local K, P = t.Character
          if K then
            t = Shared.LocalPlayer
            P = M:IsDescendantOf(t.Character)
          else
            P = K
          end
          U = not P
        else
          U = a
        end
        if U then
          a = M:FindFirstChildWhichIsA("BasePart")
          if a then
            c(a, "Transparency", 1)
          end
        elseif M:IsA("SpecialMesh") then
          c(M, "TextureId", "")
        elseif M:IsA("Explosion") then
          c(M, "Visible", false)
        else
          local a = M:IsA("BasePart")
          local U
          if a then
            local t = Shared.LocalPlayer
            local K, P = t.Character
            if K then
              t = Shared.LocalPlayer
              P = M:IsDescendantOf(t.Character)
            else
              P = K
            end
            U = not P
          else
            U = a
          end
          if U then
            if M:IsA("MeshPart") then
              c(M, "TextureID", "")
              c(M, "RenderFidelity", Enum.RenderFidelity.Performance)
            end
            c(M, "CastShadow", false)
            c(M, "Reflectance", 0)
            c(M, "Material", Enum.Material.SmoothPlastic)
          elseif M:IsA("Atmosphere") then
            c(M, "Density", 0)
            c(M, "Haze", 0)
            c(M, "Glare", 0)
          elseif M:IsA("Clouds") then
            c(M, "Cover", 0)
          end
        end
      end
    end
    local a = G("Lighting")
    local M = workspace.Terrain
    local function U(t)
      local K, P = os.clock, ipairs
      local C = K()
      for J, N in P(t) do
        K = Shared.s21
        if not (K.opt) then
          return
        end
        pcall(n, N)
        if (os.clock() - C) > 0.003 then
          J = Shared.WaitHeartbeat
          J()
          C = os.clock()
        else
        end
      end
    end
    local t = {}
    m(pO, "Low graphics", "opt", false, function(K)
      UO("opt", K and workspace.DescendantAdded, function(P)
        t[#t + 1] = P
      end)
      local P
      if K then
        local C = Shared.RunService
        P = C.Heartbeat
      else
        P = K
      end
      UO("optDrain", P, function()
        local C = os.clock()
        while (#t > 0) and ((os.clock() - C) < 0.003) do
          pcall(n, table.remove(t))
        end
      end)
      table.clear(t)
      if K then
        P = settings().Rendering
        c(P, "QualityLevel", Enum.QualityLevel.Level01)
        c(P, "MeshPartDetailLevel", Enum.MeshPartDetailLevel.Level01)
        pcall(function()
          c(UserSettings():GetService("UserGameSettings"), "SavedQualityLevel", Enum.SavedQualitySetting.QualityLevel1)
        end)
        c(a, "GlobalShadows", false)
        c(a, "ShadowSoftness", 0)
        c(a, "FogEnd", 9000000000)
        c(a, "EnvironmentDiffuseScale", 0)
        c(a, "EnvironmentSpecularScale", 0)
        c(M, "Decoration", false)
        c(M, "WaterWaveSize", 0)
        c(M, "WaterWaveSpeed", 0)
        c(M, "WaterReflectance", 0)
        c(M, "WaterTransparency", 1)
        task.spawn(function()
          U(a:GetDescendants())
          U(workspace:GetDescendants())
        end)
      else
        task.spawn(function()
          local c, a = next, 0
          for n, M in c, i, nil do
            for c, U in next, M, nil do
              pcall(function()
                n[c] = U
              end)
            end
            i[n] = nil
            a += 1
            if (a % 300) == 0 then
              M = Shared.WaitHeartbeat
              M()
            end
          end
        end)
      end
    end)
    local c, a, i = I("Folder", {Name = "VenyxHidden"}), setmetatable, {__mode = "k"}
    local n, M = a({}, i), {ClientRenderedAssets = true, PlacedEggRenders = true}
    Shared.Core.hidden = c
    local function a(i)
      local U = Shared.LocalPlayer
      return tonumber(i:GetAttribute("OwnerUserId") or i.Name:match("^(%d+)_")) == U.UserId
    end
    local function i(U)
      local t = a(U)
      U = nil
      if t then
        local a = Shared.s21
        U = a.hideMine
      else
        U = t
      end
      local a
      if U then
        a = U
      else
        local U = not t
        if t then
          a = U
        else
          local U = Shared.s21
          a = U.hideOthers
        end
      end
      return a
    end
    local function a(U)
      if U.Parent ~= c then
        if i(U) then
          n[U] = U.Parent
          U.Parent = c
        end
      end
    end
    local function U()
      for t, K in next, n, nil do
        if not (i(t)) then
          n[t] = nil
          if K.Parent then
            if t.Parent == c then
              t.Parent = K
            end
          end
        end
      end
      local c = Shared.s21
      local i, n = c.hideMine
      if i then
        n = i
      else
        c = Shared.s21
        n = c.hideOthers
      end
      for i in next, M, nil do
        c = workspace:FindFirstChild(i)
        for t, t in ipairs((c and c:GetChildren()) or {}) do
          a(t)
        end
        UO("hide" .. i, (c and n) and c.ChildAdded, function(c)
          task.defer(a, c)
        end)
      end
      UO("hideW", n and workspace.ChildAdded, function(c)
        if M[c.Name] then
          task.defer(U)
        end
      end)
    end
    m(u, "Hide other players' pets and eggs", "hideOthers", false, U)
    m(u, "Hide my pets and eggs", "hideMine", false, U)
    table.insert(Shared.Core.cleanup, function()
      local c, a = Shared.s21, Shared.s21
      c.hideMine = false
      a.hideOthers = false
      U()
    end)
    local c = I("ScreenGui", {Name = "VenyxBlack", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = -1000, Enabled = false, Parent = Shared.LocalPlayer:FindFirstChildOfClass("PlayerGui")})
    local a = I("Frame", {Parent = c, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0})
    table.insert(Shared.Core.cleanup, function()
      c:Destroy()
    end)
    local i = sO({name = "Render", gap = 180, at = math.huge})
    local n
    m(pO, "Disable 3D Render", "no3d", false, function(M)
      local U, U = Shared.RunService, Shared.RunService
      pcall(Shared.RunService.Set3dRenderingEnabled, Shared.RunService, not M)
      local U, t, K = pcall, setfpscap
      if M then
        local P
        P, K = Shared.s21, math.min(Shared.s21.fpsCap, 40)
      else
        K = M
      end
      local P
      if K then
        P = K
      else
        local K = Shared.s21
        P = K.fpsCap
      end
      U(t, P)
      pcall(function()
        local U = settings().Rendering
        if M then
          n = n or U.QualityLevel
          U.QualityLevel = Enum.QualityLevel.Level01
        elseif n then
          local t = Shared.s21
          if not (t.opt) then
            U.QualityLevel = n
            n = nil
          end
        end
      end)
      c.Enabled = M
      i.at = (M and (os.clock() + 180)) or math.huge
    end)
    x(pO, "Background color", "no3dColor", {"Black", "White"}, "Black", function(n)
      a.BackgroundColor3 = ((n == "White") and Color3.new(1, 1, 1)) or Color3.new(0, 0, 0)
    end)
    i.on = function()
      local a = Shared.s21
      return a.no3d
    end
    i.fn = function()
      local a, a = Shared.RunService, Shared.RunService
      pcall(Shared.RunService.Set3dRenderingEnabled, Shared.RunService, true)
      task.wait(2)
      local a = Shared.s21
      if a.no3d then
        local a, a = Shared.RunService, Shared.RunService
        pcall(Shared.RunService.Set3dRenderingEnabled, Shared.RunService, false)
      end
    end
    local a, i, n = G("StarterGui"), setmetatable, {__mode = "k"}
    local M, U, t = i({}, n), setmetatable, {__mode = "k"}
    local i, n, K = U({}, t), {}, {}
    local function U(t)
      i[t] = (i[t] or 0) + 1
      t.Enabled = false
    end
    local function t(P)
      if P:IsA("LayerCollector") then
        if P == c then
          return
        elseif M[P] ~= nil then
          return
        end
      else
        return
      end
      M[P] = P.Enabled
      n[#n + 1] = P:GetPropertyChangedSignal("Enabled"):Connect(function()
        local c = Shared.s21
        if not (c.hideUI) then
          return
        end
        if P.Enabled then
          M[P] = true
          U(P)
        else
          c = i[P]
          if c then
            if c > 0 then
              i[P] = i[P] - 1
            else
              M[P] = false
            end
          else
            M[P] = false
          end
        end
      end)
      if P.Enabled then
        U(P)
      end
    end
    m(pO, "Hide game UI", "hideUI", false, function(c)
      local U = Shared.LocalPlayer
      local P = U:FindFirstChildOfClass("PlayerGui")
      UO("hideUI", (c and P) and P.ChildAdded, t)
      if c then
        for c, c in ipairs((P and P:GetChildren()) or {}) do
          t(c)
        end
        local c, t = ipairs, f[53](Enum.CoreGuiType:GetEnumItems())
        for P, P in c(f:uT(t)) do
          if P ~= Enum.CoreGuiType.All then
            if a:GetCoreGuiEnabled(P) then
              U = K
              U[#U + 1] = P
              pcall(a.SetCoreGuiEnabled, a, P, false)
            end
          end
        end
      else
        for c, c in ipairs(n) do
          c:Disconnect()
        end
        for c, U in next, M, nil do
          if c.Parent then
            if U then
              c.Enabled = true
            end
          end
        end
        local c = K
        for U, U in ipairs(c) do
          pcall(a.SetCoreGuiEnabled, a, U, true)
        end
        table.clear(M)
        table.clear(i)
        table.clear(n)
        K = {}
      end
    end)
    local c = I("ScreenGui", {Parent = (gethui and gethui()) or G("CoreGui"), ResetOnSpawn = false, DisplayOrder = 99, Enabled = false})
    table.insert(Shared.Core.cleanup, function()
      c:Destroy()
    end)
    local a = I("TextLabel", {Parent = c, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.fromOffset(170, 26), BackgroundColor3 = Color3.fromRGB(14, 16, 36), BackgroundTransparency = 0.2, TextColor3 = Color3.new(1, 1, 1), FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Medium), TextSize = 13, Text = ""})
    I("UICorner", {Parent = a, CornerRadius = UDim.new(1, 0)})
    local i
    a.Active = true
    a.InputBegan:Connect(function(n)
      local M = Shared.Core
      if not (M.press(n)) then
        return
      end
      i = {n.Position, a.Position}
      local M
      M = n.Changed:Connect(function()
        if n.UserInputState == Enum.UserInputState.End then
          i = nil
          M:Disconnect()
        end
      end)
    end)
    local n = {Value = "", Set = function(M, U)
      M.Value = tostring(U or "")
      local U, I, t, K = M.Value:match("^([%-%d%.]+),([%-%d%.]+),([%-%d%.]+),([%-%d%.]+)$")
      if U then
        a.Position = UDim2.new(tonumber(U), tonumber(I), tonumber(t), tonumber(K))
      end
    end}
    tO:Reg("FPS position", n)
    local function M(U)
      local I = Shared.Core
      if I.press(U) then
        local U = a.Position
        n:Set(("%.4f,%d,%.4f,%d"):format(U.X.Scale, U.X.Offset, U.Y.Scale, U.Y.Offset))
      end
    end
    a.InputEnded:Connect(M)
    UO("fpsDrag", G("UserInputService").InputChanged, function(n)
      if i then
        local M = Shared.Core
        if M.drags(n) then
          local M = n.Position - i[1]
          a.Position = i[2] + UDim2.fromOffset(M.X, M.Y)
        end
      end
    end)
    local i = 0
    m(tO, "Show FPS and ping", "fpsHud", true, function(n)
      c.Enabled = n
    end)
    c.Enabled = Shared.s21.fpsHud ~= false
    local c = sO({name = "Fps", gap = 1, t = os.clock()})
    c.on = function()
      local n = Shared.s21
      return n.fpsHud
    end
    UO("fpsC", Shared.RunService.RenderStepped, function()
      i += 1
    end)
    c.fn = function()
      local n = os.clock() - c.t
      c.t = os.clock()
      local c, M = math.floor, i
      local U = c((M / math.max(n, 0.01)) + 0.5)
      i = 0
      M, c = pcall(function()
        return G("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
      end)
      local G, i = M and math.floor(c)
      if G then
        i = G
      else
        c = nil
        c, i = Shared.s27, math.floor(Shared.s27() * 1000)
      end
      A("fps", function()
        a.Text = ("%d FPS  -  %d ms"):format(U, i)
      end)
    end
  end
  s:Settings(LO.Interface)
  s:Quick(LO.Interface, {"/Movement/Speed boost", "/Movement/Boost speed"})
  u, tO = LO.Interface, {}
  f:yT(tO, 0, {"Interface", "Theme", "Game HUD", "Defaults"}, {"Quick bars", "Pins and keybinds"})
  u:Arrange(tO)
  s:Config(LO.Config)
  task.spawn(f:QT(19, 20, {[49] = q, [69] = q, [1] = q, [70] = q}, p, y, nil))
  task.delay(3, function()
    local f, p = pcall(readfile, "Venyx/FromChilli.json")
    if f then
      if type(p) ~= "string" then
        return
      end
    else
      return
    end
    pcall(delfile, "Venyx/FromChilli.json")
    local y, y, y, G = Shared.HttpService, Shared.HttpService, pcall(Shared.HttpService.JSONDecode, Shared.HttpService, p)
    if y then
      if not (type(G) == "table") then
        return
      end
    else
      return
    end
    for y, c in next, G, nil do
      f = Z.Keys[y]
      p = ((f and f.Multi) and (type(c) == "table")) and (((type(f.Options) == "function") and f.Options()) or f.Options)
      if f then
        if type(p) == "table" then
          local f, a = {}, {}
          for i, i in ipairs(p) do
            f[((type(i) == "table") and i.v) or i] = true
          end
          for p, p in ipairs(c) do
            p = tostring(p)
            p = (f[p] and p) or p:match("^(.-) %[")
            if p then
              if f[p] then
                a[#a + 1] = p
              end
            end
          end
          G[y] = a
        end
      else
        G[y] = nil
      end
    end
    if not (next(G)) then
      return
    end
    Z:Save("From Chilli", G)
    A("chilliImport", function()
      s:Dialog({Title = "Chilli Hub config found", Kind = "warn", Text = "Apply your Chilli Hub settings to Venyx now? You can also load them later from Config as \"From Chilli\".", Buttons = {{"Later", function()
        W("Config", "Saved as \"From Chilli\" in Config", "ok")
      end}, {"Apply", function()
        Z.busy = true
        for f, p in next, G, nil do
          local y = Z.Keys[f]
          pcall(y.Set, y, p)
        end
        Z.busy = false
        Z:Save()
        W("Config", "Chilli Hub settings applied", "ok")
      end, true}}})
    end)
  end)
  do
    local function f(p)
      local y = Shared.Core
      return (y.rank[p.name] or p.pri) or 9
    end
    local function p(y)
      local G, c = pcall(y.on)
      return G and c
    end
    local function y(G)
      local c = Shared.Core
      local a, i = c.only
      if a then
        c = Shared.Core
        i = c.only()
      else
        i = a
      end
      return (i ~= nil) and (G.name ~= i)
    end
    local function G()
      table.sort(yO, function(c, a)
        local i, n = (c.mover and f(c)) or 99, (a.mover and f(a)) or 99
        if i ~= n then
          return i < n
        end
        return c.i < a.i
      end)
    end
    Shared.Core.order = G
    G()
    task.spawn(function()
      while true do
        local G = Shared.Alive
        if not G then
          break
        end
        local c, a, i = os.clock(), z(), Shared.Core
        local n, M = i.invisBusy
        if n then
          M = n
        else
          i = Shared.Core
          M = c < (i.invisSettle or 0)
        end
        G = ipairs
        for U, I in G(yO) do
          i, n = (Shared.Alive and not I.busy) and (c >= I.at)
          if i then
            local G, t = I.mover
            if G then
              U = nil
              if M then
                U = M
              else
                if a then
                  local M = Shared.Core
                  U = not M.free(I)
                else
                  U = a
                end
              end
              local a
              if U then
                a = U
              else
                local M = Shared.Core
                a = M.invisFirst(I)
              end
              t = a or (y(I))
            else
              t = G
            end
            n = not t
          else
            n = i
          end
          if (n and I.on) and p(I) then
            I.at = c + I.gap
            local p = I.tok
            local function G()
              local c, a = ((Shared.Alive and (I.tok == p)) and I.on()) and B()
              if c then
                local p = Shared.Core
                a = p.free(I) or not z()
              else
                a = c
              end
              local p, i = a and not y(I)
              if p then
                c = Shared.Core
                local y, n = c.invisBusy
                if y then
                  n = y
                else
                  a = nil
                  a, n = Shared.Core, os.clock() < (Shared.Core.invisSettle or 0)
                end
                i = not n
              else
                i = p
              end
              return i
            end
            if I.mover then
              local p = Shared.s4
              local y = B() and ((if p then p.soft and (f(I) < f(p)) else not p) or ((I.urgent and (p ~= I)) and (p.name ~= "Steal")))
              if y then
                local f, y = pcall(I.want)
                if f and y then
                  if p then
                    qO(p)
                    while true do
                      local f = p.busy and Shared.Alive
                      if not f then
                        break
                      end
                      task.wait()
                    end
                  end
                  Shared.s4, I.busy, I.t0 = I, true, os.clock()
                  task.spawn(function()
                    local f, p = pcall(function()
                      local c = Shared.Core
                      if c.leaveDim then
                        if I.name ~= "Halloween" then
                          if not ((type(y) == "table") and y.hw) then
                            if I.name ~= "IslandWars" then
                              if I.name ~= "Train" then
                                local c = Shared.Core
                                if c.inDim() then
                                  local c = Shared.Core
                                  if not (c.leaveDim(G)) then
                                    return
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                      return I.run(y, G)
                    end)
                    I.acted = f and (p == true)
                    if not (f) then
                      local y = Shared.s10
                      y(I.name .. (": " .. tostring(p):sub(1, 60)), "err")
                    end
                    p = Shared.s8
                    local y, G = p(), Shared.s16
                    f = G()
                    if not (z()) then
                      if y then
                        if y.PlatformStand then
                          y.PlatformStand = false
                        end
                      end
                      if f then
                        if not (f.Anchored) then
                          p = Shared.Vec3Zero
                          f.AssemblyLinearVelocity = p
                        end
                      end
                    end
                    I.busy = false
                    if Shared.s4 == I then
                      Shared.s4 = nil
                    end
                    G = Shared.Core
                    G.doneVis(I)
                  end)
                end
              end
            else
              I.busy = true
              task.spawn(function()
                pcall(I.fn)
                I.busy = false
              end)
            end
          end
        end
        task.wait(0.25)
      end
    end)
    local f = sO({name = "Guard", gap = 0.5})
    f.on = function()
      local p, y = (Shared.s4 ~= nil) and (Shared.s4.name ~= "Treadmill")
      if p then
        local G = Shared.Core
        y = (G.hold or 0) == 0
      else
        y = p
      end
      return y
    end
    f.fn = function()
      local p = Shared.s16
      local y = p()
      if y then
        if y.Anchored then
          f.n = (f.n or 0) + 1
          if f.n >= 2 then
            f.n = 0
            Shared.s14(function()
              return true
            end)
          end
        else
          f.n = 0
        end
      else
        f.n = 0
      end
    end
    local f = sO({name = "Info", gap = 1})
    f.on = function()
      return true
    end
    f.fn = function()
      local f = d()
      local p = math.floor(f - 10)
      local y, G = ((p > 0) and ("%ds"):format(p)) or ("now, day in %ds"):format(math.max(math.ceil(f + 5), 0)), Shared.s4
      local c, a = not G
      if G then
        a = c
      else
        f = nil
        f, a = Shared.Core, (os.clock() - (Shared.Core.noteAt or 0)) > 1.5
      end
      local i, n = {}
      n, i["Candy Corn"] = Shared.s59, O(tonumber((Shared.s59() or {}).HalloweenTokens) or 0)
      p = Shared.s36
      i["Last egg"] = p.last
      G = nil
      G, i.Placed = Shared.s36, tostring(Shared.s36.placed)
      i["Money /s"] = (function()
        local M = Shared.LocalPlayer
        local U = M:FindFirstChild("leaderstats")
        U = U and (U:FindFirstChild("Money/s"))
        U = (U and U.Value) or 0
        M = 10 ^ math.max(math.floor(math.log10(math.max(U, 1))) - 2, 0)
        return ((U > 0) and ("$" .. (O((U // M) * M) .. "/s"))) or "--"
      end)()
      i["Night in"] = y
      i["Session time"] = v(os.clock() - cO)
      y = Shared.s36
      c, f = y.best
      if c then
        p = Shared.s36
        f = "$" .. (O(p.best) .. "/s")
      else
        f = c
      end
      i["Best steal"] = f or "--"
      G = Shared.s59
      local f, p, c = G(), 0, 0
      for G in next, ((f and (type(f.EggInventory) == "table")) and f.EggInventory) or {}, nil do
        c += 1
      end
      y, n = next, ((f and (type(f.Inventory) == "table")) and f.Inventory) or {}
      for f in y, n, nil do
        p += 1
      end
      y = Shared.Core
      i["Egg bag"] = c .. (" / " .. (y.bagMax or 115))
      A("info", function()
        local f = 250
        pcall(function()
          local y
          y, f = Shared.LocalPlayer, tonumber(Shared.LocalPlayer.PlayerGui.BackpackGui.Backpack.Main.Inventory.Capacity.Text:match("/%s*(%d+)")) or f
        end)
        i["Pet bag"] = p .. (" / " .. f)
        local f = next
        for p, y in f, i, nil do
          local G = Shared.Core
          G.stats:Set(p, y)
        end
        f = Shared.s36
        if f.lastCat then
          local p = Shared.Core
          p.stats:Icon("Last egg", PO(Shared.s36.lastCat))
        end
        f = Shared.s36
        if f.bestCat then
          local p = Shared.Core
          p.stats:Icon("Best steal", PO(Shared.s36.bestCat))
        end
        if a then
          s:Status("Idle")
        end
        f = Shared.Core
        f.tick()
      end)
    end
  end
  H.VenyxSAE = function()
    local f = Shared.LocalPlayer
    local p, y = f.Character
    if p then
      f = Shared.LocalPlayer
      y = f.Character:GetAttribute("InvisApplied")
    else
      y = p
    end
    Shared.Alive = false
    p = Shared.Core
    for G, G in ipairs(p.cleanup or {}) do
      pcall(G)
    end
    for p, p in ipairs(L) do
      pcall(p.Disconnect, p)
    end
    f = Shared.s21
    f.god = false
    pcall(KO)
    f = Shared.s8
    if f() then
      pcall(CO, Shared.s8())
    end
    pcall(s.Destroy, s)
    H.VenyxSAE = nil
    task.spawn(function()
      for f = 1, 2, 1 do
        task.wait(0.5)
        f = Shared.Invoke
        f("RF/Treadmill/AskDoff")
      end
      if y then
        local f = Shared.Core
        f.respawn(true)
      end
    end)
end)()
