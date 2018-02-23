#!/bin/bash
source="--source https://api.nuget.org/v3/index.json --no-cache"
#cd ../Warsztaty

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR
var=$(git rev-parse --show-toplevel 2>&1)
echo $var

projects=(/src/Gabor/Gabor.csproj)
for project in ${projects[*]}
do
	echo ========================================================
	echo Building project: $project
	echo ========================================================
	p1=$var$project
	echo $p1
	#dotnet build $project/$project.csproj
done


sample='[{"name":"project1"},{"name":"project2"}]'  
for row in $(echo "${sample}" | jq -r '.[] | @base64'); do  
    _jq() {
     echo ${row} | base64 --decode | jq -r ${1}
    }

   echo $(_jq '.name')
done  