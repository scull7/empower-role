
RoleMap = require './map.coffee'
Builder = require './map-builder.coffee'

RoleMap.fromJson  = Builder.mapFromJson
RoleMap.Role      = require './role.coffee'

module.exports  = RoleMap
