base:
  '*':
    - vc.pkgs
    - vc.sshd
    - vc.users
  '{{ pillar['nfs_server'] }}':
    - vc.nfs
  'vc*':
    - vc.nfs
    
