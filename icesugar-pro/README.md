## How to Test
```
$make TOP=hello
$icesprog bin/toplevel.bit or cp bin/toplevel.bit /path/to/iCELink
$picocom -b 115200 /dev/ttyACM0
```
