class TestClass:

    def foo(self):

        print('foo is executing')
        print('self is {}'.format(self))


def bar(param1):
    print('bar is executing')
    print('self is {}'.format(param1))

a = TestClass()

TestClass.foo('of wrong type')  # <- notice we have to provide a 'self' parameter
# =>> foo is executing
# =>> self is of wrong type

bar('the first param')
# =>> bar is executing
# =>> self is the first param

a.foo()  # <- equivalent to TestClass.foo(a)
# =>> foo is executing
# =>> self is <__main__.TestClass object at ...>

TestClass.foo = bar  # <- no errors

a.foo()
# =>> bar is executing
# =>> self is <__main__.TestClass object at ...>
