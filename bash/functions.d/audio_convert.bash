_inPath afconvert || return

audio_convert()
{
  local in_file="$1"
  local out_file="$2"
  local f

  case $out_file in
    *.3gp)        f="3gpp" ;;
    *.3g2)        f="3gp2" ;;
    *.aac|*.adts) f="adts" ;;
    *.ac3)        f="ac-3" ;;
    *.aifc)       f="AIFC" ;;
    *.aiff|*.aif) f="AIFF" ;;
    *.amr)        f="amrf" ;;
    *.m4a|*.m4r)  f="m4af" ;;
    *.m4b)        f="m4bf" ;;
    *.caf)        f="caff" ;;
    *.ec3)        f="ec-3" ;;
    *.flac)       f="flac" ;;
    *.mp1)        f="MPG1" ;;
    *.mp2)        f="MPG2" ;;
    *.mp3|*.mpeg) f="MPG3" ;;
    *.mp4)        f="mp4f" ;;
    *.snd|*.au)   f="NeXT" ;;
    *.sd2)        f="Sd2f" ;;
    *.wav)        f="WAVE" ;;
    *)
      scold "Unknown output type: .${out_file##*.}"
      return 1 ;;
  esac

  afconvert "$in_file" "$out_file" -f "$f"
}
