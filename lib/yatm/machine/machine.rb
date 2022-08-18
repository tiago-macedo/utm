# frozen_string_literal: true

class YATM::Machine
	attr_reader :tape, :state_machine, :history
	
	def initialize(position: 0, content: [nil])
		@tape = YATM::Tape.new(position: position, content: content)
		@state_machine = YATM::StateMachine.new
		@history = []
	end
	
	def initial_state(...); @state_machine.initial_state(...); end
	def final_state(...); @state_machine.final_state(...); end
	def states(...); @state_machine.states(...); end
	def event(...); @state_machine.event(...); end
	
	def reset(...)
		@history = []
		@tape.reset(...)
		@state_machine.reset
	end
	
	def to_h
		{
			state: @state_machine.current_state,
			final: @state_machine.final_states.include?(@state_machine.current_state),
			position: @tape.pos
		}
	end
	
	def to_s; to_h.to_s; end
	
	def to_txt
		<<~TO_S
		,_______________
		| State Machine
		`---------------
		#{@state_machine}
		,______
		| Tape
		`------
		#{@tape}
		TO_S
	end
	
	def step!(n = 1)
		return if n < 1
		
		(1..n).each do
			result = @state_machine.process!(@tape.read)
			@history << result
			break if result[:final]
			@tape.write result[:write]
			@tape.move result[:move]
		end
		
		@history.last
	end
	
	def step(...)
		step!(...) rescue YATM::Error
	end
	
	def run!(max = Float::INFINITY)
		(1..max).each do
			latest = step!
			break to_h if latest[:final]
		end
	end
	
	def run(...)
		run!(...) rescue YATM::Error
	end
end
