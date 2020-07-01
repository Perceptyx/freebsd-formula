$network_provisioning = <<SCRIPT
env PAGER=cat
export PAGER=cat
ASSUME_ALWAYS_YES=YES
export ASSUME_ALWAYS_YES
env ASSUME_ALWAYS_YES=YES

sed -i '' -e '/^#VAGRANT-BEGIN/,/^#VAGRANT-END/ d' /etc/rc.conf || {
  echo "Fail while removing VAGRANT entries in /etc/rc.conf"
  exit 1
}

sed -i '' -e '/^ifconfig_vtnet/d' /etc/rc.conf || {
  echo "Fail while removing ifconfig_vtnet entries from /etc/rc.conf"
  exit 1
}

sed -i '' -e '/^ifconfig_em/d' /etc/rc.conf || {
  echo "Fail while removing ifconfig_em entries from /etc/rc.conf"
  exit 1
}

if ! [ -f /etc/firstboot ]; then
  touch /etc/firstboot

  ifconfig -a
  netstat -nr

  ifconfig em0
  if [ $? -eq 0 ]; then
    INTERFACE="em0"
    DNS="1.1.1.1"
  else
    INTERFACE="vtnet0"
    DNS="192.168.121.1"
  fi

  IP=$(ifconfig ${INTERFACE} inet | awk '/inet /{print $2}' | tr -d '\n')
  NETMASK=$(ifconfig ${INTERFACE} inet | awk '/inet /{print $4}' | sed 's/^0x//g' | perl -pe '$_ = join(".", map(hex, /.{2}/g))')
  GATEWAY=$(netstat -nr | grep '^default' | awk '{print $2}' | tr -d '\n')

  cat /etc/resolv.conf
  echo "nameserver ${DNS}" > /etc/resolv.conf
  echo "name_servers=\"${DNS}\"" > /etc/resolvconf.conf
  resolvconf -u
  cat /etc/resolv.conf

  host google.com

  echo ${IP}
  echo ${NETMASK}
  echo ${GATEWAY}

  sysrc ifconfig_vtnet0_name="em0"
  sysrc ifconfig_em0="inet ${IP} netmask ${NETMASK}"
  sysrc defaultrouter="${GATEWAY}"
  sysrc ifconfig_vtnet1_name="em1"
  sysrc ifconfig_vtnet2_name="em2"
  sysrc ifconfig_vtnet3_name="em3"

  reboot
fi

SCRIPT

Vagrant.configure(2) do |config|
  config.vm.provision "shell", inline: $network_provisioning
end

