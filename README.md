[![Build Status](https://travis-ci.org/scull7/empower-role.svg?branch=master)](https://travis-ci.org/scull7/empower-role)
[![Coverage Status](https://coveralls.io/repos/scull7/empower-role/badge.svg?branch=master&service=github)](https://coveralls.io/github/scull7/empower-role?branch=master)

# empower-role
Given a role map, a set of roles and a permission can the user access?

## Role Map
Maps a set of roles to a set of permission strings and CRUD actions against
that set _(expressed as HTTP/1.1 methods)_.

```json
{
  "role-name": {
    "permission-name": [ "get" ],
    "other-permission": [ "post" ],
    "one-more-permission": [ "get", "put", "post", "delete" ]
  },
  "other-role": {
    "permission-name": [ "get", "post"],
    "other-permission": [ "delete" ],
    "permission:action": [ "get" ]
  }
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
    .addPermission('permission-name'), [ 'get' ])
    .addPermission('other-permission'), [ 'get', 'post' ])
    .addPermission('permission:action', [ 'get', 'put', 'post', 'delete' ])
  )
  .addRole( Role('other-role')
    .addPermission('permission-name'), [ 'get', 'post' ])
    .addPermission('other-permission'), [ 'delete' ])
    .addPermission('permission:action', [ 'get' ])
  )
;

var userRoles = [ 'role-name', 'other-role' ];

var isAllowed1 = map.check(userRoles, 'permission-name', 'get');
var isAllowed2 = map.check(userRoles, 'other-permission', [ 'delete' ]);
var isAllowed3 = map.check(userRoles, 'permission:action!', [ 'put' ]);

// will print "true, true, true"
// the most permissive result is always returned.
console.log(isAllowed1, isAllowed2, isAllowed3);

```
