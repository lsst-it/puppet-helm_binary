# helm_binary

## Table of Contents

1. [Overview](#overview)
1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)

## Overview

Installs the [helm](https://github.com/helm/helm/) binary.

## Description

Fetches the `helm` utility and and symlinks `/usr/bin/helm` to the downloaded
artifact.  This is a minimal, binary installation only alternative to the
[puppetlabs/helm](https://forge.puppet.com/modules/puppetlabs/helm) module
without the legacy helm v2 deployment support.  In addition, this module has
artifact digest support.

## Usage

```puppet
class { 'helm_binary':
  version       => '3.5.4',
  checksum      => 'a8ddb4e30435b5fd45308ecce5eaad676d64a5de9c89660b56face3fe990b318',
  checksum_type => 'sha256',
  base_path     => '/opt/rke',
}
```

## Reference

See [REFERENCE](REFERENCE.md)
