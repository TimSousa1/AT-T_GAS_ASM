# print every command to stdout 
set -x

if [ "$1" = "clean" ]; then
    # cleaning
    rm *.o *.out
elif [[ "$1" =~ ".s" ]]; then
    # output names
    obj=${1/.s/.o}
    out=${1/.s/.out}
    # building
    as $1   -o $obj
    ld $obj -o $out

elif [[ "$1" =~ ".c" ]]; then
    obj=${1/.c/.o}
    out=${1/.c/.out}

    gcc -c    $1 -o $obj
    gcc     $obj -o $out
    objdump $out --disassemble=main
fi

