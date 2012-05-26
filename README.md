Description
===========

Requirements
============

Attributes
==========

Usage
=====

Use the `preferred_attribute` LWRP to define dynamic attributes to have the
value of the first of an ordered list of expressions to have a non-nil
value:

    preferred_attribute "preferred.hostname" do
      first_of [
        "ec2.public_ipaddress",
        "ipaddress" ]
    end

