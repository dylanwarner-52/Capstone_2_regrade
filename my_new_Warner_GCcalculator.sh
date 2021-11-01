#!/bin/bash

#here is an if then statement to remind me that a fasta file has to be used
if [ $# != 1 ]
then
echo "use fasta file"
exit
fi


#here we will see if the fasta file is real  actually exists and if not were gonna say "mission fail, we'll get em next time" and abort
if [ -s $1 ]
then
echo "input file exists"
else
echo "mission fail, we'll get em next time"
exit
fi

#time to calculate the number of sequences in said fasta file
nseq=`grep ">" $1 | wc -l`
echo -e "\nThere are $nseq sequences in $1"


#here we will be creating an empty file with the header to this output file with 2 columns 
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
