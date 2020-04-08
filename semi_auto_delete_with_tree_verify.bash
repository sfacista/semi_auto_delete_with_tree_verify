#!/bin/bash 
#Delete a lot of stuff using a limited tree to verify contents
#Salvatore Facista - 2020 - MIT 
#Good for fastqs in TGen pipeline after archival

#Begin license text.
#Copyright 2020 Salvatore Facista
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#End license text.

echo "WARNING! This script deletes files in your current directory!"

echo "You are about to delete a bunch of stuff in the directory where this script lives. You will be prompted with a tree -L 2 for each item. Press Ctrl+C to cancel the whole job."
echo "Selecting anything but y or Y will move you on to the next file without deleting something. You will be asked to confirm a delete."

echo "WARNING! This script deletes files in your current directory!"

read -p "Do you want to start selecting files for deletion (y/n)?" in1  
echo    # just a blank line

if [ $in1 = "y" ] || [ $in1 = "Y" ];
	then
		echo "Making array of files uning temp_array_1=(\$(ls -d */))  ..."
		temp_array_1=($(ls -d */))
		echo "... done."
		echo ""
		echo "Measuring array length using temp_len_1=\${#temp_array_1[@]} ..."
		temp_len_1=${#temp_array_1[@]}
		echo "... done. "
		echo "Found this many directories: " ${temp_len_1}
		echo ""
		
		for ((i = 0 ; i < temp_len_1 ; i++))
			do
				temp_item0=${temp_array_1["${i%/}"]}
				temp_item1=${temp_item0%/}
				printf ${temp_item1} 
				printf " is the directory."
				echo ""
				
				tree -L 2 ${temp_item1}
				read -p "Do you want to delete everything inside this directory (y/n)?" in2  
				echo    # just a blank line

				if [ ${in2} = "y" ] || [ ${in2} = "Y" ];
					then
						echo "!About to delete everthing inside this directory!: " ${temp_item1}
						read -p  "Are you sure (y/n)?"  in3

						if [ ${in3} = "y" ] || [ ${in3} = "Y" ];
							then
							#echo "MOCK FILE DELETION - NO RM HERE YET"
							rm -r "${temp_item1}"
						else
							echo "Cancelled - No files were deleted."
							break
						fi
						
				else
					echo "File not deleted ... going on to next file."
				fi
				
			done
		
		
	
	
	
	else 
		echo "Nothing was done."
		exit 0
fi

