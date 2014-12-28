# Get a text input and integer and shift all letters the # of spaces

def caesar_cipher(text_to_code,shift)
	final_text = ""
	counter = 0
	# While we still have letters to convert
	while counter < text_to_code.length
		letter = text_to_code[counter]
		# Set our counter equal to shift
		shift_counter = shift
		while shift_counter > 0	
			if letter =~ /[!$. ,|?*+()]/	# Skip special characters
				shift_counter = 0
			else 	# move letter one space
				if letter == "Z" # if letter is Z, start over at beginning or Ruby outputs 'AB, etc'
					letter = "A"
				elsif letter == "z" # if letter is z, start over at 'a'
					letter = "a"
				else 
					letter = letter.next! # else, increment letter
				end
				shift_counter -= 1 # decrement number of letter shifts left
			end
		end
		# add result to final text, increment counter
		final_text += letter[0]
		counter += 1
	end
	# return result to user
	puts "Your ciphered text is: '#{final_text}'!"
end

puts "Please give a word or phrase to Caesar-ize"
text_to_code = gets.chomp
puts "How many letters to shift?"
shift = gets.chomp.to_i
caesar_cipher(text_to_code,shift)