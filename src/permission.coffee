
GET     = 1
POST    = 2
PUT     = 4
DELETE  = 8

methods =
  GET     : GET
  POST    : POST
  PUT     : PUT
  DELETE  : DELETE


# _isInt :: a -> Bool
_isInt  = (value) -> if isNaN(value) then false else
  x = parseFloat value
  (0 | x) is x


# _translateMethod :: a -> Int
_translateMethod  = (method) -> if not method
  0
else if not _isInt method
  methods[method.toUpperCase()] or 0
else method


# Permission :: String -> Array String -> Permission
Permission        = (route, levels) ->
  levelSum        = levels.reduce ( (a,b) -> a + (_translateMethod b) ), 0
  return [ route, levelSum ]


# methodToLevel :: a -> Int
Permission.methodToLevel  = _translateMethod


# hasLevel :: Permission -> a -> Bool
Permission.hasAccess = (permission, method) ->
  ( (_translateMethod method) & permission[1]) > 0


Permission.GET    = GET
Permission.POST   = POST
Permission.PUT    = PUT
Permission.DELETE = DELETE


module.exports    = Permission
