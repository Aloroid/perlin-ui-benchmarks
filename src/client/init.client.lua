local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

workspace.CurrentCamera.FieldOfView = 1
workspace.CurrentCamera.CFrame = CFrame.fromMatrix(Vector3.zero, Vector3.zero, Vector3.zero)

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

local ui_component = "vide"
local component = ReplicatedStorage.Shared.Components:FindFirstChild(ui_component)

assert(component, `component {ui_component} does not exist`)

print('running')
require(component)()