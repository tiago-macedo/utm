# Run with `./bin/console < lib/example.rb`

m = UTM::Machine.new
m.event nil,
	start: [:a, 1, :r],
	a: [:b, 1, :r],
	b: [:c, 1, :r],
	c: [:x, nil, :l],
	end: :end
m.event 1,
	x: [:y, 1, :l],
	y: [:z, 2, :l],
	z: [:end, 1, :l]
	
m.initial_state :start

m.step!(10)
puts m.tape
