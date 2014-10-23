#!/usr/bin/env ruby

# Purpose:
#     Demonstrate how to use a token bucket for availability-based scheduling.
#
# License:
#    Copyright 2014 Todd A. Jacobs
#
#    This program is free software: you can redistribute it and/or
#    modify it under the terms of the GNU General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful, but
#    WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#    General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see
#    Licenses[http://www.gnu.org/licenses/].

# Basic token bucket for availability-based scheduling. The caller never
# receives an actual token; instead, a collaborator object is needed to track
# the tokens that have been handed out.
class TokenBucket
  def initialize tokens=20
    @tokens = tokens
  end

  # Request a token from the bucket if one is available. Returns a Boolean value
  # based on whether a token was available for the caller or not.
  def req_token
    if tokens?
      @tokens -= 1
      return true
    end
    false
  end

  # Return a token to the bucket. Return false as the calling object will no
  # longer have a token.
  def rel_token
    @tokens += 1
    false
  end

  private

  def tokens
    @tokens
  end

  def tokens?
    @tokens > 0
  end
end

if __FILE__ == $0
  require 'pp'

  # Set up a token bucket to represent a single appointment slot to contend for,
  # and define an Array of Structs to act as the collaborator object.
  tb = TokenBucket.new 1
  Person = Struct.new :name, :token
  people = [Person.new('John Doe'), Person.new('Jane Doe')]

  # John and Jane both try to schedule an appointment.
  people[0].token = tb.req_token
  people[1].token = tb.req_token

  # Who has a token, and is thus eligible to make an appointment?
  pp people.select { |person| person.token }
  #=> [#<struct Person name="John Doe", token=true>]

  # John cancels an appointment and Jane takes the token.
  people[0].token = tb.rel_token
  people[1].token = tb.req_token

  # Who has a token, and is thus eligible to make an appointment?
  pp people.select { |person| person.token }
  #=> [#<struct Person name="Jane Doe", token=true>]
end
