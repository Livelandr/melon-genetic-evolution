AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
util.AddNetworkString("MelonGeneticEvolution_ChatMessage")

function ENT:Initialize()
 
	self:SetModel( "models/props_junk/watermelon01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
    self:SetUseType(SIMPLE_USE)


    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

    self.lastBreed = 0
    self.lastRadiationAffect = 0 

    self.chromosome = self.chromosome or MelonGeneticEvolution.GenerateChromosome()

    -- Genetic setup
    self.GeneticInfo = self.GeneticInfo or {
        chromosome = "",
        color = Color(0,0,0),
        size = 1,
        speed = 1,
    }



    self:FragmentCalculation()
    self:SetupAccordingToGenes()


end


function ENT:FragmentCalculation()

    self.GeneticInfo.Fragments = {}

    local division = math.max(math.floor(string.len(self.chromosome) / 25), 1)

    for i = 1, 25 do -- Creating data fragments
        for j = 1, division do
            self.GeneticInfo.Fragments[i] = math.abs( (self.GeneticInfo.Fragments[i] or 1) 
            - string.byte( self.chromosome[ math.max((i*j) 
            % string.len(self.chromosome), 1)] ) )
        end
    end

end


function ENT:SetupAccordingToGenes()

    local trailMaterials = {
        "trails/love",
        "trails/smoke",
        "trails/physbeam",
        "trails/tube",
        "trails/electric",
        "trails/plasma",
        "trails/laser",
        "trails/lol"
    }

    local materials = {
        "brick/brick_model",
        "hunter/myplastic",
        "models/XQM//LightLinesRed",
        "models/XQM/BoxFull_diffuse",
        "models/alyx/emptool_glow",
        "models/combine_advisor/mask",
        "models/effects/splode_sheet",
        "models/props_c17/frostedglass_01a",
        "models/props_combine/com_shield001a",
        "models/props_combine/combine_interface_disp",
        "models/props_combine/stasisshield_sheet",
        "models/props_combine/tprings_globe",
        "models/props_lab/cornerunit_cloud",
        "models/props_lab/warp_sheet",
        "models/props_lab/xencrystal_sheet",
        "models/shadertest/shader3",
        "models/shadertest/shader4",
        "models/weapons/v_slam/new light1",
        "models/weapons/v_slam/new light2",
        "phoenix_storms/wire/pcb_red",
        "phoenix_storms/wire/pcb_blue",
        "phoenix_storms/wire/pcb_green",
        "phoenix_storms/scrnspace",
        "phoenix_storms/metal_wheel"
    }

    -- Calculating melon color
    self.GeneticInfo.color.r = (255 * self.GeneticInfo.Fragments[4] / (self.GeneticInfo.Fragments[2] * (self.GeneticInfo.Fragments[1] / self.GeneticInfo.Fragments[3]))) % 255
    self.GeneticInfo.color.g = (255 * self.GeneticInfo.Fragments[15] / (self.GeneticInfo.Fragments[5] * (self.GeneticInfo.Fragments[6] / self.GeneticInfo.Fragments[9]))) % 255
    self.GeneticInfo.color.b = (255 * self.GeneticInfo.Fragments[19] / (self.GeneticInfo.Fragments[23] * (self.GeneticInfo.Fragments[8] / self.GeneticInfo.Fragments[11]))) % 255

    self:SetColor( self.GeneticInfo.color )
    
    -- Calculating melon size
    self.GeneticInfo.size = math.Clamp( math.sqrt( self.GeneticInfo.Fragments[6] * self.GeneticInfo.Fragments[7] ) % 15 / 5, 0.75, 10)
    
	self:Activate() -- Avoid hitbox scale bug

    self:SetModelScale(self.GeneticInfo.size, 0) -- Setup Scale
    self:SetHealth(15 * self.GeneticInfo.size)
   
    -- Calculating melon speed
    self.GeneticInfo.speed = self.GeneticInfo.Fragments[16] / self.GeneticInfo.Fragments[4]

    -- Calculating melon flight
    self.GeneticInfo.flight = self.GeneticInfo.Fragments[8] / self.GeneticInfo.Fragments[4]
    

    self.GeneticInfo.MaterialChance = 1 > (self.GeneticInfo.Fragments[23] * self.GeneticInfo.Fragments[12]) / (self.GeneticInfo.Fragments[19] * self.GeneticInfo.Fragments[15]) 
    if self.GeneticInfo.MaterialChance then
        
        local materialID = self.GeneticInfo.Fragments[23] * self.GeneticInfo.Fragments[10] / self.GeneticInfo.Fragments[25] * self.GeneticInfo.Fragments[15]

        self:SetMaterial( materials[ 1 + (materialID % #materials) ] )

    end


    -- Some special melons

    if (self.chromosome == "Komenci Sian Vojon Kiel") then
        self:SetMaterial("models/combine_advisor/mask")
        
        self:SetColor(Color(100,100,100))

        util.SpriteTrail( self, 0, Color(255, 0, 0), false, 12, 0, 5, 1 / ( 12 ) * 0.5, "trails/smoke" )
    end

    -- end


    self.GeneticInfo.RainbowChance = 0.3 > (self.GeneticInfo.Fragments[12] * self.GeneticInfo.Fragments[22]) / (self.GeneticInfo.Fragments[12] * self.GeneticInfo.Fragments[11]) 

    self.GeneticInfo.TrailExist = 0.5 > (self.GeneticInfo.Fragments[6] * self.GeneticInfo.Fragments[16]) / (self.GeneticInfo.Fragments[11] * self.GeneticInfo.Fragments[23]) 
    if self.GeneticInfo.TrailExist then
        self.GeneticInfo.TrailLifetime = math.sqrt( self.GeneticInfo.Fragments[9] * self.GeneticInfo.Fragments[21] ) % 10

        local w1, w2 = math.sqrt( self.GeneticInfo.Fragments[15] * self.GeneticInfo.Fragments[22] ) % 45, math.sqrt( self.GeneticInfo.Fragments[16] * self.GeneticInfo.Fragments[20] ) % 45 

        self.GeneticInfo.TrailStartWidth = w1
        self.GeneticInfo.TrailEndWidth = w2  

        self.GeneticInfo.trailMat = trailMaterials[ math.ceil(1 +(self.GeneticInfo.Fragments[22] / self.GeneticInfo.Fragments[11]) % #trailMaterials) ]
    
        

        util.SpriteTrail( self, 0, self:GetColor(), false, self.GeneticInfo.TrailStartWidth, self.GeneticInfo.TrailEndWidth, self.GeneticInfo.TrailLifetime, 1 / ( self.GeneticInfo.TrailStartWidth + self.GeneticInfo.TrailEndWidth ) * 0.5, self.GeneticInfo.trailMat )
    end


    self.GeneticInfo.RetardChance = 0.1 > (self.GeneticInfo.Fragments[22] * self.GeneticInfo.Fragments[7]) / (self.GeneticInfo.Fragments[4] * self.GeneticInfo.Fragments[9]) 
    if self.GeneticInfo.RetardChance then
        self:SetModel("models/props_junk/watermelon01_chunk01c.mdl")
        self:SetHealth(1)
    
        self.GeneticInfo.speed = 0.01

    end

end


function ENT:Think()

    if self.GeneticInfo.RainbowChance then
        self:SetColor( HSVToColor((SysTime() * 75) % 360, 1, 1) )
    end

end

function ENT:Touch(ent) -- Breeding

    if ent == self then return end

    if ent:GetClass() ~= "mge_melon" then return end
    if ent:EntIndex() > self:EntIndex() then return end 

    if ent.lastBreed > CurTime() or self.lastBreed > CurTime() then return end

    if MelonGeneticEvolution.MelonsAmount() >= GetConVar("mge_maxmelons"):GetInt() then return end

    local child = ents.Create("mge_melon")
    child:SetPos(self:GetPos() + Vector(0,0,15))
    child.chromosome = MelonGeneticEvolution.MateChromosomes(ent.chromosome, self.chromosome)

    child:Spawn()
    child:SetupAccordingToGenes() -- Precaution

    child:EmitSound("garrysmod/balloon_pop_cute.wav")

    ent.lastBreed = CurTime() + GetConVar("mge_breedcooldown"):GetInt()
    self.lastBreed = CurTime() + GetConVar("mge_breedcooldown"):GetInt()

    if GetConVar("mge_destroyparents"):GetBool() then
        ent:Remove()
        self:Remove()
    end

end


function ENT:OnTakeDamage( dmginfo )
	if ( not self.m_bApplyingDamage ) then
		self.m_bApplyingDamage = true
        
        self:SetHealth( self:Health() - dmginfo:GetDamage() )

            self:EmitSound("npc/zombie/zombie_voice_idle" .. math.random(1, 14) .. ".wav", 75, 275 - (25 * self.GeneticInfo.size)) -- Scream pitch is proportional to size

        if (self:Health() <= 0) then
            self:Remove()
        end 

		self.m_bApplyingDamage = false
	end
end


function ENT:Use(ply)
    
    local msg = {Color(255, 255, 255), "Hi! My chromosome is: ", Color(0,115,255), self.chromosome }
    
    net.Start("MelonGeneticEvolution_ChatMessage")
    net.WriteTable(msg)
    net.Send(ply)

end


function ENT:PhysicsUpdate( phys )

    local moveVector = Vector(
        math.random(-25, 25) * self.GeneticInfo.speed,
        math.random(-25, 25) * self.GeneticInfo.speed,
        math.random(-10, 25 * self.GeneticInfo.flight / 2)
    )

    phys:ApplyForceCenter(phys:GetMass() * moveVector * 1.5 )
end