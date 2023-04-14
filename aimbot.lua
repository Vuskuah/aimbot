function isEnemy(player)
    return player.TeamColor ~= game:GetService("Players").LocalPlayer.TeamColor
end

function getNearestEnemyToCursor()
    local target, dist = nil, math.huge
    for i, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player ~= game:GetService("Players").LocalPlayer and isEnemy(player) then
            local rootPart = player.Character.HumanoidRootPart
            if rootPart.Position.Y > 0 then
                local screenPos, onScreen = workspace.CurrentCamera:WorldToScreenPoint(rootPart.Position)
                local mousePos = game:GetService("UserInputService"):GetMouseLocation()
                local newDist = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                if newDist < dist and onScreen then
                    target = player
                    dist = newDist
                end
            end
        end
    end
    return target
end

function aimbot()
    while true do
        local target = getNearestEnemyToCursor()
        if target then
            local headPos = target.Character.Head.Position
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, headPos)
        end
        wait()
    end
end

aimbot()
