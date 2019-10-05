
local function ChopMenu( ply, ent )
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Rental Car Actions" )
	mainframe:SetSize( 300, 300 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_MENU_COLOR )
	end
	local rentbutton = vgui.Create( "DButton", mainframe )
	rentbutton:SetText( "Rent Vehicle" )
	rentbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	rentbutton:SetPos( 25, 50 )
	rentbutton:SetSize( 250, 30 )
	rentbutton:CenterHorizontal()
	rentbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	rentbutton.DoClick = function()
		net.Start( "RentVehicle" )
		net.WriteEntity( ent )
		net.SendToServer()
		mainframe:Close()
		surface.PlaySound( CRAFT_CONFIG_UI_SOUND )
    end
	local returnbutton = vgui.Create( "DButton", mainframe )
	returnbutton:SetText( "Return Vehicle (If Rented)" )
	returnbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	returnbutton:SetPos( 25, 100 )
	returnbutton:SetSize( 250, 30 )
	returnbutton:CenterHorizontal()
	returnbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	returnbutton.DoClick = function()
		net.Start( "ReturnVehicle" )
		net.WriteEntity( ent )
		net.SendToServer()
		mainframe:Close()
		surface.PlaySound( CRAFT_CONFIG_UI_SOUND )
	end
	local stealbutton = vgui.Create( "DButton", mainframe )
	stealbutton:SetText( "Sell Vehicle (If Stolen)" )
	stealbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	stealbutton:SetPos( 25, 150 )
	stealbutton:SetSize( 250, 30 )
	stealbutton:CenterHorizontal()
	stealbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	stealbutton.DoClick = function()
		net.Start( "StealVehicle" )
		net.WriteEntity( ent )
		net.SendToServer()
		mainframe:Close()
		surface.PlaySound( CRAFT_CONFIG_UI_SOUND )
	end
	local enterbutton = vgui.Create( "DButton", mainframe )
	enterbutton:SetText( "Enter Vehicle" )
	enterbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	enterbutton:SetPos( 25, 200 )
	enterbutton:SetSize( 250, 30 )
	enterbutton:CenterHorizontal()
	enterbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	enterbutton.DoClick = function()
		net.Start( "EnterRental" )
		net.WriteEntity( ent )
		net.SendToServer()
		mainframe:Close()
		surface.PlaySound( CRAFT_CONFIG_UI_SOUND )
	end
end

net.Receive( "ChopCarMenu", function( len, ply )
	local ent = net.ReadEntity()
	ChopMenu( ply, ent )
end )