# frozen_string_literal: true

require_relative "tape_errors"

class UTM::Tape
	module Move
		LEFT = :l
		RIGHT = :r
		NONE = nil
	end
	
  attr_accessor :pos
	
	def initialize(position: 0, content: [nil])
		@pos, @p_tape = position, content
		@n_tape = [nil]
	end
	
	def read
		tape[table_pos]
	end
	
	def write(value)
		tape[table_pos] = value
	end
	
	def move(direction = Move::NONE)
		case direction
		when Move::RIGHT
			@pos += 1
			expand if table_pos == tape.size
		when Move::LEFT
			@pos -= 1
			expand if table_pos > tape.size
		when Move::NONE
		else
			raise InvalidMove
		end
	end
	
	def to_s
		full = @n_tape.reverse + @p_tape
		abs_pos = @pos + @n_tape.size
		str = ""
		full.each_with_index do |val, idx|
			str += idx == abs_pos ? "[#{val}]" : val.to_s
			str += " "
		end
		
		str
	end
	
	private
	
	def tape
		@pos >= 0 ?
			@p_tape :
			@n_tape
	end
	
	def table_pos
		@pos >= 0 ?
			@pos :
			-@pos - 1
	end
	
	def expand
		current_size = tape.size
		(1..current_size).each { tape << nil }
	end
end
