
width=4096
height=2160

mkdir -p /tmp/images

echo "mutex, scene, width, height, threads, samples, divisions, time (s)"

#for mutex in def K n s asm_sleep def 
for mutex in asm def K n s
do
for scene in forest
do
    #for threads in 1 4 8 12 16 20 24 28 32 36 40 40 44 48 52 56 60 64 96 192 384 
    for threads in 8 48
    do
        for samples in 1 
        do
            for divisions in 384 
            do
                if [ ${divisions} -lt ${threads} ]
                then
                    continue
                fi
                output_file="/tmp/images/queue_mutex_${mutex}_${scene}_${width}_${height}_${threads}_${samples}_${divisions}.png"
                ex_time=$(./smallpt_queue_mutex_${mutex} -scene "${scene}" -width "${width}" -height "${height}" -threads "${threads}" -samples "${samples}" -divisions ${divisions} -output "${output_file}" 2> /dev/null |  awk  '$1 ~ /Execution/ { print substr($3, 1, length($3)-1)}')
                echo "${mutex}, ${scene}, ${width}, ${height}, ${threads}, ${samples}, ${divisions}, ${ex_time}"
            done
        done
    done
done # scene
done #mutex
exit 0
