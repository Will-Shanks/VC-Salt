include:
  - vc.slurm.client

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

/usr/lib/systemd/system/slurmctld.service:
  file:
    - managed
    - source: salt://vc/slurm/server/slurmctld.service
    - mode: 644
    - owner: root
    - group: root

/usr/lib/systemd/system/slurmdbd.service:
  file:
    - managed
    - source: salt://vc/slurm/server/slurmdbd.service
    - mode: 644
    - owner: root
    - group: root

/opt/slurm/17.11.5.1/etc/slurmdbd.conf:
  file:
    - managed
    - source: salt://vc/slurm/server/slurmdbd.conf
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
