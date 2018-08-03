include:
  - vc.nfs.client

munge:
  pkg.installed

munge-devel:
  pkg.installed

/etc/munge/munge.key:
  file:
    - managed
    - source: salt://vc/slurm/client/munge.key
    - mode: 0400
    - owner: munge

for i in '/run/munge' '/var/log/munge' '/var/lib/munge' '/etc/munge/munge.key' '/etc/munge'; do chown root:root "$i"; done:
  cmd.run

/usr/sbin/munged:
  cmd.run

/root/installSlurm.sh:
  file:
    - managed
    - source: salt://vc/slurm/client/installSlurm.sh
    - mode: 500
    - user: root
    - group: root

bash /root/installSlurm.sh:
  cmd.run

rm -f /root/installSlurm.sh:
  cmd.run

printf 'PATH="/opt/ompi/3.1.0/bin:/opt/slurm/17.11.5.1/sbin:/opt/slurm/17.11.5.1/bin:/opt/sbin:/opt/bin:/usr/sbin:/usr/bin:/root/bin"' > /etc/environment:
  cmd.run
