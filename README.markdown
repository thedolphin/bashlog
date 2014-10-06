This is log processing full of bachism
Useful for automating, cron jobs etc
Took hours of my life away

Just look. This script

```bash
#!/bin/sh

. ./bashlog.sh

# Open log
createlog "./bashlog.test.log"

# This will put stdout to pretty log
runcommand ls ||
    fail "will never fail"

# This will stderr to pretty log
runcommand grep grep grep ||
    echo "grep grep grep failed, your K.O."

# Catch stdout and return code, send stderr to pretty log
filelist=$(evalcommand ls /whereismycat) ||
    echo "cat not found"

# Catch stdout, fail in case of something strange
filelist=$(evalcommand ls) ||
    fail "Ooops, is your system alive?"

echo $filelist

# Exit
ok
```

Will generate this log:


```
[2014-10-06 16:49:06] ++ ls
[2014-10-06 16:49:06] bashlog.sh
[2014-10-06 16:49:06] bashlog.test.log
[2014-10-06 16:49:06] bashlog.test.sh
[2014-10-06 16:49:06] ++ grep grep grep
[2014-10-06 16:49:06] grep: grep: No such file or directory
[2014-10-06 16:49:06] +++ ls /whereismycat
[2014-10-06 16:49:06] ls: /whereismycat: No such file or directory
[2014-10-06 16:49:06] +++ ls
[2014-10-06 16:49:06] Done
```

Like it? Use it!

Ok, it's public domain code.
