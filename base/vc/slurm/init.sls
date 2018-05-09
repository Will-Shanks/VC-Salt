include:
  - vc.nfs

/etc/munge/munge.key:
  file:
    - managed
    - source: salt://vc/slurm/munge.key
    - mode: 0400
    - owner: munge

for i in '/run/munge' '/var/log/munge' '/var/lib/munge' '/etc/munge/munge.key' '/etc/munge'; do chown root:root "$i"; done:
  cmd.run

/usr/sbin/munged:
  cmd.run

#/tmp/x86_64:
#  file.recurse:
#    - source: salt://vc/slurm/x86_64

#rpm --install /tmp/x86_64/pmix*:
#  cmd.run

#rpm --install /tmp/x86_64/*:
#  cmd.run

/var/lib/slurm:
  file.directory:
    - user: slurm
    - group: slurm
    - mode: 755

/var/log/slurm:
  file.directory:
    - user: root
    - group: root
    - mode: 755

#/lib/systemd/system/slurmdbd.service:
#  file:
#    - managed
#    - source: salt://vc/slurm/slurmdbd.service
#    - mode: 644
#    - owner: root
#    - group: root

/lib/systemd/system/slurmctld.service:
  file:
    - managed
    - source: salt://vc/slurm/slurmctld.service
    - mode: 644
    - owner: root
    - group: root

/lib/systemd/system/slurmd.service:
  file:
    - managed
    - source: salt://vc/slurm/slurmd.service
    - mode: 644
    - owner: root
    - group: root

mycommand:
  cmd.run:
    - name: ls -l /
    - env:
      - PATH: {{ ['/usr/local/ompi/3.1.0/bin:/usr/local/slurm/17.11.5.1/sbin:/usr/local/slurm/17.11.5.1/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin'] }}

{% if grains['id'] == pillar['slurm_server'] %}

#if [ ! -d "/usr/local/pmix/2.1.1/" ]; then wget https://github.com/pmix/pmix/archive/v2.1.1.tar.gz && tar -xzvf v2.1.1.tar.gz && cd pmix-2.1.1 && ./autogen.sh && ./configure --prefix=/usr/local/pmix/2.1.1/ && make -j40 all && make -j40 install; fi:
#  cmd.run

#if [ ! -d "/usr/local/slurm/17.11.5.1/" ]; then wget https://github.com/SchedMD/slurm/archive/slurm-17-11-5-1.tar.gz && tar -xzvf slurm-17-11-5-1.tar.gz && cd slurm-slurm-17-11-5-1 && ./configure --prefix=/usr/local/slurm/17.11.5.1/ --with-pmix=/usr/local/pmix/2.1.1/ && make -j40 all && make -j40 install; fi:
#  cmd.run

#if [ ! -d "/usr/local/ompi/3.1.0/" ]; then wget https://github.com/open-mpi/ompi/archive/v3.1.0.tar.gz && tar -xzvf v3.1.0.tar.gz && cd ompi-3.1.0 && ./autogen.pl && ./configure --prefix=/usr/local/ompi/3.1.0/ --with-libevent=/usr --with-pmix=/usr/local/pmix/2.1.1/ --with-slurm && make -j40 all && make -j40 install; fi:
#  cmd.run

/usr/local/slurm/17.11.5.1/etc:
  file.directory:
    - user: slurm
    - group: slurm
    - mode: 755

/usr/local/slurm/17.11.5.1/etc/slurm.conf:
  file:
    - managed
    - source: salt://vc/slurm/slurm.conf
    - mode: 0644
    - owner: slurm
    - group: slurm


/usr/local/slurm/17.11.5.1/etc/cgroup.conf:
  file:
    - managed
    - source: salt://vc/slurm/cgroup.conf
    - mode: 640
    - owner: slurm
    - group: slurm

systemctl daemon-reload:
  cmd.run

slurmctld:
  service.running:
    - enable: True

#/usr/local/etc/slurm/slurmdbd.conf:
#  file:
#    - managed
#    - source: salt://vc/slurm/slurmdbd.conf
#    - mode: 644
#    - owner: slurm
#    - group: slurm

#systemctl daemon-reload:
#  cmd.run

#slurmdbd:
#  service.running:
#    - enable: True

{% elif grains['id'][2].isdigit() %}

systemctl daemon-reload:
  cmd.run

slurmd:
  service.running:
    - enable: True
{% endif %}
