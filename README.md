# CkeditorAssetsFolders

This gem add virtual folders for ckeditor assets.
Physically file system will be the same, but in ckeditor assets window you`ll can add and edit folders.
And add uploads in this folders for more flexible user interface.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jquery-dragdrop-rails', github: 'alippert/jquery-dragdrop-rails' # optional: version without railties v3.0 dependencies
gem 'ckeditor_assets_folders', github: 'ack43/ckeditor_assets_folders' #temporary
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ckeditor_assets_folders

## Usage

That is all! Use ckeditor as usual. Folders will be there.

## TODO

* Fix file counters.
* Filters
* Orders

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ack43/ckeditor_assets_folders.
