
assert  = require 'assert'
Builder = require '../../src/map-builder.coffee'


testJson  =
  'test1' :
    'perm:one'    : [ 'get' ]
    'perm:four'   : [ 'post' ]
  'test2' :
    'perm:two'    : [ 'get', 'post' ]
    'perm:four'   : [ 'put' ]
  'test3' :
    'perm:one'    : [ 'get', 'post', 'put', 'delete' ]

describe 'Builder', ->

  describe 'mapFromJson', ->

    it 'should return and object that passes all of the map::check tests', ->

      testMap   = Builder.mapFromJson testJson
      userRoles = [ 'test1', 'test2', 'test3' ]

      assert.equal (testMap.check userRoles, 'perm:two', 'get'), true
      assert.equal (testMap.check ['dne1', 'dne2'], 'perm:two', 'post'), false
      assert.equal (testMap.check userRoles, 'perm:four', 'post'), true
      assert.equal (testMap.check userRoles, 'perm:three', 'get'), false
