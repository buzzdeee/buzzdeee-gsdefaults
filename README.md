# gsdefaults

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with gsdefaults](#setup)
    * [What gsdefaults affects](#what-gsdefaults-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with gsdefaults](#beginning-with-gsdefaults)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module doesn't configure a specific service, but manages GNUstep 
based application and server configurations. 

## Module Description

This module provides basic management of GNUstep configurations,
usually managed via the 'defaults' command.
Key/Value pairs can be defined for a given user/domain.
Values can be ensured as either 'present', 'absent', or 'keyonly'.
The 'keyonly' only ensures the existence of the given key, but doesn't
verify its value.

## Setup

### What gsdefaults affects

 * You can manage any key/value pair for any given domain for a specific
   user.
 * Everything possible as legal value, i.e. an array, dictionary, string
   or boolean can be passed as value.

### Setup Requirements **OPTIONAL**

The module is a Ruby only module, to make use of it, pluginsync must
be enabled.
This module is intended to be used by other modules. Those other modules
must somehow ensure that gnustep-base 'defaults' command is available.

### Beginning with gsdefaults

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

The module provides a custom ruby type: 'gsdefaults'.

### Example usage:

```puppet

   gsdefaults { 'a_unique_name_here':
     ensure => 'present',
     user   => 'exampleuser',
     domain => 'NSGlobalDomain',
     key    => 'testkey',
     value  => 'testvalue',
   }
```

### Parameters

#### ensure
This parameter is optional, valid values are:
 - present (default)
  - makes sure all parameters exist as they should
 - absent
 - keyonly
  - works like present, but only makes sure that the key exists,
    regardless of the given value

#### user
This parameter is optional, valid values are:
 - valid user names
 - default value is 'root'

#### domain
This parameter is optional, valid values are:
 - a string
 - default value is 'NSGlobalDomain'

#### key
This parameter is mandatory, valid values are:
 - a string

#### value
This parameter is mandatory, except for ensure => 'absent'
 - any valid value type you can hand over to the GNUstep 'defaults' tool

## Limitations

Tested and known to work on OpenBSD -current with Puppet 3.7.3.

## Development

Please help me make this module awesome!  Send pull requests and file issues.

## Release Notes

### Version 0.1.0 (2015-01-05)
 * initial release
### Version 0.1.1 (2015-01-05)
 * minimal fixups to please the metadata score
