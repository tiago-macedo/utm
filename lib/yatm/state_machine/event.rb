# frozen_string_literal: true

require_relative "../tape/tape"

class YATM::Event
	attr_reader :name, :transitions
	
	def initialize(name, **transitions)
		@name = name
		@transitions = {}
		transitions&.each { |t| add_transition(t) }
	end
	
	def keys; @transitions.keys; end
	def map(&block); @transitions.map(&block); end
	def [](key); @transitions[key]; end
	
	def to_s
		str = "#{name.nil? ? "_" : name}:\n"
		@transitions.each do |k, v|
			str += "  #{k} -> #{v}\n"
		end
		str
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
		
		from = YATM::StateMachine.statify(t[0])
		to = t[1][0] == YATM::SAME ?
			from :
			YATM::StateMachine.statify(t[1][0])
		write = t[1][1] == YATM::SAME ?
			@name :
			t[1][1] || @name
		move = t[1][2] || YATM::NONE
		
		@transitions.merge!({
			from => {
				to: to,
				write: write,
				move: move
			}
		})
	end
end
