# Yet Another Turing Machine

This gem allows you to program an run a Turing Machine.

## Current state

Alpha.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yatm'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install yatm

## Usage

See the examples at `lib/example_1.rb` and `lib/example_2.rb`.

## Roadmap

### Alpha
- [x] Final states
- [x] Allow transitions from any state (`m.event :e, UTM::any => [:state, "e", :r]`)
- [ ] Other syntatic sugar

### Beta

- [ ] Tests
- [ ] Documentation

### Release 1

- [ ] Compositon of machines

### Release 2

- [ ] Thread safety
- [ ] Imutability
- [ ] Next-gen holistic RESTful mainframe cryptography
- [ ] Blockchain integration
- [ ] AI
  - [ ] If-else-based AI
  - [ ] Unscrutable linear algebra-based AI
  - [ ] GPT-3 integration
- [ ] Client side rendering
- [ ] Bluetooth

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tiago-macedo/yatm.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
