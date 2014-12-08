proxy()
{   # open an SSH tunnel for use as a SOCKS5 proxy

	ssh -fCqND 8080 "$@"
	#    ││││└─ dynamic port forwarding on 8080
	#    │││└── don't execute remote command (forward only)
	#    ││└─── quiet mode
	#    │└──── compress all data
	#    └───── go to background immediately
}
