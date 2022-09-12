# Yet Another Turing Machine

A small gem to create an run a Turing Machines.

## Synopsis

A YATM machine consists of three parts: a **tape** (divided into discreete cells), a **head** (to read and write on the tape) and a **state machine**. The state machine, in turn, is configured by loading it with a set of **events**. Each events tells the machine what to do if it reads a certain value on the tape.

As an example in natural language, consider a machine which can be either on state `:A` or state `:B`. If the machine is supposed to switch it's state when readin the symbol `:s` from the tape, than move to the next cell, this rule would be represented by the event

> If you read the symbol `:s`
> > If you are in state `:A`, go to state `:B` then move the head one cell to the right.
> 
> > If you are in state `:B`, go to state `:A` then move the head one cell to the right.

We say that the event above is _triggered by the symbol `:s`_, and that it contains two _transitions_: one, from `:A` to `:B`, not writing anything on the tape and moving right; and another one from `:B` to `:A`, also not writing anything on the tape and moving right.

The only "ingredients" left are to define a certain state as the **initial state**, the one the state machine starts at, and define however many states you might want (including zero) as **final states**, that is, states which will halt the machine upon being reached.

### Initializing a machine

```ruby
m = YATM::Machine.new
```

### State machine

The set of states on the state machine are not defined explicitly. Instead, you can just describe the events, and all states are automatically added.

Let's translate the event we previously described in natural language into Ruby + YATM:

```ruby
m.event :s,           # When value read is :s
  :A => [:B, :s, :r], #   If on state :A, go to :B, write :s, move right
  :B => [:A, :s, :r]  #   If on state :B, go to :A, write :s, move right
```

Now, we need to set one of the states as the initial one. Note: this could also have been done before any event was registered.

```ruby
m.initial_state :A
```

We could run the machine "as is" until it found a value different than `:s` — at which point it would either raise an error (if executed with `#run!`) or do nothing (if executed with `#run`).

However, it might be better to add an event in case the machine's head reaches an empty cell on the tape (the value read will be `nil`), so that it goes to a third and final state.

```ruby
m.event nil,
  :A => [:X, "A", :n]
  :B => [:X, "B", :n]
m.final_state :X
```

The event above is triggered by reading the value `nil` from the tape. It describes two transitions, both lead the machine to state `:X` and not moving the tape's head. If it had previously been on state `:A`, it writes `"A"` on the current tape cell. It it had previously been on state `:B`, it writes `"B"`.

We then set state `:X` as final, so that the machine will halt when reaching it.

### Tape

All that is left to do now is to load the tape with values. We can also det on which cell the head starts at (default is cell 0). We will use this to leave a message at the start of the tape.

```ruby
m.reset(
	["T", "u", "r", "i", "n", "g", :s, :s, :s],
	position: 6
)
```

The machine will start with the head positioned over the first `:s`. There will be two more `:s` to the right (and the name "Turing" to the left), and then an infinite amount of `nil`s (both to the left and to the right).

### Running

```ruby
m.run!            # Run until halting
m.to_h[:final]    # => true (machine has indeed halted)
m.to_h[:state]    # => :X (in which state it halted)
m.to_h[:position] # => 9 (in which position it ended up)
m.history         # A record of all transitions
```


## Development state

Beta.

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
- 🗹 Final states
- 🗹 Allow transitions from any state (`m.event :e, YATM::ANY => [:state, "e", :r]`)
- 🗹 Other syntatic

### Beta

- ☐ Tests
- ⚒ Documentation

### Release 1

- ☐ Compositon of machines

### Release 2

- ☐ Thread safety
- ☐ Imutability
- ☐ Next-gen holistic RESTful mainframe cryptography on the edge
- ☐ Blockchain integration
- ☐ AI
  - ☐ If-else-based AI
  - ☐ Unscrutable linear algebra-based AI
  - ☐ GPT-3 integration
  - ☐ Paperclip maximization
- ☐ Bluetooth

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tiago-macedo/yatm.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
