proc run {} {

    if ($hello) {
        do_something
    } else {
        if ($hello) {
            do_something
        }
        run_cmd ${var}s
        do_something \
            witharg 1 \
            witharg 2 \
            witharg 3 \
            witharg 4 \
            witharg 5
        if (hello) {
            hhdhd .*fdewfew.*
        } elseif {
            dwqdqwdq
        } else {
            dwqdqwdq
        }

        add {"some string"}

        hello [
            dwqdqwdq
            dqwdqwd
        ]

        cmd \
            "string" \
            "string"

        set some_list "
            hello
            hi
        "
    }
}

namespace eval nms {

}
# vim: set sw=4 :
