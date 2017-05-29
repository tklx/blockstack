fatal() { echo "fatal [$(basename $BATS_TEST_FILENAME)]: $@" 1>&2; exit 1; }

_in_cache() {
    IFS=":"; img=($1); unset IFS
    [[ ${#img[@]} -eq 1 ]] && img=("${img[@]}" "latest")
    [ "$(docker images ${img[0]} | grep ${img[1]} | wc -l)" = "1" ] || return 1
}

[ "$IMAGE" ] || fatal "IMAGE envvar not set"
_in_cache $IMAGE || fatal "$IMAGE not in cache"

@test "dummy" {
    true
}

