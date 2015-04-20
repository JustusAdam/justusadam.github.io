---
title: TeX compiler automator
github_link: fsr/lesson-builder
status: finished, actively maintained
languages:
  - Python
---

This one is unfinished but finished at the same time.

It basically means that it work's and does what it's supposed to but I am not satisfied with it yet. The structure of the config is not good in my opinion.
I've had some ideas on how to make it better (adding the features I'd like to have) but they all seemed to make too convoluted and difficult to use.

Since there's no documentation yet, I've decided to add one as a github [wiki](https://github.com/fsr/lesson-builder/wiki). Not much there yet but there (hopefully) will be.

## What it does

The builder module consists of two parts.

### The actual builder

A bunch of python functions that'll asynchronously build however many TeX source files you like using a command that can be specified in the config.

*Technically it could execute any command on any file but that would require said command to be added to the allowed commands python set in the script itself*

Once the builder is finished it'll print the report on how the build went to the log.

Optionally a git repository can be added to the config which will cause the builder to pull or clone the repository before starting to build.

### The GitHub Webhook receiver

[GitHub Webhooks](https://developer.github.com/webhooks/) are a very useful tool for monitoring the activity in a repository. This part of the builder is a cgi script that will, when receiving a pull Hookshot, pull and build the repository in question, provided the repository is in the watch config.
