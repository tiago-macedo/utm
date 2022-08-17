# frozen_string_literal: true

require_relative "../error"

class StateMachineError < UTM::Error; end

class InvalidState < StateMachineError
	def initialize(state)
		@state = state
	end
	
	def text
		"Argument #{@state} cannot be a state"
	end
end

class InvalidEvent < StateMachineError
	def initialize(event)
		@event = event
	end
	
	def text
		"#{@event} is not a registered event"
	end
end

class InvalidTransition < StateMachineError
	def initialize(current, event)
		@current = current
		@event = event
	end
	
	def text
		"Event #{@event} has no registered transition from state #{@current}"
	end
end

class InitialStateNotSet < StateMachineError
	def text
		"Initial state must be set pefore processing any event"
	end
end