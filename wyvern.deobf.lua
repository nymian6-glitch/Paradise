local string_char, string_byte, bit32_bxor = string.char, string.byte, bit32.bxor
local uo = function(Qr, hs)
  local Ra = ""
  for yn = 205, (#Qr - 1) + 205 do
    Ra = Ra .. string_char(bit32_bxor(string_byte(Qr, (yn - 205) + 1), string_byte(hs, (yn - 205) % #hs + 1)))
  end
  return Ra
end
local string_gsub, string_char = string.gsub, string.char
local he = function(Ap)
  Ap = string_gsub(Ap, "[^ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=]", "")
  return (
    Ap:gsub(".", function(ab)
      if ab == "=" then
        return ""
      end
      local pb, Zn = "", (("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):find(ab) - 1)
      for Fh = 6, 1, -1 do
        pb = pb .. (Zn % 2 ^ Fh - Zn % 2 ^ (Fh - 1) > 0 and "1" or "0")
      end
      return pb
    end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(pd)
      if #pd ~= 8 then
        return ""
      end
      local q = 0
      for wo = 1, 8 do
        q = q + (pd:sub(wo, wo) == "1" and 2 ^ (8 - wo) or 0)
      end
      return string_char(q)
    end)
  )
end
local Qg, Gm = pcall(function()
  game()
end)
while not Gm:find("attempt to call a Instance value") do
  for Fu = 124, math.huge do
    Instance.new("Part"):InvalidMethod("wydird hmm i see you try to sneak my code ")
  end
end
if not (not game:IsLoaded()) then
else
  game.Loaded:Wait()
end
local math_floor, math_abs, math_rad, math_max, math_clamp, math_random, math_acos, math_deg, wv, Ao, CFrame_new, CFrame_Angles, Uj, UDim_new, jw, hg, Vs, string_lower, string_find, string_split, string_sub, string_upper, table_insert, table_remove, table_sort, table_clear, table_concat, task_wait, task_spawn, task_delay, CoreGui, HttpService, TweenService, TeleportService, Players, Workspace, ReplicatedStorage, UserInputService, RunService, Lighting, SoundService, Stats =
  math.floor,
  math.abs,
  math.rad,
  math.max,
  math.clamp,
  math.random,
  math.acos,
  math.deg,
  Vector2.new,
  Vector3.new,
  CFrame.new,
  CFrame.Angles,
  UDim2.new,
  UDim.new,
  Color3.new,
  Color3.fromRGB,
  Color3.fromHSV,
  string.lower,
  string.find,
  string.split,
  string.sub,
  string.upper,
  table.insert,
  table.remove,
  table.sort,
  table.clear,
  table.concat,
  task.wait,
  task.spawn,
  task.delay,
  game:GetService("CoreGui"),
  game:GetService("HttpService"),
  game:GetService("TweenService"),
  game:GetService("TeleportService"),
  game:GetService("Players"),
  game:GetService("Workspace"),
  game:GetService("ReplicatedStorage"),
  game:GetService("UserInputService"),
  game:GetService("RunService"),
  game:GetService("Lighting"),
  game:GetService("SoundService"),
  game:GetService("Stats")
local ii_LocalPlayer, Vm_CurrentCamera, If = Players.LocalPlayer, Workspace.CurrentCamera, nil
pcall(function()
  If = (rawget and rawget(_G, "setclipboard")) or (rawget and rawget(_G, "toclipboard")) or _G.setclipboard or _G.toclipboard
end)
local Zu, Wk, Md, gm, zh, wq =
  mousemoverel or (Input and Input.MouseMoveRel) or mouse_moverel or function() end,
  mouse1press or function() end,
  mouse1release or function() end,
  mouse1click or function() end,
  keypress or key_press,
  keyrelease or function() end
local function Ae()
  local wg, po = pcall(function()
    if not gethui then
    else
      return gethui()
    end
  end)
  if not (wg and po) then
  else
    return po
  end
  local StarterGui = game:GetService("StarterGui")
  return ii_LocalPlayer:FindFirstChild("PlayerGui") or CoreGui
end
local as = "Unknown"
pcall(function()
  if not identifyexecutor then
  else
    as = identifyexecutor() or "Unknown"
  end
end)
local Kq = string_lower(as)
if not (string_find(Kq, "cosmic")) then
else
  ii_LocalPlayer:Kick("Wyvern Bloxstrike: Cosmic executor is not supported for security reasons.")
  task_wait(0.5)
  while true do
  end
end
local T, Wl_TouchEnabled, Be, eg, oi, ag =
  string_find(Kq, "xeno") ~= nil or string_find(Kq, "solara") ~= nil,
  UserInputService.TouchEnabled,
  require(ReplicatedStorage:WaitForChild("Database"):WaitForChild("Components"):WaitForChild("Libraries"):WaitForChild("Skins")),
  require(ReplicatedStorage:WaitForChild("Classes"):WaitForChild("WeaponComponent"):WaitForChild("Classes"):WaitForChild("Viewmodel")),
  require(ReplicatedStorage:WaitForChild("Controllers"):WaitForChild("InventoryController")),
  Workspace:WaitForChild("Characters")
local function Yp(mu)
  warn("[Wyvern] " .. tostring(mu))
end
local function Zr()
  local Kp = Instance.new("Sound")
  Kp.SoundId = "rbxassetid://108038650150228"
  Kp.Volume = 1
  Kp.Parent = Workspace
  Kp:Play()
  Kp.Ended:Connect(function()
    Kp:Destroy()
  end)
end
Zr()
local Wd, Cn =
  {
    Watermark = true,
    ShowKeybinds = true,
    ShowWButton = true,
    RageMode = false,
    RageKey = Enum.KeyCode.Unknown,
    AutoShoot = false,
    KillAll = false,
    SilentEnabled = false,
    Wallbang = false,
    FOV = 150,
    ShowFOV = true,
    TargetPart = "Head",
    HitChance = 100,
    RandomParts = false,
    TargetPartMode = "Head",
    FullFOV360 = false,
    Spread = 0,
    DynamicMiss = false,
    RecoilSpoof = true,
    HitboxScanning = true,
    ViewAngleSpoof = true,
    InterpolatedSpoof = true,
    InterpSmoothness = 1.2,
    AimPrediction = true,
    HumanRecoilComp = true,
    RecoilCompStrength = 80,
    VelocityDesync = true,
    DesyncAmount = 60,
    OriginSpoof = false,
    SilentAimToggleKey = Enum.KeyCode.Unknown,
    WallbangToggleKey = Enum.KeyCode.Unknown,
    TriggerBot = false,
    TriggerKey = Enum.KeyCode.Unknown,
    TriggerDelay = 0,
    Backtrack = true,
    BacktrackTime = 250,
    Aimlock = false,
    FlickBot = false,
    AimSmoothness = 2,
    AimFOV = 150,
    AimKey = Enum.UserInputType.MouseButton2,
    AimWallCheck = true,
    TeamCheck = true,
    AimMethod = "Raw Mouse",
    AimJitter = 10,
    AimlockToggleKey = Enum.KeyCode.Unknown,
    AntiSpecEnable = false,
    AntiSpecMode = "Both",
    ESP = false,
    Box = false,
    Box3D = false,
    Name = false,
    Distance = false,
    MoneyESP = false,
    WeaponNameESP = false,
    HPBar = false,
    Skeleton = false,
    Tracers = false,
    ViewTracers = false,
    ViewTracerLength = 15,
    Chams = false,
    ShowTeam = false,
    TeamColors = true,
    WeaponESP = false,
    C4ESP = false,
    BombTrail = false,
    BulletTracers = false,
    TracerColor = "Yellow",
    ESPToggleKey = Enum.KeyCode.Unknown,
    EnemyESPColor = "Red",
    TeamESPColor = "Cyan",
    VMChams = false,
    VMChamsColor = "White",
    RainbowVM = false,
    VMChamsTransparency = 30,
    HitboxExpander = false,
    HitboxSize = 2,
    HitboxTransparency = 50,
    HitboxToggleKey = Enum.KeyCode.Unknown,
    NightMode = false,
    LowGFX = false,
    AntiFlash = false,
    AntiSmoke = false,
    Spectators = false,
    NightModeKey = Enum.KeyCode.Unknown,
    MenuKey = Enum.KeyCode.V,
    TPS = false,
    TPSDistance = 8,
    MovementEnabled = false,
    JumpPower = 25,
    SpeedValue = 16,
    Bhop = false,
    Spinbot = false,
    SpinbotSpeed = 50,
    SpinbotLookUp = false,
    TPSKey = Enum.KeyCode.Unknown,
    SpeedJumpKey = Enum.KeyCode.Unknown,
    HitSound = false,
    HitSoundID = "Sound 1",
    CustomHitSoundID = "131051026960528",
    RapidFire = false,
    RapidFireDelay = 10,
    InstaReload = false,
    InstaEquip = false,
    AutoClicker = false,
    AutoClickerDelay = 50,
    MobileUI = Wl_TouchEnabled,
    AutoApplySkins = true,
    ActiveGunSkins = {},
    TargetKnife = "Karambit",
    TargetSkin = "Vanilla",
    TargetGlove = "Sports Gloves",
    TargetSkinGlove = "",
    Hitmarker = true,
    HitmarkerDuration = 300,
    DamageIndicator = true,
    SmartTargeting = false,
    SmartPartESP = false,
    BacktrackChams = false,
  },
  {
    HitQueue = {},
    activeWarnings = {},
    highestWarnLevel = 0,
    fpsSum = 0,
    frameCount = 0,
    SpecCount = 0,
    Checkifbaseknife = { "CT Knife", "T Knife" },
    TargetKnife = "Karambit",
    TargetSkin = "Vanilla",
    TargetGlove = "Sports Gloves",
    TargetSkinGlove = "",
    TargetGun = nil,
    TargetGunSkin = nil,
    FoundKnives = {},
    FoundSkins = { "Vanilla" },
    FoundGloves = {},
    FoundGloveSkins = {},
    AvailableGunSkins = {},
    KnifeKeywords = {
      "knife",
      "karambit",
      "bayonet",
      "butterfly",
      "gut",
      "huntsman",
      "falchion",
      "bowie",
      "daggers",
      "navaja",
      "stiletto",
      "talon",
      "ursus",
      "kukri",
      "dagger",
      "sickle",
      "machete",
    },
    HitSoundMap = {
      ["Sound 1"] = "131051026960528",
      ["Sound 2"] = "134133338735313",
      ["Sound 3"] = "128315748935399",
      ["Sound 4"] = "131775908076148",
      ["Sound 5"] = "137280299475879",
      ["Sound 6"] = "140569440527302",
      ["Sound 7"] = "18362692980",
      ["Sound 8"] = "84282005424007",
    },
    IsMenuOpen = false,
    isTweening = false,
    dragging = false,
    dragInput = nil,
    dragStart = nil,
    startPos = nil,
    PreviewConnection = nil,
    smokeConnections = {},
    isSkinLoaded = false,
    mDragging = false,
    mDragInput = nil,
    mDragStart = nil,
    mStartPos = nil,
    sortedWeapons = {},
    SkinsFolder = nil,
    OriginalFireRates = {},
    InstaCache = {},
    ActiveWeaponTables = {},
    isClicking = false,
    BacktrackHistory = {},
    LastSpoofedDirection = nil,
    _G_AutoShootWait = false,
    ESP_Objects = {},
    VisCache = {},
    BacktrackFolders = Instance.new("Folder", Workspace),
    espTimer = 0,
    ESP_UPDATE_RATE = 0.016666666666666666,
    CurrentLockedTarget = nil,
    TriggerBotActive = false,
    SpinbotAngle = 0,
    OriginalC0s = {},
    OriginalVMMaterials = {},
    OriginalVMColors = {},
    OriginalHitboxSizes = {},
    MasterWeaponIcons = {},
    ESPRaycastParams = RaycastParams.new(),
  }
Cn.ESPRaycastParams.FilterType = Enum.RaycastFilterType.Exclude
Cn.BacktrackFolders.Name = "Wyvern_Backtrack_Chams"
local h, zo, qb, sl, Bm =
  {},
  { Materials = {}, Reflectance = {}, Textures = {}, SurfaceAppearances = {}, Lighting = {} },
  {
    Background = hg(20, 0, 50),
    Panel = hg(30, 30, 70),
    MainColor = hg(0, 255, 255),
    AccentColor = hg(255, 50, 200),
    Text = hg(240, 255, 255),
    TextDim = hg(150, 150, 180),
  },
  {
    ["Red"] = hg(255, 50, 50),
    ["Green"] = hg(50, 255, 50),
    ["Blue"] = hg(50, 100, 255),
    ["Yellow"] = hg(255, 255, 50),
    ["Cyan"] = hg(0, 255, 255),
    ["Magenta"] = hg(255, 0, 255),
    ["White"] = hg(255, 255, 255),
    ["Orange"] = hg(255, 150, 0),
  },
  {}
Bm.ESPGui = Instance.new("ScreenGui")
Bm.ESPGui.Name = "Wyvern_NativeESP"
Bm.ESPGui.IgnoreGuiInset = true
Bm.ESPGui.Parent = Ae()
Bm.HitmarkerCenter = Instance.new("Frame", Bm.ESPGui)
Bm.HitmarkerCenter.BackgroundTransparency = 1
Bm.HitmarkerCenter.Size = Uj(0, 16, 0, 16)
Bm.HitmarkerCenter.Position = Uj(0.5, -8, 0.5, -8)
Bm.HitmarkerCenter.Visible = false
Bm.HM_Line1 = Instance.new("Frame", Bm.HitmarkerCenter)
Bm.HM_Line1.Size = Uj(0, 2, 0, 8)
Bm.HM_Line1.Position = Uj(0, 2, 0, 2)
Bm.HM_Line1.BackgroundColor3 = jw(1, 1, 1)
Bm.HM_Line1.Rotation = 45
Bm.HM_Line1.BorderSizePixel = 0
Bm.HM_Line2 = Instance.new("Frame", Bm.HitmarkerCenter)
Bm.HM_Line2.Size = Uj(0, 2, 0, 8)
Bm.HM_Line2.Position = Uj(1, -4, 0, 2)
Bm.HM_Line2.BackgroundColor3 = jw(1, 1, 1)
Bm.HM_Line2.Rotation = -45
Bm.HM_Line2.BorderSizePixel = 0
Bm.HM_Line3 = Instance.new("Frame", Bm.HitmarkerCenter)
Bm.HM_Line3.Size = Uj(0, 2, 0, 8)
Bm.HM_Line3.Position = Uj(0, 2, 1, -10)
Bm.HM_Line3.BackgroundColor3 = jw(1, 1, 1)
Bm.HM_Line3.Rotation = -45
Bm.HM_Line3.BorderSizePixel = 0
Bm.HM_Line4 = Instance.new("Frame", Bm.HitmarkerCenter)
Bm.HM_Line4.Size = Uj(0, 2, 0, 8)
Bm.HM_Line4.Position = Uj(1, -4, 1, -10)
Bm.HM_Line4.BackgroundColor3 = jw(1, 1, 1)
Bm.HM_Line4.Rotation = 45
Bm.HM_Line4.BorderSizePixel = 0
local Ik, Pl, vp, oc, j = {}, tostring, type, typeof, false
local function u_()
  if not j then
  else
    return
  end
  j = true
  local Ck, Np, Bo =
    newcclosure(function(nd)
      if vp(nd) == "table" and Ik[nd] then
        return Ik[nd]
      end
      return Pl(nd)
    end), newcclosure(function(fh)
      if vp(fh) == "table" and Ik[fh] then
        return "function"
      end
      return vp(fh)
    end), newcclosure(function(Ni)
      if vp(Ni) == "table" and Ik[Ni] then
        return "function"
      end
      return oc(Ni)
    end)
  getgenv().tostring = Ck
  getgenv().type = Np
  getgenv().typeof = Bo
end
local function Dq(ov, Eq, Mi)
  local Ng = ov[Eq]
  if not Ng then
    return nil
  end
  local Ag = Pl(Ng)
  u_()
  local Hn = setmetatable({}, {
    __call = function(Mv, ...)
      local Tv, Op = pcall(Mi, Ng, ...)
      if Tv then
        return Op
      else
        return Ng(...)
      end
    end,
    __tostring = function()
      return Ag
    end,
    __metatable = getmetatable(Ng) or "The metatable is locked",
  })
  Ik[Hn] = Ag
  ov[Eq] = Hn
  return Ng
end
local function ud()
  Cn.activeWarnings = {}
  Cn.highestWarnLevel = 0
  local function bb(iw, hb)
    table_insert(Cn.activeWarnings, hb)
    if iw > Cn.highestWarnLevel then
      Cn.highestWarnLevel = iw
    end
  end
  if Wd.KillAll then
    bb(2, "\195\162\226\130\172\194\162 KILL ALL ACTIVE: Instant Ban Risk!")
  end
  if not Wd.RageMode then
  else
    bb(2, "\195\162\226\130\172\194\162 RAGE MODE ACTIVE: High Risk of Kick/Ban!")
  end
  if Wd.HitboxExpander then
    bb(1, "\195\162\226\130\172\194\162 Hitbox Expander Active: Visible to others!")
  end
  if tonumber(Wd.FOV) > 150 then
    bb(2, "\195\162\226\130\172\194\162 try lower fov you can get kick from game")
  end
  if Wd.Wallbang then
    bb(2, "\195\162\226\130\172\194\162 Wallbang can get you kicked")
  end
  local hp = tonumber(Wd.HitChance) or 100
  if hp > 80 then
    bb(2, "\195\162\226\130\172\194\162 Hit Chance > 80 can get you kicked")
  elseif not (hp > 60) then
  else
    bb(1, "\195\162\226\130\172\194\162 Hit Chance > 60 is risky")
  end
  local fr = tonumber(Wd.Spread) or 0
  if not (fr < 40) then
    if fr < 50 then
      bb(1, "\195\162\226\130\172\194\162 Spread < 50 is risky")
    end
  else
    bb(2, "\195\162\226\130\172\194\162 Spread < 40 can get you kicked")
  end
  if not Wd.FullFOV360 then
  else
    bb(2, "\195\162\226\130\172\194\162 360 FOV can get you kicked")
  end
  if Wd.MovementEnabled then
    bb(2, "\195\162\226\130\172\194\162 Speed/Jump can get you kicked")
  end
  if not Bm.GlobalWarnBox then
  else
    if not (#Cn.activeWarnings > 0) then
      Bm.GlobalWarnBox.Visible = false
      if Bm.TooltipFrame then
        Bm.TooltipFrame.Visible = false
      end
    else
      Bm.GlobalWarnBox.Visible = true
      local ob = Cn.highestWarnLevel == 2 and hg(255, 50, 50) or hg(255, 200, 0)
      if not Bm.GlobalWarnStroke then
      else
        Bm.GlobalWarnStroke.Color = ob
      end
      if not Bm.TooltipStroke then
      else
        Bm.TooltipStroke.Color = ob
      end
      local ow = table_concat(Cn.activeWarnings, "\n")
      if not Bm.TooltipText then
      else
        Bm.TooltipText.Text = ow
      end
      local lc = game:GetService("TextService"):GetTextSize(ow, 12, Enum.Font.GothamMedium, wv(500, 500))
      if not Bm.TooltipFrame then
      else
        Bm.TooltipFrame.Size = Uj(0, lc.X + 16, 0, lc.Y + 16)
      end
    end
  end
end
Bm.NotifGui = Instance.new("ScreenGui")
Bm.NotifGui.Name = "Wyvern_Notifications"
Bm.NotifGui.Parent = Ae()
Bm.NotifContainer = Instance.new("Frame")
Bm.NotifContainer.Size = Uj(0, 300, 1, 0)
Bm.NotifContainer.Position = Uj(1, -310, 0, 20)
Bm.NotifContainer.BackgroundTransparency = 1
Bm.NotifContainer.Parent = Bm.NotifGui
Bm.NotifList = Instance.new("UIListLayout")
Bm.NotifList.Parent = Bm.NotifContainer
Bm.NotifList.SortOrder = Enum.SortOrder.LayoutOrder
Bm.NotifList.Padding = UDim_new(0, 10)
Bm.NotifList.VerticalAlignment = Enum.VerticalAlignment.Top
Bm.NotifList.HorizontalAlignment = Enum.HorizontalAlignment.Right
local function Ev(D, Mo, Fi)
  Fi = Fi or 3
  local Ip = Instance.new("Frame")
  Ip.Size = Uj(0, 250, 0, 60)
  Ip.BackgroundColor3 = qb.Background
  Ip.BackgroundTransparency = 0.1
  Instance.new("UICorner", Ip).CornerRadius = UDim_new(0, 8)
  local Zb = Instance.new("UIStroke")
  Zb.Color = qb.MainColor
  Zb.Thickness = 1.5
  Zb.Parent = Ip
  local Rr = Instance.new("TextLabel")
  Rr.Size = Uj(1, -20, 0, 20)
  Rr.Position = Uj(0, 10, 0, 5)
  Rr.BackgroundTransparency = 1
  Rr.Text = D
  Rr.TextColor3 = qb.MainColor
  Rr.Font = Enum.Font.GothamBold
  Rr.TextSize = 14
  Rr.TextXAlignment = Enum.TextXAlignment.Left
  Rr.Parent = Ip
  local fn = Instance.new("TextLabel")
  fn.Size = Uj(1, -20, 0, 25)
  fn.Position = Uj(0, 10, 0, 25)
  fn.BackgroundTransparency = 1
  fn.Text = Mo
  fn.TextColor3 = qb.Text
  fn.Font = Enum.Font.GothamMedium
  fn.TextSize = 12
  fn.TextXAlignment = Enum.TextXAlignment.Left
  fn.TextWrapped = true
  fn.Parent = Ip
  local Wg = Instance.new("Frame")
  Wg.Size = Uj(1, 0, 0, 4)
  Wg.Position = Uj(0, 0, 1, -4)
  Wg.BackgroundColor3 = qb.Panel
  Wg.BorderSizePixel = 0
  Wg.Parent = Ip
  Instance.new("UICorner", Wg).CornerRadius = UDim_new(0, 8)
  local Ii = Instance.new("Frame")
  Ii.Size = Uj(1, 0, 1, 0)
  Ii.BackgroundColor3 = qb.AccentColor
  Ii.BorderSizePixel = 0
  Ii.Parent = Wg
  Instance.new("UICorner", Ii).CornerRadius = UDim_new(0, 8)
  Ip.Parent = Bm.NotifContainer
  Ip.Position = Uj(1, 0, 0, 0)
  TweenService:Create(Ip, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = Uj(0, 0, 0, 0) }):Play()
  TweenService:Create(Ii, TweenInfo.new(Fi, Enum.EasingStyle.Linear), { Size = Uj(0, 0, 1, 0) }):Play()
  task_delay(Fi, function()
    local _n = TweenService:Create(
      Ip,
      TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
      { Position = Uj(1, 50, 0, 0), BackgroundTransparency = 1 }
    )
    _n:Play()
    TweenService:Create(Zb, TweenInfo.new(0.4), { Transparency = 1 }):Play()
    TweenService:Create(Rr, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()
    TweenService:Create(fn, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()
    TweenService:Create(Wg, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Ii, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()
    _n.Completed:Connect(function()
      Ip:Destroy()
    end)
  end)
end
Bm.WatermarkGui = Instance.new("ScreenGui")
Bm.WatermarkGui.Name = "Wyvern_Watermark"
Bm.WatermarkGui.IgnoreGuiInset = false
Bm.WatermarkGui.Parent = Ae()
Bm.WFrame = Instance.new("Frame", Bm.WatermarkGui)
Bm.WFrame.Size = Uj(0, 260, 0, 24)
Bm.WFrame.Position = Uj(0, 15, 0, 50)
Bm.WFrame.BackgroundColor3 = qb.Background
Bm.WFrame.BackgroundTransparency = 0.2
Instance.new("UICorner", Bm.WFrame).CornerRadius = UDim_new(0, 4)
Bm.WStroke = Instance.new("UIStroke", Bm.WFrame)
Bm.WStroke.Color = qb.MainColor
Bm.WStroke.Thickness = 1.5
Bm.WLabel = Instance.new("TextLabel", Bm.WFrame)
Bm.WLabel.Size = Uj(1, -10, 1, 0)
Bm.WLabel.Position = Uj(0, 5, 0, 0)
Bm.WLabel.BackgroundTransparency = 1
Bm.WLabel.TextColor3 = qb.Text
Bm.WLabel.Font = Enum.Font.GothamMedium
Bm.WLabel.TextSize = 12
Bm.WLabel.TextXAlignment = Enum.TextXAlignment.Left
local kv = ii_LocalPlayer and ii_LocalPlayer.Name or "User"
Bm.WLabel.Text = "Wyvern (Crack by dyxmy xD) | " .. kv .. " | Loading..."
RunService.Heartbeat:Connect(function(Ce)
  Cn.fpsSum = Cn.fpsSum + 1 / Ce
  Cn.frameCount = Cn.frameCount + 1
end)
task_spawn(function()
  while Bm.WFrame and Bm.WFrame.Parent do
    pcall(function()
      Bm.WatermarkGui.Enabled = Wd.Watermark
      local Gj = (Cn.frameCount > 0) and math_floor(Cn.fpsSum / Cn.frameCount) or 0
      Cn.fpsSum = 0
      Cn.frameCount = 0
      local wp = 0
      pcall(function()
        local Ef = Stats:FindFirstChild("PerformanceStats")
        if Ef and Ef:FindFirstChild("Ping") then
          wp = math_floor(Ef.Ping:GetValue())
        else
          wp = math_floor(Stats.Network.ServerTickBridge.LastPing * 1000)
        end
      end)
      if not (wp < 0 or wp > 2000) then
      else
        wp = 0
      end
      Bm.WLabel.Text = string.format("Wyvern (Crack by dymxy xD) | %s | %d FPS | %dms", kv, Gj, wp)
      Bm.WLabel.TextColor3 = qb.Text
      Bm.WStroke.Color = qb.MainColor
    end)
    task_wait(1)
  end
end)
local function Ci()
  if not readfile then
  else
    local mi, Tk = pcall(readfile, "WyvernBloxstrike_MasterConfig.json")
    if not (mi and type(Tk) == "string" and Tk ~= "") then
    else
      local vb, Jp = pcall(HttpService.JSONDecode, HttpService, Tk)
      if not (vb and type(Jp) == "table") then
      else
        return Jp
      end
    end
  end
  return {}
end
local function mo(gq)
  if not writefile then
    return false
  end
  local Ys, Ts = Ci(), {}
  for yd, Lp in pairs(Wd) do
    if typeof(Lp) == "EnumItem" then
      Ts[yd] = "ENUM_" .. tostring(Lp)
    else
      Ts[yd] = Lp
    end
  end
  Ys[gq] = Ts
  return pcall(function()
    writefile("WyvernBloxstrike_MasterConfig.json", HttpService:JSONEncode(Ys))
  end)
end
local function nl(_d)
  local Am = Ci()
  local Ya = Am[_d]
  if not Ya or type(Ya) ~= "table" then
    return false
  end
  for Ne, cl in pairs(Ya) do
    if Ne == "TargetKnife" then
      Cn.TargetKnife = cl
      Wd.TargetKnife = cl
    elseif Ne == "TargetSkin" then
      Cn.TargetSkin = cl
      Wd.TargetSkin = cl
    elseif Ne == "TargetGlove" then
      Cn.TargetGlove = cl
      Wd.TargetGlove = cl
    elseif not (Ne == "TargetSkinGlove") then
      if Ne == "ActiveGunSkins" then
        Wd.ActiveGunSkins = cl
      elseif not (type(cl) == "string" and string_sub(cl, 1, 5) == "ENUM_") then
        if not h[Ne] then
          Wd[Ne] = cl
        else
          h[Ne](cl)
        end
      else
        local I = string_split(string_sub(cl, 6), ".")
        pcall(function()
          local Wp = Enum[I[2]][I[3]]
          if h[Ne] then
            h[Ne](Wp)
          else
            Wd[Ne] = Wp
          end
        end)
      end
    else
      Cn.TargetSkinGlove = cl
      Wd.TargetSkinGlove = cl
    end
  end
  Wd.HitboxScanning = true
  Wd.ViewAngleSpoof = true
  Wd.InterpolatedSpoof = true
  Wd.InterpSmoothness = 1.2
  Wd.AimPrediction = true
  Wd.HumanRecoilComp = true
  Wd.RecoilCompStrength = 80
  Wd.VelocityDesync = true
  Wd.DesyncAmount = 60
  Wd.OriginSpoof = false
  return true
end
Bm.ScreenGui = Instance.new("ScreenGui")
Bm.ScreenGui.Name = "Wyvern_Bloxstrike"
Bm.ScreenGui.ResetOnSpawn = false
Bm.ScreenGui.Parent = Ae()
for Sc, no_ in pairs(Bm.ScreenGui.Parent:GetChildren()) do
  if no_.Name == "Wyvern_Bloxstrike" and no_ ~= Bm.ScreenGui then
    no_:Destroy()
  end
end
local tb, Mq = Wl_TouchEnabled and 500 or 600, Wl_TouchEnabled and 340 or 400
Bm.OpenMenuBtn = Instance.new("TextButton", Bm.ScreenGui)
Bm.OpenMenuBtn.Size = Uj(0, 50, 0, 50)
Bm.OpenMenuBtn.AnchorPoint = wv(0.5, 0.5)
Bm.OpenMenuBtn.Position = Uj(0, 35, 0.5, 0)
Bm.OpenMenuBtn.BackgroundColor3 = qb.Background
Bm.OpenMenuBtn.BackgroundTransparency = 0.7
Bm.OpenMenuBtn.Text = "W"
Bm.OpenMenuBtn.TextColor3 = qb.MainColor
Bm.OpenMenuBtn.Font = Enum.Font.GothamBlack
Bm.OpenMenuBtn.TextSize = 24
Bm.OpenMenuBtn.Visible = false
Instance.new("UICorner", Bm.OpenMenuBtn).CornerRadius = UDim_new(1, 0)
Bm.OpenBtnStroke = Instance.new("UIStroke", Bm.OpenMenuBtn)
Bm.OpenBtnStroke.Color = qb.AccentColor
Bm.OpenBtnStroke.Thickness = 2
Bm.MainFrame = Instance.new("Frame", Bm.ScreenGui)
Bm.MainFrame.AnchorPoint = wv(0.5, 0.5)
Bm.MainFrame.Position = Uj(0.5, 0, 0.5, 0)
Bm.MainFrame.Size = Uj(0, 0, 0, 0)
Bm.MainFrame.BackgroundColor3 = qb.Background
Bm.MainFrame.BackgroundTransparency = 0.05
Bm.MainFrame.BorderSizePixel = 0
Bm.MainFrame.Visible = false
Instance.new("UICorner", Bm.MainFrame).CornerRadius = UDim_new(0, 6)
Bm.MainStroke = Instance.new("UIStroke", Bm.MainFrame)
Bm.MainStroke.Color = qb.MainColor
Bm.MainStroke.Thickness = 1.5
Bm.PreviewFrame = Instance.new("Frame", Bm.MainFrame)
Bm.PreviewFrame.Size = Uj(0, 350, 1, 0)
Bm.PreviewFrame.Position = Uj(1, 10, 0, 0)
Bm.PreviewFrame.BackgroundColor3 = qb.Background
Bm.PreviewFrame.BackgroundTransparency = 0.05
Bm.PreviewFrame.BorderSizePixel = 0
Bm.PreviewFrame.Visible = false
Instance.new("UICorner", Bm.PreviewFrame).CornerRadius = UDim_new(0, 6)
Bm.PrevStroke = Instance.new("UIStroke", Bm.PreviewFrame)
Bm.PrevStroke.Color = qb.MainColor
Bm.PrevStroke.Thickness = 1.5
Bm.ViewportBG = Instance.new("Frame", Bm.PreviewFrame)
Bm.ViewportBG.Size = Uj(1, -20, 1, -40)
Bm.ViewportBG.Position = Uj(0, 10, 0, 10)
Bm.ViewportBG.BackgroundColor3 = qb.Panel
Bm.ViewportBG.BackgroundTransparency = 0.7
Bm.ViewportBG.BorderSizePixel = 0
Instance.new("UICorner", Bm.ViewportBG).CornerRadius = UDim_new(0, 6)
Bm.VpStroke = Instance.new("UIStroke", Bm.ViewportBG)
Bm.VpStroke.Color = qb.AccentColor
Bm.VpStroke.Thickness = 1
Bm.InfoText = Instance.new("TextLabel", Bm.PreviewFrame)
Bm.InfoText.Size = Uj(1, 0, 0, 20)
Bm.InfoText.Position = Uj(0, 0, 1, -25)
Bm.InfoText.BackgroundTransparency = 1
Bm.InfoText.Text = "Drag: Rotate | Scroll: Zoom In/Out"
Bm.InfoText.TextColor3 = qb.TextDim
Bm.InfoText.Font = Enum.Font.GothamMedium
Bm.InfoText.TextSize = 11
task_spawn(function()
  Bm.SplashGui = Instance.new("ScreenGui")
  Bm.SplashGui.Name = "Wyvern_Splash"
  Bm.SplashGui.IgnoreGuiInset = true
  Bm.SplashGui.Parent = Ae()
  Bm.SplashBg = Instance.new("Frame", Bm.SplashGui)
  Bm.SplashBg.Size = Uj(1, 0, 1, 0)
  Bm.SplashBg.BackgroundColor3 = hg(0, 0, 0)
  Bm.SplashCard = Instance.new("Frame", Bm.SplashBg)
  Bm.SplashCard.AnchorPoint = wv(0.5, 0.5)
  Bm.SplashCard.Position = Uj(0.5, 0, 0.5, 60)
  Bm.SplashCard.Size = Uj(0, 320, 0, 110)
  Bm.SplashCard.BackgroundColor3 = qb.Background
  Bm.SplashCard.BackgroundTransparency = 0.05
  Instance.new("UICorner", Bm.SplashCard).CornerRadius = UDim_new(0, 12)
  Bm.SplashStroke = Instance.new("UIStroke", Bm.SplashCard)
  Bm.SplashStroke.Color = qb.MainColor
  Bm.SplashStroke.Thickness = 2
  Bm.SplashTitle = Instance.new("TextLabel", Bm.SplashCard)
  Bm.SplashTitle.Size = Uj(1, 0, 0, 40)
  Bm.SplashTitle.Position = Uj(0, 0, 0, 12)
  Bm.SplashTitle.BackgroundTransparency = 1
  Bm.SplashTitle.Text = "WYVERN BLOXSTRIKE"
  Bm.SplashTitle.TextColor3 = qb.MainColor
  Bm.SplashTitle.Font = Enum.Font.GothamBlack
  Bm.SplashTitle.TextSize = 26
  Bm.SplashTitle.TextTransparency = 1
  Bm.SplashSub = Instance.new("TextLabel", Bm.SplashCard)
  Bm.SplashSub.Size = Uj(1, 0, 0, 22)
  Bm.SplashSub.Position = Uj(0, 0, 0, 52)
  Bm.SplashSub.BackgroundTransparency = 1
  Bm.SplashSub.Text = "Running on: " .. as
  Bm.SplashSub.TextColor3 = qb.TextDim
  Bm.SplashSub.Font = Enum.Font.GothamMedium
  Bm.SplashSub.TextSize = 12
  Bm.SplashSub.TextTransparency = 1
  Bm.SplashBarBg = Instance.new("Frame", Bm.SplashCard)
  Bm.SplashBarBg.Size = Uj(0.8, 0, 0, 3)
  Bm.SplashBarBg.Position = Uj(0.1, 0, 0, 84)
  Bm.SplashBarBg.BackgroundColor3 = qb.Panel
  Bm.SplashBarBg.BorderSizePixel = 0
  Instance.new("UICorner", Bm.SplashBarBg).CornerRadius = UDim_new(1, 0)
  Bm.SplashBar = Instance.new("Frame", Bm.SplashBarBg)
  Bm.SplashBar.Size = Uj(0, 0, 1, 0)
  Bm.SplashBar.BackgroundColor3 = qb.MainColor
  Bm.SplashBar.BorderSizePixel = 0
  Instance.new("UICorner", Bm.SplashBar).CornerRadius = UDim_new(1, 0)
  Bm.SplashStatus = Instance.new("TextLabel", Bm.SplashCard)
  Bm.SplashStatus.Size = Uj(1, 0, 0, 16)
  Bm.SplashStatus.Position = Uj(0, 0, 0, 90)
  Bm.SplashStatus.BackgroundTransparency = 1
  Bm.SplashStatus.Text = "Initializing..."
  Bm.SplashStatus.TextColor3 = qb.AccentColor
  Bm.SplashStatus.Font = Enum.Font.GothamMedium
  Bm.SplashStatus.TextSize = 11
  Bm.SplashStatus.TextTransparency = 1
  TweenService:Create(Bm.SplashCard, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = Uj(0.5, 0, 0.5, 0) })
    :Play()
  TweenService:Create(Bm.SplashTitle, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
  task_wait(0.5)
  TweenService:Create(Bm.SplashSub, TweenInfo.new(0.4), { TextTransparency = 0 }):Play()
  TweenService:Create(Bm.SplashStatus, TweenInfo.new(0.4), { TextTransparency = 0 }):Play()
  task_wait(0.45)
  local Uk = { "Loading modules...", "Building GUI...", "Hooking services...", "Ready!" }
  for yl, Ac in ipairs(Uk) do
    Bm.SplashStatus.Text = Ac
    local tq = TweenService:Create(Bm.SplashBar, TweenInfo.new(0.32, Enum.EasingStyle.Quad), { Size = Uj(yl / #Uk, 0, 1, 0) })
    tq:Play()
    tq.Completed:Wait()
  end
  task_wait(0.3)
  TweenService:Create(Bm.SplashBg, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { BackgroundTransparency = 1 })
    :Play()
  TweenService:Create(Bm.SplashCard, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { BackgroundTransparency = 1 })
    :Play()
  TweenService:Create(Bm.SplashStroke, TweenInfo.new(0.45), { Transparency = 1 }):Play()
  TweenService:Create(Bm.SplashTitle, TweenInfo.new(0.45), { TextTransparency = 1 }):Play()
  TweenService:Create(Bm.SplashSub, TweenInfo.new(0.45), { TextTransparency = 1 }):Play()
  TweenService:Create(Bm.SplashStatus, TweenInfo.new(0.45), { TextTransparency = 1 }):Play()
  local fg = TweenService:Create(Bm.SplashBar, TweenInfo.new(0.45), { BackgroundTransparency = 1 })
  fg:Play()
  fg.Completed:Wait()
  Bm.SplashGui:Destroy()
  task_delay(0.2, function()
    Cn.IsMenuOpen = true
    Cn.isTweening = true
    Bm.MainFrame.Visible = true
    local Fg =
      TweenService:Create(Bm.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = Uj(0, tb, 0, Mq) })
    Fg:Play()
    Fg.Completed:Connect(function()
      Cn.isTweening = false
    end)
  end)
end)
Bm.TooltipGui = Instance.new("ScreenGui", Ae())
Bm.TooltipGui.Name = "Wyvern_Tooltip"
Bm.TooltipGui.DisplayOrder = 999
Bm.TooltipGui.IgnoreGuiInset = true
Bm.TooltipFrame = Instance.new("Frame", Bm.TooltipGui)
Bm.TooltipFrame.BackgroundColor3 = hg(15, 15, 25)
Bm.TooltipFrame.Visible = false
Instance.new("UICorner", Bm.TooltipFrame).CornerRadius = UDim_new(0, 6)
Bm.TooltipStroke = Instance.new("UIStroke", Bm.TooltipFrame)
Bm.TooltipStroke.Thickness = 1.5
Bm.TooltipText = Instance.new("TextLabel", Bm.TooltipFrame)
Bm.TooltipText.Size = Uj(1, -16, 1, -16)
Bm.TooltipText.Position = Uj(0, 8, 0, 8)
Bm.TooltipText.BackgroundTransparency = 1
Bm.TooltipText.TextColor3 = jw(1, 1, 1)
Bm.TooltipText.Font = Enum.Font.GothamMedium
Bm.TooltipText.TextSize = 12
Bm.TooltipText.TextXAlignment = Enum.TextXAlignment.Left
Bm.TooltipText.TextYAlignment = Enum.TextYAlignment.Top
Bm.MainFrame.InputBegan:Connect(function(Fq)
  if Fq.UserInputType == Enum.UserInputType.MouseButton1 or Fq.UserInputType == Enum.UserInputType.Touch then
    Cn.dragging = true
    Cn.dragStart = Fq.Position
    Cn.startPos = Bm.MainFrame.Position
  end
end)
Bm.MainFrame.InputEnded:Connect(function(_h)
  if not (_h.UserInputType == Enum.UserInputType.MouseButton1 or _h.UserInputType == Enum.UserInputType.Touch) then
  else
    Cn.dragging = false
  end
end)
UserInputService.InputChanged:Connect(function(na)
  if na.UserInputType == Enum.UserInputType.MouseMovement or na.UserInputType == Enum.UserInputType.Touch then
    Cn.dragInput = na
  end
  if Cn.dragging and Cn.dragInput then
    local Qc = Cn.dragInput.Position - Cn.dragStart
    Bm.MainFrame.Position = Uj(Cn.startPos.X.Scale, Cn.startPos.X.Offset + Qc.X, Cn.startPos.Y.Scale, Cn.startPos.Y.Offset + Qc.Y)
  end
end)
Bm.TopBar = Instance.new("Frame", Bm.MainFrame)
Bm.TopBar.Size = Uj(1, 0, 0, 45)
Bm.TopBar.BackgroundTransparency = 1
Bm.Title = Instance.new("TextLabel", Bm.TopBar)
Bm.Title.Text = "Wyvern Bloxstrike"
Bm.Title.Size = Uj(1, -60, 0.6, 0)
Bm.Title.Position = Uj(0, 15, 0, 5)
Bm.Title.BackgroundTransparency = 1
Bm.Title.TextColor3 = qb.MainColor
Bm.Title.Font = Enum.Font.GothamBlack
Bm.Title.TextSize = 16
Bm.Title.TextXAlignment = Enum.TextXAlignment.Left
Bm.GlobalWarnBox = Instance.new("Frame", Bm.TopBar)
Bm.GlobalWarnBox.Size = Uj(0, 24, 0, 24)
Bm.GlobalWarnBox.Position = Uj(0, 185, 0, 4)
Bm.GlobalWarnBox.BackgroundColor3 = qb.Panel
Bm.GlobalWarnBox.Visible = false
Instance.new("UICorner", Bm.GlobalWarnBox).CornerRadius = UDim_new(0, 4)
Bm.GlobalWarnStroke = Instance.new("UIStroke", Bm.GlobalWarnBox)
Bm.GlobalWarnStroke.Thickness = 1.5
Bm.GlobalWarnIcon = Instance.new("TextLabel", Bm.GlobalWarnBox)
Bm.GlobalWarnIcon.Size = Uj(1, 0, 1, 1)
Bm.GlobalWarnIcon.BackgroundTransparency = 1
Bm.GlobalWarnIcon.Text = "\195\162\197\161 \195\175\194\184\194\143"
Bm.GlobalWarnIcon.Font = Enum.Font.GothamBold
Bm.GlobalWarnIcon.TextSize = 14
Bm.GlobalWarnBox.MouseEnter:Connect(function()
  if #Cn.activeWarnings > 0 then
    Bm.TooltipFrame.Visible = true
  end
end)
Bm.GlobalWarnBox.MouseLeave:Connect(function()
  Bm.TooltipFrame.Visible = false
end)
task_spawn(function()
  while Bm.Title and Bm.Title.Parent do
    TweenService:Create(Bm.Title, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { TextColor3 = qb.AccentColor })
      :Play()
    task_wait(1.4)
    TweenService:Create(Bm.Title, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { TextColor3 = qb.MainColor })
      :Play()
    task_wait(1.4)
  end
end)
Bm.ExecLabel = Instance.new("TextLabel", Bm.TopBar)
Bm.ExecLabel.Text = "Running on: " .. as
Bm.ExecLabel.Size = Uj(1, -60, 0.4, 0)
Bm.ExecLabel.Position = Uj(0, 15, 0.6, 0)
Bm.ExecLabel.BackgroundTransparency = 1
Bm.ExecLabel.TextColor3 = qb.TextDim
Bm.ExecLabel.Font = Enum.Font.GothamMedium
Bm.ExecLabel.TextSize = 11
Bm.ExecLabel.TextXAlignment = Enum.TextXAlignment.Left
local function Sa(Xq)
  if not Cn.isTweening then
  else
    return
  end
  Cn.IsMenuOpen = Xq
  Cn.isTweening = true
  if Xq then
    Bm.MainFrame.Visible = true
    Bm.OpenMenuBtn.Visible = false
    local Hj =
      TweenService:Create(Bm.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = Uj(0, tb, 0, Mq) })
    Hj:Play()
    Hj.Completed:Connect(function()
      Cn.isTweening = false
    end)
  else
    local Xn =
      TweenService:Create(Bm.MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Size = Uj(0, 0, 0, 0) })
    Xn:Play()
    Xn.Completed:Connect(function()
      if not not Cn.IsMenuOpen then
      else
        Bm.MainFrame.Visible = false
        if not Wd.ShowWButton then
        else
          Bm.OpenMenuBtn.Visible = true
          TweenService
            :Create(Bm.OpenMenuBtn, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = Uj(0, 50, 0, 50) })
            :Play()
        end
      end
      Cn.isTweening = false
    end)
  end
end
h["ShowWButton"] = function(Ak)
  Wd.ShowWButton = Ak
  if not Cn.IsMenuOpen then
    Bm.OpenMenuBtn.Visible = Ak
    if Ak then
      Bm.OpenMenuBtn.Size = Uj(0, 50, 0, 50)
    end
  end
end
Bm.CloseBtn = Instance.new("TextButton", Bm.TopBar)
Bm.CloseBtn.Size = Uj(0, 30, 0, 30)
Bm.CloseBtn.Position = Uj(1, -35, 0.5, -15)
Bm.CloseBtn.BackgroundTransparency = 1
Bm.CloseBtn.Text = "X"
Bm.CloseBtn.TextColor3 = qb.AccentColor
Bm.CloseBtn.Font = Enum.Font.GothamBold
Bm.CloseBtn.TextSize = 18
Bm.CloseBtn.MouseButton1Click:Connect(function()
  Sa(false)
end)
Bm.OpenMenuBtn.MouseButton1Click:Connect(function()
  Sa(true)
end)
Bm.Line = Instance.new("Frame", Bm.MainFrame)
Bm.Line.Size = Uj(1, 0, 0, 1)
Bm.Line.Position = Uj(0, 0, 0, 45)
Bm.Line.BackgroundColor3 = qb.AccentColor
Bm.Line.BorderSizePixel = 0
Bm.Line.BackgroundTransparency = 0.5
Bm.TabBar = Instance.new("Frame", Bm.MainFrame)
Bm.TabBar.Size = Uj(1, 0, 0, 35)
Bm.TabBar.Position = Uj(0, 0, 0, 46)
Bm.TabBar.BackgroundTransparency = 1
Bm.TabContainer = Instance.new("Frame", Bm.MainFrame)
Bm.TabContainer.Size = Uj(1, -20, 1, -95)
Bm.TabContainer.Position = Uj(0, 10, 0, 85)
Bm.TabContainer.BackgroundTransparency = 1
Bm.ActiveTabIndicator = Instance.new("Frame", Bm.TabBar)
Bm.ActiveTabIndicator.Size = Uj(0.16666666666666666, 0, 0, 2)
Bm.ActiveTabIndicator.Position = Uj(0, 0, 1, -2)
Bm.ActiveTabIndicator.BackgroundColor3 = qb.MainColor
Bm.ActiveTabIndicator.BorderSizePixel = 0
local function Og(Bd)
  for xv, Bl in pairs(Bd:GetDescendants()) do
    if Bl:IsA("JointInstance") then
      local Bl_Part0, Bl_Part1 = Bl.Part0, Bl.Part1
      if Bl_Part0 and Bl_Part1 and Bl_Part0:IsA("BasePart") and Bl_Part1:IsA("BasePart") then
        pcall(function()
          Bl_Part1.CFrame = Bl_Part0.CFrame * Bl.C0 * Bl.C1:Inverse()
        end)
      end
    end
  end
end
local function Bi(cb)
  local Sk, Zj = nil, -1
  for Hu, uv in pairs(cb:GetDescendants()) do
    if not (uv:IsA("BasePart") and uv.Transparency < 0.95) then
    else
      local Dv = uv.Size.X * uv.Size.Y * uv.Size.Z
      if not (Dv > Zj) then
      else
        Zj = Dv
        Sk = uv
      end
    end
  end
  if not Sk then
    Sk = cb:FindFirstChildWhichIsA("BasePart", true)
  end
  if not not Sk then
  else
    return CFrame_new(), Ao(1, 1, 1)
  end
  local math_huge, math_huge, math_huge, Ql, qv, Xi, oo = math.huge, math.huge, math.huge, -math.huge, -math.huge, -math.huge, false
  for Pj, zs in pairs(cb:GetDescendants()) do
    if zs:IsA("BasePart") then
      if (zs.Position - Sk.Position).Magnitude > 15 then
        continue
      end
      if zs.Transparency >= 0.95 then
        continue
      end
      oo = true
      local zs_CFrame, Qq, Rv = zs.CFrame, zs.Size / 2, zs:FindFirstChildWhichIsA("SpecialMesh")
      if not Rv then
      else
        Qq = Qq * Rv.Scale
      end
      local Bp = {
        zs_CFrame * Ao(Qq.X, Qq.Y, Qq.Z),
        zs_CFrame * Ao(Qq.X, Qq.Y, -Qq.Z),
        zs_CFrame * Ao(Qq.X, -Qq.Y, Qq.Z),
        zs_CFrame * Ao(Qq.X, -Qq.Y, -Qq.Z),
        zs_CFrame * Ao(-Qq.X, Qq.Y, Qq.Z),
        zs_CFrame * Ao(-Qq.X, Qq.Y, -Qq.Z),
        zs_CFrame * Ao(-Qq.X, -Qq.Y, Qq.Z),
        zs_CFrame * Ao(-Qq.X, -Qq.Y, -Qq.Z),
      }
      for Wv, Wh in pairs(Bp) do
        if Wh.X < math_huge then
          math_huge = Wh.X
        end
        if Wh.Y < math_huge then
          math_huge = Wh.Y
        end
        if not (Wh.Z < math_huge) then
        else
          math_huge = Wh.Z
        end
        if not (Wh.X > Ql) then
        else
          Ql = Wh.X
        end
        if Wh.Y > qv then
          qv = Wh.Y
        end
        if Wh.Z > Xi then
          Xi = Wh.Z
        end
      end
    end
  end
  if not oo then
    return Sk.CFrame, Sk.Size
  end
  local Le, Pt = Ao((math_huge + Ql) / 2, (math_huge + qv) / 2, (math_huge + Xi) / 2), Ao(Ql - math_huge, qv - math_huge, Xi - math_huge)
  return CFrame_new(Le), Pt
end
local function ye(Td, Ca, yp)
  if not (not yp or yp == "Vanilla" or yp == "Stock") then
  else
    return
  end
  local ue = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Skins")
  if not not ue then
  else
    return
  end
  local jg = nil
  for Nr, De in pairs(ue:GetChildren()) do
    if string_lower(De.Name) == string_lower(Ca) then
      jg = De
      break
    end
  end
  if not jg then
    return
  end
  local mv = nil
  for lb, Lk in pairs(jg:GetChildren()) do
    if string_lower(Lk.Name) == string_lower(yp) then
      mv = Lk
      break
    end
  end
  if not not mv then
  else
    return
  end
  local Al = mv:FindFirstChild("Camera") or mv
  local Bt, il, bg = Al:FindFirstChild("Factory New") or Al:FindFirstChild("Minimal Wear") or Al, {}, nil
  for Cl, oa in pairs(Bt:GetChildren()) do
    if oa:IsA("SurfaceAppearance") or oa:IsA("Texture") or oa:IsA("Decal") then
      il[string_lower(oa.Name)] = oa
      if not (string_find(string_lower(oa.Name), "body") or string_find(string_lower(oa.Name), "main")) then
      else
        bg = oa
      end
    elseif oa:IsA("MeshPart") then
      il[string_lower(oa.Name)] = oa
    end
  end
  if not not bg then
  else
    for hi, vo in pairs(il) do
      bg = vo
      break
    end
  end
  for dh, jf in pairs(Td:GetDescendants()) do
    if not (jf:IsA("BasePart")) then
    else
      local Ss, c = il[string_lower(jf.Name)], false
      if not Ss then
        for oh, Xk in pairs(jf:GetChildren()) do
          if Xk:IsA("SurfaceAppearance") and il[string_lower(Xk.Name)] then
            Ss = il[string_lower(Xk.Name)]
            break
          end
        end
      end
      if not Ss and jf:IsA("MeshPart") then
        Ss = bg
        c = true
      end
      if not Ss then
      else
        for bl, W in pairs(jf:GetChildren()) do
          if not (W:IsA("SurfaceAppearance") or W:IsA("Texture") or W:IsA("Decal")) then
          else
            W:Destroy()
          end
        end
        if not (jf:IsA("MeshPart")) then
        else
          if not (Ss:IsA("MeshPart") and not c) then
          else
            jf.MeshId = Ss.MeshId
          end
          pcall(function()
            jf.TextureID = Ss.TextureID or ""
          end)
        end
        local dc = jf:FindFirstChildWhichIsA("SpecialMesh")
        if dc then
          local gw = Ss:FindFirstChildWhichIsA("SpecialMesh")
          if not (gw and not c) then
          else
            dc.MeshId = gw.MeshId
            dc.Scale = gw.Scale
            dc.Offset = gw.Offset
          end
          if gw then
            dc.TextureId = gw.TextureId
          else
            dc.TextureId = ""
          end
        end
        for bc, gb in pairs(Ss:GetChildren()) do
          if not (gb:IsA("SurfaceAppearance") or gb:IsA("Texture") or gb:IsA("Decal")) then
          else
            gb:Clone().Parent = jf
          end
        end
        if not (Ss:IsA("SurfaceAppearance") or Ss:IsA("Texture") or Ss:IsA("Decal")) then
        else
          Ss:Clone().Parent = jf
        end
      end
    end
  end
end
local function rp(Ru)
  return string.gsub(string.gsub(string_lower(Ru), "%-", ""), " ", "")
end
local function Tr(Ns, Jh)
  local ur = Bm.ViewportBG:FindFirstChild("Wyvern_Viewport")
  if ur then
    ur:Destroy()
  end
  if Cn.PreviewConnection then
    Cn.PreviewConnection:Disconnect()
    Cn.PreviewConnection = nil
  end
  local kf, Ll =
    string_find(string_lower(Ns), "sg 553") or string_find(string_lower(Ns), "aug") or string_find(string_lower(Ns), "berettas"),
    Bm.ViewportBG:FindFirstChild("WyvernPreviewWarning")
  if not kf then
    if Ll then
      Ll.Visible = false
    end
  else
    if not not Ll then
    else
      Ll = Instance.new("TextLabel", Bm.ViewportBG)
      Ll.Name = "WyvernPreviewWarning"
      Ll.Size = Uj(1, 0, 1, 0)
      Ll.Position = Uj(0, 0, 0, 0)
      Ll.BackgroundTransparency = 1
      Ll.TextColor3 = hg(255, 50, 50)
      Ll.Font = Enum.Font.GothamBlack
      Ll.TextSize = 13
      Ll.ZIndex = 10
      Ll.TextYAlignment = Enum.TextYAlignment.Center
    end
    Ll.Text = "\195\162\197\161 \195\175\194\184\194\143 "
      .. string_upper(Ns)
      .. " Not Working \195\162\197\161 \195\175\194\184\194\143\n\nSince the model of this weapon is corrupted,\npreview has been disabled.\nYou can select a skin."
    Ll.Visible = true
    return
  end
  local aa = Instance.new("ViewportFrame", Bm.ViewportBG)
  aa.Name = "Wyvern_Viewport"
  aa.Size = Uj(1, 0, 1, 0)
  aa.BackgroundTransparency = 1
  aa.LightColor = jw(1, 1, 1)
  aa.Ambient = jw(0.8, 0.8, 0.8)
  aa.ZIndex = 1
  local J = Instance.new("Camera")
  J.FieldOfView = 25
  aa.CurrentCamera = J
  J.Parent = aa
  local qt, Gr = nil, rp(Ns)
  for qh, Do in pairs(ReplicatedStorage:GetDescendants()) do
    if not (rp(Do.Name) == Gr and (Do:IsA("Model") or Do:IsA("Folder") or Do:IsA("MeshPart"))) then
    else
      if not (Do:FindFirstChildWhichIsA("BasePart", true)) then
      else
        qt = Do:Clone()
        break
      end
    end
  end
  if not qt then
    return
  end
  local gj = qt
  if not gj:IsA("Model") then
    gj = Instance.new("Model")
    gj.Name = Ns
    for En, Wm in ipairs(qt:GetChildren()) do
      Wm.Parent = gj
    end
  end
  local bt = string_find(string_lower(Ns), "glove") or string_find(string_lower(Ns), "wraps")
  for Pm, sv in pairs(gj:GetChildren()) do
    local Fd = string_lower(sv.Name)
    if Fd == "viewmodel" or Fd == "v_model" or Fd == "client" or Fd == "arms" then
      sv:Destroy()
    end
  end
  local Jv, hj =
    (string_find(string_lower(Ns), "dual") or string_find(string_lower(Ns), "daggers") or string_find(Gr, "berettas")) and 2 or 1, {}
  for eb, ca in pairs(gj:GetDescendants()) do
    if not (ca:IsA("BasePart")) then
      if
        ca:IsA("Script")
        or ca:IsA("LocalScript")
        or ca:IsA("Sound")
        or ca:IsA("ParticleEmitter")
        or ca:IsA("Light")
        or ca:IsA("Attachment")
      then
        ca:Destroy()
      end
    else
      local Wj, js = string_lower(ca.Name), ca.Parent and string_lower(ca.Parent.Name) or ""
      local Ui, zd =
        (string_find(Wj, "arm") and not string_find(Wj, "firearm"))
          or (string_find(Wj, "hand") and not string_find(Wj, "handle") and not string_find(Wj, "handguard"))
          or string_find(Wj, "sleeve"),
        (string_find(js, "arm") and not string_find(js, "firearm"))
          or (string_find(js, "hand") and not string_find(js, "handle") and not string_find(js, "handguard"))
          or string_find(js, "sleeve")
      local wu, It =
        Ui or zd,
        string_find(Wj, "hitbox")
          or string_find(Wj, "bounds")
          or string_find(Wj, "collision")
          or Wj == "humanoidrootpart"
          or Wj == "clipbox"
          or Wj == "root"
      if It or (wu and not bt) then
        ca:Destroy()
        continue
      end
      if ca.ClassName == "Part" and not bt then
        local ll = ca:FindFirstChildWhichIsA("DataModelMesh") or ca:FindFirstChildWhichIsA("SurfaceAppearance")
        if not not ll then
        else
          ca:Destroy()
          continue
        end
      end
      if not (ca.Transparency >= 0.95 and not bt) then
      else
        ca:Destroy()
        continue
      end
      local Ds = ""
      if not (ca:IsA("MeshPart")) then
      else
        Ds = ca.MeshId
      end
      local qa = ca:FindFirstChildWhichIsA("SpecialMesh")
      if not qa then
      else
        Ds = qa.MeshId
      end
      if Ds ~= "" then
        hj[Ds] = (hj[Ds] or 0) + 1
        if not (hj[Ds] > Jv) then
        else
          ca:Destroy()
        end
      end
    end
  end
  Og(gj)
  ye(gj, Ns, Jh)
  gj.Parent = aa
  local Bk, Cq = Bi(gj)
  local fq = math_max(Cq.X, Cq.Y, Cq.Z)
  if not (fq < 0.5) then
  else
    fq = 1.5
  end
  if not (fq > 8) then
  else
    fq = 6
  end
  local Fp = CFrame_new()
  if not bt then
    if not (math_abs(fq - Cq.Y) < 0.3) then
      if math_abs(fq - Cq.Z) < 0.3 then
        Fp = CFrame_Angles(0, math_rad(90), 0)
      end
    else
      Fp = CFrame_Angles(0, 0, math_rad(90))
    end
  else
    Fp = CFrame_Angles(0, math_rad(90), 0)
  end
  gj.WorldPivot = Bk
  gj:PivotTo(Fp)
  local db, sw, uq, nb, qu, dm = bt and (fq * 3.5) or (fq * 2.2), math_rad(-10), math_rad(-90), false, wv(), Instance.new("TextButton", aa)
  dm.Size = Uj(1, 0, 1, 0)
  dm.BackgroundTransparency = 1
  dm.Text = ""
  dm.ZIndex = 5
  dm.InputBegan:Connect(function(Iq)
    if Iq.UserInputType == Enum.UserInputType.MouseButton1 or Iq.UserInputType == Enum.UserInputType.Touch then
      nb = true
      qu = wv(Iq.Position.X, Iq.Position.Y)
    end
  end)
  UserInputService.InputEnded:Connect(function(Gf)
    if not (Gf.UserInputType == Enum.UserInputType.MouseButton1 or Gf.UserInputType == Enum.UserInputType.Touch) then
    else
      nb = false
    end
  end)
  UserInputService.InputChanged:Connect(function(Lh)
    if nb and (Lh.UserInputType == Enum.UserInputType.MouseMovement or Lh.UserInputType == Enum.UserInputType.Touch) then
      local tk = wv(Lh.Position.X, Lh.Position.Y)
      local Wt = tk - qu
      uq = uq - math_rad(Wt.X * 0.4)
      sw = math_clamp(sw - math_rad(Wt.Y * 0.4), math_rad(-85), math_rad(85))
      qu = tk
    elseif Lh.UserInputType == Enum.UserInputType.MouseWheel then
      local qr = Lh.Position.Z
      db = math_clamp(db - (qr * fq * 0.3), fq * 0.8, fq * 8)
    end
  end)
  Cn.PreviewConnection = RunService.RenderStepped:Connect(function(Af)
    if not aa.Parent then
      Cn.PreviewConnection:Disconnect()
      Cn.PreviewConnection = nil
      return
    end
    local Gi = CFrame_Angles(sw, uq, 0)
    J.CFrame = CFrame.lookAt(Gi * Ao(0, 0, db), Ao(0, 0, 0))
  end)
end
local function ki(fo_, Mu)
  local Z = Instance.new("TextButton", Bm.TabBar)
  Z.Size = Uj(0.16666666666666666, 0, 1, -2)
  Z.Position = Uj((Mu - 1) / 6, 0, 0, 0)
  Z.BackgroundTransparency = 1
  Z.Text = fo_
  Z.TextColor3 = Mu == 1 and qb.MainColor or qb.TextDim
  Z.Font = Enum.Font.GothamBold
  Z.TextSize = 11
  local rv = Instance.new("ScrollingFrame", Bm.TabContainer)
  rv.Size = Uj(1, 0, 1, 0)
  rv.BackgroundTransparency = 1
  rv.BorderSizePixel = 0
  rv.ScrollBarThickness = 2
  rv.ScrollBarImageColor3 = qb.MainColor
  rv.Visible = (Mu == 1)
  rv.AutomaticCanvasSize = Enum.AutomaticSize.Y
  local ts = Instance.new("UIListLayout", rv)
  ts.SortOrder = Enum.SortOrder.LayoutOrder
  ts.Padding = UDim_new(0, 8)
  Z.MouseButton1Click:Connect(function()
    for Cg, xp in pairs(Bm.TabContainer:GetChildren()) do
      if not (xp:IsA("ScrollingFrame") or xp:IsA("Frame")) then
      else
        xp.Visible = false
      end
    end
    for Vd, zb in pairs(Bm.TabBar:GetChildren()) do
      if zb:IsA("TextButton") then
        zb.TextColor3 = qb.TextDim
      end
    end
    rv.Visible = true
    Z.TextColor3 = qb.MainColor
    TweenService:Create(
      Bm.ActiveTabIndicator,
      TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
      { Position = Uj((Mu - 1) / 6, 0, 1, -2) }
    ):Play()
    if Mu == 3 or Mu == 4 or Mu == 5 then
      Bm.PreviewFrame.Visible = true
      if Mu == 3 and Cn.TargetGun then
        Tr(Cn.TargetGun, Cn.TargetGunSkin or "Vanilla")
      end
      if not (Mu == 4 and Cn.TargetKnife) then
      else
        Tr(Cn.TargetKnife, Cn.TargetSkin or "Vanilla")
      end
      if not (Mu == 5 and Cn.TargetGlove) then
      else
        Tr(Cn.TargetGlove, Cn.TargetSkinGlove == "" and "Vanilla" or Cn.TargetSkinGlove)
      end
    else
      Bm.PreviewFrame.Visible = false
    end
  end)
  return rv
end
local function Hr(C, gg, Ta)
  local Nq = Instance.new("TextButton", C)
  Nq.Size = Uj(1, 0, 0, 32)
  Nq.BackgroundColor3 = qb.Panel
  Nq.BackgroundTransparency = 0.7
  Nq.BorderSizePixel = 0
  Nq.Text = ""
  Instance.new("UICorner", Nq).CornerRadius = UDim_new(0, 4)
  local uc = Instance.new("Frame", Nq)
  uc.Size = Uj(0, 18, 0, 18)
  uc.Position = Uj(0, 10, 0.5, -9)
  uc.BackgroundColor3 = Wd[Ta] and qb.MainColor or hg(20, 20, 30)
  Instance.new("UICorner", uc).CornerRadius = UDim_new(0, 4)
  local xe = Instance.new("UIStroke", uc)
  xe.Color = Wd[Ta] and qb.MainColor or qb.AccentColor
  xe.Thickness = 1.5
  local _j = Instance.new("TextLabel", Nq)
  _j.Text = gg
  _j.Size = Uj(1, -40, 1, 0)
  _j.Position = Uj(0, 38, 0, 0)
  _j.BackgroundTransparency = 1
  _j.TextColor3 = Wd[Ta] and qb.Text or qb.TextDim
  _j.Font = Enum.Font.GothamMedium
  _j.TextSize = 13
  _j.TextXAlignment = Enum.TextXAlignment.Left
  h[Ta] = function(Ep)
    Wd[Ta] = Ep
    TweenService:Create(uc, TweenInfo.new(0.18, Enum.EasingStyle.Quad), { BackgroundColor3 = Ep and qb.MainColor or hg(20, 20, 30) }):Play()
    xe.Color = Wd[Ta] and qb.MainColor or qb.AccentColor
    _j.TextColor3 = Wd[Ta] and qb.Text or qb.TextDim
    ud()
  end
  Nq.MouseButton1Click:Connect(function()
    h[Ta](not Wd[Ta])
  end)
end
local function Lm(uj, Sd, ra, ve, E)
  local Eg = Instance.new("Frame", uj)
  Eg.Size = Uj(1, 0, 0, 45)
  Eg.BackgroundColor3 = qb.Panel
  Eg.BackgroundTransparency = 0.7
  Eg.BorderSizePixel = 0
  Instance.new("UICorner", Eg).CornerRadius = UDim_new(0, 4)
  local Ij = Instance.new("TextLabel", Eg)
  Ij.Text = Sd
  Ij.Size = Uj(1, -20, 0, 20)
  Ij.Position = Uj(0, 10, 0, 5)
  Ij.BackgroundTransparency = 1
  Ij.TextColor3 = qb.Text
  Ij.Font = Enum.Font.GothamMedium
  Ij.TextSize = 13
  Ij.TextXAlignment = Enum.TextXAlignment.Left
  local nq = Instance.new("TextLabel", Eg)
  nq.Text = tostring(Wd[E])
  nq.Size = Uj(0, 40, 0, 20)
  nq.Position = Uj(1, -50, 0, 5)
  nq.BackgroundTransparency = 1
  nq.TextColor3 = qb.MainColor
  nq.Font = Enum.Font.GothamBold
  nq.TextSize = 13
  nq.TextXAlignment = Enum.TextXAlignment.Right
  local Yn = Instance.new("Frame", Eg)
  Yn.Size = Uj(1, -20, 0, 4)
  Yn.Position = Uj(0, 10, 0, 32)
  Yn.BackgroundColor3 = hg(20, 20, 30)
  Yn.BorderSizePixel = 0
  Instance.new("UICorner", Yn).CornerRadius = UDim_new(1, 0)
  local Tf = tonumber(Wd[E]) or ra
  local Lj, Mt = math_clamp((Tf - ra) / (ve - ra), 0, 1), Instance.new("Frame", Yn)
  Mt.Size = Uj(Lj, 0, 1, 0)
  Mt.BackgroundColor3 = qb.MainColor
  Mt.BorderSizePixel = 0
  Instance.new("UICorner", Mt).CornerRadius = UDim_new(1, 0)
  local th_ = Instance.new("TextButton", Yn)
  th_.Size = Uj(1, 0, 1, 10)
  th_.Position = Uj(0, 0, 0.5, -5)
  th_.BackgroundTransparency = 1
  th_.Text = ""
  h[E] = function(bf)
    Wd[E] = bf
    local pn = tonumber(bf) or ra
    local Ur = math_clamp((pn - ra) / (ve - ra), 0, 1)
    Mt.Size = Uj(Ur, 0, 1, 0)
    nq.Text = tostring(bf)
    ud()
  end
  local pi = false
  local function mn(vu)
    local Ff = math_clamp((vu.Position.X - Yn.AbsolutePosition.X) / Yn.AbsoluteSize.X, 0, 1)
    Mt.Size = Uj(Ff, 0, 1, 0)
    local ng = (ve - ra) * Ff + ra
    local Rj
    if (ve - ra) <= 10 then
      Rj = math_floor(ng * 10) / 10
    else
      Rj = math_floor(ng)
    end
    Wd[E] = Rj
    nq.Text = tostring(Rj)
    ud()
  end
  th_.InputBegan:Connect(function(Lt)
    if Lt.UserInputType == Enum.UserInputType.MouseButton1 or Lt.UserInputType == Enum.UserInputType.Touch then
      pi = true
      mn(Lt)
    end
  end)
  UserInputService.InputEnded:Connect(function(Vh)
    if Vh.UserInputType == Enum.UserInputType.MouseButton1 or Vh.UserInputType == Enum.UserInputType.Touch then
      pi = false
    end
  end)
  UserInputService.InputChanged:Connect(function(Fb)
    if not (pi and (Fb.UserInputType == Enum.UserInputType.MouseMovement or Fb.UserInputType == Enum.UserInputType.Touch)) then
    else
      mn(Fb)
    end
  end)
end
local function bk(mh, Ba, X)
  local a_ = Instance.new("Frame", mh)
  a_.Size = Uj(1, 0, 0, 32)
  a_.BackgroundColor3 = qb.Panel
  a_.BackgroundTransparency = 0.7
  a_.BorderSizePixel = 0
  Instance.new("UICorner", a_).CornerRadius = UDim_new(0, 4)
  local lv = Instance.new("TextLabel", a_)
  lv.Text = Ba
  lv.Size = Uj(0.6, 0, 1, 0)
  lv.Position = Uj(0, 10, 0, 0)
  lv.BackgroundTransparency = 1
  lv.TextColor3 = qb.Text
  lv.Font = Enum.Font.GothamMedium
  lv.TextSize = 13
  lv.TextXAlignment = Enum.TextXAlignment.Left
  local ia = Instance.new("TextButton", a_)
  ia.Size = Uj(0, 100, 0, 24)
  ia.Position = Uj(1, -110, 0.5, -12)
  ia.BackgroundColor3 = hg(20, 20, 30)
  ia.BackgroundTransparency = 0.2
  ia.Text = (Wd[X] and Wd[X].Name) or "Unknown"
  ia.TextColor3 = qb.AccentColor
  ia.Font = Enum.Font.GothamBold
  ia.TextSize = 12
  Instance.new("UICorner", ia).CornerRadius = UDim_new(0, 4)
  h[X] = function(ae)
    Wd[X] = ae
    ia.Text = ae.Name
  end
  local Gp = false
  ia.MouseButton1Click:Connect(function()
    if not Gp then
    else
      return
    end
    Gp = true
    ia.Text = "..."
    task_delay(0.2, function()
      local Vj
      Vj = UserInputService.InputBegan:Connect(function(Qf)
        if not (Qf.UserInputType == Enum.UserInputType.Keyboard and Qf.KeyCode ~= Enum.KeyCode.Unknown) then
          if Qf.UserInputType == Enum.UserInputType.MouseButton2 or Qf.UserInputType == Enum.UserInputType.MouseButton3 then
            h[X](Qf.UserInputType)
            Gp = false
            Vj:Disconnect()
          end
        else
          h[X](Qf.KeyCode)
          Gp = false
          Vj:Disconnect()
        end
      end)
    end)
  end)
end
local function Ch(b_, Lo, up, Ht)
  local Nt = Instance.new("TextButton", b_)
  Nt.Size = Uj(1, 0, 0, 32)
  Nt.BackgroundColor3 = qb.Panel
  Nt.BackgroundTransparency = 0.7
  Nt.BorderSizePixel = 0
  Nt.Text = Lo
  Nt.TextColor3 = qb.MainColor
  Nt.Font = Enum.Font.GothamBold
  Nt.TextSize = 13
  Instance.new("UICorner", Nt).CornerRadius = UDim_new(0, 4)
  local xc = Instance.new("UIStroke", Nt)
  xc.Color = qb.AccentColor
  xc.Thickness = 1.5
  Nt.MouseButton1Click:Connect(function()
    if not Ht then
    else
      Ht()
    end
    if up then
      local Nt_Text = Nt.Text
      Nt.Text = up
      Nt.TextColor3 = hg(0, 255, 0)
      task_delay(1, function()
        Nt.Text = Nt_Text
        Nt.TextColor3 = qb.MainColor
      end)
    end
  end)
  return Nt
end
local function dl(wm, Yd)
  local Qd = Instance.new("TextLabel", wm)
  Qd.Size = Uj(1, 0, 0, 20)
  Qd.BackgroundTransparency = 1
  Qd.Text = "- " .. Yd .. " -"
  Qd.TextColor3 = qb.AccentColor
  Qd.Font = Enum.Font.GothamBold
  Qd.TextSize = 12
end
local function be(gp, xo, Za, V)
  local cq, Yr, Sb = false, false, Instance.new("Frame", gp)
  Sb.Size = Uj(1, 0, 0, 32)
  Sb.BackgroundTransparency = 1
  Sb.BorderSizePixel = 0
  Sb.ClipsDescendants = false
  local Oe = Instance.new("TextButton", Sb)
  Oe.Size = Uj(1, 0, 0, 32)
  Oe.BackgroundColor3 = qb.Panel
  Oe.BackgroundTransparency = 0.7
  Oe.BorderSizePixel = 0
  Oe.Text = ""
  Instance.new("UICorner", Oe).CornerRadius = UDim_new(0, 4)
  local Oq = Instance.new("UIStroke", Oe)
  Oq.Color = qb.AccentColor
  Oq.Thickness = 1
  Oq.Transparency = 0.7
  local Gq = Instance.new("TextLabel", Oe)
  Gq.Size = Uj(1, -40, 1, 0)
  Gq.Position = Uj(0, 10, 0, 0)
  Gq.BackgroundTransparency = 1
  Gq.Text = xo .. ": " .. tostring(Wd[V])
  Gq.TextColor3 = qb.Text
  Gq.Font = Enum.Font.GothamMedium
  Gq.TextSize = 13
  Gq.TextXAlignment = Enum.TextXAlignment.Left
  local hu = Instance.new("TextLabel", Oe)
  hu.Size = Uj(0, 28, 1, 0)
  hu.Position = Uj(1, -30, 0, 0)
  hu.BackgroundTransparency = 1
  hu.Text = "v"
  hu.TextColor3 = qb.AccentColor
  hu.Font = Enum.Font.GothamBold
  hu.TextSize = 12
  local Kk = Instance.new("Frame", Bm.ScreenGui)
  Kk.BackgroundColor3 = qb.Background
  Kk.BackgroundTransparency = 0.04
  Kk.BorderSizePixel = 0
  Kk.Visible = false
  Kk.ZIndex = 50
  Kk.ClipsDescendants = true
  Kk.Size = Uj(0, 0, 0, 0)
  Instance.new("UICorner", Kk).CornerRadius = UDim_new(0, 6)
  local ks = Instance.new("UIStroke", Kk)
  ks.Color = qb.AccentColor
  ks.Thickness = 1.5
  ks.Transparency = 0.4
  local ls = Instance.new("UIListLayout", Kk)
  ls.SortOrder = Enum.SortOrder.LayoutOrder
  ls.Padding = UDim_new(0, 0)
  local Xh = #Za * 28
  h[V] = function(cg)
    Wd[V] = cg
    Gq.Text = xo .. ": " .. tostring(cg)
  end
  local function Rg()
    return Uj(0, Oe.AbsolutePosition.X, 0, Oe.AbsolutePosition.Y + Oe.AbsoluteSize.Y + 2), Uj(0, Oe.AbsoluteSize.X, 0, Xh)
  end
  for vs, Ft in ipairs(Za) do
    local Uq = Instance.new("TextButton", Kk)
    Uq.Size = Uj(1, 0, 0, 28)
    Uq.BackgroundColor3 = Wd[V] == Ft and qb.Panel or qb.Background
    Uq.BackgroundTransparency = Wd[V] == Ft and 0.2 or 0.5
    Uq.BorderSizePixel = 0
    Uq.Text = Ft
    Uq.TextColor3 = Wd[V] == Ft and qb.MainColor or qb.TextDim
    Uq.Font = Enum.Font.GothamMedium
    Uq.TextSize = 12
    Uq.ZIndex = 51
    Uq.LayoutOrder = vs
    if not (vs < #Za) then
    else
      local Dp = Instance.new("Frame", Uq)
      Dp.Size = Uj(1, -16, 0, 1)
      Dp.Position = Uj(0, 8, 1, -1)
      Dp.BackgroundColor3 = qb.AccentColor
      Dp.BackgroundTransparency = 0.8
      Dp.BorderSizePixel = 0
      Dp.ZIndex = 52
    end
    Uq.MouseEnter:Connect(function()
      if Wd[V] ~= Ft then
        Uq.TextColor3 = qb.Text
        Uq.BackgroundTransparency = 0.3
      end
    end)
    Uq.MouseLeave:Connect(function()
      if Wd[V] ~= Ft then
        Uq.TextColor3 = qb.TextDim
        Uq.BackgroundTransparency = 0.5
      end
    end)
    Uq.MouseButton1Click:Connect(function()
      h[V](Ft)
      for wf, yq in pairs(Kk:GetChildren()) do
        if yq:IsA("TextButton") then
          yq.TextColor3 = qb.TextDim
          yq.BackgroundTransparency = 0.5
          yq.BackgroundColor3 = qb.Background
        end
      end
      Uq.TextColor3 = qb.MainColor
      Uq.BackgroundTransparency = 0.2
      Uq.BackgroundColor3 = qb.Panel
      cq = false
      Yr = true
      hu.Text = "v"
      Oq.Transparency = 0.7
      local ql, jd = Rg()
      local la =
        TweenService:Create(Kk, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Size = Uj(0, jd.X.Offset, 0, 0) })
      la:Play()
      la.Completed:Connect(function()
        Kk.Visible = false
        Yr = false
      end)
    end)
  end
  Oe.MouseButton1Click:Connect(function()
    if Yr then
      return
    end
    Yr = true
    cq = not cq
    local ah, rq = Rg()
    if cq then
      Kk.Position = ah
      Kk.Size = Uj(0, rq.X.Offset, 0, 0)
      Kk.Visible = true
      hu.Text = "^"
      Oq.Transparency = 0.2
      local qo = TweenService:Create(Kk, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = rq })
      qo:Play()
      qo.Completed:Connect(function()
        Yr = false
      end)
    else
      hu.Text = "v"
      Oq.Transparency = 0.7
      local lo_ =
        TweenService:Create(Kk, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Size = Uj(0, rq.X.Offset, 0, 0) })
      lo_:Play()
      lo_.Completed:Connect(function()
        Kk.Visible = false
        Yr = false
      end)
    end
  end)
  RunService.RenderStepped:Connect(function()
    if not (cq and Kk.Visible) then
    else
      local Si, Zo = Rg()
      Kk.Position = Si
      local yf = Oe:FindFirstAncestorWhichIsA("ScrollingFrame")
      if yf then
        local kw, mw = Oe.AbsolutePosition.Y, yf.AbsolutePosition.Y
        local zk = mw + yf.AbsoluteSize.Y
        if not (kw < mw or kw + 32 > zk) then
          Kk.Visible = true
        else
          Kk.Visible = false
        end
      end
    end
  end)
  return Sb
end
Bm.PageCombat = ki("COMBAT", 1)
Bm.PageVisuals = ki("VISUALS", 2)
Bm.PageGunSkins = ki("GUN SKINS", 3)
Bm.PageKnife = ki("KNIVES", 4)
Bm.PageGlove = ki("GLOVES", 5)
Bm.PageMisc = ki("MISC", 6)
dl(Bm.PageCombat, "RAGE BOT (RISKY)")
Hr(Bm.PageCombat, "Master Rage Mode", "RageMode")
bk(Bm.PageCombat, "Rage Toggle Key", "RageKey")
if not (ii_LocalPlayer.UserId == 3839175996) then
else
  Hr(Bm.PageCombat, "Kill All (Knife Aura)", "KillAll")
end
dl(Bm.PageCombat, "SILENT AIM & SMART TARGET")
if not T then
else
  local Oo = Instance.new("TextLabel", Bm.PageCombat)
  Oo.Size = Uj(1, 0, 0, 20)
  Oo.BackgroundTransparency = 1
  Oo.Text = "Xeno / Solara Does Not Support Silent Aim"
  Oo.TextColor3 = hg(255, 50, 50)
  Oo.Font = Enum.Font.GothamBold
  Oo.TextSize = 11
end
Hr(Bm.PageCombat, "Enable Silent Aim", "SilentEnabled")
Hr(Bm.PageCombat, "Auto Shoot (With Silent Aim)", "AutoShoot")
bk(Bm.PageCombat, "Toggle Keybind", "SilentAimToggleKey")
Hr(Bm.PageCombat, "Smart Target Prioritization", "SmartTargeting")
Hr(Bm.PageCombat, "Show FOV Circle", "ShowFOV")
Lm(Bm.PageCombat, "FOV Size", 50, 1000, "FOV")
Hr(Bm.PageCombat, "Wallbang", "Wallbang")
bk(Bm.PageCombat, "Wallbang Toggle Key", "WallbangToggleKey")
Hr(Bm.PageCombat, "Dynamic Miss (Humanized)", "DynamicMiss")
Lm(Bm.PageCombat, "Base Hit Chance (%)", 1, 100, "HitChance")
Lm(Bm.PageCombat, "Spread (0=None, 100=Normal)", 0, 100, "Spread")
dl(Bm.PageCombat, "ANTI-SPECTATOR")
Hr(Bm.PageCombat, "Disable Aim When Spectated", "AntiSpecEnable")
be(Bm.PageCombat, "Disable Mode", { "Silent Aim", "Aimlock", "Both" }, "AntiSpecMode")
dl(Bm.PageCombat, "WEAPON MODS")
Hr(Bm.PageCombat, "Enable Rapid Fire", "RapidFire")
Lm(Bm.PageCombat, "Rapid Fire Delay (ms)", 0, 500, "RapidFireDelay")
Hr(Bm.PageCombat, "Auto Clicker (Pistols/Snipers)", "AutoClicker")
Lm(Bm.PageCombat, "Auto Click Delay (ms)", 10, 500, "AutoClickerDelay")
Hr(Bm.PageCombat, "Enable Instant Reload", "InstaReload")
Hr(Bm.PageCombat, "Enable Insta Equip", "InstaEquip")
dl(Bm.PageCombat, "TARGETING")
local Xo = { "Head", "UpperTorso", "LowerTorso", "RightUpperArm", "LeftUpperArm", "RightUpperLeg", "LeftUpperLeg" }
be(Bm.PageCombat, "Target Part", Xo, "TargetPartMode")
Hr(Bm.PageCombat, "Random Parts", "RandomParts")
Hr(Bm.PageCombat, "360 FOV (All Directions)", "FullFOV360")
Hr(Bm.PageCombat, "Aim Wall Check", "AimWallCheck")
Hr(Bm.PageCombat, "Team Check", "TeamCheck")
dl(Bm.PageCombat, "TRIGGER BOT")
Hr(Bm.PageCombat, "Enable Trigger Bot", "TriggerBot")
bk(Bm.PageCombat, "Toggle Keybind", "TriggerKey")
Lm(Bm.PageCombat, "Delay (ms)", 0, 500, "TriggerDelay")
dl(Bm.PageCombat, "AIM ASSIST")
Hr(Bm.PageCombat, "Enable Aimlock", "Aimlock")
bk(Bm.PageCombat, "Toggle Keybind", "AimlockToggleKey")
bk(Bm.PageCombat, "Aimlock Hold Key", "AimKey")
be(Bm.PageCombat, "Aimlock Method", { "Raw Mouse", "Smooth Mouse" }, "AimMethod")
Lm(Bm.PageCombat, "Aimlock FOV Size", 10, 1000, "AimFOV")
Lm(Bm.PageCombat, "Aim Smoothness", 1, 20, "AimSmoothness")
Lm(Bm.PageCombat, "Aim Jitter (Randomize)", 0, 50, "AimJitter")
Hr(Bm.PageCombat, "Flick Bot", "FlickBot")
dl(Bm.PageCombat, "HITBOX EXPANDER")
Hr(Bm.PageCombat, "Enable Hitbox", "HitboxExpander")
bk(Bm.PageCombat, "Toggle Keybind", "HitboxToggleKey")
Lm(Bm.PageCombat, "Hitbox Size", 1, 3, "HitboxSize")
Lm(Bm.PageCombat, "Hitbox Transparency (%)", 0, 100, "HitboxTransparency")
dl(Bm.PageVisuals, "ESP VISUALS")
Hr(Bm.PageVisuals, "Enable Master ESP", "ESP")
bk(Bm.PageVisuals, "Toggle Keybind", "ESPToggleKey")
be(Bm.PageVisuals, "Enemy ESP Color", { "Red", "Green", "Blue", "Yellow", "Cyan", "Magenta", "White", "Orange" }, "EnemyESPColor")
be(Bm.PageVisuals, "Team ESP Color", { "Cyan", "Green", "Blue", "Yellow", "Red", "Magenta", "White", "Orange" }, "TeamESPColor")
Hr(Bm.PageVisuals, "Boxes", "Box")
Hr(Bm.PageVisuals, "3D Box Mode", "Box3D")
Hr(Bm.PageVisuals, "Skeleton ESP", "Skeleton")
Hr(Bm.PageVisuals, "Smart Visible Chams", "SmartPartESP")
Hr(Bm.PageVisuals, "Backtrack Chams", "BacktrackChams")
Hr(Bm.PageVisuals, "Name ESP", "Name")
Hr(Bm.PageVisuals, "Distance ESP", "Distance")
Hr(Bm.PageVisuals, "Money ESP", "MoneyESP")
Hr(Bm.PageVisuals, "Weapon Name ESP", "WeaponNameESP")
Hr(Bm.PageVisuals, "HP Bar ESP", "HPBar")
Hr(Bm.PageVisuals, "Chams (Glow)", "Chams")
Hr(Bm.PageVisuals, "Tracers", "Tracers")
Hr(Bm.PageVisuals, "View Tracers", "ViewTracers")
Lm(Bm.PageVisuals, "Trace Length", 5, 50, "ViewTracerLength")
Hr(Bm.PageVisuals, "Show Teammates", "ShowTeam")
Hr(Bm.PageVisuals, "Team Colors (Auto)", "TeamColors")
dl(Bm.PageVisuals, "VIEWMODEL (HANDS)")
Hr(Bm.PageVisuals, "Enable Viewmodel Chams", "VMChams")
be(Bm.PageVisuals, "VM Chams Color", { "White", "Red", "Green", "Blue", "Yellow", "Cyan", "Magenta" }, "VMChamsColor")
Hr(Bm.PageVisuals, "Rainbow Viewmodel", "RainbowVM")
Lm(Bm.PageVisuals, "VM Chams Transparency (%)", 0, 100, "VMChamsTransparency")
dl(Bm.PageVisuals, "WORLD MODS")
Hr(Bm.PageVisuals, "Night Mode", "NightMode")
bk(Bm.PageVisuals, "Toggle Keybind", "NightModeKey")
Hr(Bm.PageVisuals, "Low GFX (FPS Boost)", "LowGFX")
Cn.oldLowGFXUpdater = h["LowGFX"]
h["LowGFX"] = function(rk)
  Cn.oldLowGFXUpdater(rk)
  if rk then
    zo.Lighting.GlobalShadows = Lighting.GlobalShadows
    Lighting.GlobalShadows = false
    for tg, Gc in pairs(Workspace:GetDescendants()) do
      if Gc:IsDescendantOf(Vm_CurrentCamera) or (Gc.Parent and Gc.Parent:FindFirstChild("Humanoid")) then
        continue
      end
      if Gc:IsA("BasePart") then
        zo.Materials[Gc] = Gc.Material
        zo.Reflectance[Gc] = Gc.Reflectance
        Gc.Material = Enum.Material.SmoothPlastic
        Gc.Reflectance = 0
      elseif Gc:IsA("Decal") or Gc:IsA("Texture") then
        zo.Textures[Gc] = Gc.Transparency
        Gc.Transparency = 1
      end
    end
  else
    if not (zo.Lighting.GlobalShadows ~= nil) then
    else
      Lighting.GlobalShadows = zo.Lighting.GlobalShadows
    end
    for lf, Es in pairs(zo.Materials) do
      if lf and lf.Parent then
        lf.Material = Es
      end
    end
    for Aj, jm in pairs(zo.Reflectance) do
      if not (Aj and Aj.Parent) then
      else
        Aj.Reflectance = jm
      end
    end
    for hn, Tj in pairs(zo.Textures) do
      if hn and hn.Parent then
        hn.Transparency = Tj
      end
    end
    table_clear(zo.Materials)
    table_clear(zo.Reflectance)
    table_clear(zo.Textures)
  end
end
dl(Bm.PageVisuals, "VISUAL MODS")
Hr(Bm.PageVisuals, "Anti-Flash", "AntiFlash")
Hr(Bm.PageVisuals, "Anti-Smoke", "AntiSmoke")
Hr(Bm.PageVisuals, "Show Spectators", "Spectators")
task_spawn(function()
  Bm.SpecGui = Instance.new("ScreenGui")
  Bm.SpecGui.Name = "Wyvern_Spectators"
  Bm.SpecGui.ResetOnSpawn = false
  Bm.SpecGui.Parent = Ae()
  Bm.SpecFrame = Instance.new("Frame", Bm.SpecGui)
  Bm.SpecFrame.Size = Uj(0, 150, 0, 30)
  Bm.SpecFrame.Position = Uj(0.5, -75, 0, 10)
  Bm.SpecFrame.BackgroundColor3 = qb.Background
  Bm.SpecFrame.BackgroundTransparency = 0.2
  Bm.SpecFrame.Visible = false
  Instance.new("UICorner", Bm.SpecFrame).CornerRadius = UDim_new(0, 6)
  Bm.SpecStroke = Instance.new("UIStroke", Bm.SpecFrame)
  Bm.SpecStroke.Color = qb.MainColor
  Bm.SpecStroke.Thickness = 1.5
  Bm.SpecLabel = Instance.new("TextLabel", Bm.SpecFrame)
  Bm.SpecLabel.Size = Uj(1, 0, 1, 0)
  Bm.SpecLabel.BackgroundTransparency = 1
  Bm.SpecLabel.Text = "Spectators: 0"
  Bm.SpecLabel.TextColor3 = qb.Text
  Bm.SpecLabel.Font = Enum.Font.GothamBold
  Bm.SpecLabel.TextSize = 12
  Bm.SpecLabel.TextXAlignment = Enum.TextXAlignment.Center
  while task_wait(0.5) do
    local Dm = 0
    if not ii_LocalPlayer then
    else
      local Ed = ii_LocalPlayer:GetAttribute("Spectators")
      if not (type(Ed) == "number") then
        local Fv = ii_LocalPlayer:FindFirstChild("Spectators")
        if Fv and Fv:IsA("IntValue") then
          Dm = Fv.Value
        end
      else
        Dm = Ed
      end
    end
    Cn.SpecCount = Dm
    if not Wd.Spectators then
      Bm.SpecFrame.Visible = false
    else
      Bm.SpecLabel.Text = "Spectators: " .. tostring(Dm)
      Bm.SpecFrame.Visible = true
    end
  end
end)
local function Nm(Wo)
  if not (not Wo:IsA("BasePart")) then
  else
    return
  end
  pcall(function()
    Wo.LocalTransparencyModifier = 1
    Wo.CastShadow = false
  end)
  for Us, Ek in pairs(Wo:GetDescendants()) do
    if not (Ek:IsA("ParticleEmitter") or Ek:IsA("Smoke") or Ek:IsA("Fire") or Ek:IsA("Sparkles") or Ek:IsA("Trail") or Ek:IsA("Beam")) then
    else
      pcall(function()
        Ek:Destroy()
      end)
    end
  end
  Wo.DescendantAdded:Connect(function(Ze)
    if not not Wd.AntiSmoke then
    else
      return
    end
    if not (Ze:IsA("ParticleEmitter") or Ze:IsA("Smoke") or Ze:IsA("Fire") or Ze:IsA("Sparkles") or Ze:IsA("Trail") or Ze:IsA("Beam")) then
    else
      pcall(function()
        Ze:Destroy()
      end)
    end
  end)
end
local function nh(sk)
  if not not (sk:IsA("Folder") and string_find(sk.Name, "VoxelSmoke")) then
  else
    return
  end
  for ko, in_ in pairs(sk:GetChildren()) do
    Nm(in_)
  end
  local jl = sk.ChildAdded:Connect(function(Bs)
    if Wd.AntiSmoke then
      Nm(Bs)
    end
  end)
  table_insert(Cn.smokeConnections, jl)
end
local function jc()
  local Ec = Workspace:WaitForChild("Debris", 10)
  if not Ec then
    return
  end
  for Dd, Ld in pairs(Ec:GetChildren()) do
    nh(Ld)
  end
  local Qj = Ec.ChildAdded:Connect(function(ma)
    if Wd.AntiSmoke then
      nh(ma)
    end
  end)
  table_insert(Cn.smokeConnections, Qj)
end
local function ew()
  for Mh, tl in pairs(Cn.smokeConnections) do
    pcall(function()
      tl:Disconnect()
    end)
  end
  table_clear(Cn.smokeConnections)
end
local vf = h["AntiSmoke"]
h["AntiSmoke"] = function(Jj)
  vf(Jj)
  if not Jj then
    ew()
  else
    task_spawn(jc)
  end
end
dl(Bm.PageVisuals, "DEBRIS ESP")
Hr(Bm.PageVisuals, "Weapon ESP", "WeaponESP")
Hr(Bm.PageVisuals, "C4 ESP", "C4ESP")
Hr(Bm.PageVisuals, "Bullet Tracers", "BulletTracers")
be(Bm.PageVisuals, "Tracer Color", { "Yellow", "Red", "Blue", "White", "Purple" }, "TracerColor")
Hr(Bm.PageVisuals, "Bomb Trail (2D)", "BombTrail")
dl(Bm.PageVisuals, "CAMERA & TPS")
Hr(Bm.PageVisuals, "Third Person (TPS)", "TPS")
bk(Bm.PageVisuals, "Toggle Keybind", "TPSKey")
Lm(Bm.PageVisuals, "TPS Distance", 5, 25, "TPSDistance")
dl(Bm.PageMisc, "HIT FEEDBACK")
Hr(Bm.PageMisc, "Show Hitmarker", "Hitmarker")
Lm(Bm.PageMisc, "Hitmarker Duration (ms)", 100, 2000, "HitmarkerDuration")
Hr(Bm.PageMisc, "Damage Indicator", "DamageIndicator")
Hr(Bm.PageMisc, "Enable Hit Sound", "HitSound")
be(
  Bm.PageMisc,
  "Sound Type",
  { "Sound 1", "Sound 2", "Sound 3", "Sound 4", "Sound 5", "Sound 6", "Sound 7", "Sound 8", "Custom" },
  "HitSoundID"
)
Bm.CustomSoundBox = Instance.new("TextBox", Bm.PageMisc)
Bm.CustomSoundBox.Size = Uj(1, 0, 0, 32)
Bm.CustomSoundBox.BackgroundColor3 = qb.Panel
Bm.CustomSoundBox.BackgroundTransparency = 0.7
Bm.CustomSoundBox.TextColor3 = qb.Text
Bm.CustomSoundBox.PlaceholderText = "Enter Custom Sound ID..."
Bm.CustomSoundBox.Font = Enum.Font.GothamMedium
Bm.CustomSoundBox.TextSize = 13
Bm.CustomSoundBox.Text = Wd.CustomHitSoundID or "131051026960528"
Instance.new("UICorner", Bm.CustomSoundBox).CornerRadius = UDim_new(0, 4)
Bm.CSoundStroke = Instance.new("UIStroke", Bm.CustomSoundBox)
Bm.CSoundStroke.Color = qb.AccentColor
Bm.CSoundStroke.Thickness = 1
Bm.CustomSoundBox.FocusLost:Connect(function()
  Wd.CustomHitSoundID = Bm.CustomSoundBox.Text
end)
h["CustomHitSoundID"] = function(i_)
  Wd.CustomHitSoundID = i_
  Bm.CustomSoundBox.Text = i_
end
dl(Bm.PageMisc, "SETTINGS")
bk(Bm.PageMisc, "Menu Toggle Key", "MenuKey")
Hr(Bm.PageMisc, "Show Watermark", "Watermark")
Hr(Bm.PageMisc, "Show Keybinds", "ShowKeybinds")
Hr(Bm.PageMisc, "Show 'W' Menu Button", "ShowWButton")
if Wl_TouchEnabled then
  dl(Bm.PageMisc, "MOBILE")
  Hr(Bm.PageMisc, "Show Mobile UI", "MobileUI")
end
dl(Bm.PageMisc, "CHARACTER MODS")
Hr(Bm.PageMisc, "Enable Speed/Jump", "MovementEnabled")
bk(Bm.PageMisc, "Toggle Keybind", "SpeedJumpKey")
Lm(Bm.PageMisc, "Jump Power (Max 25)", 10, 25, "JumpPower")
Lm(Bm.PageMisc, "Speed", 16, 25, "SpeedValue")
Hr(Bm.PageMisc, "Auto Bhop (Hold Space)", "Bhop")
Hr(Bm.PageMisc, "Enable Spinbot", "Spinbot")
Hr(Bm.PageMisc, "Spinbot Look Up", "SpinbotLookUp")
Lm(Bm.PageMisc, "Spinbot Speed", 10, 150, "SpinbotSpeed")
dl(Bm.PageMisc, "EXTERNAL SCRIPTS")
Bm.SkinBtn = Instance.new("TextButton", Bm.PageMisc)
Bm.SkinBtn.Size = Uj(1, 0, 0, 32)
Bm.SkinBtn.BackgroundColor3 = qb.Panel
Bm.SkinBtn.BackgroundTransparency = 0.7
Bm.SkinBtn.BorderSizePixel = 0
Bm.SkinBtn.Text = "Skin Changer"
Bm.SkinBtn.TextColor3 = qb.MainColor
Bm.SkinBtn.Font = Enum.Font.GothamBold
Bm.SkinBtn.TextSize = 13
Instance.new("UICorner", Bm.SkinBtn).CornerRadius = UDim_new(0, 4)
Bm.SkinStroke = Instance.new("UIStroke", Bm.SkinBtn)
Bm.SkinStroke.Color = qb.AccentColor
Bm.SkinStroke.Thickness = 1.5
Bm.SkinBtn.MouseButton1Click:Connect(function()
  if not Cn.isSkinLoaded then
    Cn.isSkinLoaded = true
    Bm.SkinBtn.Text = "LOADING..."
    Bm.SkinBtn.TextColor3 = hg(255, 255, 0)
    task_spawn(function()
      pcall(function()
        loadstring(game:HttpGet(""))()
      end)
      Bm.SkinBtn.Text = "LOADED!"
      Bm.SkinBtn.TextColor3 = hg(0, 255, 0)
    end)
  end
end)
dl(Bm.PageMisc, "SERVER")
Bm.ServerBtnContainer = Instance.new("Frame", Bm.PageMisc)
Bm.ServerBtnContainer.Size = Uj(1, 0, 0, 32)
Bm.ServerBtnContainer.BackgroundTransparency = 1
Bm.SBtnLayout = Instance.new("UIListLayout", Bm.ServerBtnContainer)
Bm.SBtnLayout.FillDirection = Enum.FillDirection.Horizontal
Bm.SBtnLayout.Padding = UDim_new(0, 5)
Bm.RejoinBtn = Ch(Bm.ServerBtnContainer, "REJOIN", "REJOINING...", function()
  TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, ii_LocalPlayer)
end)
Bm.RejoinBtn.Size = Uj(0.48, 0, 1, 0)
Bm.HopBtn = Ch(Bm.ServerBtnContainer, "SERVER HOP", "HOPPING...", function()
  local Uc = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
  task_spawn(function()
    local Ua, Ia = pcall(function()
      return game:HttpGet(Uc)
    end)
    if not Ua then
    else
      local jo = HttpService:JSONDecode(Ia)
      if jo and jo.data then
        local Dg = {}
        for _t, Mp in ipairs(jo.data) do
          if not (Mp.playing and Mp.maxPlayers and Mp.playing < (Mp.maxPlayers - 1) and Mp.id ~= game.JobId) then
          else
            table_insert(Dg, Mp.id)
          end
        end
        if not (#Dg > 0) then
        else
          local Gs = Dg[math_random(1, #Dg)]
          TeleportService:TeleportToPlaceInstance(game.PlaceId, Gs, ii_LocalPlayer)
        end
      end
    end
  end)
end)
Bm.HopBtn.Size = Uj(0.48, 0, 1, 0)
dl(Bm.PageMisc, "COMMUNITY")
Ch(Bm.PageMisc, "Copy Discord Link", "COPIED!", function()
  if not If then
    if toclipboard then
      toclipboard("https://discord.gg/cEzvCvdBrm")
    end
  else
    If("https://discord.gg/cEzvCvdBrm")
  end
end)
dl(Bm.PageMisc, "CONFIGURATION")
Bm.ConfigNameBox = Instance.new("TextBox", Bm.PageMisc)
Bm.ConfigNameBox.Size = Uj(1, 0, 0, 32)
Bm.ConfigNameBox.BackgroundColor3 = qb.Panel
Bm.ConfigNameBox.BackgroundTransparency = 0.7
Bm.ConfigNameBox.TextColor3 = qb.Text
Bm.ConfigNameBox.PlaceholderText = "Enter Config Name (e.g. Legit)"
Bm.ConfigNameBox.Font = Enum.Font.GothamMedium
Bm.ConfigNameBox.TextSize = 13
Bm.ConfigNameBox.Text = "Default"
Instance.new("UICorner", Bm.ConfigNameBox).CornerRadius = UDim_new(0, 4)
Bm.CNameStroke = Instance.new("UIStroke", Bm.ConfigNameBox)
Bm.CNameStroke.Color = qb.AccentColor
Bm.CNameStroke.Thickness = 1
Bm.ConfigScroll = Instance.new("ScrollingFrame", Bm.PageMisc)
Bm.ConfigScroll.Size = Uj(1, 0, 0, 100)
Bm.ConfigScroll.BackgroundColor3 = qb.Panel
Bm.ConfigScroll.BackgroundTransparency = 0.7
Bm.ConfigScroll.BorderSizePixel = 0
Bm.ConfigScroll.ScrollBarThickness = 4
Bm.ConfigScroll.ScrollBarImageColor3 = qb.MainColor
Bm.ConfigListLayout = Instance.new("UIListLayout", Bm.ConfigScroll)
Bm.ConfigListLayout.Padding = UDim_new(0, 2)
Bm.ConfigListLayout.SortOrder = Enum.SortOrder.LayoutOrder
local function cs()
  for sr, Jr in pairs(Bm.ConfigScroll:GetChildren()) do
    if not (Jr:IsA("TextButton")) then
    else
      Jr:Destroy()
    end
  end
  local er = Ci()
  for Eh, gt in pairs(er) do
    local Xf = Instance.new("TextButton")
    Xf.Size = Uj(1, -6, 0, 25)
    Xf.BackgroundColor3 = qb.Background
    Xf.BackgroundTransparency = 0.7
    Xf.TextColor3 = qb.Text
    Xf.Font = Enum.Font.GothamMedium
    Xf.TextSize = 13
    Xf.Text = Eh
    Xf.Parent = Bm.ConfigScroll
    Instance.new("UICorner", Xf).CornerRadius = UDim_new(0, 4)
    Xf.MouseButton1Click:Connect(function()
      Bm.ConfigNameBox.Text = Eh
      for Uu, Pk in pairs(Bm.ConfigScroll:GetChildren()) do
        if Pk:IsA("TextButton") then
          Pk.TextColor3 = qb.Text
          Pk.BackgroundColor3 = qb.Background
        end
      end
      Xf.TextColor3 = qb.MainColor
      Xf.BackgroundColor3 = qb.Panel
    end)
  end
  Bm.ConfigScroll.CanvasSize = Uj(0, 0, 0, Bm.ConfigListLayout.AbsoluteContentSize.Y + 5)
end
Bm.ConfigBtnContainer = Instance.new("Frame", Bm.PageMisc)
Bm.ConfigBtnContainer.Size = Uj(1, 0, 0, 32)
Bm.ConfigBtnContainer.BackgroundTransparency = 1
Bm.CfgBtnLayout = Instance.new("UIListLayout", Bm.ConfigBtnContainer)
Bm.CfgBtnLayout.FillDirection = Enum.FillDirection.Horizontal
Bm.CfgBtnLayout.Padding = UDim_new(0, 5)
Bm.SaveBtn = Ch(Bm.ConfigBtnContainer, "SAVE", "SAVED!", function()
  local ft = Bm.ConfigNameBox.Text
  if ft ~= "" then
    mo(ft)
    cs()
  end
end)
Bm.SaveBtn.Size = Uj(0.48, 0, 1, 0)
Bm.LoadBtn = Ch(Bm.ConfigBtnContainer, "LOAD", "LOADED!", function()
  local Oh = Bm.ConfigNameBox.Text
  if not (Oh ~= "") then
  else
    nl(Oh)
  end
end)
Bm.LoadBtn.Size = Uj(0.48, 0, 1, 0)
cs()
UserInputService.InputBegan:Connect(function(Hb, Rm)
  if UserInputService:GetFocusedTextBox() then
    return
  end
  local Hb_KeyCode = Hb.KeyCode
  if not (Hb_KeyCode == Wd.MenuKey) then
  else
    Sa(not Cn.IsMenuOpen)
  end
  if Hb_KeyCode ~= Enum.KeyCode.Unknown then
    if Hb_KeyCode == Wd.RageKey then
      h.RageMode(not Wd.RageMode)
    end
    if Hb_KeyCode == Wd.SilentAimToggleKey then
      h.SilentEnabled(not Wd.SilentEnabled)
    end
    if not (Hb_KeyCode == Wd.ESPToggleKey) then
    else
      h.ESP(not Wd.ESP)
    end
    if Hb_KeyCode == Wd.HitboxToggleKey then
      h.HitboxExpander(not Wd.HitboxExpander)
    end
    if Hb_KeyCode == Wd.AimlockToggleKey then
      h.Aimlock(not Wd.Aimlock)
    end
    if Hb_KeyCode == Wd.TPSKey then
      h.TPS(not Wd.TPS)
    end
    if Hb_KeyCode == Wd.WallbangToggleKey then
      h.Wallbang(not Wd.Wallbang)
    end
    if Hb_KeyCode == Wd.SpeedJumpKey then
      h.MovementEnabled(not Wd.MovementEnabled)
    end
    if Hb_KeyCode == Wd.NightModeKey then
      h.NightMode(not Wd.NightMode)
    end
    if not (Hb_KeyCode == Wd.TriggerKey) then
    else
      h.TriggerBot(not Wd.TriggerBot)
    end
  end
end)
Bm.IndicatorGui = Instance.new("ScreenGui")
Bm.IndicatorGui.Name = "Wyvern_KeyIndicator"
Bm.IndicatorGui.ResetOnSpawn = false
Bm.IndicatorGui.IgnoreGuiInset = false
Bm.IndicatorGui.Parent = Ae()
Bm.IndicatorFrame = Instance.new("Frame", Bm.IndicatorGui)
Bm.IndicatorFrame.Size = Uj(0, 140, 0, 0)
Bm.IndicatorFrame.Position = Uj(0, 15, 0, 78)
Bm.IndicatorFrame.AnchorPoint = wv(0, 0)
Bm.IndicatorFrame.BackgroundTransparency = 1
Bm.IndicatorFrame.BorderSizePixel = 0
Bm.IndicatorLayout = Instance.new("UIListLayout", Bm.IndicatorFrame)
Bm.IndicatorLayout.SortOrder = Enum.SortOrder.LayoutOrder
Bm.IndicatorLayout.Padding = UDim_new(0, 4)
Bm.IndicatorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
Cn.INDICATORS = {
  { key = "RageMode", label = "RAGE MODE", keyVar = "RageKey" },
  { key = "Wallbang", label = "WALLBANG", keyVar = "WallbangToggleKey" },
  { key = "MovementEnabled", label = "SPEED/JUMP", keyVar = "SpeedJumpKey" },
  { key = "TPS", label = "TPS", keyVar = "TPSKey" },
  { key = "SilentEnabled", label = "SILENT AIM", keyVar = "SilentAimToggleKey" },
  { key = "Aimlock", label = "AIMLOCK", keyVar = "AimlockToggleKey" },
  { key = "HitboxExpander", label = "HITBOX", keyVar = "HitboxToggleKey" },
  { key = "ESP", label = "ESP", keyVar = "ESPToggleKey" },
  { key = "NightMode", label = "NIGHT MODE", keyVar = "NightModeKey" },
  { key = "TriggerBot", label = "TRIGGER BOT", keyVar = "TriggerKey" },
}
Cn.pills = {}
local function Vr(ha)
  if not not ha then
  else
    return ""
  end
  local fu_ = Wd[ha]
  if not (fu_ and fu_.Name) then
    return ""
  else
    return " [" .. fu_.Name .. "]"
  end
end
for km, M in ipairs(Cn.INDICATORS) do
  local ke = Instance.new("Frame", Bm.IndicatorFrame)
  ke.Size = Uj(1, 0, 0, 20)
  ke.BackgroundColor3 = qb.Background
  ke.BackgroundTransparency = 0.2
  ke.BorderSizePixel = 0
  ke.Visible = false
  ke.LayoutOrder = km
  Instance.new("UICorner", ke).CornerRadius = UDim_new(0, 4)
  local df = Instance.new("UIStroke", ke)
  df.Thickness = 1
  df.Color = qb.MainColor
  local _u = Instance.new("TextLabel", ke)
  _u.Size = Uj(1, -18, 1, 0)
  _u.Position = Uj(0, 5, 0, 0)
  _u.BackgroundTransparency = 1
  _u.Font = Enum.Font.GothamBold
  _u.TextSize = 11
  _u.TextColor3 = qb.MainColor
  _u.TextXAlignment = Enum.TextXAlignment.Left
  local vj = Instance.new("Frame", ke)
  vj.Size = Uj(0, 5, 0, 5)
  vj.Position = Uj(1, -10, 0.5, -2.5)
  vj.BackgroundColor3 = qb.MainColor
  vj.BorderSizePixel = 0
  Instance.new("UICorner", vj).CornerRadius = UDim_new(1, 0)
  Cn.pills[M.key] = { pill = ke, label = _u, stroke = df, dot = vj, ind = M }
end
RunService.RenderStepped:Connect(function()
  if not Bm.IndicatorGui then
  else
    Bm.IndicatorGui.Enabled = Wd.ShowKeybinds
  end
  for Zl, zr in pairs(Cn.pills) do
    local Fs = Wd[Zl] == true
    if not (Fs ~= zr.pill.Visible) then
    else
      zr.pill.Visible = Fs
      if Fs then
        TweenService:Create(zr.pill, TweenInfo.new(0.15), { BackgroundTransparency = 0.2 }):Play()
      end
    end
    if Fs then
      local On = Vr(zr.ind.keyVar)
      local Pn = zr.ind.label .. On
      if not (zr.label.Text ~= Pn) then
      else
        zr.label.Text = Pn
        local io = game:GetService("TextService"):GetTextSize(Pn, 11, Enum.Font.GothamBold, wv(999, 20))
        zr.pill.Size = Uj(0, io.X + 25, 0, 20)
      end
    end
  end
  Bm.IndicatorFrame.Size = Uj(0, 140, 0, Bm.IndicatorLayout.AbsoluteContentSize.Y)
end)
local function cw(Fr)
  if not Fr or Fr == Enum.KeyCode.Unknown then
    return false
  end
  pcall(function()
    if not (zh and wq) then
    else
      zh(Fr.Value)
      task_delay(0.05, function()
        wq(Fr.Value)
      end)
    end
  end)
  return true
end
if Wl_TouchEnabled then
  Bm.MobileToggleGui = Instance.new("ScreenGui", Ae())
  Bm.MobileToggleGui.Name = "Wyvern_MobileUI"
  Bm.MobileToggleGui.ResetOnSpawn = false
  Bm.MobileFrame = Instance.new("Frame", Bm.MobileToggleGui)
  Bm.MobileFrame.Size = Uj(0, 140, 245)
  Bm.MobileFrame.Position = Uj(0, 10, 0.5, -92)
  Bm.MobileFrame.BackgroundColor3 = qb.Background
  Bm.MobileFrame.BackgroundTransparency = 0.2
  Bm.MobileFrame.BorderSizePixel = 0
  Bm.MobileFrame.Visible = Wd.MobileUI
  Instance.new("UICorner", Bm.MobileFrame).CornerRadius = UDim_new(0, 6)
  Bm.MStroke = Instance.new("UIStroke", Bm.MobileFrame)
  Bm.MStroke.Color = qb.MainColor
  Bm.MStroke.Thickness = 1.5
  Bm.MLayout = Instance.new("UIListLayout", Bm.MobileFrame)
  Bm.MLayout.SortOrder = Enum.SortOrder.LayoutOrder
  Bm.MLayout.Padding = UDim_new(0, 5)
  Bm.MLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
  Instance.new("UIPadding", Bm.MobileFrame).PaddingTop = UDim_new(0, 5)
  local function tn(Cm, An)
    local xd = Instance.new("TextButton", Bm.MobileFrame)
    xd.Size = Uj(1, -10, 0, 30)
    xd.BackgroundColor3 = Wd[An] and qb.MainColor or qb.Panel
    xd.TextColor3 = Wd[An] and qb.Background or qb.Text
    xd.Text = Cm
    xd.Font = Enum.Font.GothamBold
    xd.TextSize = 12
    Instance.new("UICorner", xd).CornerRadius = UDim_new(1, 0)
    xd.MouseButton1Click:Connect(function()
      local ak, Pe =
        An == "RageMode" and "RageKey"
          or An == "SilentEnabled" and "SilentAimToggleKey"
          or An == "Aimlock" and "AimlockToggleKey"
          or An == "TriggerBot" and "TriggerKey"
          or An == "ESP" and "ESPToggleKey"
          or An == "Wallbang" and "WallbangToggleKey"
          or nil,
        false
      if ak and Wd[ak] and Wd[ak] ~= Enum.KeyCode.Unknown then
        Pe = cw(Wd[ak])
      end
      if not not Pe then
      else
        if not h[An] then
        else
          h[An](not Wd[An])
        end
      end
      xd.BackgroundColor3 = Wd[An] and qb.MainColor or qb.Panel
      xd.TextColor3 = Wd[An] and qb.Background or qb.Text
    end)
    task_spawn(function()
      while task_wait(0.2) do
        if xd and xd.Parent then
          xd.BackgroundColor3 = Wd[An] and qb.MainColor or qb.Panel
          xd.TextColor3 = Wd[An] and qb.Background or qb.Text
        end
      end
    end)
  end
  tn("Aimlock", "Aimlock")
  tn("Auto Shoot", "AutoShoot")
  tn("ESP", "ESP")
  tn("Wallbang", "Wallbang")
  tn("Bomb Trail", "BombTrail")
  tn("Rage Mode", "RageMode")
  if ii_LocalPlayer.UserId == 3839175996 then
    tn("Kill All", "KillAll")
  end
  Bm.MobileFrame.InputBegan:Connect(function(Yt)
    if Yt.UserInputType == Enum.UserInputType.MouseButton1 or Yt.UserInputType == Enum.UserInputType.Touch then
      Cn.mDragging = true
      Cn.mDragStart = Yt.Position
      Cn.mStartPos = Bm.MobileFrame.Position
    end
  end)
  Bm.MobileFrame.InputEnded:Connect(function(ka)
    if not (ka.UserInputType == Enum.UserInputType.MouseButton1 or ka.UserInputType == Enum.UserInputType.Touch) then
    else
      Cn.mDragging = false
    end
  end)
  UserInputService.InputChanged:Connect(function(Ub)
    if Ub.UserInputType == Enum.UserInputType.MouseMovement or Ub.UserInputType == Enum.UserInputType.Touch then
      Cn.mDragInput = Ub
    end
    if not (Cn.mDragging and Cn.mDragInput) then
    else
      local Zd = Cn.mDragInput.Position - Cn.mDragStart
      Bm.MobileFrame.Position = Uj(Cn.mStartPos.X.Scale, Cn.mStartPos.X.Offset + Zd.X, Cn.mStartPos.Y.Scale, Cn.mStartPos.Y.Offset + Zd.Y)
    end
  end)
  h["MobileUI"] = function(zl)
    Wd.MobileUI = zl
    Bm.MobileFrame.Visible = zl
  end
end
local function yi()
  local im = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Skins")
  if im then
    for fs, Ol in pairs(im:GetChildren()) do
      local cu, Vi = string_lower(Ol.Name), false
      for je, yc in ipairs(Cn.KnifeKeywords) do
        if string_find(cu, yc) then
          Vi = true
          table_insert(Cn.FoundKnives, Ol.Name)
          break
        end
      end
      if not Vi and (string_find(cu, "glove") or string_find(cu, "wraps")) then
        Vi = true
        table_insert(Cn.FoundGloves, Ol.Name)
      end
      if not Vi then
        Cn.AvailableGunSkins[Ol.Name] = {}
        for _o, Ja in pairs(Ol:GetChildren()) do
          table_insert(Cn.AvailableGunSkins[Ol.Name], Ja.Name)
        end
      end
    end
  end
end
local function Hg(ee, id)
  local cr = {}
  if not id then
    table_insert(cr, "Vanilla")
  end
  local av = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Skins")
  if av then
    local gs = av:FindFirstChild(ee)
    if gs then
      for de, al in pairs(gs:GetChildren()) do
        if not (string_lower(al.Name) == "vanilla" or string_lower(al.Name) == "stock") then
        else
          continue
        end
        local yk = false
        for ug, wd in ipairs(cr) do
          if not (wd == al.Name) then
          else
            yk = true
            break
          end
        end
        if not not yk then
        else
          table_insert(cr, al.Name)
        end
      end
    end
  end
  if not id then
    Cn.FoundSkins = cr
  else
    Cn.FoundGloveSkins = cr
    if not (#Cn.FoundGloveSkins > 0) then
      Cn.TargetSkinGlove = ""
    else
      Cn.TargetSkinGlove = Cn.FoundGloveSkins[1]
    end
  end
end
yi()
if not (#Cn.FoundGloves > 0) then
else
  Cn.TargetGlove = Cn.FoundGloves[1]
  Hg(Cn.TargetGlove, true)
end
Bm.PageGunSkins:ClearAllChildren()
Bm.PageGunSkins.CanvasSize = Uj(0, 0, 0, 0)
Bm.PageGunSkins.ScrollingEnabled = false
Bm.AutoApplyFrame = Instance.new("Frame", Bm.PageGunSkins)
Bm.AutoApplyFrame.Size = Uj(1, 0, 0, 30)
Bm.AutoApplyFrame.BackgroundTransparency = 1
Bm.AutoToggle = Instance.new("TextButton", Bm.AutoApplyFrame)
Bm.AutoToggle.Size = Uj(0, 20, 0, 20)
Bm.AutoToggle.Position = Uj(0, 10, 0.5, -10)
Bm.AutoToggle.BackgroundColor3 = Wd.AutoApplySkins and qb.MainColor or hg(60, 60, 60)
Bm.AutoToggle.Text = ""
Instance.new("UICorner", Bm.AutoToggle).CornerRadius = UDim_new(0, 4)
Bm.AutoLabel = Instance.new("TextLabel", Bm.AutoApplyFrame)
Bm.AutoLabel.Text = "AUTO APPLY (Re-equip weapon)"
Bm.AutoLabel.Size = Uj(0, 200, 1, 0)
Bm.AutoLabel.Position = Uj(0, 40, 0, 0)
Bm.AutoLabel.BackgroundTransparency = 1
Bm.AutoLabel.TextColor3 = qb.Text
Bm.AutoLabel.Font = Enum.Font.GothamBold
Bm.AutoLabel.TextSize = 12
Bm.AutoLabel.TextXAlignment = Enum.TextXAlignment.Left
Bm.AutoToggle.MouseButton1Click:Connect(function()
  Wd.AutoApplySkins = not Wd.AutoApplySkins
  Bm.AutoToggle.BackgroundColor3 = Wd.AutoApplySkins and qb.MainColor or hg(60, 60, 60)
end)
Bm.GunSearchBox = Instance.new("TextBox", Bm.PageGunSkins)
Bm.GunSearchBox.Size = Uj(1, -20, 0, 30)
Bm.GunSearchBox.Position = Uj(0, 10, 0, 35)
Bm.GunSearchBox.BackgroundColor3 = qb.Panel
Bm.GunSearchBox.BackgroundTransparency = 0.7
Bm.GunSearchBox.Text = ""
Bm.GunSearchBox.PlaceholderText = "Search Weapon..."
Bm.GunSearchBox.PlaceholderColor3 = qb.TextDim
Bm.GunSearchBox.TextColor3 = qb.MainColor
Bm.GunSearchBox.Font = Enum.Font.GothamMedium
Bm.GunSearchBox.TextSize = 14
Instance.new("UICorner", Bm.GunSearchBox).CornerRadius = UDim_new(0, 6)
Bm.GunSearchStroke = Instance.new("UIStroke", Bm.GunSearchBox)
Bm.GunSearchStroke.Color = qb.AccentColor
Bm.GunSearchStroke.Thickness = 1.5
Bm.GunSearchStroke.Transparency = 0.5
Bm.GunWeaponScroll = Instance.new("ScrollingFrame", Bm.PageGunSkins)
Bm.GunWeaponScroll.Size = Uj(0.48, 0, 0.6, 0)
Bm.GunWeaponScroll.Position = Uj(0, 0, 0, 75)
Bm.GunWeaponScroll.BackgroundColor3 = qb.Panel
Bm.GunWeaponScroll.BackgroundTransparency = 0.7
Bm.GunWeaponScroll.BorderSizePixel = 0
Bm.GunWeaponScroll.ScrollBarThickness = 2
Bm.GunWeaponScroll.ScrollBarImageColor3 = qb.MainColor
Bm.GWList = Instance.new("UIListLayout", Bm.GunWeaponScroll)
Bm.GWList.Padding = UDim_new(0, 4)
Bm.GunSkinScroll = Instance.new("ScrollingFrame", Bm.PageGunSkins)
Bm.GunSkinScroll.Size = Uj(0.48, 0, 0.6, 0)
Bm.GunSkinScroll.Position = Uj(0.52, 0, 0, 75)
Bm.GunSkinScroll.BackgroundColor3 = qb.Panel
Bm.GunSkinScroll.BackgroundTransparency = 0.7
Bm.GunSkinScroll.BorderSizePixel = 0
Bm.GunSkinScroll.ScrollBarThickness = 2
Bm.GunSkinScroll.ScrollBarImageColor3 = qb.MainColor
Bm.GSList = Instance.new("UIListLayout", Bm.GunSkinScroll)
Bm.GSList.Padding = UDim_new(0, 4)
Bm.GunSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
  local He = string_lower(Bm.GunSearchBox.Text)
  for bs, hr in pairs(Bm.GunWeaponScroll:GetChildren()) do
    if not (hr:IsA("TextButton")) then
    else
      if He == "" or string_find(string_lower(hr.Text), He) then
        hr.Visible = true
      else
        hr.Visible = false
      end
    end
  end
end)
local function Jq(Lb)
  for Iu, au in pairs(Bm.GunSkinScroll:GetChildren()) do
    if not (au:IsA("TextButton")) then
    else
      au:Destroy()
    end
  end
  local rl = Cn.AvailableGunSkins[Lb]
  if rl then
    local Kf = Instance.new("TextButton", Bm.GunSkinScroll)
    Kf.Text = "Stock"
    Kf.Size = Uj(1, -6, 0, 25)
    Kf.BackgroundColor3 = qb.Background
    Kf.BackgroundTransparency = 0.7
    Kf.TextColor3 = qb.Text
    Kf.Font = Enum.Font.GothamMedium
    Kf.TextSize = 12
    Instance.new("UICorner", Kf).CornerRadius = UDim_new(0, 4)
    Kf.MouseButton1Click:Connect(function()
      Cn.TargetGunSkin = "Stock"
      for gh, sa in pairs(Bm.GunSkinScroll:GetChildren()) do
        if sa:IsA("TextButton") then
          sa.TextColor3 = qb.Text
          sa.BackgroundColor3 = qb.Background
        end
      end
      Kf.TextColor3 = qb.MainColor
      Kf.BackgroundColor3 = qb.Panel
      Tr(Lb, "Vanilla")
    end)
    local hl = {}
    for jt, rd in ipairs(rl) do
      local xn = string_lower(rd)
      if xn ~= "stock" and xn ~= "vanilla" and not hl[xn] then
        hl[xn] = true
        local qe = Instance.new("TextButton", Bm.GunSkinScroll)
        qe.Text = rd
        qe.Size = Uj(1, -6, 0, 25)
        qe.BackgroundColor3 = qb.Background
        qe.BackgroundTransparency = 0.7
        qe.TextColor3 = qb.Text
        qe.Font = Enum.Font.GothamMedium
        qe.TextSize = 12
        Instance.new("UICorner", qe).CornerRadius = UDim_new(0, 4)
        qe.MouseButton1Click:Connect(function()
          Cn.TargetGunSkin = rd
          for cv, Ob in pairs(Bm.GunSkinScroll:GetChildren()) do
            if not (Ob:IsA("TextButton")) then
            else
              Ob.TextColor3 = qb.Text
              Ob.BackgroundColor3 = qb.Background
            end
          end
          qe.TextColor3 = qb.MainColor
          qe.BackgroundColor3 = qb.Panel
          Tr(Lb, rd)
        end)
      end
    end
    Bm.GunSkinScroll.CanvasSize = Uj(0, 0, 0, Bm.GSList.AbsoluteContentSize.Y + 10)
  end
end
for yo, gf in pairs(Cn.AvailableGunSkins) do
  table_insert(Cn.sortedWeapons, yo)
end
table_sort(Cn.sortedWeapons)
for Mn, Lq in ipairs(Cn.sortedWeapons) do
  local ju, gu = Instance.new("TextButton", Bm.GunWeaponScroll), string_lower(Lq)
  local yg = string_find(gu, "sg 553") or string_find(gu, "aug") or string_find(gu, "berettas")
  if not yg then
    ju.Text = Lq
    ju.TextColor3 = qb.Text
  else
    ju.Text = Lq .. " (Not Working)"
    ju.TextColor3 = qb.TextDim
  end
  ju.Size = Uj(1, -6, 0, 25)
  ju.BackgroundColor3 = qb.Background
  ju.BackgroundTransparency = 0.7
  ju.Font = Enum.Font.GothamMedium
  ju.TextSize = 11
  Instance.new("UICorner", ju).CornerRadius = UDim_new(0, 4)
  ju.MouseButton1Click:Connect(function()
    Cn.TargetGun = Lq
    Cn.TargetGunSkin = nil
    Jq(Lq)
    for xs, Qv in pairs(Bm.GunWeaponScroll:GetChildren()) do
      if Qv:IsA("TextButton") then
        Qv.TextColor3 = qb.Text
        Qv.BackgroundColor3 = qb.Background
      end
    end
    ju.TextColor3 = qb.AccentColor
    ju.BackgroundColor3 = qb.Panel
    Tr(Lq, "Vanilla")
  end)
end
Bm.GunWeaponScroll.CanvasSize = Uj(0, 0, 0, Bm.GWList.AbsoluteContentSize.Y + 10)
Bm.GunApplyBtn = Instance.new("TextButton", Bm.PageGunSkins)
Bm.GunApplyBtn.Text = "SAVE & APPLY ALL"
Bm.GunApplyBtn.Size = Uj(1, 0, 0, 30)
Bm.GunApplyBtn.Position = Uj(0, 0, 1, -30)
Bm.GunApplyBtn.BackgroundColor3 = qb.Panel
Bm.GunApplyBtn.BackgroundTransparency = 0.7
Bm.GunApplyBtn.TextColor3 = qb.MainColor
Bm.GunApplyBtn.Font = Enum.Font.GothamBlack
Bm.GunApplyBtn.TextSize = 14
Instance.new("UICorner", Bm.GunApplyBtn).CornerRadius = UDim_new(0, 6)
Bm.GunApplyStroke = Instance.new("UIStroke", Bm.GunApplyBtn)
Bm.GunApplyStroke.Color = qb.AccentColor
Bm.GunApplyStroke.Thickness = 2
Cn.SkinsFolder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Skins")
local function Wn(Pr)
  local Pr_Name = Pr.Name
  local lk = Wd.ActiveGunSkins[Pr_Name]
  if not (not lk or lk == "Stock") then
  else
    return
  end
  local rc = Cn.SkinsFolder:FindFirstChild(Pr_Name)
  if not not rc then
  else
    return
  end
  local Qt = rc:FindFirstChild(lk)
  if not not Qt then
  else
    return
  end
  local fc = Qt:FindFirstChild("Camera") or Qt
  local xt, Ud, sq =
    fc:FindFirstChild("Factory New") or fc:FindFirstChild("Minimal Wear") or fc:FindFirstChild("Field-Tested") or fc:FindFirstChild(
      "Well-Worn"
    ) or fc:FindFirstChild("Battle-Scarred") or fc,
    {},
    nil
  for _r, Kg in pairs(xt:GetChildren()) do
    if Kg:IsA("SurfaceAppearance") or Kg:IsA("Texture") or Kg:IsA("Decal") then
      local Yk = string_lower(Kg.Name)
      Ud[Yk] = Kg
      if not (string_find(Yk, "body") or string_find(Yk, "receiver") or string_find(Yk, "main")) then
      else
        sq = Kg
      end
    end
  end
  if not not sq then
  else
    for tc, ro in pairs(Ud) do
      sq = ro
      break
    end
  end
  local function ib(No)
    No = string_lower(No)
    if not (string_find(No, "glove") or string_find(No, "sleeve") or string_find(No, "arm") or string_find(No, "wrist")) then
    else
      return true
    end
    if string_find(No, "hand") and not string_find(No, "handle") and not string_find(No, "handguard") then
      return true
    end
    return false
  end
  for fb, Er in pairs(Pr:GetDescendants()) do
    if Er:IsA("BasePart") then
      local qc, Ok = string_lower(Er.Name), Er.Parent and string_lower(Er.Parent.Name) or ""
      if ib(qc) or ib(Ok) then
        continue
      end
      local dp = Ud[qc]
      if not dp then
        for rn, Wr in pairs(Er:GetChildren()) do
          if Wr:IsA("SurfaceAppearance") then
            local lh = string_lower(Wr.Name)
            if not Ud[lh] then
            else
              dp = Ud[lh]
              break
            end
          end
        end
      end
      if not dp and Er:IsA("MeshPart") then
        dp = sq
      end
      if dp then
        for fa_, gi in pairs(Er:GetChildren()) do
          if gi:IsA("SurfaceAppearance") or gi:IsA("Texture") or gi:IsA("Decal") then
            gi:Destroy()
          end
        end
        if Er:IsA("MeshPart") then
          Er.TextureID = ""
        end
        local zu = Er:FindFirstChildWhichIsA("SpecialMesh")
        if not zu then
        else
          zu.TextureId = ""
        end
        if dp:IsA("SurfaceAppearance") then
          if Er:IsA("MeshPart") then
            dp:Clone().Parent = Er
          end
        else
          dp:Clone().Parent = Er
        end
      end
    end
  end
end
Bm.GunApplyBtn.MouseButton1Click:Connect(function()
  if not (Cn.TargetGun and Cn.TargetGunSkin) then
  else
    Wd.ActiveGunSkins[Cn.TargetGun] = Cn.TargetGunSkin
  end
  Bm.GunApplyBtn.Text = "APPLIED!"
  Bm.GunApplyBtn.TextColor3 = hg(0, 255, 0)
  local Me, Jl = pcall(function()
    for it, wl in pairs(Vm_CurrentCamera:GetChildren()) do
      if wl:IsA("Model") then
        Wn(wl)
      end
    end
  end)
  if not not Me then
  else
    Yp("Skin Changer Error: " .. tostring(Jl))
    return
  end
  task_wait(1)
  Bm.GunApplyBtn.Text = "SAVE & APPLY ALL"
  Bm.GunApplyBtn.TextColor3 = qb.MainColor
end)
Vm_CurrentCamera.ChildAdded:Connect(function(jr)
  if Wd.AutoApplySkins and Cn.AvailableGunSkins[jr.Name] then
    task_wait(0.2)
    pcall(function()
      Wn(jr)
    end)
  end
end)
Bm.PageKnife:ClearAllChildren()
Bm.PageKnife.CanvasSize = Uj(0, 0, 0, 0)
Bm.PageKnife.ScrollingEnabled = false
Bm.KnifeTitle = Instance.new("TextLabel", Bm.PageKnife)
Bm.KnifeTitle.Size = Uj(0.5, -5, 0, 20)
Bm.KnifeTitle.Position = Uj(0, 0, 0, 0)
Bm.KnifeTitle.BackgroundTransparency = 1
Bm.KnifeTitle.Text = "KNIVES"
Bm.KnifeTitle.TextColor3 = qb.MainColor
Bm.KnifeTitle.Font = Enum.Font.GothamBold
Bm.KnifeTitle.TextSize = 12
Bm.KnifeSearchBox = Instance.new("TextBox", Bm.PageKnife)
Bm.KnifeSearchBox.Size = Uj(0.5, -5, 0, 25)
Bm.KnifeSearchBox.Position = Uj(0, 0, 0, 20)
Bm.KnifeSearchBox.BackgroundColor3 = qb.Panel
Bm.KnifeSearchBox.BackgroundTransparency = 0.7
Bm.KnifeSearchBox.Text = ""
Bm.KnifeSearchBox.PlaceholderText = "Search Knife..."
Bm.KnifeSearchBox.PlaceholderColor3 = qb.TextDim
Bm.KnifeSearchBox.TextColor3 = qb.MainColor
Bm.KnifeSearchBox.Font = Enum.Font.GothamMedium
Bm.KnifeSearchBox.TextSize = 12
Instance.new("UICorner", Bm.KnifeSearchBox).CornerRadius = UDim_new(0, 4)
Bm.SkinTitle = Instance.new("TextLabel", Bm.PageKnife)
Bm.SkinTitle.Size = Uj(0.5, -5, 0, 20)
Bm.SkinTitle.Position = Uj(0.5, 5, 0, 0)
Bm.SkinTitle.BackgroundTransparency = 1
Bm.SkinTitle.Text = "SKINS (Vanilla)"
Bm.SkinTitle.TextColor3 = qb.MainColor
Bm.SkinTitle.Font = Enum.Font.GothamBold
Bm.SkinTitle.TextSize = 12
Bm.KnifeSkinSearchBox = Instance.new("TextBox", Bm.PageKnife)
Bm.KnifeSkinSearchBox.Size = Uj(0.5, -5, 0, 25)
Bm.KnifeSkinSearchBox.Position = Uj(0.5, 5, 0, 20)
Bm.KnifeSkinSearchBox.BackgroundColor3 = qb.Panel
Bm.KnifeSkinSearchBox.BackgroundTransparency = 0.7
Bm.KnifeSkinSearchBox.Text = ""
Bm.KnifeSkinSearchBox.PlaceholderText = "Search Skin..."
Bm.KnifeSkinSearchBox.PlaceholderColor3 = qb.TextDim
Bm.KnifeSkinSearchBox.TextColor3 = qb.MainColor
Bm.KnifeSkinSearchBox.Font = Enum.Font.GothamMedium
Bm.KnifeSkinSearchBox.TextSize = 12
Instance.new("UICorner", Bm.KnifeSkinSearchBox).CornerRadius = UDim_new(0, 4)
Bm.KnifeScroll = Instance.new("ScrollingFrame", Bm.PageKnife)
Bm.KnifeScroll.Size = Uj(0.5, -5, 1, -50)
Bm.KnifeScroll.Position = Uj(0, 0, 0, 50)
Bm.KnifeScroll.BackgroundColor3 = qb.Panel
Bm.KnifeScroll.BackgroundTransparency = 0.7
Bm.KnifeScroll.BorderSizePixel = 0
Bm.KnifeScroll.ScrollBarThickness = 2
Bm.KnifeScroll.ScrollBarImageColor3 = qb.MainColor
Bm.KnifeLayout = Instance.new("UIListLayout", Bm.KnifeScroll)
Bm.KnifeLayout.Padding = UDim_new(0, 4)
Bm.SkinScroll = Instance.new("ScrollingFrame", Bm.PageKnife)
Bm.SkinScroll.Size = Uj(0.5, -5, 1, -50)
Bm.SkinScroll.Position = Uj(0.5, 5, 0, 50)
Bm.SkinScroll.BackgroundColor3 = qb.Panel
Bm.SkinScroll.BackgroundTransparency = 0.7
Bm.SkinScroll.BorderSizePixel = 0
Bm.SkinScroll.ScrollBarThickness = 2
Bm.SkinScroll.ScrollBarImageColor3 = qb.MainColor
Bm.SkinLayout = Instance.new("UIListLayout", Bm.SkinScroll)
Bm.SkinLayout.Padding = UDim_new(0, 4)
Bm.KnifeSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
  local _g = string_lower(Bm.KnifeSearchBox.Text)
  for el_, kd in pairs(Bm.KnifeScroll:GetChildren()) do
    if kd:IsA("TextButton") then
      if not (_g == "" or string_find(string_lower(kd.Text), _g)) then
        kd.Visible = false
      else
        kd.Visible = true
      end
    end
  end
end)
Bm.KnifeSkinSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
  local vm = string_lower(Bm.KnifeSkinSearchBox.Text)
  for Pc, jj in pairs(Bm.SkinScroll:GetChildren()) do
    if not (jj:IsA("TextButton")) then
    else
      if vm == "" or string_find(string_lower(jj.Text), vm) then
        jj.Visible = true
      else
        jj.Visible = false
      end
    end
  end
end)
local function sn(qp, jn, bh)
  local ev = Instance.new("TextButton", jn)
  ev.Size = Uj(1, 0, 0, 25)
  ev.BackgroundColor3 = qb.Background
  ev.BackgroundTransparency = 0.7
  ev.TextColor3 = qb.Text
  ev.Text = qp
  ev.Font = Enum.Font.Gotham
  ev.TextSize = 12
  ev.BorderSizePixel = 0
  Instance.new("UICorner", ev).CornerRadius = UDim_new(0, 4)
  ev.MouseButton1Click:Connect(function()
    if bh then
      Cn.TargetSkin = qp
      Wd.TargetSkin = qp
      local ev_Text = ev.Text
      ev.Text = "Applied!"
      ev.TextColor3 = hg(0, 255, 0)
      task_delay(1.5, function()
        if not (ev and ev.Parent) then
        else
          ev.Text = ev_Text
          ev.TextColor3 = qb.Text
        end
      end)
      for n_, Tb in pairs(Bm.SkinScroll:GetChildren()) do
        if not (Tb:IsA("TextButton")) then
        else
          Tb.TextColor3 = qb.Text
          Tb.BackgroundColor3 = qb.Background
        end
      end
      ev.TextColor3 = qb.MainColor
      ev.BackgroundColor3 = qb.Panel
      Tr(Cn.TargetKnife, Cn.TargetSkin)
    else
      Cn.TargetKnife = qp
      Wd.TargetKnife = qp
      Bm.SkinTitle.Text = "SKINS (" .. qp .. ")"
      Hg(Cn.TargetKnife, false)
      for Tq, Hv in pairs(Bm.SkinScroll:GetChildren()) do
        if Hv:IsA("TextButton") then
          Hv:Destroy()
        end
      end
      for br_, Rl in ipairs(Cn.FoundSkins) do
        sn(Rl, Bm.SkinScroll, true)
      end
      Bm.SkinScroll.CanvasSize = Uj(0, 0, 0, Bm.SkinLayout.AbsoluteContentSize.Y + 10)
      Cn.TargetSkin = "Vanilla"
      Ev("Knife Equipped", Cn.TargetKnife .. " will be applied next round.", 3)
      for lg, Bu in pairs(Bm.KnifeScroll:GetChildren()) do
        if Bu:IsA("TextButton") then
          Bu.TextColor3 = qb.Text
          Bu.BackgroundColor3 = qb.Background
        end
      end
      ev.TextColor3 = qb.AccentColor
      ev.BackgroundColor3 = qb.Panel
      Tr(Cn.TargetKnife, "Vanilla")
    end
  end)
end
Bm.PageGlove:ClearAllChildren()
Bm.PageGlove.CanvasSize = Uj(0, 0, 0, 0)
Bm.PageGlove.ScrollingEnabled = false
Bm.GloveTitle = Instance.new("TextLabel", Bm.PageGlove)
Bm.GloveTitle.Size = Uj(0.5, -5, 0, 20)
Bm.GloveTitle.Position = Uj(0, 0, 0, 0)
Bm.GloveTitle.BackgroundTransparency = 1
Bm.GloveTitle.Text = "GLOVES"
Bm.GloveTitle.TextColor3 = qb.MainColor
Bm.GloveTitle.Font = Enum.Font.GothamBold
Bm.GloveTitle.TextSize = 12
Bm.GloveSearchBox = Instance.new("TextBox", Bm.PageGlove)
Bm.GloveSearchBox.Size = Uj(0.5, -5, 0, 25)
Bm.GloveSearchBox.Position = Uj(0, 0, 0, 20)
Bm.GloveSearchBox.BackgroundColor3 = qb.Panel
Bm.GloveSearchBox.BackgroundTransparency = 0.7
Bm.GloveSearchBox.Text = ""
Bm.GloveSearchBox.PlaceholderText = "Search Glove..."
Bm.GloveSearchBox.PlaceholderColor3 = qb.TextDim
Bm.GloveSearchBox.TextColor3 = qb.MainColor
Bm.GloveSearchBox.Font = Enum.Font.GothamMedium
Bm.GloveSearchBox.TextSize = 12
Instance.new("UICorner", Bm.GloveSearchBox).CornerRadius = UDim_new(0, 4)
Bm.GloveSkinTitle = Instance.new("TextLabel", Bm.PageGlove)
Bm.GloveSkinTitle.Size = Uj(0.5, -5, 0, 20)
Bm.GloveSkinTitle.Position = Uj(0.5, 5, 0, 0)
Bm.GloveSkinTitle.BackgroundTransparency = 1
Bm.GloveSkinTitle.Text = "SKINS (" .. Cn.TargetSkinGlove .. ")"
Bm.GloveSkinTitle.TextColor3 = qb.MainColor
Bm.GloveSkinTitle.Font = Enum.Font.GothamBold
Bm.GloveSkinTitle.TextSize = 12
Bm.GloveSkinSearchBox = Instance.new("TextBox", Bm.PageGlove)
Bm.GloveSkinSearchBox.Size = Uj(0.5, -5, 0, 25)
Bm.GloveSkinSearchBox.Position = Uj(0.5, 5, 0, 20)
Bm.GloveSkinSearchBox.BackgroundColor3 = qb.Panel
Bm.GloveSkinSearchBox.BackgroundTransparency = 0.7
Bm.GloveSkinSearchBox.Text = ""
Bm.GloveSkinSearchBox.PlaceholderText = "Search Skin..."
Bm.GloveSkinSearchBox.PlaceholderColor3 = qb.TextDim
Bm.GloveSkinSearchBox.TextColor3 = qb.MainColor
Bm.GloveSkinSearchBox.Font = Enum.Font.GothamMedium
Bm.GloveSkinSearchBox.TextSize = 12
Instance.new("UICorner", Bm.GloveSkinSearchBox).CornerRadius = UDim_new(0, 4)
Bm.GloveScroll = Instance.new("ScrollingFrame", Bm.PageGlove)
Bm.GloveScroll.Size = Uj(0.5, -5, 1, -50)
Bm.GloveScroll.Position = Uj(0, 0, 0, 50)
Bm.GloveScroll.BackgroundColor3 = qb.Panel
Bm.GloveScroll.BackgroundTransparency = 0.7
Bm.GloveScroll.BorderSizePixel = 0
Bm.GloveScroll.ScrollBarThickness = 2
Bm.GloveScroll.ScrollBarImageColor3 = qb.MainColor
Bm.GloveLayout = Instance.new("UIListLayout", Bm.GloveScroll)
Bm.GloveLayout.Padding = UDim_new(0, 4)
Bm.GloveSkinScroll = Instance.new("ScrollingFrame", Bm.PageGlove)
Bm.GloveSkinScroll.Size = Uj(0.5, -5, 1, -50)
Bm.GloveSkinScroll.Position = Uj(0.5, 5, 0, 50)
Bm.GloveSkinScroll.BackgroundColor3 = qb.Panel
Bm.GloveSkinScroll.BackgroundTransparency = 0.7
Bm.GloveSkinScroll.BorderSizePixel = 0
Bm.GloveSkinScroll.ScrollBarThickness = 2
Bm.GloveSkinScroll.ScrollBarImageColor3 = qb.MainColor
Bm.GloveSkinLayout = Instance.new("UIListLayout", Bm.GloveSkinScroll)
Bm.GloveSkinLayout.Padding = UDim_new(0, 4)
Bm.GloveSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
  local Rk = string_lower(Bm.GloveSearchBox.Text)
  for hc, Je in pairs(Bm.GloveScroll:GetChildren()) do
    if not (Je:IsA("TextButton")) then
    else
      if not (Rk == "" or string_find(string_lower(Je.Text), Rk)) then
        Je.Visible = false
      else
        Je.Visible = true
      end
    end
  end
end)
Bm.GloveSkinSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
  local gd = string_lower(Bm.GloveSkinSearchBox.Text)
  for Rh, Iv in pairs(Bm.GloveSkinScroll:GetChildren()) do
    if not (Iv:IsA("TextButton")) then
    else
      if not (gd == "" or string_find(string_lower(Iv.Text), gd)) then
        Iv.Visible = false
      else
        Iv.Visible = true
      end
    end
  end
end)
local function vd()
  pcall(function()
    for Fa, lm in pairs(Cn.ActiveWeaponTables) do
      if rawget(Fa, "Class") == "Melee" then
        if not (rawget(Fa, "Viewmodel")) then
        else
          Fa.Viewmodel = nil
        end
        pcall(function()
          if type(rawget(Fa, "Unequip")) == "function" then
            Fa:Unequip()
          end
        end)
        task_delay(0.1, function()
          pcall(function()
            if type(rawget(Fa, "Equip")) == "function" then
              Fa:Equip()
            end
          end)
        end)
        break
      end
    end
  end)
end
local function Q(Gh, an_, Gd)
  local uk = Instance.new("TextButton", an_)
  uk.Size = Uj(1, 0, 0, 25)
  uk.BackgroundColor3 = qb.Background
  uk.BackgroundTransparency = 0.7
  uk.TextColor3 = qb.Text
  uk.Text = Gh
  uk.Font = Enum.Font.Gotham
  uk.TextSize = 12
  uk.BorderSizePixel = 0
  Instance.new("UICorner", uk).CornerRadius = UDim_new(0, 4)
  uk.MouseButton1Click:Connect(function()
    if not Gd then
      Cn.TargetGlove = Gh
      Wd.TargetGlove = Gh
      Hg(Cn.TargetGlove, true)
      Bm.GloveSkinTitle.Text = "SKINS (" .. (Cn.TargetSkinGlove ~= "" and Cn.TargetSkinGlove or "None") .. ")"
      for ce, xl in pairs(Bm.GloveSkinScroll:GetChildren()) do
        if xl:IsA("TextButton") then
          xl:Destroy()
        end
      end
      for Hd, Of in ipairs(Cn.FoundGloveSkins) do
        Q(Of, Bm.GloveSkinScroll, true)
      end
      Bm.GloveSkinScroll.CanvasSize = Uj(0, 0, 0, Bm.GloveSkinLayout.AbsoluteContentSize.Y + 10)
      for di, sg in pairs(Bm.GloveScroll:GetChildren()) do
        if not (sg:IsA("TextButton")) then
        else
          sg.TextColor3 = qb.Text
          sg.BackgroundColor3 = qb.Background
        end
      end
      uk.TextColor3 = qb.AccentColor
      uk.BackgroundColor3 = qb.Panel
      Tr(Cn.TargetGlove, Cn.TargetSkinGlove == "" and "Vanilla" or Cn.TargetSkinGlove)
      vd()
    else
      Cn.TargetSkinGlove = Gh
      Wd.TargetSkinGlove = Gh
      Bm.GloveSkinTitle.Text = "SKINS (" .. Cn.TargetSkinGlove .. ")"
      local uk_Text = uk.Text
      uk.Text = "Applied!"
      uk.TextColor3 = hg(0, 255, 0)
      task_delay(1.5, function()
        if not (uk and uk.Parent) then
        else
          uk.Text = uk_Text
          uk.TextColor3 = qb.Text
        end
      end)
      for qj, Cj in pairs(Bm.GloveSkinScroll:GetChildren()) do
        if Cj:IsA("TextButton") then
          Cj.TextColor3 = qb.Text
          Cj.BackgroundColor3 = qb.Background
        end
      end
      uk.TextColor3 = qb.MainColor
      uk.BackgroundColor3 = qb.Panel
      Tr(Cn.TargetGlove, Cn.TargetSkinGlove)
      vd()
    end
  end)
end
for cj, Hi in ipairs(Cn.FoundKnives) do
  local Ga = string_lower(Hi)
  if not (Ga == "ct knife" or Ga == "t knife") then
    sn(Hi, Bm.KnifeScroll, false)
  end
end
Bm.KnifeScroll.CanvasSize = Uj(0, 0, 0, Bm.KnifeLayout.AbsoluteContentSize.Y + 10)
for Eu, Kn in ipairs(Cn.FoundSkins) do
  sn(Kn, Bm.SkinScroll, true)
end
Bm.SkinScroll.CanvasSize = Uj(0, 0, 0, Bm.SkinLayout.AbsoluteContentSize.Y + 10)
for Ue, ct in ipairs(Cn.FoundGloves) do
  Q(ct, Bm.GloveScroll, false)
end
Bm.GloveScroll.CanvasSize = Uj(0, 0, 0, Bm.GloveLayout.AbsoluteContentSize.Y + 10)
for Lg, Nu in ipairs(Cn.FoundGloveSkins) do
  Q(Nu, Bm.GloveSkinScroll, true)
end
Bm.GloveSkinScroll.CanvasSize = Uj(0, 0, 0, Bm.GloveSkinLayout.AbsoluteContentSize.Y + 10)
local function es()
  table_clear(Cn.ActiveWeaponTables)
  pcall(function()
    for _k, Tp in pairs(getgc(true)) do
      if type(Tp) == "table" and rawget(Tp, "FireRate") then
        Cn.ActiveWeaponTables[Tp] = true
      end
    end
  end)
end
task_spawn(es)
ii_LocalPlayer:GetAttributeChangedSignal("CurrentEquipped"):Connect(function()
  task_delay(0.1, es)
end)
ii_LocalPlayer.CharacterAdded:Connect(function()
  task_delay(1, es)
end)
UserInputService.InputBegan:Connect(function(Qa, Co)
  if not Co and Qa.UserInputType == Enum.UserInputType.MouseButton1 and Wd.AutoClicker and IsPistolOrSniper() then
    Cn.isClicking = true
  end
end)
UserInputService.InputEnded:Connect(function(Ut)
  if Ut.UserInputType == Enum.UserInputType.MouseButton1 then
    Cn.isClicking = false
  end
end)
task_spawn(function()
  while task_wait() do
    if not (Cn.isClicking and Wd.AutoClicker and IsPistolOrSniper()) then
    else
      for Sl, ok in pairs(Cn.ActiveWeaponTables) do
        if not (rawget(Sl, "State") and rawget(Sl, "Class") ~= "Melee") then
        else
          if rawget(Sl, "MouseDown") ~= nil then
            Sl.MouseDown = true
          end
          if not (rawget(Sl, "isShooting") ~= nil) then
          else
            Sl.isShooting = true
          end
          pcall(function()
            if type(rawget(Sl, "Shoot")) == "function" then
              Sl:Shoot()
            end
          end)
          task_wait((tonumber(Wd.AutoClickerDelay) or 50) / 1000)
          if not (rawget(Sl, "MouseDown") ~= nil) then
          else
            Sl.MouseDown = false
          end
          if rawget(Sl, "isShooting") ~= nil then
            Sl.isShooting = false
          end
        end
      end
    end
  end
end)
UserInputService.InputBegan:Connect(function(md, mp)
  if not (not mp and md.UserInputType == Enum.UserInputType.MouseButton1 and Wd.AutoClicker and IsPistolOrSniper()) then
  else
    Cn.isClicking = true
  end
end)
UserInputService.InputEnded:Connect(function(Yl)
  if Yl.UserInputType == Enum.UserInputType.MouseButton1 then
    Cn.isClicking = false
  end
end)
task_spawn(function()
  while task_wait(0.1) do
    pcall(function()
      local vl = ii_LocalPlayer.Character
        and ii_LocalPlayer.Character:FindFirstChild("Humanoid")
        and ii_LocalPlayer.Character.Humanoid.Health > 0
      if not vl then
        return
      end
      for gk, _w in pairs(Cn.ActiveWeaponTables) do
        if not (Cn.isClicking and Wd.AutoClicker and IsPistolOrSniper()) then
        else
          if rawget(gk, "MouseDown") ~= nil then
            gk.MouseDown = true
          end
          if not (rawget(gk, "isShooting") ~= nil) then
          else
            gk.isShooting = true
          end
          pcall(function()
            if not (type(rawget(gk, "Shoot")) == "function") then
            else
              gk:Shoot()
            end
          end)
          task_wait((tonumber(Wd.AutoClickerDelay) or 50) / 1000)
          if not (rawget(gk, "MouseDown") ~= nil) then
          else
            gk.MouseDown = false
          end
          if rawget(gk, "isShooting") ~= nil then
            gk.isShooting = false
          end
        end
        if rawget(gk, "FireRate") then
          if not Cn.OriginalFireRates[gk] then
            Cn.OriginalFireRates[gk] = gk.FireRate
          end
          if Wd.RapidFire or Wd.RageMode then
            if not setreadonly then
            else
              setreadonly(gk, false)
            end
            gk.FireRate = Wd.RageMode and 0 or ((tonumber(Wd.RapidFireDelay) or 10) / 1000)
            if not (rawget(gk, "Auto") ~= nil) then
            else
              gk.Auto = true
            end
            if not setreadonly then
            else
              setreadonly(gk, true)
            end
          else
            if Cn.OriginalFireRates[gk] then
              if setreadonly then
                setreadonly(gk, false)
              end
              gk.FireRate = Cn.OriginalFireRates[gk]
              if not setreadonly then
              else
                setreadonly(gk, true)
              end
              Cn.OriginalFireRates[gk] = nil
            end
          end
        end
        if rawget(gk, "State") and rawget(gk, "Class") ~= "Melee" then
          if not Cn.InstaCache[gk] then
            Cn.InstaCache[gk] = { NextFire = rawget(gk, "NextFire"), NextAttack = rawget(gk, "NextAttack") }
          end
          if not (Wd.InstaEquip or Wd.RageMode) then
          else
            if gk.State == "Equipping" or gk.State == "Drawing" or gk.State == "Pulling" then
              gk.State = "Idle"
            end
            if rawget(gk, "IsEquipping") ~= nil then
              gk.IsEquipping = false
            end
          end
          if not (Wd.InstaReload or Wd.RageMode) then
          else
            if not (gk.State == "Reloading") then
            else
              gk.State = "Idle"
            end
            if rawget(gk, "IsReloading") ~= nil then
              gk.IsReloading = false
            end
          end
          if Wd.InstaEquip or Wd.InstaReload or Wd.RageMode then
            if rawget(gk, "NextFire") then
              gk.NextFire = 0
            end
            if rawget(gk, "NextAttack") then
              gk.NextAttack = 0
            end
          else
            if Cn.InstaCache[gk] then
              if not Cn.InstaCache[gk].NextFire then
              else
                gk.NextFire = Cn.InstaCache[gk].NextFire
              end
              if not Cn.InstaCache[gk].NextAttack then
              else
                gk.NextAttack = Cn.InstaCache[gk].NextAttack
              end
              Cn.InstaCache[gk] = nil
            end
          end
        end
      end
    end)
  end
end)
local function ns()
  local N = {
    "knife",
    "karambit",
    "bayonet",
    "butterfly",
    "gut",
    "huntsman",
    "falchion",
    "bowie",
    "daggers",
    "navaja",
    "stiletto",
    "talon",
    "ursus",
    "kukri",
    "dagger",
    "sickle",
    "machete",
    "melee",
  }
  for Ee, su in pairs(Vm_CurrentCamera:GetChildren()) do
    if not (su:IsA("Model")) then
    else
      local bu = string_lower(su.Name)
      for go, to in ipairs(N) do
        if string_find(bu, to) then
          return true
        end
      end
    end
  end
  return false
end
Cn.oldIndex = hookmetamethod(game, "__index", function(xi, Ms)
  if not (not checkcaller() and Ms == "Length" and typeof(xi) == "Instance" and xi:IsA("AnimationTrack")) then
  else
    local xi_Animation = xi.Animation
    if not (xi_Animation and xi_Animation.Name) then
    else
      local em = string_lower(xi_Animation.Name)
      if string_find(em, "equip") or string_find(em, "draw") or string_find(em, "pull") then
        if not ((Wd.InstaEquip or Wd.RageMode) and not ns()) then
        else
          return 0.01
        end
      elseif not (string_find(em, "reload")) then
      else
        if Wd.InstaReload or Wd.RageMode then
          return 0.01
        end
      end
    end
  end
  return Cn.oldIndex(xi, Ms)
end)
task_spawn(function()
  local function pt(Lv, _e)
    if not Lv then
      return
    end
    Lv.AnimationPlayed:Connect(function(El)
      local El_Animation = El.Animation
      if El_Animation and El_Animation.Name then
        local ej = string_lower(El_Animation.Name)
        if string_find(ej, "equip") or string_find(ej, "draw") or string_find(ej, "pull") then
          if (Wd.InstaEquip or Wd.RageMode) and not ns() then
            El:AdjustSpeed(100)
          end
        elseif not (string_find(ej, "reload")) then
        else
          if Wd.InstaReload or Wd.RageMode then
            El:AdjustSpeed(100)
          end
        end
      end
    end)
  end
  local function Em(Zt)
    if not Zt then
      return
    end
    local l_ = Zt:FindFirstChildOfClass("Humanoid") or Zt:FindFirstChildOfClass("AnimationController")
    if not l_ then
    else
      local ao = l_:FindFirstChildOfClass("Animator")
      if not ao then
        l_.ChildAdded:Connect(function(Um)
          if Um:IsA("Animator") then
            pt(Um, Zt)
          end
        end)
      else
        pt(ao, Zt)
      end
    end
  end
  if not ii_LocalPlayer.Character then
  else
    Em(ii_LocalPlayer.Character)
  end
  ii_LocalPlayer.CharacterAdded:Connect(function(ws)
    Em(ws)
  end)
  for Dn, ef in pairs(Vm_CurrentCamera:GetChildren()) do
    if not (ef:IsA("Model")) then
    else
      Em(ef)
    end
  end
  Vm_CurrentCamera.ChildAdded:Connect(function(_q)
    if _q:IsA("Model") then
      Em(_q)
    end
  end)
end)
Cn.oldGetCameraModel = Be.GetCameraModel
Be.GetCameraModel = function(te, Yc, ...)
  for sb, ad in ipairs(Cn.Checkifbaseknife) do
    if not (te == ad) then
    else
      te = Cn.TargetKnife
      Yc = Cn.TargetSkin
      break
    end
  end
  return Cn.oldGetCameraModel(te, Yc, ...)
end
Cn.oldGetCharacterModel = Be.GetCharacterModel
if not Cn.oldGetCharacterModel then
else
  Be.GetCharacterModel = function(Av, ne, ...)
    for ap, e_ in ipairs(Cn.Checkifbaseknife) do
      if not (Av == e_) then
      else
        Av = Cn.TargetKnife
        ne = Cn.TargetSkin
        break
      end
    end
    return Cn.oldGetCharacterModel(Av, ne, ...)
  end
end
Cn.oldViewmodelNew = eg.new
eg.new = function(H, hv, vr, ...)
  for dn, Hk in ipairs(Cn.Checkifbaseknife) do
    if not (hv == Hk) then
    else
      hv = Cn.TargetKnife
      vr = Cn.TargetSkin
      break
    end
  end
  return Cn.oldViewmodelNew(H, hv, vr, ...)
end
Cn.oldGetGloves = Be.GetGloves
if Cn.oldGetGloves then
  Be.GetGloves = function(uh, ph, ...)
    return Cn.oldGetGloves(Cn.TargetGlove, Cn.TargetSkinGlove, ...)
  end
end
local function Sf(aj)
  if not Wd.TeamCheck then
    return false
  end
  if not not ag then
  else
    return false
  end
  local Eo = nil
  if not (ag:FindFirstChild("Terrorists") and ag.Terrorists:FindFirstChild(ii_LocalPlayer.Name)) then
    if not (ag:FindFirstChild("Counter-Terrorists") and ag["Counter-Terrorists"]:FindFirstChild(ii_LocalPlayer.Name)) then
    else
      Eo = "Counter-Terrorists"
    end
  else
    Eo = "Terrorists"
  end
  if not (Eo and aj:IsDescendantOf(ag:FindFirstChild(Eo))) then
  else
    return true
  end
  return false
end
local function Yb(d_, Or)
  if not (Or == nil and not Wd.Wallbang and not Wd.RageMode) then
  else
    return true
  end
  local nv = Vm_CurrentCamera.CFrame.Position
  local nr, lt = d_.Position - nv, RaycastParams.new()
  lt.FilterType = Enum.RaycastFilterType.Exclude
  local Ej = { Vm_CurrentCamera, ii_LocalPlayer.Character }
  if Workspace:FindFirstChild("Debris") then
    table_insert(Ej, Workspace.Debris)
  end
  if not (Workspace:FindFirstChild("RaycastVisualizers")) then
  else
    table_insert(Ej, Workspace.RaycastVisualizers)
  end
  if not ag then
  else
    for s_, Ai in pairs(ag:GetChildren()) do
      for _i, or_ in pairs(Ai:GetChildren()) do
        if or_ ~= d_.Parent and (Sf(or_) or or_.Name == ii_LocalPlayer.Name) then
          table_insert(Ej, or_)
        end
      end
    end
  end
  local Wc = 0
  while Wc < 15 do
    Wc = Wc + 1
    lt.FilterDescendantsInstances = Ej
    local pc = Workspace:Raycast(nv, nr, lt)
    if not pc then
      return true
    else
      if pc.Instance:IsDescendantOf(d_.Parent) then
        return true
      elseif
        not (
          pc.Instance.Transparency >= 0.5
          or not pc.Instance.CanCollide
          or string_find(string_lower(pc.Instance.Name), "hitbox")
          or pc.Instance.Name == "Glass"
        )
      then
        return false
      else
        table_insert(Ej, pc.Instance)
      end
    end
  end
  return false
end
local function ds()
  return wv(math_floor(Vm_CurrentCamera.ViewportSize.X / 2), math_floor(Vm_CurrentCamera.ViewportSize.Y / 2))
end
local function Vn()
  local hq, Zf, zj = nil, tonumber(Wd.AimFOV) or 150, ds()
  if not ag then
    return nil
  end
  local wa = Vm_CurrentCamera.CFrame.Position
  for jp, bv in pairs(ag:GetChildren()) do
    for Kh, Mg in pairs(bv:GetChildren()) do
      if not (Mg.Name ~= ii_LocalPlayer.Name) then
      else
        local qk = Mg:FindFirstChild(Wd.TargetPartMode) or Mg:FindFirstChild("Head")
        if not Sf(Mg) and qk then
          local kt = Mg:FindFirstChildOfClass("Humanoid")
          if kt and kt.Health > 0 then
            local hf, rs = Vm_CurrentCamera:WorldToViewportPoint(qk.Position)
            if rs then
              local Dh = (wv(hf.X, hf.Y) - zj).Magnitude
              if Dh < Zf then
                if Wd.AimWallCheck then
                  if not (Yb(qk, true)) then
                  else
                    hq = qk
                    Zf = Dh
                  end
                else
                  hq = qk
                  Zf = Dh
                end
              end
            end
          end
        end
      end
    end
  end
  return hq
end
local function Yh(Yf)
  if not not ag then
  else
    return nil
  end
  local Wd_RageMode = Wd.RageMode
  local oe, mt, lj = Wd_RageMode or Wd.FullFOV360, Wd_RageMode or Wd.Wallbang, Vm_CurrentCamera.CFrame.Position
  if not oe then
  else
    local v, math_huge, vv_Character = nil, math.huge, ii_LocalPlayer.Character
    local Li = vv_Character and vv_Character:FindFirstChild("HumanoidRootPart")
    if not Li then
      return nil
    end
    for Jg, Ku in pairs(ag:GetChildren()) do
      for Ei, ec in pairs(Ku:GetChildren()) do
        if ec:IsA("Model") and ec.Name ~= ii_LocalPlayer.Name and not Sf(ec) then
          local vh, ga = ec:FindFirstChildOfClass("Humanoid"), ec:FindFirstChild(Wd.TargetPartMode) or ec:FindFirstChild("Head")
          if vh and vh.Health > 0 and ga then
            if not mt then
              if not Yb(ga, true) then
                continue
              end
            end
            local ru = (ga.Position - Li.Position).Magnitude
            local Vq = ru
            if not Wd.SmartTargeting then
            else
              local Pi, qm = vh.Health / vh.MaxHealth, (lj - ga.Position).Magnitude
              Vq = (ru * 0.4) + (Pi * 100) + (qm * 0.2)
              if not Yb(ga, true) then
                Vq = Vq + 500
              end
            end
            if not (Vq < math_huge) then
            else
              math_huge = Vq
              v = { Part = ga }
            end
          end
        end
      end
    end
    return v
  end
  local Gg, zm, yu = ds(), nil, Yf
  for iu, Sr in pairs(ag:GetChildren()) do
    for Ih, fj in pairs(Sr:GetChildren()) do
      if not (fj:IsA("Model") and fj.Name ~= ii_LocalPlayer.Name and not Sf(fj)) then
      else
        local zf, vn = fj:FindFirstChildOfClass("Humanoid"), fj:FindFirstChild(Wd.TargetPartMode) or fj:FindFirstChild("Head")
        if zf and zf.Health > 0 and vn then
          if not mt then
            if not (not Yb(vn, true)) then
            else
              continue
            end
          end
          local pe, Se = Vm_CurrentCamera:WorldToViewportPoint(vn.Position)
          if Se then
            local on = (wv(pe.X, pe.Y) - Gg).Magnitude
            local Va = on
            if Wd.SmartTargeting then
              local Io, Xd = zf.Health / zf.MaxHealth, (lj - vn.Position).Magnitude
              Va = (on * 0.4) + (Io * 100) + (Xd * 0.2)
              if not Yb(vn, true) then
                Va = Va + 500
              end
            end
            if Va < yu then
              yu = Va
              zm = { Part = vn }
            end
          end
        end
      end
    end
  end
  return zm
end
local function k()
  local wk, pf = math_random(), math_random()
  local ml = math.sqrt(-2 * math.log(wk)) * math.cos(2 * math.pi * pf)
  return ml / 3
end
task_spawn(function()
  local Tl
  while not Tl do
    pcall(function()
      Tl = require(ReplicatedStorage.Database.Security.Remotes).Inventory.ShootWeapon
    end)
    task_wait(1)
  end
  local bo
  local ik = 0
  local function ck(Pq, Ti, R, lp)
    local R_Position = R.Position
    local tr_, dg, Zm, Ad, hd, os =
      (R_Position - Pq).Magnitude, {}, { ii_LocalPlayer.Character, Vm_CurrentCamera }, Pq, 0, RaycastParams.new()
    os.FilterType = Enum.RaycastFilterType.Exclude
    local S = RaycastParams.new()
    S.FilterType = Enum.RaycastFilterType.Include
    for rw = 177, 180 do
      os.FilterDescendantsInstances = Zm
      local Vc = Workspace:Raycast(Ad, Ti * tr_, os)
      if not not Vc then
      else
        break
      end
      if Vc.Instance:FindFirstAncestorWhichIsA("Model") and Vc.Instance.Parent:FindFirstChildOfClass("Humanoid") then
        break
      end
      table_insert(
        dg,
        {
          Instance = Vc.Instance,
          Position = Vc.Position,
          Normal = Vc.Normal,
          Material = Vc.Material.Name,
          Distance = (Vc.Position - Ad).Magnitude,
          Exit = false,
        }
      )
      S.FilterDescendantsInstances = { Vc.Instance }
      local lr = Workspace:Raycast(Vc.Position + Ti * 10, -Ti * 11, S)
      if lr then
        local yv = (lr.Position - Vc.Position).Magnitude
        hd = hd + yv
        if not (hd > lp) then
        else
          break
        end
        table_insert(
          dg,
          { Instance = lr.Instance, Position = lr.Position, Normal = lr.Normal, Material = Vc.Material.Name, Distance = yv, Exit = true }
        )
        Ad = lr.Position + Ti * 0.01
      else
        break
      end
      table_insert(Zm, Vc.Instance)
    end
    table_insert(
      dg,
      { Instance = R, Position = R_Position, Normal = -Ti, Material = R.Material.Name, Distance = (R_Position - Ad).Magnitude, Exit = false }
    )
    return dg
  end
  local function nu(Os, ...)
    local qw = tick()
    if qw - ik < 0.05 then
      return bo(Os, ...)
    end
    ik = qw
    local Oj, Wd_RageMode =
      UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or UserInputService:IsMouseButtonPressed(
        Enum.UserInputType.MouseButton2
      ) or Cn.TriggerBotActive or Cn._G_AutoShootWait,
      Wd.RageMode
    if type(Os) == "table" then
      local bq = (tonumber(Wd.BacktrackTime) or 250) / 1000
      if Os.tick then
        Os.tick = Os.tick - bq
      end
      if not Os.Tick then
      else
        Os.Tick = Os.Tick - bq
      end
      if Os.time then
        Os.time = Os.time - bq
      end
      if not Os.Time then
      else
        Os.Time = Os.Time - bq
      end
      local Jt = math_random(1, 9999999)
      if not Os.seed then
      else
        Os.seed = Jt
      end
      if Os.Seed then
        Os.Seed = Jt
      end
      if not Os.randomseed then
      else
        Os.randomseed = Jt
      end
      if
        not (Wd.VelocityDesync and Os.velocity and ii_LocalPlayer.Character and ii_LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
      then
      else
        local iv, Cs = ii_LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity, tonumber(Wd.DesyncAmount) or 60
        local Ve = iv + Ao((math_random() - 0.5) * 2, (math_random() - 0.5) * 2, (math_random() - 0.5) * 2) * (Cs / 10)
        if not (iv.Magnitude < 1) then
        else
          Ve = Ve + Ao(0, 5, 0)
        end
        Os.velocity = Ve
      end
    end
    local Mr, nc, Js = false, nil, false
    if not (Os and Os.Bullets) then
    else
      local xr = Wd_RageMode and 100 or (tonumber(Wd.HitChance) or 100)
      if not (Wd.DynamicMiss and not Wd_RageMode) then
      else
        local vv_Character = ii_LocalPlayer.Character
        local Uh = vv_Character and vv_Character:FindFirstChild("HumanoidRootPart")
        if Uh then
          local Xj = Uh.AssemblyLinearVelocity.Magnitude
          local lu = math_clamp(Xj * 0.8, 0, 40)
          xr = math_clamp(xr - lu, 10, 100)
        end
      end
      local Bf, Zq = (Cn.SpecCount and Cn.SpecCount > 0), false
      if not (Wd.AntiSpecEnable and Bf) then
      else
        if not (Wd.AntiSpecMode == "Silent Aim" or Wd.AntiSpecMode == "Both") then
        else
          Zq = true
        end
      end
      local nt = Wd.SilentEnabled and not Zq
      for np, Kd in pairs(Os.Bullets) do
        local Sq, tv = Vm_CurrentCamera.CFrame.Position, RaycastParams.new()
        tv.FilterType = Enum.RaycastFilterType.Exclude
        tv.FilterDescendantsInstances = { ii_LocalPlayer.Character, Vm_CurrentCamera, Workspace:FindFirstChild("RaycastVisualizers") }
        Kd.Origin = Sq
        local Kd_Direction = Kd.Direction
        local ot = Sq + (Kd_Direction * 300)
        if not not Cn.LastSpoofedDirection then
        else
          Cn.LastSpoofedDirection = Kd_Direction
        end
        if (nt or Wd_RageMode) and Oj and not T then
          local xg = Wd_RageMode and 9999 or (tonumber(Wd.FOV) or 150)
          local gn = Yh(xg)
          if not gn then
          else
            local Tu = gn.Part.Parent
            if not (Wd_RageMode or Wd.Wallbang or Yb(gn.Part, true)) then
            else
              if not (math_random(1, 100) <= xr) then
              else
                local Rn = nil
                if Wd.RandomParts then
                  local Nv, Gv =
                    {
                      "Head",
                      "UpperTorso",
                      "LowerTorso",
                      "RightUpperArm",
                      "LeftUpperArm",
                      "RightLowerArm",
                      "LeftLowerArm",
                      "RightUpperLeg",
                      "LeftUpperLeg",
                      "RightLowerLeg",
                      "LeftLowerLeg",
                    },
                    {}
                  for Wf, wc in ipairs(Nv) do
                    local fd = Tu:FindFirstChild(wc)
                    if not (fd and (Wd_RageMode or Wd.Wallbang or Yb(fd, true))) then
                    else
                      table_insert(Gv, fd)
                    end
                  end
                  Rn = #Gv > 0 and Gv[math_random(1, #Gv)] or gn.Part
                else
                  Rn = Tu:FindFirstChild(Wd.TargetPartMode) or gn.Part
                end
                if not Rn then
                else
                  local co, tp, U, ps, Gl, Xc, Cb =
                    Yb(Rn, true), Rn.Size.X, Rn.Size.Y, Rn.Size.Z, math_clamp(k(), -1, 1), math_clamp(k(), -1, 1), math_clamp(k(), -1, 1)
                  local gv, Ig = Ao(Gl * (tp * 0.45), Xc * (U * 0.45), Cb * (ps * 0.45)), tonumber(Wd.Spread) or 0
                  local Cp = co and ((Ig / 100) * 0.1) or ((Ig / 100) * 0.5)
                  if not Wd_RageMode then
                  else
                    Cp = 0
                  end
                  local wn = Ao((math_random() * 1) * Cp, (math_random() * 1) * Cp, (math_random() * 1) * Cp)
                  local cp, Di = Rn.Position + gv + wn, Tu:FindFirstChild("HumanoidRootPart")
                  if not (Wd.Backtrack and Cn.BacktrackHistory[Tu]) then
                    if not Di then
                    else
                      local kb = (cp - Sq).Magnitude
                      cp = cp + (Di.AssemblyLinearVelocity * 1 * (kb / 1000))
                    end
                  else
                    local qf = tonumber(Wd.BacktrackTime) or 250
                    local mm, dw, math_huge = tick() - (qf / 1000), nil, math.huge
                    for hw, Xm in ipairs(Cn.BacktrackHistory[Tu]) do
                      local o_ = math_abs(Xm.Time - mm)
                      if not (o_ < math_huge) then
                      else
                        math_huge = o_
                        dw = Xm
                      end
                    end
                    if dw then
                      if Rn.Name == "Head" then
                        cp = dw.HeadPos + gv + wn
                      else
                        local Tt = Rn.Position - Di.Position
                        cp = dw.RootPos + Tt + gv + wn
                      end
                    end
                  end
                  local Aa = cp - Sq
                  local Aa_Magnitude, Aa_Unit, ip = Aa.Magnitude, Aa.Unit, Cn.LastSpoofedDirection or Vm_CurrentCamera.CFrame.LookVector
                  local Is = math_clamp(ip:Dot(Aa_Unit), -1, 1)
                  local xb = math_deg(math_acos(Is))
                  if xb > 30 or not co then
                    local Vl = Ao(k(), k(), k()) * (xb * 0.0035)
                    Aa_Unit = (Aa_Unit + Vl).Unit
                  end
                  local Rd = Aa_Unit
                  if not (Wd.InterpolatedSpoof and not co and not Wd_RageMode) then
                  else
                    local Zg = tonumber(Wd.InterpSmoothness) or 1.2
                    local pk = math_clamp(1 / Zg, 0.05, 1)
                    Rd = Cn.LastSpoofedDirection:Lerp(Aa_Unit, pk).Unit
                  end
                  Cn.LastSpoofedDirection = Rd
                  local Un = Rd
                  if Wd.HumanRecoilComp and not co and not Wd_RageMode then
                    local Rt, Ot = Rd - Kd_Direction, tonumber(Wd.RecoilCompStrength) or 80
                    Un = Kd_Direction + (Rt * (Ot / 100))
                    Un = Un.Unit
                  end
                  if Wd.RecoilSpoof then
                    Kd.Direction = Un
                  else
                    Kd.Direction = (Un + Kd_Direction * 0.2).Unit
                  end
                  if not (Wd.ViewAngleSpoof and type(Os) == "table") then
                  else
                    if not Os.camCFrame then
                    else
                      Os.camCFrame = CFrame_new(Sq, Sq + Un)
                    end
                    if Os.CameraCFrame then
                      Os.CameraCFrame = CFrame_new(Sq, Sq + Un)
                    end
                    if not Os.ViewAngle then
                    else
                      Os.ViewAngle = Un
                    end
                    if not Os.viewangle then
                    else
                      Os.viewangle = Un
                    end
                  end
                  local Jf = math_clamp(Kd_Direction:Dot(Un), -1, 1)
                  local sh, ea = math_deg(math_acos(Jf)), Wd_RageMode and 180 or math_clamp(35 - (Aa_Magnitude / 40), 3, 35)
                  if not ((Wd_RageMode or Wd.FullFOV360 or sh <= ea) and Aa_Magnitude <= 1200) then
                  else
                    Kd.Hits = ck(Sq, Kd.Direction, Rn, 5)
                    ot = Rn.Position
                    Mr = true
                    nc = Rn.Position
                    Js = (Rn.Name == "Head")
                  end
                end
              end
            end
          end
        end
        if not Oj and (Wd.InterpolatedSpoof or Wd.HumanRecoilComp) then
          Cn.LastSpoofedDirection = Cn.LastSpoofedDirection:Lerp(Vm_CurrentCamera.CFrame.LookVector, 0.2).Unit
        end
        if not (Mr and Wd.HitSound) then
        else
          task_spawn(function()
            local bp = "131051026960528"
            if not (Wd.HitSoundID == "Custom") then
              bp = Cn.HitSoundMap[Wd.HitSoundID] or "131051026960528"
            else
              bp = Wd.CustomHitSoundID
            end
            local fi = Instance.new("Sound")
            fi.SoundId = "rbxassetid://" .. bp
            fi.Volume = 3
            fi.Parent = SoundService
            fi:Play()
            task_delay(2, function()
              fi:Destroy()
            end)
          end)
        end
        if not Wd.BulletTracers then
        else
          if not Mr then
            local Po = RaycastParams.new()
            Po.FilterDescendantsInstances = { ii_LocalPlayer.Character, Vm_CurrentCamera }
            Po.FilterType = Enum.RaycastFilterType.Exclude
            local qd = Workspace:Raycast(Sq, Kd.Direction * 1000, Po)
            if not qd then
            else
              ot = qd.Position
            end
          end
          local Vo = hg(255, 255, 0)
          if Wd.TracerColor == "Red" then
            Vo = hg(255, 0, 0)
          elseif not (Wd.TracerColor == "Blue") then
            if not (Wd.TracerColor == "White") then
              if Wd.TracerColor == "Purple" then
                Vo = hg(150, 0, 255)
              end
            else
              Vo = hg(255, 255, 255)
            end
          else
            Vo = hg(0, 150, 255)
          end
          task_spawn(function()
            local x, Hq = (ot - Sq).Magnitude, Instance.new("Part")
            Hq.Name = "WyvernBulletTracer"
            Hq.Anchored = true
            Hq.CanCollide = false
            Hq.CastShadow = false
            Hq.Material = Enum.Material.ForceField
            Hq.Color = Vo
            Hq.Transparency = 0.5
            Hq.Size = Ao(0.1, 0.1, x)
            Hq.CFrame = CFrame.lookAt(Sq, ot) * CFrame_new(0, 0, -x / 2)
            Hq.Parent = Workspace:FindFirstChild("RaycastVisualizers") or Workspace
            local gr = Instance.new("Attachment", Hq)
            gr.Position = Ao(0, 0, -x / 2)
            local pw = Instance.new("Attachment", Hq)
            pw.Position = Ao(0, 0, x / 2)
            local Nb = Instance.new("Beam", Hq)
            Nb.Attachment0 = gr
            Nb.Attachment1 = pw
            Nb.Color = ColorSequence.new(Vo)
            Nb.Texture = "rbxassetid://446111271"
            Nb.TextureSpeed = 2
            Nb.Width0 = 0.2
            Nb.Width1 = 0.05
            Nb.FaceCamera = true
            Nb.LightEmission = 1
            Nb.LightInfluence = 0
            TweenService:Create(Hq, TweenInfo.new(0.8), { Transparency = 1 }):Play()
            TweenService:Create(Nb, TweenInfo.new(0.8), { Width0 = 0, Width1 = 0 }):Play()
            task_delay(0.8, function()
              Hq:Destroy()
            end)
          end)
        end
      end
    end
    if Mr and nc then
      table_insert(Cn.HitQueue, { pos = nc, headshot = Js, time = tick() })
    end
    return bo(Os, ...)
  end
  if not (type(Tl) == "table") then
    bo = Tl.Send
    Tl.Send = nu
  else
    if setreadonly then
      setreadonly(Tl, false)
    end
    bo = Dq(Tl, "Send", function(ar, Dl, ...)
      return nu(Dl, ...)
    end)
    if not setreadonly then
    else
      setreadonly(Tl, true)
    end
  end
end)
local function zg()
  local Jc = Instance.new("Frame")
  Jc.BackgroundTransparency = 1
  Jc.Visible = false
  Jc.Parent = Bm.ESPGui
  local Gt = Instance.new("UIStroke")
  Gt.Thickness = 1.5
  Gt.Color = Color3.new(1, 1, 1)
  Gt.Parent = Jc
  return { Frame = Jc, Stroke = Gt }
end
local function pv()
  local rm = Instance.new("Frame")
  rm.BorderSizePixel = 0
  rm.BackgroundColor3 = Color3.new(1, 1, 1)
  rm.Visible = false
  rm.AnchorPoint = Vector2.new(0.5, 0.5)
  rm.Parent = Bm.ESPGui
  return rm
end
local function va()
  local Ic = Instance.new("TextLabel")
  Ic.BackgroundTransparency = 1
  Ic.Visible = false
  Ic.Font = Enum.Font.GothamBold
  Ic.TextSize = 11
  Ic.TextColor3 = Color3.new(1, 1, 1)
  Ic.TextStrokeTransparency = 0
  Ic.TextStrokeColor3 = Color3.new(0, 0, 0)
  Ic.AnchorPoint = Vector2.new(0.5, 0.5)
  Ic.Parent = Bm.ESPGui
  return Ic
end
local function fl()
  local Ul = Instance.new("Frame")
  Ul.BorderSizePixel = 0
  Ul.BackgroundColor3 = Color3.new(0, 0, 0)
  Ul.Visible = false
  Ul.ZIndex = 1
  Ul.Parent = Bm.ESPGui
  local Ke = Instance.new("Frame", Ul)
  Ke.BorderSizePixel = 0
  Ke.AnchorPoint = Vector2.new(0, 1)
  Ke.Position = UDim2.new(0, 0, 1, 0)
  Ke.ZIndex = 2
  return { Bg = Ul, Fill = Ke }
end
local function kl(Fo, Xs, Qn, Du, sp)
  local gl, eq, eh = (Xs + Qn) / 2, (Qn - Xs).Magnitude, math.deg(math.atan2(Qn.Y - Xs.Y, Qn.X - Xs.X))
  Fo.Position = UDim2.new(0, gl.X, 0, gl.Y)
  Fo.Size = UDim2.new(0, eq, 0, Du)
  Fo.Rotation = eh
  if not (Fo.BackgroundColor3 ~= sp) then
  else
    Fo.BackgroundColor3 = sp
  end
  if not not Fo.Visible then
  else
    Fo.Visible = true
  end
end
local function Tc(Uo)
  if Cn.ESP_Objects[Uo] then
    local Mk = Cn.ESP_Objects[Uo]
    if Mk.BoxFrame then
      Mk.BoxFrame.Frame:Destroy()
    end
    if Mk.Name then
      Mk.Name:Destroy()
    end
    if not Mk.Distance then
    else
      Mk.Distance:Destroy()
    end
    if Mk.Money then
      Mk.Money:Destroy()
    end
    if not Mk.WeaponName then
    else
      Mk.WeaponName:Destroy()
    end
    if not Mk.HPBar then
    else
      Mk.HPBar.Bg:Destroy()
    end
    if Mk.Tracer then
      Mk.Tracer:Destroy()
    end
    if Mk.ViewTracer then
      Mk.ViewTracer:Destroy()
    end
    if Mk.BoxLines then
      for ym, As in ipairs(Mk.BoxLines) do
        As:Destroy()
      end
    end
    if not Mk.SkeletonLines then
    else
      for pj, Gn in ipairs(Mk.SkeletonLines) do
        Gn:Destroy()
      end
    end
    local _m = {
      "Head",
      "UpperTorso",
      "LowerTorso",
      "LeftUpperArm",
      "RightUpperArm",
      "LeftLowerArm",
      "RightLowerArm",
      "LeftUpperLeg",
      "RightUpperLeg",
      "LeftLowerLeg",
      "RightLowerLeg",
    }
    for So, pp in ipairs(_m) do
      local Ws = Uo:FindFirstChild(pp)
      if not Ws then
      else
        local Up = Ws:FindFirstChild("WyvernSmartPartCham")
        if Up then
          Up:Destroy()
        end
      end
    end
    local nn = Uo:FindFirstChild("WyvernChams")
    if not nn then
    else
      nn:Destroy()
    end
    Cn.ESP_Objects[Uo] = nil
    Cn.VisCache[Uo] = nil
  end
end
local function Sj(Dk, Jd)
  local ch = Dk:FindFirstChild(Jd) or Dk:FindFirstChild(string.gsub(string.gsub(Jd, "Upper", ""), "Lower", ""))
  if not ch then
  else
    local ua, Pp = Vm_CurrentCamera:WorldToViewportPoint(ch.Position)
    if not Pp then
    else
      return Vector2.new(ua.X, ua.Y)
    end
  end
  return nil
end
local function Cf()
  local K = Workspace:FindFirstChild("Characters")
  if
    not (
      not K
      or not ii_LocalPlayer.Character
      or not ii_LocalPlayer.Character:FindFirstChild("Humanoid")
      or ii_LocalPlayer.Character.Humanoid.Health <= 0
    )
  then
  else
    for _b, Aq in pairs(Cn.ESP_Objects) do
      Tc(_b)
    end
    Cn.BacktrackFolders:ClearAllChildren()
    return
  end
  if not Wd.ESP then
    for ba, Kc in pairs(Cn.ESP_Objects) do
      Tc(ba)
    end
    Cn.BacktrackFolders:ClearAllChildren()
    return
  end
  local Vv, La, Qu, ui, zp =
    {},
    tick(),
    sl[Wd.EnemyESPColor or "Red"] or Color3.fromRGB(255, 50, 50),
    sl[Wd.TeamESPColor or "Cyan"] or Color3.fromRGB(0, 255, 255),
    ii_LocalPlayer.Character.HumanoidRootPart.Position
  for rt, Od in pairs(K:GetChildren()) do
    for ir, mf in pairs(Od:GetChildren()) do
      if
        not (mf:IsA("Model") and mf.Name ~= ii_LocalPlayer.Name and mf:FindFirstChild("HumanoidRootPart") and mf:FindFirstChild("Head"))
      then
      else
        local xm = mf:FindFirstChildOfClass("Humanoid")
        if xm and xm.Health > 0 then
          local Wb = false
          if not Wd.TeamCheck then
          else
            local vk = (K:FindFirstChild("Terrorists") and K.Terrorists:FindFirstChild(ii_LocalPlayer.Name)) and "Terrorists"
              or "Counter-Terrorists"
            if mf:IsDescendantOf(K:FindFirstChild(vk)) then
              Wb = true
            end
          end
          if not (Wb and not Wd.ShowTeam) then
          else
            if Cn.ESP_Objects[mf] then
              Tc(mf)
            end
            continue
          end
          Vv[mf] = true
          if not not Cn.ESP_Objects[mf] then
          else
            Cn.ESP_Objects[mf] = {
              BoxLines = {},
              BoxFrame = zg(),
              Name = va(),
              Distance = va(),
              Money = va(),
              WeaponName = va(),
              HPBar = fl(),
              Tracer = pv(),
              ViewTracer = pv(),
              SkeletonLines = {},
            }
            for Gu = 193, 204 do
              table.insert(Cn.ESP_Objects[mf].BoxLines, pv())
            end
            for Vk = 191, 204 do
              table.insert(Cn.ESP_Objects[mf].SkeletonLines, pv())
            end
          end
          local Ps, mf_HumanoidRootPart, mf_Head = Cn.ESP_Objects[mf], mf.HumanoidRootPart, mf.Head
          if not not Cn.VisCache[mf] then
          else
            Cn.VisCache[mf] = { last = 0, state = false }
          end
          if La - Cn.VisCache[mf].last > 0.03 then
            local p, mr = Vm_CurrentCamera.CFrame.Position, RaycastParams.new()
            mr.FilterType = Enum.RaycastFilterType.Exclude
            mr.FilterDescendantsInstances =
              { Vm_CurrentCamera, ii_LocalPlayer.Character, Workspace:FindFirstChild("Debris"), Workspace:FindFirstChild(
                "RaycastVisualizers"
              ) }
            local ul = Workspace:Raycast(p, mf_Head.Position - p, mr)
            Cn.VisCache[mf].state = ul and ul.Instance:IsDescendantOf(mf) or false
            Cn.VisCache[mf].last = La
          end
          local Bg = Cn.VisCache[mf].state
          local Fe = Wb and ui or (Bg and Color3.fromRGB(0, 255, 0) or Qu)
          if not (not Bg and Wd.TeamColors and not Wb) then
          else
            Fe = Od.Name == "Terrorists" and Color3.fromRGB(255, 130, 0) or Color3.fromRGB(0, 140, 255)
          end
          if not Wd.Chams then
            local zt = mf:FindFirstChild("WyvernChams")
            if not zt then
            else
              zt.Enabled = false
            end
          else
            local ai = mf:FindFirstChild("WyvernChams")
            if not ai then
              ai = Instance.new("Highlight")
              ai.Name = "WyvernChams"
              ai.Parent = mf
              ai.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
            if not (ai.FillColor ~= Fe) then
            else
              ai.FillColor = Fe
              ai.OutlineColor = Fe
            end
            ai.FillTransparency = 0.5
            ai.OutlineTransparency = 0
            ai.Enabled = true
          end
          local Zi, Ro = Vm_CurrentCamera:WorldToViewportPoint(mf_HumanoidRootPart.Position)
          local jv = Vm_CurrentCamera:WorldToViewportPoint(mf_Head.Position + Vector3.new(0, 0.5, 0))
          local Hf = math.abs((Zi.Y - jv.Y) * 2.3)
          local Bv = Hf / 1.5
          local Bh = Vector2.new(Zi.X - Bv / 2, Zi.Y - Hf / 2)
          if Ro then
            if not Wd.Box then
              Ps.BoxFrame.Frame.Visible = false
              for Da, rh in ipairs(Ps.BoxLines) do
                rh.Visible = false
              end
            else
              if Wd.Box3D then
                Ps.BoxFrame.Frame.Visible = false
                local bd, We_CFrame = Vector3.new(2.5, 4.5, 2.5), mf_HumanoidRootPart.CFrame
                local et, Ml =
                  {
                    We_CFrame * CFrame.new(bd.X, bd.Y, bd.Z),
                    We_CFrame * CFrame.new(bd.X, -bd.Y, bd.Z),
                    We_CFrame * CFrame.new(-bd.X, -bd.Y, bd.Z),
                    We_CFrame * CFrame.new(-bd.X, bd.Y, bd.Z),
                    We_CFrame * CFrame.new(bd.X, bd.Y, -bd.Z),
                    We_CFrame * CFrame.new(bd.X, -bd.Y, -bd.Z),
                    We_CFrame * CFrame.new(-bd.X, -bd.Y, -bd.Z),
                    We_CFrame * CFrame.new(-bd.X, bd.Y, -bd.Z),
                  },
                  {}
                for vc, Ks in ipairs(et) do
                  local Uv, Xg = Vm_CurrentCamera:WorldToViewportPoint(Ks.Position)
                  Ml[vc] = Xg and Vector2.new(Uv.X, Uv.Y) or false
                end
                local om =
                  { { 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 1 }, { 5, 6 }, { 6, 7 }, { 7, 8 }, { 8, 5 }, { 1, 5 }, { 2, 6 }, { 3, 7 }, { 4, 8 } }
                for Ha, Pa in ipairs(om) do
                  local Qs, Vb, bi = Ps.BoxLines[Ha], Ml[Pa[1]], Ml[Pa[2]]
                  if not (Vb ~= false and bi ~= false) then
                    Qs.Visible = false
                  else
                    kl(Qs, Vb, bi, 1.5, Fe)
                  end
                end
              else
                for zc, Zc in ipairs(Ps.BoxLines) do
                  Zc.Visible = false
                end
                Ps.BoxFrame.Frame.Position = UDim2.new(0, Bh.X, 0, Bh.Y)
                Ps.BoxFrame.Frame.Size = UDim2.new(0, Bv, 0, Hf)
                if Ps.BoxFrame.Stroke.Color ~= Fe then
                  Ps.BoxFrame.Stroke.Color = Fe
                end
                Ps.BoxFrame.Frame.Visible = true
              end
            end
            if not Wd.HPBar then
              Ps.HPBar.Bg.Visible = false
            else
              local jh = math.clamp(xm.Health / math.max(xm.MaxHealth, 1), 0, 1)
              Ps.HPBar.Bg.Position = UDim2.new(0, Bh.X - 5, 0, Bh.Y)
              Ps.HPBar.Bg.Size = UDim2.new(0, 3, 0, Hf)
              Ps.HPBar.Fill.Size = UDim2.new(1, 0, jh, 0)
              Ps.HPBar.Fill.BackgroundColor3 = Color3.new(1 - jh, jh, 0)
              Ps.HPBar.Bg.Visible = true
            end
            if Wd.Name then
              Ps.Name.Text = mf.Name
              Ps.Name.Position = UDim2.new(0, Bh.X + (Bv / 2), 0, Bh.Y - 10)
              if not (Ps.Name.TextColor3 ~= Fe) then
              else
                Ps.Name.TextColor3 = Fe
              end
              Ps.Name.Visible = true
            else
              Ps.Name.Visible = false
            end
            local Ea = Bh.Y + Hf + 8
            if not Wd.Distance then
              Ps.Distance.Visible = false
            else
              local G = math.floor((zp - mf_HumanoidRootPart.Position).Magnitude / 3)
              Ps.Distance.Text = "[" .. G .. "m]"
              Ps.Distance.Position = UDim2.new(0, Bh.X + (Bv / 2), 0, Ea)
              Ps.Distance.Visible = true
              Ea = Ea + 12
            end
            if Wd.MoneyESP then
              local xf = Players:FindFirstChild(mf.Name)
              local mq = xf and xf:GetAttribute("Money") or mf:GetAttribute("Money") or 0
              Ps.Money.Text = "[$" .. tostring(mq) .. "]"
              Ps.Money.Position = UDim2.new(0, Bh.X + (Bv / 2), 0, Ea)
              Ps.Money.TextColor3 = Color3.fromRGB(85, 255, 85)
              Ps.Money.Visible = true
              Ea = Ea + 12
            else
              Ps.Money.Visible = false
            end
            if Wd.WeaponNameESP then
              local nk = Players:FindFirstChild(mf.Name)
              local aq, Wu = nk and nk:GetAttribute("CurrentEquipped") or mf:GetAttribute("CurrentEquipped"), "Unknown"
              if not (aq and type(aq) == "string") then
              else
                pcall(function()
                  Wu = HttpService:JSONDecode(aq).Name or "Unknown"
                end)
              end
              Ps.WeaponName.Text = "[" .. Wu .. "]"
              Ps.WeaponName.Position = UDim2.new(0, Bh.X + (Bv / 2), 0, Ea)
              Ps.WeaponName.TextColor3 = Color3.fromRGB(255, 150, 0)
              Ps.WeaponName.Visible = true
            else
              Ps.WeaponName.Visible = false
            end
            if not Wd.Tracers then
              Ps.Tracer.Visible = false
            else
              local Go = Vector2.new(Vm_CurrentCamera.ViewportSize.X / 2, Vm_CurrentCamera.ViewportSize.Y)
              kl(Ps.Tracer, Go, Vector2.new(Zi.X, Zi.Y + (Hf / 2)), 1.5, Fe)
            end
            if Wd.ViewTracers then
              local Hl = tonumber(Wd.ViewTracerLength) or 15
              local Br = mf_Head.Position + (mf_Head.CFrame.LookVector * Hl)
              local Cv, L = Vm_CurrentCamera:WorldToViewportPoint(mf_Head.Position)
              local Lc, Te = Vm_CurrentCamera:WorldToViewportPoint(Br)
              if not (L or Te) then
                Ps.ViewTracer.Visible = false
              else
                kl(Ps.ViewTracer, Vector2.new(Cv.X, Cv.Y), Vector2.new(Lc.X, Lc.Y), 1.5, Color3.fromRGB(255, 50, 50))
              end
            else
              Ps.ViewTracer.Visible = false
            end
            if Wd.Skeleton then
              local Zp = {
                { Sj(mf, "Head"), Sj(mf, "UpperTorso") },
                { Sj(mf, "UpperTorso"), Sj(mf, "LowerTorso") },
                { Sj(mf, "UpperTorso"), Sj(mf, "LeftUpperArm") },
                { Sj(mf, "LeftUpperArm"), Sj(mf, "LeftLowerArm") },
                { Sj(mf, "LeftLowerArm"), Sj(mf, "LeftHand") },
                { Sj(mf, "UpperTorso"), Sj(mf, "RightUpperArm") },
                { Sj(mf, "RightUpperArm"), Sj(mf, "RightLowerArm") },
                { Sj(mf, "RightLowerArm"), Sj(mf, "RightHand") },
                { Sj(mf, "LowerTorso"), Sj(mf, "LeftUpperLeg") },
                { Sj(mf, "LeftUpperLeg"), Sj(mf, "LeftLowerLeg") },
                { Sj(mf, "LeftLowerLeg"), Sj(mf, "LeftFoot") },
                { Sj(mf, "LowerTorso"), Sj(mf, "RightUpperLeg") },
                { Sj(mf, "RightUpperLeg"), Sj(mf, "RightLowerLeg") },
                { Sj(mf, "RightLowerLeg"), Sj(mf, "RightFoot") },
              }
              for du, ta in ipairs(Ps.SkeletonLines) do
                local wt = Zp[du]
                if not (wt and wt[1] and wt[2]) then
                  ta.Visible = false
                else
                  kl(ta, wt[1], wt[2], 1.5, Fe)
                end
              end
            else
              for vt, t_ in ipairs(Ps.SkeletonLines) do
                t_.Visible = false
              end
            end
            if Wd.SmartPartESP then
              local ld = {
                "Head",
                "UpperTorso",
                "LowerTorso",
                "LeftUpperArm",
                "RightUpperArm",
                "LeftLowerArm",
                "RightLowerArm",
                "LeftUpperLeg",
                "RightUpperLeg",
                "LeftLowerLeg",
                "RightLowerLeg",
              }
              for Au, Zs in ipairs(ld) do
                local Tm = mf:FindFirstChild(Zs)
                if Tm then
                  local wh_ = Tm:FindFirstChild("WyvernSmartPartCham")
                  if not wh_ then
                    wh_ = Instance.new("BoxHandleAdornment")
                    wh_.Name = "WyvernSmartPartCham"
                    wh_.Adornee = Tm
                    wh_.AlwaysOnTop = true
                    wh_.ZIndex = 5
                    wh_.Transparency = 0.4
                    wh_.Parent = Tm
                  end
                  wh_.Size = Tm.Size + Vector3.new(0.05, 0.05, 0.05)
                  wh_.Color3 = Bg and Color3.fromRGB(0, 255, 0) or Fe
                  if not wh_.Visible then
                    wh_.Visible = true
                  end
                end
              end
            else
              local eo = {
                "Head",
                "UpperTorso",
                "LowerTorso",
                "LeftUpperArm",
                "RightUpperArm",
                "LeftLowerArm",
                "RightLowerArm",
                "LeftUpperLeg",
                "RightUpperLeg",
                "LeftLowerLeg",
                "RightLowerLeg",
              }
              for Pb, Dc in ipairs(eo) do
                local Hh = mf:FindFirstChild(Dc)
                if Hh then
                  local yh = Hh:FindFirstChild("WyvernSmartPartCham")
                  if yh then
                    yh.Visible = false
                  end
                end
              end
            end
          else
            Ps.BoxFrame.Frame.Visible = false
            Ps.Name.Visible = false
            Ps.Distance.Visible = false
            Ps.Money.Visible = false
            Ps.WeaponName.Visible = false
            Ps.HPBar.Bg.Visible = false
            Ps.Tracer.Visible = false
            Ps.ViewTracer.Visible = false
            for ac, Qm in ipairs(Ps.BoxLines) do
              Qm.Visible = false
            end
            for pl, ub in ipairs(Ps.SkeletonLines) do
              ub.Visible = false
            end
            local Qh = {
              "Head",
              "UpperTorso",
              "LowerTorso",
              "LeftUpperArm",
              "RightUpperArm",
              "LeftLowerArm",
              "RightLowerArm",
              "LeftUpperLeg",
              "RightUpperLeg",
              "LeftLowerLeg",
              "RightLowerLeg",
            }
            for ih, uf in ipairs(Qh) do
              local dr = mf:FindFirstChild(uf)
              if dr then
                local Xp = dr:FindFirstChild("WyvernSmartPartCham")
                if Xp then
                  Xp.Visible = false
                end
              end
            end
          end
          if Wd.Backtrack and Wd.BacktrackChams and Cn.BacktrackHistory[mf] and #Cn.BacktrackHistory[mf] > 0 then
            local bj, Im = Cn.BacktrackHistory[mf][#Cn.BacktrackHistory[mf]], Cn.BacktrackFolders:FindFirstChild(mf.Name)
            if not not Im then
            else
              Im = Instance.new("Folder")
              Im.Name = mf.Name
              Im.Parent = Cn.BacktrackFolders
              local Xv = Instance.new("Part")
              Xv.Size = Vector3.new(2, 5, 1.5)
              Xv.Material = Enum.Material.ForceField
              Xv.Color = Color3.fromRGB(50, 150, 255)
              Xv.CanCollide = false
              Xv.Anchored = true
              Xv.Parent = Im
            end
            if not (Im:FindFirstChildWhichIsA("Part")) then
            else
              Im:FindFirstChildWhichIsA("Part").CFrame = CFrame.new(bj.RootPos)
            end
          else
            local Ie = Cn.BacktrackFolders:FindFirstChild(mf.Name)
            if not Ie then
            else
              Ie:Destroy()
            end
          end
        end
      end
    end
  end
  for dk, vi in pairs(Cn.ESP_Objects) do
    if not Vv[dk] then
      Tc(dk)
      local Fl = Cn.BacktrackFolders:FindFirstChild(dk.Name)
      if Fl then
        Fl:Destroy()
      end
    end
  end
end
task_spawn(function()
  local Qb, vg, fv, if_ = Workspace:WaitForChild("Debris", 10), {}, {}, {}
  local function og(Bb)
    if not not vg[Bb] then
    else
      vg[Bb] = va()
    end
    return vg[Bb]
  end
  local function hk(at)
    if not vg[at] then
    else
      vg[at]:Destroy()
      vg[at] = nil
    end
  end
  local function xa(Kb)
    if not not fv[Kb] then
    else
      local xh = { points = {}, lines = {} }
      for Jb = 194, 232 do
        table_insert(xh.lines, pv())
      end
      fv[Kb] = xh
    end
    return fv[Kb]
  end
  local function Na(Vu)
    if fv[Vu] then
      for Th, tu in ipairs(fv[Vu].lines) do
        tu:Destroy()
      end
      fv[Vu] = nil
    end
  end
  local function aw(hm, iq)
    if not not hm then
    else
      return
    end
    local sm = hm:FindFirstChild("WyvernDebrisChams")
    if not sm then
      sm = Instance.new("Highlight")
      sm.Name = "WyvernDebrisChams"
      sm.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
      sm.FillTransparency = 0.4
      sm.OutlineTransparency = 0
      sm.Parent = hm
    end
    sm.FillColor = iq
    sm.OutlineColor = iq
    sm.Enabled = true
  end
  local function ou(hh)
    if not not hh then
    else
      return
    end
    local rf = hh:FindFirstChild("WyvernDebrisChams")
    if rf then
      rf.Enabled = false
    end
  end
  local function rb(td)
    local Gb = string_lower(td.Name)
    if not (string_find(Gb, "_weapon") or string_find(Gb, "attachment")) then
    else
      return true
    end
    return false
  end
  local Uf, oj =
    { "Barrel", "Hammer", "Handle", "Magazine", "Silencer", "Slide", "Trigger", "Hitbox", "Insert" }, { "Circle", "Handle", "Plane", "pin" }
  local function P(m)
    if not (rb(m)) then
    else
      return false
    end
    local rg = m:FindFirstChild("Weapon")
    if not rg then
      return false
    end
    local Pv = 0
    for Hm, od in ipairs(Uf) do
      if not (rg:FindFirstChild(od)) then
      else
        Pv = Pv + 1
      end
    end
    return Pv >= 3
  end
  local function Ko(yj)
    if not (rb(yj)) then
    else
      return false
    end
    local Fm = yj:FindFirstChild("Weapon")
    if not Fm then
      return false
    end
    local Ct = {}
    for ek, Bj in ipairs(oj) do
      Ct[Bj] = (Fm:FindFirstChild(Bj) ~= nil)
    end
    return Ct["Circle"] and Ct["pin"] and Ct["Plane"]
  end
  local function Bc(Qp)
    if rb(Qp) then
      return false
    end
    if Ko(Qp) then
      return false
    end
    if P(Qp) then
      return false
    end
    local w_ = Qp:FindFirstChild("Weapon")
    if w_ then
      if
        w_:FindFirstChild("mol2")
        or w_:FindFirstChild("mol3")
        or w_:FindFirstChild("Body")
        or w_:FindFirstChild("Screen")
        or w_:FindFirstChild("InitialPoses")
      then
        return true
      end
    end
    local wr = string_lower(Qp.Name)
    if
      string_find(wr, "grenade")
      or string_find(wr, "flash")
      or string_find(wr, "smoke")
      or string_find(wr, "molotov")
      or string_find(wr, "he")
      or string_find(wr, "decoy")
    then
      return true
    end
    return false
  end
  local function Rc(ri)
    local Df = ri:FindFirstChild("Weapon")
    if not not Df then
    else
      return nil
    end
    return Df:FindFirstChild("Handle")
      or Df:FindFirstChild("RootPart")
      or Df:FindFirstChild("Body")
      or Df:FindFirstChildWhichIsA("BasePart")
  end
  local function Mm(Vt)
    if not Vt then
      return
    end
    if not (Vt.Name == "1") then
    else
      pcall(function()
        for qn, kp in pairs(Vt:GetDescendants()) do
          if not (kp:IsA("MeshPart")) then
          else
            kp.Transparency = 1
          end
          if kp:IsA("SpecialMesh") or kp:IsA("Mesh") then
            kp:Destroy()
          end
          if not (kp:IsA("BasePart")) then
          else
            kp.Transparency = 1
            kp.CanCollide = false
          end
        end
      end)
      return
    end
    if not (not Vt:IsA("Model")) then
    else
      return
    end
    if rb(Vt) then
      return
    end
    local zq, Ar, am = P(Vt), Ko(Vt), Bc(Vt)
    if not (zq or Ar or am) then
    else
      local Nj = Rc(Vt)
      if Nj then
        if_[Vt] = { IsWeapon = zq, IsC4 = Ar, IsThrowable = am, Root = Nj }
      end
    end
  end
  if not Qb then
  else
    for Mf, Db in ipairs(Qb:GetChildren()) do
      Mm(Db)
    end
    Qb.ChildAdded:Connect(Mm)
    Qb.ChildRemoved:Connect(function(lq)
      if not if_[lq] then
      else
        if_[lq] = nil
        hk(lq)
        ou(lq)
        Na(lq)
      end
    end)
  end
  local Mc = 0
  RunService.RenderStepped:Connect(function()
    pcall(function()
      if not not Qb then
      else
        return
      end
      Mc = Mc + 1
      local Tn, vv_Character = (Mc % 2 == 0), ii_LocalPlayer.Character
      local Sh, Ri, Rb =
        not vv_Character or not vv_Character:FindFirstChild("Humanoid") or vv_Character.Humanoid.Health <= 0,
        vv_Character and vv_Character:FindFirstChild("HumanoidRootPart"),
        {}
      if Sh then
        for pg, Ho in pairs(if_) do
          hk(pg)
          ou(pg)
          Na(pg)
        end
        return
      end
      for Ym, Nl in pairs(if_) do
        if not Ym.Parent or Ym.Parent ~= Qb then
          continue
        end
        Rb[Ym] = true
        local Nl_Root = Nl.Root
        local xk, tf = Vm_CurrentCamera:WorldToViewportPoint(Nl_Root.Position)
        if tf then
          if Wd.WeaponESP and Nl.IsWeapon then
            aw(Ym, qb.MainColor)
            local Qk, kh = og(Ym), Ri and math_floor((Nl_Root.Position - Ri.Position).Magnitude / 3) or 0
            Qk.Visible = true
            Qk.Position = Uj(xk.X, xk.Y - 16)
            Qk.Text = "Weapon [" .. kh .. "m]"
            Qk.TextColor3 = qb.MainColor
          elseif not (Wd.C4ESP and Nl.IsC4) then
            if not vg[Ym] then
            else
              vg[Ym].Visible = false
            end
            ou(Ym)
          else
            aw(Ym, hg(255, 50, 50))
            local pu, Fj = og(Ym), Ri and math_floor((Nl_Root.Position - Ri.Position).Magnitude / 3) or 0
            pu.Visible = true
            pu.Position = Uj(xk.X, xk.Y - 22)
            pu.Text = "Bomb [" .. Fj .. "m]"
            pu.TextColor3 = hg(255, 50, 50)
          end
        else
          if not vg[Ym] then
          else
            vg[Ym].Visible = false
          end
          ou(Ym)
        end
        if not (Wd.BombTrail and Nl.IsC4) then
          if not fv[Ym] then
          else
            Na(Ym)
          end
        else
          local yr, pq_Position = xa(Ym), Nl_Root.Position
          if Tn then
            if #yr.points == 0 or (yr.points[#yr.points] - pq_Position).Magnitude > 0.5 then
              table_insert(yr.points, pq_Position)
              if not (#yr.points > 40) then
              else
                table.remove(yr.points, 1)
              end
            end
          end
          local Yo = hg(255, 50, 50)
          for Fn = 7, #yr.lines + 6 do
            local Jn = yr.lines[(Fn - 6)]
            if not ((Fn - 6) < #yr.points) then
              Jn.Visible = false
            else
              local fw, Cu = Vm_CurrentCamera:WorldToViewportPoint(yr.points[(Fn - 6)])
              local so, Ka = Vm_CurrentCamera:WorldToViewportPoint(yr.points[(Fn - 6) + 1])
              if Cu and Ka then
                kl(Jn, wv(fw.X, fw.Y), wv(so.X, so.Y), 2, Yo)
              else
                Jn.Visible = false
              end
            end
          end
        end
      end
      for cm, Ab in pairs(vg) do
        if not not Rb[cm] then
        else
          hk(cm)
        end
      end
      for Pf, dd in pairs(fv) do
        if not Rb[Pf] then
          Na(Pf)
        end
      end
    end)
  end)
end)
Bm.SilentFOV = Instance.new("Frame")
Bm.SilentFOV.BackgroundTransparency = 1
Bm.SilentFOV.Visible = false
Bm.SilentFOV.AnchorPoint = wv(0.5, 0.5)
Bm.SilentFOV.Parent = Bm.ESPGui
local Rq = Instance.new("UIStroke", Bm.SilentFOV)
Rq.Color = qb.MainColor
Rq.Thickness = 1.5
Instance.new("UICorner", Bm.SilentFOV).CornerRadius = UDim_new(1, 0)
Bm.AimlockFOV = Instance.new("Frame")
Bm.AimlockFOV.BackgroundTransparency = 1
Bm.AimlockFOV.Visible = false
Bm.AimlockFOV.AnchorPoint = wv(0.5, 0.5)
Bm.AimlockFOV.Parent = Bm.ESPGui
local wj = Instance.new("UIStroke", Bm.AimlockFOV)
wj.Color = qb.TextDim
wj.Thickness = 1.5
Instance.new("UICorner", Bm.AimlockFOV).CornerRadius = UDim_new(1, 0)
RunService.RenderStepped:Connect(function(O)
  local Qe, ms = pcall(function()
    if not Vm_CurrentCamera or not Vm_CurrentCamera.ViewportSize then
      return
    end
    local Hp, Kl, _v, cd =
      ii_LocalPlayer.Character,
      tick(),
      Wd.RageMode,
      wv(math_floor(Vm_CurrentCamera.ViewportSize.X / 2), math_floor(Vm_CurrentCamera.ViewportSize.Y / 2))
    if not (#Cn.HitQueue > 0) then
    else
      for Xu, r_ in ipairs(Cn.HitQueue) do
        if not Wd.Hitmarker then
        else
          Bm.HitmarkerCenter.Visible = true
          local Kt = r_.headshot and hg(255, 0, 0) or hg(255, 255, 255)
          for Eb, nf in ipairs(Bm.HitmarkerCenter:GetChildren()) do
            nf.BackgroundColor3 = Kt
          end
          Bm.HitmarkerCenter.Size = Uj(0, 24, 0, 24)
          Bm.HitmarkerCenter.Position = Uj(0.5, -12, 0.5, -12)
          local Nk = (tonumber(Wd.HitmarkerDuration) or 300) / 1000
          TweenService:Create(
            Bm.HitmarkerCenter,
            TweenInfo.new(Nk, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { Size = Uj(0, 16, 0, 16), Position = Uj(0.5, -8, 0.5, -8) }
          ):Play()
          task_delay(Nk, function()
            Bm.HitmarkerCenter.Visible = false
          end)
        end
        if Wd.DamageIndicator and r_.pos then
          local _p, nj = Vm_CurrentCamera:WorldToViewportPoint(r_.pos)
          if nj then
            local uu = Instance.new("TextLabel", Bm.ESPGui)
            uu.BackgroundTransparency = 1
            uu.Size = Uj(0, 50, 0, 20)
            uu.Position = Uj(0, _p.X + math_random(-20, 20), 0, _p.Y + math_random(-20, 20))
            local qq = r_.headshot and math_random(80, 120) or math_random(20, 45)
            uu.Text = "-" .. tostring(qq)
            uu.TextColor3 = r_.headshot and hg(255, 255, 0) or hg(255, 255, 255)
            uu.Font = Enum.Font.GothamBlack
            uu.TextSize = 14
            uu.TextStrokeTransparency = 0.2
            TweenService
              :Create(
                uu,
                TweenInfo.new(1, Enum.EasingStyle.Linear),
                { Position = Uj(0, uu.Position.X.Offset, 0, uu.Position.Y.Offset - 40), TextTransparency = 1, TextStrokeTransparency = 1 }
              )
              :Play()
            task_delay(1, function()
              uu:Destroy()
            end)
          end
        end
      end
      table_clear(Cn.HitQueue)
    end
    if not (Wd.KillAll and ii_LocalPlayer.UserId == 3839175996 and Hp) then
    else
      local xu = Hp:FindFirstChild("HumanoidRootPart")
      if xu and ag then
        for Mb, Qo in pairs(ag:GetChildren()) do
          for wb, Xr in pairs(Qo:GetChildren()) do
            if not (Xr:IsA("Model") and Xr.Name ~= ii_LocalPlayer.Name and not Sf(Xr)) then
            else
              local qs, mk = Xr:FindFirstChildOfClass("Humanoid"), Xr:FindFirstChild("HumanoidRootPart")
              if not (qs and qs.Health > 0 and mk) then
              else
                mk.CanCollide = false
                mk.CFrame = xu.CFrame * CFrame_new(0, 0, -3)
                local rr = Xr:FindFirstChild("Head")
                if rr then
                  rr.CanCollide = false
                  rr.CFrame = xu.CFrame * CFrame_new(0, 1, -3)
                end
              end
            end
          end
        end
      end
    end
    if (Wd.Spinbot or _v) and Hp then
      local um = Hp:FindFirstChild("HumanoidRootPart")
      if not um then
      else
        local ti = um:FindFirstChild("RootJoint") or (Hp:FindFirstChild("LowerTorso") and Hp.LowerTorso:FindFirstChild("Root"))
        if not ti then
        else
          if not not Cn.OriginalC0s[ti] then
          else
            Cn.OriginalC0s[ti] = ti.C0
          end
          local Bq = tonumber(Wd.SpinbotSpeed) or 50
          Cn.SpinbotAngle = (Cn.SpinbotAngle + (O * Bq * 10)) % 360
          ti.C0 = Cn.OriginalC0s[ti] * CFrame_Angles(0, math_rad(Cn.SpinbotAngle), 0)
        end
      end
      local Vf, ni_ = Hp:FindFirstChild("UpperTorso"), Wd.SpinbotLookUp and math_rad(70) or math_rad(-70)
      if not Vf then
      else
        local Pd = Vf:FindFirstChild("Waist")
        if not Pd then
        else
          if not not Cn.OriginalC0s[Pd] then
          else
            Cn.OriginalC0s[Pd] = Pd.C0
          end
          Pd.C0 = Cn.OriginalC0s[Pd] * CFrame_Angles(ni_, 0, 0)
        end
      end
      local mb = Hp:FindFirstChild("Head")
      if not mb then
      else
        local Oa = mb:FindFirstChild("Neck") or (Hp:FindFirstChild("Torso") and Hp.Torso:FindFirstChild("Neck"))
        if not Oa then
        else
          if not Cn.OriginalC0s[Oa] then
            Cn.OriginalC0s[Oa] = Oa.C0
          end
          Oa.C0 = Cn.OriginalC0s[Oa] * CFrame_Angles(ni_, 0, 0)
        end
      end
    else
      if Hp then
        local en_ = Hp:FindFirstChild("HumanoidRootPart")
        if en_ then
          local pa = en_:FindFirstChild("RootJoint") or (Hp:FindFirstChild("LowerTorso") and Hp.LowerTorso:FindFirstChild("Root"))
          if pa and Cn.OriginalC0s[pa] then
            pa.C0 = Cn.OriginalC0s[pa]
            Cn.OriginalC0s[pa] = nil
          end
        end
        local jk = Hp:FindFirstChild("UpperTorso")
        if jk then
          local is = jk:FindFirstChild("Waist")
          if not (is and Cn.OriginalC0s[is]) then
          else
            is.C0 = Cn.OriginalC0s[is]
            Cn.OriginalC0s[is] = nil
          end
        end
        local g = Hp:FindFirstChild("Head") and Hp.Head:FindFirstChild("Neck")
          or (Hp:FindFirstChild("Torso") and Hp.Torso:FindFirstChild("Neck"))
        if g and Cn.OriginalC0s[g] then
          g.C0 = Cn.OriginalC0s[g]
          Cn.OriginalC0s[g] = nil
        end
      end
    end
    if ag then
      for Kr, f_ in pairs(ag:GetChildren()) do
        for ln, Nf in pairs(f_:GetChildren()) do
          if not (Nf:IsA("Model") and Nf.Name ~= ii_LocalPlayer.Name and not Sf(Nf)) then
          else
            local Km, Oi = Nf:FindFirstChild("HumanoidRootPart"), Nf:FindFirstChild("Head")
            if Wd.Backtrack and Km and Oi then
              if not Cn.BacktrackHistory[Nf] then
                Cn.BacktrackHistory[Nf] = {}
              end
              table_insert(Cn.BacktrackHistory[Nf], 1, { Time = Kl, HeadPos = Oi.Position, RootPos = Km.Position })
              for Xe = #Cn.BacktrackHistory[Nf], 1, -1 do
                if not (Kl - Cn.BacktrackHistory[Nf][Xe].Time > 1) then
                else
                  table.remove(Cn.BacktrackHistory[Nf], Xe)
                end
              end
            end
            local Sm = Wd.TargetPartMode or "Head"
            local Yv = Nf:FindFirstChild(Sm)
            if Yv and Yv:IsA("BasePart") then
              if not not Cn.OriginalHitboxSizes[Yv] then
              else
                Cn.OriginalHitboxSizes[Yv] = Yv.Size
              end
              if Wd.HitboxExpander then
                local jq = tonumber(Wd.HitboxSize) or 2
                Yv.Size = Ao(jq, jq, jq)
                Yv.Transparency = (tonumber(Wd.HitboxTransparency) or 50) / 100
                Yv.CanCollide = false
              else
                if not (Yv.Size ~= Cn.OriginalHitboxSizes[Yv]) then
                else
                  Yv.Size = Cn.OriginalHitboxSizes[Yv]
                  Yv.Transparency = 0
                end
              end
            end
          end
        end
      end
    end
    if Hp then
      if not Wd.TPS then
        ii_LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
        for yb, gc in pairs(Vm_CurrentCamera:GetChildren()) do
          if gc:IsA("Model") then
            for Et, z in pairs(gc:GetDescendants()) do
              if not (z:IsA("BasePart")) then
              else
                z.LocalTransparencyModifier = 0
              end
            end
          end
        end
      else
        for Fk, Ib in pairs(Hp:GetDescendants()) do
          if not (Ib:IsA("BasePart") and Ib.Name ~= "HumanoidRootPart") then
          else
            Ib.LocalTransparencyModifier = 0
          end
        end
        ii_LocalPlayer.CameraMode = Enum.CameraMode.Classic
        Vm_CurrentCamera.CFrame = Vm_CurrentCamera.CFrame * CFrame_new(0, 0, tonumber(Wd.TPSDistance) or 8)
        for ja, Ge in pairs(Vm_CurrentCamera:GetChildren()) do
          if Ge:IsA("Model") then
            for ei, Sn in pairs(Ge:GetDescendants()) do
              if Sn:IsA("BasePart") then
                Sn.LocalTransparencyModifier = 1
              end
            end
          end
        end
      end
      if Hp:FindFirstChild("Humanoid") then
        local dt, ff = Hp.Humanoid, Hp:FindFirstChild("HumanoidRootPart")
        local Xb, jb =
          ff and ff.Anchored or false,
          UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(
            Enum.KeyCode.S
          ) or UserInputService:IsKeyDown(Enum.KeyCode.D)
        if not Xb then
          if Wd.MovementEnabled then
            dt.WalkSpeed = tonumber(Wd.SpeedValue) or 16
            dt.UseJumpPower = true
            dt.JumpPower = tonumber(Wd.JumpPower) or 25
          end
          if not (Wd.Bhop and UserInputService:IsKeyDown(Enum.KeyCode.Space) and jb) then
          else
            if not (dt.FloorMaterial ~= Enum.Material.Air) then
            else
              dt.Jump = true
            end
          end
        end
      end
    end
    if Wd.AntiFlash then
      Lighting.ExposureCompensation = 0
      for _f, Dj in pairs(Lighting:GetChildren()) do
        if Dj:IsA("ColorCorrectionEffect") and (string_find(string_lower(Dj.Name), "flash") or Dj.TintColor == jw(1, 1, 1)) then
          Dj.Enabled = false
        end
      end
      local In = ii_LocalPlayer:FindFirstChild("PlayerGui")
      if In then
        for A, kr in pairs(In:GetChildren()) do
          if string_find(string_lower(kr.Name), "flash") or string_find(string_lower(kr.Name), "blind") then
            kr:Destroy()
          end
        end
      end
    end
    if Wd.NightMode then
      local kc = Vm_CurrentCamera:FindFirstChild("WyvernNight")
      if not kc then
        kc = Instance.new("ColorCorrectionEffect")
        kc.Name = "WyvernNight"
        kc.Parent = Vm_CurrentCamera
      end
      kc.TintColor = hg(100, 100, 160)
      kc.Brightness = -0.15
      kc.Contrast = 0.2
      kc.Enabled = true
    else
      local Jo = Vm_CurrentCamera:FindFirstChild("WyvernNight")
      if not Jo then
      else
        Jo:Destroy()
      end
    end
    if not Wd.VMChams then
      for Kj, At in pairs(Vm_CurrentCamera:GetChildren()) do
        if not (At:IsA("Model")) then
        else
          local pr = At:FindFirstChild("WyvernVMChams")
          if pr then
            pr.Enabled = false
          end
        end
      end
    else
      local tm = Wd.VMChamsColor or "White"
      local Sp = sl[tm] or hg(255, 255, 255)
      if Wd.RainbowVM then
        Sp = Vs(tick() % 1, 1, 1)
      end
      local Ug = (tonumber(Wd.VMChamsTransparency) or 30) / 100
      for _c, ze in pairs(Vm_CurrentCamera:GetChildren()) do
        if
          not (
            ze:IsA("Model") and (ze:FindFirstChild("Weapon") or ze:FindFirstChild("Right Arm") or ze:FindFirstChild("AnimationController"))
          )
        then
        else
          local Ir = ze:FindFirstChild("WyvernVMChams")
          if not Ir then
            Ir = Instance.new("Highlight")
            Ir.Name = "WyvernVMChams"
            Ir.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            Ir.Parent = ze
          end
          Ir.FillColor = Sp
          Ir.OutlineColor = Sp
          Ir.FillTransparency = Ug
          Ir.OutlineTransparency = 0
          Ir.Enabled = true
        end
      end
    end
    Cn.espTimer = Cn.espTimer + O
    if not (Cn.espTimer >= Cn.ESP_UPDATE_RATE) then
    else
      Cf()
      Cn.espTimer = 0
    end
    if not Bm.SilentFOV then
    else
      Bm.SilentFOV.Position = Uj(0, cd.X, 0, cd.Y)
      local za = tonumber(Wd.FOV) or 150
      Bm.SilentFOV.Size = Uj(0, za * 2, 0, za * 2)
      if not ((Wd.SilentEnabled or _v) and Wd.ShowFOV) then
        Bm.SilentFOV.Visible = false
      else
        Bm.SilentFOV.Visible = true
        local Ji = Yh(_v and 9999 or za)
        if Ji then
          Rq.Color = hg(255, 50, 50)
        else
          Rq.Color = qb.MainColor
        end
      end
    end
    if Bm.AimlockFOV then
      Bm.AimlockFOV.Position = Uj(0, cd.X, 0, cd.Y)
      local Y = tonumber(Wd.AimFOV) or 150
      Bm.AimlockFOV.Size = Uj(0, Y * 2, 0, Y * 2)
      if not Wd.Aimlock then
        Bm.AimlockFOV.Visible = false
      else
        Bm.AimlockFOV.Visible = true
      end
    end
    if Bm.TooltipFrame and Bm.TooltipFrame.Visible then
      local we = UserInputService:GetMouseLocation()
      Bm.TooltipFrame.Position = Uj(0, we.X + 15, 0, we.Y - 10)
    end
    if not (Wd.AutoShoot and (Wd.SilentEnabled or _v)) then
    else
      local Ki = (Wd.SilentEnabled or _v) and (tonumber(Wd.FOV) or 150) or 15
      if not _v then
      else
        Ki = 9999
      end
      local B = Yh(Ki)
      if B and (Wd.Wallbang or _v or Yb(B.Part, true)) then
        if not Cn._G_AutoShootWait then
          Cn._G_AutoShootWait = true
          task_spawn(function()
            if not (Wk and Md and not Wl_TouchEnabled) then
              if not (gm and not Wl_TouchEnabled) then
              else
                pcall(gm)
              end
            else
              pcall(Wk)
              task_wait(0.05)
              pcall(Md)
            end
            task_wait(0.05)
            Cn._G_AutoShootWait = false
          end)
        end
      end
    end
    if Wd.TriggerBot and not Wd.AutoShoot then
      local tt = Vn()
      if not tt then
      else
        local Il, kj = Vm_CurrentCamera:WorldToViewportPoint(tt.Position)
        if not kj then
        else
          local ge, se_ = (wv(Il.X, Il.Y) - cd).Magnitude, Wd.SilentEnabled and (tonumber(Wd.FOV) or 150) or 12
          if ge <= se_ then
            if not _G.TrigWait then
              _G.TrigWait = true
              task_spawn(function()
                local st = tonumber(Wd.TriggerDelay) or 0
                local bn = st + math_random(80, 180)
                task_wait(bn / 1000)
                local rj = Vn()
                if rj then
                  if not (Wk and Md and not Wl_TouchEnabled) then
                    if not (gm and not Wl_TouchEnabled) then
                    else
                      pcall(gm)
                    end
                  else
                    pcall(Wk)
                    task_wait(0.05)
                    pcall(Md)
                  end
                  task_wait(math_random(30, 80) / 1000)
                end
                task_wait(math_random(50, 120) / 1000)
                _G.TrigWait = false
              end)
            end
          end
        end
      end
    end
    local Id = false
    if Wl_TouchEnabled and Wd.Aimlock then
      Id = true
    else
      if not (Wd.AimKey.EnumType == Enum.UserInputType) then
        Id = UserInputService:IsKeyDown(Wd.AimKey)
      else
        Id = UserInputService:IsMouseButtonPressed(Wd.AimKey)
      end
    end
    local Ph, Ma, yt =
      Wd.FlickBot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1), (Cn.SpecCount and Cn.SpecCount > 0), false
    if Wd.AntiSpecEnable and Ma then
      if Wd.AntiSpecMode == "Aimlock" or Wd.AntiSpecMode == "Both" then
        yt = true
      end
    end
    if Ph and not yt then
      local mg = Vn()
      if not (mg and mg.Parent and mg:IsDescendantOf(Workspace)) then
      else
        local Pu, vq = Vm_CurrentCamera:WorldToViewportPoint(mg.Position)
        if not vq then
        else
          local Ls, Vp = math_floor((Pu.X - cd.X) * 0.7), math_floor((Pu.Y - cd.Y) * 0.7)
          if Zu and not Wl_TouchEnabled then
            pcall(function()
              Zu(Ls, Vp)
            end)
          end
        end
      end
    elseif Wd.Aimlock and Id and not yt then
      if not (not Cn.CurrentLockedTarget or not Cn.CurrentLockedTarget.Parent or not Cn.CurrentLockedTarget:IsDescendantOf(Workspace)) then
        local ys = Cn.CurrentLockedTarget.Parent:FindFirstChildOfClass("Humanoid")
        if not (not ys or ys.Health <= 0) then
          if not (Wd.AimWallCheck and not Yb(Cn.CurrentLockedTarget, true)) then
          else
            Cn.CurrentLockedTarget = Vn()
          end
        else
          Cn.CurrentLockedTarget = Vn()
        end
      else
        Cn.CurrentLockedTarget = Vn()
      end
      if Cn.CurrentLockedTarget then
        local bw, zi = Cn.CurrentLockedTarget.Position, Cn.CurrentLockedTarget.Parent:FindFirstChild("HumanoidRootPart")
        if zi then
          local op = (bw - Vm_CurrentCamera.CFrame.Position).Magnitude
          if Wd.AimPrediction then
            bw = bw + (zi.AssemblyLinearVelocity * 1 * (op / 1500))
          else
            bw = bw + (zi.AssemblyLinearVelocity * 1 * (op / 1000))
          end
        end
        local Jk, Fc = Vm_CurrentCamera:WorldToViewportPoint(bw)
        if not Fc then
        else
          local Pg = tonumber(Wd.AimJitter) or 10
          local _a = Pg / 100
          local Wi, Nn = (math_random() - 0.5) * _a * 2, (math_random() - 0.5) * _a * 2
          if not Wl_TouchEnabled then
            if Wd.AimMethod == "Raw Mouse" then
              local lw = tonumber(Wd.AimSmoothness) or 2
              local Ou, sj, ed = lw + (math_random() * 0.3), (Jk.X - cd.X) + Wi, (Jk.Y - cd.Y) + Nn
              local cf, Re = math_floor(sj / Ou), math_floor(ed / Ou)
              if math_abs(cf) < 1000 and math_abs(Re) < 1000 then
                if not Zu then
                else
                  pcall(function()
                    Zu(cf, Re)
                  end)
                end
              end
            elseif Wd.AimMethod == "Smooth Mouse" then
              local mc, Wa, ie = tonumber(Wd.AimSmoothness) or 2, (Jk.X - cd.X) + Wi, (Jk.Y - cd.Y) + Nn
              local Mj = math_clamp(mc * 0.8, 1, 20)
              local Nh, Yq = math_floor((Wa / Mj) * 0.5), math_floor((ie / Mj) * 0.5)
              if math_abs(Nh) > 0 or math_abs(Yq) > 0 then
                if not Zu then
                else
                  pcall(function()
                    Zu(Nh, Yq)
                  end)
                end
              end
            end
          else
            local of = tonumber(Wd.AimSmoothness) or 2
            local Yu, ig = math_clamp(0.1 / of, 0.01, 1), CFrame_new(Vm_CurrentCamera.CFrame.Position, bw + Ao(Wi, Nn, 0))
            Vm_CurrentCamera.CFrame = Vm_CurrentCamera.CFrame:Lerp(ig, Yu)
          end
        end
      end
    else
      Cn.CurrentLockedTarget = nil
    end
  end)
end)
local pm = false
local function Kv()
  if pm then
    return true
  end
  for Cr, Sv in pairs(getgc(true)) do
    if type(Sv) == "table" and rawget(Sv, "Karambit") and type(rawget(Sv, "Karambit")) == "table" then
      for xj, Qi in pairs(Sv) do
        if not (type(Qi) == "table") then
        else
          local me, fe, ol =
            rawget(Qi, "Image") or rawget(Qi, "Icon") or rawget(Qi, "hud_icon"),
            rawget(Qi, "ImageRectOffset") or rawget(Qi, "IconRectOffset"),
            rawget(Qi, "ImageRectSize") or rawget(Qi, "IconRectSize")
          if fe or me then
            Cn.MasterWeaponIcons[xj] = { Image = me, Offset = fe, Size = ol }
          end
        end
      end
      pm = true
      return true
    end
  end
  return false
end
task_spawn(function()
  while not pm do
    Kv()
    task_wait(2)
  end
  while task_wait(0.5) do
    pcall(function()
      local Xl = ii_LocalPlayer.Character
        and ii_LocalPlayer.Character:FindFirstChild("Humanoid")
        and ii_LocalPlayer.Character.Humanoid.Health > 0
      if not Xl then
        return
      end
      local kg = Wd.TargetKnife or Cn.TargetKnife
      local zn = Cn.MasterWeaponIcons[kg]
      if zn then
        local si = ii_LocalPlayer:FindFirstChild("PlayerGui")
        if not si then
        else
          for kk, da in pairs(si:GetDescendants()) do
            if not (da:IsA("TextLabel") and da.Visible) then
            else
              if not (da.Text == "Zeus x27" or da.Text == "Taser") then
              else
                continue
              end
              local ss = (
                da.Text == "CT Knife"
                or da.Text == "T Knife"
                or da.Text == "Knife"
                or da.Text == "BaseKnife"
                or da.Text == "Melee"
              )
              if ss or (da.Text == kg and da:GetAttribute("SpoofedKnife")) then
                if not (da.Text ~= kg) then
                else
                  da.Text = kg
                end
                if not (not da:GetAttribute("SpoofedKnife")) then
                else
                  da:SetAttribute("SpoofedKnife", true)
                end
                local Hs = da.Parent and da.Parent.Parent
                if Hs then
                  for Sg, qi in pairs(Hs:GetDescendants()) do
                    if qi:IsA("ImageLabel") and qi.Name ~= "Crosshair" then
                      if zn.Image and qi.Image ~= zn.Image then
                        qi.Image = zn.Image
                      end
                      if zn.Offset and qi.ImageRectOffset ~= zn.Offset then
                        qi.ImageRectOffset = zn.Offset
                      end
                      if not (zn.Size and qi.ImageRectSize ~= zn.Size) then
                      else
                        qi.ImageRectSize = zn.Size
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end)
  end
end)
local ji
ji = hookmetamethod(game, "__index", function(fm, nw)
  if not checkcaller() then
    if fm:IsA("Mouse") and (nw == "Hit" or nw == "Target") then
      local Cd = false
      pcall(function()
        Cd = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
          or UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
      end)
      if not ((Cd or _G.WyvernAutoShoot or Cn.TriggerBotActive) and (Wd.SilentEnabled or Wd.RageMode) and Cn.LastSpoofedDirection) then
      else
        if nw == "Hit" then
          local Om = Workspace.CurrentCamera.CFrame.Position
          return CFrame.new(Om + (Cn.LastSpoofedDirection * 1000))
        elseif nw == "Target" then
          return nil
        end
      end
    end
  end
  return ji(fm, nw)
end)
local function dv(ep)
  if not ep or not ep:IsA("Model") then
    return
  end
  for Oc, oq in pairs(ep:GetDescendants()) do
    if oq:IsA("BasePart") or oq:IsA("MeshPart") then
      if not (oq.Name == "Hitbox" or oq.Name == "bounds" or oq.Transparency >= 1) then
      else
        continue
      end
      local function qg()
        if not Wd.VMChams then
          return
        end
        local Dr = sl[Wd.VMChamsColor or "White"] or Color3.fromRGB(255, 255, 255)
        if not Wd.RainbowVM then
        else
          Dr = Color3.fromHSV(tick() % 1, 1, 1)
        end
        if oq.Material ~= Enum.Material.ForceField then
          oq.Material = Enum.Material.ForceField
        end
        if oq.Color ~= Dr then
          oq.Color = Dr
        end
        if oq.Transparency > 0 and oq.Transparency < 1 then
          oq.Transparency = 0
        end
      end
      oq:GetPropertyChangedSignal("Material"):Connect(qg)
      oq:GetPropertyChangedSignal("Color"):Connect(qg)
      qg()
    end
  end
end
Vm_CurrentCamera.ChildAdded:Connect(function(le)
  if le:IsA("Model") then
    task.wait(0.1)
    dv(le)
  end
end)
for fk, Zk in pairs(Vm_CurrentCamera:GetChildren()) do
  if not (Zk:IsA("Model")) then
  else
    dv(Zk)
  end
end
