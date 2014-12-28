# Sort an array manually

# Declare array of words
array_to_sort = ["Toni","Michael","Olivia"]

# Copy into array of unsorted words, create empty array of sorted words
unsorted_words = array_to_sort
sorted_words = []

# Compare first two words in array, add smaller to sorted and remove from unsorted
array_to_sort.length.times do |x|
	if (unsorted_words[0] < unsorted_words[1]) 
		sorted_words.push(unsorted_words[0])
		unsorted_words.pop(unsorted_words[0])
	else sorted_words.push(unsorted_words[1])
		unsorted_words.pop(unsorted_words[1])
	end
end

sorted_words.each do |x|
	puts x + ", "
end
# Compare last word in sorted array to next word in unsorted array, add smaller to sorted and remove from unsorted
# Repeat until unsorted array is empty