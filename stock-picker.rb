# Create a stock picker to figure out best days to buy and sell when given an arra,y
# stock_picker([17,3,6,9,15,8,6,1,10]),
# return => [1,4]  # for a profit of $1,5, - $3 == $12

def stock_picker(values)
	value = 0
	max_value = 0
	best_buy_day = 0
	best_sell_day = 0
	buy_day = 0
	#loop through buy days/values
	values.each do |buy_value|
		sell_day = 0
		#calculate sell value if sell day > buy day
			while sell_day < values.length
				value = values[sell_day] - buy_value
				#puts value if greater than current max and sell day is after buy day
				 if value > max_value && sell_day > buy_day
				 	max_value = value
				 	best_buy_day = buy_day
				 	best_sell_day = sell_day
				 end
				sell_day += 1
			end
		buy_day += 1
	end
	puts "Buy on day #{best_buy_day + 1} sell on day #{best_sell_day + 1} make $#{max_value}"
end
stock_picker([17,3,6,9,15,8,6,1,10])
stock_picker([15,6,19,11,1,18,5,6])
stock_picker([12,4,8,67])
stock_picker([14,21,1,41,23,50,25,32,5])