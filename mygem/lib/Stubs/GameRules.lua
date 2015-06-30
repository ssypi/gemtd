GameRules = {}

-- Kills the ancient, etc.
function GameRules:Defeated(  )
end

-- true when we have waited some time after end of the game and not received signout
-- Returns bool
function GameRules:DidMatchSignoutTimeOut(  )
val = 1
return val
end

-- Returns the difficulty level of the custom game mode
-- Returns int
function GameRules:GetCustomGameDifficulty(  )
val = 1
return val
end

-- Returns difficulty level of the custom game mode
-- Returns int
function GameRules:GetDifficulty(  )
val = 1
return val
end

-- Gets the Xth dropped item
---- int dropIndex
-- Returns handle
function GameRules:GetDroppedItem( dropIndex )
val = 1
return val
end

-- Get the game mode entity
-- Returns handle
function GameRules:GetGameModeEntity(  )
val = 1
return val
end

-- Returns the number of seconds elapsed since map start. This time doesn't count up when the game is paused
-- Returns float
function GameRules:GetGameTime(  )
val = 1
return val
end

-- Have we received the post match signout message that includes reward information
-- Returns bool
function GameRules:GetMatchSignoutComplete(  )
val = 1
return val
end

-- Gets the start time for the Nian fight
-- Returns float
function GameRules:GetNianFightStartTime(  )
val = 1
return val
end

-- For New Bloom, get total damage taken by the Nian / Year Beast
-- Returns int
function GameRules:GetNianTotalDamageTaken(  )
val = 1
return val
end

-- Get the time of day
-- Returns float
function GameRules:GetTimeOfDay(  )
val = 1
return val
end

-- Is it day time.
-- Returns bool
function GameRules:IsDaytime(  )
val = 1
return val
end

-- Makes ths specified team lose
---- int team
function GameRules:MakeTeamLose( team )
end

-- Returns the number of items currently dropped on the ground
-- Returns int
function GameRules:NumDroppedItems(  )
val = 1
return val
end

-- Updates custom hero, unit and ability KeyValues in memory with the latest values from disk
function GameRules:Playtesting_UpdateAddOnKeyValues(  )
end

-- Restart after killing the ancient, etc.
function GameRules:ResetDefeated(  )
end

-- Restart the game at hero selection
function GameRules:ResetToHeroSelection(  )
end

-- Displays a line of text in the left textbox (where usually deaths/denies/buysbacks are announced). This function takes restricted HTML as input! (&lt;br&gt;,&lt;u&gt;,&lt;font&gt;)
---- string message, int teamID, int unknown
function GameRules:SendCustomMessage( message, teamID, unknown )
end

-- Scale the creep icons on the minimap.
---- float scale
function GameRules:SetCreepMinimapIconScale( scale )
end

-- Set the difficulty level of the custom game mode
---- int a
function GameRules:SetCustomGameDifficulty( a )
end

-- Sets whether First Blood has been triggered.
---- bool a
function GameRules:SetFirstBloodActive( a )
end

-- Makes ths specified team win
---- int team
function GameRules:SetGameWinner( team )
end

-- Set the auto gold increase per timed interval.
---- int a
function GameRules:SetGoldPerTick( a )
end

-- Set the time interval between auto gold increases.
---- float a
function GameRules:SetGoldTickTime( a )
end

-- (nMinimapHeroIconSize) - Set the hero minimap icon size.
---- int iconSize
function GameRules:SetHeroMinimapIconSize( iconSize )
end

-- Control if the normal DOTA hero respawn rules apply.
---- bool canRespawn
function GameRules:SetHeroRespawnEnabled( canRespawn )
end

-- Sets the amount of time players have to pick their hero.
---- float time
function GameRules:SetHeroSelectionTime( time )
end

-- Sets the start time for the Nian fight
---- float a
function GameRules:SetNianFightStartTime( a )
end

-- Show this unit's health on the overlay health bar
---- handle unit, int style
function GameRules:SetOverlayHealthBarUnit( unit, style )
end

-- Sets the amount of time players have between the game ending and the server disconnecting them.
---- float time
function GameRules:SetPostGameTime( time )
end

-- Sets the amount of time players have between picking their hero and game start.
---- float time
function GameRules:SetPreGameTime( time )
end

-- Scale the rune icons on the minimap.
---- float scale
function GameRules:SetRuneMinimapIconScale( scale )
end

-- Sets the amount of time between rune spawns.
---- float time
function GameRules:SetRuneSpawnTime( time )
end

-- Mark this game as safe to leave.
---- bool safeToLeave
function GameRules:SetSafeToLeave( safeToLeave )
end

-- When true, players can repeatedly pick the same hero.
---- bool enabled
function GameRules:SetSameHeroSelectionEnabled( enabled )
end

-- Set the time of day.
---- float time
function GameRules:SetTimeOfDay( time )
end

-- Sets the tree regrow time in seconds.
---- float time
function GameRules:SetTreeRegrowTime( time )
end

-- Heroes will use the basic NPC functionality for determining their bounty, rather than DOTA specific formulas.
---- bool a
function GameRules:SetUseBaseGoldBountyOnHeroes( a )
end

-- Allows heroes in the map to give a specific amount of XP (this value must be set).
---- bool a
function GameRules:SetUseCustomHeroXPValues( a )
end

-- When true, all items are available at as long as any shop is in range, including Secret Shop items
---- bool enabled
function GameRules:SetUseUniversalShopMode( enabled )
end

-- Get the current Gamerules state
-- Returns &lt;&gt;
function GameRules:State_Get(  )
val = 1
return val
end

