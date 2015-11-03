RoleMap     = require './map'
Role        = require './role'

# mapFromJson :: JSON -> RoleMap
mapFromJson = (jsonMap) ->
  map       = RoleMap()

  for roleName, permMap of jsonMap
    role    = Role(roleName)
    role.addPermission name, value for name, value of permMap

    map.addRole role

  return map

module.exports  =
  mapFromJson   : mapFromJson
