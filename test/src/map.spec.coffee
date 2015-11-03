
assert  = require 'assert'
RoleMap = require '../../src/map.coffee'
Role    = require '../../src/role.coffee'


testMap = RoleMap()
testMap.addRole(Role('test1')
  .addPermission('perm:one', 1)
  .addPermission('perm:two', 0)
  .addPermission('perm:three', 0)
  .addPermission('perm:four', 1)
)

testMap.addRole(Role('test2')
  .addPermission('perm:one', 0)
  .addPermission('perm:two', 1)
  .addPermission('perm:three', 0)
  .addPermission('perm:four', 0)
)

testMap.addRole(Role('test3')
  .addPermission('perm:one', 1)
  .addPermission('perm:two', 0)
  .addPermission('perm:three', 0)
)

userRoles = [ 'test1', 'test2', 'test3' ]

describe 'RoleMap', ->

  it 'should return a RoleMap object', ->

    map = RoleMap()
    assert.equal (typeof map.addRole is 'function'), true
    assert.equal (typeof map.hasRole is 'function'), true
    assert.equal (typeof map.checkRolePermission is 'function'), true
    assert.equal (typeof map.check is 'function'), true

  it 'should initialize the internal map object to an empty object', ->

    map = RoleMap()
    assert.deepEqual map.map, {}

  describe 'addRole', ->

    it 'should add a role to the current role map', ->

      map = RoleMap()
      map.addRole Role('test')

      assert.equal (map.map.hasOwnProperty 'test'), true

    it 'should check for a getName function using duck typing', ->

      try
        map = RoleMap()
        map.addRole { isAllowed: -> true }
      catch e
        assert.equal e.message, 'You must add a Role object.'

    it 'should check for a isAllowed function using duck typing', ->

      try
        map = RoleMap()
        map.addRole { getName: -> 'test' }
      catch e
        assert.equal e.message, 'You must add a Role object.'

    it 'should gaurd against duplicate role entries', ->

      try
        map = RoleMap()
        map.addRole Role('test')
        map.addRole Role('test')
      catch e
        assert.equal e.message, 'Role already exists.'

  describe 'hasRole', ->

    it 'should return false if the role name is not found', ->

      map = RoleMap()
      assert.equal (map.hasRole 'test'), false

    it 'should return true if the role name is found', ->

      map = RoleMap()
      map.addRole (Role 'test')
      assert.equal (map.hasRole 'test'), true

  describe 'checkRolePermission', ->

    it 'should return false if the role does not exist', ->

      assert.equal (testMap.checkRolePermission 'test:perm', 'test'), false

    it 'should return true if the role exists and permission is granted',
      ->

      assert.equal (testMap.checkRolePermission 'perm:one', 'test1'), true

  describe 'check', ->

    it 'should return true if any role has access', ->

      assert.equal (testMap.check userRoles, 'perm:two'), true

    it 'should return false if none of the roles are found', ->

      assert.equal (testMap.check ['dne1', 'dne2'], 'perm:two'), false

    it 'should return true even if one of the roles doesn\'t have the perm.',
      ->

      assert.equal (testMap.check userRoles, 'perm:four'), true

    it 'should return false if all roles have no access', ->

      assert.equal (testMap.check userRoles, 'perm:three'), false
