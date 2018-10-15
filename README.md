# flyway

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with flyway](#setup)
    * [What flyway affects](#what-flyway-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with flyway](#beginning-with-flyway)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)

## Overview

Install Flyway command-line tool and manages database migrations with it.

## Module Description

That flyway module can install Flyway command-line tool from a URL and manage database migrations (`flyway migrate`).

> **Note**: This module requires wget.

## Setup

### What flyway affects

* Flyway command-line installation.
* Migrate a target database to a specific version.

### Beginning with flyway

`include flyway`

Install Flyway commmand-line tool with default parameters:

- *install_source* = 'https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/5.2.0/flyway-commandline-5.2.0-linux-x64.tar.gz',
- *dirname* = '/opt/flyway',
- *install_cache_dir* = '/var/cache/wget'

_note: The default setting for flyway is the latest version of `5.2.0`.  This can be overrided by setting the hieradata key `flyway::version: '4.0'`
for example_

## Usage

    include flyway

    flyway::migrate { 'MyDB':
      url       => 'jdbc:postgresql://localhost:5432/MyDB',
      user      => 'postgres',
      password  => 'postgres',
      schemas   => 'public',
      locations => 'filesystem:/opt/sql'
    }

Migrates your database (MyDB) to latest version using migration scripts inside /opt/sql.

## Reference

- [**Public classes**](#public-classes)
    - [Class: flyway](#class-flyway)
- [**Public defined types**](#public-defined-types)
    - [Defined type: flyway::migrate](#defined-type-flywaymigrate)

### Public Classes

#### Class: `flyway`

**Parameters within `flyway`**:

##### `install_source`

URL to download flyway binaries in tar.gz format. Default to `https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/4.0/flyway-commandline-4.0-linux-x64.tar.gz`.

##### `dirname`

Installation directory. Default to `/opt/flyway`

##### `install_cache_dir`

Directory used for wget cache. Default to `/var/cache/wget`

### Public defined types

#### Defined type: `flyway::migrate`

Migrates target database to a target version using selected scripts.

**Parameters within `flyway::migrate`**:

##### `url`

The jdbc url to use to connect to the database

##### `user`

The user to use to connect to the database

##### `password`

The password to use to connect to the database

##### `locations`

Comma-separated list of locations to scan recursively for migrations. The location type is determined by its prefix.
Unprefixed locations or locations starting with **classpath:** point to a package on the classpath and may contain both sql and java-based migrations.
Locations starting with **filesystem:** point to a directory on the filesystem and may only contain sql migrations.

##### `schemas`

Comma-separated list of schemas the migrations should be applied to.

##### `target`

The target version up to which Flyway should consider migrations. Migrations with a higher version number will be ignored. The special value current designates the current version of the schema. Default to `latest version`.
