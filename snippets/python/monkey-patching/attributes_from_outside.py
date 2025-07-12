#! /usr/bin/env python3

class TestClass:

    def __init__(self):
        pass

    def method_1(self):
        # defining an instance attribute from inside another method
        self.instance_foo = 4



my_instance = TestClass()

print(
    hasattr(my_instance, 'instance_foo')
)  # =>>  False
# the instance_foo attribute does not exist yet

my_instance.method_1()

print(
    my_instance.instance_foo
)  # =>> 4
# now it does

print(
    hasattr(my_instance, 'instance_bar')
)  # =>> False

my_instance.instance_bar = 'hello'

print(
    my_instance.instance_bar
)  # =>> hello

del my_instance.instance_foo

my_instance.instance_foo
# =>> AttributeError: 'TestClass' object has no attribute 'instance_foo'
# trying to call non-existing attributes causes an AttributeError
