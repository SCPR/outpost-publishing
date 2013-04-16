# Outpost::Publishing

Adds some helper UI for publishing in Outpost. Also adds the ability to use
auto-publishing for any content.

This gem assumes that the models you want to use it with have at least a 
"Published" and "Pending" status, and that they respond to `#published?` and 
`#pending?`.


## Installation

    gem 'outpost-publishing'

## Usage

Drop it into your javascript manifest:

```javascript
//= require outpost/publishing
//= require outpost/content_alarms
```

Then instantiate using Javascript. Initialize by passing in a few options:

* the form selector (such as `#post_99`),
* the selector of the div wrapper around the publishing fields,
* the selector for where to render the notifications,
* the selector for the status input

```javascript
$(function() {
  publishing = new outpost.Publishing({
    form: "#<%=f.options[:html][:id]%>",
    container: ".publishing-fields",
    notifications: "<%= options[:notifications] || "#scheduled_status" %>",
    statusField: "#status-select"
  });
});
```


### Content Alarms

This gem provides a mixin, `Outpost::Publishing::ActsAsAlarm`, which you can
mix in to any class which you want to acts as an alarm. It adds a polymorphic
association with `content`, a scope for finding `pending` alarms, and a few
other methods. Look at the mixin for all of the details.

To make an alarm, add a table:

```ruby
create_table :publish_alarms do |t|
  t.integer :content_id
  t.string :content_type
  t.datetime :fire_at
  t.timestamps
end

add_index :publish_alarms, [:content_type, :content_id]
```

Then the class would look something like:

```ruby
class PublishAlarm < ActiveRecord::Base
  include Outpost::Publishing::ActsAsAlarm
end
```

"Publishing" is currently the only action that is supported by default.
You can override the `fire` instance method to change what the alarm actually
does.


## Contributing

Yes, please. PR's are appreciated.
