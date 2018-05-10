include:
  - vc.nfs.client

pkgs:
  pkg.installed:
    - pkgs:
      - munge
      - munge-devel

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

printf 'PATH="/usr/local/ompi/3.1.0/bin:/usr/local/slurm/17.11.5.1/sbin:/usr/local/slurm/17.11.5.1/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin"' > /etc/environment:
  cmd.run
