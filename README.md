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
* (optional) `statusPending` and `statusPublished` to indicate the value
for each of those. Default is 3 and 5, respectively.

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

This gem only provides UI for content alarms. You'll need to do the
server-side stuff yourself.

An alarm might look like this:

```ruby
create_table :publish_alarms do |t|
  t.integer :content_id
  t.string :content_type
  t.datetime :fire_at
  t.timestamps
end

add_index :publish_alarms, [:content_type, :content_id]
add_index :publish_alarms, :fire_at
```

The only things that the UI script requires is a "fire_at" field, and a status
field to read.


## Contributing

Yes, please. PR's are appreciated.
