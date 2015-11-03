assert  = require 'assert'
Role    = require '../../src/role.coffee'


describe 'Role', ->

  it 'should return a new Role object', ->

    role = Role 'test'
    assert.equal (typeof role.getName is 'function'), true
    assert.equal (typeof role.addPermission is 'function'), true
    assert.equal (typeof role.isAllowed is 'function'), true

  describe 'getName', ->

    it 'should return the role name', ->

      role  = Role 'test'
      assert.equal role.getName(), 'test'

  describe 'addPermission', ->

    it 'should add a permission to the permission map', ->

      role  = Role 'test'
      role.addPermission 'test', 1
        .addPermission 'test2', 0

      assert.equal (role.isAllowed 'test'), true
      assert.equal (role.isAllowed 'test2'), false

  describe 'isAllowed', ->

    it 'should return false for a non-existant permission', ->

      role  = Role 'test'
      assert.equal (role.isAllowed 'dne'), false
