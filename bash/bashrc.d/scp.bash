scp()
{
    ### ZGM disabled 2016-02-23 -- ironically, slows things down considerably??
    # command scp -Cpr "$@"
    command scp  -rp "$@"
    #            ││└─ preserve times/modes
    #            │└── recursive
    #            └─── compress
}
