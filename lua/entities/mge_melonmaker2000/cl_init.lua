local save = {
    [1] = {
        ["children"] = {
            [1] = {
                ["children"] = {
                    [1] = {
                        ["children"] = {
                        },
                        ["self"] = {
                            ["Angles"] = Angle(-9.9376247817418e-06, 90, 90),
                            ["Position"] = Vector(1.9441070556641, -3.0267944335938, 24.27596282959),
                            ["ClassName"] = "model2",
                            ["Size"] = 0.65,
                            ["Model"] = "models/maxofs2d/thruster_propeller.mdl",
                        },
                    },
                    [2] = {
                        ["children"] = {
                        },
                        ["self"] = {
                            ["Model"] = "models/props_wasteland/prison_lamp001c.mdl",
                            ["Position"] = Vector(-0.000213623046875, -10.072937011719, 31.406286239624),
                            ["Angles"] = Angle(3.3350534778265e-08, -1.8464340882929e-06, -57.520904541016),
                            ["Size"] = 1,
                            ["ClassName"] = "model2",
                        },
                    },
                    [3] = {
                        ["children"] = {
                            [1] = {
                                ["children"] = {
                                },
                                ["self"] = {
                                    ["Model"] = "models/props_wasteland/buoy01.mdl",
                                    ["Position"] = Vector(1.52587890625e-05, 0, 5.2507042884827),
                                    ["Angles"] = Angle(0, 0, 0),
                                    ["Size"] = 0.175,
                                    ["ClassName"] = "model2",
                                },
                            },
                        },
                        ["self"] = {
                            ["Position"] = Vector(-3.0517578125e-05, 9.2828979492188, 42.932231903076),
                            ["ClassName"] = "model2",
                            ["Angles"] = Angle(0, 0, 0),
                            ["Size"] = 1,
                            ["Model"] = "models/props_junk/MetalBucket01a.mdl",
                        },
                    },
                    [4] = {
                        ["children"] = {
                        },
                        ["self"] = {
                            ["Angles"] = Angle(-9.9376247817418e-06, 90, 90),
                            ["Position"] = Vector(1.9440765380859, 11.688171386719, 24.275922775269),
                            ["ClassName"] = "model2",
                            ["Size"] = 0.65,
                            ["Model"] = "models/maxofs2d/thruster_propeller.mdl",
                        },
                    },
                    [5] = {
                        ["children"] = {
                            [1] = {
                                ["children"] = {
                                },
                                ["self"] = {
                                    ["Angles"] = Angle(2.6680423204084e-08, -27.239589691162, -29.458431243896),
                                    ["Position"] = Vector(-6.103515625e-05, 0, 4.2676115036011),
                                    ["ClassName"] = "model2",
                                    ["Size"] = 0.275,
                                    ["Model"] = "models/props_junk/watermelon01.mdl",
                                },
                            },
                        },
                        ["self"] = {
                            ["Angles"] = Angle(-1.3340215154756e-08, -109.3237991333, 6.6701066891994e-09),
                            ["Position"] = Vector(-3.4447631835938, -2.9163208007813, 35.463424682617),
                            ["ClassName"] = "model2",
                            ["Size"] = 1,
                            ["Model"] = "models/props_junk/glassjug01.mdl",
                        },
                    },
                },
                ["self"] = {
                    ["Angles"] = Angle(0, 0, 0),
                    ["Position"] = Vector(1.52587890625e-05, 42.122863769531, 35.0339012146),
                    ["ClassName"] = "model2",
                    ["Size"] = 1,
                    ["Model"] = "models/props_lab/reciever_cart.mdl",
                },
            },
            [2] = {
                ["children"] = {
                },
                ["self"] = {
                    ["Angles"] = Angle(0, 0, 0),
                    ["Position"] = Vector(10.262176513672, -14.41748046875, 28.275527954102),
                    ["ClassName"] = "model2",
                    ["Size"] = 0.75,
                    ["Model"] = "models/props_lab/reciever01b.mdl",
                },
            },
            [3] = {
                ["children"] = {
                },
                ["self"] = {
                    ["Angles"] = Angle(2.0010320511687e-08, -1.389388444295e-07, 90),
                    ["Position"] = Vector(-0.92668151855469, 18.860778808594, 40.968997955322),
                    ["ClassName"] = "model2",
                    ["Size"] = 1,
                    ["Model"] = "models/props_c17/streetsign004e.mdl",
                },
            },
            [4] = {
                ["children"] = {
                },
                ["self"] = {
                    ["Angles"] = Angle(0, 0, 0),
                    ["Position"] = Vector(-7.8778381347656, -15.502563476563, 58.75267791748),
                    ["ClassName"] = "model2",
                    ["Size"] = 1,
                    ["Model"] = "models/props_lab/monitor01a.mdl",
                },
            },
            [5] = {
                ["children"] = {
                },
                ["self"] = {
                    ["Angles"] = Angle(0, 0, 0),
                    ["Position"] = Vector(9.5832977294922, -13.676025390625, 47.274711608887),
                    ["ClassName"] = "model2",
                    ["Size"] = 1,
                    ["Model"] = "models/props_c17/computer01_keyboard.mdl",
                },
            },
            [6] = {
                ["children"] = {
                },
                ["self"] = {
                    ["Skin"] = 0,
                    ["Angles"] = Angle(0, 0, 0),
                    ["Position"] = Vector(-11.4599609375, 19.141418457031, 59.380847930908),
                    ["ClassName"] = "model2",
                    ["Size"] = 1,
                    ["Model"] = "models/props_trainstation/TrackSign03.mdl",
                },
            },
        },
    },
    
}


include('shared.lua')

function ENT:Draw()
    self:DrawModel() 
end



-- Model render
local main

local function GetAllChildren(parent, tbl)
    
    for k, v in pairs(tbl["children"]) do
        local data = v.self

        if data.ClassName ~= "model2" and data.ClassName ~= "model" then continue end
        
        local model = ents.CreateClientProp()
        model:SetParent(parent)
        model:SetAngles( parent:LocalToWorldAngles(data["Angles"]) )
        
        model:SetPos(parent:LocalToWorld(data["Position"]))
        model:SetModel(data["Model"])
        model:SetModelScale(data["Size"])

        model:Spawn()
        
        table.insert(main.clientChildren, model)

        if #v.children > 0 then
            GetAllChildren(model, v)
        end

    end

end


function ENT:OpenMelonMenu()

    local inputMenu = vgui.Create("DFrame")
    inputMenu:SetSize( ScrW() * 0.25, ScrH() / 10 )
    inputMenu:MakePopup()
    inputMenu:SetTitle("Melon-Maker 2000: The best melon genetic engineering interface")
    inputMenu:Center()

    local inputPanel = vgui.Create("DTextEntry", inputMenu)
	inputPanel:Dock( TOP )
	inputPanel:DockMargin( 0, 5, 0, 0 )
	inputPanel:SetPlaceholderText( "INPUT CHROMOSOME" )

    local createButton = vgui.Create("DButton", inputMenu)
    createButton:Dock(BOTTOM)
    createButton:SetText("GENERATE MELON")

    createButton.DoClick = function()
        if inputPanel:GetValue() == "" then 
            inputMenu:Close()
            return
        end

        inputMenu:Close()


        net.Start("MelonGeneticEvolution_MelonmakerRequest")
            net.WriteEntity(self)
            net.WriteString(inputPanel:GetValue())
        net.SendToServer()

    end

end

function ENT:Initialize()
    self.clientChildren = {}
    main = self

    GetAllChildren(self, save[1])


    net.Receive("MelonGeneticEvolution_OpenMelonmakerMenu", function()

        local ent = net.ReadEntity()

        if ent ~= self then return end

        self:OpenMelonMenu()

    end)



end

function ENT:OnRemove()
    if not self.clientChildren then return end

    for k, v in pairs(self.clientChildren) do
        if IsValid(v) then
            v:Remove()
        end
    end
end