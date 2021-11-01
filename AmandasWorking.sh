#! /bin/bash

#Checking to make sure a file was given to process
if [ $# != 1 ]
then
echo "Usage: Please input a FASTA file when running this script"
exit
fi

#Checking to see if it not only exists, but that it is not an empty file.
if [ -s $1 ]
then
echo "$1 exists and is not empty...Continuing"
else
echo "$1 does not exists or is an empty file...aborting"
exit
fi

#Determine # of sequences in given file
nseq=`grep ">" $1 | wc -l`
echo -e "\nThere are $nseq sequences in $1"

#Making an empty file to hold output; printing tab-delim header
touch GCcount.3.txt
echo -e "Sequence_Name\tGC_Percentage" > GCcount.3.txt

#sorting sequence names and values into appropriate arrays
names=(`grep ">" $1 | tr -d ">"`) #could also use sed
seqs=(`grep -v ">" $1`)

#Initializing a loop for as many elements we have in our arrays, based on $nseq count from file
for ((i=0; i<$nseq; i++))
do

#printing sequences from array without new line characters and counting the occurances of G|C|Allcharacters, no matter the case
G=`echo -n ${seqs[$i]}|grep -oi "G"|wc -l`
C=`echo -n ${seqs[$i]}|grep -oi "C"|wc -l`
T=`echo -n ${seqs[$i]}| wc -m`

#calculating the GC %
GCp=`echo "scale=3; ((($G + $C)/$T)*100)"|bc`

#output into file
echo -e "${names[$i]}\t$GCp" >> GCcount.3.txt
done
