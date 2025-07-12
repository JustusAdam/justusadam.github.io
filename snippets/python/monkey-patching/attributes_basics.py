#! /usr/bin/env python3

class TestClass:

    # class atttributes are declared in the class body
    # they absolutey must be assigned a value
    class_foo = 0
    class_bar = object

    def __init__(self):

        # instance attributes are assigned to the object in the initializer
        # these also need to be assigned a value
        self.instance_foo = 8
        self.instance_bar = None
