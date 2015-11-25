#!/bin/sh

# errors shouldn't cause script to exit
set +e

ln -f -s "/Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/bin/shiny-server" /usr/bin/shiny-server
# See if "shiny" user exists
if id -u shiny >/dev/null 2>&1;
then
   echo User "shiny" already exists. Ensuring proper permissions on /home/shiny/.
   mkdir -p /home/shiny
   chown shiny:shiny /home/shiny
else
   echo Creating group "shiny"
   groupadd shiny

   echo Creating user "shiny"
   useradd -r -m shiny -g shiny -s /bin/sh
fi

if [ ! -d "/srv/shiny-server" ];
then
   mkdir -p /srv/shiny-server
   # And seed with initial apps and index.html
   ln -s /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/samples/welcome.html /srv/shiny-server/index.html
   ln -s /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/samples/sample-apps /srv/shiny-server/sample-apps
fi

mkdir -p /etc/shiny-server
if [ ! -f "/etc/shiny-server/shiny-server.conf" ];
then
   cp /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/config/default.config /etc/shiny-server/shiny-server.conf
fi

mkdir -p /var/log/shiny-server

# Place the logrotate script, if applicable
if test -d /etc/logrotate.d
then
   cp /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/config/logrotate /etc/logrotate.d/shiny-server
fi

# Log dir must be writable by "shiny" user
chown shiny:shiny /var/log/shiny-server

RH_VER=""
if test -e /etc/redhat-release
then
  RH_VER=`sed -nr "s/.*release\\ ([0-9]).*/\\1/p" /etc/redhat-release`
fi

# add upstart profile, or init.d/systemd script and start the server
if test -d /etc/init/
then
   # remove any previously existing init.d based scheme
   service shiny-server stop 2>/dev/null
   rm -f /etc/init.d/shiny-server

   cp /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/config/upstart/shiny-server.conf /etc/init/
   initctl reload-configuration
   initctl stop shiny-server 2>/dev/null
   sleep 1
   initctl start shiny-server
elif [ "$RH_VER" == "7" ]
then
   cp /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/config/systemd/shiny-server.service /etc/systemd/system/
   systemctl enable shiny-server
   systemctl restart shiny-server
else
   if test -e /etc/SuSE-release
   then
      cp /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/config/init.d/suse/shiny-server /etc/init.d/
   else
      cp /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/config/init.d/redhat/shiny-server /etc/init.d/
   fi

   chmod +x /etc/init.d/shiny-server
   chkconfig --add shiny-server
   service shiny-server stop 2>/dev/null
   sleep 1
   service shiny-server start
fi

if [ -e /etc/SuSE-release ] || [ "$RH_VER" == "7" ]  || [ "$RH_VER" == "6" ]
then
   # The default Pandoc binaries aren't compatible, overwrite with the static versions.
   cp -f /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/ext/pandoc/static/pandoc /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/ext/pandoc/pandoc
   cp -f /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/ext/pandoc/static/pandoc-citeproc /Users/lukas/Downloads/shiny-server-master/tmp/shiny-server/ext/pandoc/pandoc-citeproc
fi

# clear error termination state
set -e
