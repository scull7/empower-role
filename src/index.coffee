
RoleMap = require './map'
Builder = require './map-builder'

RoleMap.fromJson  = Builder.mapFromJson
RoleMap.Role      = require './role.coffee'

module.exports  = RoleMap
