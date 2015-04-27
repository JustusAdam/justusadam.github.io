#! /usr/bin/env python3

class BaseClass:
    def __init__(self):
        print(BaseClass.__init__, 'executing')


class SubClass(BaseClass):
    def __init__(self):
        print(SubClass.__init__, 'executing')
        super().__init__()

print('\ninstantiating', SubClass)
SubClass()
# =>> <function SubClass.__init__ at ...> executing
# =>> <function BaseClass.__init__ at ...> executing

print()

# removing it
del SubClass.__init__

print('\ninstantiating', SubClass, 'again')
SubClass()
# =>> <function BaseClass.__init__ at ...> executing

def new_init(self):
    print('I overwrote __init__')
    super(SubClass, self).__init__()

# and adding a new one
SubClass.__init__ = new_init

print('\ninstantiating', SubClass, 'one last time')
SubClass()
# =>> I overwrote __init__
# =>> <function BaseClass.__init__ at ...> executing
