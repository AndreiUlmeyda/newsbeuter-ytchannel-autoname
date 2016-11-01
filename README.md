# newsbeuter-ytchannel-autoname

AWK! HUUH! Whaat is it goood for? Absolutely noth...oh wait.

## Why would I want it?
If you imported a number of youtube channel subscriptions into [newsbeuter](http://newsbeuter.org) and are too lazy or too busy to give them proper names by editing the urls file, then this script may save you a few minutes of your precious time.
## What is it doing?
It fetches the html documents corresponding to youtube feeds in your urls file, extracts what is, hopefully, the channels name and then appends that name to the respective line.
## System requirements/Dependencies
Your command line should respond kindly to the commands "grep", "awk", and "http" and be able to put whatever comes out of the script into a file.

Which means that if you are running any of the 4*10¹⁷ most popular Linux distributions and have [httpie](https://httpie.org) installed, through an official repository or manually, you should be good to go.
## Usage
Back up your urls file, for instance by doing
```
cd ~/.newsbeuter; # this and subsequent paths might need to be changed corresponding to the location of your newsbeuter config directory
mv urls urls-bak;
```

Make the script executable and invoke it with your backup as input while also redirecting its output into what becomes your new urls file
```
  cd <path-to-this-repository>
  chmod +x newsbeuter-ytchannel-autoname.awk
  ./newsbeuter-ytchannel-autoname.awk ~/.newsbeuter/urls-bak > ~/.newsbeuter/urls
```
Hint: If you leave out the redirection `> ~/.newsbeuter/urls` you can preview a dry run live on your command line. Also, doing a
```
cd ~/.newsbeuter
diff urls urls-bak
```
before deleting the backup might help verifying that nothing horrible happened since the script does not handle piping errors...or any errors, really.

Give the script a few seconds time since the http requests happen sequentially to keep it short and simple.

Enjoy
