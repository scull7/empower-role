
class Map

  # constructor :: RoleMap
  constructor: () ->
    @map  = {}


  # addRole :: Role -> RoleMap
  addRole: (role) ->

    if  typeof role.getName isnt 'function' or
        typeof role.isAllowed isnt 'function'
      throw new Error 'You must add a Role object.'

    if @hasRole role.getName()
      throw new Error 'Role already exists.'

    @map[role.getName()]  = role
    return @


  # hasRole :: Role -> Bool
  hasRole: (roleName) -> ( @map.hasOwnProperty roleName )


  # checkRolePermission :: String -> String -> String -> Bool
  checkRolePermission: (path, method, roleName) ->
    if not @hasRole roleName
      false
    else @map[roleName].isAllowed path, method


  # check :: Array String -> String -> String -> Bool
  check: (roleNameList, permission, method) ->

    return roleNameList
      .map @checkRolePermission.bind(@, permission, method)
      .reduce (acc, cur) -> (acc or cur)


module.exports  = -> new Map()
