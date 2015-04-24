class TestClass:
    greeting = 'hello'


instance = TestClass()

print(
    TestClass.greeting
)  # ==> hello

print(
    TestClass.greeting is instance.greeting
)  # ==> True

# removing class attributes
del TestClass.greeting

print(
    hasattr(instance, 'greeting')
)  # ==> False

# and adding them
instance.__class__.greeting = 'hello again'
type(instance).greeting_2 = 'dear me'

print(
    TestClass.greeting
)  # ==> hello again

print(
    instance.greeting_2
)  # ==> dear me

print(
    'greeting_2' in TestClass.__dict__
)  # ==> True
