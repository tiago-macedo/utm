# Run with `./bin/console < lib/example_3.rb`

m = YATM::Machine.new
m.event 1,
	s: [:on, 1, :r],
	on: [:on, 1, :r]
m.event nil,
	YATM::ANY => [:halt, "X", :l]
m.initial_state :s
m.final_state :halt
m.reset content: [1, 1, 1]

puts m.tape
m.run!
puts m.tape
