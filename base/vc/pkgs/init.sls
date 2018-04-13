pkgs:
  pkg.installed:
    - pkgs:
      - vim-enhanced
      - net-tools
  service.dead:
    - name: firewalld
    - enable: False
