# Build a method #bubble_sort that takes an array and returns a sorted array. A bubble sort is where each element is compared to the one next to it and they are swapped if the one on the right is larger than the one on the left. This continues until the array is eventually sorted.

# bubble_sort([4,3,78,2,0,2])  => [0,2,2,3,4,78]

def bubble_sort(to_sort)
pass = 0 # keep track of number of passes -- we need array.length - 1 to be sure we have them all
	while pass < to_sort.length
		to_sort.each_with_index do |value,slot| 
			if (value <=> to_sort[slot.to_i+1]) == 1 #if first value is larger
				to_sort[slot],to_sort[slot+1] = to_sort[slot+1],to_sort[slot] #swap values
			end
		end
	pass += 1 #increment passes
	end
	return to_sort
end
p bubble_sort([4,3,78,2,0,2])


# Now create a similar method called #bubble_sort_by which sorts an array but accepts a block. The block should take two arguments which represent the two elements currently being compared. Expect that the block's return will be similar to the spaceship operator you learned about before -- if the result of the block is negative, the element on the left is "smaller" than the element on the right. 0 means they are equal. A positive result means the left element is greater. Use this to sort your array.

 #bubble_sort_by(["hi","hello","hey"]) do |left,right|
 	#right.length - left.length
 #end
 #=> ["hi", "hey", "hello"]

def bubble_sort_by(to_sort)
pass = 0 # keep track of number of passes -- we need array.length - 1 to be sure we have them all
	while pass < (to_sort.length-1)
		to_sort.each_with_index do |currValue,slot| #step through each array spot
			nextValue = to_sort[slot+1] #grab next spot value
			if !nextValue.nil? #as long as the next spot isn't nil, perform the comparison
				if yield(currValue,nextValue).to_i > 0 
					to_sort[slot],to_sort[slot+1] = to_sort[slot+1],to_sort[slot] #swap spots
				end
			end
		end
	pass += 1 #increment passes
	end
	p to_sort
end

 bubble_sort_by(["hi","hello","hey"]) do |left,right|
 	left.length - right.length
 end