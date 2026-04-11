local GlobalEnv = getgenv()
if GlobalEnv and GlobalEnv.StandaloneLoaded then return end
if GlobalEnv then GlobalEnv.StandaloneLoaded = true end
if not game:IsLoaded() then game.Loaded:Wait() end

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local CoreGui           = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local HttpService       = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

for _, n in ipairs({"Paradise_Remake","Paradise_Overlay","Paradise_KBList"}) do
    local g = CoreGui:FindFirstChild(n); if g then g:Destroy() end
end

local Library = { Flags={}, SetFlags={}, Connections={}, OpenFrames={}, Assets={} }
Library.__index = Library

local GAME_TAG = game.PlaceId ~= 0 and tostring(game.PlaceId):sub(-5) or "00000"

if not isfolder("Paradise")         then makefolder("Paradise")         end
if not isfolder("Paradise/configs") then makefolder("Paradise/configs") end

local ConfigManager = {}

function ConfigManager:GetList()
    local names = {}
    local ok, files = pcall(listfiles, "Paradise/configs")
    if not ok then return names end
    for _, f in ipairs(files) do
        if f:match("%.json$") then
            local n = f:match("[^\/]+$"):gsub("%.json$", "")
            if n and n ~= "" then table.insert(names, n) end
        end
    end
    return names
end

function ConfigManager:_path(name)
    return "Paradise/configs/" .. name .. ".json"
end

function ConfigManager:Save(name)
    if not name or name == "" then return false, "enter a name" end
    local data = { _game_tag = GAME_TAG }
    for k, v in pairs(Library.Flags) do data[k] = v end
    local ok, err = pcall(function()
        writefile(self:_path(name), HttpService:JSONEncode(data))
    end)
    return ok, err
end

function ConfigManager:Load(name)
    local path = self:_path(name)
    local content
    local ok1 = pcall(function() content = readfile(path) end)
    if not ok1 or not content then return false, "file not found: " .. path end
    local ok2, data = pcall(function() return HttpService:JSONDecode(content) end)
    if not ok2 or type(data) ~= "table" then return false, "read error" end
    local savedTag = data["_game_tag"]
    if savedTag and savedTag ~= GAME_TAG then
        return false, "wrong game (saved: ..." .. tostring(savedTag) .. " current: ..." .. GAME_TAG .. ")"
    end
    for k, v in pairs(data) do
        if k ~= "_game_tag" and Library.SetFlags[k] then
            Library:SafeCall(Library.SetFlags[k], v)
        end
    end
    return true
end

function ConfigManager:Delete(name)
    local path = self:_path(name)
    local ok, err = pcall(function() delfile(path) end)
    return ok, err
end

do
    if not isfolder("Paradise")         then makefolder("Paradise")         end
    if not isfolder("Paradise/configs") then makefolder("Paradise/configs") end
    local function loadAsset(fileName, url)
        local path = "Paradise/"..fileName
        if not isfile(path) then writefile(path, base64decode(game:HttpGet(url))) end
        return getcustomasset(path)
    end
    Library.Assets["legit_icon"]    = loadAsset("legit_icon.png",    "https://www.dropbox.com/scl/fi/1p5ia0tbgds4cire6fvng/sword.txt?rlkey=mnxkovo5ac9auswq4qs3vayg1&st=j0rgpiyx&dl=1")
    Library.Assets["rage_icon"]     = loadAsset("rage_icon.png",     "https://www.dropbox.com/scl/fi/qbxcm6uu2bntlpis2yhuz/swords.txt?rlkey=4qp3uvqybwwggkj3xjrkefmdc&st=imsgq754&dl=1")
    Library.Assets["settings_icon"] = loadAsset("settings_icon.png", "https://www.dropbox.com/scl/fi/gjyau7xdribyf92mmwhe4/settings.txt?rlkey=9r7y2c1gh8a9o53uphns0y1y4&st=srhxea2b&dl=1")
    Library.Assets["nixware_icon"]  = loadAsset("nixware_icon.png",  "https://www.dropbox.com/scl/fi/tu3owu6hpjjklat678zgz/nixware.txt?rlkey=m56jpnwze06ngvpsxar6mogsi&st=t6276ag8&dl=1")
    Library.Assets["page_icon"]     = loadAsset("page_icon.png",     "https://www.dropbox.com/scl/fi/r4c4cao6ofhtwafz80e90/page-break.txt?rlkey=2wlyvdgzhvuviqvjpsnn88ynt&st=pwfvsf6c&dl=1")
    Library.Assets["user_icon"]     = loadAsset("user_icon.png",     "https://www.dropbox.com/scl/fi/a4yc4xvmo4ahmiydadoga/user.txt?rlkey=nwu941vkl4u70mtz07om70a18&st=584t20ja&dl=1")
end

local function Tween(inst, goal, t)
    TweenService:Create(inst, TweenInfo.new(t or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()
end

local function ConnectGlobal(sig, fn)
    local c = sig:Connect(fn); table.insert(Library.Connections, c); return c
end

function Library:SafeCall(fn, ...)
    local ok, err = pcall(fn, ...); if not ok then warn("[Standalone] "..tostring(err)) end
end

local Colors = {
    Background    = Color3.fromRGB(30,30,30),
    Header        = Color3.fromRGB(36,36,36),
    Card          = Color3.fromRGB(37,37,39),
    Element       = Color3.fromRGB(44,44,48),
    Separator     = Color3.fromRGB(55,55,55),
    Text          = Color3.fromRGB(188,188,192),
    TextMuted     = Color3.fromRGB(100,100,108),
    AccentBlue    = Color3.fromRGB(58,110,250),
    ToggleOff     = Color3.fromRGB(58,58,63),
    SidebarActive = Color3.fromRGB(48,48,52),
    SidebarBar    = Color3.fromRGB(65,120,255),
    White         = Color3.fromRGB(255,255,255),
    DropdownBG    = Color3.fromRGB(32,32,35),
    DropdownHover = Color3.fromRGB(50,50,55),
}

local function NewInstance(cls, props, parent)
    local i = Instance.new(cls)
    for k,v in pairs(props or {}) do i[k]=v end
    if parent then i.Parent=parent end
    return i
end

local function AddCorner(r, p) return NewInstance("UICorner",{CornerRadius=UDim.new(0,r)},p) end

local KBListGui = NewInstance("ScreenGui",{Name="Paradise_KBList",ZIndexBehavior=Enum.ZIndexBehavior.Sibling,DisplayOrder=150,ResetOnSpawn=false,Parent=CoreGui})
Library._kbListGui = KBListGui
local KBListFrame = NewInstance("Frame",{Size=UDim2.new(0,160,0,40),Position=UDim2.new(0,20,0.5,0),BackgroundColor3=Colors.Card,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.Y,Parent=KBListGui})
AddCorner(8,KBListFrame)
NewInstance("UIStroke",{Color=Colors.Separator,Thickness=1,Parent=KBListFrame})
local KBListHeader = NewInstance("Frame",{Size=UDim2.new(1,0,0,28),BackgroundColor3=Colors.Header,BorderSizePixel=0,ZIndex=2,Parent=KBListFrame})
AddCorner(8,KBListHeader)
NewInstance("Frame",{Size=UDim2.new(1,0,0,8),Position=UDim2.new(0,0,1,-8),BackgroundColor3=Colors.Header,BorderSizePixel=0,ZIndex=2,Parent=KBListHeader})
NewInstance("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Colors.TextMuted,Text="KEYBINDS",ZIndex=3,Parent=KBListHeader})
local KBListContent = NewInstance("Frame",{Size=UDim2.new(1,0,0,0),Position=UDim2.new(0,0,0,28),BackgroundTransparency=1,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.Y,Parent=KBListFrame})
NewInstance("UIListLayout",{Padding=UDim.new(0,0),SortOrder=Enum.SortOrder.LayoutOrder,Parent=KBListContent})
NewInstance("UIPadding",{PaddingTop=UDim.new(0,4),PaddingBottom=UDim.new(0,6),PaddingLeft=UDim.new(0,8),PaddingRight=UDim.new(0,8),Parent=KBListContent})
do
    local isDragging,dragStart,startPos=false,nil,nil
    KBListHeader.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then isDragging=true;dragStart=i.Position;startPos=KBListFrame.Position end
    end)
    ConnectGlobal(UserInputService.InputChanged,function(i)
        if i.UserInputType==Enum.UserInputType.MouseMovement and isDragging then
            local d=i.Position-dragStart
            KBListFrame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
    ConnectGlobal(UserInputService.InputEnded,function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then isDragging=false end
    end)
end

local KeyDisplayMap = {
    ["MouseButton1"]="MB1",["MouseButton2"]="MB2",["Unknown"]="None",
    ["Backspace"]="Back",["Return"]="Enter",["Escape"]="Esc",["Space"]="Space",
    ["Delete"]="Del",["Home"]="Home",["End"]="End",["Insert"]="Ins",
    ["PageUp"]="PgUp",["PageDown"]="PgDn",["RightShift"]="RShift",["LeftShift"]="LShift",
    ["RightControl"]="RCtrl",["LeftControl"]="LCtrl",["LeftAlt"]="LAlt",["RightAlt"]="RAlt",
    ["F1"]="F1",["F2"]="F2",["F3"]="F3",["F4"]="F4",["F5"]="F5",["F6"]="F6",
    ["F7"]="F7",["F8"]="F8",["F9"]="F9",["F10"]="F10",["F11"]="F11",["F12"]="F12",
}
local function GetKeyDisplay(kc)
    local s=tostring(kc):gsub("Enum%.KeyCode%.",""):gsub("Enum%.UserInputType%.","")
    return KeyDisplayMap[s] or s
end

local KBListItems = {}
local function AddKeybindToList(bindName, flagKey)
    local row   = NewInstance("Frame",{Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,BorderSizePixel=0,Parent=KBListContent})
    local dot   = NewInstance("Frame",{Size=UDim2.new(0,6,0,6),Position=UDim2.new(0,0,0.5,-3),BackgroundColor3=Colors.ToggleOff,BorderSizePixel=0,ZIndex=2,Parent=row})
    AddCorner(99,dot)
    local label = NewInstance("TextLabel",{Size=UDim2.new(1,-20,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextColor3=Colors.TextMuted,TextXAlignment=Enum.TextXAlignment.Left,Text=bindName.." [None]",ZIndex=2,Parent=row})
    table.insert(KBListItems,{row=row,dot=dot,label=label,name=bindName,flagKey=flagKey})
end
local function UpdateKBList()
    for _,entry in ipairs(KBListItems) do
        local flag=Library.Flags[entry.flagKey]
        if flag and type(flag)=="table" then
            local raw=tostring(flag.Key or ""):gsub("Enum%.KeyCode%.",""):gsub("Enum%.UserInputType%.","")
            local disp=KeyDisplayMap[raw] or raw
            if disp=="Unknown" then disp="None" end
            entry.label.Text=entry.name.." ["..disp.."]"
            if flag.Toggled then
                entry.dot.BackgroundColor3=Colors.AccentBlue; entry.label.TextColor3=Colors.Text
            else
                entry.dot.BackgroundColor3=Colors.ToggleOff; entry.label.TextColor3=Colors.TextMuted
            end
        end
    end
end
do
    local _kbTimer=0
    ConnectGlobal(RunService.Heartbeat,function(dt) _kbTimer+=dt; if _kbTimer>=0.1 then _kbTimer=0; UpdateKBList() end end)
end

local function CreateKeybind(bindData, contentParent, kbListName)
    local flagKey  = bindData.Flag or "kb_unnamed"
    local callback = bindData.Callback or function() end
    local Row = NewInstance("Frame",{Size=UDim2.new(1,0,0,46),BackgroundTransparency=1,ZIndex=5,Parent=contentParent})
    NewInstance("TextLabel",{Size=UDim2.new(1,0,0,14),Text=bindData.Name or "Keybind",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Colors.TextMuted,BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,Parent=Row})
    local KeyBox = NewInstance("Frame",{Size=UDim2.new(0,110,0,26),Position=UDim2.new(0,0,0,16),BackgroundColor3=Colors.Element,BorderSizePixel=0,ZIndex=6,Parent=Row})
    AddCorner(5,KeyBox)
    NewInstance("UIPadding",{PaddingLeft=UDim.new(0,8),Parent=KeyBox})
    local initDisp = GetKeyDisplay(bindData.Default or Enum.KeyCode.Unknown)
    local KeyButton = NewInstance("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Colors.Text,Text=initDisp=="Unknown" and "None" or initDisp,AutoButtonColor=false,ZIndex=7,Parent=KeyBox})
    local ModesFrame = NewInstance("Frame",{Size=UDim2.new(0,176,0,26),AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,16),BackgroundColor3=Colors.Element,BorderSizePixel=0,ZIndex=6,Parent=Row})
    AddCorner(5,ModesFrame)
    local ModeBG = NewInstance("Frame",{Size=UDim2.new(0.34,0,1,0),BackgroundColor3=Colors.AccentBlue,BorderSizePixel=0,ZIndex=7,Parent=ModesFrame})
    AddCorner(5,ModeBG)
    local function MakeModeBtn(text,xs,xp)
        return NewInstance("TextButton",{Size=UDim2.new(xs,0,1,0),Position=UDim2.new(xp,0,0,0),BackgroundTransparency=1,BorderSizePixel=0,AutoButtonColor=false,Font=Enum.Font.Gotham,TextSize=10,TextColor3=xp==0 and Color3.fromRGB(0,0,0) or Colors.TextMuted,Text=text,ZIndex=8,Parent=ModesFrame})
    end
    local BtnToggle = MakeModeBtn("Toggle",0.34,0)
    local BtnHold   = MakeModeBtn("Hold",0.33,0.34)
    local BtnAlways = MakeModeBtn("Always",0.33,0.67)
    local KB = {Flag=flagKey,Key=tostring(bindData.Default or Enum.KeyCode.Unknown),ModeSelected=bindData.Mode or "Toggle",Toggled=false,Picking=false,Value=initDisp=="Unknown" and "None" or initDisp}
    if kbListName then AddKeybindToList(kbListName,flagKey) end
    local function SetMode(mode)
        KB.ModeSelected=mode
        Library.Flags[KB.Flag]={Mode=mode,Key=KB.Key,Toggled=KB.Toggled}
        local posMap={Toggle=0,Hold=0.34,Always=0.67}
        local sizeMap={Toggle=0.34,Hold=0.33,Always=0.33}
        Tween(ModeBG,{Position=UDim2.new(posMap[mode],0,0,0),Size=UDim2.new(sizeMap[mode],0,1,0)})
        Tween(BtnToggle,{TextColor3=mode=="Toggle" and Color3.fromRGB(0,0,0) or Colors.TextMuted})
        Tween(BtnHold,  {TextColor3=mode=="Hold"   and Color3.fromRGB(0,0,0) or Colors.TextMuted})
        Tween(BtnAlways,{TextColor3=mode=="Always" and Color3.fromRGB(0,0,0) or Colors.TextMuted})
        Library:SafeCall(callback,KB.Toggled)
    end
    local function PressKey(pressed)
        if     KB.ModeSelected=="Toggle" then KB.Toggled=not KB.Toggled
        elseif KB.ModeSelected=="Hold"   then KB.Toggled=pressed
        elseif KB.ModeSelected=="Always" then KB.Toggled=true end
        Library.Flags[KB.Flag]={Mode=KB.ModeSelected,Key=KB.Key,Toggled=KB.Toggled}
        Library:SafeCall(callback,KB.Toggled)
    end
    local function SetKey(kv)
        if type(kv)=="string" and ({Toggle=1,Hold=1,Always=1})[kv] then SetMode(kv); return
        elseif type(kv)=="table" then
            local rk=kv.Key or kv.key; if rk then KB.Key=tostring(rk) end
            local rm=kv.Mode or kv.mode; if rm then SetMode(rm) end
            KB.Toggled=kv.Toggled or kv.toggled or false
        else KB.Key=tostring(kv) end
        local clean=KB.Key:gsub("Enum%.KeyCode%.",""):gsub("Enum%.UserInputType%.","")
        KB.Value=KeyDisplayMap[clean] or clean
        if KB.Value=="Unknown" then KB.Value="None" end
        KeyButton.Text=KB.Value
        Library.Flags[KB.Flag]={Mode=KB.ModeSelected,Key=KB.Key,Toggled=KB.Toggled}
        KB.Picking=false
    end
    KeyButton.MouseButton1Click:Connect(function()
        KB.Picking=true; KeyButton.Text="."
        task.spawn(function()
            local n=1
            while KB.Picking do
                if n==4 then n=1 end
                KeyButton.Text=n==1 and "." or n==2 and ".." or "..."
                n+=1; task.wait(0.35)
            end
        end)
        local conn; conn=UserInputService.InputBegan:Connect(function(inp)
            if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.KeyCode==Enum.KeyCode.Delete then
                KB.Key=tostring(Enum.KeyCode.Unknown); KB.Value="None"; KeyButton.Text="None"
                Library.Flags[KB.Flag]={Mode=KB.ModeSelected,Key=KB.Key,Toggled=false}
                KB.Picking=false; conn:Disconnect(); conn=nil; return
            end
            if inp.UserInputType==Enum.UserInputType.Keyboard then SetKey(inp.KeyCode)
            else SetKey(inp.UserInputType) end
            conn:Disconnect(); conn=nil
        end)
    end)
    BtnToggle.MouseButton1Down:Connect(function() SetMode("Toggle") end)
    BtnHold.MouseButton1Down:Connect(function()   SetMode("Hold")   end)
    BtnAlways.MouseButton1Down:Connect(function() SetMode("Always") end)
    ConnectGlobal(UserInputService.InputBegan,function(inp)
        if KB.Value=="None" or KB.Key==tostring(Enum.KeyCode.Unknown) then return end
        if tostring(inp.KeyCode)==KB.Key or tostring(inp.UserInputType)==KB.Key then
            if KB.ModeSelected=="Toggle" then PressKey() else PressKey(true) end
        end
    end)
    ConnectGlobal(UserInputService.InputEnded,function(inp)
        if KB.Value=="None" or KB.Key==tostring(Enum.KeyCode.Unknown) then return end
        if tostring(inp.KeyCode)==KB.Key or tostring(inp.UserInputType)==KB.Key then
            if KB.ModeSelected=="Hold" then PressKey(false)
            elseif KB.ModeSelected=="Always" then PressKey(true) end
        end
    end)
    SetKey({Key=tostring(bindData.Default or Enum.KeyCode.Unknown),Mode=bindData.Mode or "Toggle"})
    local elem={Flag=flagKey}
    function elem:Get() return KB.Toggled end
    function elem:Set(v) SetKey(v) end
    Library.SetFlags[flagKey]=function(v) SetKey(v) end
    return elem
end

function Library:Window(windowData)
    windowData=windowData or {}
    local Win={Name=windowData.Name or "Window",Pages={},Items={},IsOpen=true}
    local mainGui=NewInstance("ScreenGui",{Name="Paradise_Remake",ZIndexBehavior=Enum.ZIndexBehavior.Sibling,DisplayOrder=10,ResetOnSpawn=false,Parent=CoreGui})
    local overlayGui=NewInstance("ScreenGui",{Name="Paradise_Overlay",ZIndexBehavior=Enum.ZIndexBehavior.Sibling,DisplayOrder=200,ResetOnSpawn=false,Parent=CoreGui})
    self._mainGui=mainGui; self._overlayGui=overlayGui
    Win.Items.OverlayGui=overlayGui
    local MainFrame=NewInstance("Frame",{Name="Main",Size=UDim2.new(0,680,0,440),Position=UDim2.new(0.5,-340,0.5,-220),BackgroundColor3=Colors.Background,BorderSizePixel=0,ClipsDescendants=true,Parent=mainGui})
    AddCorner(10,MainFrame)
    Win.Items.Main=MainFrame
    local HeaderFrame=NewInstance("Frame",{Size=UDim2.new(1,0,0,45),BackgroundColor3=Colors.Header,BorderSizePixel=0,ZIndex=3,Parent=MainFrame})
    NewInstance("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=Colors.Separator,BorderSizePixel=0,ZIndex=4,Parent=HeaderFrame})
    NewInstance("ImageLabel",{Size=UDim2.new(0,22,0,22),Position=UDim2.new(0,14,0.5,-11),Image=Library.Assets["nixware_icon"],ImageColor3=Colors.White,BackgroundTransparency=1,ZIndex=4,Parent=HeaderFrame})
    local HeaderTitle=NewInstance("TextLabel",{Size=UDim2.new(0,300,0,20),Position=UDim2.new(0,44,0.5,-10),Text=Win.Name,Font=Enum.Font.GothamBold,TextSize=18,TextColor3=Colors.White,BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=HeaderFrame})
    Win.Items.HeaderTitle=HeaderTitle
    local Sidebar=NewInstance("Frame",{Size=UDim2.new(0,48,1,-45),Position=UDim2.new(0,0,0,45),BackgroundColor3=Colors.Header,BorderSizePixel=0,ZIndex=3,Parent=MainFrame})
    NewInstance("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=Colors.Separator,BorderSizePixel=0,ZIndex=4,Parent=Sidebar})
    local TabsContainer=NewInstance("Frame",{Size=UDim2.new(1,0,1,-48),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=4,Parent=Sidebar})
    NewInstance("UIListLayout",{Padding=UDim.new(0,4),HorizontalAlignment=Enum.HorizontalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Parent=TabsContainer})
    NewInstance("UIPadding",{PaddingTop=UDim.new(0,8),Parent=TabsContainer})
    Win.Items.TabsContainer=TabsContainer
    NewInstance("Frame",{Size=UDim2.new(0,30,0,1),Position=UDim2.new(0.5,-15,1,-44),BackgroundColor3=Colors.Separator,BorderSizePixel=0,ZIndex=4,Parent=Sidebar})
    local ConfigTabFrame=NewInstance("Frame",{Size=UDim2.new(0,34,0,34),Position=UDim2.new(0.5,-17,1,-42),BackgroundColor3=Colors.Header,BorderSizePixel=0,ZIndex=4,Parent=Sidebar})
    AddCorner(8,ConfigTabFrame)
    NewInstance("ImageLabel",{Size=UDim2.new(0,18,0,18),Position=UDim2.new(0.5,-9,0.5,-9),Image=Library.Assets["page_icon"],ImageColor3=Colors.White,BackgroundTransparency=1,ZIndex=5,Parent=ConfigTabFrame})
    local ConfigTabIndicator=NewInstance("Frame",{Size=UDim2.new(0,3,0,22),Position=UDim2.new(0,-4,0.5,-11),BackgroundColor3=Colors.SidebarBar,BorderSizePixel=0,ZIndex=5,Visible=false,Parent=ConfigTabFrame})
    AddCorner(2,ConfigTabIndicator)
    ConfigTabFrame.MouseEnter:Connect(function() if not ConfigTabIndicator.Visible then Tween(ConfigTabFrame,{BackgroundColor3=Colors.SidebarActive},0.1) end end)
    ConfigTabFrame.MouseLeave:Connect(function() if not ConfigTabIndicator.Visible then Tween(ConfigTabFrame,{BackgroundColor3=Colors.Header},0.1) end end)
    local ContentFrame=NewInstance("Frame",{Size=UDim2.new(1,-58,1,-45),Position=UDim2.new(0,58,0,45),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=2,Parent=MainFrame})
    Win.Items.ContentFrame=ContentFrame
    local ConfigPageFrame=NewInstance("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,ZIndex=2,Parent=ContentFrame})
    local ConfigLeftWrap=NewInstance("Frame",{Size=UDim2.new(0.5,-5,1,0),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=3,Parent=ConfigPageFrame})
    NewInstance("UIPadding",{PaddingTop=UDim.new(0,10),Parent=ConfigLeftWrap})
    NewInstance("TextLabel",{Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,Text="CONFIGS",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Colors.TextMuted,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=ConfigLeftWrap})
    local ConfigCard=NewInstance("Frame",{Size=UDim2.new(1,0,1,-24),Position=UDim2.new(0,0,0,18),BackgroundColor3=Colors.Card,BorderSizePixel=0,ZIndex=3,Parent=ConfigLeftWrap})
    AddCorner(8,ConfigCard)
    local ConfigNameBox=NewInstance("Frame",{Size=UDim2.new(1,-12,0,22),Position=UDim2.new(0,6,0,8),BackgroundColor3=Colors.Element,BorderSizePixel=0,ZIndex=5,Parent=ConfigCard})
    AddCorner(4,ConfigNameBox)
    local ConfigNameInput=NewInstance("TextBox",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,8,0,0),Font=Enum.Font.Gotham,TextSize=12,TextColor3=Color3.fromRGB(195,195,205),PlaceholderText="Config name...",PlaceholderColor3=Color3.fromRGB(90,90,100),BackgroundTransparency=1,BorderSizePixel=0,ClearTextOnFocus=false,Text="",ZIndex=6,Parent=ConfigNameBox})
    local ConfigSaveBtn=NewInstance("TextButton",{Size=UDim2.new(1,-12,0,26),Position=UDim2.new(0,6,0,38),BackgroundColor3=Color3.fromRGB(50,160,80),BorderSizePixel=0,Text="Save",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=Colors.White,ZIndex=5,Parent=ConfigCard})
    AddCorner(5,ConfigSaveBtn)
    ConfigSaveBtn.MouseEnter:Connect(function() Tween(ConfigSaveBtn,{BackgroundColor3=Color3.fromRGB(60,185,95)}) end)
    ConfigSaveBtn.MouseLeave:Connect(function() Tween(ConfigSaveBtn,{BackgroundColor3=Color3.fromRGB(50,160,80)}) end)
    local ConfigStatusLabel=NewInstance("TextLabel",{Size=UDim2.new(1,-12,0,16),Position=UDim2.new(0,6,0,70),BackgroundTransparency=1,Text="",Font=Enum.Font.Gotham,TextSize=11,TextColor3=Color3.fromRGB(50,160,80),ZIndex=5,Parent=ConfigCard})
    local ConfigListWrap=NewInstance("Frame",{Size=UDim2.new(0.5,-5,1,0),Position=UDim2.new(0.5,5,0,0),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=3,Parent=ConfigPageFrame})
    NewInstance("UIPadding",{PaddingTop=UDim.new(0,10),Parent=ConfigListWrap})
    NewInstance("TextLabel",{Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,Text="LIST",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Colors.TextMuted,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=ConfigListWrap})
    local ConfigListCard=NewInstance("Frame",{Size=UDim2.new(1,0,1,-24),Position=UDim2.new(0,0,0,18),BackgroundColor3=Colors.Card,BorderSizePixel=0,ZIndex=3,Parent=ConfigListWrap})
    AddCorner(8,ConfigListCard)
    local ConfigListScroll=NewInstance("ScrollingFrame",{Size=UDim2.new(1,-10,1,-10),Position=UDim2.new(0,5,0,5),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=Color3.fromRGB(70,70,80),AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(0,0,0,0),ZIndex=4,Parent=ConfigListCard})
    NewInstance("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder,Parent=ConfigListScroll})
    local function ShowStatus(msg,isErr)
        ConfigStatusLabel.Text=msg; ConfigStatusLabel.TextColor3=isErr and Color3.fromRGB(200,60,60) or Color3.fromRGB(50,160,80)
        task.delay(2.5,function() if ConfigStatusLabel.Text==msg then ConfigStatusLabel.Text="" end end)
    end
    local function RefreshConfigList()
        for _,c in ipairs(ConfigListScroll:GetChildren()) do
            if not c:IsA("UIListLayout") then c:Destroy() end
        end
        local names=ConfigManager:GetList()
        if #names==0 then
            NewInstance("TextLabel",{Size=UDim2.new(1,0,0,26),BackgroundTransparency=1,Text="No configs",Font=Enum.Font.Gotham,TextSize=11,TextColor3=Colors.TextMuted,ZIndex=5,Parent=ConfigListScroll}); return
        end
        for _,cfgName in ipairs(names) do
            local Row=NewInstance("Frame",{Size=UDim2.new(1,0,0,28),BackgroundColor3=Colors.Element,BorderSizePixel=0,ZIndex=5,Parent=ConfigListScroll})
            AddCorner(5,Row)
            NewInstance("TextLabel",{Size=UDim2.new(1,-60,1,0),Position=UDim2.new(0,8,0,0),Text=cfgName,Font=Enum.Font.Gotham,TextSize=12,TextColor3=Colors.Text,BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=6,Parent=Row})
            local LoadBtn=NewInstance("TextButton",{Size=UDim2.new(0,24,0,20),Position=UDim2.new(1,-54,0.5,-10),BackgroundColor3=Color3.fromRGB(58,110,250),BorderSizePixel=0,Text="▶",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Colors.White,ZIndex=6,Parent=Row})
            AddCorner(4,LoadBtn)
            LoadBtn.MouseEnter:Connect(function() Tween(LoadBtn,{BackgroundColor3=Color3.fromRGB(80,130,255)}) end)
            LoadBtn.MouseLeave:Connect(function() Tween(LoadBtn,{BackgroundColor3=Color3.fromRGB(58,110,250)}) end)
            LoadBtn.MouseButton1Click:Connect(function()
                local ok,err=ConfigManager:Load(cfgName)
                if ok then ShowStatus("Loaded: "..cfgName,false) else ShowStatus(tostring(err),true) end
            end)
            local DelBtn=NewInstance("TextButton",{Size=UDim2.new(0,24,0,20),Position=UDim2.new(1,-26,0.5,-10),BackgroundColor3=Color3.fromRGB(200,60,60),BorderSizePixel=0,Text="✕",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Colors.White,ZIndex=6,Parent=Row})
            AddCorner(4,DelBtn)
            DelBtn.MouseEnter:Connect(function() Tween(DelBtn,{BackgroundColor3=Color3.fromRGB(220,80,80)}) end)
            DelBtn.MouseLeave:Connect(function() Tween(DelBtn,{BackgroundColor3=Color3.fromRGB(200,60,60)}) end)
            DelBtn.MouseButton1Click:Connect(function()
                local ok,err=ConfigManager:Delete(cfgName)
                if ok then ShowStatus("Deleted: "..cfgName,false); RefreshConfigList() else ShowStatus(tostring(err),true) end
            end)
        end
    end
    ConfigSaveBtn.MouseButton1Click:Connect(function()
        local name=ConfigNameInput.Text:match("^%s*(.-)%s*$")
        if name=="" then ShowStatus("Enter a name!",true); return end
        local ok,err=ConfigManager:Save(name)
        if ok then
            ShowStatus("Saved: "..name.." | ..."..GAME_TAG,false); RefreshConfigList()
        else ShowStatus(tostring(err),true) end
    end)
    RefreshConfigList()
    Win.Items.ConfigPageFrame=ConfigPageFrame; Win.Items.ConfigTabIndicator=ConfigTabIndicator
    Win.Items.ConfigTabFrame=ConfigTabFrame; Win.Items.RefreshConfigList=RefreshConfigList
    do
        local isDragging,dragStart,startPos=false,nil,nil
        HeaderFrame.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 then isDragging=true;dragStart=i.Position;startPos=MainFrame.Position end
        end)
        ConnectGlobal(UserInputService.InputChanged,function(i)
            if i.UserInputType==Enum.UserInputType.MouseMovement and isDragging then
                local d=i.Position-dragStart
                MainFrame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
            end
        end)
        ConnectGlobal(UserInputService.InputEnded,function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 then isDragging=false end
        end)
    end

    function Win:Page(pd)
        pd=pd or {}
        local Page={Window=self,Name=pd.Name or "Page",Sections={},Items={},Active=false}
        local TabFrame=NewInstance("Frame",{Size=UDim2.new(0,34,0,34),BackgroundColor3=Colors.Header,BorderSizePixel=0,ZIndex=4,Parent=self.Items.TabsContainer})
        AddCorner(8,TabFrame); Page.Items.TabFrame=TabFrame
        local Indicator=NewInstance("Frame",{Size=UDim2.new(0,3,0,22),Position=UDim2.new(0,-4,0.5,-11),BackgroundColor3=Colors.SidebarBar,BorderSizePixel=0,ZIndex=5,Visible=false,Parent=TabFrame})
        AddCorner(2,Indicator); Page.Items.Indicator=Indicator
        local TabIcon=NewInstance("ImageLabel",{Size=UDim2.new(0,18,0,18),Position=UDim2.new(0.5,-9,0.5,-9),BackgroundTransparency=1,ZIndex=5,Image=pd.Icon or "",ImageColor3=Colors.White,Parent=TabFrame})
        Page.Items.TabIcon=TabIcon
        TabFrame.MouseEnter:Connect(function() if not Page.Active then Tween(TabFrame,{BackgroundColor3=Colors.SidebarActive},0.1) end end)
        TabFrame.MouseLeave:Connect(function() if not Page.Active then Tween(TabFrame,{BackgroundColor3=Colors.Header},0.1) end end)
        local PageFrame=NewInstance("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,ZIndex=2,Parent=self.Items.ContentFrame})
        Page.Items.PageFrame=PageFrame
        local ColsFrame=NewInstance("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=2,Parent=PageFrame})
        NewInstance("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,HorizontalFlex=Enum.UIFlexAlignment.Fill,Padding=UDim.new(0,10),SortOrder=Enum.SortOrder.LayoutOrder,VerticalFlex=Enum.UIFlexAlignment.Fill,Parent=ColsFrame})
        NewInstance("UIPadding",{PaddingTop=UDim.new(0,10),PaddingBottom=UDim.new(0,10),PaddingLeft=UDim.new(0,10),PaddingRight=UDim.new(0,10),Parent=ColsFrame})
        local Columns={}
        for ci=1,2 do
            local Col=NewInstance("ScrollingFrame",{Size=UDim2.new(0.5,0,1,0),ScrollBarThickness=0,BackgroundTransparency=1,BorderSizePixel=0,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(0,0,0,0),ZIndex=2,Parent=ColsFrame})
            NewInstance("UIFlexItem",{FlexMode=Enum.UIFlexMode.Fill,Parent=Col})
            NewInstance("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=Col})
            NewInstance("UIPadding",{PaddingTop=UDim.new(0,2),Parent=Col})
            Columns[ci]=Col
        end
        Page.Items.Columns=Columns
        local TabButton=NewInstance("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=6,Parent=TabFrame})
        local function ActivatePage()
            ConfigPageFrame.Visible=false; ConfigTabIndicator.Visible=false; ConfigTabFrame.BackgroundColor3=Colors.Header
            for _,page in ipairs(self.Pages) do
                local on=(page==Page)
                page.Items.PageFrame.Visible=on; page.Items.Indicator.Visible=on
                page.Items.TabIcon.ImageColor3=Colors.White
                page.Items.TabFrame.BackgroundColor3=on and Colors.SidebarActive or Colors.Header
                page.Active=on
            end
            Win.Items.HeaderTitle.Text=Page.Name
        end
        TabButton.MouseButton1Click:Connect(ActivatePage)
        table.insert(self.Pages,Page)
        if #self.Pages==1 then ActivatePage() end

        local function ActivateConfigPage()
            for _,page in ipairs(self.Pages) do
                page.Items.PageFrame.Visible=false; page.Items.Indicator.Visible=false
                page.Items.TabIcon.ImageColor3=Colors.White; page.Items.TabFrame.BackgroundColor3=Colors.Header; page.Active=false
            end
            ConfigPageFrame.Visible=true; ConfigTabIndicator.Visible=true
            ConfigTabFrame.BackgroundColor3=Colors.SidebarActive; Win.Items.HeaderTitle.Text="Configs"
            RefreshConfigList()
        end
        if not Win.Items._cfgBtnBound then
            Win.Items._cfgBtnBound=true
            NewInstance("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=6,Parent=ConfigTabFrame}).MouseButton1Click:Connect(ActivateConfigPage)
        end

        function Page:Section(sd)
            sd=sd or {}
            local Sec={Page=self,Window=self.Window,Name=sd.Name or "Section",Side=sd.Side or 1,Elements={},Items={}}
            local col=self.Items.Columns[Sec.Side] or self.Items.Columns[1]
            local osg=Win.Items.OverlayGui
            local Wrap=NewInstance("Frame",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=3,Parent=col})
            NewInstance("TextLabel",{Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,Text=Sec.Name,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Colors.TextMuted,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4,Parent=Wrap})
            local Card=NewInstance("Frame",{Size=UDim2.new(1,0,0,20),Position=UDim2.new(0,0,0,18),BackgroundColor3=Colors.Card,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.Y,ZIndex=3,Parent=Wrap})
            AddCorner(8,Card)
            local Inner=NewInstance("Frame",{Size=UDim2.new(1,-12,0,0),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1,BorderSizePixel=0,AutomaticSize=Enum.AutomaticSize.Y,ZIndex=4,Parent=Card})
            NewInstance("UIListLayout",{Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder,Parent=Inner})
            NewInstance("UIPadding",{PaddingBottom=UDim.new(0,6),Parent=Inner})
            Sec.Items.Content=Inner
            local ROW=28

            function Sec:Toggle(d)
                d=d or {}
                local flagKey=d.Flag or ("tgl_"..#self.Elements)
                local isOn=d.Default==true
                local callback=d.Callback or function() end
                Library.Flags[flagKey]=isOn
                local Row=NewInstance("Frame",{Size=UDim2.new(1,0,0,ROW),BackgroundTransparency=1,ZIndex=5,Parent=self.Items.Content})
                NewInstance("TextLabel",{Size=UDim2.new(1,-44,1,0),Text=d.Name or "Toggle",Font=Enum.Font.Gotham,TextSize=13,TextColor3=Colors.Text,BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,Parent=Row})
                local Track=NewInstance("Frame",{Size=UDim2.new(0,30,0,16),Position=UDim2.new(1,-30,0.5,-8),BackgroundColor3=isOn and Colors.AccentBlue or Colors.ToggleOff,BorderSizePixel=0,ZIndex=6,Parent=Row})
                AddCorner(99,Track)
                local Knob=NewInstance("Frame",{Size=UDim2.new(0,10,0,10),Position=isOn and UDim2.new(1,-13,0.5,-5) or UDim2.new(0,3,0.5,-5),BackgroundColor3=Colors.White,BorderSizePixel=0,ZIndex=7,Parent=Track})
                AddCorner(99,Knob)
                local elem={Flag=flagKey,Value=isOn}
                function elem:Set(v)
                    isOn=v; self.Value=v; Library.Flags[flagKey]=v
                    Tween(Knob,{Position=v and UDim2.new(1,-13,0.5,-5) or UDim2.new(0,3,0.5,-5)})
                    Tween(Track,{BackgroundColor3=v and Colors.AccentBlue or Colors.ToggleOff})
                    Library:SafeCall(callback,v)
                end
                function elem:Get() return self.Value end
                local HitBtn=NewInstance("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=8,Parent=Row})
                HitBtn.MouseButton1Click:Connect(function() elem:Set(not isOn) end)
                HitBtn.MouseEnter:Connect(function() Row.BackgroundColor3=Color3.fromRGB(36,36,42); Tween(Row,{BackgroundTransparency=0},0.08) end)
                HitBtn.MouseLeave:Connect(function() Tween(Row,{BackgroundTransparency=1},0.08) end)
                Library.SetFlags[flagKey]=function(v) elem:Set(v) end
                self.Elements[#self.Elements+1]=elem; return elem
            end

            function Sec:Slider(d)
                d=d or {}
                local flagKey=d.Flag or ("sl_"..#self.Elements)
                local minV=d.Min or 0; local maxV=d.Max or 100; local dec=d.Decimals
                local suf=d.Suffix or ""; local val=math.clamp(d.Default or minV,minV,maxV)
                local callback=d.Callback or function() end
                Library.Flags[flagKey]=val
                local Row=NewInstance("Frame",{Size=UDim2.new(1,0,0,ROW),BackgroundTransparency=1,ZIndex=5,Parent=self.Items.Content})
                NewInstance("TextLabel",{Size=UDim2.new(0,90,1,0),Text=d.Name or "Slider",Font=Enum.Font.Gotham,TextSize=12,TextColor3=Colors.Text,BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,Parent=Row})
                local VB=NewInstance("Frame",{Size=UDim2.new(0,44,0,18),Position=UDim2.new(1,-44,0.5,-9),BackgroundColor3=Colors.Element,BorderSizePixel=0,ZIndex=6,Parent=Row})
                AddCorner(4,VB)
                local VL=NewInstance("TextLabel",{Size=UDim2.new(1,0,1,0),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Color3.fromRGB(200,200,210),BackgroundTransparency=1,ZIndex=7,Text=tostring(val)..suf,Parent=VB})
                local VI=NewInstance("TextBox",{Size=UDim2.new(1,-4,1,0),Position=UDim2.new(0,2,0,0),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=Color3.fromRGB(200,200,210),BackgroundTransparency=1,BorderSizePixel=0,Text="",ClearTextOnFocus=true,ZIndex=9,Visible=false,Parent=VB})
                local TBG=NewInstance("Frame",{Size=UDim2.new(1,-146,0,4),Position=UDim2.new(0,93,0.5,-2),BackgroundColor3=Color3.fromRGB(52,52,58),BorderSizePixel=0,ZIndex=6,Parent=Row})
                AddCorner(99,TBG)
                local r0=(val-minV)/(maxV-minV)
                local TF=NewInstance("Frame",{Size=UDim2.new(r0,0,1,0),BackgroundColor3=Colors.AccentBlue,BorderSizePixel=0,ZIndex=7,Parent=TBG})
                AddCorner(99,TF)
                local Th=NewInstance("Frame",{Size=UDim2.new(0,12,0,12),Position=UDim2.new(r0,-6,0.5,-6),BackgroundColor3=Colors.White,BorderSizePixel=0,ZIndex=8,Parent=TBG})
                AddCorner(99,Th)
                local elem={Flag=flagKey,Value=val,Sliding=false}
                local function rnd(n)
                    if not dec or dec==0 then return math.floor(n+0.5) end
                    local m=10^dec; return math.floor(n*m+0.5)/m
                end
                function elem:Set(v)
                    v=math.clamp(rnd(v),minV,maxV); val=v; self.Value=v; Library.Flags[flagKey]=v
                    local r=(v-minV)/(maxV-minV); VL.Text=tostring(v)..suf
                    Tween(TF,{Size=UDim2.new(r,0,1,0)},0.08); Tween(Th,{Position=UDim2.new(r,-6,0.5,-6)},0.08)
                    Library:SafeCall(callback,v)
                end
                function elem:Get() return self.Value end
                NewInstance("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=10,Parent=VB}).MouseButton1Click:Connect(function()
                    VL.Visible=false; VI.Text=tostring(val); VI.Visible=true; VI:CaptureFocus()
                end)
                VI.FocusLost:Connect(function() local n=tonumber(VI.Text); if n then elem:Set(n) end; VI.Visible=false; VL.Visible=true end)
                local Hit=NewInstance("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,Parent=TBG})
                local function upd(x) local r=math.clamp((x-TBG.AbsolutePosition.X)/TBG.AbsoluteSize.X,0,1); elem:Set(minV+r*(maxV-minV)) end
                Hit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then elem.Sliding=true; upd(i.Position.X) end end)
                ConnectGlobal(UserInputService.InputChanged,function(i) if i.UserInputType==Enum.UserInputType.MouseMovement and elem.Sliding then upd(i.Position.X) end end)
                ConnectGlobal(UserInputService.InputEnded,function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then elem.Sliding=false end end)
                Library.SetFlags[flagKey]=function(v) elem:Set(v) end; self.Elements[#self.Elements+1]=elem; return elem
            end

            function Sec:Dropdown(d)
                d=d or {}
                local flagKey=d.Flag or ("dd_"..#self.Elements)
                local opts=d.Items or {}; local sel=d.Default or (opts[1] or "")
                local callback=d.Callback or function() end; local isOpen=false
                Library.Flags[flagKey]=sel
                local Row=NewInstance("Frame",{Size=UDim2.new(1,0,0,ROW),BackgroundTransparency=1,ZIndex=5,Parent=self.Items.Content})
                NewInstance("TextLabel",{Size=UDim2.new(0,62,1,0),Text=d.Name or "Dropdown",Font=Enum.Font.Gotham,TextSize=12,TextColor3=Colors.Text,BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6,Parent=Row})
                local DB=NewInstance("Frame",{Size=UDim2.new(1,-66,0,22),Position=UDim2.new(0,65,0.5,-11),BackgroundColor3=Colors.Element,BorderSizePixel=0,ZIndex=6,Parent=Row})
                AddCorner(4,DB)
                local SL=NewInstance("TextLabel",{Size=UDim2.new(1,-18,1,0),Position=UDim2.new(0,7,0,0),Text=sel,Font=Enum.Font.Gotham,TextSize=12,TextColor3=Color3.fromRGB(195,195,205),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=10,Parent=DB})
                local Arr=NewInstance("TextLabel",{Size=UDim2.new(0,14,1,0),Position=UDim2.new(1,-15,0,0),Text="∨",Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Color3.fromRGB(120,120,130),BackgroundTransparency=1,ZIndex=10,Parent=DB})
                local DL=NewInstance("Frame",{BackgroundColor3=Colors.DropdownBG,BorderSizePixel=0,Visible=false,ZIndex=500,ClipsDescendants=false,Parent=osg})
                AddCorner(5,DL); NewInstance("UIStroke",{Color=Color3.fromRGB(55,55,60),Thickness=1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=DL})
                local DS=NewInstance("Frame",{Size=UDim2.new(1,-12,1,-8),Position=UDim2.new(0,6,0,4),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=501,Parent=DL})
                NewInstance("UIListLayout",{Padding=UDim.new(0,2),SortOrder=Enum.SortOrder.LayoutOrder,Parent=DS})
                local elem={Flag=flagKey,Value=sel,IsOpen=false}
                local optionItems={}
                local rsConn; local iH=22
                local function closeDD()
                    isOpen=false; elem.IsOpen=false; DL.Visible=false; Arr.Text="∨"
                    Library.OpenFrames[elem]=nil
                    if rsConn then rsConn:Disconnect(); rsConn=nil end
                end
                local function openDD()
                    for _,other in pairs(Library.OpenFrames) do
                        if other~=elem and other.IsOpen and other.SetOpen then other:SetOpen(false) end
                    end
                    isOpen=true; elem.IsOpen=true; DL.Visible=true; Arr.Text="∧"
                    Library.OpenFrames[elem]=elem
                    local lH=#opts*iH+8
                    if rsConn then rsConn:Disconnect() end
                    rsConn=RunService.RenderStepped:Connect(function()
                        local ap=DB.AbsolutePosition; local as=DB.AbsoluteSize
                        local sH=osg.AbsoluteSize.Y
                        local spBelow=sH-(ap.Y+as.Y); local spAbove=ap.Y
                        local goUp=(spBelow<lH+4) and (spAbove>spBelow)
                        local pY=goUp and (ap.Y-lH-2) or (ap.Y+as.Y+2)
                        DL.Position=UDim2.new(0,ap.X,0,pY); DL.Size=UDim2.new(0,as.X,0,lH)
                    end)
                end
                for _,opt in ipairs(opts) do
                    local OB=NewInstance("TextButton",{Size=UDim2.new(1,0,0,iH),BackgroundTransparency=1,BorderSizePixel=0,Text="",AutoButtonColor=false,ZIndex=502,Parent=DS})
                    local Dot=NewInstance("Frame",{Size=UDim2.new(0,6,0,6),Position=UDim2.new(0,0,0.5,-3),BackgroundTransparency=1,BorderSizePixel=0,BackgroundColor3=Colors.AccentBlue,ZIndex=503,Parent=OB})
                    AddCorner(99,Dot)
                    local OTxt=NewInstance("TextLabel",{Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0),Text=opt,Font=Enum.Font.Gotham,TextSize=12,TextColor3=Color3.fromRGB(185,185,195),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=0.3,ZIndex=503,Parent=OB})
                    NewInstance("UIPadding",{PaddingLeft=UDim.new(0,8),Parent=OB})
                    local isSelected = opt==sel
                    local function setSelected(v)
                        isSelected=v
                        if v then Tween(Dot,{BackgroundTransparency=0}); Tween(OTxt,{TextTransparency=0,Position=UDim2.new(0,14,0,0)})
                        else Tween(Dot,{BackgroundTransparency=1}); Tween(OTxt,{TextTransparency=0.3,Position=UDim2.new(0,0,0,0)}) end
                    end
                    if isSelected then setSelected(true) end
                    optionItems[opt]={setSelected=setSelected}
                    OB.InputBegan:Connect(function(inp)
                        if inp.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                        for k,v in pairs(optionItems) do v.setSelected(false) end
                        setSelected(true); sel=opt; SL.Text=opt; elem.Value=opt; Library.Flags[flagKey]=opt
                        closeDD(); Library:SafeCall(callback,opt)
                    end)
                end
                NewInstance("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=8,Parent=DB}).MouseButton1Click:Connect(function()
                    if isOpen then closeDD() else openDD() end
                end)
                ConnectGlobal(UserInputService.InputBegan,function(inp)
                    if inp.UserInputType~=Enum.UserInputType.MouseButton1 or not isOpen then return end
                    local mp=UserInputService:GetMouseLocation()
                    local dp=DL.AbsolutePosition; local ds2=DL.AbsoluteSize
                    if not (mp.X>=dp.X and mp.X<=dp.X+ds2.X and mp.Y>=dp.Y and mp.Y<=dp.Y+ds2.Y) then closeDD() end
                end)
                function elem:Set(v) sel=v; SL.Text=v; self.Value=v; Library.Flags[flagKey]=v
                    for k,oi in pairs(optionItems) do oi.setSelected(k==v) end; Library:SafeCall(callback,v)
                end
                function elem:SetOpen(b) if b then openDD() else closeDD() end end
                function elem:Get() return self.Value end
                function elem:Refresh(newItems, newDefault)
                    closeDD()
                    opts = newItems or {}
                    for _, c in ipairs(DS:GetChildren()) do
                        if not c:IsA("UIListLayout") then c:Destroy() end
                    end
                    for k in pairs(optionItems) do optionItems[k]=nil end
                    local newSel = newDefault or opts[1] or ""
                    sel = newSel; SL.Text = newSel; self.Value = newSel
                    Library.Flags[flagKey] = newSel
                    for _,opt in ipairs(opts) do
                        local OB=NewInstance("TextButton",{Size=UDim2.new(1,0,0,iH),BackgroundTransparency=1,BorderSizePixel=0,Text="",AutoButtonColor=false,ZIndex=502,Parent=DS})
                        local Dot=NewInstance("Frame",{Size=UDim2.new(0,6,0,6),Position=UDim2.new(0,0,0.5,-3),BackgroundTransparency=1,BorderSizePixel=0,BackgroundColor3=Colors.AccentBlue,ZIndex=503,Parent=OB})
                        AddCorner(99,Dot)
                        local OTxt=NewInstance("TextLabel",{Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0),Text=opt,Font=Enum.Font.Gotham,TextSize=12,TextColor3=Color3.fromRGB(185,185,195),BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=0.3,ZIndex=503,Parent=OB})
                        NewInstance("UIPadding",{PaddingLeft=UDim.new(0,8),Parent=OB})
                        local isSel=(opt==newSel)
                        local function setSelected(v)
                            isSel=v
                            if v then Tween(Dot,{BackgroundTransparency=0}); Tween(OTxt,{TextTransparency=0,Position=UDim2.new(0,14,0,0)})
                            else Tween(Dot,{BackgroundTransparency=1}); Tween(OTxt,{TextTransparency=0.3,Position=UDim2.new(0,0,0,0)}) end
                        end
                        if isSel then setSelected(true) end
                        optionItems[opt]={setSelected=setSelected}
                        OB.InputBegan:Connect(function(inp)
                            if inp.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                            for k,v in pairs(optionItems) do v.setSelected(false) end
                            setSelected(true); sel=opt; SL.Text=opt; self.Value=opt; Library.Flags[flagKey]=opt
                            closeDD(); Library:SafeCall(callback,opt)
                        end)
                    end
                end
                Library.SetFlags[flagKey]=function(v) elem:Set(v) end; self.Elements[#self.Elements+1]=elem; return elem
            end

            function Sec:Keybind(d)
                d=d or {}
                local elem=CreateKeybind(d,self.Items.Content,d.ListName)
                self.Elements[#self.Elements+1]=elem; return elem
            end

            return Sec
        end
        setmetatable(Page,{__index=Library}); return Page
    end
    setmetatable(Win,{__index=Library}); return Win
end

local Blink      = require(ReplicatedStorage.Blink.Client)
local Entity     = require(ReplicatedStorage.Modules.Entity)
local MeleeConst = require(ReplicatedStorage.Constants.Melee)
local Knit       = require(ReplicatedStorage.Modules.Knit.Client)

local function isBlockTool(tool)
    if not tool then return false end
    return tool.Name=="Blocks" or tool.Name:sub(-5)=="Block" or tool.Name:find("Block")~=nil
end

local function isSwordTool(tool)
    if not tool then return false end
    local n=tool.Name
    return n:sub(-5)=="Sword" or n:sub(-3)=="Axe" or n:sub(-4)=="Mace" or n:sub(-5)=="Knife" or n:sub(-4)=="Spear"
end

local cfg = {
    bhop          = false,
    bhopSpeed     = 18,
    airstuck      = false,
    killAura      = false,
    kaRadius      = 10,
    kaTarget      = "Nearest",
    kaCooldown    = (MeleeConst.COOLDOWN or 0.5) + 0.1,
    autoRotate    = false,
    autoBlock     = false,
    miner         = false,
    minerBedsOnly = false,
    noclip        = false,
    fly           = false,
    flySpeed      = 20,
    autoPlace     = false,
}

local apLastPlace = 0
local apRparam    = RaycastParams.new()
apRparam.FilterType = Enum.RaycastFilterType.Exclude

local function apSnapGrid(v)
    local S=3; return Vector3.new(math.round(v.X/S)*S,math.round(v.Y/S)*S,math.round(v.Z/S)*S)
end

RunService.Heartbeat:Connect(function()
    if not cfg.autoPlace then return end
    if os.clock()-apLastPlace<0.1 then return end
    local char=LocalPlayer.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart")
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    if hum.MoveDirection.Magnitude==0 then return end
    local tool=char:FindFirstChildOfClass("Tool")
    if not tool or not isBlockTool(tool) then return end
    local ok,ctrl=pcall(function() return Knit.GetController("BlockPlacementController") end)
    if not ok or not ctrl then return end
    local blockName=tool.Name=="Blocks" and "Clay" or tool.Name:sub(1,-6)
    local moveDir=hum.MoveDirection
    local flatDir=Vector3.new(moveDir.X,0,moveDir.Z)
    if flatDir.Magnitude<0.01 then return end
    flatDir=flatDir.Unit
    apRparam.FilterDescendantsInstances={char}
    for i=0,1 do
        local origin=Vector3.new(root.Position.X+flatDir.X*(i*3),root.Position.Y,root.Position.Z+flatDir.Z*(i*3))
        local hit=workspace:Raycast(origin,Vector3.new(0,-6,0),apRparam)
        if not hit then pcall(function() ctrl:PlaceBlock(apSnapGrid(origin-Vector3.new(0,4.5,0)),blockName) end) end
    end
    apLastPlace=os.clock()
end)

RunService.Stepped:Connect(function()
    if not cfg.noclip then return end
    local char=LocalPlayer.Character; if not char then return end
    for _,part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then part.CanCollide=false end
    end
end)

local flyBV,flyBG=nil,nil

local function stopFly(char)
    if flyBV then flyBV:Destroy(); flyBV=nil end
    if flyBG then flyBG:Destroy(); flyBG=nil end
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand=false; hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
end

local function startFly(char)
    stopFly(char)
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    local hum=char:FindFirstChildOfClass("Humanoid"); if hum then hum.PlatformStand=true end
    flyBV=Instance.new("BodyVelocity"); flyBV.Name="FlyBV"; flyBV.Velocity=Vector3.zero
    flyBV.MaxForce=Vector3.new(1e5,1e5,1e5); flyBV.P=1e4; flyBV.Parent=root
    flyBG=Instance.new("BodyGyro"); flyBG.Name="FlyBG"; flyBG.MaxTorque=Vector3.new(4e5,4e5,4e5)
    flyBG.P=2e4; flyBG.D=1e3; flyBG.CFrame=CFrame.new(root.Position); flyBG.Parent=root
end

RunService.RenderStepped:Connect(function()
    if not cfg.fly then return end
    local char=LocalPlayer.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    if not flyBV or not flyBV.Parent then return end
    if not flyBG or not flyBG.Parent then return end
    local cam=Workspace.CurrentCamera; local cf=cam.CFrame; local dir=Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W)           then dir=dir+cf.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S)           then dir=dir-cf.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A)           then dir=dir-cf.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D)           then dir=dir+cf.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space)       then dir=dir+Vector3.new(0,1,0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir=dir-Vector3.new(0,1,0) end
    flyBV.Velocity=dir.Magnitude>0 and dir.Unit*cfg.flySpeed or Vector3.zero
    local flatLook=Vector3.new(cf.LookVector.X,0,cf.LookVector.Z)
    if flatLook.Magnitude>0.01 then flyBG.CFrame=CFrame.new(root.Position,root.Position+flatLook) end
end)

local kaAttackCooldown=false
local ToolService=require(ReplicatedStorage.Services.ToolService)

local function getNearestEnemy()
    local char=LocalPlayer.Character; if not char or not char.PrimaryPart then return nil end
    local bestDist,bestRoot=math.huge,nil
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LocalPlayer then continue end
        local pc=p.Character; if not pc then continue end
        local pr=pc:FindFirstChild("HumanoidRootPart")
        local ph=pc:FindFirstChildOfClass("Humanoid")
        if not pr or not ph or ph.Health<=0 then continue end
        local dist=(char.PrimaryPart.Position-pr.Position).Magnitude
        if dist<bestDist then bestDist=dist; bestRoot=pr end
    end
    return bestRoot
end

RunService.Heartbeat:Connect(function()
    local char=LocalPlayer.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart")
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    if cfg.autoRotate then
        local enemyRoot=getNearestEnemy()
        if enemyRoot then
            local dir=Vector3.new(enemyRoot.Position.X-root.Position.X,0,enemyRoot.Position.Z-root.Position.Z)
            if dir.Magnitude>0.1 then
                hum.AutoRotate=false
                local _,rotY,_=CFrame.new(root.Position,root.Position+dir):ToEulerAnglesYXZ()
                root.CFrame=CFrame.new(root.Position)*CFrame.Angles(0,rotY,0)
            end
        else hum.AutoRotate=true end
    else hum.AutoRotate=true end
    if cfg.autoBlock then
        local tool=char:FindFirstChildOfClass("Tool")
        if tool and isSwordTool(tool) then
            local enemyRoot=getNearestEnemy()
            if enemyRoot then
                local dist=(root.Position-enemyRoot.Position).Magnitude
                if dist<=20 and not kaAttackCooldown then
                    if not LocalPlayer:GetAttribute("ClientBlocking") then
                        LocalPlayer:SetAttribute("ClientBlocking",true)
                        pcall(function() ToolService:ToggleBlockSword(true,tool.Name) end)
                    end
                elseif kaAttackCooldown then
                    if LocalPlayer:GetAttribute("ClientBlocking") then
                        LocalPlayer:SetAttribute("ClientBlocking",false)
                        pcall(function() ToolService:ToggleBlockSword(false,tool.Name) end)
                    end
                end
            else
                if LocalPlayer:GetAttribute("ClientBlocking") then
                    LocalPlayer:SetAttribute("ClientBlocking",false)
                    pcall(function() ToolService:ToggleBlockSword(false,tool and tool.Name or "") end)
                end
            end
        end
    end
end)

local function GetMoveDir()
    local cam=workspace.CurrentCamera; local lv=cam.CFrame.LookVector; local rv=cam.CFrame.RightVector
    local d=Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then d=d+lv end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then d=d-lv end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then d=d-rv end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then d=d+rv end
    return Vector3.new(d.X,0,d.Z).Unit
end

local function tryAttack(targetChar, weaponName)
    local char=LocalPlayer.Character; if not char or not char.PrimaryPart then return false end
    if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return false end
    local hum=targetChar:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health<=0 then return false end
    local dist=(char.PrimaryPart.Position-targetChar.HumanoidRootPart.Position).Magnitude
    if dist>cfg.kaRadius then return false end
    local targetEntity=Entity.FindByCharacter(targetChar); if not targetEntity then return false end
    local isCrit=char.PrimaryPart.AssemblyLinearVelocity.Y<0
    pcall(function()
        Blink.item_action.attack_entity.fire({
            target_entity_id=targetEntity.Id, is_crit=isCrit, weapon_name=weaponName,
            extra={rizz="Bro.",owo="What's this? OwO ",those=workspace.Name=="Ok"},
        })
    end)
    return true
end

local function getKATarget()
    local char=LocalPlayer.Character; if not char or not char.PrimaryPart then return nil end
    local candidates={}
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LocalPlayer then continue end
        local pchar=p.Character; if not pchar then continue end
        local proot=pchar:FindFirstChild("HumanoidRootPart")
        local phum=pchar:FindFirstChildOfClass("Humanoid")
        if not proot or not phum or phum.Health<=0 then continue end
        local dist=(char.PrimaryPart.Position-proot.Position).Magnitude
        if dist>cfg.kaRadius then continue end
        table.insert(candidates,{char=pchar,dist=dist,hp=phum.Health})
    end
    if #candidates==0 then return nil end
    if cfg.kaTarget=="Nearest" then table.sort(candidates,function(a,b) return a.dist<b.dist end)
    elseif cfg.kaTarget=="Lowest HP" then table.sort(candidates,function(a,b) return a.hp<b.hp end)
    elseif cfg.kaTarget=="Random" then return candidates[math.random(1,#candidates)].char end
    return candidates[1].char
end

local BlockConst   = require(ReplicatedStorage.Constants.Blocks)
local PickaxeConst = require(ReplicatedStorage.Constants.Pickaxes)
local minerBusy=false

local function isPickaxeTool(tool)
    if not tool then return false end
    return tool.Name:find("Pickaxe")~=nil or tool.Name:find("Axe")~=nil or tool.Name:find("Shears")~=nil
end

RunService.Heartbeat:Connect(function()
    if not cfg.miner or minerBusy then return end
    local char=LocalPlayer.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    local tool=char:FindFirstChildOfClass("Tool"); if not tool then return end
    if not isPickaxeTool(tool) then return end
    minerBusy=true
    task.spawn(function()
        local targets={}
        for _,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name=="Block" and v.Parent then
                local dist=(root.Position-v.Position).Magnitude
                local isBed=v.Parent.Name=="Bed"
                if dist<=15 then
                    if cfg.minerBedsOnly and not isBed then continue end
                    table.insert(targets,v)
                end
            end
        end
        for _,block in ipairs(targets) do
            if not block or not block.Parent then continue end
            local blockType=block:GetAttribute("block_type") or "Clay"
            local pos=block.Position; local pickName=tool.Name
            local toolName=blockType=="Clay" and "Blocks" or ("%sBlock"):format(blockType)
            local isBed=block.Parent.Name=="Bed"; local breakTime=1
            pcall(function()
                local bConst=BlockConst[blockType]; local pConst=PickaxeConst[pickName]
                if bConst and pConst then breakTime=bConst*pConst end
                if blockType=="Clay" and pickName=="Shears" then breakTime=BlockConst["Clay"]*PickaxeConst.ClayShears end
                if pickName:find("Axe") and not pickName:find("Pick") then breakTime=BlockConst[blockType]*PickaxeConst.RegularSpeed end
            end)
            for _,face in ipairs(Enum.NormalId:GetEnumItems()) do
                local tx=Instance.new("Texture"); tx.Name="MinerPick"; tx.Face=face
                tx.Transparency=0.3; tx.Color3=Color3.fromRGB(255,80,80)
                tx.StudsPerTileU=3; tx.StudsPerTileV=3; tx.Texture="rbxassetid://100384306731421"
                tx.ZIndex=99; tx.Parent=block
            end
            pcall(function() Blink.item_action.start_break_block.fire({position=pos,pickaxe_name=pickName,timestamp=workspace:GetServerTimeNow()}) end)
            task.wait(breakTime)
            for _,c in ipairs(block:GetChildren()) do if c:IsA("Texture") and c.Name=="MinerPick" then c:Destroy() end end
            pcall(function() Blink.item_action.stop_break_block.fire(true); if not isBed then Entity.LocalEntity:AddTool(toolName,1) end end)
        end
        minerBusy=false
    end)
end)

local _bhopRP=RaycastParams.new(); _bhopRP.FilterType=Enum.RaycastFilterType.Exclude
local _lastEquip=0

RunService.Heartbeat:Connect(function()
    local char=LocalPlayer.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart")
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    if cfg.airstuck then
        for _,p in ipairs(char:GetChildren()) do if p:IsA("BasePart") then p.Anchored=true end end
    end
    if cfg.bhop then
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            _bhopRP.FilterDescendantsInstances={char}
            local ground=Workspace:Raycast(root.Position,Vector3.new(0,-4,0),_bhopRP)
            if ground then hum.Jump=true end
        end
        local dir=GetMoveDir()
        if dir.Magnitude>0 then
            local spd=cfg.bhopSpeed; local vel=root.AssemblyLinearVelocity
            root.AssemblyLinearVelocity=Vector3.new(vel.X+(dir.X*spd-vel.X)*0.2,vel.Y,vel.Z+(dir.Z*spd-vel.Z)*0.2)
        end
    end
    local tool=char:FindFirstChildOfClass("Tool")

    local function equipFromBackpack(checkFn)
        if tool and checkFn(tool) then return true end
        if os.clock() - _lastEquip < 0.05 then return false end
        for _,t in ipairs(LocalPlayer.Backpack:GetChildren()) do
            if t:IsA("Tool") and checkFn(t) then
                _lastEquip = os.clock()
                hum:EquipTool(t)
                return true
            end
        end
        return false
    end

    if cfg.killAura and not kaAttackCooldown then
        local target=getKATarget()
        if target then
            local hasSword = tool and isSwordTool(tool)
            if not hasSword then
                equipFromBackpack(isSwordTool)
            else
                kaAttackCooldown=true
                if cfg.autoBlock and LocalPlayer:GetAttribute("ClientBlocking") then
                    LocalPlayer:SetAttribute("ClientBlocking",false)
                    pcall(function() ToolService:ToggleBlockSword(false,tool.Name) end)
                end
                tryAttack(target,tool.Name)
                task.spawn(function() task.wait(cfg.kaCooldown); kaAttackCooldown=false end)
            end
        elseif cfg.miner and not minerBusy then
            equipFromBackpack(isPickaxeTool)
        elseif cfg.autoPlace then
            equipFromBackpack(isBlockTool)
        end
    elseif cfg.miner and not minerBusy then
        equipFromBackpack(isPickaxeTool)
    elseif cfg.autoPlace then
        equipFromBackpack(isBlockTool)
    end
end)

RunService.Heartbeat:Connect(function()
    if cfg.airstuck then return end
    local char=LocalPlayer.Character; if not char then return end
    for _,p in ipairs(char:GetChildren()) do if p:IsA("BasePart") and p.Anchored then p.Anchored=false end end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    cfg.fly=false; cfg.noclip=false; flyBV=nil; flyBG=nil
end)

local Win = Library:Window({Name="MyScript"})

local MovePage = Win:Page({Name="Movement", Icon=Library.Assets["legit_icon"]})

local BhopSec = MovePage:Section({Name="BUNNY HOP", Side=1})
local bhopToggle = BhopSec:Toggle({Name="Enable", Flag="bhop_enable", Default=false, Callback=function(v) cfg.bhop=v end})
BhopSec:Slider({Name="Speed", Flag="bhop_speed", Default=18, Min=1, Max=30, Decimals=1, Suffix=" spd", Callback=function(v) cfg.bhopSpeed=v end})
BhopSec:Keybind({Name="Bhop Key", Flag="kb_bhop", Default=Enum.KeyCode.Unknown, Mode="Toggle", ListName="Bhop",
    Callback=function(toggled) cfg.bhop=toggled; bhopToggle:Set(toggled) end})

local AirSec = MovePage:Section({Name="AIRSTUCK", Side=2})
local airstuckToggle = AirSec:Toggle({Name="Enable", Flag="airstuck_enable", Default=false, Callback=function(v) cfg.airstuck=v end})
AirSec:Keybind({Name="Airstuck Key", Flag="kb_airstuck", Default=Enum.KeyCode.Unknown, Mode="Hold", ListName="Airstuck",
    Callback=function(toggled) cfg.airstuck=toggled; airstuckToggle:Set(toggled) end})

local NoclipSec = MovePage:Section({Name="NO CLIP", Side=1})
local noclipToggle = NoclipSec:Toggle({Name="Enable", Flag="noclip_enable", Default=false, Callback=function(v) cfg.noclip=v end})
NoclipSec:Keybind({Name="Noclip Key", Flag="kb_noclip", Default=Enum.KeyCode.Unknown, Mode="Toggle", ListName="Noclip",
    Callback=function(toggled) cfg.noclip=toggled; noclipToggle:Set(toggled) end})

local FlySec = MovePage:Section({Name="FLY", Side=2})
local flyToggle = FlySec:Toggle({Name="Enable", Flag="fly_enable", Default=false,
    Callback=function(v) cfg.fly=v; local char=LocalPlayer.Character; if char then if v then startFly(char) else stopFly(char) end end end})
FlySec:Slider({Name="Speed", Flag="fly_speed", Default=20, Min=1, Max=30, Decimals=0, Suffix=" spd", Callback=function(v) cfg.flySpeed=v end})
FlySec:Keybind({Name="Fly Key", Flag="kb_fly", Default=Enum.KeyCode.Unknown, Mode="Toggle", ListName="Fly",
    Callback=function(toggled) cfg.fly=toggled; flyToggle:Set(toggled); local char=LocalPlayer.Character; if char then if toggled then startFly(char) else stopFly(char) end end end})

local AutoPlaceSec = MovePage:Section({Name="AUTO PLACE", Side=1})
local autoPlaceToggle = AutoPlaceSec:Toggle({Name="Enable", Flag="autoplace_enable", Default=false, Callback=function(v) cfg.autoPlace=v end})
AutoPlaceSec:Keybind({Name="AutoPlace Key", Flag="kb_autoplace", Default=Enum.KeyCode.Unknown, Mode="Toggle", ListName="Auto Place",
    Callback=function(toggled) cfg.autoPlace=toggled; autoPlaceToggle:Set(toggled) end})

local KAPage = Win:Page({Name="Kill Aura", Icon=Library.Assets["rage_icon"]})
local KASec  = KAPage:Section({Name="AUTO ATTACK", Side=1})

local kaToggle = KASec:Toggle({Name="Enable", Flag="ka_enable", Default=false, Callback=function(v) cfg.killAura=v end})

KASec:Slider({
    Name="Radius", Flag="ka_radius", Default=10, Min=1, Max=35, Decimals=0, Suffix=" st",
    Callback=function(v) cfg.kaRadius=v end,
})

KASec:Slider({
    Name="Cooldown", Flag="ka_cooldown", Default=0.6, Min=0.05, Max=2, Decimals=2, Suffix=" s",
    Callback=function(v) cfg.kaCooldown=v end,
})

KASec:Dropdown({
    Name="Target", Flag="ka_target",
    Items={"Nearest","Lowest HP","Random"},
    Default="Nearest",
    Callback=function(v) cfg.kaTarget=v end,
})
KASec:Keybind({Name="Kill Aura Key", Flag="kb_killaura", Default=Enum.KeyCode.Unknown, Mode="Hold", ListName="Kill Aura",
    Callback=function(toggled) cfg.killAura=toggled; kaToggle:Set(toggled) end})

local CombatSec = KAPage:Section({Name="COMBAT", Side=2})
local autoRotateToggle = CombatSec:Toggle({Name="Auto Rotate", Flag="autorotate_enable", Default=false, Callback=function(v) cfg.autoRotate=v end})
CombatSec:Keybind({Name="Rotate Key", Flag="kb_autorotate", Default=Enum.KeyCode.Unknown, Mode="Toggle", ListName="Auto Rotate",
    Callback=function(toggled) cfg.autoRotate=toggled; autoRotateToggle:Set(toggled) end})
local autoBlockToggle = CombatSec:Toggle({Name="Auto Block", Flag="autoblock_enable", Default=false, Callback=function(v) cfg.autoBlock=v end})
CombatSec:Keybind({Name="Block Key", Flag="kb_autoblock", Default=Enum.KeyCode.Unknown, Mode="Toggle", ListName="Auto Block",
    Callback=function(toggled) cfg.autoBlock=toggled; autoBlockToggle:Set(toggled) end})

local MinerPage = Win:Page({Name="Miner", Icon=Library.Assets["page_icon"]})
local MinerSec  = MinerPage:Section({Name="AUTO MINER", Side=1})
local minerToggle = MinerSec:Toggle({Name="Enable", Flag="miner_enable", Default=false, Callback=function(v) cfg.miner=v end})
MinerSec:Toggle({Name="Beds Only", Flag="miner_beds_only", Default=false, Callback=function(v) cfg.minerBedsOnly=v end})
MinerSec:Keybind({Name="Miner Key", Flag="kb_miner", Default=Enum.KeyCode.Unknown, Mode="Toggle", ListName="Miner",
    Callback=function(toggled) cfg.miner=toggled; minerToggle:Set(toggled) end})

local ExploitPage = Win:Page({Name="Exploits", Icon=Library.Assets["user_icon"]})

local PearlSec = ExploitPage:Section({Name="PEARL TP", Side=1})

local pearlTargetName = ""
local pearlPlayerList = {}

local function getPlayerNames()
    local names = {}
    pearlPlayerList = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local char = p.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")

        if char and hum and hum.Health > 0 then
            table.insert(names, p.Name)
            pearlPlayerList[p.Name] = p
        end
    end
    if #names == 0 then names = {"(нет игроков)"} end
    return names
end

local playerDrop = PearlSec:Dropdown({
    Name    = "Target",
    Flag    = "pearl_target",
    Items   = getPlayerNames(),
    Default = getPlayerNames()[1] or "",
    Callback = function(v)
        pearlTargetName = v
    end,
})
pearlTargetName = playerDrop:Get()

local lastNames = {}

local function refreshDrop()
    local names = getPlayerNames()
    local changed = #names ~= #lastNames
    if not changed then
        for i,v in ipairs(names) do
            if lastNames[i] ~= v then changed=true; break end
        end
    end
    if changed then
        lastNames = names
        local keep = pearlPlayerList[pearlTargetName] and pearlTargetName or nil
        local newDefault = keep or (names[1] ~= "(нет игроков)" and names[1] or nil)
        playerDrop:Refresh(names, newDefault)
        pearlTargetName = newDefault or ""
    end
end

task.spawn(function()
    while task.wait(1) do
        refreshDrop()
    end
end)

local function hookPlayer(p)
    p.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        refreshDrop()
        local hum = char:WaitForChild("Humanoid", 5)
        if hum then
            hum.Died:Connect(function()
                task.wait(0.1)
                refreshDrop()
            end)
        end
    end)
    if p.Character then
        local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.Died:Connect(function()
                task.wait(0.1)
                refreshDrop()
            end)
        end
    end
end

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then hookPlayer(p) end
end

Players.PlayerAdded:Connect(function(p)
    task.wait(0.5)
    hookPlayer(p)
    refreshDrop()
end)

Players.PlayerRemoving:Connect(function(p)
    task.wait(0.1)
    refreshDrop()
end)

local CollectionService = game:GetService("CollectionService")

local function getPearlTool()
    local char = LocalPlayer.Character
    if not char then return nil end
    for _, obj in ipairs(CollectionService:GetTagged("Pearl")) do
        if obj:IsDescendantOf(char) and obj:IsA("Tool") then return obj end
    end
    for _, t in ipairs(char:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("pearl") then return t end
    end
    return nil
end

local function equipPearl()
    local char = LocalPlayer.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    if getPearlTool() then return true end
    for _, t in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if t:IsA("Tool") and (t.Name:lower():find("pearl") or CollectionService:HasTag(t, "Pearl")) then
            hum:EquipTool(t)
            task.wait(0.15)
            return getPearlTool() ~= nil
        end
    end
    return false
end

local function firePearl(aimPos)
    local tool = getPearlTool()
    if not tool then return false, "нет перла в руках" end

    local ok, err = pcall(function()
        local Comm = require(ReplicatedStorage.Modules.Comm)
        local comm = Comm.ClientComm.new(tool, true)

        local fn = comm:GetFunction("Fire")
        fn(aimPos):catch(warn)
    end)

    if ok then return true
    else return false, tostring(err):sub(1, 60) end
end

local tpStatus = PearlSec:Toggle({
    Name    = "► TP PEARL",
    Flag    = "pearl_tp_btn",
    Default = false,
    Callback = function(v)
        if not v then return end

        task.spawn(function()

            task.delay(0.15, function()
                Library.SetFlags["pearl_tp_btn"](false)
            end)

            local targetPlayer = pearlPlayerList[pearlTargetName]
            if not targetPlayer then
                warn("[PearlTP] no player selected or player left")
                return
            end
            if not targetPlayer.Parent then
                warn("[PearlTP] player left the game")
                return
            end

            local tChar = targetPlayer.Character
            if not tChar then warn("[PearlTP] target has no character"); return end

            local tRoot = tChar:FindFirstChild("HumanoidRootPart")
            if not tRoot then warn("[PearlTP] target has no HumanoidRootPart"); return end

            local targetPos = tRoot.Position

            local equipped = equipPearl()
            if not equipped then
                warn("[PearlTP] pearl not found in backpack")
                return
            end

            local myChar2 = LocalPlayer.Character
            local myRoot2 = myChar2 and myChar2:FindFirstChild("HumanoidRootPart")
            if not myRoot2 then warn("[PearlTP] local HRP missing"); return end

            local downPos = myRoot2.Position - Vector3.new(0, 100, 0)
            local fired, err2 = firePearl(downPos)
            if not fired then
                warn("[PearlTP] fire failed: " .. tostring(err2))
                return
            end

            task.wait(0.25)

            local tChar2 = targetPlayer.Character
            local tRoot2 = tChar2 and tChar2:FindFirstChild("HumanoidRootPart")
            if not tRoot2 then warn("[PearlTP] target disappeared"); return end

            local myChar3 = LocalPlayer.Character
            local myRoot3 = myChar3 and myChar3:FindFirstChild("HumanoidRootPart")
            if not myRoot3 then warn("[PearlTP] local character disappeared"); return end

            myRoot3.CFrame = CFrame.new(tRoot2.Position + Vector3.new(0, 3, 0))
            print("[PearlTP] teleported to " .. targetPlayer.Name)
        end)
    end,
})

local BedSec = ExploitPage:Section({Name="BED TP", Side=2})

local function getAllBeds()
    local beds = {}
    local myTeam = LocalPlayer:GetAttribute("OriginalTeam")
    local mapFolder = Workspace:FindFirstChild("Map")
    if not mapFolder then return beds end
    for _, obj in ipairs(mapFolder:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Bed" then
            local team = obj:GetAttribute("Team")
            if team and team ~= myTeam then
                table.insert(beds, {model=obj, team=team})
            end
        end
    end
    return beds
end

local function isBedAlive(bedModel)
    if not bedModel or not bedModel.Parent then return false end
    local mapFolder = Workspace:FindFirstChild("Map")
    if not mapFolder then return false end
    for _, obj in ipairs(mapFolder:GetDescendants()) do
        if obj == bedModel then return true end
    end
    return false
end

local function getBedPosition(bed)
    if bed.PrimaryPart then
        return bed.PrimaryPart.Position
    end
    local anyPart = bed:FindFirstChildWhichIsA("BasePart")
    if anyPart then return anyPart.Position end
    return nil
end

local function doBedTP(bedModel, teamName)
    local bedPos = getBedPosition(bedModel)
    if not bedPos then
        warn("[BedTP] bed has no BasePart | team =", teamName)
        return
    end

    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then warn("[BedTP] local HRP missing"); return end

    print("[BedTP] --- tp to", teamName, "bed ---")
    print("[BedTP] bed pos =", tostring(bedPos))

    local equipped = equipPearl()
    if not equipped then warn("[BedTP] pearl not found in backpack"); return end
    print("[BedTP] pearl equipped")

    local downPos = myRoot.Position - Vector3.new(0, 100, 0)
    print("[BedTP] firing pearl down | aimPos =", tostring(downPos))

    local fired, fireErr = firePearl(downPos)
    if not fired then warn("[BedTP] fire failed: " .. tostring(fireErr)); return end
    print("[BedTP] pearl fired, waiting 0.25s...")

    task.wait(0.25)

    local myChar2 = LocalPlayer.Character
    local myRoot2 = myChar2 and myChar2:FindFirstChild("HumanoidRootPart")
    if not myRoot2 then warn("[BedTP] local character disappeared after wait"); return end

    myRoot2.CFrame = CFrame.new(bedPos + Vector3.new(0, 4, 0))
    print("[BedTP] teleported to", teamName, "bed at", tostring(bedPos))
    print("[BedTP] --- done ---")
end

BedSec:Toggle({
    Name    = "► TP TO MY BED",
    Flag    = "bed_tp_btn",
    Default = false,
    Callback = function(v)
        if not v then return end
        task.spawn(function()
            task.delay(0.15, function() Library.SetFlags["bed_tp_btn"](false) end)
            local myTeam = LocalPlayer:GetAttribute("OriginalTeam")
            if not myTeam then warn("[BedTP] LocalPlayer has no [OriginalTeam] attribute"); return end
            print("[BedTP] my team =", myTeam)
            local beds = getAllBeds()
            local myBed = nil
            for _, b in ipairs(beds) do
                if b.team == myTeam then myBed = b; break end
            end
            if not myBed then warn("[BedTP] no bed found for team: " .. myTeam); return end
            doBedTP(myBed.model, myTeam)
        end)
    end,
})

local bedTargetTeam = ""
local bedTeamList   = {}

local function getBedTeams()
    local teams = {}
    bedTeamList = {}
    local beds = getAllBeds()
    for _, b in ipairs(beds) do
        if not bedTeamList[b.team] then
            bedTeamList[b.team] = b.model
            table.insert(teams, b.team)
        end
    end
    table.sort(teams)
    if #teams == 0 then teams = {"(no beds)"} end
    return teams
end

local bedDrop = BedSec:Dropdown({
    Name     = "Team",
    Flag     = "bed_target_team",
    Items    = {"(no beds)"},
    Default  = "(no beds)",
    Callback = function(v)
        bedTargetTeam = v
        bedTeamList = {}
        local beds = getAllBeds()
        for _, b in ipairs(beds) do
            bedTeamList[b.team] = b.model
        end
    end,
})
bedTargetTeam = bedDrop:Get()

task.spawn(function()
    local bedsFound = false

    local function doInit()
        local teams = getBedTeams()
        if #teams == 0 or teams[1] == "(no beds)" then return false end
        local newDefault = teams[1]
        bedDrop:Refresh(teams, newDefault)
        bedTargetTeam = newDefault
        bedsFound = true
        return true
    end

    local waited = 0
    while waited < 30 and not bedsFound do
        if doInit() then break end
        task.wait(0.5)
        waited += 0.5
    end

    if not bedsFound then
        local mapFolder = Workspace:FindFirstChild("Map") or Workspace:WaitForChild("Map", 10)
        if mapFolder then
            local conn
            conn = mapFolder.DescendantAdded:Connect(function(desc)
                if bedsFound then conn:Disconnect(); return end
                if desc:IsA("Model") and desc.Name == "Bed" and desc:GetAttribute("Team") then
                    task.wait(0.2)
                    if doInit() then conn:Disconnect() end
                end
            end)
        end
    end
end)

BedSec:Toggle({
    Name    = "► TP TO BED",
    Flag    = "bed_team_tp_btn",
    Default = false,
    Callback = function(v)
        if not v then return end
        task.spawn(function()
            task.delay(0.15, function() Library.SetFlags["bed_team_tp_btn"](false) end)
            if bedTargetTeam == "" or bedTargetTeam == "(no beds)" then
                warn("[BedTP] no team selected")
                return
            end
            local bedModel = bedTeamList[bedTargetTeam]
            if not bedModel then
                warn("[BedTP] bed model not found for team: " .. bedTargetTeam)
                return
            end
            if not isBedAlive(bedModel) then
                warn("[BedTP] bed is destroyed | team: " .. bedTargetTeam)
                return
            end
            print("[BedTP] bed exists | team: " .. bedTargetTeam)
            doBedTP(bedModel, bedTargetTeam)
        end)
    end,
})

print("[MyScript] loaded | game_tag=..."..GAME_TAG)