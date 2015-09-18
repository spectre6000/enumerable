module Enumerable

	def my_each
		for i in 0...length
			yield(self[i]) if block_given?
		end
		self
	end

array = [1, 2, 3, 4, 5, 6]
double = Proc.new {|x|puts x*2}
print array.my_each
print array.each(&double)
print array.my_each(&double)

	def my_each_with_index
		return self unless block_given?
		for i in 0...length
			yield(i, self[i])
		end
		self
	end

#array = [1, 2, 3, 4, 5, 6]
#double = Proc.new {|x, y|puts "#{x} #{y*3}"}
#print array.each_with_index(&double)
#print array.my_each_with_index(&double)
#print array.each_with_index
#print array.my_each_with_index


	def my_select
		return self unless block_given?
		new_array = []
		my_each {|i| new_array << i if yield(i)}
		new_array
	end

#array = [1, 2, 3, 4, 5, 6]
#double = Proc.new {|x| x%2==0}
#print array.select
#print array.my_select
#print array.select(&double)
#print array.my_select(&double)


	def my_all?
		return true unless block_given?
		my_each do |x|
			if yield x
				return true
			else
				return false
			end
		end
	end

#array = [2, 2, 4, 4, 6, 6]
#double = Proc.new {|x| x%2==0}
#print array.all?
#print array.my_all?
#print array.all?(&double)
#print array.my_all?(&double)

	def my_any?
		return true unless block_given?
		true_hold = false
		my_each {|x| if yield x;true_hold = true;end}
		true_hold
	end

#array = [2, 2, 3, 4, 6, 6]
#array = [2,4,6]
#array = [1,3,5,]
#double = Proc.new {|x| x%2==0}
#print array.any?
#print array.my_any?
#print array.any?(&double)
#print array.my_any?(&double)

	def my_none?
		return false unless block_given?
		false_hold = true
		my_each do |x|
			if x == nil
				return false
			elsif yield x
				false_hold = false
			end
		end
		false_hold
	end

#array = [2, 2, 3, 4, 6, 6]
#array = [2,4,6]
#array = [1,3,5,]
#double = Proc.new {|x| x%2==0}
#print array.none?
#print array.my_none?
#print array.none?(&double)
#print array.my_none?(&double)

	def my_count
		count_hold = 0
		my_each do |x|
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

#array = [2, 2, 3, 4, 6, 6]
#array = [2,4,6]
#array = [1,3,5,]
#double = Proc.new {|x| x%2==0}
#print array.count
#print array.my_count
#print array.count(&double)
#print array.my_count(&double)

	def my_map 
		arry = []
		for i in self 
			arry << yield(i)
		end
		arry
	end

	def my_mapii (proc)
		arry = []
		for i in self
			arry << proc.call(i)
		end
		arry
	end

	def my_mapiii (proc = nil)
		arry = []
		if proc == nil
			for i in self
				arry.push(yield i)
			end	
		elsif block_given?
			for i in self
				arry << proc.call(yield i)
			end
		else	
			for i in self
				arry << proc.call(i)
			end
		end
		arry
	end

#array = [1,2,3,4]
#halfloat = Proc.new {|n| n.to_f/2}
#print array.my_mapiii(halfloat) {|y| y * 2}
#print array.my_mapiii(halfloat)
#print array.my_mapiii {|y| y*2}


	def my_inject(*args)
		array = self.to_a

		if args.length > 2
			raise ArgumentError.new("Wrong number of arguments: #{args.length} for 2")
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
			steps = (1...array.length).to_a
		else
			memo = initial
			steps = (0...array.length).to_a
		end
		
		if sym == nil
			task = lambda { |memo, obj| yield(memo, obj) }
		else
			task = lambda { |memo, obj| memo.send(sym, obj) }
		end
		
		steps.my_each do |index|
			memo = task.call(memo, array[index])
		end

		return memo
	end

end


def multiply_els (array)
#	array.my_inject{|sum, n| sum*n}
end

#array = [2,4,5]
#print array.my_inject(3){|sum,n|sum*n}
#print array.inject(3){|sum,n|sum*n}
#print array.my_inject {|sum,n|sum*n}
#print array.inject{|sum,n|sum*n}
#print array.my_inject(2, :*)
#print array.inject(2, :*)














