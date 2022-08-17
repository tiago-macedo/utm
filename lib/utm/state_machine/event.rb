# frozen_string_literal: true

require_relative "../tape/tape"

class UTM::Event
	attr_reader :name, :transitions
	
	def initialize(name, **transitions)
		@name = name
		@transitions = {}
		transitions&.each { |t| add_transition(t) }
	end
	
	def to_s
		str = "#{name}: {\n"
		@transitions.each do |k, v|
			str += "  #{k} -> #{v}\n"
		end
		str += "}"
	end
	
	def run(from)
		@transitions[from]
	end
	
	def run!(from)
		run(from) or raise InvalidTransition.new(from, @name)
	end
	
	private
	
	def add_transition(t)
		unless t[1].is_a?(Array)
			return add_transition( [ t[0], [t[1]] ] )
		end
		
		from = statify(t[0])
		to = statify(t[1][0])
		write = t[1][1] || @name
		move = t[1][2] || UTM::Tape::Move::NONE
		
		@transitions.merge!({
			from => {
				to: to,
				write: write,
				move: move
			}
		})
	end
	
	def statify(state)
		raise InvalidState.new(state) unless state.respond_to?(:to_s)
		state = state.to_s
		raise InvalidState.new(state) unless state.respond_to?(:to_sym)
		state.to_sym
	end
end
