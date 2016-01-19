# BitTable

[![Build Status](https://travis-ci.org/IceDragon200/bit_table.svg?branch=master)](https://travis-ci.org/IceDragon200/bit_table)
[![Test Coverage](https://codeclimate.com/github/IceDragon200/bit_table/badges/coverage.svg)](https://codeclimate.com/github/IceDragon200/bit_table)
[![Inline docs](http://inch-ci.org/github/IceDragon200/bit_table.svg?branch=master)](http://inch-ci.org/github/IceDragon200/bit_table)
[![Code Climate](https://codeclimate.com/github/IceDragon200/bit_table/badges/gpa.svg)](https://codeclimate.com/github/IceDragon200/bit_table)

## Example

```ruby
stream = StringIO.new('')
table = BitTable.new(stream)
table[0] = 1
table[0] #=> 1
table[0] = 3
table[0] #=> 1
```
