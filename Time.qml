pragma Singleton

import Quickshell

Singleton {
    id: root
    // an expression can be broken across multiple lines using {}
    readonly property string date: {
        // The passed format string matches the default output of
        // the `date` command.
        Qt.formatDateTime(clock.date, "ddd, MMM dd, yyyy")
    }

    readonly property string time: {
        // The passed format string matches the default output of
        // the `date` command.
        Qt.formatDateTime(clock.date, "h:mm:ss AP")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}