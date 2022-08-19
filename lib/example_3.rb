# Run with `./bin/console < lib/example_3.rb`

m = YATM::Machine.new
m.event 1,
	s:	[:on , :_, :r],
	on:	[:_  , :_, :r]
m.event nil,
	:* => [:halt, "X", :l]
m.initial_state :s
m.final_state :halt
m.reset [1, 1, 1]

puts m.tape
m.run!
puts m.tape
