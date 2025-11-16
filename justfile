# use cmd.exe instead of sh:
set shell := ["cmd.exe", "/c"]

add-version PORT:
  python scripts/add_version.py {{PORT}}