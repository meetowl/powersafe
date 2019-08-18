[Marketing]
Do you have a 24/7 homebrew server?
Are you too cheap to buy a UPS with actual software?
Do you live in an area where powercuts are a usual occurence?
Do you hate your stuff getting corrupted?

Then I have quite the simple solution for you. 
This watches a network interface (that you set during installation) and 
sends the system to safely shutdown when it is down. This relies on your
network going down during a powercut, with more features coming when I 
need them.

[Installation]

Clone the repository with:
"$ git clone gitlab.com/meetowl/powersafe.git"

cd into the powersafe directory with:
"$ cd ./powersafe

Run the installer script (as root) with:
"# chmod u+x ./install.sh && ./install.sh"

This will ask you to set the network interface you want to watch, you can 
retrieve that list using:
"$ ip addr list"

Hit enter, and if that interface exists the installation is complete.
You can now enable "powersafe.timer" with:
"$ systemctl start powersafe.timer"
and this will periodically (every 15s) check the interface. 
The shutting down process takes about 2 minutes, so make sure your UPS can hold
at least that much.

If you want to for some reason incorporate this into your own script, 
"$ systemctl start powersafe.service" 
will start the script that checks the interface once and then quits.


