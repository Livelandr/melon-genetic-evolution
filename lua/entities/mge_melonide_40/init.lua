AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
function ENT:Initialize()
 
	self:SetModel( "models/props_junk/cardboard_box001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
    self:SetUseType(SIMPLE_USE)


    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

    self:SetMaterial("models/props_lab/xencrystal_sheet")

    self:EmitSound("player/geiger" .. math.random(1, 3) .. ".wav")

end

local function replace_char(pos, str, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end

function ENT:Think()

    local foundEnts = ents.FindInSphere(self:GetPos(), 150)

    for k, v in pairs(foundEnts) do
        if v:GetClass() == "mge_melon" and v.lastRadiationAffect <= SysTime() then
            
            v.chromosome = replace_char( math.random(1, string.len(v.chromosome) ) , v.chromosome, MelonGeneticEvolution.RandomGen())

            self:EmitSound("player/geiger" .. math.random(1, 3) .. ".wav")
            v.lastRadiationAffect = SysTime() + v:GetPos():Distance(self:GetPos()) / 150 / 2
            v:FragmentCalculation()
            v:SetupAccordingToGenes()

        end
    end

end