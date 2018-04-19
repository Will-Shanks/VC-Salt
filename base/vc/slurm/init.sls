include:
  - vc.nfs

munge:
  pkg.installed:
    - pkgs:
      - munge

/etc/munge/munge.key:
  file:
    - managed
    - source: salt://vc/slurm/munge.key
    - mode: 0400
    - owner: munge
    - require:
      - pkg: munge

/usr/sbin/munged --force:
  cmd.run
