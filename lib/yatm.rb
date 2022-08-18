# frozen_string_literal: true

require_relative "yatm/version"
require_relative "yatm/tape/tape"
require_relative "yatm/state_machine/state_machine"

module YATM
	class Machine
		attr_reader :tape, :state_machine
		
		def initialize(position: 0, content: [nil])
			@tape = Tape.new(position: position, content: content)
			@state_machine = StateMachine.new
		end
		
		def initial_state(...); @state_machine.initial_state(...); end
		def final_state(...); @state_machine.final_state(...); end
		def states(...); @state_machine.states(...); end
		def event(...); @state_machine.event(...); end
		
		def reset(...)
			@tape.reset(...)
			@state_machine.reset
		end
		
		def to_s
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
			
			history = []
			(1..n).each do
				result = @state_machine.process!(@tape.read)
				history << result
				break if result[:final]
				@tape.write result[:write]
				@tape.move result[:move]
			end
			
			history
		end
	end
end
