#!/bin/bash
var="00 1d 1e 2e 2f c7 c8 ee ef"

echo "badchars="$var
badchars="\x"${var:0:2}
badcharsbs="\\x"${var:0:2}
max=10
for ((i=0; i < $max; i++)); do
    strtmp=${var:3 + 6*i:2}
    if [ -z $strtmp ]; then break
    fi
    badchars+="\x"$strtmp
    badcharsbs+="\\x"$strtmp
    badchar[i]="\x"$strtmp
done
echo ""

echo "Immunity Command"
echo "!mona bytearray -b \"$badchars\""
echo ""

array=(0 1 2 3 4 5 6 7 8 9 a b c d e f)
testchar=""
for v in "${array[@]}"
do
    for w in "${array[@]}"
    do
        strtmp="\x$v$w"
        testchar+=$strtmp
    done
done
echo ${testchar:4}

for v in "${badchar[@]}"
do
        testchar=${testchar/"\\"$v}
done
echo ${testchar:4}
