# frozen_string_literal: true

require_relative "state_machine_errors"
require_relative "event"

class UTM::StateMachine
	attr_reader :current_state, :events
	
	def initialize
		@events = []
		
		def @events.[](name)
			self.find { |e| e.name == name }&.transitions
		end
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
	
	def initial_state(s)
		@current_state ||= statify(s)
	end
	
	def event(...)
		@events << UTM::Event.new(...)
	end
	
	def process(value)
		process!(value)
	rescue StateMachineError
		nil
	end
	
	def process!(value)
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
