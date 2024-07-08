#
#	This script profiles MPI code using VampirTrace
#
#	File dependence on 	:	makefile	(Instrumented according to VampirTrace)
#	Input				:	Dimesion of Input data,1 input file and 1 output file passed as command line arguments
#	Output 				:	Profiling_result[dataset-$2_m=$m_M=$M_EPS=$Epsilon_MINPOINTS=$MINPOINTS].txt
#
#	Author 				:	Saiyedul Islam
#		 					saiyedul.islam@gmail.com
#
#parameters for running code
path1=
# path1=../../../../Dataset_clustering/
m=$4
M=$5
Epsilon=$6
k=$7
MINPOINTS=2000
UNDEFINED=10000000
QT=$9

echo "=========================================="
echo "Following code was profiled on : `date`"
echo "Script for Profiling serial Code using Vampir"
echo "\nFiles given->\n\t$1\n\t$2"
echo "=========================================="
echo
echo "\tCompiling Code..."
make clean
make -f $3
if [ $? -eq 1 ] ;	then
	echo "\tError occured during compilation\nTerminating script\n"
	exit 1
else
	echo "\n\tCompilation done successfully.\n"
fi
#executable file name
exename=output
temp=./temp
rm -rf $temp
mkdir $temp

#export VT_ON=no
export VT_UNIFY=no
#export VT_MAX_FLUSHES=10
#export VT_BUFFER_SIZE=256M
export VT_MODE=STAT
export VT_PFORM_GDIR=$temp
export VT_PFORM_LDIR=$temp
export VT_FILE_PREFIX=$1_$2
nm output>output.nm
export VT_GNU_NMFILE=output.nm
echo "\t\tRunning Code..."

#sonal di, execute your program here
#$1 and $2 are the command line arguments 
#$1 is input file and $2 is output file to which the program output is to be written


#valgrind --tool=memcheck --leak-check=yes ./output $path1$1 output_$1\_EPS=$Epsilon\_MINPOINTS=$MINPOINTS.txt $m $M $Epsilon $MINPOINTS $UNDEFINED $k $path1$8 $QT

./output  $path1$1 output_$1\_EPS=$Epsilon\_MINPOINTS=$MINPOINTS.txt $m $M $Epsilon $MINPOINTS $UNDEFINED $k $path1$8 $QT
#gprof -z output > gprof_dataset-$2\_m=$m\_M=$M\_EPS=$Epsilon\_MINPOINTS=$MINPOINTS.txt 

if [ $? -ne 0 ] ;	then
	echo "\tError occured. Terminating script...\n"
	exit 1
fi

echo "Exeuction Done on : `date`"
#cd $temp
vtunify --stats $temp/$1_$2
#cd ..
cp $temp/$1_$2.prof.txt Profiling_result[dataset-$1\_$QT\_m=$m\_M=$M\_K=$k].txt

#rm -rf $temp

echo "Unification completed on : `date`"