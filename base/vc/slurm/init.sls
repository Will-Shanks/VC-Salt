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

/tmp/x86_64:
  file.recurse:
    - source: salt://vc/slurm/x86_64

#rpm --install /tmp/x86_64/pmix*:
#  cmd.run

#rpm --install /tmp/x86_64/*:
#  cmd.run

/etc/slurm:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/var/lib/slurm:
  file.directory:
    - user: slurm
    - group: slurm
    - mode: 755

/etc/slurm/slurm.conf:
  file:
    - managed
    - source: salt://vc/slurm/slurm.conf
    - mode: 0644
    - owner: slurm
    - group: slurm

/var/log/slurm:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/lib/systemd/system/slurmdbd.service:
  file:
    - managed
    - source: salt://vc/slurm/slurmdbd.service
    - mode: 644
    - owner: root
    - group: root

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

/etc/slurm/cgroup.conf:
  file:
    - managed
    - source: salt://vc/slurm/cgroup.conf
    - mode: 640
    - owner: slurm
    - group: slurm


{% if grains['id'] == pillar['slurm_server'] %}

#slurmctld:
#  service.running:
#    - enable: True

/etc/slurm/slurmdbd.conf:
  file:
    - managed
    - source: salt://vc/slurm/slurmdbd.conf
    - mode: 644
    - owner: slurm
    - group: slurm

#slurmdbd:
#  service.running:
#    - enable: True

{% elif grains['id'][2].isdigit() %}

#slurmd:
#  service.running:
#    - enable: True
{% endif %}
