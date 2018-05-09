include:
  - vc.slurm.client

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

if [ ! -d "/usr/local/pmix/2.1.1/" ]; then wget https://github.com/pmix/pmix/archive/v2.1.1.tar.gz && tar -xzvf v2.1.1.tar.gz && cd pmix-2.1.1 && ./autogen.sh && ./configure --prefix=/usr/local/pmix/2.1.1/ && make -j40 all && make -j40 install; fi:
  cmd.run

if [ ! -d "/usr/local/slurm/17.11.5.1/" ]; then wget https://github.com/SchedMD/slurm/archive/slurm-17-11-5-1.tar.gz && tar -xzvf slurm-17-11-5-1.tar.gz && cd slurm-slurm-17-11-5-1 && ./configure --prefix=/usr/local/slurm/17.11.5.1/ --with-pmix=/usr/local/pmix/2.1.1/ && make -j40 all && make -j40 install; fi:
  cmd.run

if [ ! -d "/usr/local/ompi/3.1.0/" ]; then wget https://github.com/open-mpi/ompi/archive/v3.1.0.tar.gz && tar -xzvf v3.1.0.tar.gz && cd ompi-3.1.0 && ./autogen.pl && ./configure --prefix=/usr/local/ompi/3.1.0/ --with-libevent=/usr --with-pmix=/usr/local/pmix/2.1.1/ --with-slurm && make -j40 all && make -j40 install; fi:
  cmd.run

/usr/local/slurm/17.11.5.1/etc:
  file.directory:
    - user: slurm
    - group: slurm
    - mode: 755

/usr/local/slurm/17.11.5.1/etc/slurm.conf:
  file:
    - managed
    - source: salt://vc/slurm/server/slurm.conf
    - mode: 0644
    - owner: slurm
    - group: slurm


/usr/local/slurm/17.11.5.1/etc/cgroup.conf:
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

#/lib/systemd/system/slurmdbd.service:
#  file:
#    - managed
#    - source: salt://vc/slurm/server/slurmdbd.service
#    - mode: 644
#    - owner: root
#    - group: root

#/usr/local/etc/slurm/slurmdbd.conf:
#  file:
#    - managed
#    - source: salt://vc/slurm/slurmdbd.conf
#    - mode: 644
#    - owner: slurm
#    - group: slurm

systemctl daemon-reload:
  cmd.run

slurmctld:
  service.running:
    - enable: True
    - reload: True

#slurmdbd:
#  service.running:
#    - enable: True
#    - reload: True
