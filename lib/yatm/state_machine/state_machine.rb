# frozen_string_literal: true

require_relative "state_machine_errors"
require_relative "event"

class YATM::StateMachine
	attr_reader :current_state, :events, :final_states, :initial_state
	
	def initialize
		@events = []
		@final_states = []
		
		def @events.[](name)
			self.find { |e| e.name == name }&.transitions
		end
	end
	
	def reset
		@current_state = @initial_state
	end
	
	def to_s
		<<~TO_S.chomp
		| states:  #{states}
		| current: #{@current_state}
		| events: #{@events.map(&:name)}
		TO_S
	end
	
	def states
		@events.map do |event|
			event.transitions.keys + event.transitions.map{ |key, val| val[:to] }
		end.flatten.uniq
	end
	
	def initial_state(state)
		@initial_state = statify(state)
		@current_state = @initial_state
	end
	
	def final_state(*states)
		states.each do |state|
			(@final_states << statify(state)).uniq!
		end
	end
	
	def event(...)
		@events << YATM::Event.new(...)
	end
	
	def process(value)
		process!(value)
	rescue StateMachineError
		nil
	end
	
	def process!(value)
		return {final: @current_state} if @final_states.include?(@current_state)
		raise InitialStateNotSet unless @current_state
		raise InvalidEvent.new(value) unless (
			event = @events[value]
		)
		raise InvalidTransition.new(@current_state, event) unless (
			transition = event[@current_state]
		)
		
		@current_state = transition[:to]
		transition
	end
	
	private
	
	def statify(name)
		raise InvalidState.new(name) unless name.respond_to?(:to_s)
		name = name.to_s
		raise InvalidState.new(name) unless name.respond_to?(:to_sym)
		name.to_sym
	end
end
