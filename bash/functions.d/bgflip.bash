bgflip()
{
    case $solarized in
        dark)   solarized=light ;;
        light)  solarized=dark  ;;
        *)      solarized=dark ;;
    esac

    echo "# solarized=${solarized}"

    rl colours prompt
}
