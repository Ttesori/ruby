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