include:
  - vc.slurm.client

mariadb:
  pkg.installed

mariadb-devel:
  pkg.installed

perl-Data-Dumper:
  pkg.installed

autoconf:
  pkg.installed

automake:
  pkg.installed

libtool:
  pkg.installed

libevent-devel:
  pkg.installed

flex:
  pkg.installed

/var/lib/slurm:
  file.directory:
    - user: slurm
    - group: slurm
    - mode: 755

/var/log/slurm:
  file.directory:
    - user: slurm
    - group: slurm
    - mode: 755

/root/installSlurm.sh:
  file:
    - managed
    - source: salt://vc/slurm/server/installSlurm.sh
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
    - source: salt://vc/slurm/server/slurm.conf
    - mode: 0644
    - owner: slurm
    - group: slurm


/opt/slurm/17.11.5.1/etc/cgroup.conf:
  file:
    - managed
    - source: salt://vc/slurm/server/cgroup.conf
    - mode: 640
    - owner: slurm
    - group: slurm

/lib/systemd/system/slurmctld.service:
  file:
    - managed
    - source: salt://vc/slurm/server/slurmctld.service
    - mode: 644
    - owner: root
    - group: root

/lib/systemd/system/slurmdbd.service:
  file:
    - managed
    - source: salt://vc/slurm/server/slurmdbd.service
    - mode: 644
    - owner: root
    - group: root

/opt/slurm/17.11.5.1/etc/slurmdbd.conf:
  file:
    - managed
    - source: salt://vc/slurm/slurmdbd.conf
    - mode: 644
    - owner: slurm
    - group: slurm

systemctl daemon-reload:
  cmd.run

slurmctld:
  service.running:
    - enable: True
    - reload: True

slurmdbd:
  service.running:
    - enable: True
    - reload: True
