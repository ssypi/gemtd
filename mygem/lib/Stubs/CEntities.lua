CEntities = {}

-- Creates an entity by classname
---- string className
-- Returns handle
function CEntities:CreateByClassname( className )
val = 1
return val
end

-- Finds all entities by class name. Returns an array containing all the found entities.
---- string a
-- Returns table
function CEntities:FindAllByClassname( a )
val = 1
return val
end

-- Find entities by class name within a radius.
---- string a, Vector b, float c
-- Returns table
function CEntities:FindAllByClassnameWithin( a, b, c )
val = 1
return val
end

-- Find entities by model name.
---- string modelName
-- Returns table
function CEntities:FindAllByModel( modelName )
val = 1
return val
end

-- Find all entities by name. Returns an array containing all the found entities in it.
---- string name
-- Returns table
function CEntities:FindAllByName( name )
val = 1
return val
end

-- Find entities by name within a radius.
---- string name, Vector origin, float maxRadius
-- Returns table
function CEntities:FindAllByNameWithin( name, origin, maxRadius )
val = 1
return val
end

-- Find entities by targetname.
---- string targetName
-- Returns table
function CEntities:FindAllByTarget( targetName )
val = 1
return val
end

-- Find entities within a radius.
---- Vector origin, float maxRadius
-- Returns table
function CEntities:FindAllInSphere( origin, maxRadius )
val = 1
return val
end

-- Find entities by class name. Pass nil to start an iteration, or reference to a previously found entity to continue a search
---- handle startFrom, string className
-- Returns handle
function CEntities:FindByClassname( startFrom, className )
val = 1
return val
end

-- Find entities by class name nearest to a point.
---- string className, Vector origin, float maxRadius
-- Returns handle
function CEntities:FindByClassnameNearest( className, origin, maxRadius )
val = 1
return val
end

-- Find entities by class name within a radius. Pass nil to start an iteration, or reference to a previously found entity to continue a search
---- handle startFrom, string className, Vector origin, float maxRadius
-- Returns handle
function CEntities:FindByClassnameWithin( startFrom, className, origin, maxRadius )
val = 1
return val
end

-- Find entities by model name. Pass nil to start an iteration, or reference to a previously found entity to continue a search
---- handle startFrom, string modelName
-- Returns handle
function CEntities:FindByModel( startFrom, modelName )
val = 1
return val
end

-- Find entities by model name within a radius. Pass nil to start an iteration, or reference to a previously found entity to continue a search
---- handle startFrom, string modelName, Vector origin, float maxRadius
-- Returns handle
function CEntities:FindByModelWithin( startFrom, modelName, origin, maxRadius )
val = 1
return val
end

-- Find entities by name. Pass nil to start an iteration, or reference to a previously found entity to continue a search
---- handle lastEnt, string searchString
-- Returns handle
function CEntities:FindByName( lastEnt, searchString )
val = 1
return val
end

-- Find entities by name nearest to a point.
---- string name, Vector origin, float maxRadius
-- Returns handle
function CEntities:FindByNameNearest( name, origin, maxRadius )
val = 1
return val
end

-- Find entities by name within a radius. Pass nil to start an iteration, or reference to a previously found entity to continue a search
---- handle startFrom, string name, Vector origin, float maxRadius
-- Returns handle
function CEntities:FindByNameWithin( startFrom, name, origin, maxRadius )
val = 1
return val
end

-- Find entities by targetname. Pass nil to start an iteration, or reference to a previously found entity to continue a search
---- handle startFrom, string targetName
-- Returns handle
function CEntities:FindByTarget( startFrom, targetName )
val = 1
return val
end

-- Find entities within a radius. Pass nil to start an iteration, or reference to a previously found entity to continue a search
---- handle startFrom, Vector origin, float maxRadius
-- Returns handle
function CEntities:FindInSphere( startFrom, origin, maxRadius )
val = 1
return val
end

-- Begin an iteration over the list of entities
-- Returns handle
function CEntities:First(  )
val = 1
return val
end

-- Continue an iteration over the list of entities, providing reference to a previously found entity
---- handle startFrom
-- Returns handle
function CEntities:Next( startFrom )
val = 1
return val
end

