Permission  = require './permission'

class Role

  # constructor :: String -> Role
  constructor: (@name) ->

    @permissions  = {}

  # getName :: String
  getName: -> @name

  # addPermission :: String -> Array String -> Role
  addPermission: (name, methods) ->

    methods = [ methods ] if not Array.isArray methods
    @permissions[name]  = Permission name, methods

    return @


  # isAllowed :: String -> String -> Bool
  isAllowed: (name, method) -> if not (@permissions.hasOwnProperty name)
    false
  else (Permission.hasAccess @permissions[name], method)


module.exports  = (name) -> new Role(name)
