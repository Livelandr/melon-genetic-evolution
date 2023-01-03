 
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Melonus"
ENT.Author			= "Livelandr"
ENT.Contact			= "???"
ENT.Purpose			= "Idk"
ENT.Instructions	= "God made him simple, genetic evolution made him god"

ENT.Category = "Melon Genetic Evolution"

ENT.Spawnable = true



function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "LightSize" )
	self:NetworkVar( "Float", 1, "LightBrightness" )
end