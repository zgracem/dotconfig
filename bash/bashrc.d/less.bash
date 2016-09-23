# -----------------------------------------------------------------------------
# colourize man pages in less
# -----------------------------------------------------------------------------

# begin/end "bold" mode -- used for man page headers
LESS_TERMCAP_md=${esc_green}
LESS_TERMCAP_me=${esc_reset}

# begin/end "underline" mode -- used to highlight variables
LESS_TERMCAP_us=${esc_yellow}         
LESS_TERMCAP_ue=${esc_reset}          

# reset everything
LESS_TERMEND=${esc_reset}

export ${!LESS_TERM*}
