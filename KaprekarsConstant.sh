#!/bin/bash
# Joshua Barber
# Kaprekars Constant
# Nov 1 2022

# Validate Parameters
if (( $# != 1 ));
then
	echo "Usage: $0 Number "
	exit 0
fi

# Validate Parameter is 4 digits and not all the same
dig1=$(echo $1 | cut -c 1)
dig2=$(echo $1 | cut -c 2)
dig3=$(echo $1 | cut -c 3)
dig4=$(echo $1 | cut -c 4)
if [[ $dig1 == $dig2 && $dig2 == $dig3 && $dig3 == $dig4 ]]
then
	echo "All digits are the same. Please enter at least 2 unique digits."
	exit 0
fi

# Loop until Kaprekars Constant is reached
NewNumber=$1
i=1
while [[ $NewNumber != 6174 ]]
do
	# Sort the new number
	AscNumber=$(echo $NewNumber | grep -o . | sort |tr -d "\n")
	DescNumber=$(echo $NewNumber |grep -o . | sort -r |tr -d "\n")
	printf "Iteration $i \n   New Number: $NewNumber \n   Desc Number: $DescNumber \n   Asc Number: $AscNumber \n"

	# Check for leading 0's in ascending number
	if [[ $(echo $AscNumber | cut -c 1) == 0 ]]
	then
		AscNumber=$(echo $AscNumber | cut -c 2-)
	fi

	# Calculate and print
	NewNumber=$((DescNumber-AscNumber))
	printf "   $DescNumber - $AscNumber = $NewNumber \n"

	# Check to see if new number needs leading 0 (new number becomes 3 digits [999])
	if [[ $NewNumber == 999 ]]
	then
		NewNumber=0999
	fi
	
	# Increase iteration count
	let "i++"
done
