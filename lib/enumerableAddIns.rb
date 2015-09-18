module Enumerable

	def my_each
		for i in 0 ... length
			yield( self[ i ] ) if block_given?
		end
		self
	end

	def my_each_with_index
		return self unless block_given?
		for i in 0 ... length
			yield( i, self[ i ] )
		end
		self
	end

	def my_select
		return self unless block_given?
		new_array = []
		my_each do | i | 
			if yield( i )
				new_array << i 
			end
		end
		new_array
	end

	def my_all?
		return true unless block_given?
		my_each do | x |
			if yield x
				return true
			else
				return false
			end
		end
	end

	def my_any?
		return true unless block_given?
		true_hold = false
		my_each do | x | 
			if yield x
				true_hold = true
			end
		end
		true_hold
	end

	def my_none?
		return false unless block_given?
		false_hold = true
		my_each do | x |
			if x == nil
				return false
			elsif yield x
				false_hold = false
			end
		end
		false_hold
	end

	def my_count
		count_hold = 0
		my_each do | x |
			if block_given?
				if yield x 
					count_hold += 1
				end
			else
				count_hold += 1
			end
		end
		count_hold
	end

	#my_map accepts block and proc, and will execute either or both as provided
	def my_map (proc = nil)
		arry = []
		if proc == nil
			for i in self
				arry.push( yield i )
			end	
		elsif block_given?
			for i in self
				arry << proc.call( yield i )
			end
		else	
			for i in self
				arry << proc.call( i )
			end
		end
		arry
	end

	def my_inject( *args )
		array = self.to_a

		if args.length > 2
			raise ArgumentError.new( "Wrong number of arguments: #{args.length} for 2" )
		elsif args.length == 2
			initial = args.first
			sym = args.last
		elsif args.length == 1 && args.first.class == Symbol
			initial = nil
			sym = args.first
		elsif args.length == 1
			initial = args.first
			sym = nil
		else
			initial = nil
			sym = nil
		end
		
		if initial == nil
			memo = array.first
			steps = ( 1 ... array.length ).to_a
		else
			memo = initial
			steps = ( 0 ... array.length ).to_a
		end
		
		if sym == nil
			task = lambda { | memo, obj | yield( memo, obj ) }
		else
			task = lambda { | memo, obj | memo.send( sym, obj ) }
		end
		
		steps.my_each do | index |
			memo = task.call( memo, array[ index ] )
		end

		return memo
	end

end

def multiply_els (array)
	array.my_inject { | sum, n | sum * n }
end