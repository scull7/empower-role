
assert      = require 'assert'
Permission  = require '../../src/permission'

describe.only 'Permission', ->

  it 'should return a Permission tuple', ->

    perm  = Permission('/test', [ 'get', 'post', 'put' ])

    assert.equal perm[0], '/test'
    assert.equal perm[1], 7

  it 'should return 15 if all methods are set', ->

    perm  = Permission('/test', [ 'get', 'post', 'put', 'delete' ])
    assert.equal perm[1], 15

  describe 'methodToLevel', ->

    it 'should just return an Int when given an Int', ->

      assert.equal (Permission.methodToLevel 5), 5

    it 'should return zero when given an unknown string', ->

      assert.equal (Permission.methodToLevel 'unknown'), 0

    it 'should handle an undefined method value', ->

      assert.equal (Permission.methodToLevel undefined), 0

  describe 'hasAccess', ->

    it 'should return true if the user has the requested level', ->

      perm  = Permission '/test', [ 'get', 'post', 'put', 'delete' ]

      assert.equal (Permission.hasAccess perm, 'get'), true
      assert.equal (Permission.hasAccess perm, 'post'), true
      assert.equal (Permission.hasAccess perm, 'put'), true
      assert.equal (Permission.hasAccess perm, 'delete'), true

    it 'should return false if the user does not have the requested level', ->

      perm  = Permission '/test', [ 'get', 'post', 'delete' ]

      assert.equal (Permission.hasAccess perm, 'get'), true
      assert.equal (Permission.hasAccess perm, 'post'), true
      assert.equal (Permission.hasAccess perm, 'put'), false
      assert.equal (Permission.hasAccess perm, 'delete'), true
