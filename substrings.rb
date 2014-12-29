# Implement a method #substrings that takes a word as the first argument and then an array of valid substrings (your dictionary) as the second argument. It should return a hash listing each substring (case insensitive) that was found in the original string and how many times it was found.

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
# substrings("below", dictionary)    => {"below"=>1, "low"=>1}
# substrings("Howdy partner, sit down! How's it going?", dictionary) 
# {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}


def substrings(text,dictionary)
	text.downcase!
	#create array of words and hash of frequencies
	words_list = text.split(/[!$. ,|?*+()]/)
	frequencies = Hash.new()

	# add each word of dictionary into a new hash
	dictionary.each do |entry|
		frequencies[entry] = 0
	end
	# step through words
	words_list.each do |words|
		#try to match word
		frequencies.each do |word,numtimes|
			if words.include? word
				frequencies[word] += 1
			end
		end
	end
	# delete unused words
	frequencies.delete_if {|key, value| value == 0 }
	# output results
	puts frequencies
end

substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary) 