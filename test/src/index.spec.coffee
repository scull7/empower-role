
assert      = require 'assert'
empowerRole = require '../../src/index.coffee'


testJson  =
  'test1' :
    'perm:one'    : [ 'get' ]
    'perm:four'   : [ 'post' ]
  'test2' :
    'perm:two'    : [ 'get', 'post' ]
    'perm:four'   : [ 'put' ]
  'test3' :
    'perm:one'    : [ 'get', 'post', 'put', 'delete' ]

testMap = empowerRole()
testMap.addRole(empowerRole.Role('test1')
  .addPermission('perm:one', 'get')
  .addPermission('perm:four', 'post')
)

testMap.addRole(empowerRole.Role('test2')
  .addPermission('perm:two', [ 'get', 'post' ])
  .addPermission('perm:four', 'put')
)

testMap.addRole(empowerRole.Role('test3')
  .addPermission('perm:one', [ 'get', 'post', 'put', 'delete' ])
)

describe 'empower-role', ->

  it 'should return an object that passes all of the map::check tests', ->

    userRoles     = [ 'test1', 'test2', 'test3' ]

    assert.equal (testMap.check userRoles, 'perm:two', 'get'), true
    assert.equal (testMap.check ['dne1', 'dne2'], 'perm:two', 'get'), false
    assert.equal (testMap.check userRoles, 'perm:four', 'put'), true
    assert.equal (testMap.check userRoles, 'perm:three', 'get'), false

  describe 'fromJson', ->

    it 'should return and object that passes all of the map::check tests', ->

      testJsonMap   = empowerRole.fromJson testJson
      userRoles     = [ 'test1', 'test2', 'test3' ]

      assert.equal (testJsonMap.check userRoles, 'perm:two', 'get'), true
      assert.equal (testJsonMap.check ['dne1', 'dne2'], 'perm:two', 'get'),false
      assert.equal (testJsonMap.check userRoles, 'perm:four', 'post'), true
      assert.equal (testJsonMap.check userRoles, 'perm:three', 'get'), false
