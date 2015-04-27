#! /usr/bin/env python3

class TestClass:

    foo = 0

    def __init__(self):

        print(dir(self))
        # =>> ['__class__', '__delattr__', '__dict__', '__dir__', '__doc__',
        # '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__',
        # '__hash__', '__init__', '__le__', '__lt__', '__module__', '__ne__',
        # '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__',
        # '__sizeof__', '__str__', '__subclasshook__', '__weakref__', 'foo',
        # 'method']
        # only shows us the names of methods or attributed we defined on the class

        # we can refer to the instance dict directly using __dict__
        print(self.__dict__)
        # =>> {}

        # this is an alternative way to get the instance dict
        print(vars(self))

        self.bar = 'hi there'

        print(dir(self))
        # =>> ['__class__', '__delattr__', '__dict__', '__dir__', '__doc__',
        # '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__',
        # '__hash__', '__init__', '__le__', '__lt__', '__module__', '__ne__',
        # '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__',
        # '__sizeof__', '__str__', '__subclasshook__', '__weakref__', 'bar',
        # 'foo', 'method']
        # now bar exists as well

        print(self.__dict__)
        # =>> {'bar': 'hi there'}

        print(self.__dict__['bar'])
        # =>> 'hi there'

    def method(self):
        pass


a = TestClass()

del a.__dict__['bar']
# we can delete keys directly in the dict

print(
    hasattr(a, 'bar')
)  # =>> False

print(
    'bar' in a.__dict__
)  # =>> False

a.bar
# =>> AttributeError: 'TestClass' object has no attribute 'bar'
