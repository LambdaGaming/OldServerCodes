AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "cis_life" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props/starwars/tech/machine.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetColor( Color(0, 0, 175, 255) )
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	self:SetHealth(150)
	self:SetMaxHealth(150)
end

function ENT:Use(caller, activator)
	caller:ChatPrint("Life support health: "..( math.Round( self:Health(), 1 ) )..".")
end

function ENT:OnTakeDamage()
	if self:Health() <= 0 then return end
	self:SetHealth( self:Health() -2 )
	if self:Health() <= 0 then
		local explode = ents.Create( "env_explosion" )
		explode:SetPos( self.Entity:GetPos() + Vector( 0, 0, 500 ) )
		explode:Spawn()
		explode:SetKeyValue( "iMagnitude", "0" )
		explode:Fire( "Explode", 0, 0 )
		for k,v in pairs(player.GetAll()) do
			v:ChatPrint("The CIS life support has been destroyed!")
		end
	end
end

function ENT:Think()
if self:Health() >= self:GetMaxHealth() then self:SetHealth(self:GetMaxHealth()) end
local isdamaged = self:GetColor() == Color( 30, 30, 30 ) and self:IsOnFire()
	if self:Health() <= 0 and !isdamaged then
		self:SetColor( Color( 30, 30, 30 ) )
		self:Ignite()
	end
	
	if self:Health() >= self:GetMaxHealth() then
		self:SetColor( Color(0, 0, 175, 255) )
		self:Extinguish()
	end
end