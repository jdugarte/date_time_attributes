# Date Time Attributes

Creates date and time virtual attributes from a date/time attribute.

## Installation

```bash
gem install date_time_attribute
```

Or add it to your Gemfile:

```ruby
gem 'bootstrap_form_extensions'
```

Then:

```bash
bundle
```

## Usage

```ruby
class Event < ActiveRecord::Base

  date_time_attributes_for :start_at

end

event = Event.new
event.start_at                    # => nil
                                  
event.start_at = Time.now         # => 2015-10-29 14:59:34 -0400
event.start_date                  # => "2015-10-29"
event.start_time                  # => "18:59:34"
                                  
event.start_date = '1971-10-21'   # => "1971-10-21"
event.start_at                    # => 1971-10-21 14:59:34 -0400
                                  
event.start_time = '11:30:00'     # => "11:30:00"
event.start_at                    # => 1971-10-21 11:30:00 -0400
```

If the attribute ends with '_at', as in the previous example, the date and time attributes are called attribute_date and attribute_time. Otherwise, 'date' and 'time' just get added to the attribute name:

```ruby
class Event < ActiveRecord::Base

  date_time_attributes_for :ending

end

event = Event.new
event.ending                      # => nil
                                  
event.ending = Time.now           # => 2015-10-29 14:59:34 -0400
event.ending_date                 # => "2015-10-29"
event.ending_time                 # => "18:59:34"
```

### Plain Ruby Classes

ActiveRecord is extended automatically when the gem is added to a Rails project. If you want to use this in a plain ruby class, just extend the class:

```ruby
class Event

  extend DateTimeAttributes

  date_time_attributes_for :start_at

end
```
