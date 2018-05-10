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

/lib/systemd/system/slurmd.service:
  file:
    - managed
    - source: salt://vc/slurm/compute/slurmd.service
    - mode: 644
    - owner: root
    - group: root

systemctl daemon-reload:
  cmd.run

slurmd:
  service.running:
    - enable: True
    - reload: True
