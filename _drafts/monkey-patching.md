---
title: Next level monkey patching
author: Justus
description: The dumb things you can(n't) do with python objects and classes
snippet_folder: monkey-patching-snippets
curr_location: _drafts
---

*Hint: all python examples here run on python 3 and you can try them for yourself and experiment.
The source can be found [here](https://github.com/JustusAdam/justusadam.github.io/tree/master/{{ page.curr_location }}/{{ page.snippet_folder }})*

As everyone probably knows most objects in python are not static as static as in many other languages. When you create a class you can specify class attributes in the class body and instance attributes in the init method.

{% highlight python %}{% include_relative {{ page.snippet_folder }}/attributes_basics.py %}{% endhighlight %}

However that is by no means final.

## Patching objects

Even though you are encouraged to declare instance attributes in the initializer you are by no means required to do so. You can declare/assign instance attribute in any method and even outside the class at any point in the program.

{% highlight python %}{% include_relative {{ page.snippet_folder }}/attributes_from_outside.py %}{% endhighlight %}

As you can see we can add attributes from inside another method. You can also remove the attributes from anywhere.

### Some things to learn from this

Declare your instance variables in the initializer because you are guaranteed that this method will execute, or you probably will run into unexpected AttributeErrors somewhere down the line.

Never add instance attributes from the outside. You may accidentally overwrite others or forget to do it and that would again cause name errors.

### Exceptions from the rule

There are however some exceptions. For instance if you use a decorator to attach meta information to a function or class. It is okay to do here, because, again, you are guaranteed that the function is going to execute.

{% highlight python %}
{% include_relative {{ page.snippet_folder }}/meta_information_decorator.py %}
{% endhighlight %}

*Note that we're attaching instance variables to a function. Functions are just objects, like anything else, so we're allowed to do that*

## How it works

Objects in python are actually quite a simple construct.

For purposes of this article we can just think of objects as a combination of a class, the type of the object, and a so called instance dict.

The class, or type, is what we created when we were using the `class` keyword and it contains the methods and class attributes and reference to parent classes and so on.

The instance dict is a simple python dictionary that holds the instance variables.

When an python object is created by the runtime the instance dict is actually empty[^instance_dict_init], no object actually has any instance attributes[^slots], until the `__init__` method is called. In the init method we are basically monkey patching in our instance attributes. This sets the key corresponding to the name of the attribute in the instance dict.

[^instance_dict_init]:
    This is true for any custom object. It can however be changed by using decorators or metaclasses.

[^slots]:
    This is true for classes that do not define `__slots__` which will in fact allocate named fields.

{% highlight python %}
{% include_relative {{ page.snippet_folder }}/instance_dict_basic.py %}
{% endhighlight %}

## Patching classes

As you may have guessed already, if we're allowed to attach attributes to a function, we are also alowed to attach attributes to a class.
