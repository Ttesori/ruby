# Build a method #bubble_sort that takes an array and returns a sorted array. A bubble sort is where each element is compared to the one next to it and they are swapped if the one on the right is larger than the one on the left. This continues until the array is eventually sorted.

# bubble_sort([4,3,78,2,0,2])  => [0,2,2,3,4,78]

def bubble_sort(to_sort)
	# decide the passes_left: to_sort.length - 1
	pass_number = 0
	passes_left = to_sort.length - 1

	# decide number of array compares_left each pass: to_sort.length
	compares_left = to_sort.length

	# begin sort if pass_number is < passes_left
	while pass_number < passes_left
		pass_number += 1
		
	# until reaching the to_sort[compares_left] for this pass, 
		while compares_left > to_sort.index(compares_left)
		
	# store to_sort[n] (curr_slot_value) and to_sort[n+1] (next_slot_value) and to_sort.index(to_sort[n]) curr_slot
			curr_slot_value = to_sort[n]
			next_slot_value = to_sort[n+1]
			curr_slot = to_sort.index(to_sort[n])
			
	# if curr_slot_value > next_slot_value, swap spots to_sort[curr_slot] = next_slot_value and to_sort[curr_slot + 1] = curr_slot_value
			if curr_slot_value > next_slot_value
				to_sort[curr_slot] = next_slot_value
				to_sort[curr_slot + 1] = curr_slot value
			else	
			end
			compares_left -= 1
		end
	# decrement passes_left
	passes_left -= 1
	# return sorted_array
	end
end
# bubble_sort([4,3,78,2,0,2])  => [0,2,2,3,4,78]