
scene=sky
width=1024
height=768

echo "scene, width, height, threads, samples, time (s)"

for threads in 1 2 4
do
    for samples in 1 2 4 8
    do
        output_file="${scene}_${width}_${height}_${threads}_${samples}.png"
        ex_time=$(./smallpt_thd -scene "${scene}" -width "${width}" -height "${height}" -threads "${threads}" -samples "${samples}" -output "${output_file}" 2> /dev/null |  awk  '$1 ~ /Execution/ { print substr($3, 1, length($3)-1)}')
        echo "${scene}, ${width}, ${height}, ${threads}, ${samples}, ${ex_time}"
    done
done

exit 0
