def attach_meta(**arguments):

    def _inner(function_or_class):

        if hasattr(function_or_class, '_meta'):
            raise AttributeError('Function already has meta information')
        else:
            function_or_class._meta = arguments
        return function_or_class
    return _inner


def print_with(obj):

    if 'foo' in obj._meta:
        print(obj, 'printed with', obj._meta['foo'])
    else:
        print(obj)


@attach_meta(foo='blue')
def my_func():
    pass


print_with(my_func)
# ==> <function my_func at ...> printed with blue
