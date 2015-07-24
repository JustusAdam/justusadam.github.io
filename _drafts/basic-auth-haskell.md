---
title: Basic authenticated http requests and forms in Haskell
---

{% assign snippets = site.data.snippets.http %}

## Prelude

I've recently needed to make a basic, authenticated HTTP request in Haskell, however I found it difficult to find examples and documentation on the web so I thought I'd share my findings with the world in the form of a blog post (and a gist).

First of all, in order to use http in Haskell you'll want to use the right library. Fortunately for me I already knew a library which is sort of the standard library for Haskell when it comes to http (client side). The aptly named [HTTP][] library.

[HTTP]: https://hackage.haskell.org/package/HTTP
[hackage]: https://hackage.haskell.org

The hackage page for the [hackage][] page for the [HTTP][] library albeit being helpful does not provide very many examples on how to use it and more importantly does not provide a lot of guidance for beginners when it comes to choosing the right submodule for a particular task.

I the past I've mostly dealt with the very basic Network.HTTP package. Which is reasonably easy to understand and totally sufficient for simple, unauthenticated **GET** requests. However if you want to do more complicated things like for example auth or cookies it is too low level. For those more complicated requests you'll want to use the Network.Browser module, which seems a bit intimidating at first.

Network.Browser defines the BrowserAction Monad, which is basically IO combined with (Browser)State. All further actions are then defined on this BrowserAction.


## Browser basics

The main action with the BrowserAction Monad, outside of BrowserAction, is the `browse` function. This function evaluates the BrowserAction and returns whatever contents it is holding, very much like IO. This is the usual entry and exit point for Browser related computation in the [HTTP][] library.

The basic function for performing requests is the `request` function, which given a `Request` object performs the request, ending again inside a BrowserAction.

`Request` objects can either be created by hand, or with the utility functions from `Network.HTTP` or by using the utility functions in `Network.HTTP.Browser` itself.

The quickest one of these to get started is using the `getRequest` function from `Network.HTTP`, it just takes a `String` and returns a `Request`.

Which means a basic request starts like this

{% include haskell-snippet.html snippet=snippets.start %}

## Handling URI's

If you want to be slightly more fancy and safe with your requests, instead of using the `getRequest` function you can first parse your URI using the `Network.URI` module from the [network-uri][] package (which is what `getRequest` does internally). This module provides several ways of parsing URI's that return either Maybe's, Either's or throwing exceptions, if you're okay with throwing exceptions. But they all return `URI` type objects.

Getting those URI's into a `Request` can be done by for example `defaultGetRequest` which takes a `URI` and returns a Request that the Browser can carry out.

[network-uri]: https://hackage.haskell.org/package/network-uri

## Requests with forms

Sending requests with actual (x-www-urlencoded) payload is, as I discovered with joy, similarly easy with the Browser module. It provides a function called `formToRequest` which takes a `Form` and `URI`, returning a `Request` and a data constructor for `Form` which takes a `RequestMethod` for which the constructors are simply `POST`, `GET` etc and a list of 2-Tuples of Strings for the payload values.

{% include haskell-snippet.html snippet=snippets.form %}

## Requests with Authentication

Even though it took me a relatively long time to figure out how to do authentication with this library, it is actually relatively simple.

<!-- TODO Authentication -->

## Sending literal JSON

I've also recently had the pleasure to be in a situation where I've wanted to create some very simple json, for which the proper way (via the [aeson][] library) would have felt like overkill,

I wanted to create thw output with just string concatenation and then send it to the client. Unfortunately the [warp][] library, which is sort of the standard web server library for Haskell, uses ByteStrings for output. Now if you do things the canonical way, the [aeson][] way it'll create a unicode encoded ByteString for you and there's nothing to worry about.

The JSON standard requires the text to be unicode encoded. However when using string literals and concatenation it becomes quite obvious that ByteString is inherently not meant for unicode. So in order to get a Unicode encoded String you'll have create `Text` rather than a `String` and then specifically encode it as a unicode ByteString. You can do this by importing the `Data.Text.Encoding` module or the `Data.Text.Lazy.Encoding` module if you, like me, are dealing with [warp][] and need a lazy ByteString for output and then simply use the `encodeUtf8` function on your `Text`.

[warp]: https://hackage.haskell.org/package/warp

{% include haskell-snippet.html snippet=snippets.utf8 %}

<!-- TODO UTF encoding for literal json -->
