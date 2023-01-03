MelonGeneticEvolution = MelonGeneticEvolution or {}


CreateConVar( "mge_chromosomelength", 20, FCVAR_NONE, "Length of generated chromosomes, increase to get more enthropy and lags", 1, 1000 )
CreateConVar( "mge_destroyparents", 0, FCVAR_NONE, "Remove parents after breeding", 0, 1 )
CreateConVar( "mge_breedcooldown", 5, FCVAR_NONE, "Breed cooldown", 1, 3600 )
CreateConVar( "mge_maxmelons", 100, FCVAR_NONE, "How much melons can exist at the same time", 1, 3600 )


MelonGeneticEvolution.AvaliableGenes = "1234567890-+=()[]/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
 
concommand.Add( "mge_variationsamount", function( ply, cmd, args )
    print("Current chromosome variations amount: ", math.pow( string.len(MelonGeneticEvolution.AvaliableGenes), GetConVar("mge_chromosomelength"):GetInt() ))
end )

concommand.Add( "mge_clearmelons", function( ply, cmd, args )

    if not ply:IsAdmin() then return end

    local i = 0
    
    for k, v in pairs(ents.GetAll()) do
        if v:GetClass() == "mge_melon" then 
            v:Remove()
            i = i + 1
        end
    end

    print("Removed " .. i .. " melons!")
end )

function MelonGeneticEvolution.MelonsAmount()
    local i = 0

    for k, v in pairs(ents.GetAll()) do
        if (v:GetClass() == "mge_melon") then
            i = i + 1
        end
    end

    return i
end

function MelonGeneticEvolution.RandomGen()
    return MelonGeneticEvolution.AvaliableGenes[ math.random(1, string.len(MelonGeneticEvolution.AvaliableGenes)) ]
end

function MelonGeneticEvolution.MateChromosomes(first, second)

    local chromo = ""
    local length = math.random( string.len(first), string.len(second) )
    
    for i = 0, length do 
        local chance = math.random(0, 100) 

        if (chance < 50) and string.len(first) >= i then
            chromo = chromo .. first[i]
        elseif (chance < 99) and string.len(second) >= i then
            chromo = chromo .. second[i]
        else
            chromo = chromo .. MelonGeneticEvolution.RandomGen()
        end
    end

    return chromo

end

function MelonGeneticEvolution.GenerateChromosome(length)
    length = length or GetConVar("mge_chromosomelength"):GetInt()

    local newChromosome = ""

    for i = 0, length do
        newChromosome = newChromosome .. MelonGeneticEvolution.RandomGen()
    end

    
    return newChromosome
end