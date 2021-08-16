percent=$(sudo tlp-stat -b | grep total | awk -F' ' '{print $5}' | awk -F'.' '{print $1}')

# Both long and short
echo $percent
echo $percent

if [ $percent -gt 66 ]
then
	echo "#9FD84F"
fi


if [ $percent -lt 33 ]
then
	echo "#FF5522"
fi

echo "#E6E854"

