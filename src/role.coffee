
class Role

  # constructor :: String -> Role
  constructor: (@name) ->

    @permissions  = {}

  # getName :: String
  getName: -> @name

  # addPermission :: String -> Bool -> Role
  addPermission: (name, isAllowed) ->

    @permissions[name] = if isAllowed then 1 else 0

    return @


  # isAllowed :: String -> Bool
  isAllowed: (name) -> (@permissions[name] is 1)


module.exports  = (name) -> new Role(name)
