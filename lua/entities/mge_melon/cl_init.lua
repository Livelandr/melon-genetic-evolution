 
include('shared.lua')

function ENT:Draw()
    self:DrawModel() 
end

net.Receive("MelonGeneticEvolution_ChatMessage", function()
	
	local msg = net.ReadTable()

	chat.PlaySound()
	chat.AddText( unpack(msg) )

end)