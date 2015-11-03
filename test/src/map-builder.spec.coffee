
assert  = require 'assert'
Builder = require '../../src/map-builder.coffee'


testJson  =
  'test1' :
    'perm:one'    : 1
    'perm:two'    : 0
    'perm:three'  : 0
    'perm:four'   : 1
  'test2' :
    'perm:one'    : 0
    'perm:two'    : 1
    'perm:three'  : 0
    'perm:four'   : 1
  'test3' :
    'perm:one'    : 1
    'perm:two'    : 0
    'perm:three'  : 0

describe 'Builder', ->

  describe 'mapFromJson', ->

    it 'should return and object that passes all of the map::check tests', ->

      testMap   = Builder.mapFromJson testJson
      userRoles = [ 'test1', 'test2', 'test3' ]

      assert.equal (testMap.check userRoles, 'perm:two'), true
      assert.equal (testMap.check ['dne1', 'dne2'], 'perm:two'), false
      assert.equal (testMap.check userRoles, 'perm:four'), true
      assert.equal (testMap.check userRoles, 'perm:three'), false
