local u1 = game:GetService("UserInputService")
local u2 = require(game.ReplicatedStorage.Modules.UnitsData)
local u3 = game.Players.LocalPlayer
require(game.ReplicatedStorage.Modules.CameraShaker)
local _ = workspace.CurrentCamera
u3:GetMouse().TargetFilter = workspace.PartEffect
local u4 = game.Workspace.CurrentCamera
local u5 = require(game.ReplicatedStorage.Client.Controllers.GamepadController)
local u6 = require(game.ReplicatedStorage.Client.Controllers.MobileController)
local function u9(p7) --[[Anonymous function at line 17]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if u3.Character:FindFirstChild("Humanoid") then
        local v8 = u3.Character.Humanoid:LoadAnimation(p7)
        v8:Play(0)
        return v8
    end
end
local function u11() --[[Anonymous function at line 27]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v10, _ = workspace:FindPartOnRayWithIgnoreList(Ray.new(u3.Character.HumanoidRootPart.Position, (Vector3.new(0, -4, 0))), { workspace.PlayerFodel, workspace.PartEffect, workspace.Enemy })
    return v10 ~= nil
end
local u12 = tick()
local u13 = 1
getfenv()
local function BodyVelocityLook(p14, p15, p16)
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
        [3] = u4
    --]]
    local v17 = u3.Character.Target.Value
    local v18 = Instance.new("BodyVelocity", p14.HumanoidRootPart)
    v18.MaxForce = Vector3.one * 25000
    v18.Velocity = p14.HumanoidRootPart.CFrame.LookVector * p15
    game.Debris:AddItem(v18, 0.4)
    if (v17 == nil or u1.MouseBehavior == Enum.MouseBehavior.LockCenter) and (v17 == nil or p16 == nil) then
        local v19 = u4.CFrame.LookVector.X * 900000
        local v20 = u3.Character.HumanoidRootPart.Position.Y
        local v21 = u4.CFrame.LookVector.Z * 900000
        local v22 = Vector3.new(v19, v20, v21)
        u3.Character.HumanoidRootPart.CFrame = CFrame.new(u3.Character.HumanoidRootPart.Position, v22)
    else
        local v23 = v17.HumanoidRootPart.Position.X
        local v24 = u3.Character.HumanoidRootPart.Position.Y
        local v25 = v17.HumanoidRootPart.Position.Z
        local v26 = Vector3.new(v23, v24, v25)
        u3.Character.HumanoidRootPart.CFrame = CFrame.new(u3.Character.HumanoidRootPart.Position, v26)
    end
end


function Combat()
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u11
        [4] = u12
        [5] = u13
        [6] = u9
    --]]
    if u3.Character:FindFirstChild("Humanoid") then
        if u3.Character:FindFirstChild("Hit") then
            return
        elseif u3.Character.Stastus.Value == "" then
            if u3.Character.Parent.Name == "PlayerFodel" then
                if u3.Character.Humanoid.Sit == true then
                    return
                elseif u3.Character.Skill.Value == true then
                    return
                elseif u3.Character:FindFirstChild("Death") then
                    return
                elseif u3.CharValue.Lost.Value ~= true then
                    game.ReplicatedStorage.PlayerData:FindFirstChild(u3.Name)
                    local v27 = u3.CharValue:FindFirstChild("Slot" .. u3.Character.Onslot.Value).Units
                    if u2[v27.Value] and u11() then
                        local v28 = u2[v27.Value]
                        if tick() - u12 > v28.ResetCombo and u13 <= #v28.Animations then
                            u13 = 1
                        end
                        if u13 <= #v28.Animations and tick() - u12 > v28.TimePerAttack then
                            u9(v28.Animations[u13])
                            if game.ReplicatedFirst.SkillUnits:FindFirstChild(v27.Value) then
                                game.ReplicatedFirst.SkillUnits:FindFirstChild(v27.Value).Slash.Event:Fire(u3.Character, u13, v27.Value, u3.Character.Target.Value)
                            end
                            local v29 = game.ReplicatedStorage.Sound.Attack:FindFirstChild(v27.Value):FindFirstChild("Sound" .. u13):Clone()
                            game.Debris:AddItem(v29, 4)
                            v29.Parent = u3.Character.HumanoidRootPart
                            v29:Play()
                            game.ReplicatedStorage.Events.Combat:FireServer(v27.Value, u13)
                            u12 = tick()
                            u13 = u13 + 1
                            if u3.Character.Shoot.Value == true then
                                BodyVelocityLook(u3.Character, -6, true)
                                u3.Character.UnlockCam.Value = true
                            else
                                BodyVelocityLook(u3.Character, 9)
                            end
                            local v30 = u13
                            u3.Character.Humanoid.AutoRotate = false
                            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 4
                            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
                            u3.Character.Skill.Value = true
                            wait(v28.TimePerAttack)
                            u3.Character.Skill.Value = false
                            if u13 == v30 and u3.Character.Skill.Value == false then
                                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 25
                                u3.Character.Humanoid.AutoRotate = true
                                game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
                                u3.Character.UnlockCam.Value = false
                            end
                        end
                        if u13 > #v28.Animations and tick() - u12 > v28.ComboCooldown then
                            u13 = 1
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
end

local CombateModule = {
    Combat
}

return CombateModule
