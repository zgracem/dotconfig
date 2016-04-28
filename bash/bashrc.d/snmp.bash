# SNMP access

if [[ $OSTYPE =~ darwin ]]; then
  SNMP_HOST="Oracle.local"
  SNMP_MIB="AIRPORT-BASESTATION-3-MIB"
  SNMP_COMMUNITY="sibyl"
  export ${!SNMP_*}
else
	return 0
fi

airportusers()
{ # return number of users connected to AirPort base station

  # -Ovq suppresses the equal sign, type info, and OID
  snmpget -v 2c -c "$SNMP_COMMUNITY" -Oqv "$SNMP_HOST" \
    "$SNMP_MIB::wirelessNumber.0"
}
