#!/usr/bin/env python3
import time
import i3ipc

def on_window_focus(i3, e):
    focused = i3.get_tree().find_focused()
    if not focused or not focused.parent or focused.parent.layout not in ("splith", "splitv"):
        return

    layout = "splitv" if focused.rect.width < focused.rect.height else "splith"
    i3.command(layout)

def main():
    while True:
        try:
            i3 = i3ipc.Connection()
            i3.on("window::focus", on_window_focus)
            i3.main()
        except Exception:
            time.sleep(1)

if __name__ == "__main__":
    main()
