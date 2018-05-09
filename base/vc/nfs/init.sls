include:
  - vc.firewalld
  - vc.users
  - vc.pkgs

{% if grains['id'] == pillar['nfs_server'] %}
rpcbind:  
  service.running:
    - enable: True
    - reload: True
nfs-lock:
  service.running:
    - enable: True
    - reload: True
nfs-idmap:
  service.running:
    - enable: True
    - reload: True
/etc/exports:
  file.managed:
    - contents:
      - /root       "*"(rw,sync,no_root_squash,no_all_squash)
      - /home       "*"(rw,sync,no_root_squash,no_all_squash)
      - /usr/local  "*"(rw,sync,no_root_squash,no_all_squash)
exportfs -a:
  cmd.run
nfs-server:
  service.running:
    - enable: True
    - reload: True
{% else %}
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
{% endif %}
