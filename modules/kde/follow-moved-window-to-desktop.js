const moveAndFollowShortcuts = [
    "Meta+!",
    "Meta+@",
    "Meta+#",
    "Meta+$",
    "Meta+%",
    "Meta+^",
    "Meta+&",
    "Meta+*",
    "Meta+(",
    "Meta+)",
];

function moveActiveWindowToDesktop(index) {
    const window = workspace.activeWindow;
    const targetDesktop = workspace.desktops[index - 1];

    if (!window || !targetDesktop) {
        return;
    }

    window.onAllDesktops = false;
    window.desktops = [targetDesktop];
    workspace.currentDesktop = targetDesktop;
}

for (let index = 1; index <= moveAndFollowShortcuts.length; index++) {
    registerShortcut(
        "Move Window to Desktop " + index + " and Follow",
        "Move Window to Desktop " + index + " and Follow",
        moveAndFollowShortcuts[index - 1],
        () => moveActiveWindowToDesktop(index)
    );
}
