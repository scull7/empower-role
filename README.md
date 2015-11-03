[![Build Status](https://travis-ci.org/scull7/empower-role.svg?branch=master)](https://travis-ci.org/scull7/empower-role)

[![Coverage Status](https://coveralls.io/repos/scull7/empower-role/badge.svg?branch=master&service=github)](https://coveralls.io/github/scull7/empower-role?branch=master)

# empower-role
Given a role map, a set of roles and a permission can the user access?

## Role Map
Maps a set of roles to a set of permissions.

```json
{
  "role-name": {
    "permission-name": 1,
    "other-permission": 0,
    "permission:action!": 1
  },
  "other-role": {
    "permission-name": 1,
    "other-permission": 1,
    "permission:action!": 0
}
```

## Set of user roles
Simply an array of roles to check against.

## Permission
A string that represents a system action or request.

## Usage

```javascript
var RoleMap = require('empower-role').Map;
var Role    = require('empower-role').Role;

// Alternatively you can supply JSON via the RoleMap.fromJson function.
var map     = RoleMap()
  .addRole( Role('role-name')
    .addPermission('permission-name'), 1)
    .addPermission('other-permission'), 0)
    .addPermission('permission:action!', 1)
  )
  .addRole( Role('other-role')
    .addPermission('permission-name'), 1)
    .addPermission('other-permission'), 1)
    .addPermission('permission:action!', 0)
  )
;

var userRoles = [ 'role-name', 'other-role' ];

var isAllowed1 = map.check(userRoles, 'permission-name');
var isAllowed2 = map.check(userRoles, 'other-permission');
var isAllowed3 = map.check(userRoles, 'permission:action!');

// will print "true, true, true"
// the most permissive result is always returned.
console.log(isAllowed1, isAllowed2, isAllowed3);

```
