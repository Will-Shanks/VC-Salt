include:
  - vc.firewalld
  - vc.users
  - vc.pkgs

pkgs:
  pkg.installed:
    - pkgs:
      - nfs-utils

/home:
  mount.mounted:
    - device: vcnfs1:/home
    - mkmnt: True
    - fstype: nfs
/root:
  mount.mounted:
    - device: vcnfs1:/root
    - mkmnt: True
    - fstype: nfs
/usr/local:
  mount.mounted:
    - device: vcnfs1:/usr/local
    - mkmnt: True
    - fstype: nfs
