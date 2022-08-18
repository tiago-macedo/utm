# Run with `./bin/console < lib/example_2.rb`

m = YATM::Machine.new
m.event 0,
	:_0 => [:_0, 0, :r],
	:_1 => [:_1, 0, :r],
	:_2 => [:_2, 0, :r],
	:_3 => [:_3, 0, :r]
m.event 1,
	:_0 => [:_1, 1, :r],
	:_1 => [:_2, 1, :r],
	:_2 => [:_3, 1, :r],
	:_3 => :overflow
m.event 2,
	:_0 => [:_2, 2, :r],
	:_1 => [:_3, 2, :r],
	:_2 => :overflow,
	:_3 => :overflow
m.event nil,
	:_0 => [:halt, 0, :r],
	:_1 => [:halt, 1, :r],
	:_2 => [:halt, 2, :r],
	:_3 => [:halt, 3, :r]
m.initial_state :_0
m.final_state :halt, :overflow

m.reset(content: [1, 2])
m.run!
puts m.tape
puts m

m.reset(content: [1, 0, 1])
m.run!
puts m.tape
puts m

m.reset(content: [1, 2, 1])
m.run!
puts m.tape
puts m
