This is log processing full of bachisms. Useful for automating, cron jobs etc. Took hours of my life away.

Just look. This script:

```bash
#!/bin/sh

. ./bashlog.sh

# Open log
createlog "./bashlog.test.log"

# This will put stdout to pretty log
runcommand ls ||
    fail "will never fail"

# This will send stdout and stderr to pretty log
runcommand grep grep grep ||
    echo "grep grep grep failed, your K.O."

# Multiline output from other sources we'll put to log, line by line
fortune | logwrapper

# Ok, just say something
log "Nobody will ever look for logs"

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

Will generate this output...

```
grep grep grep failed, your K.O.
cat not found
README.markdown bashlog.sh bashlog.test.log bashlog.test.sh

```

...and this log...


```
[2014-10-06 17:31:04] ++ ls
[2014-10-06 17:31:04] README.markdown
[2014-10-06 17:31:04] bashlog.sh
[2014-10-06 17:31:04] bashlog.test.log
[2014-10-06 17:31:04] bashlog.test.sh
[2014-10-06 17:31:04] ++ grep grep grep
[2014-10-06 17:31:04] grep: grep: No such file or directory
[2014-10-06 17:31:04] +++ ls /whereismycat
[2014-10-06 17:31:04] ls: /whereismycat: No such file or directory
[2014-10-06 17:31:04] If we can ever make red tape nutritional, we can feed the world.
[2014-10-06 17:31:04] -- R. Schaeberle, "Management Accounting"
[2014-10-06 17:31:04] Nobody will ever look for logs
[2014-10-06 17:31:04] +++ ls
[2014-10-06 17:31:04] Done

```

Like it? Use it!

Ok, it's public domain code.
