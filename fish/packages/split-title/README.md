# split-title

The default implementation of `fish_title` writes simultaneously to both the
terminal "window" and "icon" titles. In my opinion, if the terminal emulator
makes a distinction between them, it's a distinction worth keeping, hence my
reimplementation.

## Usage

Define `fish_window_title` and `fish_tab_title` functions, the output of which
will appear in the terminal window/tab title, respectively, each time the prompt
is displayed.
