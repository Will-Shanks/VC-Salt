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

perl-Data-Dumper:
  pkg.installed

autoconf:
  pkg.installed

automake:
  pkg.installed

libtool:
  pkg.installed

mariadb:
  pkg.installed

mariadb-devel:
  pkg.installed

libevent-devel:
  pkg.installed

flex:
  pkg.installed

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

/opt/slurm/17.11.5.1/etc:
  file.directory:
    - user: slurm
    - group: slurm
    - mode: 755

/opt/slurm/17.11.5.1/etc/slurm.conf:
  file:
    - managed
    - source: salt://vc/slurm/client/slurm.conf
    - mode: 0644
    - owner: slurm
    - group: slurm


/opt/slurm/17.11.5.1/etc/cgroup.conf:
  file:
    - managed
    - source: salt://vc/slurm/client/cgroup.conf
    - mode: 640
    - owner: slurm
    - group: slurm

printf 'PATH="/opt/ompi/3.1.0/bin:/opt/slurm/17.11.5.1/sbin:/opt/slurm/17.11.5.1/bin:/opt/sbin:/opt/bin:/usr/sbin:/usr/bin:/root/bin"' > /etc/environment:
  cmd.run
