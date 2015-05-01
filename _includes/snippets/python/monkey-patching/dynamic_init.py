#! /usr/bin/env python3


def auto_init(class_):
    
    def filter_func(fieldname):
        """
        Return True if the field is not private and its value is a type
        """
        if fieldname.startswith('_'):
            return False
        value = getattr(class_, fieldname)
        
        return isinstance(value, type)
        
    fields = filter(
        filter_func, 
        class_.__dict__
    )
    
    fields_and_types = [(field, getattr(class_, field)) for field in fields]
    
    for field in fields:
        # delete the class attributed to prevent collision
        delattr(class_, field)
            
    # preserve the old init, this is a safety measure
    old_init = getattr(class_, '__init__') 
    # if the class does not define this itself, this will be super.__init__
    # which is convenient  
    
    def new_init(self, **kwargs):
        # only accept kwargs, because otherwise there's no way of 
        # matching the fields
        
        for field, type_ in fields_and_types:
            
            # check whether the field is present
            # for simplicity's sake I do not handle extra arguments 
            if field not in kwargs:
                raise TypeError(
                    'Expected keyword Argument {}'.format(field)
                )
            value = kwargs[field]
            
            # typecheck the field
            if not isinstance(value, type_):
                raise TypeError(
                    'Expected instance of {} for field {}'.format(
                        type_, field
                    )
                )
                
            # essentially self.field = value 
            setattr(self, field, value)
            
        old_init(self)  # for completeness sake
    
    class_.__init__ = new_init
    
    return class_


@auto_init
class TestClass:
    foo = int
    bar = int
    glob = str
    
    
a = TestClass(foo=0, bar=8, glob="globbi globbi globbi")
b = TestClass(foo=8, bar=8, glob="")

print(a.foo)
# =>> 0
print(b.foo)
# =>> 8

print(b.bar == a.bar)
# =>> True

print(b.glob != a.glob)
# =>> True

print(a.glob)
# =>> globbi globbi globbi


try:
    TestClass()
except Exception as e:
    print(e)
    # =>> Expected keyword Argument foo
    
try:
    TestClass(foo=object, bar=0, glob="eirjg")
except Exception as e:
    print(e) 
    # =>> Expected instance of <class 'int'> for field foo
