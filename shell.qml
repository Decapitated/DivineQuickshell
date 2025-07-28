pragma ComponentBehavior: Bound
//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets

import QtQuick

import "core"
import "singletons"

ShellRoot {
    Scope {
        Variants {
            id: screenVariant
            model: Quickshell.screens
            Scope {
                id: screenScope
                required property ShellScreen modelData

                Taskbar {
                    id: taskbar
                    screen: screenScope.modelData
                }
                // Screen Corners
                ScreenCorners {}
            }
        }
    }
}