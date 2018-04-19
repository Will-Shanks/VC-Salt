base:
  '{{ pillar['nfs_server'] }}':
    - vc.nfs
#  '{{ pillar['slurm_server'] }}':
#    - vc.slurm
  '*':
    - vc.firewalld
    - vc.pkgs
    - vc.sshd
    - vc.users
    - vc.nfs
#    - vc.slurm
