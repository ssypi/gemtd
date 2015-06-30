Entities = {}



-- Creates an entity by classname
--- - string className
-- Returns handle
function Entities:CreateByClassname(className)
    val = 1
    return val
end

-- Finds all entities by class name. Returns an array containing all the found entities.
--- - string a
-- Returns table
function Entities:FindAllByClassname(a)
    val = 1
    return val
end

-- Find entities by class name within a radius.
--- - string a, Vector b, float c
-- Returns table
function Entities:FindAllByClassnameWithin(a, b, c)
    val = 1
    return val
end

-- Find entities by model name.
--- - string modelName
-- Returns table
function Entities:FindAllByModel(modelName)
    val = 1
    return val
end

-- Find all entities by name. Returns an array containing all the found entities in it.
--- - string name
-- Returns table
function Entities:FindAllByName(name)
    val = 1
    return val
end

-- Find entities by name within a radius.
--- - string name, Vector origin, float maxRadius
-- Returns table
function Entities:FindAllByNameWithin(name, origin, maxRadius)
    val = 1
    return val
end

-- Find entities by targetname.
--- - string targetName
-- Returns table
function Entities:FindAllByTarget(targetName)
    val = 1
    return val
end

-- Find entities within a radius.
--- - Vector origin, float maxRadius
-- Returns table
function Entities:FindAllInSphere(origin, maxRadius)
    val = 1
    return val
end

-- Find entities by class name. Pass nil to start an iteration, or reference to a previously found entity to continue a search
--- - handle startFrom, string className
-- Returns handle
function Entities:FindByClassname(startFrom, className)
    val = 1
    return val
end

-- Find entities by class name nearest to a point.
--- - string className, Vector origin, float maxRadius
-- Returns handle
function Entities:FindByClassnameNearest(className, origin, maxRadius)
    val = 1
    return val
end

-- Find entities by class name within a radius. Pass nil to start an iteration, or reference to a previously found entity to continue a search
--- - handle startFrom, string className, Vector origin, float maxRadius
-- Returns handle
function Entities:FindByClassnameWithin(startFrom, className, origin, maxRadius)
    val = 1
    return val
end

-- Find entities by model name. Pass nil to start an iteration, or reference to a previously found entity to continue a search
--- - handle startFrom, string modelName
-- Returns handle
function Entities:FindByModel(startFrom, modelName)
    val = 1
    return val
end

-- Find entities by model name within a radius. Pass nil to start an iteration, or reference to a previously found entity to continue a search
--- - handle startFrom, string modelName, Vector origin, float maxRadius
-- Returns handle
function Entities:FindByModelWithin(startFrom, modelName, origin, maxRadius)
    val = 1
    return val
end

-- Find entities by name. Pass nil to start an iteration, or reference to a previously found entity to continue a search
--- - handle lastEnt, string searchString
-- Returns handle
function Entities:FindByName(lastEnt, searchString)
    val = 1
    return val
end

-- Find entities by name nearest to a point.
--- - string name, Vector origin, float maxRadius
-- Returns handle
function Entities:FindByNameNearest(name, origin, maxRadius)
    val = 1
    return val
end

-- Find entities by name within a radius. Pass nil to start an iteration, or reference to a previously found entity to continue a search
--- - handle startFrom, string name, Vector origin, float maxRadius
-- Returns handle
function Entities:FindByNameWithin(startFrom, name, origin, maxRadius)
    val = 1
    return val
end

-- Find entities by targetname. Pass nil to start an iteration, or reference to a previously found entity to continue a search
--- - handle startFrom, string targetName
-- Returns handle
function Entities:FindByTarget(startFrom, targetName)
    val = 1
    return val
end

-- Find entities within a radius. Pass nil to start an iteration, or reference to a previously found entity to continue a search
--- - handle startFrom, Vector origin, float maxRadius
-- Returns handle
function Entities:FindInSphere(startFrom, origin, maxRadius)
    val = 1
    return val
end

-- Begin an iteration over the list of entities
-- Returns handle
function Entities:First()
    val = 1
    return val
end

-- Continue an iteration over the list of entities, providing reference to a previously found entity
--- - handle startFrom
-- Returns handle
function Entities:Next(startFrom)
    val = 1
    return val
end

