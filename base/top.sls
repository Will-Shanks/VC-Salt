base:
  '*':
#    - vc.firewalld
    - vc.pkgs
#    - vc.sshd
    - vc.users
  '{{ pillar["nfs_server"] }}':
    - vc.nfs.server
  '{{ pillar["slurm_server"] }}':
    - vc.slurm.server
  'vclogin*':
    - vc.slurm.client
  'vcsalt':
    - vc.nfs.client
  'vc[1-5]':
    - vc.slurm.compute
