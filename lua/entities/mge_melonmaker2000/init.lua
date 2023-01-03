AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')

util.AddNetworkString("MelonGeneticEvolution_OpenMelonmakerMenu")
util.AddNetworkString("MelonGeneticEvolution_MelonmakerRequest")


function ENT:Initialize()
    self:SetModel( "models/props_wasteland/kitchen_stove001a.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS ) 
    self:SetUseType(SIMPLE_USE)

    self.lastCooldown = 0

    local phys = self:GetPhysicsObject()
    if(phys:IsValid()) then phys:Wake() end


    net.Receive("MelonGeneticEvolution_MelonmakerRequest", function(len, ply)
        local ent = net.ReadEntity()

        if ent ~= self or ent:GetPos():Distance(ply:GetPos()) > 200 then return end
        if self.lastCooldown > CurTime() then return end



        self.lastCooldown = CurTime() + 3

        self:EmitSound("vehicles/tank_readyfire1.wav")


        local chromosome = net.ReadString()


        if ( string.lower(chromosome) == "melon" or string.lower(chromosome) == "watermelon") then
            
            timer.Simple(3, function()
                self:EmitSound("common/stuck2.wav") 
            end)
            
            return 
            
        end
        

        local melon = ents.Create("mge_melon")
        melon:SetPos( self:GetPos() + Vector(0,0,50) )
        melon.chromosome = chromosome

        timer.Simple(3, function()
            self:EmitSound("garrysmod/save_load" .. math.random(1, 4) .. ".wav")
            melon:Spawn()
        end)


    end)

end

function ENT:Use(ply)

    if self.lastCooldown > CurTime() then return end

    net.Start("MelonGeneticEvolution_OpenMelonmakerMenu")
    net.WriteEntity(self)
    net.Send(ply)

end