repeat
	task.wait()
until game.Players.LocalPlayer.Character
local localPlayer = game.Players.LocalPlayer
local playerCharacter = localPlayer.Character
local currentCamera = workspace.CurrentCamera
local mouse = localPlayer:GetMouse()
local carbonResource = game.ReplicatedStorage:WaitForChild("CarbonResource")
local carbonEvents = carbonResource:WaitForChild("Events")
local carbonFx = carbonResource:WaitForChild("FX")
local _carbonResourceModels = carbonResource:WaitForChild("Models")
local carbonClientResourceModels = _carbonResourceModels:WaitForChild("Client")
local _carbonResourceModels = _carbonResourceModels:WaitForChild("Server")
local carbonHUD = carbonResource:WaitForChild("HUD")
local carbonGlobalResource = carbonResource:WaitForChild("Global")
local carbonModules = carbonResource:WaitForChild("Modules")
local carbonAccessories = carbonResource:WaitForChild("Accessories")
local _carbonArms = carbonAccessories:WaitForChild("Arms")
local _wearable = carbonAccessories:WaitForChild("Wearable")
local carbonAudio
local _aBullet = nil
local rotation = CFrame.Angles(0, 0, 0)
local dataStorage =
	script:FindFirstChild("DataStorage") or Instance.new("Folder")
dataStorage.Name = "DataStorage"
dataStorage.Parent = script
local menuStorage = game.ReplicatedStorage:FindFirstChild("Menu_Storage") or nil
local attachmentStorage
local eventsStorage
local toolStorage
if menuStorage then
	attachmentStorage = menuStorage:WaitForChild("Attachments")
	eventsStorage = menuStorage:WaitForChild("Events")
	toolStorage = game.ReplicatedStorage:WaitForChild("ToolStorage")
else
	attachmentStorage = carbonResource:WaitForChild("Attachments")
end
local tweenService = game:GetService("TweenService")
local renderLoop = game:GetService("RunService").RenderStepped
local userInputService = game:GetService("UserInputService")
local contextActionService = game:GetService("ContextActionService")
local playerArms = {
	head = playerCharacter:WaitForChild("Head"),
	torso = playerCharacter:WaitForChild("Torso"),
	rightArm = playerCharacter:WaitForChild("Right Arm"),
	leftArm = playerCharacter:WaitForChild("Left Arm"),
	rightLeg = playerCharacter:WaitForChild("Right Leg"),
	leftLeg = playerCharacter:WaitForChild("Left Leg"),
	rootPart = playerCharacter:WaitForChild("HumanoidRootPart"),
	humanoid = playerCharacter:WaitForChild("Humanoid"),
	neck = playerCharacter.Torso:WaitForChild("Neck"),
	rightShoulder = playerCharacter.Torso:WaitForChild("Right Shoulder"),
	leftShoulder = playerCharacter.Torso:WaitForChild("Left Shoulder"),
	rightHip = playerCharacter.Torso:WaitForChild("Right Hip"),
	leftHip = playerCharacter.Torso:WaitForChild("Left Hip"),
	rootJoint = playerCharacter.HumanoidRootPart:WaitForChild("RootJoint")
}
local carbonConfigs = {
	globalConfig = require(carbonGlobalResource:WaitForChild("GlobalConfig")),
	ignoreModule = require(carbonModules:WaitForChild("IgnoreModule")),
	ragdollModule = require(carbonModules:WaitForChild("Ragdoll")),
	setupModule = require(carbonModules:WaitForChild("SetupModule")),
	springModule = require(carbonModules:WaitForChild("Spring")),
	utilitiesModule = require(carbonModules:WaitForChild("Utilities")),
	codeArchive = require(carbonModules:WaitForChild("CodeArchive")),
	tableContainer = require(carbonModules:WaitForChild("TableContainer")),
	attachmentAPI = require(carbonModules:WaitForChild("AttachmentAPI"))
}
local carbonEvents = {
	equipEvent = playerArms:WaitForChild("Equip"),
	updateCharEvent = playerArms:WaitForChild("UpdateChar"),
	halfStepEvent = playerArms:WaitForChild("HalfStep"),
	damageEvent = playerArms:WaitForChild("DamageEvent"),
	whizEvent = playerArms:WaitForChild("WhizEvent"),
	hitEvent = playerArms:WaitForChild("HitEvent"),
	flybyEvent = playerArms:WaitForChild("flybyEvent"),
	serverFXEvent = playerArms:WaitForChild("ServerFXEvent"),
	storeDataEvent = playerArms:WaitForChild("StoreData"),
	createOwnerEvent = playerArms:WaitForChild("CreateOwner"),
	manipEvent = playerArms:WaitForChild("ManipEvent"),
	resupplyEvent = playerArms:WaitForChild("ResupplyEvent"),
	medEvent = playerArms:WaitForChild("MedEvent"),
	explosiveEvent = playerArms:WaitForChild("ExplosiveEvent"),
	connectionEvent = playerArms:WaitForChild("EventConnection"),
	nadeEvent = playerArms:WaitForChild("NadeEvent"),
	placeC4Event = playerArms:WaitForChild("PlaceC4"),
	attachmentEvent = playerArms:WaitForChild("AttachmentEvent"),
	clearAttchEvent = playerArms:WaitForChild("ClearAttachment")
}

local function prnt(txt)
	-- used this for debugging lol
	--print("[CE HOOK] "..txt)
end
local massVariableArray = {
	tool = nil,
	curModel = nil,
	curConfig = nil,
	aimSFX = nil,
	RA = nil,
	RAW = nil,
	LA = nil,
	LAW = nil,
	NeckCW = nil,
	AnimBase = nil,
	AnimBaseW = nil,
	BasePart = nil,
	ArmModel = nil,
	Grip = nil,
	GripW = nil,
	GripW2 = nil,
	AimPart = nil,
	AimPart2 = nil,
	CurAimPart = nil,
	lastAimPart = nil,
	FirePart = nil,
	Bolt = nil,
	BoltW = nil,
	Mag = nil,
	FirePart2 = nil,
	hud = nil,
	mainFrame = nil,
	mode1 = nil,
	mode2 = nil,
	mode3 = nil,
	mode4 = nil,
	mode5 = nil,
	ammoDisplay = nil,
	magCountDisplay = nil,
	title = nil,
	stanceDisplay = nil,
	weapDisplay = nil,
	intenseShade = nil,
	painShade = nil,
	progressBar = nil,
	menuFrame = nil,
	optionButton = nil,
	keybindButton = nil,
	patchButton = nil,
	storeButton = nil,
	menuButton = nil,
	sensDisplay = nil,
	radialFrame = nil,
	radialOutter = nil,
	radialInner = nil,
	radialTop = nil,
	radialButtom = nil,
	radialRight = nil,
	radialLeft = nil,
	radialCenter = nil,
	mainFrame2 = nil,
	aimButton = nil,
	boltButton = nil,
	crouchButton = nil,
	jumpButton = nil,
	proneButton = nil,
	reloadButton = nil,
	shootButton = nil,
	mobileAmmo = nil,
	fireSelectButton = nil,
	sprintButton = nil,
	charView = nil,
	overlay = nil,
	cc = nil,
	noise = nil,
	attachFrame = nil,
	tempFolder = nil,
	Ammo = 30,
	StoredAmmo = 30,
	ExplosiveAmmo = 3,
	FireMode = 0,
	baseWalkspeed = 16,
	aimWalkSpeed = 9,
	StanceIndex = 0,
	Recoiling = false,
	RecoilFront = false,
	Seated = false,
	HalfStep = true,
	MouseHeld = false,
	CanShoot = false,
	newCamOffset = CFrame.new(),
	camC0 = Vector3.new(),
	camC1 = CFrame.new(),
	origSens = userInputService.MouseDeltaSensitivity,
	baseSens = 1,
	aimSens = 1,
	NadeMode = carbonConfigs.globalConfig.NadeMode,
	FragAmmo = carbonConfigs.globalConfig.FragAmmo,
	FlashAmmo = carbonConfigs.globalConfig.FlashAmmo,
	SmokeAmmo = carbonConfigs.globalConfig.SmokeAmmo,
	C4Ammo = carbonConfigs.globalConfig.C4Ammo,
	readyMode = 0,
	curZoom = nil,
	queued = nil,
	Stamina = 1,
	StaminaMult = carbonConfigs.globalConfig.StaminaMult,
	HopUp = 0,
	oHopUp = 0
}
local mathVariables = {
	swayCF = CFrame.new(),
	Sensitivity = 0.6,
	Delta = 0.2,
	Multiplier = -0.3,
	desiredXOffset = 0,
	desiredYOffset = 0,
	swayInputLimit = 35,
	hipSway = 12,
	aimSway = 5,
	gunSway = carbonConfigs.springModule.new(Vector3.new()),
	movinganim = CFrame.new(),
	camanim = CFrame.new(),
	walkTick = 0,
	walkAnimIntensity = 0.08,
	walkAnimSpeed = 12,
	idleTick = 0,
	idleAnimation = CFrame.new(),
	idleIntensity = 0.1,
	idleSpeed = 2,
	deltaX = 0,
	deltaY = 0,
	oc1 = nil,
	oc0 = nil
}
local aimInSounds = carbonConfigs.tableContainer.AimInSounds
local aimOutSounds = carbonConfigs.tableContainer.AimOutSounds
local componentCollection = {playerCharacter, carbonAudio, currentCamera}
local componentList = {playerCharacter, carbonAudio, currentCamera}
local darkNoiseTable = carbonConfigs.tableContainer.DarkNoise
local lightNoiseTableContainer = carbonConfigs.tableContainer.LightNoise
local resultData = {}
local recoilData = {}
recoilData.recoilSpring = carbonConfigs.springModule.new(Vector3.new())
recoilData.recoilSpring.s = 45
recoilData.recoilSpring.d = 0.45
recoilData.recoilSpring2 = carbonConfigs.springModule.new(Vector3.new())
recoilData.recoilSpring2.s = 35
recoilData.recoilSpring2.d = 0.45
recoilData.cornerPeek = carbonConfigs.springModule.new(0)
recoilData.cornerPeek.d = 0.8
recoilData.cornerPeek.s = 16
recoilData.peekFactor = math.rad(10)
recoilData.dirPeek = 0
local Ca = false
local va = false
local L = false
local za = false
local ya = false
local qa = false
local da = false
local ea = false
local la = false
local oa = false
local Q = false
local ma = false
local ta = false
local Aa = false
local H = false
local T = false
local h = playerCharacter:WaitForChild("Humanoid").Health
local f = false
local X = "Option"
local O = false
local A = false
local q = false
local wa = false
local k = true
local _ = false
local ja = false
local G = false
local ka = false
local na = false
local i = false
local ba = false
local I = nil
local pa = false
local z = false
local g = false
local Z = nil
local V = nil
local m = true
local W = false
local fa = false
local d = true
local x = true
local w = false
local n = false
local l = false
local ia = false
local P = 40
local R = 70
local K = false
local F = {CFrame.new(), CFrame.new()}
local E
local M
local aa
local j = 10000
local Y
local _ = false
local C = false
local N = "Radial_Center"
local _ = "None"
local D
local ga
local e
local J
massVariableArray.hud = carbonHUD:WaitForChild("WeaponHUD"):clone()
massVariableArray.hud.Parent = localPlayer.PlayerGui
for _, _ in pairs(massVariableArray.hud:GetDescendants()) do
	if _ then
		if _.Name == "MainFrame" then
			massVariableArray.mainFrame = _
			massVariableArray.mainFrame.Visible = false
		elseif _.Name == "Mode1" then
			massVariableArray.mode1 = _
		elseif _.Name == "Mode2" then
			massVariableArray.mode2 = _
		elseif _.Name == "Mode3" then
			massVariableArray.mode3 = _
		elseif _.Name == "Mode4" then
			massVariableArray.mode4 = _
		elseif _.Name == "Mode5" then
			massVariableArray.mode5 = _
		elseif _.Name == "Ammo" then
			massVariableArray.ammoDisplay = _
		elseif _.Name == "MagCount" then
			massVariableArray.magCountDisplay = _
		elseif _.Name == "Title" then
			massVariableArray.title = _
		elseif _.Name == "Stances" then
			massVariableArray.stanceDisplay = _
		elseif _.Name == "WeapDisplay" then
			massVariableArray.weapDisplay = _
		elseif _.Name == "Intense" then
			massVariableArray.intenseShade = _
		elseif _.Name == "Pain" then
			massVariableArray.painShade = _
		elseif _.Name == "Sensitivity" then
			massVariableArray.sensDisplay = _
		elseif _.Name == "Progress" then
			massVariableArray.progressBar = _
			massVariableArray.progressBar.Size = UDim2.new(1, 0, 1, -4)
		elseif _.Name == "MenuFrame" then
			massVariableArray.menuFrame = _
		elseif _.Name == "OptionButton" then
			massVariableArray.optionButton = _
		elseif _.Name == "KeybindButton" then
			massVariableArray.keybindButton = _
		elseif _.Name == "PatchButton" then
			massVariableArray.patchButton = _
		elseif _.Name == "StoreButton" then
			massVariableArray.storeButton = _
		elseif _.Name == "Radial_Menu" then
			massVariableArray.radialFrame = _
		elseif _.Name == "Radial_Outter" then
			massVariableArray.radialOutter = _
		elseif _.Name == "Radial_Inner" then
			massVariableArray.radialInner = _
		elseif _.Name == "Radial_Top" then
			massVariableArray.radialTop = _
		elseif _.Name == "Radial_Right" then
			massVariableArray.radialRight = _
		elseif _.Name == "Radial_Bottom" then
			massVariableArray.radialBottom = _
		elseif _.Name == "Radial_Left" then
			massVariableArray.radialLeft = _
		elseif _.Name == "Radial_Center" then
			massVariableArray.radialCenter = _
		elseif _.Name == "CharView" then
			massVariableArray.charView = _
			D = Instance.new("Camera")
			D.Parent = massVariableArray.charView
			massVariableArray.charView.CurrentCamera = D
			D.CFrame = CFrame.new(10, 10, 10) * CFrame.Angles(10, 10, 10)
			ga = Instance.new("Model")
			ga.Parent = massVariableArray.charView
			ga.Name = ""
			e = Instance.new("Humanoid")
			e.Parent = ga
			J = Instance.new("Part")
			J.Size = Vector3.new(2, 2, 1)
			J.Name = "Torso"
			J.Parent = ga
			J.CanCollide = false
			J.BrickColor =
				BrickColor.new("Institutional white")
			local _ = Instance.new("Part")
			_.Size = Vector3.new(2, 1, 1)
			_.Name = "Head"
			_.Parent = ga
			_.CanCollide = false
			_.Position = Vector3.new(0, 1.5, 0)
			playerCharacter:WaitForChild("Head"):WaitForChild("Mesh"):Clone().Parent = _
			_.BrickColor =
				BrickColor.new("Institutional white")
			local _ = Instance.new("Part")
			_.Size = Vector3.new(1, 2, 1)
			_.Name = "Right Arm"
			_.Parent = ga
			_.CanCollide = false
			_.Position = Vector3.new(1.5, 0, 0)
			_.BrickColor =
				BrickColor.new("Institutional white")
			local _ = Instance.new("Part")
			_.Size = Vector3.new(1, 2, 1)
			_.Name = "Left Arm"
			_.Parent = ga
			_.CanCollide = false
			_.Position = Vector3.new(-1.5, 0, 0)
			_.BrickColor =
				BrickColor.new("Institutional white")
			local _ = Instance.new("Part")
			_.Size = Vector3.new(1, 2, 1)
			_.Name = "Right Leg"
			_.Parent = ga
			_.CanCollide = false
			_.Position = Vector3.new(0.5, -2, 0)
			_.BrickColor =
				BrickColor.new("Institutional white")
			local _ = Instance.new("Part")
			_.Size = Vector3.new(1, 2, 1)
			_.Name = "Left Leg"
			_.Parent = ga
			_.CanCollide = false
			_.Position = Vector3.new(-0.5, -2, 0)
			_.BrickColor =
				BrickColor.new("Institutional white")
			ga.PrimaryPart = ga:WaitForChild("Torso")
		elseif _.Name == "MenuButton" then
			massVariableArray.menuButton = _
		elseif _.Name == "Overlay" then
			massVariableArray.overlay = _
		elseif _.Name == "MainFrame2" then
			massVariableArray.mainFrame2 = _
		elseif _.Name == "Aim_Button" then
			massVariableArray.aimButton = _
		elseif _.Name == "Bolt_Button" then
			massVariableArray.boltButton = _
		elseif _.Name == "Crouch_Button" then
			massVariableArray.crouchButton = _
		elseif _.Name == "Jump_Button" then
			massVariableArray.jumpButton = _
		elseif _.Name == "Prone_Button" then
			massVariableArray.proneButton = _
		elseif _.Name == "Reload_Button" then
			massVariableArray.reloadButton = _
		elseif _.Name == "Shoot_Button" then
			massVariableArray.shootButton = _
		elseif _.Name == "Mobile_Ammo" then
			massVariableArray.mobileAmmo = _
		elseif _.Name == "FireSelect_Button" then
			massVariableArray.fireSelectButton = _
		elseif _.Name == "Sprint_Button" then
			massVariableArray.sprintButton = _
		elseif _.Name == "TemplateFolder" then
			massVariableArray.tempFolder = _
		elseif _.Name == "Attachment_Frame" then
			massVariableArray.attachFrame = _
		end
	end
end
massVariableArray.cc =
	game.Lighting:FindFirstChild("NVGColor") or
	Instance.new("ColorCorrectionEffect")
massVariableArray.cc.Parent = game.Lighting
massVariableArray.cc.Name = "NVGColor"
massVariableArray.noise = massVariableArray.hud:WaitForChild("Noise")
k = carbonConfigs.globalConfig.CanHeal
local _ =
	game.ReplicatedStorage:FindFirstChild(localPlayer.UserId .. "Sensi") or
	Instance.new("Folder")
_.Name = localPlayer.UserId .. "Sensi"
_.Parent = game.ReplicatedStorage
local e =
	_:FindFirstChild("BaseSens") or Instance.new("NumberValue")
e.Parent = _
e.Name = "BaseSens"
local c =
	_:FindFirstChild("AimSens") or Instance.new("NumberValue")
c.Parent = _
c.Name = "AimSens"
if e.Value ~= 0 then
	massVariableArray.baseSens = e.Value
else
	e.Value = massVariableArray.baseSens
end
if c.Value ~= 0 then
	massVariableArray.aimSens = c.Value
else
	c.Value = massVariableArray.aimSens
end
massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild("Option"):WaitForChild(
"BaseSens"
):WaitForChild("Context").Text = massVariableArray.baseSens
massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild("Option"):WaitForChild(
"AimSens"
):WaitForChild("Context").Text = massVariableArray.aimSens
for _, _ in pairs(carbonEvents) do
	if _ then
		table.insert(resultData, _.Name)
		_.Name = ""
	end
end
function AttachAttachment(a, _)
	if a and a.Name ~= "" then
		carbonConfigs.attachmentAPI.Attach(a, _)
	end
end
function EquipModel(_)
	prnt("Gun equipped")
	va = true
	massVariableArray.mainFrame.Visible = true
	carbonAudio =
		workspace:WaitForChild("BulletModel") or
		Instance.new("Folder")
	carbonAudio.Name = "BulletModel"
	carbonAudio.Parent = workspace
	table.insert(componentCollection, carbonAudio)
	localPlayer.CameraMaxZoomDistance = 0.5
	mouse.TargetFilter = workspace
	userInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	userInputService.MouseIconEnabled = false
	contextActionService:BindAction("Shoot", MobileShoot, true)
	contextActionService:SetPosition("Shoot", UDim2.new(1, -85, 1, -75))
	contextActionService:SetImage(
		"Shoot",
		"rbxassetid://5861899658"
	)
	if
		localPlayer:WaitForChild("PlayerGui"):FindFirstChild(
		"ContextActionGui"
		)
	then
		localPlayer:WaitForChild("PlayerGui"):WaitForChild(
		"ContextActionGui"
		):WaitForChild("ContextButtonFrame"):WaitForChild(
		"ContextActionButton"
		).Size = UDim2.new(0, 72, 0, 72)
		localPlayer:WaitForChild("PlayerGui"):WaitForChild(
		"ContextActionGui"
		):WaitForChild("ContextButtonFrame"):WaitForChild(
		"ContextActionButton"
		).Active = false
	end
	contextActionService:BindAction("SelectFire", MobileSelectFire, true)
	contextActionService:SetPosition("SelectFire", UDim2.new(1, -162, 1, -140))
	contextActionService:SetImage(
		"SelectFire",
		"rbxassetid://5862289667"
	)
	contextActionService:BindAction("Bolt", MobileBolt, true)
	contextActionService:SetPosition("Bolt", UDim2.new(1, -118, 1, -102))
	contextActionService:SetImage(
		"Bolt",
		"rbxassetid://5861959780"
	)
	contextActionService:BindAction("Reload", MobileReload, true)
	contextActionService:SetPosition("Reload", UDim2.new(1, -130, 1, -55))
	contextActionService:SetImage(
		"Reload",
		"rbxassetid://5861917803"
	)
	contextActionService:BindAction("Jump", MobileJump, true)
	contextActionService:SetPosition("Jump", UDim2.new(1, -165, 1, -90))
	contextActionService:SetImage(
		"Jump",
		"rbxassetid://5861963801"
	)
	contextActionService:BindAction("Prone", MobileProne, true)
	contextActionService:SetPosition("Prone", UDim2.new(1, -112, 1, -152))
	contextActionService:SetImage(
		"Prone",
		"rbxassetid://5861969398"
	)
	contextActionService:BindAction("NewCrouch", MobileCrouch, true)
	contextActionService:SetPosition("NewCrouch", UDim2.new(1, -70, 1, -175))
	contextActionService:SetImage(
		"NewCrouch",
		"rbxassetid://5861968749"
	)
	massVariableArray.tool = _
	massVariableArray.ArmModel = currentCamera:FindFirstChild("ArmModel") or Instance.new("Model")
	massVariableArray.ArmModel.Name = "ArmModel"
	massVariableArray.ArmModel.Parent = currentCamera
	massVariableArray.BasePart = Instance.new("Part")
	massVariableArray.BasePart.Name = "BasePart"
	massVariableArray.BasePart.Parent = massVariableArray.ArmModel
	massVariableArray.BasePart.Anchored = true
	massVariableArray.BasePart.CanCollide = false
	massVariableArray.BasePart.Transparency = 1
	massVariableArray.BasePart.Size = Vector3.new(0.1, 0.1, 0.1)
	massVariableArray.PrimeAnimBase = Instance.new("Part")
	massVariableArray.PrimeAnimBase.Name = "PrimeAnimBase"
	massVariableArray.PrimeAnimBase.Parent = massVariableArray.ArmModel
	massVariableArray.PrimeAnimBase.Anchored = true
	massVariableArray.PrimeAnimBase.CanCollide = false
	massVariableArray.PrimeAnimBase.Transparency = 1
	massVariableArray.PrimeAnimBase.Size = Vector3.new(0.1, 0.1, 0.1)
	massVariableArray.PrimeAnimBaseW = Instance.new("Motor6D")
	massVariableArray.PrimeAnimBaseW.Parent = massVariableArray.PrimeAnimBase
	massVariableArray.PrimeAnimBaseW.Name = "PrimeAnimBaseW"
	massVariableArray.PrimeAnimBaseW.Part0 = massVariableArray.PrimeAnimBase
	massVariableArray.PrimeAnimBaseW.Part1 = massVariableArray.BasePart
	massVariableArray.PrimeAnimBase.Anchored = false
	massVariableArray.AnimBase = Instance.new("Part")
	massVariableArray.AnimBase.Name = "AnimBase"
	massVariableArray.AnimBase.Parent = massVariableArray.ArmModel
	massVariableArray.AnimBase.Anchored = true
	massVariableArray.AnimBase.CanCollide = false
	massVariableArray.AnimBase.Transparency = 1
	massVariableArray.AnimBase.Size = Vector3.new(0.1, 0.1, 0.1)
	massVariableArray.AnimBaseW = Instance.new("Motor6D")
	massVariableArray.AnimBaseW.Parent = massVariableArray.AnimBase
	massVariableArray.AnimBaseW.Name = "AnimBaseW"
	massVariableArray.AnimBaseW.Part0 = massVariableArray.AnimBase
	massVariableArray.AnimBaseW.Part1 = massVariableArray.PrimeAnimBase
	massVariableArray.AnimBase.Anchored = false
	massVariableArray.curModel = carbonClientResourceModels:WaitForChild(_.Name):clone()
	if menuStorage then
		local _, _, a, b = eventsStorage:WaitForChild("DataRequest"):InvokeServer()
		local _ = a
		local _ = b
		local _, c = eventsStorage:WaitForChild("AttchQueue"):InvokeServer()
		if massVariableArray.curModel.Name == a and _[1] then
			AttachAttachment(massVariableArray.curModel, _)
		elseif massVariableArray.curModel.Name == b and c[1] then
			AttachAttachment(massVariableArray.curModel, c)
		end
	end
	massVariableArray.curModel.Parent = massVariableArray.ArmModel
	massVariableArray.curConfig =
		require(
			massVariableArray.tool:WaitForChild("ConfigMods"):WaitForChild("CConfig")
		)
	local _ = {}
	for _, _ in pairs(massVariableArray.curModel:GetChildren()) do
		if _:IsA("BasePart") and _.Name ~= "Grip" then
			local a
			if string.match(_.Name, "Hinge") then
				a = massVariableArray.curModel:FindFirstChild(string.sub(_.Name, 6, string.len(_.Name)))
			end
			if a then
				if massVariableArray.curModel:FindFirstChild("Hinge" .. a.Name) then
					carbonConfigs.utilitiesModule.Weld(a, massVariableArray.curModel:WaitForChild("Hinge" .. a.Name))
				else
					carbonConfigs.utilitiesModule.Weld(a, massVariableArray.curModel:WaitForChild("Grip"))
				end
			end
		end
	end
	for _, a in pairs(massVariableArray.curModel:GetChildren()) do
		if a and not a:FindFirstChild(a.Name) and a:IsA("BasePart") then
			carbonConfigs.utilitiesModule.Weld(a, massVariableArray.curModel:WaitForChild("Grip"))
		end
		if
			a and a.Name ~= "NoWeld" and
			(a:IsA("Model") or a:IsA("Folder"))
		then
			if a.Name ~= "Shield" then
				for _, _ in pairs(a:GetDescendants()) do
					if _ and _:IsA("BasePart") then
						carbonConfigs.utilitiesModule.Weld(_, massVariableArray.curModel:WaitForChild("Grip"))
					end
				end
			elseif a.Name == "Shield" then
				for _, _ in pairs(a:GetDescendants()) do
					if _ and _:IsA("BasePart") and _.Name ~= "Grip" then
						carbonConfigs.utilitiesModule.Weld(_, a:WaitForChild("Grip"))
					end
				end
			end
		end
	end
	for _, _ in pairs(massVariableArray.curModel:GetDescendants()) do
		if _:IsA("BasePart") and _.Name ~= "Grip" then
			_.Anchored = false
			_.CanCollide = false
		end
	end
	massVariableArray.NeckCW = Instance.new("Motor6D")
	massVariableArray.NeckCW.Name = "Clone"
	massVariableArray.NeckCW.Parent = playerArms.torso
	massVariableArray.NeckCW.Part0 = playerArms.rootPart
	massVariableArray.NeckCW.Part1 = playerArms.head
	massVariableArray.NeckCW.C0 = playerArms.neck.C0
	massVariableArray.NeckCW.C1 = playerArms.neck.C1
	massVariableArray.AimPart = massVariableArray.curModel:WaitForChild("AimPart")
	massVariableArray.AimPart2 = massVariableArray.curModel:FindFirstChild("AimPart2") or nil
	massVariableArray.CurAimPart = massVariableArray.AimPart
	massVariableArray.lastAimPart = massVariableArray.AimPart
	massVariableArray.FirePart = massVariableArray.curModel:WaitForChild("FirePart")
	massVariableArray.Bolt = massVariableArray.curModel:WaitForChild("Bolt")
	massVariableArray.BoltW = massVariableArray.Bolt:WaitForChild("Bolt")
	massVariableArray.Mag = massVariableArray.curModel:WaitForChild("Mag")
	massVariableArray.FirePart2 = massVariableArray.curModel:FindFirstChild("FirePart2") or nil
	local _ = carbonFx:WaitForChild("EquipSound"):clone()
	_.Parent = localPlayer.PlayerGui
	_:Play()
	game.Debris:AddItem(_, _.TimeLength)
	massVariableArray.aimSFX = localPlayer.PlayerGui:FindFirstChild("AimSFX") or Instance.new("Sound")
	massVariableArray.aimSFX.Name = "AimSFX"
	massVariableArray.aimSFX.Parent = localPlayer.PlayerGui
	massVariableArray.HopUp = massVariableArray.curConfig.BulletHopUpMult
	local n, e, f, d, b, _, _, c, a, l, _, g, m, h, i, k, j =
		carbonEvents.storeDataEvent:InvokeServer(
			"Retrieve",
			massVariableArray.tool.Name,
			massVariableArray.curConfig.Ammo,
			(massVariableArray.curConfig.StoredAmmo * massVariableArray.curConfig.MagCount),
			massVariableArray.curConfig.ExplosiveAmmo,
			massVariableArray.curConfig.FireMode,
			massVariableArray.curConfig.MouseSensitivity,
			1,
			nil,
			nil,
			"Auth"
		)
	if n then
		massVariableArray.Ammo = e
		massVariableArray.StoredAmmo = f
		massVariableArray.ExplosiveAmmo = d
		massVariableArray.FireMode = b
		massVariableArray.CanShoot = c
		G = l
		Q = _
		ia = g
		K = k
		P = m
		R = h
		F = j
		massVariableArray.oHopUp = i
		if Q then
			if not ia then
				massVariableArray.curZoom = massVariableArray.curConfig.AltAimZoom
			else
				massVariableArray.curZoom = R
			end
			massVariableArray.CurAimPart = massVariableArray.AimPart2
		else
			if not ia then
				massVariableArray.curZoom = massVariableArray.curConfig.AimZoom
			else
				massVariableArray.curZoom = P
			end
			massVariableArray.CurAimPart = massVariableArray.AimPart
		end
	else
		ia = g
		K = k
		P = m
		R = h
		F = j
		massVariableArray.oHopUp = i
		massVariableArray.Ammo = massVariableArray.curConfig.Ammo
		massVariableArray.StoredAmmo = massVariableArray.curConfig.StoredAmmo * massVariableArray.curConfig.MagCount
		massVariableArray.ExplosiveAmmo = massVariableArray.curConfig.ExplosiveAmmo
		massVariableArray.FireMode = massVariableArray.curConfig.FireMode
		massVariableArray.CanShoot = false
		l = false
		Q = false
		if not ia then
			massVariableArray.curZoom = massVariableArray.curConfig.AimZoom
		else
			massVariableArray.curZoom = P
		end
		massVariableArray.CurAimPart = massVariableArray.AimPart
	end
	massVariableArray.RAW, massVariableArray.LAW, massVariableArray.RA, massVariableArray.LA, massVariableArray.Grip, massVariableArray.GripW, massVariableArray.GripW2 =
		carbonConfigs.setupModule(massVariableArray.ArmModel, playerCharacter, massVariableArray.AnimBase, massVariableArray.curConfig, massVariableArray.curModel, K, F)
	local b = carbonClientResourceModels:WaitForChild(massVariableArray.curModel.Name):clone()
	b.Parent = massVariableArray.weapDisplay
	b.PrimaryPart = b:WaitForChild("Grip")
	for _, _ in pairs(b:GetDescendants()) do
		if _ and _:IsA("Texture") or _:IsA("Decal") then
			_:Destroy()
		elseif _ and _:IsA("UnionOperation") then
			_.UsePartColor = true
			_.Material = Enum.Material.SmoothPlastic
		elseif _ and _:IsA("MeshPart") then
			_.TextureID = ""
			_.Material = Enum.Material.SmoothPlastic
		end
	end
	for _, _ in pairs(b:GetDescendants()) do
		if _ and _:IsA("BasePart") then
			_.BrickColor =
				BrickColor.new("Institutional white")
			_.Material = Enum.Material.SmoothPlastic
			if _:IsA("UnionOperation") then
				_.UsePartColor = true
			end
		end
	end
	local _ = Instance.new("Camera")
	massVariableArray.weapDisplay.CurrentCamera = _
	_.Parent = massVariableArray.weapDisplay
	_.CFrame = CFrame.new(10, 10, 10) * CFrame.Angles(10, 10, 10)
	tweenService:Create(
		_,
		TweenInfo.new(0.5),
		{CFrame = b.PrimaryPart.CFrame * CFrame.new(-2, 0, -0.4) * CFrame.Angles(0, math.rad(-90), 0)}
	):Play()
	if q then
		q = false
		massVariableArray.Ammo = massVariableArray.curConfig.Ammo
		massVariableArray.StoredAmmo = massVariableArray.curConfig.StoredAmmo * massVariableArray.curConfig.MagCount
	end
	if massVariableArray.FireMode == 6 and massVariableArray.Ammo > 0 then
		massVariableArray.CanShoot = true
	end
	UpdateAmmo()
	if
		localPlayer and localPlayer:FindFirstChild("PlayerGui") and
		localPlayer.PlayerGui:FindFirstChild("TouchGui")
	then
		massVariableArray.mainFrame.Visible = false
		massVariableArray.mainFrame2.Visible = true
		localPlayer.PlayerGui:FindFirstChild("TouchGui"):WaitForChild(
		"TouchControlFrame"
		):WaitForChild("JumpButton").Visible = false
	end
	local _ =
		require(
			massVariableArray.tool:WaitForChild("ConfigMods"):WaitForChild("SConfig")
		)
	carbonEvents.equipEvent:FireServer(
		true,
		"Auth",
		massVariableArray.tool.Name,
		_.RightArmPos,
		_.LeftArmPos,
		_.GunPos,
		_.ShieldPos,
		_.HolsteringEnabled,
		_.HolsterClient,
		_.HolsterTo,
		_.HolsterPos
	)
	va = false
	Ca = true
	if not n and carbonConfigs.globalConfig.StartUpBolt then
		ea = true
		massVariableArray.CanShoot, Aa, massVariableArray.Ammo, a, ea =
			carbonConfigs.codeArchive.StartUpBolt(massVariableArray.Ammo, BoltBackAnim, BoltForwardAnim, IdleAnim, UpdateAmmo)
	end
end
function SpawnIso(a, b, _, _)
	local c = b:FindFirstChild("IsoSound") or Instance.new("Sound")
	c.Volume = 1
	c.Name = "IsoSound"
	c.Parent = b
	c.SoundId = a
	c.PlaybackSpeed = _
	local a
	local _ =
		(b.Position - playerCharacter:WaitForChild("HumanoidRootPart").Position).magnitude
	if _ > 10 then
		a =
			c:FindFirstChild("Isolation") or
			Instance.new("EqualizerSoundEffect")
		a.Enabled = true
		a.Name = "Isolation"
		a.Parent = c
		a.HighGain = (-0.03 * _)
		a.MidGain = (-0.03 * _)
		a.LowGain = (_ / 100)
	else
		if c:FindFirstChild("Isolation") then
			c.Isolation.Enabled = false
		end
	end
	c:Play()
	c.Ended:connect(
		function()
			if a then
				a:Destroy()
			end
		end
	)
end
function UnequipModel()
	if massVariableArray.ArmModel and massVariableArray.curConfig then
		va = true
		recoilData.dirPeek = 0
		Lean()
		massVariableArray.mainFrame.Visible = false
		massVariableArray.mainFrame2.Visible = false
		massVariableArray.weapDisplay:ClearAllChildren()
		local _ = carbonFx:WaitForChild("UnequipSound"):clone()
		_.Parent = localPlayer.PlayerGui
		_:Play()
		game.Debris:AddItem(_, _.TimeLength)
		massVariableArray.ArmModel:Destroy()
		massVariableArray.curModel = nil
		massVariableArray.curConfig = nil
		massVariableArray.RA:Destroy()
		massVariableArray.RAW:Destroy()
		massVariableArray.LA:Destroy()
		massVariableArray.LAW:Destroy()
		massVariableArray.NeckCW:Destroy()
		massVariableArray.AnimBase = nil
		massVariableArray.AnimBaseW = nil
		massVariableArray.BasePart:Destroy()
		massVariableArray.Grip = nil
		massVariableArray.GripW:Destroy()
		massVariableArray.aimSFX:Destroy()
		contextActionService:UnbindAction("Shoot")
		contextActionService:UnbindAction("SelectFire")
		contextActionService:UnbindAction("Bolt")
		contextActionService:UnbindAction("Reload")
		contextActionService:UnbindAction("Jump")
		contextActionService:UnbindAction("Prone")
		contextActionService:UnbindAction("NewCrouch")
		za = false
		ya = false
		ea = false
		la = false
		O = false
		ja = false
		na = false
		ma = false
		da = false
		wa = false
		massVariableArray.CanShoot = Aa
		userInputService.MouseBehavior = Enum.MouseBehavior.Default
		userInputService.MouseIconEnabled = true
		currentCamera.CameraType = Enum.CameraType.Custom
		localPlayer.CameraMaxZoomDistance = game.StarterPlayer.CameraMaxZoomDistance
		if qa and not carbonConfigs.globalConfig.UniversalStances then
			playerArms.humanoid.WalkSpeed = 16
			massVariableArray.StanceIndex = 0
			changeStance()
		end
		tweenService:Create(currentCamera, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {FieldOfView = 70}):Play()
		carbonEvents.storeDataEvent:InvokeServer(
			"Store",
			massVariableArray.tool.Name,
			massVariableArray.Ammo,
			massVariableArray.StoredAmmo,
			massVariableArray.ExplosiveAmmo,
			massVariableArray.FireMode,
			0,
			0,
			massVariableArray.CanShoot,
			ta,
			"Auth",
			G,
			Q,
			ia,
			P,
			R,
			massVariableArray.HopUp,
			K,
			F
		)
		local _ =
			require(
				massVariableArray.tool:WaitForChild("ConfigMods"):WaitForChild(
				"SConfig"
				)
			)
		carbonEvents.equipEvent:FireServer(
			false,
			"Auth",
			massVariableArray.tool.Name,
			_.RightArmPos,
			_.LeftArmPos,
			_.GunPos,
			_.ShieldPos,
			_.HolsteringEnabled,
			_.HolsterClient,
			_.HolsterTo,
			_.HolsterPos
		)
		va = false
		Ca = false
		ta = false
		userInputService.MouseDeltaSensitivity = massVariableArray.origSens
		playerArms.humanoid.WalkSpeed = 16
		if E then
			E:Destroy()
		end
		if M then
			M:Destroy()
		end
		if aa then
			aa:Destroy()
		end
		if Y then
			Y:Destroy()
		end
		wa = false
		na = false
		for _, _ in pairs(massVariableArray.hud:WaitForChild("RangeFrame"):GetChildren()) do
			if _ then
				_.Visible = false
			end
		end
		if
			localPlayer and localPlayer:FindFirstChild("PlayerGui") and
			localPlayer.PlayerGui:FindFirstChild("TouchGui")
		then
			localPlayer.PlayerGui:FindFirstChild("TouchGui"):WaitForChild(
			"TouchControlFrame"
			):WaitForChild("JumpButton").Visible = true
		end
		ia = false
		K = false
	end
end
function ChangeReady()
	if massVariableArray.curConfig then
		if za then
			Aim(false, true)
		end
		if ya then
			Sprint(false)
		end
		if massVariableArray.readyMode == 0 then
			da = false
			carbonEvents.updateCharEvent:FireServer("Idle", true, "Auth")
			massVariableArray.CanShoot = true
			W = false
		elseif massVariableArray.readyMode == 1 then
			da = true
			tweenService:Create(massVariableArray.AnimBaseW, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {C1 = massVariableArray.curConfig.ReadyHighPos}):Play()
			carbonEvents.updateCharEvent:FireServer("ReadyHigh", true, "Auth")
			if oa then
				oa = false
			end
			W = true
		elseif massVariableArray.readyMode == -1 then
			da = true
			tweenService:Create(massVariableArray.AnimBaseW, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {C1 = massVariableArray.curConfig.ReadyLowPos}):Play()
			carbonEvents.updateCharEvent:FireServer("ReadyLow", true, "Auth")
			if oa then
				oa = false
			end
			W = true
		end
	end
end
function Aim(_, a)
	if massVariableArray.curConfig and not ka and not wa and not na then
		if _ then
			if m then
				if ya then
					Sprint(false)
				end
				if da then
					massVariableArray.readyMode = 0
					ChangeReady()
				end
				if oa then
					oa = false
				end
				if a then
					carbonEvents.updateCharEvent:FireServer("Aim", true, "Auth")
				end
				if
					playerCharacter:WaitForChild("CarbonValues"):WaitForChild(
					"NVGActive"
					).Value == true and
						massVariableArray.curModel:FindFirstChild("AimPart3") and
						O and
						massVariableArray.CurAimPart ~= massVariableArray.curModel.AimPart3
				then
					massVariableArray.lastAimPart = massVariableArray.CurAimPart
					massVariableArray.CurAimPart = massVariableArray.curModel.AimPart3
				end
				massVariableArray.aimSFX.SoundId = "rbxassetid://" .. aimInSounds[math.random(1, #aimInSounds)]
				massVariableArray.aimSFX:Play()
				tweenService:Create(
					currentCamera,
					TweenInfo.new(massVariableArray.curConfig.AimZoomSpeed, Enum.EasingStyle.Quad),
					{FieldOfView = massVariableArray.curZoom}
				):Play()
				if massVariableArray.curConfig.aimAnim then
					aimAnim()
				end
				za = true
			end
		else
			massVariableArray.aimWalkSpeed = 9
			massVariableArray.CurAimPart = massVariableArray.lastAimPart
			carbonEvents.updateCharEvent:FireServer("Aim", false, "Auth")
			massVariableArray.aimSFX.SoundId = "rbxassetid://" .. aimOutSounds[math.random(1, #aimOutSounds)]
			massVariableArray.aimSFX:Play()
			tweenService:Create(currentCamera, TweenInfo.new(massVariableArray.curConfig.AimZoomSpeed, Enum.EasingStyle.Quad), {FieldOfView = 70}):Play()
			za = false
			if massVariableArray.curConfig.unaimAnim then
				unaimAnim()
			end
			mathVariables.walkAnimIntensity = carbonConfigs.globalConfig.WalkIntensity
			mathVariables.walkAnimSpeed = carbonConfigs.globalConfig.WalkAnimSpeed
		end
	end
end
function Sprint(_)
	if massVariableArray.curConfig and not ka and not wa and not na then
		if _ and L then
			if za then
				Aim(false, true)
			end
			recoilData.dirPeek = 0
			Lean()
			tweenService:Create(currentCamera, TweenInfo.new(massVariableArray.curConfig.AimZoomSpeed, Enum.EasingStyle.Quad), {FieldOfView = 70}):Play()
			if da then
				massVariableArray.readyMode = 0
				ChangeReady()
			end
			if oa then
				oa = false
			end
			carbonEvents.updateCharEvent:FireServer("Sprint", true, "Auth")
			if massVariableArray.curConfig.sprintAnim then
				sprintAnim()
			end
			ya = true
			mathVariables.walkAnimIntensity = massVariableArray.curConfig.SprintWalkIntensity
			mathVariables.walkAnimSpeed = massVariableArray.curConfig.SprintWalkAnimSpeed
		else
			carbonEvents.updateCharEvent:FireServer("Sprint", false, "Auth")
			ya = false
			if massVariableArray.curConfig.unsprintAnim then
				unsprintAnim()
			end
			mathVariables.walkAnimIntensity = carbonConfigs.globalConfig.WalkIntensity
			mathVariables.walkAnimSpeed = carbonConfigs.globalConfig.WalkAnimSpeed
			mathVariables.idleSpeed = 2
		end
	end
end
function CalculateRecoil()
	if massVariableArray.curConfig then
		local a
		local _
		local b
		if not za then
			if not qa then
				a = math.rad(math.random(massVariableArray.curConfig.SideKickMin, massVariableArray.curConfig.SideKickMax))
				_ = math.random(massVariableArray.curConfig.gunRecoilMin, massVariableArray.curConfig.gunRecoilMax)
				b = math.rad(math.random(massVariableArray.curConfig.KickbackMin, massVariableArray.curConfig.KickbackMax))
			elseif qa then
				if massVariableArray.StanceIndex == 1 then
					a = math.rad(math.random(massVariableArray.curConfig.SideKickMin / 1.5, massVariableArray.curConfig.SideKickMax / 1.5))
					_ = math.random(massVariableArray.curConfig.gunRecoilMin / 1.5, massVariableArray.curConfig.gunRecoilMax / 1.5)
					b = math.rad(math.random(massVariableArray.curConfig.KickbackMin / 1.5, massVariableArray.curConfig.KickbackMax / 1.5))
				end
				if massVariableArray.StanceIndex == 2 then
					a = math.rad(math.random(massVariableArray.curConfig.SideKickMin / 2, massVariableArray.curConfig.SideKickMax / 2))
					_ = math.random(massVariableArray.curConfig.gunRecoilMin / 2, massVariableArray.curConfig.gunRecoilMax / 2)
					b = math.rad(math.random(massVariableArray.curConfig.KickbackMin / 2, massVariableArray.curConfig.KickbackMax / 2))
				end
			end
			a = math.rad(math.random(massVariableArray.curConfig.SideKickMin, massVariableArray.curConfig.SideKickMax))
			_ = math.random(massVariableArray.curConfig.gunRecoilMin, massVariableArray.curConfig.gunRecoilMax)
			b = math.rad(math.random(massVariableArray.curConfig.KickbackMin, massVariableArray.curConfig.KickbackMax))
		else
			if not qa then
				a = math.rad(math.random(massVariableArray.curConfig.AimSideKickMin, massVariableArray.curConfig.AimSideKickMax))
				_ = math.random(massVariableArray.curConfig.AimGunRecoilMin, massVariableArray.curConfig.AimGunRecoilMax)
				b = math.rad(math.random(massVariableArray.curConfig.AimKickbackMin, massVariableArray.curConfig.AimKickbackMax))
			elseif qa then
				if massVariableArray.StanceIndex == 1 then
					a = math.rad(math.random(massVariableArray.curConfig.AimSideKickMin / 1.5, massVariableArray.curConfig.AimSideKickMax / 1.5))
					_ = math.random(massVariableArray.curConfig.AimGunRecoilMin / 1.5, massVariableArray.curConfig.AimGunRecoilMax / 1.5)
					b = math.rad(math.random(massVariableArray.curConfig.AimKickbackMin / 1.5, massVariableArray.curConfig.AimKickbackMax / 1.5))
				end
				if massVariableArray.StanceIndex == 2 then
					a = math.rad(math.random(massVariableArray.curConfig.AimSideKickMin / 2, massVariableArray.curConfig.AimSideKickMax / 2))
					_ = math.random(massVariableArray.curConfig.AimGunRecoilMin / 2, massVariableArray.curConfig.AimGunRecoilMax / 2)
					b = math.rad(math.random(massVariableArray.curConfig.AimKickbackMin / 2, massVariableArray.curConfig.AimKickbackMax / 2))
				end
			end
		end
		local _ = Vector3.new(b, a, _ / 70)
		return _
	end
end
function CalculateCamRecoil()
	if massVariableArray.curConfig then
		local b
		local _
		local a
		if not za then
			if not qa then
				b = math.rad(math.random(massVariableArray.curConfig.SideKickMin, massVariableArray.curConfig.SideKickMax))
				_ = massVariableArray.curConfig.CamShakeMin or massVariableArray.curConfig.CamShakeMax
				a = math.rad(math.random(massVariableArray.curConfig.KickbackMin, massVariableArray.curConfig.KickbackMax))
			elseif qa then
				if massVariableArray.StanceIndex == 1 then
					b = math.rad(math.random(massVariableArray.curConfig.SideKickMin / 1.5, massVariableArray.curConfig.SideKickMax / 1.5))
					_ = massVariableArray.curConfig.CamShakeMin / 1.5 or massVariableArray.curConfig.CamShakeMax / 1.5
					a = math.rad(math.random(massVariableArray.curConfig.KickbackMin / 1.5, massVariableArray.curConfig.KickbackMax / 1.5))
				end
				if massVariableArray.StanceIndex == 2 then
					b = math.rad(math.random(massVariableArray.curConfig.SideKickMin / 2, massVariableArray.curConfig.SideKickMax / 2))
					_ = massVariableArray.curConfig.CamShakeMin / 2 or massVariableArray.curConfig.CamShakeMax / 2
					a = math.rad(math.random(massVariableArray.curConfig.KickbackMin / 2, massVariableArray.curConfig.KickbackMax / 2))
				end
			end
			b = math.rad(math.random(massVariableArray.curConfig.SideKickMin, massVariableArray.curConfig.SideKickMax))
			_ = massVariableArray.curConfig.CamShakeMin or massVariableArray.curConfig.CamShakeMax
			a = math.rad(math.random(massVariableArray.curConfig.KickbackMin, massVariableArray.curConfig.KickbackMax))
		else
			if not qa then
				b = math.rad(math.random(massVariableArray.curConfig.AimSideKickMin, massVariableArray.curConfig.AimSideKickMax))
				_ = massVariableArray.curConfig.AimCanShakeMin or massVariableArray.curConfig.AimCamShakeMax
				a = math.rad(math.random(massVariableArray.curConfig.AimKickbackMin, massVariableArray.curConfig.AimKickbackMax))
			elseif qa then
				if massVariableArray.StanceIndex == 1 then
					b = math.rad(math.random(massVariableArray.curConfig.AimSideKickMin / 1.5, massVariableArray.curConfig.AimSideKickMax / 1.5))
					_ = massVariableArray.curConfig.AimCanShakeMin / 1.5 or massVariableArray.curConfig.AimCamShakeMax / 1.5
					a = math.rad(math.random(massVariableArray.curConfig.AimKickbackMin / 1.5, massVariableArray.curConfig.AimKickbackMax / 1.5))
				end
				if massVariableArray.StanceIndex == 2 then
					b = math.rad(math.random(massVariableArray.curConfig.AimSideKickMin / 2, massVariableArray.curConfig.AimSideKickMax / 2))
					_ = massVariableArray.curConfig.AimCanShakeMin / 2 or massVariableArray.curConfig.AimCamShakeMax / 2
					a = math.rad(math.random(massVariableArray.curConfig.AimKickbackMin / 2, massVariableArray.curConfig.AimKickbackMax / 2))
				end
			end
		end
		local _ = Vector3.new(a, b, _ / 70)
		return _
	end
end
function CalculateCamShake()
	if carbonConfigs.globalConfig.CanDamageShake then
		local b
		local a
		local _
		if not za then
			if not qa then
				b = math.rad(math.random(carbonConfigs.globalConfig.SideKickMin, carbonConfigs.globalConfig.SideKickMax))
				a = carbonConfigs.globalConfig.CamShakeMin or carbonConfigs.globalConfig.CamShakeMax
				_ = math.rad(math.random(carbonConfigs.globalConfig.KickbackMin, carbonConfigs.globalConfig.KickbackMax))
			elseif qa then
				if massVariableArray.StanceIndex == 1 then
					b = math.rad(math.random(carbonConfigs.globalConfig.SideKickMin / 1.5, carbonConfigs.globalConfig.SideKickMax / 1.5))
					a = carbonConfigs.globalConfig.CamShakeMin / 1.5 or carbonConfigs.globalConfig.CamShakeMax / 1.5
					_ = math.rad(math.random(carbonConfigs.globalConfig.KickbackMin / 1.5, carbonConfigs.globalConfig.KickbackMax / 1.5))
				end
				if massVariableArray.StanceIndex == 2 then
					b = math.rad(math.random(carbonConfigs.globalConfig.SideKickMin / 2, carbonConfigs.globalConfig.SideKickMax / 2))
					a = carbonConfigs.globalConfig.CamShakeMin / 2 or carbonConfigs.globalConfig.CamShakeMax / 2
					_ = math.rad(math.random(carbonConfigs.globalConfig.KickbackMin / 2, carbonConfigs.globalConfig.KickbackMax / 2))
				end
			end
			b = math.rad(math.random(carbonConfigs.globalConfig.SideKickMin, carbonConfigs.globalConfig.SideKickMax))
			a = carbonConfigs.globalConfig.CamShakeMin or carbonConfigs.globalConfig.CamShakeMax
			_ = math.rad(math.random(carbonConfigs.globalConfig.KickbackMin, carbonConfigs.globalConfig.KickbackMax))
		else
			if not qa then
				b = math.rad(math.random(carbonConfigs.globalConfig.AimSideKickMin, carbonConfigs.globalConfig.AimSideKickMax))
				a = carbonConfigs.globalConfig.AimCanShakeMin or carbonConfigs.globalConfig.AimCamShakeMax
				_ = math.rad(math.random(carbonConfigs.globalConfig.AimKickbackMin, carbonConfigs.globalConfig.AimKickbackMax))
			elseif qa then
				if massVariableArray.StanceIndex == 1 then
					b =
						math.rad(
							math.random(carbonConfigs.globalConfig.AimSideKickMin / 1.5, carbonConfigs.globalConfig.AimSideKickMax / 1.5)
						)
					a = carbonConfigs.globalConfig.AimCanShakeMin / 1.5 or carbonConfigs.globalConfig.AimCamShakeMax / 1.5
					_ =
						math.rad(
							math.random(carbonConfigs.globalConfig.AimKickbackMin / 1.5, carbonConfigs.globalConfig.AimKickbackMax / 1.5)
						)
				end
				if massVariableArray.StanceIndex == 2 then
					b = math.rad(math.random(carbonConfigs.globalConfig.AimSideKickMin / 2, carbonConfigs.globalConfig.AimSideKickMax / 2))
					a = carbonConfigs.globalConfig.AimCanShakeMin / 2 or carbonConfigs.globalConfig.AimCamShakeMax / 2
					_ = math.rad(math.random(carbonConfigs.globalConfig.AimKickbackMin / 2, carbonConfigs.globalConfig.AimKickbackMax / 2))
				end
			end
		end
		local _ = Vector3.new(_, b, a / 70)
		return _
	end
end
function Shoot() -- why broccoli bob is getting canceled for eating mac and cheese (EMOTIONAL) (EXPOSED) (COPS CALLED) (DELETED VIDEO) NOT CLICKBAIT, 1440p copyright dintisepic 2027
	prnt("Shoot")
	if Ca and massVariableArray.CanShoot and not ya and not ma and not da and not oa and not ea and not la then
		if (currentCamera.CFrame.Position - playerCharacter:WaitForChild("Head").Position).magnitude > 10 then
			localPlayer:Kick(
				"Exploiting is a bannable offense. This action log has been submitted to ROBLOX."
			)
		end
		if not ja then
			if massVariableArray.FireMode == 1 then
				fireSemi()
				if massVariableArray.Ammo > 0 then
					ta = true
				elseif massVariableArray.Ammo <= 0 then
					ta = false
				end
			elseif massVariableArray.FireMode == 2 then
				fireAuto()
				if massVariableArray.Ammo > 0 then
					ta = true
				elseif massVariableArray.Ammo <= 0 then
					ta = false
				end
			elseif massVariableArray.FireMode == 3 then
				fireBurst()
				if massVariableArray.Ammo > 0 then
					ta = true
				elseif massVariableArray.Ammo <= 0 then
					ta = false
				end
			elseif massVariableArray.FireMode == 4 then
				fireBoltAction()
			elseif massVariableArray.FireMode == 5 then
				fireShot()
			elseif massVariableArray.FireMode == 6 then
				fireRPG()
			end
		else
			if massVariableArray.ExplosiveAmmo > 0 then
				fireExplosive()
			end
		end
		UpdateAmmo()
	end
end
function Update()
	if playerCharacter:WaitForChild("Humanoid").Health > 0 and Ca then
		local d = recoilData.recoilSpring2.p
		local _ = CFrame.new(0, 0, d.z / 5)
		local a = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), d.x / 10)
		local b = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), d.y / 10)
		local c = CFrame.fromAxisAngle(Vector3.new(0, 0, 1), d.z)
		d = _ * a * b * c
		recoilData.cornerPeek.t = recoilData.peekFactor * recoilData.dirPeek
		local _ = CFrame.fromAxisAngle(Vector3.new(0, 0, 1), recoilData.cornerPeek.p)
		currentCamera.CFrame = currentCamera.CFrame * _ * massVariableArray.newCamOffset * d
	end
end
function changeStance()
	if not f and not massVariableArray.Seated then
		if massVariableArray.StanceIndex == 0 then
			qa = false
			tweenService:Create(playerArms.rootJoint, TweenInfo.new(0.6), {C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)}):Play()
			tweenService:Create(playerArms.rightHip, TweenInfo.new(0.6), {C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)}):Play()
			tweenService:Create(playerArms.leftHip, TweenInfo.new(0.6), {C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)}):Play()
			tweenService:Create(playerArms.neck, TweenInfo.new(0.6), {C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)}):Play()
			massVariableArray.camC0 = Vector3.new()
			tweenService:Create(playerArms.humanoid, TweenInfo.new(0.5), {CameraOffset = Vector3.new(0, 0, 0)}):Play()
			if Ca then
				UpdateAmmo()
			else
				playerArms.humanoid.WalkSpeed = 16
			end
			Lean()
			carbonEvents.updateCharEvent:FireServer("Stance", true, "Auth", massVariableArray.StanceIndex)
		elseif massVariableArray.StanceIndex == 1 and not playerArms.humanoid.Sit then
			qa = true
			tweenService:Create(
				playerArms.rootJoint,
				TweenInfo.new(0.6),
				{C0 = CFrame.new(0, -1.20000005, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)}
			):Play()
			tweenService:Create(
				playerArms.rightHip,
				TweenInfo.new(0.6),
				{
					C0 = CFrame.new(
						1.00000191,
						-0.93054074,
						-0.393920898,
						0,
						0,
						1,
						-0.98480773,
						0.173648179,
						0,
						-0.173648179,
						-0.98480773,
						0
					)
				}
			):Play()
			tweenService:Create(
				playerArms.leftHip,
				TweenInfo.new(0.6),
				{
					C0 = CFrame.new(
						-1,
						0.165270448,
						-0.603042603,
						0,
						0,
						-1,
						-0.173648179,
						0.98480773,
						0,
						0.98480773,
						0.173648179,
						0
					)
				}
			):Play()
			tweenService:Create(playerArms.neck, TweenInfo.new(0.6), {C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)}):Play()
			massVariableArray.camC0 = Vector3.new(0, -1, 0)
			tweenService:Create(playerArms.humanoid, TweenInfo.new(0.5), {CameraOffset = Vector3.new(0, -1.2, 0)}):Play()
			if Ca then
				UpdateAmmo()
			end
			Lean()
			carbonEvents.updateCharEvent:FireServer("Stance", true, "Auth", massVariableArray.StanceIndex)
		elseif massVariableArray.StanceIndex == 2 and not playerArms.humanoid.Sit then
			if Ca and massVariableArray.curConfig then
				recoilData.dirPeek = 0
				Lean()
			end
			qa = true
			tweenService:Create(
				playerArms.rootJoint,
				TweenInfo.new(0.6),
				{C0 = CFrame.new(0, -2.5999999, 0, -1, 0, 0, 0, 1, 1.19248806e-08, 0, 1.19248806e-08, -1)}
			):Play()
			tweenService:Create(
				playerArms.rightHip,
				TweenInfo.new(0.6),
				{
					C0 = CFrame.new(
						1,
						-1,
						2.98023224e-08,
						0.163175702,
						-0.342020363,
						0.925416529,
						0.0593911409,
						0.939692557,
						0.336824328,
						-0.984807789,
						0,
						0.17364797
					)
				}
			):Play()
			tweenService:Create(
				playerArms.leftHip,
				TweenInfo.new(0.6),
				{
					C0 = CFrame.new(
						-1,
						-1,
						2.98023224e-08,
						0.163175896,
						0.342020363,
						-0.92541647,
						-0.0593912117,
						0.939692557,
						0.336824298,
						0.98480773,
						0,
						0.173648179
					)
				}
			):Play()
			tweenService:Create(
				playerArms.neck,
				TweenInfo.new(0.6),
				{
					C1 = CFrame.new(
						0,
						-0.785033405,
						-0.109157309,
						-0.99999994,
						0,
						0,
						0,
						1,
						-4.37113883e-08,
						0,
						-4.37113883e-08,
						-1
					)
				}
			):Play()
			massVariableArray.camC0 = Vector3.new(0, -2.5, 0)
			tweenService:Create(
				playerCharacter:WaitForChild("Humanoid"),
				TweenInfo.new(0.5),
				{CameraOffset = Vector3.new(0, -3, 0)}
			):Play()
			if Ca then
				UpdateAmmo()
			end
			carbonEvents.updateCharEvent:FireServer("Stance", true, "Auth", massVariableArray.StanceIndex)
		end
	end
end
function Lean()
	if not massVariableArray.Seated then
		if massVariableArray.StanceIndex ~= 2 and not ya then
			if recoilData.dirPeek == 1 then
				if massVariableArray.StanceIndex == 0 then
					tweenService:Create(playerArms.humanoid, TweenInfo.new(0.5), {CameraOffset = Vector3.new(-1.5, 0, 0)}):Play()
				elseif massVariableArray.StanceIndex == 1 then
					tweenService:Create(playerArms.humanoid, TweenInfo.new(0.5), {CameraOffset = Vector3.new(-1.5, -1.2, 0)}):Play()
				end
				tweenService:Create(
					playerArms.rootJoint,
					TweenInfo.new(0.6),
					{
						C1 = CFrame.new(
							0.600000024,
							0,
							0,
							-0.939692616,
							0,
							0.342020124,
							0.342020124,
							0,
							0.939692616,
							0,
							1,
							0
						)
					}
				):Play()
				tweenService:Create(
					playerArms.rightHip,
					TweenInfo.new(0.6),
					{C1 = CFrame.new(0.5, 1, 0, 0, 0.087155737, 0.99619472, 0, 0.99619472, -0.087155737, -1, 0, 0)}
				):Play()
				tweenService:Create(
					playerArms.leftHip,
					TweenInfo.new(0.6),
					{
						C1 = CFrame.new(
							-0.5,
							0.600000024,
							0,
							0,
							-0.342020124,
							-0.939692557,
							0,
							0.939692557,
							-0.342020124,
							1,
							0,
							0
						)
					}
				):Play()
			elseif recoilData.dirPeek == -1 then
				if massVariableArray.StanceIndex == 0 then
					tweenService:Create(playerArms.humanoid, TweenInfo.new(0.5), {CameraOffset = Vector3.new(1.5, 0, 0)}):Play()
				elseif massVariableArray.StanceIndex == 1 then
					tweenService:Create(playerArms.humanoid, TweenInfo.new(0.5), {CameraOffset = Vector3.new(1.5, -1.2, 0)}):Play()
				end
				tweenService:Create(
					playerArms.rootJoint,
					TweenInfo.new(0.6),
					{
						C1 = CFrame.new(
							-0.600000024,
							0,
							0,
							-0.939692557,
							0,
							-0.342020154,
							-0.342020154,
							0,
							0.939692557,
							0,
							1,
							0
						)
					}
				):Play()
				tweenService:Create(
					playerArms.rightHip,
					TweenInfo.new(0.6),
					{
						C1 = CFrame.new(
							0.5,
							0.600000024,
							0,
							0,
							0.342020124,
							0.939692557,
							0,
							0.939692557,
							-0.342020124,
							-1,
							0,
							0
						)
					}
				):Play()
				tweenService:Create(
					playerArms.leftHip,
					TweenInfo.new(0.6),
					{C1 = CFrame.new(-0.5, 1, 0, 0, 0, -0.99999994, 0, 0.99999994, 0, 1, 0, 0)}
				):Play()
			elseif recoilData.dirPeek == 0 then
				if massVariableArray.StanceIndex == 0 then
					tweenService:Create(playerArms.humanoid, TweenInfo.new(0.5), {CameraOffset = Vector3.new(0, 0, 0)}):Play()
				elseif massVariableArray.StanceIndex == 1 then
					tweenService:Create(playerArms.humanoid, TweenInfo.new(0.5), {CameraOffset = Vector3.new(0, -1.2, 0)}):Play()
				end
				tweenService:Create(playerArms.rootJoint, TweenInfo.new(0.6), {C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)}):Play(

				)
				tweenService:Create(playerArms.rightHip, TweenInfo.new(0.6), {C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)}):Play(

				)
				tweenService:Create(playerArms.leftHip, TweenInfo.new(0.6), {C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)}):Play(

				)
			end
		elseif massVariableArray.StanceIndex == 2 then
			recoilData.dirPeek = 0
			tweenService:Create(
				playerCharacter:WaitForChild("Humanoid"),
				TweenInfo.new(0.5),
				{CameraOffset = Vector3.new(0, -3, 0)}
			):Play()
			tweenService:Create(playerArms.rootJoint, TweenInfo.new(0.6), {C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)}):Play()
			tweenService:Create(playerArms.rightHip, TweenInfo.new(0.6), {C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)}):Play()
			tweenService:Create(playerArms.leftHip, TweenInfo.new(0.6), {C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)}):Play()
		end
		carbonEvents.updateCharEvent:FireServer("Lean", true, "Auth", massVariableArray.StanceIndex, recoilData.dirPeek)
	end
end
function HalfStepFunc(_)
	if massVariableArray.HalfStep then
		carbonEvents.halfStepEvent:FireServer("Auth", _, Ca)
	end
	massVariableArray.HalfStep = not massVariableArray.HalfStep
end
function SpawnTracer(c, b, _, a)
	local a = Instance.new("Trail", a)
	a.Attachment0 = b
	a.Attachment1 = _
	a.Transparency = NumberSequence.new(c.TracerTransparency)
	a.LightEmission = c.TracerLightEmission
	a.TextureLength = c.TracerTextureLength
	a.LightInfluence = 0
	a.Texture =
		"http://www.roblox.com/asset/?id=4528011555"
	a.Lifetime = c.TracerLifetime
	a.FaceCamera = c.TracerFaceCamera
	a.Color = ColorSequence.new(c.TracerColor.Color)
end
function reCast(_, a)
	if massVariableArray.curConfig then
		local _ = _
		local a = a
		local _ = CFrame.new(_, _ + a)
		local c = Instance.new("Part")
		c.Parent = carbonAudio
		c.Name = "Bullet"
		game.Debris:AddItem(c, 10)
		c.Shape = Enum.PartType.Ball
		c.Size = Vector3.new(1, 1, 12)
		c.Name = "Bullet"
		c.TopSurface = "Smooth"
		c.BottomSurface = "Smooth"
		c.BrickColor = BrickColor.new("Bright green")
		c.Material = "Neon"
		c.CanCollide = false
		c.CFrame = _
		c.Transparency = 1
		local _ = c:GetMass()
		local _ = Instance.new("BodyForce", c)
		_.Force = carbonConfigs.globalConfig.BulletPhysics
		c.Velocity = a * carbonConfigs.globalConfig.BulletSpeed
		local b = Instance.new("Attachment", c)
		b.Position = Vector3.new(0.1, 0, 0)
		local a = Instance.new("Attachment", c)
		a.Position = Vector3.new(-0.1, 0, 0)
		local _ = carbonConfigs.codeArchive.TracerCalculation(massVariableArray.curConfig.TracerChance)
		if massVariableArray.curConfig.TracerEnabled == true and _ then
			if carbonConfigs.globalConfig.NightTimeTracers then
				if
					game.Lighting.ClockTime > carbonConfigs.globalConfig.MinTime or
					game.Lighting.ClockTime < carbonConfigs.globalConfig.MaxTime
				then
					SpawnTracer(massVariableArray.curConfig, b, a, c)
				end
			else
				SpawnTracer(massVariableArray.curConfig, b, a, c)
			end
		end
		return c
	end
end
function CreateBullet(c, _, a)
	if massVariableArray.curConfig then
		local b
		if not _ then
			b = massVariableArray.FirePart.Position
		else
			b = _
		end
		local d
		if not a then
			if not ia then
				d = massVariableArray.FirePart.CFrame.lookVector + (massVariableArray.FirePart.CFrame.upVector * massVariableArray.HopUp)
			else
				d = massVariableArray.FirePart.CFrame.lookVector + (massVariableArray.FirePart.CFrame.upVector * massVariableArray.oHopUp)
			end
		else
			d = a
		end
		local _ =
			CFrame.Angles(math.rad(math.random(-c, c)), math.rad(math.random(-c, c)), math.rad(math.random(-c, c)))
		d = _ * d
		local a = CFrame.new(b, b + d)
		local e = Instance.new("Part")
		e.Parent = carbonAudio
		table.insert(componentCollection, e)
		e.Name = "Bullet"
		game.Debris:AddItem(e, 10)
		e.Shape = Enum.PartType.Ball
		e.Size = Vector3.new(1, 1, 12)
		e.Name = "Bullet"
		e.TopSurface = "Smooth"
		e.BottomSurface = "Smooth"
		e.BrickColor = BrickColor.new("Bright green")
		e.Material = "Neon"
		e.CanCollide = false
		e.CFrame = a
		e.Transparency = 1
		local _ = e:GetMass()
		local _ = Instance.new("BodyForce", e)
		if not ja then
			_.Force = Vector3.new(0, carbonConfigs.globalConfig.BulletPhysics, 0)
			e.Velocity = d * carbonConfigs.globalConfig.BulletSpeed
		else
			_.Force = massVariableArray.curConfig.ExploPhysics
			e.Velocity = d * massVariableArray.curConfig.ExploSpeed
		end
		local b = Instance.new("Attachment", e)
		b.Position = Vector3.new(0.1, 0, 0)
		local c = Instance.new("Attachment", e)
		c.Position = Vector3.new(-0.1, 0, 0)
		local _ = carbonConfigs.codeArchive.TracerCalculation(massVariableArray.curConfig.TracerChance)
		if massVariableArray.FireMode == 6 then
			local _ = carbonFx:WaitForChild("RocketFire"):Clone()
			_.Parent = e
			_.Enabled = true
			local _ = carbonFx:WaitForChild("RocketLoop"):Clone()
			_.Parent = e
			_:Play()
		end
		if massVariableArray.curConfig.TracerEnabled == true and _ then
			if carbonConfigs.globalConfig.NightTimeTracers then
				if
					game.Lighting.ClockTime > carbonConfigs.globalConfig.MinTime or
					game.Lighting.ClockTime < carbonConfigs.globalConfig.MaxTime
				then
					SpawnTracer(massVariableArray.curConfig, b, c, e)
				end
			else
				SpawnTracer(massVariableArray.curConfig, b, c, e)
			end
		end
		CreateShell()
		if carbonConfigs.globalConfig.ReplicatedBullets then
			carbonEvents.whizEvent:FireServer(
				a,
				massVariableArray.curConfig.TracerEnabled,
				_,
				massVariableArray.curConfig.BulletPhysics,
				massVariableArray.curConfig.BulletSpeed,
				d,
				massVariableArray.curConfig.TracerColor,
				"Auth",
				massVariableArray.FireMode
			)
		end
		return e
	end
end
function CreateExternalBullet(f, g, b, d, e, a, _, c)
	local _ = f
	local f = Instance.new("Part")
	f.Parent = carbonAudio
	f.Name = "Bullet"
	game.Debris:AddItem(f, 10)
	f.Shape = Enum.PartType.Ball
	f.Size = Vector3.new(1, 1, 12)
	f.Name = "Bullet"
	f.TopSurface = "Smooth"
	f.BottomSurface = "Smooth"
	f.BrickColor = BrickColor.new("Bright green")
	f.Material = "Neon"
	f.CanCollide = false
	f.CFrame = _
	game.Debris:AddItem(f, 4)
	f.Transparency = 1
	local _ = f:GetMass()
	local _ = Instance.new("BodyForce", f)
	_.Force = d
	f.Velocity = a * e
	local a = Instance.new("Attachment", f)
	a.Position = Vector3.new(0.1, 0, 0)
	local _ = Instance.new("Attachment", f)
	_.Position = Vector3.new(-0.1, 0, 0)
	if g and b then
		local b = Instance.new("Trail", f)
		b.Attachment0 = a
		b.Attachment1 = _
		b.Transparency = NumberSequence.new(0.3)
		b.LightEmission = 1
		b.TextureLength = 1
		b.LightInfluence = 0
		b.Texture =
			"http://www.roblox.com/asset/?id=4528011555"
		b.Lifetime = 0.1
		b.FaceCamera = true
		b.Color = ColorSequence.new(BrickColor.new("Deep orange").Color)
	end
	if c == 6 then
		local _ = carbonFx:WaitForChild("RocketFire"):Clone()
		_.Parent = f
		_.Enabled = true
		local _ = carbonFx:WaitForChild("RocketLoop"):Clone()
		_.Parent = f
		_:Play()
	end
	return f
end
function HandleDamage(e, _, d, a, b, c)
	if massVariableArray.curConfig then
		carbonEvents.createOwnerEvent:FireServer(d, nil, nil, nil, nil, nil, nil, nil, "Auth")
		if (e.Name == "Head" or e:FindFirstAncestorWhichIsA("Accessory")) then
			if e.Name == "Head" then
				carbonEvents.damageEvent:FireServer(
					d,
					massVariableArray.curConfig.HeadDamage,
					e.Name,
					{"nil", "Auth", "nil", "nil"}
				)
			elseif e:FindFirstAncestorWhichIsA("Accessory") then
				local _ = e:FindFirstAncestorWhichIsA("Accessory")
				if
					_:WaitForChild("Handle"):WaitForChild(
					"AccessoryWeld"
					).Part1.Name == "Head"
				then
					carbonEvents.damageEvent:FireServer(
						d,
						massVariableArray.curConfig.HeadDamage,
						e.Name,
						{"nil", "Auth", "nil", "nil"}
					)
				elseif
					_:WaitForChild("Handle"):WaitForChild(
					"AccessoryWeld"
					).Part1.Name == "Torso"
				then
					carbonEvents.damageEvent:FireServer(
						d,
						massVariableArray.curConfig.BaseDamage,
						e.Name,
						{"nil", "Auth", "nil", "nil"}
					)
				end
			end
		elseif
			e.Name == "Torso" or
			e.Name == "HumanoidRootPart"
		then
			carbonEvents.damageEvent:FireServer(
				d,
				massVariableArray.curConfig.BaseDamage,
				e.Name,
				{"nil", "Auth", "nil", "nil"}
			)
		elseif
			(e.Name == "Right Arm" or e.Name == "Left Arm" or
				e.Name == "Left Leg" or
				e.Name == "Right Leg")
		then
			carbonEvents.damageEvent:FireServer(
				d,
				massVariableArray.curConfig.LimbDamage,
				e.Name,
				{"nil", "Auth", "nil", "nil"}
			)
		elseif e.Name == "Armor" then
			carbonEvents.damageEvent:FireServer(
				d,
				massVariableArray.curConfig.ArmorDamage,
				e.Name,
				{"nil", "Auth", "nil", "nil"}
			)
		elseif
			e.Parent:FindFirstChild("Middle") or
			e.Parent.Parent:FindFirstChild("Middle")
		then
			local _
			if e.Parent:FindFirstChild("Middle") then
				_ = e.Parent.Middle
			elseif e.Parent.Parent:FindFirstChild("Middle") then
				_ = e.Parent.Parent.Middle
			end
			if _ then
				if _.Parent.Name == "Chest" then
					carbonEvents.damageEvent:FireServer(
						d,
						massVariableArray.curConfig.BaseDamage - (massVariableArray.curConfig.BaseDamage * (carbonConfigs.globalConfig.ArmorBase / 100)),
						e.Name,
						{"nil", "Auth", "nil", "nil"}
					)
				elseif _.Parent.Name == "HeadWear" then
					carbonEvents.damageEvent:FireServer(
						d,
						massVariableArray.curConfig.BaseDamage - (massVariableArray.curConfig.HeadDamage * (carbonConfigs.globalConfig.ArmorHead / 100)),
						e.Name,
						{"nil", "Auth", "nil", "nil"}
					)
				else
					carbonEvents.damageEvent:FireServer(
						d,
						massVariableArray.curConfig.BaseDamage - (massVariableArray.curConfig.LimbDamage * (carbonConfigs.globalConfig.ArmorLimb / 100)),
						e.Name,
						{"nil", "Auth", "nil", "nil"}
					)
				end
			end
		else
			carbonEvents.damageEvent:FireServer(
				d,
				massVariableArray.curConfig.BaseDamage,
				e.Name,
				{"nil", "Auth", "nil", "nil"}
			)
		end
		local d = carbonFx:WaitForChild("BodyHit"):clone()
		d.Parent = localPlayer.PlayerGui
		d:Play()
		game:GetService("Debris"):addItem(d, d.TimeLength)
		carbonEvents.hitEvent:FireServer(_, a, b, c, "Auth", "Human", e)
	end
end
function CastRay(i, c, a, _)
	if massVariableArray.curConfig then
		local l, k, j
		local g
		if not c then
			g = massVariableArray.CurAimPart.Position
		else
			g = a
		end
		local e = i.Position
		local d = 0
		local b = false
		while true do
			renderLoop:Wait()
			e = i.Position
			d = d + (e - g).magnitude
			if _ then
				table.insert(componentCollection, 1, _)
			end
			l, k, j = workspace:FindPartOnRayWithIgnoreList(Ray.new(g, (e - g)), componentCollection)
			local h = Vector3.new(0, 1, 0):Cross(j)
			local f = math.asin(h.magnitude)
			if _ then
				table.remove(componentCollection, 1)
			end
			for _, _ in pairs(game.Players:GetChildren()) do
				if
					_:IsA("Player") and _ ~= localPlayer and _.Character and
					_.Character:FindFirstChild("Head") and
					(_.Character.Head.Position - k).magnitude <= 25 and
					not b
				then
					carbonEvents.flybyEvent:FireServer(_, nil, nil, nil, nil, "Auth")
					b = true
				end
			end
			for _, a in pairs(componentCollection) do
				if a and #componentCollection > 3 and a == c then
					table.remove(componentCollection, _)
				end
			end
			if d > 10000 then
				i:Destroy()
				break
			end
			if l then
				if
					(l.Transparency >= 1 or l.CanCollide == false) and l.Name ~= "Right Arm" and
					l.Name ~= "Left Arm" and
					l.Name ~= "Right Leg" and
					l.Name ~= "Left Leg" and
					l.Name ~= "Torso" and
					l.Name ~= "Armor" and
					not l.Parent:FindFirstChild("CEVARS") and
					not l.Parent:FindFirstChild("Middle") and
					not l.Parent.Parent:FindFirstChild("Middle") and
					l.Material ~= Enum.Material.Water
				then
					table.insert(componentCollection, l)
					local _, _ =
						spawn(
							function()
								CastRay(i, l, k)
							end
						)
					break
				elseif l.Name == "HumanoidRootPart" then
					table.insert(componentCollection, l)
					local _, _ =
						spawn(
							function()
								CastRay(i, l, k)
							end
						)
					break
				else
					if l then
						if carbonConfigs.globalConfig.RicochetEnabled then
							local a, _ = carbonConfigs.codeArchive.richoCalc(l)
							if a then
								local a = i.CFrame.LookVector
								i.Velocity = (a - (2 * a:Dot(j) * j)) * (massVariableArray.curConfig.BulletSpeed / 2)
								local _, _ =
									spawn(
										function()
											CastRay(i, l, k, _)
										end
									)
							end
						end
						carbonEvents.serverFXEvent:FireServer(k, nil, nil, nil, nil, nil, "Auth")
						if not ja then
							if massVariableArray.FireMode ~= 6 then
								local _, b = carbonConfigs.utilitiesModule.CheckForHumanoid(l)
								if _ then
									if massVariableArray.curConfig.AntiTK then
										if
											game.Players:GetPlayerFromCharacter(b.Parent) and
											game.Players:GetPlayerFromCharacter(b.Parent).Team ~= localPlayer.Team
										then
											HandleDamage(l, k, b, h, f, j)
										end
										if b.Name == "Target" then
											HandleDamage(l, k, b, h, f, j)
										end
										if not game.Players:FindFirstChild(b.Parent.Name) then
											if b.Parent:FindFirstChild("Vars") then
												if b.Parent.Vars:FindFirstChild("teamColor") then
													if b.Parent.Vars.teamColor.Value ~= localPlayer.TeamColor then
														HandleDamage(l, k, b, h, f, j)
													end
												end
											else
												HandleDamage(l, k, b, h, f, j)
											end
										end
									else
										HandleDamage(l, k, b, h, f, j)
									end
								else
									if
										l.Parent:FindFirstChild("CEVARS") and
										l.Parent.CEVARS:FindFirstChild(
											"IsExplosive"
										) and
											l.Parent.CEVARS.IsExplosive.Value == true
									then
										carbonEvents.explosiveEvent:FireServer(
											c,
											a,
											carbonConfigs.globalConfig.C4BlastPressue,
											carbonConfigs.globalConfig.C4BlastRadius,
											carbonConfigs.globalConfig.C4DestroyJointRadius,
											carbonConfigs.globalConfig.C4ExplosionType,
											carbonConfigs.globalConfig.C4DeletePart,
											l.Parent,
											nil,
											nil,
											nil,
											nil,
											"Auth",
											nil
										)
									end
									carbonEvents.createOwnerEvent:FireServer(
										l,
										nil,
										nil,
										nil,
										nil,
										nil,
										nil,
										nil,
										"Auth"
									)
									carbonEvents.hitEvent:FireServer(k, h, f, j, "Auth", "Part", l)
								end
							elseif massVariableArray.FireMode == 6 and massVariableArray.curConfig.RPGEnabled then
								carbonEvents.explosiveEvent:FireServer(
									l,
									k,
									massVariableArray.curConfig.BlastPressue,
									massVariableArray.curConfig.BlastRadius,
									massVariableArray.curConfig.DestroyJointRadius,
									massVariableArray.curConfig.ExplosionType,
									nil,
									nil,
									nil,
									nil,
									nil,
									nil,
									"Auth",
									nil
								)
							end
						else
							carbonEvents.explosiveEvent:FireServer(
								l,
								k,
								massVariableArray.curConfig.BlastPressue,
								massVariableArray.curConfig.BlastRadius,
								massVariableArray.curConfig.DestroyJointRadius,
								massVariableArray.curConfig.ExplosionType,
								nil,
								nil,
								nil,
								nil,
								nil,
								nil,
								"Auth",
								nil
							)
						end
					end
				end
				break
			end
			g = e
		end
		return l, k
	end
end
function CreateShell()
	local _
	if massVariableArray.curConfig.RoundType then
		if carbonFx:FindFirstChild(massVariableArray.curConfig.RoundType) then
			_ = carbonFx:WaitForChild(massVariableArray.curConfig.RoundType):clone()
		else
			_ = carbonFx:WaitForChild("Shell"):clone()
		end
	else
		_ = carbonFx:WaitForChild("Shell"):clone()
	end
	_.Anchored = false
	d = carbonConfigs.codeArchive.getQuality()
	_.CanCollide = false
	if _:FindFirstChildOfClass("Motor6D") then
		_:FindFirstChildOfClass("Motor6D"):Destroy()
	end
	_.CFrame = massVariableArray.curModel.Chamber.CFrame
	_.Velocity = massVariableArray.curModel.Chamber.CFrame.lookVector * 30 + Vector3.new(0, 4, 0)
	_.RotVelocity = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180))
    _.Parent = carbonAudio
    game:GetService("Debris"):addItem(_, 10)
    delay(
        0.1,
        function()
            if d then
                _.CanCollide = true
            else
                _.CanCollide = false
            end
        end
    )
    for _, _ in pairs(massVariableArray.curModel.Chamber:GetChildren()) do
        if _ and _.Name == "Gas_Discharge" then
            _.Enabled = true
            delay(
                0.1,
                function()
                    _.Enabled = false
                end
            )
        end
    end
end
function CreateDustUp()
    if carbonConfigs.globalConfig.DustUpFX then
        local b, a, _ =
            workspace:FindPartOnRayWithIgnoreList(Ray.new(massVariableArray.FirePart.Position, massVariableArray.FirePart.CFrame.upVector * -3), componentCollection)
        local c = Vector3.new(0, 1, 0):Cross(_)
        local _ = math.asin(c.magnitude)
        if b then
            local b = Instance.new("Part")
            b.Parent = carbonAudio
            b.Anchored = false
            b.CanCollide = false
            b.Transparency = 1
            b.CFrame = CFrame.new(a) * CFrame.fromAxisAngle(c.magnitude == 0 and Vector3.new(1) or c.unit, _)
            local _ = carbonFx:WaitForChild("DustUp"):Clone()
            _.Parent = b
            _.Enabled = true
            game.Debris:AddItem(b, 2)
            delay(
                0.1,
                function()
                    _.Enabled = false
                end
            )
        end
        local b, a, _ =
            workspace:FindPartOnRayWithIgnoreList(Ray.new(massVariableArray.FirePart.Position, massVariableArray.FirePart.CFrame.upVector * 3), componentCollection)
        local c = Vector3.new(0, 1, 0):Cross(_)
        local _ = math.asin(c.magnitude)
        if b then
            local b = Instance.new("Part")
            b.Parent = carbonAudio
            b.Anchored = false
            b.CanCollide = false
            b.Transparency = 1
            b.CFrame = CFrame.new(a) * CFrame.fromAxisAngle(c.magnitude == 0 and Vector3.new(1) or c.unit, _)
            local _ = carbonFx:WaitForChild("DustUp"):Clone()
            _.Parent = b
            _.Enabled = true
            game.Debris:AddItem(b, 2)
            delay(
                0.1,
                function()
                    _.Enabled = false
                end
            )
        end
        local b, _, a =
            workspace:FindPartOnRayWithIgnoreList(
            Ray.new(massVariableArray.FirePart.Position, massVariableArray.FirePart.CFrame.rightVector * -3),
            componentCollection
        )
        local c = Vector3.new(0, 1, 0):Cross(a)
        local a = math.asin(c.magnitude)
        if b then
            local b = Instance.new("Part")
            b.Parent = carbonAudio
            b.Anchored = false
            b.CanCollide = false
            b.Transparency = 1
            b.CFrame = CFrame.new(_) * CFrame.fromAxisAngle(c.magnitude == 0 and Vector3.new(1) or c.unit, a)
            local _ = carbonFx:WaitForChild("DustUp"):Clone()
            _.Parent = b
            _.Enabled = true
            game.Debris:AddItem(b, 2)
            delay(
                0.1,
                function()
                    _.Enabled = false
                end
            )
        end
        local _, b, a =
            workspace:FindPartOnRayWithIgnoreList(Ray.new(massVariableArray.FirePart.Position, massVariableArray.FirePart.CFrame.rightVector * 3), componentCollection)
        local c = Vector3.new(0, 1, 0):Cross(a)
        local a = math.asin(c.magnitude)
        if _ then
            local d = Instance.new("Part")
            d.Parent = carbonAudio
            d.Anchored = false
            d.CanCollide = false
            d.Transparency = 1
            d.CFrame = CFrame.new(b) * CFrame.fromAxisAngle(c.magnitude == 0 and Vector3.new(1) or c.unit, a)
            local _ = carbonFx:WaitForChild("DustUp"):Clone()
            _.Parent = d
            _.Enabled = true
            game.Debris:AddItem(d, 2)
            delay(
                0.1,
                function()
                    _.Enabled = false
                end
            )
        end
    end
end
function fireSemi()
    if massVariableArray.curConfig then
        if Ca then
            fa = true
            massVariableArray.CanShoot = false
            Recoiling = true
            local a = CalculateRecoil()
            local _ = CalculateCamRecoil()
            recoilData.recoilSpring.t = recoilData.recoilSpring.t + a
            recoilData.recoilSpring2.t = recoilData.recoilSpring2.t + _
            if massVariableArray.curConfig.Firerate / 2 >= 0.025 then
                delay(
                    0.025,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - a
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - _
                    end
                )
            elseif massVariableArray.curConfig.Firerate / 2 < 0.025 then
                delay(
                    massVariableArray.curConfig.Firerate / 2,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - a
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - _
                    end
                )
            end
            if massVariableArray.curConfig.fireAnim then
                spawn(
                    function()
                        fireAnim()
                    end
                )
            end
            CreateDustUp()
            carbonEvents.updateCharEvent:FireServer("Shoot", true, "Auth", massVariableArray.curConfig.Firerate / 2)
            Shooting = true
            if carbonConfigs.globalConfig.SoundIso then
                carbonEvents.connectionEvent:FireServer(
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire"
                    ).SoundId,
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"),
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire"
                    ).PlaybackSpeed,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    "Auth"
                )
            end
            playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                "Fire"
            ):Play()
            _aBullet = CreateBullet(massVariableArray.curConfig.BulletSpread)
            massVariableArray.Ammo = massVariableArray.Ammo - 1
            if massVariableArray.Ammo <= 0 then
                for _, _ in pairs(massVariableArray.curModel:GetDescendants()) do
                    if _ and _.Name == "Ping" and _:IsA("Sound") then
                        _:Play()
                    end
                end
            end
            RecoilFront = true
            local _, _ =
                spawn(
                function()
                    CastRay(_aBullet)
                end
            )
            for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                if _.Name:sub(1, 7) == "FlashFX" then
                    _.Enabled = true
                end
            end
            delay(
                1 / 30,
                function()
                    for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                        if _.Name:sub(1, 7) == "FlashFX" then
                            _.Enabled = false
                        end
                    end
                end
            )
            if massVariableArray.curConfig.CanBolt == true then
                BoltingBackAnim()
                delay(
                    massVariableArray.curConfig.Firerate / 2,
                    function()
                        if massVariableArray.curConfig.CanSlideLock == false then
                            BoltingForwardAnim()
                        elseif massVariableArray.curConfig.CanSlideLock == true then
                            if massVariableArray.Ammo > 0 then
                                BoltingForwardAnim()
                            end
                        end
                    end
                )
            end
            delay(
                massVariableArray.curConfig.Firerate / 2,
                function()
                    Recoiling = false
                    RecoilFront = false
                end
            )
            task.wait(massVariableArray.curConfig.Firerate)
            Shooting = false
            massVariableArray.CanShoot = true
        end
        local _ = carbonConfigs.codeArchive.JamCalculation(carbonConfigs.globalConfig.JamChance)
        if _ then
            massVariableArray.CanShoot = false
            UpdateAmmo()
        end
        UpdateAmmo()
    end
    fa = false
end
function fireRPG()
    if massVariableArray.curConfig and massVariableArray.FirePart then
        if Ca then
            fa = true
            massVariableArray.CanShoot = false
            Recoiling = true
            local _ = CalculateRecoil()
            local a = CalculateCamRecoil()
            recoilData.recoilSpring.t = recoilData.recoilSpring.t + _
            recoilData.recoilSpring2.t = recoilData.recoilSpring2.t + a
            if massVariableArray.curConfig.Firerate / 2 >= 0.025 then
                delay(
                    0.025,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - _
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - a
                    end
                )
            elseif massVariableArray.curConfig.Firerate / 2 < 0.025 then
                delay(
                    massVariableArray.curConfig.Firerate / 2,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - _
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - a
                    end
                )
            end
            massVariableArray.Mag.Transparency = 1
            if massVariableArray.curConfig.fireAnim then
                spawn(
                    function()
                        fireAnim()
                    end
                )
            end
            CreateDustUp()
            carbonEvents.updateCharEvent:FireServer("Shoot", true, "Auth", massVariableArray.curConfig.Firerate / 2)
            Shooting = true
            if carbonConfigs.globalConfig.SoundIso then
                carbonEvents.connectionEvent:FireServer(
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire"
                    ).SoundId,
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"),
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire"
                    ).PlaybackSpeed,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    "Auth"
                )
            end
            playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                "Fire"
            ):Play()
            _aBullet = CreateBullet(0)
            massVariableArray.Ammo = massVariableArray.Ammo - 1
            RecoilFront = true
            local _, _ =
                spawn(
                function()
                    CastRay(_aBullet)
                end
            )
            for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                if _.Name:sub(1, 7) == "FlashFX" then
                    _.Enabled = true
                end
            end
            delay(
                1 / 30,
                function()
                    for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                        if _.Name:sub(1, 7) == "FlashFX" then
                            _.Enabled = false
                        end
                    end
                end
            )
            delay(
                massVariableArray.curConfig.Firerate / 2,
                function()
                    Recoiling = false
                    RecoilFront = false
                end
            )
            Shooting = false
        end
        UpdateAmmo()
    end
    fa = false
end
function fireExplosive()
    if massVariableArray.curConfig and massVariableArray.FirePart2 then
        if Ca then
            fa = true
            massVariableArray.CanShoot = false
            G = true
            Recoiling = true
            local a = CalculateRecoil()
            local _ = CalculateCamRecoil()
            recoilData.recoilSpring.t = recoilData.recoilSpring.t + a
            recoilData.recoilSpring2.t = recoilData.recoilSpring2.t + _
            if massVariableArray.curConfig.Firerate / 2 >= 0.025 then
                delay(
                    0.025,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - a
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - _
                    end
                )
            elseif massVariableArray.curConfig.Firerate / 2 < 0.025 then
                delay(
                    massVariableArray.curConfig.Firerate / 2,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - a
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - _
                    end
                )
            end
            if massVariableArray.curConfig.fireAnim then
                spawn(
                    function()
                        fireAnim()
                    end
                )
            end
            CreateDustUp()
            carbonEvents.updateCharEvent:FireServer("Shoot", true, "Auth", massVariableArray.curConfig.Firerate / 2)
            Shooting = true
            if carbonConfigs.globalConfig.SoundIso then
                carbonEvents.connectionEvent:FireServer(
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire2"
                    ).SoundId,
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"),
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire2"
                    ).PlaybackSpeed,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    "Auth"
                )
            end
            playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                "Fire2"
            ):Play()
            _aBullet = CreateBullet(0)
            massVariableArray.ExplosiveAmmo = massVariableArray.ExplosiveAmmo - 1
            RecoilFront = true
            local _, _ =
                spawn(
                function()
                    CastRay(_aBullet)
                end
            )
            for _, _ in pairs(massVariableArray.FirePart2:GetChildren()) do
                if _.Name:sub(1, 7) == "FlashFX" then
                    _.Enabled = true
                end
            end
            delay(
                1 / 30,
                function()
                    for _, _ in pairs(massVariableArray.FirePart2:GetChildren()) do
                        if _.Name:sub(1, 7) == "FlashFX" then
                            _.Enabled = false
                        end
                    end
                end
            )
            delay(
                massVariableArray.curConfig.Firerate / 2,
                function()
                    Recoiling = false
                    RecoilFront = false
                end
            )
            Shooting = false
        end
        UpdateAmmo()
    end
    fa = false
end
function fireShot()
    if massVariableArray.curConfig then
        if Ca then
            fa = true
            massVariableArray.CanShoot = false
            Recoiling = true
            local _ = CalculateRecoil()
            local a = CalculateCamRecoil()
            recoilData.recoilSpring.t = recoilData.recoilSpring.t + _
            recoilData.recoilSpring2.t = recoilData.recoilSpring2.t + a
            if massVariableArray.curConfig.Firerate / 2 >= 0.025 then
                delay(
                    0.025,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - _
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - a
                    end
                )
            elseif massVariableArray.curConfig.Firerate / 2 < 0.025 then
                delay(
                    massVariableArray.curConfig.Firerate / 2,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - _
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - a
                    end
                )
            end
            if massVariableArray.curConfig.fireAnim then
                spawn(
                    function()
                        fireAnim()
                    end
                )
            end
            CreateDustUp()
            carbonEvents.updateCharEvent:FireServer("Shoot", true, "Auth", massVariableArray.curConfig.Firerate / 2)
            Shooting = true
            RecoilFront = true
            if carbonConfigs.globalConfig.SoundIso then
                carbonEvents.connectionEvent:FireServer(
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire"
                    ).SoundId,
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"),
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire"
                    ).PlaybackSpeed,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    "Auth"
                )
            end
            playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                "Fire"
            ):Play()
            for _ = 1, massVariableArray.curConfig.ShotNum do
                spawn(
                    function()
                        _aBullet = CreateBullet(massVariableArray.curConfig.BulletSpread)
                    end
                )
                local _, _ =
                    spawn(
                    function()
                        CastRay(_aBullet)
                    end
                )
            end
            for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                if _.Name:sub(1, 7) == "FlashFX" then
                    _.Enabled = true
                end
            end
            delay(
                1 / 30,
                function()
                    for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                        if _.Name:sub(1, 7) == "FlashFX" then
                            _.Enabled = false
                        end
                    end
                end
            )
            if massVariableArray.curConfig.CanBolt == true then
                BoltingBackAnim()
                delay(
                    massVariableArray.curConfig.Firerate / 2,
                    function()
                        if massVariableArray.curConfig.CanSlideLock == false then
                            BoltingForwardAnim()
                        elseif massVariableArray.curConfig.CanSlideLock == true then
                            if massVariableArray.Ammo > 0 then
                                BoltingForwardAnim()
                            end
                        end
                    end
                )
            end
            delay(
                massVariableArray.curConfig.Firerate / 2,
                function()
                    Recoiling = false
                    RecoilFront = false
                end
            )
            massVariableArray.Ammo = massVariableArray.Ammo - 1
            task.wait(massVariableArray.curConfig.Firerate)
            ta = false
            if massVariableArray.curConfig.CanAutoBolt then
                Actioning = true
                BoltBackAnim()
                BoltForwardAnim()
                IdleAnim()
                Actioning = false
                massVariableArray.CanShoot = true
            end
            Shooting = false
            UpdateAmmo()
            local _ = carbonConfigs.codeArchive.JamCalculation(carbonConfigs.globalConfig.JamChance)
            if _ then
                massVariableArray.CanShoot = false
                UpdateAmmo()
            end
        end
        UpdateAmmo()
    end
    fa = false
end
function fireBoltAction()
    if massVariableArray.curConfig then
        if Ca then
            fa = true
            massVariableArray.CanShoot = false
            Recoiling = true
            local a = CalculateRecoil()
            local _ = CalculateCamRecoil()
            recoilData.recoilSpring.t = recoilData.recoilSpring.t + a
            recoilData.recoilSpring2.t = recoilData.recoilSpring2.t + _
            if massVariableArray.curConfig.Firerate / 2 >= 0.025 then
                delay(
                    0.025,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - a
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - _
                    end
                )
            elseif massVariableArray.curConfig.Firerate / 2 < 0.025 then
                delay(
                    massVariableArray.curConfig.Firerate / 2,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - a
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - _
                    end
                )
            end
            if massVariableArray.curConfig.fireAnim then
                spawn(
                    function()
                        fireAnim()
                    end
                )
            end
            CreateDustUp()
            carbonEvents.updateCharEvent:FireServer("Shoot", true, "Auth", massVariableArray.curConfig.Firerate / 2)
            Shooting = true
            if carbonConfigs.globalConfig.SoundIso then
                carbonEvents.connectionEvent:FireServer(
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire"
                    ).SoundId,
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"),
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire"
                    ).PlaybackSpeed,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    "Auth"
                )
            end
            playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                "Fire"
            ):Play()
            _aBullet = CreateBullet(massVariableArray.curConfig.BulletSpread)
            massVariableArray.Ammo = massVariableArray.Ammo - 1
            RecoilFront = true
            local _, _ =
                spawn(
                function()
                    CastRay(_aBullet)
                end
            )
            for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                if _.Name:sub(1, 7) == "FlashFX" then
                    _.Enabled = true
                end
            end
            delay(
                1 / 30,
                function()
                    for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                        if _.Name:sub(1, 7) == "FlashFX" then
                            _.Enabled = false
                        end
                    end
                end
            )
            if massVariableArray.curConfig.CanBolt == true then
                BoltingBackAnim()
                delay(
                    massVariableArray.curConfig.Firerate / 2,
                    function()
                        if massVariableArray.curConfig.CanSlideLock == false then
                            BoltingForwardAnim()
                        elseif massVariableArray.curConfig.CanSlideLock == true then
                            if massVariableArray.Ammo > 0 then
                                BoltingForwardAnim()
                            end
                        end
                    end
                )
            end
            delay(
                massVariableArray.curConfig.Firerate / 2,
                function()
                    Recoiling = false
                    RecoilFront = false
                end
            )
            ta = false
            task.wait(massVariableArray.curConfig.Firerate)
            if massVariableArray.curConfig.CanAutoBolt then
                Actioning = true
                BoltBackAnim()
                BoltForwardAnim()
                IdleAnim()
                Actioning = false
                massVariableArray.CanShoot = true
            end
            Shooting = false
            UpdateAmmo()
            local _ = carbonConfigs.codeArchive.JamCalculation(carbonConfigs.globalConfig.JamChance)
            if _ then
                massVariableArray.CanShoot = false
                UpdateAmmo()
            end
        end
        UpdateAmmo()
    end
    fa = false
end
function fireAuto()
    if massVariableArray.curConfig then
        while not Shooting and massVariableArray.Ammo > 0 and massVariableArray.MouseHeld and massVariableArray.CanShoot and Ca and not W do
            if W then
                massVariableArray.CanShoot = false
                Shooting = false
                break
            end
            fa = true
            massVariableArray.CanShoot = false
            Recoiling = true
            local a = CalculateRecoil()
            local _ = CalculateCamRecoil()
            recoilData.recoilSpring.t = recoilData.recoilSpring.t + a
            recoilData.recoilSpring2.t = recoilData.recoilSpring2.t + _
            if massVariableArray.curConfig.Firerate / 2 >= 0.025 then
                delay(
                    0.025,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - a
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - _
                    end
                )
            elseif massVariableArray.curConfig.Firerate / 2 < 0.025 then
                delay(
                    massVariableArray.curConfig.Firerate / 2,
                    function()
                        recoilData.recoilSpring.t = recoilData.recoilSpring.t - a
                        recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - _
                    end
                )
            end
            if massVariableArray.curConfig.fireAnim then
                spawn(
                    function()
                        fireAnim()
                    end
                )
            end
            CreateDustUp()
            carbonEvents.updateCharEvent:FireServer("Shoot", true, "Auth", massVariableArray.curConfig.Firerate / 2)
            if carbonConfigs.globalConfig.SoundIso then
                carbonEvents.connectionEvent:FireServer(
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire"
                    ).SoundId,
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"),
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire"
                    ).PlaybackSpeed,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    "Auth"
                )
            end
            playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                "Fire"
            ):Play()
            massVariableArray.Ammo = massVariableArray.Ammo - 1
            Shooting = true
            RecoilFront = true
            _aBullet = CreateBullet(massVariableArray.curConfig.BulletSpread)
            local _, _ =
                spawn(
                function()
                    CastRay(_aBullet)
                end
            )
            for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                if _.Name:sub(1, 7) == "FlashFX" then
                    _.Enabled = true
                end
            end
            delay(
                1 / 30,
                function()
                    for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                        if _.Name:sub(1, 7) == "FlashFX" then
                            _.Enabled = false
                        end
                    end
                end
            )
            if massVariableArray.curConfig.CanBolt == true then
                BoltingBackAnim()
                delay(
                    massVariableArray.curConfig.Firerate / 2,
                    function()
                        if massVariableArray.curConfig.CanSlideLock == false then
                            BoltingForwardAnim()
                        elseif massVariableArray.curConfig.CanSlideLock == true then
                            if massVariableArray.Ammo > 0 then
                                BoltingForwardAnim()
                            end
                        end
                    end
                )
            end
            delay(
                massVariableArray.curConfig.Firerate / 2,
                function()
                    Recoiling = false
                    RecoilFront = false
                end
            )
            task.wait(massVariableArray.curConfig.Firerate)
            Shooting = false
            massVariableArray.CanShoot = true
            UpdateAmmo()
            local _ = carbonConfigs.codeArchive.JamCalculation(carbonConfigs.globalConfig.JamChance)
            if _ then
                massVariableArray.CanShoot = false
                UpdateAmmo()
            end
        end
        UpdateAmmo()
    end
    fa = false
end
function fireBurst()
    if massVariableArray.curConfig then
        if not Shooting and massVariableArray.Ammo > 0 and massVariableArray.MouseHeld and Ca then
            fa = true
            for _ = 1, massVariableArray.curConfig.BurstNum do
                if massVariableArray.Ammo > 0 and massVariableArray.MouseHeld then
                    massVariableArray.CanShoot = false
                    Recoiling = true
                    local a = CalculateRecoil()
                    local _ = CalculateCamRecoil()
                    recoilData.recoilSpring.t = recoilData.recoilSpring.t + a
                    recoilData.recoilSpring2.t = recoilData.recoilSpring2.t + _
                    if massVariableArray.curConfig.Firerate / 2 >= 0.025 then
                        delay(
                            0.025,
                            function()
                                recoilData.recoilSpring.t = recoilData.recoilSpring.t - a
                                recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - _
                            end
                        )
                    elseif massVariableArray.curConfig.Firerate / 2 < 0.025 then
                        delay(
                            massVariableArray.curConfig.Firerate / 2,
                            function()
                                recoilData.recoilSpring.t = recoilData.recoilSpring.t - a
                                recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - _
                            end
                        )
                    end
                    if massVariableArray.curConfig.fireAnim then
                        spawn(
                            function()
                                fireAnim()
                            end
                        )
                    end
                    CreateDustUp()
                    carbonEvents.updateCharEvent:FireServer(
                        "Shoot",
                        true,
                        "Auth",
                        massVariableArray.curConfig.Firerate / 2
                    )
                    if carbonConfigs.globalConfig.SoundIso then
                        carbonEvents.connectionEvent:FireServer(
                            playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                                "Fire"
                            ).SoundId,
                            playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"),
                            playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                                "Fire"
                            ).PlaybackSpeed,
                            nil,
                            nil,
                            nil,
                            nil,
                            nil,
                            nil,
                            nil,
                            nil,
                            nil,
                            "Auth"
                        )
                    end
                    playerCharacter:WaitForChild("@" .. massVariableArray.curModel.Name):WaitForChild("Grip"):WaitForChild(
                        "Fire"
                    ):Play()
                    _aBullet = CreateBullet(massVariableArray.curConfig.BulletSpread)
                    local _, _ =
                        spawn(
                        function()
                            CastRay(_aBullet)
                        end
                    )
                    for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                        if _.Name:sub(1, 7) == "FlashFX" then
                            _.Enabled = true
                        end
                    end
                    delay(
                        1 / 30,
                        function()
                            for _, _ in pairs(massVariableArray.FirePart:GetChildren()) do
                                if _.Name:sub(1, 7) == "FlashFX" then
                                    _.Enabled = false
                                end
                            end
                        end
                    )
                    if massVariableArray.curConfig.CanBolt == true then
                        BoltingBackAnim()
                        delay(
                            massVariableArray.curConfig.Firerate / 2,
                            function()
                                if massVariableArray.curConfig.CanSlideLock == false then
                                    BoltingForwardAnim()
                                elseif massVariableArray.curConfig.CanSlideLock == true then
                                    if massVariableArray.Ammo > 0 then
                                        BoltingForwardAnim()
                                    end
                                end
                            end
                        )
                    end
                    massVariableArray.Ammo = massVariableArray.Ammo - 1
                    RecoilFront = true
                    delay(
                        massVariableArray.curConfig.Firerate / 2,
                        function()
                            Recoiling = false
                            RecoilFront = false
                        end
                    )
                    task.wait(massVariableArray.curConfig.Firerate)
                end
                Shooting = true
            end
            Shooting = false
            massVariableArray.CanShoot = true
            UpdateAmmo()
        end
        UpdateAmmo()
    end
    fa = false
end
function UpdateAmmo()
    if massVariableArray.curConfig then
        massVariableArray.ammoDisplay.Text = massVariableArray.Ammo
        massVariableArray.title.Text = massVariableArray.curModel.Name
        massVariableArray.magCountDisplay.Text = math.ceil(massVariableArray.StoredAmmo / massVariableArray.curConfig.StoredAmmo)
        massVariableArray.mobileAmmo.Text = massVariableArray.Ammo .. "/" .. math.ceil(massVariableArray.StoredAmmo / massVariableArray.curConfig.StoredAmmo)
        if massVariableArray.StanceIndex == 0 then
            massVariableArray.stanceDisplay.Image = "rbxassetid://" .. 1868007495
            massVariableArray.stanceDisplay.Position = UDim2.new(1, -102, 0, 0)
        elseif massVariableArray.StanceIndex == 1 then
            massVariableArray.stanceDisplay.Image = "rbxassetid://" .. 1868007947
            massVariableArray.stanceDisplay.Position = UDim2.new(1, -102, 0, 10)
        elseif massVariableArray.StanceIndex == 2 then
            massVariableArray.stanceDisplay.Image = "rbxassetid://" .. 1868008584
            massVariableArray.stanceDisplay.Position = UDim2.new(1, -102, 0, 23)
        end
        if massVariableArray.FireMode == 1 then
            massVariableArray.mode1.BackgroundTransparency = 0
            massVariableArray.mode2.BackgroundTransparency = 0.7
            massVariableArray.mode3.BackgroundTransparency = 0.7
            massVariableArray.mode4.BackgroundTransparency = 0.7
            massVariableArray.mode5.BackgroundTransparency = 0.7
        elseif massVariableArray.FireMode == 2 then
            massVariableArray.mode1.BackgroundTransparency = 0
            massVariableArray.mode2.BackgroundTransparency = 0
            massVariableArray.mode3.BackgroundTransparency = 0
            massVariableArray.mode4.BackgroundTransparency = 0
            massVariableArray.mode5.BackgroundTransparency = 0
        elseif massVariableArray.FireMode == 3 then
            massVariableArray.mode1.BackgroundTransparency = 0
            massVariableArray.mode2.BackgroundTransparency = 0
            massVariableArray.mode3.BackgroundTransparency = 0.7
            massVariableArray.mode4.BackgroundTransparency = 0.7
            massVariableArray.mode5.BackgroundTransparency = 0.7
        elseif massVariableArray.FireMode == 4 then
            massVariableArray.mode1.BackgroundTransparency = 0
            massVariableArray.mode2.BackgroundTransparency = 0
            massVariableArray.mode3.BackgroundTransparency = 0
            massVariableArray.mode4.BackgroundTransparency = 0.7
            massVariableArray.mode5.BackgroundTransparency = 0.7
        elseif massVariableArray.FireMode == 5 then
            massVariableArray.mode1.BackgroundTransparency = 0
            massVariableArray.mode2.BackgroundTransparency = 0
            massVariableArray.mode3.BackgroundTransparency = 0
            massVariableArray.mode4.BackgroundTransparency = 0
            massVariableArray.mode5.BackgroundTransparency = 0.7
        elseif massVariableArray.FireMode == 6 then
            massVariableArray.mode1.BackgroundTransparency = 0
            massVariableArray.mode2.BackgroundTransparency = 0.7
            massVariableArray.mode3.BackgroundTransparency = 0
            massVariableArray.mode4.BackgroundTransparency = 0
            massVariableArray.mode5.BackgroundTransparency = 0.7
        end
        if massVariableArray.CanShoot then
            for _, _ in pairs(massVariableArray.mainFrame:GetChildren()) do
                if _ and _.Name:sub(1, 4) == "Mode" then
                    _.BackgroundColor3 =
                        BrickColor.new("Institutional white").Color
                end
            end
        else
            for _, _ in pairs(massVariableArray.mainFrame:GetChildren()) do
                if _ and _.Name:sub(1, 4) == "Mode" then
                    if _.BackgroundTransparency == 0 then
                        _.BackgroundColor3 = BrickColor.new("Dusty Rose").Color
                    else
                        _.BackgroundColor3 =
                            BrickColor.new(
                            "Institutional white"
                        ).Color
                    end
                end
            end
        end
    end
end
function OtherLaser(d, _, _, f)
    if _ then
        if f:FindFirstChild("LaserLight") then
            local _ =
                f.LaserLight:FindFirstChild("Attch0") or
                Instance.new("Attachment")
            _.Parent = f.LaserLight
            _.Name = "Attch0"
            local b =
                f.LaserLight:FindFirstChild("Attch1") or
                Instance.new("Attachment")
            b.Parent = f.LaserLight
            b.Name = "Attch1"
            local e = currentCamera:FindFirstChild(d.Name .. "Sphere") or Instance.new("Part")
            e.Name = d.Name .. "Sphere"
            e.Shape = "Ball"
            e.Size = Vector3.new(0.1, 0.1, 0.1)
            e.Parent = currentCamera
            e.CanCollide = false
            e.BrickColor = BrickColor.new("Really red")
            e.Material = Enum.Material.Neon
            local a = f.LaserLight:FindFirstChild("Beam") or Instance.new("Beam")
            a.Name = "Beam"
            a.Parent = f.LaserLight
            a.Attachment0 = _
            a.Attachment1 = b
            a.Color = ColorSequence.new(BrickColor.new("Really red").Color)
            a.LightEmission = 1
            a.LightInfluence = 0
            a.Transparency = NumberSequence.new(0.3)
            a.FaceCamera = true
            a.Width0 = 0.01
            a.Width1 = 0.01
            local _ = Ray.new(f.LaserLight.Position, f.Grip.CFrame.lookVector * 9999)
            local c, a, _ = workspace:FindPartOnRayWithIgnoreList(_, componentList)
            local _ = d.Character.CarbonValues:WaitForChild("CurLength").Value
            if c then
                _ = (f.LaserLight.Position - a).magnitude
            else
                _ = 9999
            end
            b.CFrame = CFrame.new(0, 0, -_)
            e.CFrame = b.WorldCFrame
            if c and (c and c.Transparency >= 1 or c.CanCollide == false) then
                table.insert(componentList, c)
            end
        end
    else
        if currentCamera:FindFirstChild(d.Name .. "Sphere") then
            currentCamera[d.Name .. "Sphere"]:Destroy()
        end
        if
            d.Character.CarbonValues.SModel.Value and f:FindFirstChild("LaserLight") and
                f:WaitForChild("LaserLight"):FindFirstChild("Attch0") and
                f:WaitForChild("LaserLight"):FindFirstChild("Attch1") and
                f:WaitForChild("LaserLight"):FindFirstChild("Beam")
         then
            f.LaserLight:WaitForChild("Attch0"):Destroy()
            f.LaserLight:WaitForChild("Attch1"):Destroy()
            f.LaserLight:WaitForChild("Beam"):Destroy()
        end
    end
end
function HandleBino()
    i = true
    if na then
        if za then
            Aim(false, false)
        end
        if ya then
            Sprint(false, false)
        end
        I = carbonFx:WaitForChild("Binos"):clone()
        I.Parent = massVariableArray.LA
        for _, _ in pairs(I:GetChildren()) do
            if _ and _:IsA("BasePart") then
                if _.Name ~= "Grip" then
                    carbonConfigs.utilitiesModule.Weld(_, I:WaitForChild("Grip"))
                elseif _.Name == "Grip" then
                    carbonConfigs.utilitiesModule.Weld(
                        _,
                        massVariableArray.LA,
                        nil,
                        CFrame.new(
                            0.800000012,
                            -1.5,
                            -0.300000012,
                            -0.937805653,
                            -0.290587008,
                            -0.189946115,
                            0.333234578,
                            -0.906904817,
                            -0.257833958,
                            -0.0973398462,
                            -0.305094779,
                            0.94733417
                        )
                    )
                end
            end
        end
        for _, _ in pairs(I:GetChildren()) do
            if _ and _:IsA("BasePart") then
                _.Anchored = false
            end
        end
        tweenService:Create(
            massVariableArray.LAW,
            TweenInfo.new(0.4),
            {
                C1 = CFrame.new(
                    0.854482472,
                    -0.0104820728,
                    -3.38849306,
                    0.937293589,
                    -0.342890739,
                    0.0625019744,
                    0.0908710212,
                    0.413531393,
                    0.905943871,
                    -0.33648622,
                    -0.843455732,
                    0.418759137
                )
            }
        ):Play()
        task.wait(0.4)
        tweenService:Create(
            massVariableArray.LAW,
            TweenInfo.new(0.4),
            {
                C1 = CFrame.new(
                    1.04499149,
                    -1.10762644,
                    -1.60011971,
                    0.93870455,
                    -0.307206959,
                    0.156389266,
                    -0.343125731,
                    -0.876287758,
                    0.338207453,
                    0.0331422724,
                    -0.371138126,
                    -0.927986026
                )
            }
        ):Play()
        tweenService:Create(
            massVariableArray.RAW,
            TweenInfo.new(0.4),
            {
                C1 = CFrame.new(
                    -1.43314123,
                    -1.48713386,
                    -1.55439997,
                    0.99999994,
                    0,
                    0,
                    0,
                    -0.939692616,
                    0.342020065,
                    0,
                    -0.342020065,
                    -0.939692616
                )
            }
        ):Play()
        tweenService:Create(
            massVariableArray.hud:WaitForChild("RangeFrame"),
            TweenInfo.new(0.4),
            {BackgroundTransparency = 0}
        ):Play()
        task.wait(0.4)
        for _, _ in pairs(I:GetChildren()) do
            if _ and _:IsA("BasePart") then
                _.LocalTransparencyModifier = 1
            end
        end
        massVariableArray.LA.LocalTransparencyModifier = 1
        for _, _ in pairs(massVariableArray.hud:WaitForChild("RangeFrame"):GetChildren()) do
            if _ then
                _.Visible = true
            end
        end
        massVariableArray.hud:WaitForChild("RangeFrame"):WaitForChild("ZoomNum").Text =
            carbonConfigs.globalConfig.BinoZoom
        tweenService:Create(currentCamera, TweenInfo.new(0.05, Enum.EasingStyle.Quad), {FieldOfView = carbonConfigs.globalConfig.BinoZoom}):Play()
        task.wait(0.05)
        tweenService:Create(
            massVariableArray.hud:WaitForChild("RangeFrame"),
            TweenInfo.new(0.4),
            {BackgroundTransparency = 1}
        ):Play()
        task.wait(0.4)
    else
        tweenService:Create(
            massVariableArray.hud:WaitForChild("RangeFrame"),
            TweenInfo.new(0.4),
            {BackgroundTransparency = 0}
        ):Play()
        task.wait(0.4)
        for _, _ in pairs(I:GetChildren()) do
            if _ and _:IsA("BasePart") then
                _.LocalTransparencyModifier = 0
            end
        end
        massVariableArray.LA.LocalTransparencyModifier = 0
        for _, _ in pairs(massVariableArray.hud:WaitForChild("RangeFrame"):GetChildren()) do
            if _ then
                _.Visible = false
            end
        end
        massVariableArray.hud:WaitForChild("RangeFrame"):WaitForChild("ZoomNum").Text =
            "70"
        tweenService:Create(currentCamera, TweenInfo.new(0.05, Enum.EasingStyle.Quad), {FieldOfView = 70}):Play()
        task.wait(0.05)
        tweenService:Create(
            massVariableArray.hud:WaitForChild("RangeFrame"),
            TweenInfo.new(0.4),
            {BackgroundTransparency = 1}
        ):Play()
        task.wait(0.4)
        tweenService:Create(
            massVariableArray.LAW,
            TweenInfo.new(0.4),
            {
                C1 = CFrame.new(
                    0.854482472,
                    -0.0104820728,
                    -3.38849306,
                    0.937293589,
                    -0.342890739,
                    0.0625019744,
                    0.0908710212,
                    0.413531393,
                    0.905943871,
                    -0.33648622,
                    -0.843455732,
                    0.418759137
                )
            }
        ):Play()
        task.wait(0.4)
        IdleAnim()
        massVariableArray.LA:ClearAllChildren()
    end
    i = false
end
function HandleToggle()
    if z then
        playerCharacter:WaitForChild("CarbonValues"):WaitForChild(
                "NVGActive"
            ).Value = true
        massVariableArray.overlay.Image = "rbxassetid://" .. carbonConfigs.globalConfig.OverlayID
        tweenService:Create(game.Lighting, TweenInfo.new(0.5), {ExposureCompensation = carbonConfigs.globalConfig.Exposure}):Play()
        tweenService:Create(
            massVariableArray.cc,
            TweenInfo.new(0.5),
            {
                Brightness = carbonConfigs.globalConfig.OverlayBrightness,
                Contrast = 0.8,
                Saturation = -1,
                TintColor = carbonConfigs.globalConfig.OverlayColor
            }
        ):Play()
        tweenService:Create(massVariableArray.overlay, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
        tweenService:Create(massVariableArray.noise, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
        local _ = carbonFx:WaitForChild("NVGToggle"):Clone()
        _.Parent = localPlayer.PlayerGui
        _:Play()
        game.Debris:AddItem(_, _.TimeLength)
        spawn(
            function()
                while z do
                    cycle(darkNoiseTable)
                    cycle(lightNoiseTableContainer)
                    task.wait(0.05)
                end
            end
        )
        if
            playerCharacter:WaitForChild("CarbonValues"):WaitForChild(
                "NVGActive"
            ).Value == true and
                O and
                massVariableArray.curModel:FindFirstChild("AimPart3") and
                Ca and
                massVariableArray.CurAimPart ~= massVariableArray.curModel.AimPart3
         then
            massVariableArray.CurAimPart = massVariableArray.curModel:WaitForChild("AimPart3")
            massVariableArray.curZoom = 60
            if za then
                tweenService:Create(currentCamera, TweenInfo.new(massVariableArray.curConfig.AimZoomSpeed, Enum.EasingStyle.Quad), {FieldOfView = 60}):Play(

                )
            end
        end
    else
        playerCharacter:WaitForChild("CarbonValues"):WaitForChild(
                "NVGActive"
            ).Value = false
        if Ca then
            massVariableArray.CurAimPart = massVariableArray.lastAimPart
            if massVariableArray.CurAimPart.Name == "AimPart" then
                if not ia then
                    massVariableArray.curZoom = massVariableArray.curConfig.AimZoom
                else
                    massVariableArray.curZoom = P
                end
            elseif massVariableArray.CurAimPart.Name == "AimPart2" then
                if not ia then
                    massVariableArray.curZoom = massVariableArray.curConfig.AltAimZoom
                else
                    massVariableArray.curZoom = R
                end
            end
        end
        tweenService:Create(game.Lighting, TweenInfo.new(0.5), {ExposureCompensation = 0}):Play()
        tweenService:Create(
            massVariableArray.cc,
            TweenInfo.new(0.5),
            {Brightness = 0, Contrast = 0, Saturation = 0, TintColor = Color3.fromRGB(255, 255, 255)}
        ):Play()
        tweenService:Create(massVariableArray.overlay, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
        tweenService:Create(massVariableArray.noise, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
    end
end
function cycle(b)
    local a = massVariableArray.noise
    local _ = b
    local c
    repeat
        c = _[math.random(1, #_)]
    until c ~= b.last
    a.Image = "rbxassetid://" .. c
    local _ = math.random(230, 255)
    a.Position = UDim2.new(math.random(.4, .6), 0, math.random(.4, .6), 0)
    a.ImageColor3 = Color3.fromRGB(_, _, _)
    b.last = c
end
function HandleNades()
    if massVariableArray.NadeMode == 1 then
        tweenService:Create(
            massVariableArray.LAW,
            TweenInfo.new(0.2),
            {
                C1 = CFrame.new(
                    0.922277689,
                    -0.817099452,
                    -1.92854667,
                    0.106011063,
                    -0.34216994,
                    0.933638692,
                    -0.994363368,
                    -0.0348279029,
                    0.100141913,
                    -0.00174888968,
                    -0.938992321,
                    -0.343933403
                )
            }
        ):Play()
        tweenService:Create(
            massVariableArray.RAW,
            TweenInfo.new(0.2),
            {
                C1 = CFrame.new(
                    -1.43363178,
                    -1.14598346,
                    -1.68051922,
                    0.99999994,
                    0,
                    0,
                    0,
                    -0.965925813,
                    0.258818984,
                    0,
                    -0.258818984,
                    -0.965925813
                )
            }
        ):Play()
        task.wait(0.2)
        local a = carbonFx:WaitForChild("FRAG"):clone()
        a.Parent = massVariableArray.LA
        for _, _ in pairs(a:GetChildren()) do
            if _ and _:IsA("BasePart") then
                if _.Name ~= "Grip" then
                    carbonConfigs.utilitiesModule.Weld(_, a:WaitForChild("Grip"))
                elseif _.Name == "Grip" then
                    carbonConfigs.utilitiesModule.Weld(
                        _,
                        massVariableArray.LA,
                        nil,
                        CFrame.new(
                            0.600000024,
                            -1.29999995,
                            -0.300000012,
                            1,
                            0,
                            0,
                            0,
                            1.19248806e-08,
                            1,
                            0,
                            -1,
                            1.19248806e-08
                        )
                    )
                end
            end
        end
        for _, _ in pairs(a:GetChildren()) do
            if _ and _:IsA("BasePart") then
                _.Anchored = false
            end
        end
        tweenService:Create(
            massVariableArray.LAW,
            TweenInfo.new(0.4),
            {
                C1 = CFrame.new(
                    0.0706895888,
                    -1.17250931,
                    -2.82761693,
                    0.594298601,
                    -0.799968779,
                    -0.082818523,
                    -0.72039783,
                    -0.575290084,
                    0.387386143,
                    -0.35754171,
                    -0.170560718,
                    -0.918190002
                )
            }
        ):Play()
        task.wait(0.15)
        tweenService:Create(
            massVariableArray.LAW,
            TweenInfo.new(0.4),
            {
                C1 = CFrame.new(
                    0.570689559,
                    -1.67250919,
                    -1.13768804,
                    0.680744529,
                    -0.693389475,
                    0.236215726,
                    -0.690241337,
                    -0.715155959,
                    -0.110084742,
                    0.245262563,
                    -0.0881062746,
                    -0.965444684
                )
            }
        ):Play()
        task.wait(0.4)
        if a:FindFirstChild("Pin") then
            a.Pin:Destroy()
            a.Lever:Destroy()
        end
        tweenService:Create(
            massVariableArray.LAW,
            TweenInfo.new(0.2),
            {
                C1 = CFrame.new(
                    0.570689559,
                    1.5694685,
                    -2.14090991,
                    0.814135671,
                    -0.56004262,
                    -0.153412074,
                    -0.135140836,
                    -0.439683974,
                    0.887927234,
                    -0.564730048,
                    -0.702160895,
                    -0.433647156
                )
            }
        ):Play()
        task.wait(0.03)
        a.Grip:Destroy()
        massVariableArray.FragAmmo = massVariableArray.FragAmmo - 1
        local _ = a:WaitForChild("NADE"):GetMass()
        local _ = Instance.new("BodyForce", a:WaitForChild("NADE"))
        _.Force = carbonConfigs.globalConfig.NadePhysics
        a:WaitForChild("NADE").Velocity = currentCamera.CFrame.LookVector * carbonConfigs.globalConfig.NadeSpeed
        carbonEvents.nadeEvent:FireServer(a.NADE.CFrame, "Auth", currentCamera.CFrame.LookVector)
        local _ = a.NADE
        _.Parent = carbonAudio
        a:Destroy()
        delay(
            0.02,
            function()
                _.CanCollide = true
                _:WaitForChild("Indicator").MaxDistance = carbonConfigs.globalConfig.BlastRadius
                _:WaitForChild("Indicator"):WaitForChild("Friendly").Visible =
                    true
                if carbonConfigs.globalConfig.NadeTrailEnabled then
                    _:WaitForChild("Trail").Enabled = true
                end
            end
        )
        delay(
            5,
            function()
                carbonEvents.explosiveEvent:FireServer(
                    nil,
                    _.Position,
                    carbonConfigs.globalConfig.BlastPressue,
                    carbonConfigs.globalConfig.BlastRadius,
                    carbonConfigs.globalConfig.DestroyJointRadius,
                    carbonConfigs.globalConfig.ExplosionType,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    "Auth",
                    nil
                )
                _:Destroy()
            end
        )
        task.wait(0.18)
        IdleAnim()
        pa = false
    elseif massVariableArray.NadeMode == 2 then
    elseif massVariableArray.NadeMode == 3 then
    elseif massVariableArray.NadeMode == 4 and not ba then
        ba = true
        tweenService:Create(
            massVariableArray.LAW,
            TweenInfo.new(0.4),
            {
                C1 = CFrame.new(
                    0.922277689,
                    -0.817099452,
                    -1.92854667,
                    0.106011063,
                    -0.34216994,
                    0.933638692,
                    -0.994363368,
                    -0.0348279029,
                    0.100141913,
                    -0.00174888968,
                    -0.938992321,
                    -0.343933403
                )
            }
        ):Play()
        tweenService:Create(
            massVariableArray.RAW,
            TweenInfo.new(0.3),
            {
                C1 = CFrame.new(
                    -1.43363178,
                    -1.14598346,
                    -1.68051922,
                    0.99999994,
                    0,
                    0,
                    0,
                    -0.965925813,
                    0.258818984,
                    0,
                    -0.258818984,
                    -0.965925813
                )
            }
        ):Play()
        task.wait(0.4)
        Z = carbonFx:WaitForChild("C4"):clone()
        Z.Parent = massVariableArray.LA
        for _, _ in pairs(Z:GetChildren()) do
            if _ and _:IsA("BasePart") then
                if _.Name ~= "Grip" then
                    carbonConfigs.utilitiesModule.Weld(_, Z:WaitForChild("Grip"))
                elseif _.Name == "Grip" then
                    carbonConfigs.utilitiesModule.Weld(
                        _,
                        massVariableArray.LA,
                        nil,
                        CFrame.new(0.5, -1.4000001, -0.0999999642, 1, 0, 0, 0, 0.999999881, 0, 0, 0, 1)
                    )
                end
            end
        end
        for _, _ in pairs(Z:GetChildren()) do
            if _ and _:IsA("BasePart") then
                _.Anchored = false
            end
        end
        tweenService:Create(
            massVariableArray.LAW,
            TweenInfo.new(0.4),
            {
                C1 = CFrame.new(
                    0.570689559,
                    1.5694685,
                    -2.14090991,
                    0.814135671,
                    -0.56004262,
                    -0.153412074,
                    -0.135140836,
                    -0.439683974,
                    0.887927234,
                    -0.564730048,
                    -0.702160895,
                    -0.433647156
                )
            }
        ):Play()
        task.wait(0.4)
        g = true
        ba = false
    end
end
function UpdateCamChar(_)
    if playerArms.humanoid.Health > 0 then
        ga.PrimaryPart = J
        D.CFrame = ga.PrimaryPart.CFrame * CFrame.new(0, -0.5, -5) * CFrame.Angles(0, math.rad(180), 0)
        for _, _ in pairs(ga:GetChildren()) do
            if _ and _:IsA("BasePart") then
                _.BrickColor =
                    BrickColor.new("Institutional white")
            end
        end
        for _, _ in pairs(playerCharacter:GetDescendants()) do
            if _ and _.Name == "Middle" and _:FindFirstChild("Middle") then
                if ga:FindFirstChild(_.Middle.Part1.Name) then
                    ga:FindFirstChild(_.Middle.Part1.Name).BrickColor =
                        BrickColor.new("Pastel Blue")
                end
            end
        end
    end
end
function SelectFireMode()
    while true do
        massVariableArray.FireMode = massVariableArray.FireMode + 1
        if massVariableArray.FireMode > 6 then
            massVariableArray.FireMode = 1
        end
        if massVariableArray.FireMode == 1 then
            if massVariableArray.curConfig.SemiEnabled then
                break
            end
        end
        if massVariableArray.FireMode == 2 then
            if massVariableArray.curConfig.AutoEnabled then
                break
            end
        end
        if massVariableArray.FireMode == 3 then
            if massVariableArray.curConfig.BurstEnabled then
                break
            end
        end
        if massVariableArray.FireMode == 4 then
            if massVariableArray.curConfig.BoltAction then
                break
            end
        end
        if massVariableArray.FireMode == 5 then
            if massVariableArray.curConfig.ShotEnabled then
                break
            end
        end
        if massVariableArray.FireMode == 6 then
            if massVariableArray.curConfig.RPGEnabled then
                break
            end
        end
        renderLoop:Wait()
    end
    UpdateAmmo()
end
playerCharacter.ChildAdded:connect(
    function(a)
        if
            a:IsA("Tool") and a:FindFirstChild("Authenticate") and
                playerArms.humanoid.Health > 0 and
                require(a.Authenticate).Type == "Gun"
         then
            if not w then
                local _ = true
                if playerArms.humanoid.Sit and playerCharacter.Humanoid.SeatPart.Name == "DriverSeat" then
                    _ = false
                end
                if _ then
                    massVariableArray.queued = a
                    if not Ca then
                        mouse.TargetFilter = workspace
                        EquipModel(a)
                    elseif Ca then
                        mouse.TargetFilter = nil
                        UnequipModel()
                        mouse.TargetFilter = workspace
                        EquipModel(massVariableArray.queued)
                    end
                end
            end
        end
        for _, _ in pairs(a:GetDescendants()) do
            if _ and _.Name == "Middle" then
            end
        end
    end
)
playerCharacter.ChildRemoved:connect(
    function(_)
        if _ == massVariableArray.tool then
            if Ca then
                if Y then
                    Y:Destroy()
                end
                mouse.TargetFilter = nil
                UnequipModel()
            end
        end
    end
)
localPlayer.CharacterRemoving:Connect(
    function()
        local a = 1
        for _, _ in pairs(carbonEvents) do
            _.Name = resultData[a]
            a = a + 1
        end
    end
)
playerArms.humanoid.Died:connect(
    function()
        print("You died idiot!")
        f = true
        mouse.TargetFilter = nil
        UnequipModel()
        massVariableArray.cc:Destroy()
        massVariableArray.overlay.ImageTransparency = 1
        game.Lighting.ExposureCompensation = 0
        carbonEvents.storeDataEvent:InvokeServer(
            "Erase",
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            "Auth"
        )
        local a = 1
        for _, _ in pairs(carbonEvents) do
            _.Name = resultData[a]
            a = a + 1
        end
    end
)
playerArms.humanoid.Changed:connect(
    function()
        if playerArms.humanoid.Sit and not massVariableArray.StanceIndex ~= 0 then
            massVariableArray.StanceIndex = 0
            changeStance()
        end
        if playerArms.humanoid.Health < h and playerArms.humanoid.Health ~= playerArms.humanoid.MaxHealth then
            local _ = CalculateCamShake()
            recoilData.recoilSpring2.t = recoilData.recoilSpring2.t + _
            delay(
                0.025,
                function()
                    recoilData.recoilSpring2.t = recoilData.recoilSpring2.t - _
                end
            )
            tweenService:Create(
                massVariableArray.intenseShade,
                TweenInfo.new(0.1),
                {
                    ImageColor3 = BrickColor.new(
                        "Institutional white"
                    ).Color
                }
            ):Play()
            delay(
                0.8,
                function()
                    tweenService:Create(
                        massVariableArray.intenseShade,
                        TweenInfo.new(0.3),
                        {ImageColor3 = BrickColor.new("Really black").Color}
                    ):Play()
                end
            )
        end
        h = playerArms.humanoid.Health
    end
)
playerArms.humanoid.StateChanged:Connect(
    function(_, _)
        if _ == Enum.HumanoidStateType.Swimming then
            w = true
            if Ca then
                playerArms.humanoid:UnequipTools()
            end
        else
            w = false
        end
    end
)
playerArms.humanoid.Swimming:Connect(
    function()
        if Ca then
            playerArms.humanoid:UnequipTools()
            w = true
        end
    end
)
userInputService.InputBegan:connect(
	function(a, _)
		prnt("Input began")
		prnt("_:")
		prnt("ca:")
		if Ca and playerArms.humanoid.Health > 0 and massVariableArray.curConfig then
			prnt("check 1 passed")
			if a.UserInputType == massVariableArray.curConfig.ShootKeybind and Ca and not va and not wa and not ka and not na and not T then
				prnt("Check 2 passed")
                massVariableArray.MouseHeld = true
                if not pa then
                    if not ja then
						if massVariableArray.Ammo > 0 then
							prnt("Shootah")
                            Shoot()
                        end
                    else
                        if massVariableArray.ExplosiveAmmo > 0 then
                            Shoot()
                        end
                    end
                    if massVariableArray.Ammo <= 0 or not massVariableArray.CanShoot then
                        massVariableArray.Grip:WaitForChild("Click"):Play()
                    end
                else
                    if massVariableArray.NadeMode == 4 and not ba then
                        ba = true
                        local d, b, c
                        if not V then
                            d, b, c =
                                workspace:FindPartOnRayWithIgnoreList(
                                Ray.new(Z.PrimaryPart.Position, Z.PrimaryPart.CFrame.UpVector * -2),
                                componentCollection
                            )
                            local a = Vector3.new(0, 1, 0):Cross(c)
                            local _ = math.asin(a.magnitude)
                            if d then
                                Z:Destroy()
                                V = carbonEvents.placeC4Event:InvokeServer(b, a, _, "Auth", c, d)
                                IdleAnim()
                                pa = false
                            end
                        end
                        ba = false
                    end
                end
            end
            if
                a.KeyCode == Enum.KeyCode.Minus and Ca and not va and
                    massVariableArray.curModel:FindFirstChild("Node_Storage")
             then
                l = not l
                if l then
                    AttachAnim()
                    userInputService.MouseIconEnabled = true
                    massVariableArray.hud:WaitForChild("Attachment_Frame").Visible =
                        true
                    massVariableArray.hud:WaitForChild("Mouse_Release").Modal = true
                    for _, a in pairs(
                        massVariableArray.curModel:WaitForChild("Node_Storage"):GetChildren()
                    ) do
                        if a then
                            local _ = massVariableArray.tempFolder:WaitForChild("Node_UI"):Clone()
                            _.Parent = localPlayer:WaitForChild("PlayerGui")
                            _.Adornee = a
                            _.Enabled = true
                            _:WaitForChild("Button").MouseButton1Click:Connect(
                                function()
                                    for _, _ in pairs(massVariableArray.attachFrame:GetChildren()) do
                                        if _ and _:IsA("Frame") then
                                            _:Destroy()
                                        end
                                    end
                                    for _, b in pairs(attachmentStorage:GetChildren()) do
                                        if b and b.PrimaryPart.Name == a.Name then
                                            local c =
                                                massVariableArray.tempFolder:WaitForChild(
                                                "Attachment_Item"
                                            ):Clone()
                                            c.Parent = massVariableArray.attachFrame
                                            c.Visible = true
                                            c:WaitForChild("Button").Text = b.Name
                                            local a = Instance.new("Camera")
                                            a.Name = "Display_Cam"
                                            a.CameraType = Enum.CameraType.Scriptable
                                            c:WaitForChild("ViewFrame").CurrentCamera = a
                                            a.Parent = c:WaitForChild("ViewFrame")
                                            local _ = attachmentStorage:WaitForChild(b.Name):Clone()
                                            _.Parent = c:WaitForChild("ViewFrame")
                                            a.CFrame =
                                                _:WaitForChild("Box").CFrame *
                                                CFrame.Angles(0, math.rad(90), 0) *
                                                CFrame.new(0, 0, 1)
                                            for _, _ in pairs(_:GetDescendants()) do
                                                if _ and _:IsA("BasePart") then
                                                    _.BrickColor =
                                                        BrickColor.new(
                                                        "Institutional white"
                                                    )
                                                    _.Material = Enum.Material.SmoothPlastic
                                                    if _:IsA("UnionOperation") then
                                                        _.UsePartColor = true
                                                    end
                                                end
                                            end
                                            c:WaitForChild("Button").MouseButton1Click:Connect(
                                                function()
                                                    local _, a = carbonConfigs.attachmentAPI.AttachCELive(massVariableArray.curModel, b.Name)
                                                    carbonConfigs.attachmentAPI.AttachCE(
                                                        carbonClientResourceModels:FindFirstChild(massVariableArray.curModel.Name),
                                                        b.Name
                                                    )
                                                    massVariableArray.AimPart =
                                                        massVariableArray.curModel:FindFirstChild("AimPart")
                                                    massVariableArray.CurAimPart =
                                                        massVariableArray.curModel:FindFirstChild("AimPart")
                                                    massVariableArray.lastAimPart =
                                                        massVariableArray.curModel:FindFirstChild("AimPart")
                                                    massVariableArray.FirePart =
                                                        massVariableArray.curModel:FindFirstChild("FirePart")
                                                    carbonEvents.attachmentEvent:FireServer(massVariableArray.curModel.Name, b.Name)
                                                    if _ then
                                                        ia = true
                                                        massVariableArray.curZoom = a[1]
                                                        massVariableArray.oAimZoom = a[1]
                                                        R = a[2]
                                                    end
                                                end
                                            )
                                        end
                                    end
                                end
                            )
                        end
                    end
                else
                    userInputService.MouseIconEnabled = false
                    massVariableArray.hud:WaitForChild("Mouse_Release").Modal = false
                    massVariableArray.hud:WaitForChild("Attachment_Frame").Visible =
                        false
                    carbonEvents.clearAttchEvent:FireServer(massVariableArray.curModel.Name)
                    for _, _ in pairs(localPlayer.PlayerGui:GetChildren()) do
                        if _ and _.Name == "Node_UI" then
                            _:Destroy()
                        end
                    end
                    IdleAnim()
                end
            end
            if a.UserInputType == massVariableArray.curConfig.ADSKeybind and Ca and not va and not wa and not ka and not na and not pa then
                Aim(true, true)
            end
            if a.KeyCode == massVariableArray.curConfig.AltADSKey and Ca and not va and not wa and not ka and not na and not pa then
                Aim(true, true)
            end
            if
                a.KeyCode == massVariableArray.curConfig.SprintKey and Ca and not va and userInputService:IsKeyDown(Enum.KeyCode.W) and
                    not userInputService:IsKeyDown(Enum.KeyCode.S) and
                    (carbonConfigs.globalConfig.StaminaEnabled and massVariableArray.Stamina > 0 or not carbonConfigs.globalConfig.StaminaEnabled) and
                    not qa and
                    L and
                    not wa and
                    not ka and
                    not na and
                    not pa
             then
                Sprint(true)
            end
            if a.KeyCode == Enum.KeyCode.KeypadEight and Ca and not va then
                if C then
                    N = "Radial_Top"
                    for _, _ in pairs(massVariableArray.radialInner:GetChildren()) do
                        if _ and _ ~= massVariableArray.radialTop then
                            tweenService:Create(_, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 0, 0)}):Play()
                            tweenService:Create(_, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(34, 34, 34)}):Play()
                        end
                    end
                    tweenService:Create(massVariableArray.radialTop, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 0, -5)}):Play()
                    tweenService:Create(massVariableArray.radialTop, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(135, 175, 97)}):Play()
                end
            end
            if a.KeyCode == Enum.KeyCode.KeypadTwo and Ca and not va then
                if C then
                    N = "Radial_Bottom"
                    for _, _ in pairs(massVariableArray.radialInner:GetChildren()) do
                        if _ and _ ~= massVariableArray.radialBottom then
                            tweenService:Create(_, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 0, 0)}):Play()
                            tweenService:Create(_, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(34, 34, 34)}):Play()
                        end
                    end
                    tweenService:Create(massVariableArray.radialBottom, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 0, 5)}):Play()
                    tweenService:Create(massVariableArray.radialBottom, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(135, 175, 97)}):Play()
                end
            end
            if a.KeyCode == Enum.KeyCode.LeftControl and Ca and not va and not wa then
                if not za then
                    C = not C
                    if C then
                        N = "Radial_Center"
                        tweenService:Create(massVariableArray.radialOutter, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
                        for _, _ in pairs(massVariableArray.radialInner:GetChildren()) do
                            if _ then
                                tweenService:Create(_, TweenInfo.new(0.5), {ImageTransparency = 0}):Play()
                                tweenService:Create(_, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, 0)}):Play()
                                tweenService:Create(_, TweenInfo.new(0.5), {ImageColor3 = Color3.fromRGB(34, 34, 34)}):Play()
                            end
                        end
                        tweenService:Create(massVariableArray.radialCenter, TweenInfo.new(0.5), {ImageColor3 = Color3.fromRGB(135, 175, 97)}):Play(

                        )
                        massVariableArray.radialTop.MouseEnter:Connect(
                            function()
                                N = "Radial_Top"
                                for _, _ in pairs(massVariableArray.radialInner:GetChildren()) do
                                    if _ and _ ~= massVariableArray.radialTop then
                                        tweenService:Create(_, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, 0)}):Play()
                                        tweenService:Create(_, TweenInfo.new(0.5), {ImageColor3 = Color3.fromRGB(34, 34, 34)}):Play(

                                        )
                                    end
                                end
                                tweenService:Create(massVariableArray.radialTop, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, -5)}):Play()
                                tweenService:Create(
                                    massVariableArray.radialTop,
                                    TweenInfo.new(0.5),
                                    {ImageColor3 = Color3.fromRGB(135, 175, 97)}
                                ):Play()
                            end
                        )
                        massVariableArray.radialBottom.MouseEnter:Connect(
                            function()
                                N = "Radial_Bottom"
                                for _, _ in pairs(massVariableArray.radialInner:GetChildren()) do
                                    if _ and _ ~= massVariableArray.radialBottom then
                                        tweenService:Create(_, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, 0)}):Play()
                                        tweenService:Create(_, TweenInfo.new(0.5), {ImageColor3 = Color3.fromRGB(34, 34, 34)}):Play(

                                        )
                                    end
                                end
                                tweenService:Create(massVariableArray.radialBottom, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, 5)}):Play(

                                )
                                tweenService:Create(
                                    massVariableArray.radialBottom,
                                    TweenInfo.new(0.5),
                                    {ImageColor3 = Color3.fromRGB(135, 175, 97)}
                                ):Play()
                            end
                        )
                        massVariableArray.radialCenter.MouseEnter:Connect(
                            function()
                                N = "Radial_Center"
                                for _, _ in pairs(massVariableArray.radialInner:GetChildren()) do
                                    if _ and _ ~= massVariableArray.radialCenter then
                                        tweenService:Create(_, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, 0)}):Play()
                                        tweenService:Create(_, TweenInfo.new(0.5), {ImageColor3 = Color3.fromRGB(34, 34, 34)}):Play(

                                        )
                                    end
                                end
                                tweenService:Create(
                                    massVariableArray.radialCenter,
                                    TweenInfo.new(0.5),
                                    {ImageColor3 = Color3.fromRGB(135, 175, 97)}
                                ):Play()
                            end
                        )
                    else
                        if N == "Radial_Top" then
                            massVariableArray.readyMode = massVariableArray.readyMode + 1
                            if massVariableArray.readyMode > 1 then
                                massVariableArray.readyMode = 1
                            end
                        elseif N == "Radial_Bottom" then
                            massVariableArray.readyMode = massVariableArray.readyMode - 1
                            if massVariableArray.readyMode < -1 then
                                massVariableArray.readyMode = -1
                            end
                        elseif N == "Radial_Center" then
                            massVariableArray.readyMode = 0
                        end
                        ChangeReady()
                        tweenService:Create(massVariableArray.radialOutter, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
                        for _, _ in pairs(massVariableArray.radialInner:GetChildren()) do
                            if _ then
                                tweenService:Create(_, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
                                tweenService:Create(_, TweenInfo.new(0.5), {Position = UDim2.new(0, 0, 0, 0)}):Play()
                                tweenService:Create(_, TweenInfo.new(0.5), {ImageColor3 = Color3.fromRGB(34, 34, 34)}):Play()
                            end
                        end
                    end
                else
                    massVariableArray.aimWalkSpeed = 5
                end
            end
            if a.KeyCode == Enum.KeyCode.LeftAlt then
                x = not x
                if x then
                    tweenService:Create(massVariableArray.sensDisplay, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                else
                    tweenService:Create(massVariableArray.sensDisplay, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
                end
            end
            if a.KeyCode == Enum.KeyCode.A and ya and not userInputService:IsKeyDown(Enum.KeyCode.W) then
                Sprint(false)
            end
            if a.KeyCode == Enum.KeyCode.D and ya and not userInputService:IsKeyDown(Enum.KeyCode.W) then
                Sprint(false)
            end
            if a.KeyCode == Enum.KeyCode.S and ya then
                Sprint(false)
            end
            if a.KeyCode == Enum.KeyCode.A then
                rotation = CFrame.Angles(0, 0, math.rad(-10))
                if userInputService:IsKeyDown(Enum.KeyCode.D) then
                    rotation = CFrame.Angles(0, 0, 0)
                end
            end
            if a.KeyCode == Enum.KeyCode.D then
                rotation = CFrame.Angles(0, 0, math.rad(10))
                if userInputService:IsKeyDown(Enum.KeyCode.A) then
                    rotation = CFrame.Angles(0, 0, 0)
                end
            end
            if
                a.KeyCode == carbonConfigs.globalConfig.GrenadeKey and Ca and not va and carbonConfigs.globalConfig.CanGrenade and not ka and
                    not la and
                    not wa and
                    not ma and
                    not na
             then
                if not userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    if not pa then
                        local _ = false
                        if massVariableArray.NadeMode == 1 then
                            if massVariableArray.FragAmmo > 0 then
                                _ = true
                            end
                        elseif massVariableArray.NadeMode == 2 then
                            if massVariableArray.FlashAmmo > 0 then
                                _ = true
                            end
                        elseif massVariableArray.NadeMode == 3 then
                            if massVariableArray.SmokeAmmo > 0 then
                                _ = true
                            end
                        elseif massVariableArray.NadeMode == 4 then
                            if massVariableArray.C4Ammo > 0 and not V then
                                _ = true
                            end
                        end
                        if _ then
                            _ = false
                            pa = true
                            if za then
                                Aim(false, false)
                            end
                            if ya then
                                Sprint(false, false)
                            end
                            HandleNades()
                        end
                        if V and massVariableArray.NadeMode == 4 then
                            ba = true
                            m = false
                            local _ = V:WaitForChild("CEVARS"):WaitForChild("Hit").Value
                            tweenService:Create(
                                massVariableArray.LAW,
                                TweenInfo.new(0.2),
                                {
                                    C1 = CFrame.new(
                                        0.922277689,
                                        -0.817099452,
                                        -1.92854667,
                                        0.106011063,
                                        -0.34216994,
                                        0.933638692,
                                        -0.994363368,
                                        -0.0348279029,
                                        0.100141913,
                                        -0.00174888968,
                                        -0.938992321,
                                        -0.343933403
                                    )
                                }
                            ):Play()
                            task.wait(0.2)
                            local a = carbonFx:WaitForChild("Phone"):clone()
                            a.Parent = massVariableArray.LA
                            for _, _ in pairs(a:GetChildren()) do
                                if _ and _:IsA("BasePart") then
                                    if _.Name ~= "Grip" then
                                        carbonConfigs.utilitiesModule.Weld(_, a:WaitForChild("Grip"))
                                    elseif _.Name == "Grip" then
                                        carbonConfigs.utilitiesModule.Weld(
                                            _,
                                            massVariableArray.LA,
                                            nil,
                                            CFrame.new(
                                                0.800000012,
                                                -1.20000005,
                                                -0.200000003,
                                                -0.984807611,
                                                -0.122787781,
                                                -0.122787826,
                                                0.171010077,
                                                -0.562996984,
                                                -0.808572829,
                                                0.0301536843,
                                                -0.81728667,
                                                0.575441837
                                            )
                                        )
                                    end
                                end
                            end
                            for _, _ in pairs(a:GetChildren()) do
                                if _ and _:IsA("BasePart") then
                                    _.Anchored = false
                                end
                            end
                            tweenService:Create(
                                massVariableArray.LAW,
                                TweenInfo.new(0.4),
                                {
                                    C1 = CFrame.new(
                                        1.77068973,
                                        0.727490902,
                                        -1.72761703,
                                        0.999606609,
                                        -0.00972421467,
                                        -0.026306361,
                                        0.0211262405,
                                        -0.355849683,
                                        0.934304237,
                                        -0.0184465349,
                                        -0.934492409,
                                        -0.355504274
                                    )
                                }
                            ):Play()
                            task.wait(0.4)
                            a:WaitForChild("Grip"):WaitForChild("Dial"):Play()
                            tweenService:Create(
                                massVariableArray.LAW,
                                TweenInfo.new(0.4),
                                {
                                    C1 = CFrame.new(
                                        1.77068973,
                                        0.827490926,
                                        -1.82761705,
                                        0.999606609,
                                        -0.00972421467,
                                        -0.026306361,
                                        0.0211262405,
                                        -0.355849683,
                                        0.934304237,
                                        -0.0184465349,
                                        -0.934492409,
                                        -0.355504274
                                    )
                                }
                            ):Play()
                            task.wait(0.35)
                            carbonEvents.explosiveEvent:FireServer(
                                _,
                                V:WaitForChild("Grip").Position,
                                carbonConfigs.globalConfig.C4BlastPressue,
                                carbonConfigs.globalConfig.C4BlastRadius,
                                carbonConfigs.globalConfig.C4DestroyJointRadius,
                                carbonConfigs.globalConfig.C4ExplosionType,
                                carbonConfigs.globalConfig.C4DeletePart,
                                V,
                                nil,
                                nil,
                                nil,
                                nil,
                                "Auth",
                                nil
                            )
                            V = nil
                            tweenService:Create(
                                massVariableArray.LAW,
                                TweenInfo.new(0.4),
                                {
                                    C1 = CFrame.new(
                                        -0.929310441,
                                        0.169468522,
                                        -2.74091005,
                                        -0.0636699349,
                                        -0.4868218,
                                        0.871177673,
                                        -0.822815955,
                                        0.519590497,
                                        0.230216295,
                                        -0.564730048,
                                        -0.702160895,
                                        -0.433647156
                                    )
                                }
                            ):Play()
                            task.wait(0.4)
                            a:Destroy()
                            m = true
                            IdleAnim()
                            ba = false
                        end
                    else
                        if massVariableArray.NadeMode == 4 and not ba then
                            ba = true
                            if not V then
                                tweenService:Create(
                                    massVariableArray.LAW,
                                    TweenInfo.new(0.2),
                                    {
                                        C1 = CFrame.new(
                                            -0.929310441,
                                            0.169468522,
                                            -2.74091005,
                                            -0.0636699349,
                                            -0.4868218,
                                            0.871177673,
                                            -0.822815955,
                                            0.519590497,
                                            0.230216295,
                                            -0.564730048,
                                            -0.702160895,
                                            -0.433647156
                                        )
                                    }
                                ):Play()
                                task.wait(0.2)
                                if Z then
                                    Z:Destroy()
                                end
                                g = false
                                IdleAnim()
                                pa = false
                                ba = false
                            end
                        end
                    end
                else
                    while true do
                        massVariableArray.NadeMode = massVariableArray.NadeMode + 1
                        if massVariableArray.NadeMode > 4 then
                            massVariableArray.NadeMode = 1
                        end
                        if massVariableArray.NadeMode == 1 then
                            if massVariableArray.FragAmmo > 0 then
                                break
                            end
                        end
                        if massVariableArray.NadeMode == 2 then
                            if massVariableArray.FlashAmmo > 0 then
                                break
                            end
                        end
                        if massVariableArray.NadeMode == 3 then
                            if massVariableArray.SmokeAmmo > 0 then
                                break
                            end
                        end
                        if massVariableArray.NadeMode == 4 then
                            if massVariableArray.C4Ammo > 0 then
                                break
                            end
                        end
                        task.wait()
                    end
                end
            end
            if
                a.KeyCode == carbonConfigs.globalConfig.KnifeKey and Ca and not va and carbonConfigs.globalConfig.CanKnife and not za and
                    not ya and
                    not pa and
                    not la and
                    not wa and
                    not ma and
                    not ka and
                    not na
             then
                ka = true
                if za then
                    Aim(false, false)
                end
                if ya then
                    Sprint(false, false)
                end
                local a = carbonFx:WaitForChild("Melee"):clone()
                a.Parent = massVariableArray.LA
                for _, _ in pairs(a:GetChildren()) do
                    if _ and _:IsA("BasePart") then
                        if _.Name ~= "Grip" then
                            carbonConfigs.utilitiesModule.Weld(_, a:WaitForChild("Grip"))
                        elseif _.Name == "Grip" then
                            carbonConfigs.utilitiesModule.Weld(
                                _,
                                massVariableArray.LA,
                                nil,
                                CFrame.new(
                                    0.5,
                                    -1.20000005,
                                    0.200000048,
                                    1,
                                    0,
                                    -5.56362707e-08,
                                    -5.56362707e-08,
                                    1.19248798e-08,
                                    -1,
                                    6.63455867e-16,
                                    0.99999994,
                                    1.19248806e-08
                                )
                            )
                        end
                    end
                end
                for _, _ in pairs(a:GetChildren()) do
                    if _ and _:IsA("BasePart") then
                        _.Anchored = false
                    end
                end
                tweenService:Create(
                    massVariableArray.LAW,
                    TweenInfo.new(0.2),
                    {
                        C1 = CFrame.new(
                            -0.94551754,
                            1.38951778,
                            -1.88849282,
                            0.561318159,
                            -0.82712543,
                            0.0280241668,
                            0.203741312,
                            0.170927659,
                            0.963988125,
                            -0.802129269,
                            -0.535394371,
                            0.264464438
                        )
                    }
                ):Play()
                tweenService:Create(
                    massVariableArray.RAW,
                    TweenInfo.new(0.2),
                    {
                        C1 = CFrame.new(
                            -1.43314123,
                            -1.48713386,
                            -1.55439997,
                            0.99999994,
                            0,
                            0,
                            0,
                            -0.939692616,
                            0.342020065,
                            0,
                            -0.342020065,
                            -0.939692616
                        )
                    }
                ):Play()
                task.wait(0.2)
                local _ = carbonFx:WaitForChild("KnifeJab"):clone()
                _.Parent = localPlayer.PlayerGui
                _:Play()
                game.Debris:AddItem(_, _.TimeLength)
                tweenService:Create(
                    massVariableArray.LAW,
                    TweenInfo.new(0.1),
                    {
                        C1 = CFrame.new(
                            -1.54551756,
                            0.589517653,
                            -1.88849282,
                            0.493761629,
                            -0.859933972,
                            -0.129278481,
                            -0.754563808,
                            -0.497579277,
                            0.427841365,
                            -0.432241678,
                            -0.113702744,
                            -0.894560635
                        )
                    }
                ):Play()
                coroutine.resume(
                    coroutine.create(
                        function()
                            while a:FindFirstChild("Grip") do
                                local a, _, _ =
                                    workspace:FindPartOnRayWithIgnoreList(
                                    Ray.new(
                                        a:WaitForChild("Grip").Position,
                                        a:WaitForChild("Grip").CFrame.upVector * 2
                                    ),
                                    componentCollection
                                )
                                if a then
                                    local _, a = carbonConfigs.utilitiesModule.CheckForHumanoid(a)
                                    if _ and a then
                                        local _ = carbonFx:WaitForChild("KnifeCut"):clone()
                                        _.Parent = localPlayer.PlayerGui
                                        _:Play()
                                        game.Debris:AddItem(_, _.TimeLength)
                                        carbonEvents.createOwnerEvent:FireServer(
                                            a,
                                            nil,
                                            nil,
                                            nil,
                                            nil,
                                            nil,
                                            nil,
                                            nil,
                                            "Auth"
                                        )
                                        carbonEvents.damageEvent:FireServer(
                                            a,
                                            100,
                                            nil,
                                            {"nil", "Auth", "nil", "nil"}
                                        )
                                    end
                                    break
                                end
                                renderLoop:Wait()
                            end
                        end
                    )
                )
                task.wait(0.1)
                IdleAnim()
                a:Destroy()
                ka = false
            end
            if
                a.KeyCode == carbonConfigs.globalConfig.BinoKey and Ca and not va and not pa and not la and not wa and not ma and
                    not ka and
                    not pa and
                    not i
             then
                na = not na
                HandleBino()
            end
            if
                a.KeyCode == carbonConfigs.globalConfig.GLKey and Ca and not va and not pa and not la and not wa and
                    massVariableArray.curConfig.ExplosiveEnabled and
                    not pa and
                    not fa
             then
                ja = not ja
                if ja then
                    Aa = massVariableArray.CanShoot
                    if massVariableArray.ExplosiveAmmo > 0 and not G then
                        massVariableArray.CanShoot = true
                    else
                        massVariableArray.CanShoot = false
                    end
                    local _ =
                        localPlayer.PlayerGui:FindFirstChild("NadeSound") or
                        Instance.new("Sound")
                    _.Parent = localPlayer.PlayerGui
                    _.SoundId = "rbxassetid://" .. aimInSounds[math.random(1, #aimInSounds)]
                    _:Play()
                    _.Name = "NadeSound"
                    tweenService:Create(massVariableArray.LAW, TweenInfo.new(0.3), {C1 = massVariableArray.curConfig.GLLeftPos}):Play()
                    UpdateAmmo()
                else
                    massVariableArray.CanShoot = Aa
                    local _ =
                        localPlayer.PlayerGui:FindFirstChild("NadeSound") or
                        Instance.new("Sound")
                    _.Parent = localPlayer.PlayerGui
                    _.SoundId = "rbxassetid://" .. aimOutSounds[math.random(1, #aimOutSounds)]
                    _:Play()
                    _.Name = "NadeSound"
                    tweenService:Create(massVariableArray.LAW, TweenInfo.new(0.3), {C1 = massVariableArray.curConfig.LeftArmPos}):Play()
                    UpdateAmmo()
                end
            end
            if
                a.KeyCode == carbonConfigs.globalConfig.HealKey and Ca and not va and not pa and not la and not wa and k and not ka and
                    not na
             then
                wa = true
                k = false
                local a = carbonFx:WaitForChild("Syringe"):clone()
                a.Parent = massVariableArray.LA
                tweenService:Create(
                    massVariableArray.LAW,
                    TweenInfo.new(0.4),
                    {
                        C1 = CFrame.new(
                            0.554482341,
                            -1.31048226,
                            -2.38849282,
                            -0.154961348,
                            -0.339524895,
                            0.927744389,
                            -0.987918973,
                            0.0549189299,
                            -0.144913793,
                            -0.00174888968,
                            -0.938992321,
                            -0.343933403
                        )
                    }
                ):Play()
                task.wait(0.4)
                for _, _ in pairs(a:GetChildren()) do
                    if _ and _:IsA("BasePart") then
                        if _.Name ~= "Glass" then
                            carbonConfigs.utilitiesModule.Weld(_, a:WaitForChild("Glass"))
                        elseif _.Name == "Glass" then
                            carbonConfigs.utilitiesModule.Weld(
                                _,
                                massVariableArray.LA,
                                nil,
                                CFrame.new(
                                    0.5,
                                    -1.20000005,
                                    0.199999988,
                                    1.19248806e-08,
                                    0,
                                    1,
                                    0,
                                    1,
                                    0,
                                    -1,
                                    0,
                                    1.19248806e-08
                                )
                            )
                        end
                    end
                end
                for _, _ in pairs(a:GetChildren()) do
                    if _ and _:IsA("BasePart") then
                        _.Anchored = false
                    end
                end
                tweenService:Create(
                    massVariableArray.LAW,
                    TweenInfo.new(0.4),
                    {
                        C1 = CFrame.new(
                            2.65448236,
                            -1.21048236,
                            1.91150701,
                            0.0297531113,
                            0.786976993,
                            0.616264343,
                            -0.930818856,
                            -0.202869564,
                            0.304006517,
                            0.364267558,
                            -0.582675636,
                            0.726497054
                        )
                    }
                ):Play()
                task.wait(0.24)
                local _ = carbonFx:WaitForChild("SyringeIn"):Clone()
                _.Parent = localPlayer.PlayerGui
                _:Play()
                game.Debris:AddItem(_, _.TimeLength)
                tweenService:Create(
                    massVariableArray.LAW,
                    TweenInfo.new(0.28),
                    {
                        C1 = CFrame.new(
                            2.65448236,
                            -1.21048236,
                            0.815154314,
                            0.0297531113,
                            0.786976993,
                            0.616264343,
                            -0.930818856,
                            -0.202869564,
                            0.304006517,
                            0.364267558,
                            -0.582675636,
                            0.726497054
                        )
                    }
                ):Play()
                massVariableArray.painShade.Visible = true
                tweenService:Create(massVariableArray.painShade, TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
                delay(
                    0.7,
                    function()
                        tweenService:Create(massVariableArray.painShade, TweenInfo.new(3), {ImageTransparency = 1}):Play()
                    end
                )
                task.wait(0.35)
                tweenService:Create(
                    a:WaitForChild("Push"):WaitForChild("Push"),
                    TweenInfo.new(0.3),
                    {C1 = CFrame.new(-0.65829581, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)}
                ):Play()
                tweenService:Create(
                    a:WaitForChild("Liquid"):WaitForChild("Liquid"),
                    TweenInfo.new(0.3),
                    {C1 = CFrame.new(-0.64000386, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)}
                ):Play()
                task.wait(0.5)
                carbonEvents.medEvent:FireServer(true, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Auth")
                a:WaitForChild("Liquid").Transparency = 1
                IdleAnim()
                a:Destroy()
                wa = false
            end
            if
                a.KeyCode == massVariableArray.curConfig.LaserKey and not wa and Ca and massVariableArray.curModel and
                    massVariableArray.curModel:FindFirstChild("LaserLight") and
                    massVariableArray.curConfig.LaserAttached
             then
                O = not O
                carbonEvents.manipEvent:FireServer(
                    O,
                    "Laser",
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    nil,
                    "Auth"
                )
                Y = Instance.new("Part")
                Y.Shape = "Ball"
                Y.Size = Vector3.new(0.1, 0.1, 0.1)
                Y.Parent = currentCamera
                Y.CanCollide = false
                Y.BrickColor = massVariableArray.curConfig.LaserColor
                Y.Material = Enum.Material.Neon
                if O then
                    E = Instance.new("Attachment")
                    E.Parent = massVariableArray.curModel.LaserLight
                    M = Instance.new("Attachment")
                    M.Parent = massVariableArray.curModel.LaserLight
                    aa = Instance.new("Beam")
                    aa.Parent = massVariableArray.curModel.LaserLight
                    aa.Attachment0 = E
                    aa.Attachment1 = M
                    aa.Color = ColorSequence.new(massVariableArray.curConfig.LaserColor.Color)
                    aa.LightEmission = massVariableArray.curConfig.LaserEmission
                    aa.LightInfluence = massVariableArray.curConfig.LaserInfluence
                    aa.Transparency = massVariableArray.curConfig.LaserTransparency
                    aa.FaceCamera = true
                    aa.Width0 = 0.01
                    aa.Width1 = 0.01
                    if
                        playerCharacter:WaitForChild("CarbonValues"):WaitForChild(
                            "NVGActive"
                        ).Value == true and
                            massVariableArray.curModel:FindFirstChild("AimPart3") and
                            massVariableArray.CurAimPart ~= massVariableArray.curModel.AimPart3
                     then
                        massVariableArray.CurAimPart = massVariableArray.curModel.AimPart3
                        massVariableArray.curZoom = 60
                        if za then
                            tweenService:Create(
                                currentCamera,
                                TweenInfo.new(massVariableArray.curConfig.AimZoomSpeed, Enum.EasingStyle.Quad),
                                {FieldOfView = 60}
                            ):Play()
                        end
                    end
                else
                    massVariableArray.CurAimPart = massVariableArray.lastAimPart
                    if massVariableArray.CurAimPart.Name == "AimPart" then
                        if not ia then
                            massVariableArray.curZoom = massVariableArray.curConfig.AimZoom
                        else
                            massVariableArray.curZoom = P
                        end
                    elseif massVariableArray.CurAimPart.Name == "AimPart2" then
                        if not ia then
                            massVariableArray.curZoom = massVariableArray.curConfig.AltAimZoom
                        else
                            massVariableArray.curZoom = R
                        end
                    end
                    E:Destroy()
                    M:Destroy()
                    aa:Destroy()
                    Y:Destroy()
                end
            end
            if
                a.KeyCode == massVariableArray.curConfig.LightKey and not wa and massVariableArray.curConfig.LightAttached and
                    massVariableArray.curModel:FindFirstChild("FlashLight")
             then
                A = not A
                for _, _ in pairs(massVariableArray.curModel:WaitForChild("FlashLight"):GetChildren()) do
                    if _ and _.Name == "Enable" then
                        _.Enabled = A
                    end
                end
                if carbonConfigs.globalConfig.ReplicatedFlashlight then
                    carbonEvents.manipEvent:FireServer(
                        A,
                        "FlashLight",
                        nil,
                        nil,
                        nil,
                        nil,
                        nil,
                        nil,
                        nil,
                        "Auth"
                    )
                end
            end
            if
                a.KeyCode == massVariableArray.curConfig.BoltKey and not ea and Ca and not va and not pa and not ma and not ka and
                    not wa and
                    not na and
                    massVariableArray.FireMode ~= 6
             then
                ea = true
                la = not la
                if la then
                    BoltBackAnim()
                    if ta and massVariableArray.Ammo > 0 then
                        CreateShell()
                    end
                    ea = false
                else
                    if massVariableArray.Ammo > 0 then
                        massVariableArray.CanShoot = true
                        Aa = true
                        if ta then
                            massVariableArray.Ammo = massVariableArray.Ammo - 1
                        end
                        ta = true
                    end
                    BoltForwardAnim()
                    IdleAnim()
                    ea = false
                end
                UpdateAmmo()
            end
            if
                a.KeyCode == massVariableArray.curConfig.PatrolKey and not wa and massVariableArray.curConfig and not ka and not na and not pa and
                    not wa
             then
                oa = not oa
                if oa then
                    if za then
                        Aim(false, true)
                    end
                    if ya then
                        Sprint(false)
                    end
                    if da then
                        massVariableArray.readyMode = 0
                        ChangeReady()
                    end
                    tweenService:Create(
                        massVariableArray.AnimBaseW,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                        {
                            C1 = CFrame.new(
                                0.277981758,
                                0.244040087,
                                -0.174667343,
                                0.642787635,
                                -0.383022219,
                                0.663413942,
                                0.133022055,
                                0.908677936,
                                0.395739198,
                                -0.754406512,
                                -0.166127577,
                                0.635037363
                            )
                        }
                    ):Play()
                    carbonEvents.updateCharEvent:FireServer("Patrol", true, "Auth")
                    W = true
                    task.wait(0.5)
                else
                    carbonEvents.updateCharEvent:FireServer("Patrol", false, "Auth")
                    W = false
                end
            end
            if
                a.KeyCode == massVariableArray.curConfig.CycleSightKey and not wa and Ca and
                    not (playerCharacter:WaitForChild("CarbonValues"):WaitForChild(
                        "NVGActive"
                    ).Value == true and O)
             then
                if massVariableArray.curModel:FindFirstChild("AimPart2") then
                    Q = not Q
                    if Q then
                        massVariableArray.CurAimPart = massVariableArray.curModel:FindFirstChild("AimPart2")
                        massVariableArray.lastAimPart = massVariableArray.CurAimPart
                        massVariableArray.AimPart2 = massVariableArray.curModel:FindFirstChild("AimPart2")
                        if not ia then
                            massVariableArray.curZoom = massVariableArray.curConfig.AltAimZoom
                        else
                            massVariableArray.curZoom = R
                        end
                        if massVariableArray.curModel:FindFirstChild("Magni") then
                            tweenService:Create(
                                massVariableArray.LAW,
                                TweenInfo.new(0.3),
                                {
                                    C1 = CFrame.new(
                                        -0.705815077,
                                        0.0854935497,
                                        -1.11203301,
                                        0.241317719,
                                        -0.917439699,
                                        -0.316338271,
                                        -0.742582142,
                                        -0.384429187,
                                        0.548439324,
                                        -0.624769866,
                                        0.10255906,
                                        -0.774044037
                                    )
                                }
                            ):Play()
                            task.wait(0.3)
                            tweenService:Create(
                                massVariableArray.curModel.Magni.Magni,
                                TweenInfo.new(0.3),
                                {
                                    C1 = CFrame.new(
                                        0,
                                        0.00943283178,
                                        0,
                                        -0.02264525,
                                        -0.999743462,
                                        0,
                                        0.999743462,
                                        -0.02264525,
                                        0,
                                        0,
                                        0,
                                        1
                                    )
                                }
                            ):Play()
                            tweenService:Create(
                                massVariableArray.LAW,
                                TweenInfo.new(0.3),
                                {
                                    C1 = CFrame.new(
                                        -0.502888203,
                                        -0.153193533,
                                        -1.3043437,
                                        0.241317719,
                                        -0.917439699,
                                        -0.316338271,
                                        -0.742582142,
                                        -0.384429187,
                                        0.548439324,
                                        -0.624769866,
                                        0.10255906,
                                        -0.774044037
                                    )
                                }
                            ):Play()
                            task.wait(0.3)
                            IdleAnim()
                            if za then
                                Aim(true, false)
                            end
                        else
                            if za then
                                Aim(true, false)
                            end
                        end
                    else
                        massVariableArray.CurAimPart = massVariableArray.AimPart
                        massVariableArray.lastAimPart = massVariableArray.CurAimPart
                        if not ia then
                            massVariableArray.curZoom = massVariableArray.curConfig.AimZoom
                        else
                            massVariableArray.curZoom = P
                        end
                        if za then
                            Aim(true, false)
                        end
                        if massVariableArray.curModel:FindFirstChild("Magni") then
                            tweenService:Create(
                                massVariableArray.LAW,
                                TweenInfo.new(0.3),
                                {
                                    C1 = CFrame.new(
                                        -0.502888203,
                                        -0.153193533,
                                        -1.3043437,
                                        0.241317719,
                                        -0.917439699,
                                        -0.316338271,
                                        -0.742582142,
                                        -0.384429187,
                                        0.548439324,
                                        -0.624769866,
                                        0.10255906,
                                        -0.774044037
                                    )
                                }
                            ):Play()
                            task.wait(0.3)
                            tweenService:Create(massVariableArray.curModel.Magni.Magni, TweenInfo.new(0.3), {C1 = CFrame.new()}):Play()
                            tweenService:Create(
                                massVariableArray.LAW,
                                TweenInfo.new(0.3),
                                {
                                    C1 = CFrame.new(
                                        -0.705815077,
                                        0.0854935497,
                                        -1.11203301,
                                        0.241317719,
                                        -0.917439699,
                                        -0.316338271,
                                        -0.742582142,
                                        -0.384429187,
                                        0.548439324,
                                        -0.624769866,
                                        0.10255906,
                                        -0.774044037
                                    )
                                }
                            ):Play()
                            task.wait(0.3)
                            IdleAnim()
                        else
                            if za then
                                Aim(true, false)
                            end
                        end
                    end
                end
            end
            if a.KeyCode == Enum.KeyCode.Q and massVariableArray.StanceIndex ~= 2 and not massVariableArray.Seated then
                if carbonConfigs.globalConfig.ToggleableLeaning then
                    if recoilData.dirPeek ~= 1 then
                        recoilData.dirPeek = 1
                    else
                        recoilData.dirPeek = 0
                    end
                else
                    recoilData.dirPeek = 1
                end
                Lean()
            end
            if a.KeyCode == Enum.KeyCode.E and massVariableArray.StanceIndex ~= 2 and not massVariableArray.Seated then
                if carbonConfigs.globalConfig.ToggleableLeaning then
                    if recoilData.dirPeek ~= -1 then
                        recoilData.dirPeek = -1
                    else
                        recoilData.dirPeek = 0
                    end
                else
                    recoilData.dirPeek = -1
                end
                Lean()
            end
            if a.KeyCode == massVariableArray.curConfig.ReloadKey and not wa and Ca and not ma and not Shooting and not ya and not la then
                local _ = currentCamera.FieldOfView
                if currentCamera.FieldOfView ~= 70 then
                    tweenService:Create(currentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = 70}):Play()
                end
                if not ja and massVariableArray.Ammo < massVariableArray.curConfig.Ammo then
                    Aa = massVariableArray.CanShoot
                    massVariableArray.CanShoot = false
                    if massVariableArray.Ammo > 0 then
                        ta = true
                        Aa = true
                    else
                        ta = false
                        Aa = false
                    end
                    if massVariableArray.StoredAmmo > 0 and massVariableArray.Ammo < massVariableArray.curConfig.Ammo then
                        Shooting = false
                        ma = true
                        ReloadAnim()
                        if massVariableArray.curConfig.CanAutoBolt then
                            if massVariableArray.Ammo <= 0 then
                                if not massVariableArray.curConfig.CanSlideLock then
                                    BoltBackAnim()
                                    BoltForwardAnim()
                                end
                            elseif massVariableArray.Ammo > 0 then
                                if not massVariableArray.curConfig.CanSlideLock then
                                    if massVariableArray.BoltW.C1 ~= (CFrame.new() or CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)) then
                                        BoltBackAnim()
                                        BoltForwardAnim()
                                    end
                                end
                            end
                        end
                        IdleAnim()
                        if massVariableArray.Ammo <= 0 then
                            if (massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)) < 0 then
                                massVariableArray.Ammo = massVariableArray.Ammo + massVariableArray.StoredAmmo
                                massVariableArray.StoredAmmo = 0
                            else
                                massVariableArray.StoredAmmo = massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)
                                massVariableArray.Ammo = massVariableArray.curConfig.Ammo
                            end
                        elseif massVariableArray.Ammo > 0 then
                            if (massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)) < 0 then
                                massVariableArray.Ammo = massVariableArray.Ammo + massVariableArray.StoredAmmo + 1
                                massVariableArray.StoredAmmo = 0
                            else
                                massVariableArray.StoredAmmo = massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)
                                massVariableArray.Ammo = massVariableArray.curConfig.Ammo + 1
                            end
                        end
                        ma = false
                        if massVariableArray.curConfig.CanAutoBolt or ta or massVariableArray.curConfig.CanSlideLock or massVariableArray.FireMode == 6 then
                            massVariableArray.CanShoot = true
                            Aa = true
                        end
                    end
                elseif ja then
                    if massVariableArray.ExplosiveAmmo > 0 then
                        Shooting = false
                        ma = true
                        nadeReload()
                        if not ja then
                            IdleAnim()
                        else
                            tweenService:Create(
                                massVariableArray.RAW,
                                TweenInfo.new(0.25, Enum.EasingStyle.Quad),
                                {C1 = massVariableArray.curConfig.RightArmPos}
                            ):Play()
                            tweenService:Create(massVariableArray.LAW, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {C1 = massVariableArray.curConfig.GLLeftPos}):Play(

                            )
                            task.wait(0.25)
                        end
                        ma = false
                        massVariableArray.CanShoot = true
                        G = false
                    end
                end
                UpdateAmmo()
                if _ ~= 70 and za then
                    tweenService:Create(currentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = _}):Play()
                end
            end
            if
                Ca and a.KeyCode == massVariableArray.curConfig.FireSelectKey and not wa and not T and not fa and
                    massVariableArray.curConfig.CanSelectFire and
                    not ja and
                    not la and
                    not pa and
                    not wa and
                    not ka and
                    not da
             then
                W = true
                T = true
                ja = false
                if Shooting then
                    Shooting = false
                end
                SelectFireMode()
                FireModeAnim()
                IdleAnim()
                T = false
            end
            W = false
        end
        if not _ then
            if a.KeyCode == carbonConfigs.globalConfig.NVGKey and carbonConfigs.globalConfig.NVGEnabled then
                z = not z
                HandleToggle()
            end
        end
    end
)
userInputService.InputBegan:connect(
    function(a, _)
        if not _ then
            if Ca or carbonConfigs.globalConfig.UniversalStances and not oa and not massVariableArray.Seated then
                if a.KeyCode == Enum.KeyCode.C and not massVariableArray.Seated then
                    ya = false
                    if massVariableArray.StanceIndex == 0 then
                        massVariableArray.StanceIndex = 1
                        changeStance()
                    elseif massVariableArray.StanceIndex == 1 then
                        massVariableArray.StanceIndex = 2
                        changeStance()
                    elseif massVariableArray.StanceIndex == 2 then
                        massVariableArray.StanceIndex = 1
                        changeStance()
                    end
                end
                if a.KeyCode == Enum.KeyCode.X and not massVariableArray.Seated then
                    ya = false
                    if massVariableArray.StanceIndex == 0 then
                        massVariableArray.StanceIndex = 1
                        changeStance()
                    elseif massVariableArray.StanceIndex == 1 then
                        massVariableArray.StanceIndex = 0
                        changeStance()
                    elseif massVariableArray.StanceIndex == 2 then
                        massVariableArray.StanceIndex = 1
                        changeStance()
                    end
                end
            end
        end
    end
)
userInputService.InputBegan:connect(
    function(a, _)
        if not _ then
            if Ca or carbonConfigs.globalConfig.UniversalStances and not oa and not massVariableArray.Seated then
                if a.KeyCode == Enum.KeyCode.ButtonB and not massVariableArray.Seated then
                    ya = false
                    if massVariableArray.StanceIndex == 0 then
                        massVariableArray.StanceIndex = 1
                        changeStance()
                    elseif massVariableArray.StanceIndex == 1 then
                        massVariableArray.StanceIndex = 2
                        changeStance()
                    elseif massVariableArray.StanceIndex == 2 then
                        massVariableArray.StanceIndex = 1
                        changeStance()
                    end
                    delay(
                        0.3,
                        function()
                            if userInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonB) then
                                ya = false
                                massVariableArray.StanceIndex = 0
                                changeStance()
                            end
                        end
                    )
                end
            end
        end
    end
)
userInputService.InputEnded:connect(
    function(a, _)
        if not _ and Ca and massVariableArray.curConfig then
            if a.UserInputType == massVariableArray.curConfig.ShootKeybind then
                massVariableArray.MouseHeld = false
            end
            if a.UserInputType == massVariableArray.curConfig.ADSKeybind and not ya then
                Aim(false, true)
            end
            if a.KeyCode == massVariableArray.curConfig.AltADSKey and not ya then
                Aim(false, true)
            end
            if a.KeyCode == massVariableArray.curConfig.SprintKey and Ca and not va and not qa and not za and not oa and not da then
                Sprint(false)
            end
            if
                a.KeyCode == Enum.KeyCode.Q and massVariableArray.StanceIndex ~= 2 and not massVariableArray.Seated and
                    not carbonConfigs.globalConfig.ToggleableLeaning
             then
                recoilData.dirPeek = 0
                Lean()
            end
            if
                a.KeyCode == Enum.KeyCode.E and massVariableArray.StanceIndex ~= 2 and not massVariableArray.Seated and
                    not carbonConfigs.globalConfig.ToggleableLeaning
             then
                recoilData.dirPeek = 0
                Lean()
            end
            if a.KeyCode == Enum.KeyCode.LeftControl and za then
                massVariableArray.aimWalkSpeed = 9
            end
            if a.KeyCode == Enum.KeyCode.A then
                if userInputService:IsKeyDown(Enum.KeyCode.A) then
                    rotation = CFrame.Angles(0, 0, math.rad(-10))
                elseif userInputService:IsKeyDown(Enum.KeyCode.D) then
                    rotation = CFrame.Angles(0, 0, math.rad(10))
                else
                    rotation = CFrame.Angles(0, 0, 0)
                end
            end
            if a.KeyCode == Enum.KeyCode.D then
                if userInputService:IsKeyDown(Enum.KeyCode.A) then
                    rotation = CFrame.Angles(0, 0, math.rad(-10))
                elseif userInputService:IsKeyDown(Enum.KeyCode.D) then
                    rotation = CFrame.Angles(0, 0, math.rad(10))
                else
                    rotation = CFrame.Angles(0, 0, 0)
                end
            end
            if a.KeyCode == Enum.KeyCode.W and ya then
                Sprint(false)
            end
        end
    end
)
userInputService.InputChanged:connect(
    function(a, _)
        if not _ and Ca then
            if a.UserInputType == Enum.UserInputType.MouseWheel then
                if not ka and not na and not wa and not x then
                    if za then
                        if a.Position.Z == 1 then
                            massVariableArray.aimSens = massVariableArray.aimSens + 0.1
                            if massVariableArray.aimSens > 1 then
                                massVariableArray.aimSens = 1
                            end
                            massVariableArray.aimSens = massVariableArray.aimSens
                        elseif a.Position.Z == -1 then
                            massVariableArray.aimSens = massVariableArray.aimSens - 0.1
                            if massVariableArray.aimSens < 0.1 then
                                massVariableArray.aimSens = 0.1
                            end
                            massVariableArray.aimSens = massVariableArray.aimSens
                        end
                    else
                        if a.Position.Z == 1 then
                            massVariableArray.baseSens = massVariableArray.baseSens + 0.1
                            if massVariableArray.baseSens > 1 then
                                massVariableArray.baseSens = 1
                            end
                            e.Value = massVariableArray.baseSens
                        elseif a.Position.Z == -1 then
                            massVariableArray.baseSens = massVariableArray.baseSens - 0.1
                            if massVariableArray.baseSens < 0.1 then
                                massVariableArray.baseSens = 0.1
                            end
                            e.Value = massVariableArray.baseSens
                        end
                    end
                end
            end
        end
        if a.UserInputType == Enum.UserInputType.MouseMovement then
            mathVariables.desiredXOffset = math.min(math.max(a.Delta.x, -mathVariables.swayInputLimit), mathVariables.swayInputLimit)
            mathVariables.desiredYOffset = math.min(math.max(a.Delta.y, -mathVariables.swayInputLimit), mathVariables.swayInputLimit)
        end
    end
)
userInputService.InputBegan:connect(
    function(a, _)
        if not _ and Ca then
            if a.KeyCode == Enum.KeyCode.ButtonL2 and Ca and not va and not wa then
                Aim(true, true)
            end
            if a.KeyCode == Enum.KeyCode.ButtonL3 and Ca and not va and L and not qa and not wa then
                Sprint(true)
            end
            if a.KeyCode == Enum.KeyCode.ButtonR2 and Ca and not va and not wa then
                massVariableArray.MouseHeld = true
                if massVariableArray.Ammo > 0 then
                    Shoot()
                end
                if massVariableArray.Ammo <= 0 or not massVariableArray.CanShoot then
                    massVariableArray.Grip:WaitForChild("Click"):Play()
                end
            end
            if
                a.KeyCode == Enum.KeyCode.ButtonX and Ca and not va and not ma and not Shooting and not ya and
                    massVariableArray.Ammo < massVariableArray.curConfig.Ammo
             then
                local _ = currentCamera.FieldOfView
                if currentCamera.FieldOfView ~= 70 then
                    tweenService:Create(currentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = 70}):Play()
                end
                Aa = massVariableArray.CanShoot
                massVariableArray.CanShoot = false
                if massVariableArray.Ammo > 0 then
                    ta = true
                    Aa = true
                else
                    ta = false
                    Aa = false
                end
                if massVariableArray.StoredAmmo > 0 and massVariableArray.Ammo < massVariableArray.curConfig.Ammo then
                    Shooting = false
                    ma = true
                    ReloadAnim()
                    if massVariableArray.curConfig.CanAutoBolt then
                        if massVariableArray.Ammo <= 0 then
                            if not massVariableArray.curConfig.CanSlideLock then
                                BoltBackAnim()
                                BoltForwardAnim()
                            end
                        elseif massVariableArray.Ammo > 0 then
                            if not massVariableArray.curConfig.CanSlideLock then
                                if massVariableArray.BoltW.C1 ~= (CFrame.new() or CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)) then
                                    BoltBackAnim()
                                    BoltForwardAnim()
                                end
                            end
                        end
                    end
                    IdleAnim()
                    if massVariableArray.Ammo <= 0 then
                        if (massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)) < 0 then
                            massVariableArray.Ammo = massVariableArray.Ammo + massVariableArray.StoredAmmo
                            massVariableArray.StoredAmmo = 0
                        else
                            massVariableArray.StoredAmmo = massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)
                            massVariableArray.Ammo = massVariableArray.curConfig.Ammo
                        end
                    elseif massVariableArray.Ammo > 0 then
                        if (massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)) < 0 then
                            massVariableArray.Ammo = massVariableArray.Ammo + massVariableArray.StoredAmmo + 1
                            massVariableArray.StoredAmmo = 0
                        else
                            massVariableArray.StoredAmmo = massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)
                            massVariableArray.Ammo = massVariableArray.curConfig.Ammo + 1
                        end
                    end
                    ma = false
                    if massVariableArray.curConfig.CanAutoBolt or ta then
                        massVariableArray.CanShoot = true
                        Aa = true
                    end
                end
                UpdateAmmo()
                if _ ~= 70 and za then
                    tweenService:Create(currentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = _}):Play()
                end
            end
            if a.KeyCode == Enum.KeyCode.ButtonY and Ca and not va and not ea then
                ea = true
                la = not la
                if la then
                    BoltBackAnim()
                    if ta and massVariableArray.Ammo > 0 then
                        CreateShell()
                    end
                    ea = false
                else
                    if massVariableArray.Ammo > 0 then
                        massVariableArray.CanShoot = true
                        Aa = true
                        if ta then
                            massVariableArray.Ammo = massVariableArray.Ammo - 1
                        end
                        ta = true
                    end
                    BoltForwardAnim()
                    IdleAnim()
                    ea = false
                end
                UpdateAmmo()
            end
            if
                a.KeyCode == Enum.KeyCode.DPadDown and Ca and not va and not T and not Shooting and
                    massVariableArray.curConfig.CanSelectFire
             then
                T = true
                if massVariableArray.FireMode == 1 then
                    if Shooting then
                        Shooting = false
                    end
                    if massVariableArray.curConfig.AutoEnabled then
                        massVariableArray.FireMode = 2
                        massVariableArray.CanShoot = Aa
                    elseif not massVariableArray.curConfig.AutoEnabled and massVariableArray.curConfig.BurstEnabled then
                        massVariableArray.FireMode = 3
                        massVariableArray.CanShoot = Aa
                    elseif not massVariableArray.curConfig.AutoEnabled and not massVariableArray.curConfig.BurstEnabled and massVariableArray.curConfig.BoltAction then
                        massVariableArray.FireMode = 4
                        massVariableArray.FireMode = Aa
                    elseif
                        not massVariableArray.curConfig.AutoEnabled and not massVariableArray.curConfig.BurstEnabled and not massVariableArray.curConfig.BoltAction and
                            massVariableArray.curConfig.ExplosiveEnabled
                     then
                        massVariableArray.FireMode = 6
                        Aa = massVariableArray.CanShoot
                        massVariableArray.CanShoot = H
                    elseif
                        not massVariableArray.curConfig.AutoEnabled and not massVariableArray.curConfig.BurstEnabled and not massVariableArray.curConfig.BoltAction and
                            not massVariableArray.curConfig.ExplosiveEnabled
                     then
                        massVariableArray.FireMode = 1
                        massVariableArray.CanShoot = Aa
                    end
                elseif massVariableArray.FireMode == 2 then
                    if Shooting then
                        Shooting = false
                    end
                    if massVariableArray.curConfig.BurstEnabled then
                        massVariableArray.FireMode = 3
                        massVariableArray.CanShoot = Aa
                    elseif not massVariableArray.curConfig.BurstEnabled and massVariableArray.curConfig.BoltAction then
                        massVariableArray.FireMode = 4
                        massVariableArray.CanShoot = Aa
                    elseif
                        not massVariableArray.curConfig.BurstEnabled and not massVariableArray.curConfig.BoltAction and massVariableArray.curConfig.ExplosiveEnabled
                     then
                        massVariableArray.FireMode = 6
                        Aa = massVariableArray.CanShoot
                        massVariableArray.CanShoot = H
                    elseif
                        not massVariableArray.curConfig.BurstEnabled and not massVariableArray.curConfig.BoltAction and
                            not massVariableArray.curConfig.ExplosiveEnabled and
                            massVariableArray.curConfig.SemiEnabled
                     then
                        massVariableArray.FireMode = 1
                        massVariableArray.CanShoot = Aa
                    elseif
                        not massVariableArray.curConfig.BurstEnabled and not massVariableArray.curConfig.BoltAction and not massVariableArray.curConfig.SemiEnabled
                     then
                        massVariableArray.FireMode = 2
                        massVariableArray.CanShoot = Aa
                    end
                elseif massVariableArray.FireMode == 3 then
                    if Shooting then
                        Shooting = false
                    end
                    if massVariableArray.curConfig.BoltAction then
                        massVariableArray.FireMode = 4
                        massVariableArray.CanShoot = Aa
                    elseif not massVariableArray.curConfig.BoltAction and massVariableArray.curConfig.ExplosiveEnabled then
                        massVariableArray.FireMode = 6
                        Aa = massVariableArray.CanShoot
                        massVariableArray.CanShoot = H
                    elseif
                        not massVariableArray.curConfig.BoltAction and not massVariableArray.curConfig.ExplosiveEnabled and massVariableArray.curConfig.SemiEnabled
                     then
                        massVariableArray.FireMode = 1
                        massVariableArray.CanShoot = Aa
                    elseif not massVariableArray.curConfig.BoltAction and not massVariableArray.curConfig.SemiEnabled and massVariableArray.curConfig.AutoEnabled then
                        massVariableArray.FireMode = 2
                        massVariableArray.CanShoot = Aa
                    elseif not massVariableArray.curConfig.BoltAction and not massVariableArray.curConfig.SemiEnabled and not massVariableArray.curConfig.AutoEnabled then
                        massVariableArray.FireMode = 3
                        massVariableArray.CanShoot = Aa
                    end
                elseif massVariableArray.FireMode == 4 then
                    if Shooting then
                        Shooting = false
                    end
                    if massVariableArray.curConfig.ExplosiveEnabled then
                        massVariableArray.FireMode = 6
                        Aa = massVariableArray.CanShoot
                        massVariableArray.CanShoot = H
                    elseif not massVariableArray.curConfig.ExplosiveEnabled and massVariableArray.curConfig.SemiEnabled then
                        massVariableArray.FireMode = 1
                        massVariableArray.CanShoot = Aa
                    elseif not massVariableArray.curConfig.SemiEnabled and massVariableArray.curConfig.AutoEnabled then
                        massVariableArray.FireMode = 2
                        massVariableArray.CanShoot = Aa
                    elseif not massVariableArray.curConfig.SemiEnabled and not massVariableArray.curConfig.AutoEnabled and massVariableArray.curConfig.BurstEnabled then
                        massVariableArray.FireMode = 3
                        massVariableArray.CanShoot = Aa
                    elseif
                        not massVariableArray.curConfig.SemiEnabled and not massVariableArray.curConfig.AutoEnabled and not massVariableArray.curConfig.BurstEnabled
                     then
                        massVariableArray.FireMode = 4
                        massVariableArray.CanShoot = Aa
                    end
                elseif massVariableArray.FireMode == 6 then
                    if Shooting then
                        Shooting = false
                    end
                    H = massVariableArray.CanShoot
                    if massVariableArray.curConfig.SemiEnabled then
                        massVariableArray.FireMode = 1
                        massVariableArray.CanShoot = Aa
                    elseif not massVariableArray.curConfig.SemiEnabled and massVariableArray.curConfig.AutoEnabled then
                        massVariableArray.FireMode = 2
                        massVariableArray.CanShoot = Aa
                    elseif not massVariableArray.curConfig.SemiEnabled and not massVariableArray.curConfig.AutoEnabled and massVariableArray.curConfig.BurstEnabled then
                        massVariableArray.FireMode = 3
                        massVariableArray.CanShoot = Aa
                    elseif
                        not massVariableArray.curConfig.SemiEnabled and not massVariableArray.curConfig.AutoEnabled and not massVariableArray.curConfig.BurstEnabled and
                            massVariableArray.curConfig.BoltAction
                     then
                        massVariableArray.FireMode = 4
                        massVariableArray.CanShoot = Aa
                    elseif
                        not massVariableArray.curConfig.SemiEnabled and not massVariableArray.curConfig.AutoEnabled and not massVariableArray.curConfig.BurstEnabled and
                            not massVariableArray.curConfig.BoltAction
                     then
                        massVariableArray.FireMode = 6
                        Aa = massVariableArray.CanShoot
                        massVariableArray.CanShoot = H
                    end
                end
                UpdateAmmo()
                FireModeAnim()
                IdleAnim()
                T = false
            end
            if a.KeyCode == Enum.KeyCode.DPadUp then
                if massVariableArray.curModel:FindFirstChild("AimPart2") then
                    Q = not Q
                    if Q then
                        massVariableArray.CurAimPart = massVariableArray.curModel:FindFirstChild("AimPart2")
                        massVariableArray.AimPart2 = massVariableArray.curModel:FindFirstChild("AimPart2")
                        if not ia then
                            massVariableArray.curZoom = massVariableArray.curConfig.AltAimZoom
                        else
                            massVariableArray.curZoom = R
                        end
                    else
                        massVariableArray.CurAimPart = massVariableArray.AimPart
                        if not ia then
                            massVariableArray.curZoom = massVariableArray.curConfig.AimZoom
                        else
                            massVariableArray.curZoom = P
                        end
                    end
                    if za then
                        Aim(true, false)
                    end
                end
            end
        end
    end
)
userInputService.InputEnded:connect(
    function(a, _)
        if not _ and Ca then
            if a.KeyCode == Enum.KeyCode.ButtonL2 and not ya then
                Aim(false, true)
            end
            if a.KeyCode == Enum.KeyCode.ButtonL3 and Ca and not va and not za and not oa and not da then
                Sprint(false)
            end
            if a.KeyCode == Enum.KeyCode.ButtonR2 and Ca and not va then
                massVariableArray.MouseHeld = false
            end
        end
    end
)
playerArms.humanoid.Running:connect(
    function(_)
        if playerArms.humanoid.FloorMaterial ~= Enum.Material.Air then
            if _ > 1 then
                L = true
            else
                if ya then
                    Sprint(false)
                end
                L = false
            end
        end
    end
)
mathVariables.gunSway.s = 15
mathVariables.gunSway.d = 0.4
renderLoop:Connect(
    function(d)
        if Ca and massVariableArray.AnimBaseW then
            mathVariables.deltaX, mathVariables.deltaY = mathVariables.deltaX or 0, mathVariables.deltaY or 0
            if mathVariables.oc0 == nil or mathVariables.oc1 == nil then
                mathVariables.oc0 = massVariableArray.AnimBaseW.C0
                mathVariables.oc1 = massVariableArray.AnimBaseW.C1
            end
            local a = (math.cos(mathVariables.walkTick * mathVariables.walkAnimSpeed / 2) * mathVariables.walkAnimIntensity)
            local _ = (math.cos(mathVariables.walkTick * mathVariables.walkAnimSpeed) * mathVariables.walkAnimIntensity)
            local _ =
                CFrame.new(a, _, 0.02) *
                CFrame.Angles(
                    (math.sin(mathVariables.walkTick * mathVariables.walkAnimSpeed) * mathVariables.walkAnimIntensity),
                    (math.sin(mathVariables.walkTick * mathVariables.walkAnimSpeed / 2) * mathVariables.walkAnimIntensity),
                    0
                )
            local a = (math.sin(mathVariables.idleTick * mathVariables.idleSpeed / 2) * mathVariables.idleIntensity)
            local b = (math.cos(mathVariables.idleTick * mathVariables.idleSpeed) * mathVariables.idleIntensity)
            local a = CFrame.new(a, b, 0.02)
            if L and playerArms.humanoid.FloorMaterial ~= Enum.Material.Air then
                mathVariables.walkTick = mathVariables.walkTick + .017
                mathVariables.movinganim = _
            else
                mathVariables.walkTick = 0
                mathVariables.movinganim = CFrame.new()
            end
            mathVariables.gunSway.t = Vector3.new(mathVariables.desiredXOffset, mathVariables.desiredYOffset, 0)
            local _ = mathVariables.gunSway.p
            local b = _.X / mathVariables.swayInputLimit * (za and mathVariables.aimSway or mathVariables.hipSway)
            local _ = _.Y / mathVariables.swayInputLimit * (za and mathVariables.aimSway or mathVariables.hipSway)
            if za then
                mathVariables.swayCF = CFrame.new(math.rad(-b), math.rad(_), 0) * CFrame.Angles(0, 0, math.rad(-b))
                mathVariables.idleTick = 0
                mathVariables.idleAnimation = CFrame.new()
            else
                mathVariables.swayCF = CFrame.new(math.rad(-b), math.rad(_), 0) * CFrame.Angles(0, 0, math.rad(-b))
                mathVariables.idleTick = mathVariables.idleTick + 0.003
                mathVariables.idleAnimation = a
            end
            local c = recoilData.recoilSpring.p
            local b = CFrame.new(0, 0, c.z)
            local a = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), c.x / 7)
            local _ = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), c.y / 10)
            c = b * a * _
            massVariableArray.newCamOffset = massVariableArray.newCamOffset:Lerp(massVariableArray.camC1, d * 5)
            massVariableArray.BasePart.CFrame = currentCamera.CFrame * c
            massVariableArray.PrimeAnimBaseW.C0 = massVariableArray.PrimeAnimBaseW.C0:lerp(rotation, d * 5)
            massVariableArray.AnimBaseW.C0 = massVariableArray.AnimBaseW.C0:lerp(mathVariables.oc0 * mathVariables.movinganim * mathVariables.idleAnimation, d * 5)
            UpdateCamChar(d)
            if za then
                userInputService.MouseDeltaSensitivity = massVariableArray.aimSens
                massVariableArray.sensDisplay.Text = massVariableArray.aimSens
            else
                userInputService.MouseDeltaSensitivity = massVariableArray.baseSens
                massVariableArray.sensDisplay.Text = massVariableArray.baseSens
            end
            if not za and not ya and not da and not oa then
                massVariableArray.AnimBaseW.C1 = massVariableArray.AnimBaseW.C1:lerp(CFrame.new() * mathVariables.swayCF, d)
            end
            if massVariableArray.StanceIndex == 0 and not ya then
                if not za then
                    playerCharacter:WaitForChild("Humanoid").WalkSpeed = massVariableArray.baseWalkspeed
                else
                    playerCharacter:WaitForChild("Humanoid").WalkSpeed = massVariableArray.aimWalkSpeed
                end
            end
            if za and not ya and not da and not oa then
                if not qa then
                    mathVariables.walkAnimIntensity = carbonConfigs.globalConfig.AimWalkIntensity
                    mathVariables.walkAnimSpeed = carbonConfigs.globalConfig.AimWalkAnimSpeed
                end
                mathVariables.idleSpeed = 0
                massVariableArray.AnimBaseW.C1 =
                    massVariableArray.AnimBaseW.C1:lerp(
                    massVariableArray.CurAimPart.CFrame:toObjectSpace(massVariableArray.AnimBase.CFrame) * mathVariables.oc0 * mathVariables.swayCF,
                    d * massVariableArray.curConfig.AimSpeedMult
                )
            end
            if ya and not qa and L then
                mathVariables.walkAnimIntensity = massVariableArray.curConfig.SprintWalkIntensity
                mathVariables.walkAnimSpeed = massVariableArray.curConfig.SprintWalkAnimSpeed
                playerArms.humanoid.WalkSpeed = 21
                massVariableArray.AnimBaseW.C1 = massVariableArray.AnimBaseW.C1:lerp(mathVariables.swayCF * massVariableArray.curConfig.SprintPos, d * 5)
            end
            if not za and not ya and not da and not oa then
                mathVariables.walkAnimIntensity = carbonConfigs.globalConfig.WalkIntensity
                mathVariables.walkAnimSpeed = carbonConfigs.globalConfig.WalkAnimSpeed
                mathVariables.idleSpeed = 2
                massVariableArray.AnimBaseW.C1 = massVariableArray.AnimBaseW.C1:lerp(CFrame.new() * mathVariables.swayCF, d * 7)
            end
            for _, a in pairs(massVariableArray.curModel:GetChildren()) do
                if a and string.match(a.Name, "ProjectorSight") then
                    local _ = a.SurfaceGui
                    _.Adornee = a
                    local _ = _.ClippingFrame.Reticle
                    local a = a.CFrame:pointToObjectSpace(currentCamera.CFrame.Position) / a.Size
                    _.Position = UDim2.new(.5 + a.x, 0, .5 - a.y, 0)
                end
            end
            if
                na and massVariableArray.LA:FindFirstChild("Binos") and
                    massVariableArray.LA.Binos:FindFirstChild("AimPart")
             then
                if mouse.Hit then
                    local b, a, _ =
                        workspace:FindPartOnRayWithIgnoreList(
                        Ray.new(playerArms.head.Position, (mouse.Hit.p - playerArms.head.Position)),
                        componentCollection
                    )
                    if b then
                        massVariableArray.hud:WaitForChild("RangeFrame"):WaitForChild("Dist").Text =
                            math.ceil((playerArms.head.Position - a).magnitude) .. "m"
                    end
                end
            end
        end
        if qa then
            if massVariableArray.StanceIndex == 0 then
                mathVariables.walkAnimIntensity = 0.08
                mathVariables.walkAnimSpeed = 12
            elseif massVariableArray.StanceIndex == 1 then
                if playerArms.humanoid.Jump then
                    playerArms.humanoid.Jump = false
                end
                playerArms.humanoid.WalkSpeed = 6
                mathVariables.walkAnimIntensity = 0.005
                mathVariables.walkAnimSpeed = 6
            elseif massVariableArray.StanceIndex == 2 then
                if playerArms.humanoid.Jump then
                    playerArms.humanoid.Jump = false
                end
                playerArms.humanoid.WalkSpeed = 3
                mathVariables.walkAnimIntensity = 0.003
                mathVariables.walkAnimSpeed = 3
            end
        end
        if massVariableArray.progressBar and carbonConfigs.globalConfig.StaminaEnabled then
            massVariableArray.progressBar.Size = massVariableArray.progressBar.Size:Lerp(UDim2.new(massVariableArray.Stamina, 0, 1, -4), d * 5)
        end
        HalfStepFunc(-math.asin((mouse.Hit.p - mouse.Origin.p).unit.y))
        for _, b in pairs(game.Players:GetChildren()) do
            if
                b and b:IsA("Player") and b ~= localPlayer and b.Character and
                    b.Character:WaitForChild("CarbonValues"):FindFirstChild(
                        "yRot"
                    ) and
                    b.Character:WaitForChild("CarbonValues").yRot.Value and
                    b.Character:WaitForChild("CarbonValues"):FindFirstChild(
                        "zRot"
                    ) and
                    b.Character:WaitForChild("CarbonValues").zRot.Value and
                    b.Character:FindFirstChild("Torso") and
                    b.Character.Torso:FindFirstChild("Neck") and
                    (b.Character:WaitForChild("HumanoidRootPart").Position -
                        playerArms.rootPart.Position).magnitude <= carbonConfigs.globalConfig.RenderDist
             then
                local a = b.Character:WaitForChild("Torso"):WaitForChild("Neck")
                local _ =
                    b.Character:WaitForChild("HumanoidRootPart").CFrame *
                    CFrame.new(0, 1.5, 0) *
                    CFrame.new(b.Character:WaitForChild("Humanoid").CameraOffset)
                a.C0 =
                    a.C0:lerp(
                    b.Character:WaitForChild("HumanoidRootPart").CFrame:toObjectSpace(
                        _
                    ) *
                        b.Character:WaitForChild("CarbonValues"):WaitForChild(
                            "neckCF"
                        ).Value,
                    0.2
                )
                a.C1 =
                    a.C1:lerp(
                    b.Character:WaitForChild("CarbonValues").yRot.Value *
                        b.Character:WaitForChild("CarbonValues").zRot.Value,
                    0.2
                )
            end
        end
        if O then
            local _ = Ray.new(massVariableArray.curModel.LaserLight.Position, massVariableArray.curModel.Grip.CFrame.lookVector * 9999)
            local b, a, _ = workspace:FindPartOnRayWithIgnoreList(_, componentList)
            M.CFrame = CFrame.new(0, 0, -j)
            Y.CFrame = M.WorldCFrame
            if b and (b and b.Transparency >= 1 or b.CanCollide == false) then
                table.insert(componentList, b)
            end
            if b then
                j = (massVariableArray.curModel.LaserLight.Position - a).magnitude
            else
                j = 9999
            end
        end
        if carbonConfigs.globalConfig.ReplicatedLaser then
            for _, _ in pairs(game.Players:GetChildren()) do
                if
                    _ and _:IsA("Player") and _ ~= localPlayer and _.Character and
                        _.Character.CarbonValues:FindFirstChild("Equipped") and
                        _.Character.CarbonValues.Equipped.Value and
                        _.Character.CarbonValues:FindFirstChild("SModel") and
                        _.Character.CarbonValues.SModel.Value
                 then
                    OtherLaser(
                        _,
                        _.Character.CarbonValues.SModel.Value.Name,
                        _.Character.CarbonValues.LaserActive.Value,
                        _.Character.CarbonValues.SModel.Value
                    )
                end
            end
        end
    end
)
game:GetService("RunService"):BindToRenderStep(
    "Camera Update",
    200,
    Update
)
coroutine.resume(
    coroutine.create(
        function()
            while true do
                task.wait(1)
                if carbonConfigs.globalConfig.StaminaEnabled then
                    if ya then
                        massVariableArray.Stamina = massVariableArray.Stamina - massVariableArray.StaminaMult
                        if massVariableArray.Stamina <= 0 then
                            massVariableArray.Stamina = 0
                            Sprint(false)
                        end
                    elseif not ya and massVariableArray.Stamina < 1 then
                        task.wait(carbonConfigs.globalConfig.StaminaRegenTime - 1)
                        massVariableArray.Stamina = massVariableArray.Stamina + carbonConfigs.globalConfig.StaminaRegenMult
                        if massVariableArray.Stamina > 1 then
                            massVariableArray.Stamina = 1
                        end
                    end
                end
            end
        end
    )
)
mouse.Idle:connect(
    function()
        mathVariables.desiredXOffset = 0
        mathVariables.desiredYOffset = 0
    end
)
carbonEvents.updateCharEvent.OnClientEvent:connect(
    function(e, d, c, _, b, a)
        if
            e ~= localPlayer and e.Character and e.Character:FindFirstChild("BasePart") and
                (e.Character:WaitForChild("HumanoidRootPart").Position -
                    playerArms.rootPart.Position).magnitude <= carbonConfigs.globalConfig.RenderDist
         then
            local a
            if _ ~= nil then
                a = require(_)
            else
                a = nil
            end
            if d == "Aim" then
                if c then
                    tweenService:Create(e.Character.BasePart.RAW, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {C1 = a.RightAimPos}):Play(

                    )
                    tweenService:Create(e.Character.BasePart.LAW, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {C1 = a.LeftAimPos}):Play(

                    )
                else
                    tweenService:Create(e.Character.BasePart.RAW, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {C1 = a.RightArmPos}):Play(

                    )
                    tweenService:Create(e.Character.BasePart.LAW, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {C1 = a.LeftArmPos}):Play(

                    )
                end
            end
            if d == "Sprint" then
                if c then
                    tweenService:Create(
                        e.Character.BasePart.RAW,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                        {C1 = a.RightSprintPos}
                    ):Play()
                    tweenService:Create(
                        e.Character.BasePart.LAW,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                        {C1 = a.LeftSprintPos}
                    ):Play()
                else
                    tweenService:Create(e.Character.BasePart.RAW, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {C1 = a.RightArmPos}):Play(

                    )
                    tweenService:Create(e.Character.BasePart.LAW, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {C1 = a.LeftArmPos}):Play(

                    )
                end
            end
            if d == "Shoot" then
                if c then
                    if
                        e.Character:FindFirstChild("BasePart") and
                            e.Character.BasePart:FindFirstChild("BasePartW")
                     then
                        tweenService:Create(
                            e.Character:WaitForChild("BasePart"):WaitForChild(
                                "BasePartW"
                            ),
                            TweenInfo.new(b),
                            {C1 = a.ShootPos}
                        ):Play()
                    end
                    if
                        e.Character:FindFirstChildOfClass("Tool") and
                            e.Character:FindFirstChild(
                                "@" .. e.Character:FindFirstChildOfClass("Tool").Name
                            )
                     then
                        local _ =
                            e.Character:FindFirstChild(
                            "@" .. e.Character:FindFirstChildOfClass("Tool").Name
                        )
                        if _:FindFirstChild("FirePart") then
                            for _, _ in pairs(_.FirePart:GetChildren()) do
                                if _ and _.Name:sub(1, 7) == "FlashFX" then
                                    _.Enabled = true
                                end
                            end
                            delay(
                                1 / 30,
                                function()
                                    for _, _ in pairs(_.FirePart:GetChildren()) do
                                        if _ and _.Name:sub(1, 7) == "FlashFX" then
                                            _.Enabled = false
                                        end
                                    end
                                end
                            )
                        end
                    end
                    task.wait(b * 2)
                    if
                        e.Character:FindFirstChild("BasePart") and
                            e.Character.BasePart:FindFirstChild("BasePartW")
                     then
                        tweenService:Create(
                            e.Character:WaitForChild("BasePart"):WaitForChild(
                                "BasePartW"
                            ),
                            TweenInfo.new(0.2),
                            {C1 = CFrame.new()}
                        ):Play()
                    end
                end
            end
            if d == "ReadyHigh" then
                if c then
                    tweenService:Create(
                        e.Character.BasePart.BasePartW,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                        {C1 = a.ReadyHighPos}
                    ):Play()
                end
            end
            if d == "ReadyLow" then
                if c then
                    tweenService:Create(
                        e.Character.BasePart.BasePartW,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                        {C1 = a.ReadyLowPos}
                    ):Play()
                end
            end
            if d == "Idle" then
                if c then
                    tweenService:Create(
                        e.Character.BasePart.RAW,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad),
                        {C1 = a.RightArmPos}
                    ):Play()
                    tweenService:Create(e.Character.BasePart.LAW, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {C1 = a.LeftArmPos}):Play(

                    )
                    tweenService:Create(
                        e.Character.BasePart.BasePartW,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                        {C1 = CFrame.new()}
                    ):Play()
                end
            end
            if d == "Patrol" then
                if c then
                    tweenService:Create(
                        e.Character.BasePart.RAW,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                        {C1 = a.RightPatrolPos}
                    ):Play()
                    tweenService:Create(
                        e.Character.BasePart.LAW,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                        {C1 = a.LeftPatrolPos}
                    ):Play()
                else
                    tweenService:Create(e.Character.BasePart.RAW, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {C1 = a.RightArmPos}):Play(

                    )
                    tweenService:Create(e.Character.BasePart.LAW, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {C1 = a.LeftArmPos}):Play(

                    )
                end
            end
        end
        if
            d == "Stance" and e ~= localPlayer and e.Character and
                e.Character:FindFirstChild("Humanoid") and
                e.Character.Humanoid.Health > 0
         then
            if b == 0 then
                tweenService:Create(
                    e.Character:WaitForChild("HumanoidRootPart"):WaitForChild(
                        "RootJoint"
                    ),
                    TweenInfo.new(0.6),
                    {C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)}
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild(
                        "Right Hip"
                    ),
                    TweenInfo.new(0.6),
                    {C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)}
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild("Left Hip"),
                    TweenInfo.new(0.6),
                    {C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)}
                ):Play()
            elseif b == 1 then
                tweenService:Create(
                    e.Character:WaitForChild("HumanoidRootPart"):WaitForChild(
                        "RootJoint"
                    ),
                    TweenInfo.new(0.6),
                    {C0 = CFrame.new(0, -1.20000005, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0)}
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild(
                        "Right Hip"
                    ),
                    TweenInfo.new(0.6),
                    {
                        C0 = CFrame.new(
                            1.00000191,
                            -0.93054074,
                            -0.393920898,
                            0,
                            0,
                            1,
                            -0.98480773,
                            0.173648179,
                            0,
                            -0.173648179,
                            -0.98480773,
                            0
                        )
                    }
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild("Left Hip"),
                    TweenInfo.new(0.6),
                    {
                        C0 = CFrame.new(
                            -1,
                            0.165270448,
                            -0.603042603,
                            0,
                            0,
                            -1,
                            -0.173648179,
                            0.98480773,
                            0,
                            0.98480773,
                            0.173648179,
                            0
                        )
                    }
                ):Play()
            elseif b == 2 then
                tweenService:Create(
                    e.Character:WaitForChild("HumanoidRootPart"):WaitForChild(
                        "RootJoint"
                    ),
                    TweenInfo.new(0.6),
                    {C0 = CFrame.new(0, -2.5999999, 0, -1, 0, 0, 0, 1, 1.19248806e-08, 0, 1.19248806e-08, -1)}
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild(
                        "Right Hip"
                    ),
                    TweenInfo.new(0.6),
                    {
                        C0 = CFrame.new(
                            1,
                            -1,
                            2.98023224e-08,
                            0.163175702,
                            -0.342020363,
                            0.925416529,
                            0.0593911409,
                            0.939692557,
                            0.336824328,
                            -0.984807789,
                            0,
                            0.17364797
                        )
                    }
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild("Left Hip"),
                    TweenInfo.new(0.6),
                    {
                        C0 = CFrame.new(
                            -1,
                            -1,
                            2.98023224e-08,
                            0.163175896,
                            0.342020363,
                            -0.92541647,
                            -0.0593912117,
                            0.939692557,
                            0.336824298,
                            0.98480773,
                            0,
                            0.173648179
                        )
                    }
                ):Play()
            end
        end
        if
            d == "Lean" and e ~= localPlayer and e.Character and
                e.Character:FindFirstChild("Humanoid") and
                e.Character.Humanoid.Health > 0
         then
            if a == 1 then
                tweenService:Create(
                    e.Character:WaitForChild("HumanoidRootPart"):WaitForChild(
                        "RootJoint"
                    ),
                    TweenInfo.new(0.6),
                    {
                        C1 = CFrame.new(
                            0.600000024,
                            0,
                            0,
                            -0.939692616,
                            0,
                            0.342020124,
                            0.342020124,
                            0,
                            0.939692616,
                            0,
                            1,
                            0
                        )
                    }
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild(
                        "Right Hip"
                    ),
                    TweenInfo.new(0.6),
                    {C1 = CFrame.new(0.5, 1, 0, 0, 0.087155737, 0.99619472, 0, 0.99619472, -0.087155737, -1, 0, 0)}
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild("Left Hip"),
                    TweenInfo.new(0.6),
                    {
                        C1 = CFrame.new(
                            -0.5,
                            0.600000024,
                            0,
                            0,
                            -0.342020124,
                            -0.939692557,
                            0,
                            0.939692557,
                            -0.342020124,
                            1,
                            0,
                            0
                        )
                    }
                ):Play()
            elseif a == -1 then
                tweenService:Create(
                    e.Character:WaitForChild("HumanoidRootPart"):WaitForChild(
                        "RootJoint"
                    ),
                    TweenInfo.new(0.6),
                    {
                        C1 = CFrame.new(
                            -0.600000024,
                            0,
                            0,
                            -0.939692557,
                            0,
                            -0.342020154,
                            -0.342020154,
                            0,
                            0.939692557,
                            0,
                            1,
                            0
                        )
                    }
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild(
                        "Right Hip"
                    ),
                    TweenInfo.new(0.6),
                    {
                        C1 = CFrame.new(
                            0.5,
                            0.600000024,
                            0,
                            0,
                            0.342020124,
                            0.939692557,
                            0,
                            0.939692557,
                            -0.342020124,
                            -1,
                            0,
                            0
                        )
                    }
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild("Left Hip"),
                    TweenInfo.new(0.6),
                    {C1 = CFrame.new(-0.5, 1, 0, 0, 0, -0.99999994, 0, 0.99999994, 0, 1, 0, 0)}
                ):Play()
            elseif a == 0 then
                tweenService:Create(
                    e.Character:WaitForChild("HumanoidRootPart"):WaitForChild(
                        "RootJoint"
                    ),
                    TweenInfo.new(0.6),
                    {C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)}
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild(
                        "Right Hip"
                    ),
                    TweenInfo.new(0.6),
                    {C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)}
                ):Play()
                tweenService:Create(
                    e.Character:WaitForChild("Torso"):WaitForChild("Left Hip"),
                    TweenInfo.new(0.6),
                    {C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)}
                ):Play()
            end
        end
    end
)
carbonEvents.whizEvent.OnClientEvent:connect(
    function(_, a, c, g, h, e, f, d, b)
        if localPlayer ~= _ then
            CreateExternalBullet(a, c, g, h, e, f, d, b)
        end
    end
)
carbonEvents.serverFXEvent.OnClientEvent:connect(
    function(a, _)
        if massVariableArray.hud then
            if carbonConfigs.globalConfig.OverlayEnabled and massVariableArray.painShade.ImageTransparency == 1 then
                if (playerCharacter.HumanoidRootPart.Position - a).magnitude <= 10 then
                    massVariableArray.intenseShade.Visible = true
                    tweenService:Create(massVariableArray.intenseShade, TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
                    delay(
                        0.7,
                        function()
                            tweenService:Create(massVariableArray.intenseShade, TweenInfo.new(3), {ImageTransparency = 1}):Play()
                        end
                    )
                end
            end
        end
    end
)
carbonEvents.manipEvent.OnClientEvent:Connect(
    function(c, b, a, _)
        if localPlayer ~= c then
            for _, _ in pairs(b:WaitForChild("FlashLight"):GetChildren()) do
                if _ and _.Name == "Enable" then
                    _.Enabled = a
                end
            end
        end
    end
)
carbonEvents.resupplyEvent.OnClientEvent:Connect(
    function()
        q = true
    end
)
carbonEvents.connectionEvent.OnClientEvent:Connect(
    function(_, b, c, a)
        if c ~= localPlayer then
            spawn(
                function()
                    SpawnIso(_, b, c, a)
                end
            )
        end
    end
)
carbonEvents.nadeEvent.OnClientEvent:Connect(
    function(b, _, a)
        if b ~= localPlayer then
            local c = carbonFx:WaitForChild("FRAG"):WaitForChild("NADE"):Clone()
            c.Parent = workspace
            c.CFrame = _
            c.Anchored = false
            c.CanCollide = true
            game.Debris:AddItem(c, 5)
            local _ = c:GetMass()
            local _ = Instance.new("BodyForce", c)
            _.Force = carbonConfigs.globalConfig.NadePhysics
            c.Velocity = a * carbonConfigs.globalConfig.NadeSpeed
            c:WaitForChild("Indicator").MaxDistance = carbonConfigs.globalConfig.BlastRadius
            if b.TeamColor ~= localPlayer.TeamColor then
                c:WaitForChild("Indicator"):WaitForChild("Enemy").Visible =
                    true
            else
                c:WaitForChild("Indicator"):WaitForChild("Friendly").Visible =
                    true
            end
            if carbonConfigs.globalConfig.NadeTrailEnabled then
                c:WaitForChild("Trail").Enabled = true
            end
        end
    end
)
carbonEvents.attachmentEvent.OnClientEvent:Connect(
    function(a, _, b)
        if _ == "OpticNode" then
            ia = a
            P = b[1]
            R = b[2]
            massVariableArray.oHopUp = b[3]
        elseif _ == "GripNode" then
            K = a
            F = b
        end
    end
)
local a
function IdleAnim(_)
    massVariableArray.curConfig.IdleAnim(playerCharacter, a, {massVariableArray.AnimBaseW, massVariableArray.RAW, massVariableArray.LAW, massVariableArray.GripW, massVariableArray.GripW2}, {K, F})
end
function AttachAnim(_)
    carbonConfigs.globalConfig.AttachAnim(playerCharacter, a, {massVariableArray.RAW, massVariableArray.LAW})
end
function BoltBackAnim(_)
    massVariableArray.curConfig.BoltBackAnim(
        playerCharacter,
        a,
        {massVariableArray.BoltW, massVariableArray.LAW, massVariableArray.RAW, massVariableArray.AnimBaseW, massVariableArray.Bolt, massVariableArray.RA, massVariableArray.LA, massVariableArray.Grip, massVariableArray.Grip.GripW, massVariableArray.GripW2}
    )
end
function BoltForwardAnim(_)
    massVariableArray.curConfig.BoltForwardAnim(
        playerCharacter,
        a,
        {massVariableArray.BoltW, massVariableArray.LAW, massVariableArray.RAW, massVariableArray.AnimBaseW, massVariableArray.Bolt, massVariableArray.RA, massVariableArray.LA, massVariableArray.Grip, massVariableArray.Grip.GripW, massVariableArray.GripW2}
    )
end
function BoltingBackAnim(_)
    massVariableArray.curConfig.BoltingBackAnim(playerCharacter, a, {massVariableArray.BoltW, massVariableArray.Mag, massVariableArray.Ammo, massVariableArray.GripW2})
end
function BoltingForwardAnim(_)
    massVariableArray.curConfig.BoltingForwardAnim(playerCharacter, a, {massVariableArray.BoltW, massVariableArray.Mag, massVariableArray.Ammo, massVariableArray.GripW2})
end
function ReloadAnim(_)
    massVariableArray.curConfig.ReloadAnim(
        playerCharacter,
        a,
        {
            massVariableArray.AnimBaseW,
            massVariableArray.RAW,
            massVariableArray.LAW,
            massVariableArray.Mag,
            massVariableArray.LA,
            massVariableArray.Grip,
            massVariableArray.BoltW,
            massVariableArray.RA,
            massVariableArray.GripW,
            massVariableArray.curModel,
            massVariableArray.Bolt,
            massVariableArray.Ammo,
            massVariableArray.curConfig.Ammo,
            massVariableArray.GripW2
        }
    )
end
function FireModeAnim(_)
    massVariableArray.curConfig.FireModeAnim(playerCharacter, a, {massVariableArray.AnimBaseW, massVariableArray.LAW, massVariableArray.RAW, massVariableArray.Grip, massVariableArray.GripW2})
end
function nadeReload(_)
    massVariableArray.curConfig.nadeReload(playerCharacter, a, {massVariableArray.RAW, massVariableArray.LAW, massVariableArray.GripW2})
end
function fireAnim(_)
    massVariableArray.curConfig.fireAnim(playerCharacter, a, {massVariableArray.curModel, massVariableArray.RAW, massVariableArray.LAW, massVariableArray.GripW, massVariableArray.BoltW, massVariableArray.Mag, massVariableArray.GripW2, massVariableArray.AnimBaseW})
end
function aimAnim(_)
    massVariableArray.curConfig.aimAnim(playerCharacter, a, {massVariableArray.curModel, massVariableArray.RAW, massVariableArray.LAW, massVariableArray.GripW, massVariableArray.BoltW, massVariableArray.Mag, massVariableArray.GripW2, massVariableArray.AnimBaseW})
end
function unaimAnim(_)
    massVariableArray.curConfig.unaimAnim(playerCharacter, a, {massVariableArray.curModel, massVariableArray.RAW, massVariableArray.LAW, massVariableArray.GripW, massVariableArray.BoltW, massVariableArray.Mag, massVariableArray.GripW2, massVariableArray.AnimBaseW})
end
function sprintAnim(_)
    massVariableArray.curConfig.sprintAnim(playerCharacter, a, {massVariableArray.curModel, massVariableArray.RAW, massVariableArray.LAW, massVariableArray.GripW, massVariableArray.BoltW, massVariableArray.Mag, massVariableArray.GripW2, massVariableArray.AnimBaseW})
end
function unsprintAnim(_)
    massVariableArray.curConfig.unsprintAnim(playerCharacter, a, {massVariableArray.curModel, massVariableArray.RAW, massVariableArray.LAW, massVariableArray.GripW, massVariableArray.BoltW, massVariableArray.Mag, massVariableArray.GripW2, massVariableArray.AnimBaseW})
end
massVariableArray.optionButton.MouseEnter:connect(
    function()
        tweenService:Create(
            massVariableArray.optionButton:WaitForChild("Detail"),
            TweenInfo.new(0.3),
            {BackgroundTransparency = 0.3}
        ):Play()
    end
)
massVariableArray.optionButton.MouseLeave:connect(
    function()
        if X ~= "Option" then
            tweenService:Create(
                massVariableArray.optionButton:WaitForChild("Detail"),
                TweenInfo.new(0.3),
                {BackgroundTransparency = 1}
            ):Play()
        end
    end
)
massVariableArray.optionButton.MouseButton1Click:connect(
    function()
        X = "Option"
        carbonConfigs.codeArchive.OptionFunc(massVariableArray, X)
    end
)
massVariableArray.keybindButton.MouseEnter:connect(
    function()
        tweenService:Create(
            massVariableArray.keybindButton:WaitForChild("Detail"),
            TweenInfo.new(0.3),
            {BackgroundTransparency = 0.3}
        ):Play()
    end
)
massVariableArray.keybindButton.MouseLeave:connect(
    function()
        if X ~= "Keybind" then
            tweenService:Create(
                massVariableArray.keybindButton:WaitForChild("Detail"),
                TweenInfo.new(0.3),
                {BackgroundTransparency = 1}
            ):Play()
        end
    end
)
massVariableArray.keybindButton.MouseButton1Click:connect(
    function()
        X = "Keybind"
        carbonConfigs.codeArchive.KeybindFunc(massVariableArray, X)
    end
)
massVariableArray.patchButton.MouseEnter:connect(
    function()
        tweenService:Create(
            massVariableArray.patchButton:WaitForChild("Detail"),
            TweenInfo.new(0.3),
            {BackgroundTransparency = 0.3}
        ):Play()
    end
)
massVariableArray.patchButton.MouseLeave:connect(
    function()
        if X ~= "Patch" then
            tweenService:Create(
                massVariableArray.patchButton:WaitForChild("Detail"),
                TweenInfo.new(0.3),
                {BackgroundTransparency = 1}
            ):Play()
        end
    end
)
massVariableArray.patchButton.MouseButton1Click:connect(
    function()
        X = "Patch"
        tweenService:Create(massVariableArray.patchButton:WaitForChild("Hover"), TweenInfo.new(0.3), {ImageTransparency = 0.6}):Play(

        )
        massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(
            "PageLayout"
        ):JumpTo(massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(X))
        for _, _ in pairs(massVariableArray.menuFrame:WaitForChild("Buttons"):GetDescendants()) do
            if _ and _.Name == "Hover" and _.Parent ~= massVariableArray.patchButton then
                tweenService:Create(_, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
            end
            if _ and _.Name == "Detail" and _.Parent ~= massVariableArray.patchButton then
                tweenService:Create(_, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            end
        end
    end
)
massVariableArray.storeButton.MouseEnter:connect(
    function()
        tweenService:Create(
            massVariableArray.storeButton:WaitForChild("Detail"),
            TweenInfo.new(0.3),
            {BackgroundTransparency = 0.3}
        ):Play()
    end
)
massVariableArray.storeButton.MouseLeave:connect(
    function()
        if X ~= "Store" then
            tweenService:Create(
                massVariableArray.storeButton:WaitForChild("Detail"),
                TweenInfo.new(0.3),
                {BackgroundTransparency = 1}
            ):Play()
        end
    end
)
massVariableArray.storeButton.MouseButton1Click:connect(
    function()
        X = "Store"
        tweenService:Create(massVariableArray.storeButton:WaitForChild("Hover"), TweenInfo.new(0.3), {ImageTransparency = 0.6}):Play(

        )
        massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(
            "PageLayout"
        ):JumpTo(massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(X))
        for _, _ in pairs(massVariableArray.menuFrame:WaitForChild("Buttons"):GetDescendants()) do
            if _ and _.Name == "Hover" and _.Parent ~= massVariableArray.storeButton then
                tweenService:Create(_, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
            end
            if _ and _.Name == "Detail" and _.Parent ~= massVariableArray.storeButton then
                tweenService:Create(_, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            end
        end
    end
)
massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild("Option"):WaitForChild(
    "BaseSens"
):WaitForChild("Context").FocusLost:connect(
    function(_)
        if _ then
            local _ =
                tonumber(
                massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(
                    "Option"
                ):WaitForChild("BaseSens"):WaitForChild("Context").Text
            )
            if _ > 0 and _ <= 1 then
                massVariableArray.baseSens = _
                e.Value = _
            end
        else
            massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(
                    "Option"
                ):WaitForChild("BaseSens"):WaitForChild("Context").Text =
                massVariableArray.baseSens
            massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(
                    "Option"
                ):WaitForChild("AimSens"):WaitForChild("Context").Text =
                massVariableArray.aimSens
        end
    end
)
massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild("Option"):WaitForChild(
    "AimSens"
):WaitForChild("Context").FocusLost:connect(
    function(_)
        if _ then
            local _ =
                tonumber(
                massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(
                    "Option"
                ):WaitForChild("AimSens"):WaitForChild("Context").Text
            )
            if _ > 0 and _ <= 1 then
                massVariableArray.aimSens = _
                c.Value = _
            end
        else
            massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(
                    "Option"
                ):WaitForChild("BaseSens"):WaitForChild("Context").Text =
                massVariableArray.baseSens
            massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(
                    "Option"
                ):WaitForChild("AimSens"):WaitForChild("Context").Text =
                massVariableArray.aimSens
        end
    end
)
massVariableArray.menuButton.MouseButton1Click:connect(
    function()
        massVariableArray.menuFrame.Visible = not massVariableArray.menuFrame.Visible
        if massVariableArray.menuFrame.Visible then
            massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(
                    "Option"
                ):WaitForChild("BaseSens"):WaitForChild("Context").Text =
                massVariableArray.baseSens
            massVariableArray.menuFrame:WaitForChild("PagesFrame"):WaitForChild(
                    "Option"
                ):WaitForChild("AimSens"):WaitForChild("Context").Text =
                massVariableArray.aimSens
        end
    end
)
massVariableArray.aimButton.TouchTap:Connect(
    function()
        if Ca and not va then
            if not za then
                Aim(true, false)
            else
                Aim(false, true)
            end
        end
    end
)
massVariableArray.sprintButton.TouchTap:Connect(
    function()
        if Ca and not va then
            if not ya then
                if
                    ((carbonConfigs.globalConfig.StaminaEnabled and massVariableArray.Stamina > 0) or not carbonConfigs.globalConfig.StaminaEnabled) and
                        not qa and
                        L and
                        not wa and
                        not ka and
                        not na and
                        not pa
                 then
                    Sprint(true)
                end
            else
                if not qa and not za and not oa and not da then
                    Sprint(false)
                end
            end
        end
    end
)
function MobileShoot(_, a, _)
    if a == Enum.UserInputState.Begin then
        if not massVariableArray.MouseHeld and Ca and not va and not wa and not ka and not na and not T then
            massVariableArray.MouseHeld = true
            if not pa then
                if not ja then
                    if massVariableArray.Ammo > 0 then
                        Shoot()
                    end
                else
                    if massVariableArray.ExplosiveAmmo > 0 then
                        Shoot()
                    end
                end
                if massVariableArray.Ammo <= 0 or not massVariableArray.CanShoot then
                    massVariableArray.Grip:WaitForChild("Click"):Play()
                end
            else
                if massVariableArray.NadeMode == 4 and not ba then
                    ba = true
                    local d, b, c
                    if not V then
                        d, b, c =
                            workspace:FindPartOnRayWithIgnoreList(
                            Ray.new(Z.PrimaryPart.Position, Z.PrimaryPart.CFrame.UpVector * -2),
                            componentCollection
                        )
                        local a = Vector3.new(0, 1, 0):Cross(c)
                        local _ = math.asin(a.magnitude)
                        if d then
                            Z:Destroy()
                            V = carbonEvents.placeC4Event:InvokeServer(b, a, _, "Auth", c, d)
                            IdleAnim()
                            pa = false
                        end
                    end
                    ba = false
                end
            end
        end
    elseif a == Enum.UserInputState.End or a == Enum.UserInputState.Cancel then
        massVariableArray.MouseHeld = false
    end
end
function MobileSelectFire(_, a, _)
    if a == Enum.UserInputState.Begin then
        if
            not wa and not T and not fa and massVariableArray.curConfig.CanSelectFire and not ja and not la and not pa and not wa and
                not ka and
                not da
         then
            W = true
            T = true
            ja = false
            if Shooting then
                Shooting = false
            end
            SelectFireMode()
            FireModeAnim()
            IdleAnim()
            T = false
        end
        W = false
    end
end
function MobileBolt(_, a, _)
    if a == Enum.UserInputState.Begin then
        if not ea and Ca and not va and not pa and not ma and not ka and not wa and not na and massVariableArray.FireMode ~= 6 then
            ea = true
            la = not la
            if la then
                BoltBackAnim()
                if ta and massVariableArray.Ammo > 0 then
                    CreateShell()
                end
                ea = false
            else
                if massVariableArray.Ammo > 0 then
                    massVariableArray.CanShoot = true
                    Aa = true
                    if ta then
                        massVariableArray.Ammo = massVariableArray.Ammo - 1
                    end
                    ta = true
                end
                BoltForwardAnim()
                IdleAnim()
                ea = false
            end
            UpdateAmmo()
        end
    end
end
function MobileReload(_, _, _)
    if not wa and Ca and not ma and not Shooting and not ya and not la then
        local _ = currentCamera.FieldOfView
        if currentCamera.FieldOfView ~= 70 then
            tweenService:Create(currentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = 70}):Play()
        end
        if not ja and massVariableArray and massVariableArray.Ammo and massVariableArray.curConfig and massVariableArray.curConfig.Ammo and massVariableArray.Ammo < massVariableArray.curConfig.Ammo then
            Aa = massVariableArray.CanShoot
            massVariableArray.CanShoot = false
            if massVariableArray.Ammo > 0 then
                ta = true
                Aa = true
            else
                ta = false
                Aa = false
            end
            if massVariableArray.StoredAmmo > 0 and massVariableArray.Ammo < massVariableArray.curConfig.Ammo then
                Shooting = false
                ma = true
                ReloadAnim()
                if massVariableArray.curConfig.CanAutoBolt then
                    if massVariableArray.Ammo <= 0 then
                        if not massVariableArray.curConfig.CanSlideLock then
                            BoltBackAnim()
                            BoltForwardAnim()
                        end
                    elseif massVariableArray.Ammo > 0 then
                        if not massVariableArray.curConfig.CanSlideLock then
                            if massVariableArray.BoltW.C1 ~= (CFrame.new() or CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)) then
                                BoltBackAnim()
                                BoltForwardAnim()
                            end
                        end
                    end
                end
                IdleAnim()
                if massVariableArray.Ammo <= 0 then
                    if (massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)) < 0 then
                        massVariableArray.Ammo = massVariableArray.Ammo + massVariableArray.StoredAmmo
                        massVariableArray.StoredAmmo = 0
                    else
                        massVariableArray.StoredAmmo = massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)
                        massVariableArray.Ammo = massVariableArray.curConfig.Ammo
                    end
                elseif massVariableArray.Ammo > 0 then
                    if (massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)) < 0 then
                        massVariableArray.Ammo = massVariableArray.Ammo + massVariableArray.StoredAmmo + 1
                        massVariableArray.StoredAmmo = 0
                    else
                        massVariableArray.StoredAmmo = massVariableArray.StoredAmmo - (massVariableArray.curConfig.Ammo - massVariableArray.Ammo)
                        massVariableArray.Ammo = massVariableArray.curConfig.Ammo + 1
                    end
                end
                ma = false
                if massVariableArray.curConfig.CanAutoBolt or ta or massVariableArray.curConfig.CanSlideLock or massVariableArray.FireMode == 6 then
                    massVariableArray.CanShoot = true
                    Aa = true
                end
            end
        elseif ja then
            if massVariableArray.ExplosiveAmmo > 0 then
                Shooting = false
                ma = true
                nadeReload()
                if not ja then
                    IdleAnim()
                else
                    tweenService:Create(massVariableArray.RAW, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {C1 = massVariableArray.curConfig.RightArmPos}):Play(

                    )
                    tweenService:Create(massVariableArray.LAW, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {C1 = massVariableArray.curConfig.GLLeftPos}):Play()
                    task.wait(0.25)
                end
                ma = false
                massVariableArray.CanShoot = true
                G = false
            end
        end
        UpdateAmmo()
        if _ ~= 70 and za then
            tweenService:Create(currentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = _}):Play()
        end
    end
end
function MobileJump(_, a, _)
    if Ca and not va then
        if a == Enum.UserInputState.Begin then
            n = true
            coroutine.resume(
                coroutine.create(
                    function()
                        while task.wait() do
                            if not n then
                                break
                            end
                            playerArms.humanoid.Jump = true
                        end
                    end
                )
            )
        elseif a == Enum.UserInputState.End or a == Enum.UserInputState.Cancel then
            n = false
            task.wait()
            playerArms.humanoid.Jump = false
        end
    end
end
function MobileProne(_, a, _)
    if Ca and not va then
        if a == Enum.UserInputState.Begin then
            if Ca or carbonConfigs.globalConfig.UniversalStances and not oa and not massVariableArray.Seated then
                if not massVariableArray.Seated then
                    ya = false
                    if massVariableArray.StanceIndex == 0 or massVariableArray.StanceIndex == 1 then
                        massVariableArray.StanceIndex = 2
                        changeStance()
                    elseif massVariableArray.StanceIndex == 2 then
                        massVariableArray.StanceIndex = 1
                        changeStance()
                    end
                end
            end
        end
    end
end
function MobileCrouch(_, a, _)
    if Ca and not va then
        if a == Enum.UserInputState.Begin then
            if Ca or carbonConfigs.globalConfig.UniversalStances and not oa and not massVariableArray.Seated then
                if not massVariableArray.Seated then
                    ya = false
                    if massVariableArray.StanceIndex == 0 then
                        massVariableArray.StanceIndex = 1
                        changeStance()
                    elseif massVariableArray.StanceIndex == 1 then
                        massVariableArray.StanceIndex = 0
                        changeStance()
                    elseif massVariableArray.StanceIndex == 2 then
                        massVariableArray.StanceIndex = 1
                        changeStance()
                    end
                end
            end
        end
    end
end
