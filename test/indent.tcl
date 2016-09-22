proc run {} {
    if ($hello) {
        do_something
    } else {
        if ($hello) {
            do_something
        }
        do_something \
        witharg 1 \
        witharg 2 \
        witharg 3 \
        witharg 4 \
        witharg 5
        if (hello) {
            hhdhd
        } else {
        }
    }
}
# vim: set sw=4 :
