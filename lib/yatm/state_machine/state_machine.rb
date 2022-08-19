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
		@initial_state = self.class.statify(state)
		@current_state = @initial_state
	end
	
	def final_state(*states)
		states.each do |state|
			(@final_states << self.class.statify(state)).uniq!
		end
	end
	
	def event(name, **transitions)
		if (any_result = transitions.delete(YATM::ANY))
			any_from = states - @final_states
			any_transitions = any_from.map do |from|
				[from, any_result]
			end.to_h
			transitions.merge! any_transitions
		end
		@events << YATM::Event.new(name, **transitions)
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
	
	def self.statify(state)
		raise InvalidState.new(state) unless state.respond_to?(:to_s)
		state = state.to_s
		raise InvalidState.new(state) unless state.respond_to?(:to_sym)
		state.to_sym
	end
end
