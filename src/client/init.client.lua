local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local PARENT_TO_PLAYERGUI = false

workspace.CurrentCamera.FieldOfView = 1
workspace.CurrentCamera.CFrame = CFrame.fromMatrix(Vector3.zero, Vector3.zero, Vector3.zero)

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

local ui_component = "react_state"
local component = ReplicatedStorage.Shared.Components:FindFirstChild(ui_component)
local parent = if PARENT_TO_PLAYERGUI then Players.LocalPlayer.PlayerGui else Instance.new("Folder")

Players.LocalPlayer.PlayerGui:ClearAllChildren()

assert(component, `component {ui_component} does not exist`)

print('running', ui_component)

require(component)(parent)
task.wait(1)
require(ReplicatedStorage.Shared.Components.display_fps)()