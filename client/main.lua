local target = vector3(99.992218017578, 6619.7651367188, 32.0) --Paleto Bay, northern gas station garage

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local coords = GetEntityCoords(PlayerPedId())
		if #(coords - target) < 3 then
			DrawText3D(target[1], target[2], target[3], "[~b~E~s~] - Lockpick drawer")
			sleep=1
			if IsControlJustReleased(0, 38) and #(coords - target) < 1 then
				TaskStartScenarioAtPosition(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", coords, GetEntityHeading(PlayerPedId()), 0, 0, false)
				Citizen.Wait(1000)
				if exports["k5_skillcheck"]:skillCheck() then
					Citizen.Wait(1000)
					if exports["k5_skillcheck"]:skillCheck() then
						Citizen.Wait(1000)
						if exports["k5_skillcheck"]:skillCheck() then
							print("SUCCESS")
							ClearPedTasks(PlayerPedId())
						else
							print("FAILED")
							ClearPedTasks(PlayerPedId())
						end
					else
						print("FAILED")
						ClearPedTasks(PlayerPedId())
					end
				else
					print("FAILED")
					ClearPedTasks(PlayerPedId())
				end
			end
		end
		Citizen.Wait(sleep)
	end
	
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.002+ factor, 0.03, 0, 0, 0, 100)
end