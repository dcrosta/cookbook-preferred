[![Build Status](https://secure.travis-ci.org/dcrosta/cookbook-preferred.png?branch=master)](http://travis-ci.org/dcrosta/cookbook-preferred)

Description
===========

Define an attribute dynamically using ruby blocks.

Usage
=====

Use the `preferred_attribute` LWRP to define dynamic attributes to have the
value of the first of an ordered list of expressions to have a non-nil
value:

    preferred_attribute "ipaddress" do
      maybe { node["ec2"]["public_ip"] }
      maybe { node["rackspace"]["public_ip"] }
      maybe { node["ipaddress"] }
    end

Attributes are defined within the "preferred" namespace, so the above
creates an attribute accessible as `node["preferred"]["ipaddress"]`. You can
change the namespace with the `namespace` option to `preferred_attribute`;
if you set it to `nil`, no namespacing will be applied.

The name option to `preferred_attribute` may be a dotted attribute path. Any
parts of the attribute path which do not exist are created on demand.
