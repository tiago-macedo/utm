# Run with `./bin/console < lib/utm/state_machine/example.rb`

sm = UTM::StateMachine.new

sm.state [:a, :b, :c]
sm.initial_state "start"
sm.state "finish"

sm.transition from: :start, to: "a", because: "on"
sm.transition from: :a, to: :b, because: 1
sm.transition from: :b, to: :c, because: 2
sm.transition from: :c, to: :a, because: 3
sm.transition from: :a, to: :finish, because: false
sm.transition from: :b, to: :finish, because: false
sm.transition from: :c, to: :finish, because: false

sm
sm.current_state
sm.process! "on"
sm.current_state
sm.process! 1
sm.current_state
sm.process! 2
sm.current_state
sm.process! 3
sm.current_state
"attempt invalid event with #process:"
sm.process 4
sm.current_state
sm.process false
sm.current_state
"attempt invalid event with #process!:"
sm.process! 1
