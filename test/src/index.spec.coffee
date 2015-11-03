
assert      = require 'assert'
empowerRole = require '../../src/index.coffee'


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

testMap = empowerRole()
testMap.addRole(empowerRole.Role('test1')
  .addPermission('perm:one', 1)
  .addPermission('perm:two', 0)
  .addPermission('perm:three', 0)
  .addPermission('perm:four', 1)
)

testMap.addRole(empowerRole.Role('test2')
  .addPermission('perm:one', 0)
  .addPermission('perm:two', 1)
  .addPermission('perm:three', 0)
  .addPermission('perm:four', 0)
)

testMap.addRole(empowerRole.Role('test3')
  .addPermission('perm:one', 1)
  .addPermission('perm:two', 0)
  .addPermission('perm:three', 0)
)

describe 'empower-role', ->

  it 'should return an object that passes all of the map::check tests', ->

      userRoles     = [ 'test1', 'test2', 'test3' ]

      assert.equal (testMap.check userRoles, 'perm:two'), true
      assert.equal (testMap.check ['dne1', 'dne2'], 'perm:two'), false
      assert.equal (testMap.check userRoles, 'perm:four'), true
      assert.equal (testMap.check userRoles, 'perm:three'), false

  describe 'fromJson', ->

    it 'should return and object that passes all of the map::check tests', ->

      testJsonMap   = empowerRole.fromJson testJson
      userRoles     = [ 'test1', 'test2', 'test3' ]

      assert.equal (testJsonMap.check userRoles, 'perm:two'), true
      assert.equal (testJsonMap.check ['dne1', 'dne2'], 'perm:two'), false
      assert.equal (testJsonMap.check userRoles, 'perm:four'), true
      assert.equal (testJsonMap.check userRoles, 'perm:three'), false
