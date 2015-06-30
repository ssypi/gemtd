

-- Returns the number of degrees difference between two yaw angles
---- float ang1, float ang2
-- Returns float
function AngleDiff( ang1, ang2 )
val = 1
return val
end

-- Appends a string to a log file on the server
---- string a, string b
function AppendToLogFile( a, b )
end

-- Pass table - Inputs: victim, attacker, damage, damage_type, damage_flags, abilityReturn damage done.
---- handle DamageTable
-- Returns float
function ApplyDamage( DamageTable )
val = 1
return val
end

-- (vector,float) constructs a quaternion representing a rotation by angle around the specified vector axis
---- Vector a, float b
-- Returns Quaternion
function AxisAngleToQuaternion( a, b )
val = 1
return val
end

-- Create all I/O events for a particular entity
---- ehandle a
function CancelEntityIOEvents( a )
end

-- Pass table - Inputs: entity, effect
---- handle a
-- Returns bool
function CreateEffect( a )
val = 1
return val
end

-- Creates a DOTA hero by its dota_npc_units.txt name and sets it as the given player's controlled hero
---- string a, handle b
-- Returns handle
function CreateHeroForPlayer( a, b )
val = 1
return val
end

-- Creates an item with classname item_name that owner can use.
---- string item_name, handle owner, handle owner
-- Returns handle
function CreateItem( item_name, owner, owner )
val = 1
return val
end

-- Create a physical item at a given location
---- Vector a, handle b
-- Returns handle
function CreateItemOnPositionSync( a, b )
val = 1
return val
end

-- CreateTrigger( vecMin, vecMax )&nbsp;: Creates and returns an AABB trigger
---- Vector a, Vector b, Vector c
-- Returns handle
function CreateTrigger( a, b, c )
val = 1
return val
end

-- CreateTriggerRadiusApproximate( vecOrigin, flRadius )&nbsp;: Creates and returns an AABB trigger thats bigger than the radius provided
---- Vector a, float b
-- Returns handle
function CreateTriggerRadiusApproximate( a, b )
val = 1
return val
end

-- Creates a DOTA unit by its dota_npc_units.txt name ( szUnitName, vLocation, bFindClearSpace, hNPCOwner, hUnitOwner, iTeamNumber )
---- string a, Vector b, bool c, handle d, handle e, int f
-- Returns handle
function CreateUnitByName( a, b, c, d, e, f )
val = 1
return val
end

-- Creates a DOTA unit by its dota_npc_units.txt name ( szUnitName, vLocation, bFindClearSpace, hNPCOwner, hUnitOwner, iTeamNumber, hCallback )
---- string a, Vector b, bool c, handle d, handle e, int f, handle g
-- Returns int
function CreateUnitByNameAsync( a, b, c, d, e, f, g )
val = 1
return val
end

-- Gets the value of the given cvar, as a float.
---- string a
-- Returns float
function cvar_getf( a )
val = 1
return val
end

-- Sets the value of the given cvar, as a float.
---- string a, float b
-- Returns bool
function cvar_setf( a, b )
val = 1
return val
end

-- Breaks in the debugger
function DebugBreak(  )
end

-- Draw a debug overlay box (origin, mins, maxs, forward, r, g, b, a, duration )
---- Vector a, Vector b, Vector c, int d, int e, int f, int g, float h
function DebugDrawBox( a, b, c, d, e, f, g, h )
end

-- Draw a debug forward box (cent, min, max, forward, vRgb, a, duration)
---- Vector a, Vector b, Vector c, Vector d, Vector e, float f, float g
function DebugDrawBoxDirection( a, b, c, d, e, f, g )
end

-- Draw a debug circle (center, vRgb, a, rad, ztest, duration)
---- Vector a, Vector b, float c, float d, bool e, float f
function DebugDrawCircle( a, b, c, d, e, f )
end

-- Try to clear all the debug overlay info
function DebugDrawClear(  )
end

-- Draw a debug overlay line (origin, target, r, g, b, ztest, duration)
---- Vector a, Vector b, int c, int d, int e, bool f, float g
function DebugDrawLine( a, b, c, d, e, f, g )
end

-- Draw a debug line using color vec (start, end, vRgb, a, ztest, duration)
---- Vector a, Vector b, Vector c, bool d, float e
function DebugDrawLine_vCol( a, b, c, d, e )
end

-- Draw text with a line offset (x, y, lineOffset, text, r, g, b, a, duration)
---- float a, float b, int c, string d, int e, int f, int g, int h, float i
function DebugDrawScreenTextLine( a, b, c, d, e, f, g, h, i )
end

-- Draw a debug sphere (center, vRgb, a, rad, ztest, duration)
---- Vector a, Vector b, float c, float d, bool e, float f
function DebugDrawSphere( a, b, c, d, e, f )
end

-- Draw text in 3d (origin, text, bViewCheck, duration)
---- Vector a, string b, bool c, float d
function DebugDrawText( a, b, c, d )
end

-- Draw pretty debug text (x, y, lineOffset, text, r, g, b, a, duration, font, size, bBold)
---- float a, float b, int c, string d, int e, int f, int g, int h, float i, string j, int k, bool l
function DebugScreenTextPretty( a, b, c, d, e, f, g, h, i, j, k, l )
end

-- EntFire: Generate an entity i/o event ( szTarget, szAction, szValue, flDelay, hActivator, hCaller )
---- string a, string b, string c, float d, handle e, handle f
function DoEntFire( a, b, c, d, e, f )
end

-- EntFireByHandle:Generate and entity i/o event
---- handle a, string b, string c, float d, handle e, handle f
function DoEntFireByInstanceHandle( a, b, c, d, e, f )
end

-- Execute a script (internal)
---- string a, handle b
-- Returns bool
function DoIncludeScript( a, b )
val = 1
return val
end

-- ScriptAssert:Asserts the passed in value. Prints out a message and brings up the assert dialog.
---- bool a, string b
function DoScriptAssert( a, b )
end

-- UniqueString:Generate a string guaranteed to be unique across the life of the script VM, with an optional root string. Useful for adding data to table's when not sure what keys are already in use in that table.
---- string a
-- Returns string
function DoUniqueString( a )
val = 1
return val
end

-- Play named sound for all players
---- string a
function EmitGlobalSound( a )
end

-- Play named sound on Entity
---- string a, handle b
function EmitSoundOn( a, b )
end

-- Play named sound only on the client for the passed in player
---- string a, handle b
function EmitSoundOnClient( a, b )
end

-- Turn an entity index integer to an HScript representing that entity's script instance.
---- int a
-- Returns handle
function EntIndexToHScript( a )
val = 1
return val
end

-- Issue an order from a script table
---- handle a
function ExecuteOrderFromTable( a )
end

-- Smooth curve decreasing slower as it approaches zero
---- float a, float b, float c
-- Returns float
function ExponentialDecay( a, b, c )
val = 1
return val
end

-- Reads a string from a file to send to script
-- Directory traversal doesn't seem to work. The characters '.', '/' and '\\' are ignored.
-- The files are read from C:\Program Files (x86)\Steam\steamapps\common\dota 2 beta\dota_ugc\game\dota\ems
-- The function is used in conjunction with StringToFile
--
---- string a
-- Returns string
function FileToString( a )
val = 1
return val
end

-- Place a unit somewhere not already occupied.
---- handle a, Vector b, bool c
function FindClearSpaceForUnit( a, b, c )
end

-- Finds the units in a given radius with the given flags. ( iTeamNumber, vPosition, hCacheUnit, flRadius, iTeamFilter, iTypeFilter, iFlagFilter, iOrder, bCanGrowCache )
---- int a, Vector b, handle c, float d, int e, int f, int g, int h, bool i
-- Returns table
function FindUnitsInRadius( a, b, c, d, e, f, g, h, i )
val = 1
return val
end

-- Fire Entity's Action Input w/no data
---- ehandle a, string b
function FireEntityIOInputNameOnly( a, b )
end

-- Fire Entity's Action Input with passed String - you own the memory
---- ehandle a, string b, string c
function FireEntityIOInputString( a, b, c )
end

-- Fire Entity's Action Input with passed Vector ( hEntity, szActionName, vector )
---- ehandle a, string b, Vector c
function FireEntityIOInputVec( a, b, c )
end

-- Fire a pre-defined event, which can be found either in custom_events.txt or in dota's resource/*.res
---- string eventName, handle parameterTable
function FireGameEvent( eventName, parameterTable )
end

-- Fire a game event without broadcasting to the client.
---- string a, handle b
function FireGameEventLocal( a, b )
end

-- Get the time spent on the server in the last frame
-- Returns float
function FrameTime(  )
val = 1
return val
end

-- Returns the engines current frame count
-- Returns int
function GetFrameCount(  )
val = 1
return val
end

-- No Description Set
---- int a, int b
-- Returns float
function GetFrostyBoostAmount( a, b )
val = 1
return val
end

-- No Description Set
---- int a, int b, int c
-- Returns int
function GetFrostyPointsForRound( a, b, c )
val = 1
return val
end

-- No Description Set
---- int a, int b
-- Returns float
function GetGoldFrostyBoostAmount( a, b )
val = 1
return val
end

-- No Description Set
---- int a, int b, int c
-- Returns int
function GetGoldFrostyPointsForRound( a, b, c )
val = 1
return val
end

-- Returns the supplied position moved to the ground. Second parameter is an NPC for measuring movement collision hull offset.
---- Vector a, handle b
-- Returns Vector
function GetGroundPosition( a, b )
val = 1
return val
end

-- Get the local player on a listen server.
-- Returns handle
function GetListenServerHost(  )
val = 1
return val
end

-- Get the name of the map.
-- Returns string
function GetMapName(  )
val = 1
return val
end

-- Get the longest delay for all events attached to an output
---- ehandle a, string b
-- Returns float
function GetMaxOutputDelay( a, b )
val = 1
return val
end

-- Get Angular Velocity for VPHYS or normal object
---- handle a
-- Returns Vector
function GetPhysAngularVelocity( a )
val = 1
return val
end

-- Get Velocity for VPHYS or normal object
---- handle a
-- Returns Vector
function GetPhysVelocity( a )
val = 1
return val
end

-- Get the current real world date
-- Returns string
function GetSystemDate(  )
val = 1
return val
end

-- Get the current real world time
-- Returns string
function GetSystemTime(  )
val = 1
return val
end

-- Gets the world's maximum X position.
-- Returns float
function GetWorldMaxX(  )
val = 1
return val
end

-- Gets the world's maximum Y position.
-- Returns float
function GetWorldMaxY(  )
val = 1
return val
end

-- Gets the world's minimum X position.
-- Returns float
function GetWorldMinX(  )
val = 1
return val
end

-- Gets the world's minimum Y position.
-- Returns float
function GetWorldMinY(  )
val = 1
return val
end

-- If the given file doesn't exist, creates it with the given contents; does nothing if it exists
---- string a, string b
function InitLogFile( a, b )
end

-- Returns true if this server is a dedicated server.
-- Returns bool
function IsDedicatedServer(  )
val = 1
return val
end

-- Returns true if the entity is valid and marked for deletion.
---- handle a
-- Returns bool
function IsMarkedForDeletion( a )
val = 1
return val
end

-- Checks to see if the given hScript is a valid entity
---- handle a
-- Returns bool
function IsValidEntity( a )
val = 1
return val
end

-- Register as a listener for a game event from script.
-- Tip:In addition to listening for standard engine events, you can also create your own events by placing them in /scripts/custom_events.txt.
---- string EventName, handle functionCNameToCall, handle context
-- Returns int
function ListenToGameEvent( EventName, functionCNameToCall, context )
val = 1
return val
end

-- Creates a table from the specified keyvalues text file
---- string a
-- Returns table
function LoadKeyValues( a )
val = 1
return val
end

-- Creates a table from the specified keyvalues string
---- string a
-- Returns table
function LoadKeyValuesFromString( a )
val = 1
return val
end

-- Checks to see if the given hScript is a valid entity
---- string a
-- Returns int
function MakeStringToken( a )
val = 1
return val
end

-- Print a message
---- string a
function Msg( a )
end

-- Pause or unpause the game.
---- bool a
function PauseGame( a )
end

-- Get a script instance of a player by index.
---- int a
-- Returns handle
function PlayerInstanceFromIndex( a )
val = 1
return val
end

-- Precache an entity from KeyValues in table
---- string a, handle b, handle c
function PrecacheEntityFromTable( a, b, c )
end

-- Precache a list of entity KeyValues table's
---- handle a, handle b
function PrecacheEntityListFromTable( a, b )
end

-- Asynchronously precaches a DOTA item by its dota_npc_items.txt name, provides a callback when it's finished.
---- string a, handle b
function PrecacheItemByNameAsync( a, b )
end

-- Precaches a DOTA item by its dota_npc_items.txt name
---- string a, handle b
function PrecacheItemByNameSync( a, b )
end

-- ( modelName, context ) - Manually precache a single model
---- string a, handle b
function PrecacheModel( a, b )
end

-- Manually precache a single resource
---- string a, string b, handle c
function PrecacheResource( a, b, c )
end

-- Asynchronously precaches a DOTA unit by its dota_npc_units.txt name, provides a callback when it's finished.
---- string a, handle b
function PrecacheUnitByNameAsync( a, b )
end

-- Precaches a DOTA unit by its dota_npc_units.txt name
---- string a, handle b
function PrecacheUnitByNameSync( a, b )
end

-- Print a console message with a linked console command
---- string a, string b
function PrintLinkedConsoleMessage( a, b )
end

-- Get a random float within a range
---- float a, float b
-- Returns float
function RandomFloat( a, b )
val = 1
return val
end

-- Get a random int within a range
---- int a, int b
-- Returns int
function RandomInt( a, b )
val = 1
return val
end

-- Get a random 2D vector. Argument (float) is the minimum length of the returned vector.
---- float a
-- Returns Vector
function RandomVector( a )
val = 1
return val
end

-- Create a C proxy for a script-based spawn group filter
---- string a
function RegisterSpawnGroupFilterProxy( a )
end

-- Reloads the MotD file
function ReloadMOTD(  )
end

-- Remove the C proxy for a script-based spawn group filter
---- string a
function RemoveSpawnGroupFilterProxy( a )
end

-- Rolls a number from 1 to 100 and returns true if the roll is less than or equal to the number specified
---- int a
-- Returns bool
function RollPercentage( a )
val = 1
return val
end

-- Rotate a QAngle by another QAngle.
---- QAngle a, QAngle b
-- Returns QAngle
function RotateOrientation( a, b )
val = 1
return val
end

-- Rotate a Vector around a point.
---- Vector a, QAngle b, Vector c
-- Returns Vector
function RotatePosition( a, b, c )
val = 1
return val
end

-- Rotates a quaternion by the specified angle around the specified vector axis
---- Quaternion a, Vector b, float c
-- Returns Quaternion
function RotateQuaternionByAxisAngle( a, b, c )
val = 1
return val
end

-- Find the delta between two QAngles.
---- QAngle a, QAngle b
-- Returns QAngle
function RotationDelta( a, b )
val = 1
return val
end

-- Add a rule to the decision database.
---- handle a
-- Returns bool
function rr_AddDecisionRule( a )
val = 1
return val
end

-- Commit the result of QueryBestResponse back to the given entity to play. Call with params (entity, airesponse)
---- handle a, handle b
-- Returns bool
function rr_CommitAIResponse( a, b )
val = 1
return val
end

-- Retrieve a table of all available expresser targets, in the form { name&nbsp;: handle, name: handle }.
-- Returns handle
function rr_GetResponseTargets(  )
val = 1
return val
end

-- Params: ( hEnt, hQuery, hResult ) // Static&nbsp;: tests 'query' against entity's response system and returns the best response found (or nil if none found).
---- handle a, handle b, handle c
-- Returns bool
function rr_QueryBestResponse( a, b, c )
val = 1
return val
end

-- Have Entity say string, and teamOnly or not
---- handle entity, string message, bool teamOnly
function Say( entity, message, teamOnly )
end

-- Start a screenshake with the following parameters. vecCenter, flAmplitude, flFrequency, flDuration, flRadius, eCommand( SHAKE_START = 0, SHAKE_STOP = 1 ), bAirShake
---- Vector a, float b, float c, float d, float e, int f, bool g
function ScreenShake( a, b, c, d, e, f, g )
end

-- No Description Set
function SendFrostivusTimeElapsedToGC(  )
end

-- No Description Set
---- handle a
function SendFrostyPointsMessageToGC( a )
end

-- Send a string to the console as a client command
---- string a
function SendToConsole( a )
end

-- Send a string to the console as a server command
---- string a
function SendToServerConsole( a )
end

-- Sets an opvar value for all players
---- string a, string b, string c, float d
function SetOpvarFloatAll( a, b, c, d )
end

-- Sets an opvar value for a single player ( szStackName, szOperatorName, szOpvarName, flOpvarValue, hEnt )
---- string a, string b, string c, float d, handle e
function SetOpvarFloatPlayer( a, b, c, d, e )
end

-- Set the current quest name.
---- string a
function SetQuestName( a )
end

-- Set the current quest phase.
---- int a
function SetQuestPhase( a )
end

-- Set rendering on/off for an ehandle
---- ehandle a, bool b
function SetRenderingEnabled( a, b )
end

-- Shows a generic popup to all users
---- string title, string content, string unknown, string unknown, int containerType
function ShowGenericPopup( title, content, unknown, unknown, containerType )
end

-- Show a generic popup dialog to a specific player.
---- handle a, string b, string c, string d, string e, int f
function ShowGenericPopupToPlayer( a, b, c, d, e, f )
end

-- Print a hud message on all clients
---- string a
function ShowMessage( a )
end

-- Synchronously spawns a single entity from a table
---- string a, handle b
-- Returns handle
function SpawnEntityFromTableSynchronous( a, b )
val = 1
return val
end

-- Hierarchically spawn an entity group from a set of spawn tables.
---- handle groupSpawnTables, bool bAsync, handle hCallback
-- Returns bool
function SpawnEntityGroupFromTable( groupSpawnTables, bAsync, hCallback )
val = 1
return val
end

-- Asynchronously spawn an entity group from a list of spawn table's. A callback will be triggered when the spawning is complete
---- handle a, handle b
-- Returns int
function SpawnEntityListFromTableAsynchronous( a, b )
val = 1
return val
end

-- Synchronously spawn an entity group from a list of spawn table's.
---- handle a
-- Returns handle
function SpawnEntityListFromTableSynchronous( a )
val = 1
return val
end

-- (quaternion,quaternion,float) very basic interpolation of v0 to v1 over t on [0,1]
---- Quaternion a, Quaternion b, float c
-- Returns Quaternion
function SplineQuaternions( a, b, c )
val = 1
return val
end

-- (vector,vector,float) very basic interpolation of v0 to v1 over t on [0,1]
---- Vector a, Vector b, float c
-- Returns Vector
function SplineVectors( a, b, c )
val = 1
return val
end

-- Start a sound event
---- string a, handle b
function StartSoundEvent( a, b )
end

-- (hEntity, szEffectName)
---- handle a, string b
function StopEffect( a, b )
end

-- Stop listening to all game events within a specific context.
---- handle a
function StopListeningToAllGameEvents( a )
end

-- Stop listening to a particular game event.
---- int a
-- Returns bool
function StopListeningToGameEvent( a )
val = 1
return val
end

-- Stops a sound event
---- string a, handle b
function StopSoundEvent( a, b )
end

-- Stop named sound on Entity
---- string soundName, handle playingEntity
function StopSoundOn( soundName, playingEntity )
end

-- * Directory traversal doesn't seem to work. The characters '.', '/' and '\\' are ignored.
-- The file name cannot be blank, nor can it consist only of the ignored characters, else the function will do nothing and return false.
-- Only one string can be stored at a time, the file is overwritten to at every call.
-- The file ends with a NUL character.
-- The files are stored at C:\Program Files (x86)\Steam\steamapps\common\dota 2 beta\dota_ugc\game\dota\ems
-- The function is used in conjunction with FileToString
--
---- string a, string b
-- Returns bool
function StringToFile( a, b )
val = 1
return val
end

-- Get the current server time
-- Returns float
function Time(  )
val = 1
return val
end

-- Pass table - Inputs: start, end, ent, (optional mins, maxs) -- outputs: pos, fraction, hit, startsolid, normal
---- handle a
-- Returns bool
function TraceCollideable( a )
val = 1
return val
end

-- Pass table - Inputs: start, end, min, max, mask, ignore  -- outputs: pos, fraction, hit, enthit, startsolid
---- handle a
-- Returns bool
function TraceHull( a )
val = 1
return val
end

-- Pass table - Inputs: startpos, endpos, mask, ignore  -- outputs: pos, fraction, hit, enthit, startsolid
---- handle a
-- Returns bool
function TraceLine( a )
val = 1
return val
end

-- Unload a spawn group by name
---- string a
function UnloadSpawnGroup( a )
end

-- Unload a spawn group by handle
---- int a
function UnloadSpawnGroupByHandle( a )
end

-- No Description Set
---- handle a
function UpdateEventPoints( a )
end

-- Removes the specified entity
---- handle a
function UTIL_Remove( a )
end

-- Immediately removes the specified entity
---- handle a
function UTIL_RemoveImmediate( a )
end

-- Get Qangles (with no roll) for a Vector.
---- Vector a
-- Returns QAngle
function VectorToAngles( a )
val = 1
return val
end

-- Print a warning
---- string a
function Warning( a )
end

