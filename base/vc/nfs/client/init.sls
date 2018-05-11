include:
  - vc.users
  - vc.pkgs

nfs-utils:
  pkg.installed

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
