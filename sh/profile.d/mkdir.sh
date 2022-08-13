mkdir()
{
  command mkdir -pv "$@"
  #              │└─ verbose
  #              └── create parents as required
}
