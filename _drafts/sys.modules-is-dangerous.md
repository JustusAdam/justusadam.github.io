---
title: "Importing in python - don't touch sys.modules"
author: Justus
---

So I am sitting here watching [David Beazley](//twitter.com/dabeaz)'s [pycon talk](//https://www.youtube.com/watch?v=0oTh1CXRaQ0) about modules, packages and imports and he is talking about `sys.modules` sort of guarding multiple imports which inspired me to fire up the python interpreter myself and start messing about.

Now, as David mentions as well, in python you cannot just `import module` again to reload the module. The canonical albeit still bad way is to `import importlib` and use `importlib.reload(module)`. However, he also mentions that the instance actually recording imported modules is located in `sys.modules` which happens to be a standard python dict.

The interesting thing about that is that unlike `mappingproxy` which is the dict-like object/wrapper/imitator that a lot of the builtin data structures (such as the `dict` itself) use to imitate a dict while avoiding modification[^1] and infinite recursion[^2] this `sys.modules` standard dict supports item assignment `__setitem__` as well as deletion `__delitem__`.

This got me thinking "How much does the sys.modules dict actually influence the import process." and as it turns out a lot and it allows you to mess with it.

If you import a module, let's call it `test`, modify the file and import again (in the same interpreter instance) nothing changes, you're still running the old code. What happens if you delete the module from sys.modules?

The answer: nothing at first. The code still runs, all functions that were in the module previously are still there and execute, __but__ something odd happens if you now call `import test`: it reimports the module.

{% highlight python %}
# module test

def hello():
    print('hello everyone')

# in the interpreter
>>> import test
>>> test.hello()
hello everyone

# change the file
def hello():
   print('hello')

# modify sys.modules in the interpreter
>>> import sys
>>> del sys.modules['test']

# reimport
>>> import test
>>> test.hello()
hello

{% endhighlight %}

This is obviously per se not all that bad, __however__ this hacked reload does not facilitate the same behaviour as `importlib.reload`.

The difference between reloading the module this way, which I do not recommend anyone actually does, and using `importlib.reload` is that this particular way of reloading only reloads the module in the current namespace.

Let's suppose we have two modules `foo.py` and `bar.py` where `bar` imports `foo` and uses a function defined therein:

{% highlight python %}
# foo.py

def hello():
    print('hello')

# bar.py

import foo

def hello_bar():
    foo.hello()

{% endhighlight %}

We can then do the following experiment:

{% highlight python %}

>>> import foo, bar
>>> bar.hello_bar()
hello
>>> foo.hello()
hello
# now we go into foo.py and change print('hello') to print('hello everyone')
>>> from importlib import reload
>>> reload(foo)
>>> bar.hello_bar()
hello everyone
>>> foo.hello()
hello everyone

{% endhighlight %}

As you can see using `importlib.reload` reloads the module and references to the module are updated as well[^3]. This behavior is different if you reload using our dirty little trick.

{% highlight python %}

>>> import foo, bar
>>> bar.hello_bar()
hello
>>> foo.hello()
hello
# now we go into foo.py and change print('hello') to print('hello everyone')
>>> import sys
>>> del sys.modules['foo']
>>> import foo
>>> bar.hello_bar()
hello
>>> foo.hello()
hello everyone

{% endhighlight %}

Here the reference to `foo` in `bar` is not being updated which seems to indicate that this `import` is overwriting the definition of the module wherever it is being kept and the old version of the code remains in the `globals()` dicts of the modules using it.


[^1]:
    `dict.__dict__.__getitem__ = 8` results in `AttributeError: 'mappingproxy' object attribute '__getitem__' is read-only`


[^2]:
    Otherwise any `dict` would have an instance dict `dict.__dict__` which would have an instance dict `dict.__dict.__.__dict__` of type dict which would have an instance dict and so on.

[^3]:
    This does not work if you reassign contents of the imported module. I you do something like `var = module.other_var` change the value of `other_var` and reload `var` will still have the old value. That applies to functions and variables as well as `from module import symbol` imports.
    From this I can only assume that `importlib.reload` changes the module object in place rather that replace it.
