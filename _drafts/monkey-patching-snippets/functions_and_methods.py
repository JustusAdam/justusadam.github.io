class MyClass:
    def a_method(self):
        print(self)


print(
    'a_method' in MyClass.__dict__
)  # ==> True

print(
    MyClass.a_method
)  # ==> <function MyClass.a_method at ...>

obj = MyClass()

print(
    obj.a_method
)  # ==> <bound method MyClass.a_method of <__main__.MyClass object at ...>>

obj.a_method()  # ==> <__main__.MyClass object at ...>

type(obj).a_method('hello')  # ==> hello
