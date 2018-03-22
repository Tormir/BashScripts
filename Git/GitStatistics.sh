#!/bin/bash  

#touch GitStatistics.csv 
#chmod 744 GitStatistics.csv 
#touch NamesOfCommiters.csv 
#chmod 744 NamesOfCommiters.csv 

echo "Platform of repo e.g. github.com, gitlab.com etc. For local instances IP of server e.g. 192.168.1.1"
read Platform

echo "Port that your app is running e.g. :7999 :8005, if you don't know leave empty"
read Port
 
echo "Time in months since you want to collect data e.g. 12"
read Time

while : 
 do 

        echo "Name of project" 
        read pathPro

        echo "Name of repository" 
        read path 

        git clone ssh://git@"$Platform""$Port"/"$pathPro"/"$path".git 

        cd $path 

        git log --since=""$Time" month ago" --format='%aN' | sort -u > NamesOfCommiters.csv 2> /dev/null 

        NumberOfCommiters=$(awk 'END {print NR}' NamesOfCommiters.csv) 

        for i in $(seq 1 $NumberOfCommiters) 
         do 

                Autor=$(awk -v x="$i" 'NR==x' NamesOfCommiters.csv) 
                NumberOfCommitsByCommiter=$(git shortlog --since="12 month ago" -s -n --author="$Autor" | awk '{print $1}') 

                git log --since="12 month ago" --shortstat --author="$Autor" | grep -E "fil(e|es) changed" | awk -v x="$Autor" -v y="$NumberOfCommitsByCommiter" -v z="$path" '{i+=$4; d+=$6} END {print y","i","d","x","z","}' >> GitStatistics.csv 2> /dev/null 

         done 
 cd ..
 find "$path"/* -type f \( ! -name GitStatistics.csv \) -exec rm {} \;
 echo "CO,IN,DL,user,repozytorium," >> "$path"/GitStatistics.csv 2> /dev/null
 echo "For 2 end, anything other continue"
 read WhileEnd 
 if [ $WhileEnd -eq 2 ] 
  then 
	exit 1; 
	fi
  done
