#!/bin/sh

# Sets the date taken EXIF on jpeg files
# according to the name of the directory
# in this format "99.12.31"

set -e
total=0
for j in [0-9]*.[0-9][0-9].[0-9][0-9]
do
    cd $j
    # echo $PWD
    a=$(basename "$PWD")
    # echo $a

    YEAR="19"$(echo $a|cut -d. -f1)
    MONTH=$(echo $a|cut -d. -f2)
    DAY=$(echo $a|cut -d. -f3)
    # echo "$a -> $YEAR $MONTH $DAY "
    echo -n "$a "

    count=0
    for extension in jpg jpeg JPG JPEG
    do
        if [ $(ls *.$extension 2>/dev/null | wc -l) -gt 0 ]
        then
            HOURS=12
            MINUTES=0
            for i in *.$extension
            do
                count=$(expr $count + 1)
                if [ $MINUTES -ge 60 ]
                then
                    MINUTES=0
                    HOURS=$(expr $HOURS + 1)
                fi
                minutes=$MINUTES
                if [ $minutes -lt 10 ]
                then
                    minutes="0"$minutes
                fi
                exiftool \
                    -overwrite_original \
                    -quiet \
                    -DateTimeOriginal="$YEAR:$MONTH:$DAY $HOURS:$minutes:00" \
                    $i
                MINUTES=$(expr $MINUTES + 1)
            done
        fi
    done
    if [ $count -lt 10 ]
    then
        count=" "$count
    fi
    echo "$count updated"
    total=$(expr $total + $count)


    cd ..
done
echo "Total $total"
