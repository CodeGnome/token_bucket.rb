# Project Name: [Ruby Token Bucket Demo][Home]

## Copyright and Licensing

### Copyright Notice

The copyright for the software, documentation, and associated files are held by
the author.

    Copyright 2014 Todd A. Jacobs
    All rights reserved.

The AUTHORS file is also included in the source tree.

### Software License

![GPLv3 Logo]

The software is licensed under the [GPLv3 License]. The LICENSE file is included
in the source tree.

### README License

![Creative Commons BY-NC-SA Logo][CC Logo]

This README is licensed under the [Creative Commons
Attribution-NonCommercial-ShareAlike 3.0 United States License][CC License].

## Purpose

Demonstrate use of a token bucket for availability-based scheduling.

## Synopsis

Basic token bucket for availability-based scheduling. The caller never receives
an actual token; instead, a collaborator object is needed to track the tokens
that have been handed out.

See the source code for additional documentation and examples.

## Examples

No screenshots here, just samples of what you can expect to see on a console
when you run the program.

### Command Line

    $ ./token_bucket.rb
    #<TokenBucket:0x007fbb14da8398 @tokens=1>
    [#<struct Person name="John Doe", token=nil>,
     #<struct Person name="Jane Doe", token=nil>]

    John and Jane both try to schedule an appointment.
    Who has a token, and is thus eligible to make an appointment?
    [#<struct Person name="John Doe", token=true>]

    John cancels an appointment and Jane takes the returned token.
    Who has a token, and is thus eligible to make an appointment?
    [#<struct Person name="Jane Doe", token=true>]

### REPL

    require './token_bucket'

    bucket = TokenBucket.new 1
    #=> #<TokenBucket:0x007f81666f51f0 @tokens=1>

    bucket.request_token
    #=> true

    bucket.inspect
    #=> #<TokenBucket:0x007f81666f51f0 @tokens=0>

    bucket.request_token
    #=> false

    bucket.send :tokens
    #=> 0

    bucket.release_token
    #=> false

    bucket.inspect
    #=> #<TokenBucket:0x007f81666f51f0 @tokens=1>

----

[Project Home Page][Home]


[Home]: https://github.com/CodeGnome/token_bucket.rb
[CC License]: http://creativecommons.org/licenses/by-nc-sa/3.0/us/
[CC Logo]: http://i.creativecommons.org/l/by-nc-sa/3.0/us/88x31.png
[GPLv3 License]: http://www.gnu.org/copyleft/gpl.html
[GPLv3 Logo]: http://www.gnu.org/graphics/gplv3-88x31.png

<!-- vim: set tw=80 sw=4 ft=markdown: -->
