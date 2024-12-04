# afconvert (macOS)

source (status dirname)/say.fish # for __fish_complete_pcm_formats

function __fish_complete_afconvert_dataformats
    set -l formats (afconvert -hf 2>&1 | string match -ar "'.{4}'(?! =)" | path sort -u)
    printf '%s\t\n' $formats
end

function __fish_complete_afconvert_fileformats
    afconvert -hf 2>&1 | string replace -rf "^\s+'(.{4})' = ([^(]+) \(.*" '$1\t$2'
end

function __fish_complete_afconvert_layouts
    # string match -r "(?<=\bkAudioChannelLayoutTag_)\w+" \
    #     </System/Library/Frameworks/CoreAudioTypes.framework/Headers/CoreAudioBaseTypes.h \
    #     | un1q
    set -l layouts \
        UseChannel{Descriptions,Bitmap} {,Logic_}{Mono,Stereo,Quadraphonic} \
        StereoHeadphones MatrixStereo MidSide XY Binaural Ambisonic_B_Format \
        {Pent,Hex,Oct}agonal Cube MPEG_{1,2}_0 MPEG_{3,4}_0_{A,B} \
        MPEG_5_{0,1}_{A,B,C,D} MPEG_6_1_A MPEG_7_1_{A,B,C} Emagic_Default_7_1 \
        SMPTE_DTV ITU_1_0 ITU_{2,3}_{0,1,2} ITU_3_{2,4}_1 ITU_5_1 DVD_(seq 0 \
        20) AudioUnit_{4,5,6,8} AudioUnit_{5,6,7}_{0,1} \
        AudioUnit_7_{0,1}_Front AAC_Quadraphonic AAC_Octagonal \
        AAC_{3,4,5,6,7}_0 AAC_{5,6,7}_{0,1} AAC_7_1_{B,C} TMH_10_2_{std,full} \
        AC3_1_0_1 AC3_2_1_1 AC3_3_{0,1}{,_1} EAC_{6,7}_0_A EAC3_6_1_{A,B,C} \
        EAC3_7_1_{A,B,C,D,E,F,G,H} DTS_{3,4}_1 DTS_6_{0,1}_{A,B,C} DTS_6_1_D \
        DTS_7_{0,1} DTS_8_{0,1}_{A,B} WAVE_{2,6,7}_1 WAVE_3_0 \
        WAVE_{4_0,5_0,5_1}_{A,B} HOA_ACN_{S,}N3D Atmos_{5,7}_1_{2,4} \
        Atmos_9_1_6 Logic_{4_0,6_0,7_1,7_1_SDDS}_{A,B,C} \
        Logic_{5_0,5_1,6_1}_{A,B,C,D} Logic_Atmos_{5,7}_1_{2,4} \
        Logic_Atmos_5_1_{2,4} Logic_Atmos_7_1_{2,4_A,4_B,6} DiscreteInOrder \
        CICP_(seq 20) {Begin,End}Reserved Unknown

    printf '%s\t\n' $layouts
end

set -l afconvert_channel_opts '
    -1\tsilent\ output
    0\t
    1\t
'

set -l afconvert_quality_opts '
    0\tlowest
    127\thighest
'

set -l afconvert_strategy_opts '
    0\tCBR
    1\tABR
    2\tVBR_constrained
    3\tVBR
'

set -l afconvert_media_opts '
    Audio Ad
    Video Ad
'

set -l afconvert_priming_opts '
    kConverterPrimeMethod_Pre\tPrime with leading + trailing input frames
    kConverterPrimeMethod_Normal\tOnly prime with trailing frames
    kConverterPrimeMethod_None\t"Latency mode"
'

# General options
complete -c afconvert -s d -l data -x -a "(__fish_complete_afconvert_dataformats; __fish_complete_pcm_formats)" -d "Specify data format"
complete -c afconvert -s c -l channels -x -d "Add/remove channels"
complete -c afconvert -s m -l channelmap -x -a "$afconvert_channel_opts" -d "Map input/output channels"
complete -c afconvert -s l -l channellayout -x -a "(__fish_complete_afconvert_layouts)" -d "Channel layout"
complete -c afconvert -s b -l bitrate -x -d "Total bit rate in bps"
complete -c afconvert -s q -l quality -x -a "$afconvert_quality_opts" -d "Codec quality"
complete -c afconvert -s r -l src-quality -x -a "$afconvert_quality_opts" -d "Converter quality"
complete -c afconvert -l src-complexity -x -a "line norm bats\ minp" -d "Converter complexity"
complete -c afconvert -s s -l strategy -x -a "$afconvert_strategy_opts" -d "Bitrate allocation strategy"
complete -c afconvert -l prime-method -x -a "$afconvert_priming_opts" -d "Decode priming method"
complete -c afconvert -l prime-override -x -d "Override packet table info"
complete -c afconvert -l no-filler -d "Don't page-align audio data"
complete -c afconvert -l soundcheck-generate -d "Add SoundCheck data to output file"
complete -c afconvert -l media-kind -x -a "$afconvert_media_opts"
complete -c afconvert -l anchor-loudness -x -d "Anchor loudness in dB"
complete -c afconvert -l anchor-generate -d "Add dialogue anchor level data to output file"
complete -c afconvert -l generate-hash -d "Add a hash of the input data to the output file"
complete -c afconvert -l codec-manuf -x -d "Component manufacturer code"
complete -c afconvert -l dither -x -a "1 2" -d "Dither algorithm"
complete -c afconvert -l mix -d "Enable channel downmixing"
complete -c afconvert -s u -l userproperty -x -d "Set an AudioConverter property"
complete -c afconvert -o ud -x -d "Set AudioConverter property for decoder"
complete -c afconvert -o ue -x -d "Set AudioConverter property for encoder"

# Input file options
complete -c afconvert -l decode-formatid -x -a "(__fish_complete_afconvert_dataformats)" -d "Specify layer to decode"
complete -c afconvert -l read-track -x -d "Specify track index"
complete -c afconvert -l offset -x -d "Starting offset in frames"
complete -c afconvert -l soundcheck-read -d "Transfer SoundCheck data to output file"
complete -c afconvert -l copy-hash -d "Transfer SHA-1 hash to output file"
complete -c afconvert -l check-hash -d "Check against embedded hash"
complete -c afconvert -l gapless-before -rF -d "Previous file on gapless album"
complete -c afconvert -l gapless-after -rF -d "Next file on gapless album"

# Output file options
complete -c afconvert -s o -d "Output file"
complete -c afconvert -s f -l file -x -a "(__fish_complete_afconvert_fileformats)" -d "File format"
complete -c afconvert -l condensed-framing -x -a 16 -d "Externally framed packet size in bits"

# Other options
complete -c afconvert -s v -l verbose -d "Print progress verbosely"
complete -c afconvert -s t -l tag -d "Store or use data in user chunks"
complete -c afconvert -l leaks -d "Run leaks at the end of the conversion"
complete -c afconvert -l profile -d "Print performance information"

# Help options
complete -c afconvert -o hf -l help-formats -f -d "Print supported formats"
complete -c afconvert -s h -l help -f -d "Print help"
