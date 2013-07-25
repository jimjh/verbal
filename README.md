Verbal
=====================
[![Build Status](https://travis-ci.org/jimjh/verbal.png?branch=master)](https://travis-ci.org/jimjh/verbal)

## Overview
Verbal is a Ruby library that helps to construct difficult regular expressions.
It's ported from the awesome JavaScript [VerbalExpressions](https://github.com/jehna/VerbalExpressions).

## Installation

```sh
$> gem install verbal
```

```ruby
require 'verbal'
```

## Examples

Here's a couple of simple examples to give an idea of how Verbal works:

### Testing if we have a valid URL

```ruby
# Create an example of how to test for correctly formed URLs
tester = Verbal.new do
  start_of_line
  find 'http'
  maybe 's'
  find '://'
  maybe 'www.'
  anything_but ' '
  end_of_line
end

# Create an example URL
test_url = "https://www.google.com"

# Use it just like a regular Ruby regex:
puts 'Hooray!  It works!' if tester.match(test_url)
puts 'This works too!' if tester =~ test_url

# Print the generated regex:
puts tester.source # => /^(?:http)(s)?(?::\/\/)(www\.)?([^\ ]*)$/i
```

### Replacing strings

```ruby
# Create a test string
replace_me = "Replace bird with a duck"

# Create an expression that seeks for word "bird"
expression = Verbal.new { find 'bird' }

# Execute the expression like a normal Regexp object
result = replace_me.gsub( expression, "duck" );

puts result # Outputs "Replace duck with a duck"
```

## Issues
 - I haven't yet ported the modifier code because Ruby Regexp handles modifiers a little differently.

## Thanks!
Thank you to @jehna for coming up with the awesome original idea.

Thank you to @ryan-endacott for the original port.
