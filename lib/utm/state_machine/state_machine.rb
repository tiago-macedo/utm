# frozen_string_literal: true

require_relative "state_machine_errors"

class UTM::StateMachine
	attr_reader :current_state
	
	def initialize(states: nil, transitions: nil)
		@states = Set.new
		state(states) if states
		@transitions = {}
	end
	
	def states
		@states.to_a
	end
	
	def transitions
		@transitions.map { |key, val| [key, val.clone] }.to_h
	end
	
	def state(arg)
		if arg.is_a? Array
			arg.each { |element| state(element) }
			return states
		end
		
		@states << statify(arg)
		return states
	end
	
	def initial_state(s)
		@current_state ||= statify(s)
		state(s)
	end
	
	def transition(from:, to:, because:)
		from = statify(from)
		to = statify(to)
		
		if @transitions[because]
			@transitions[because].merge!({from => to})
		else
			@transitions[because] = {from => to}
		end
	end
	
	def process(event)
		return unless (transition = @transitions[event])
		return unless (next_state = transition[@current_state])
		
		@current_state = next_state
	end
	
	def process!(event)
		raise InvalidEvent.new(event) unless (transition = @transitions[event])
		raise InvalidTransition.new(@current_state, event) unless (next_state = transition[@current_state])
		
		@current_state = next_state
	end
	
	private
	
	def statify(name)
		raise InvalidState.new(name) unless name.respond_to?(:to_s)
		name = name.to_s
		raise InvalidState.new(name) unless name.respond_to?(:to_sym)
		name.to_sym
	end
end
