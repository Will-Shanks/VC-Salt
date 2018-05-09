base:
  '*':
    - vc.firewalld
    - vc.pkgs
    - vc.sshd
    - vc.users
  '{{ pillar['nfs_server'] }}':
    - vc.nfs.server
  '{{ pillar['slurm_server'] }}':
    - vc.slurm.server
  'vc[1-5]':
    - vc.nfs.client
    - vc.slurm.compute
  'vclogin*':
    - vc.nfs.client
    - vc.slurm.login
