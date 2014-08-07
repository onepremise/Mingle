array_contains () { 
    local array="$1[@]"
    local seeking=$2
    local e
    local in=1
    
    IFS=' '
    
    for e in ${!array}; do
        if [[ $e == $seeking ]]; then
            in=0
            break
        fi
    done
    return $in
}