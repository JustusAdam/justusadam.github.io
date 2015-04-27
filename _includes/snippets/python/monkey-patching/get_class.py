#! /usr/bin/env python3

class TestClass:
    pass


my_obj = TestClass()

print(
    type(my_obj)
)  # =>> <class '__main__.TestClass'> or <class 'get_class.TestClass'>

print(
    my_obj.__class__
)  # =>> <class '__main__.TestClass'> or <class 'get_class.TestClass'>

print(
    type(my_obj) is my_obj.__class__
)  # =>> True
