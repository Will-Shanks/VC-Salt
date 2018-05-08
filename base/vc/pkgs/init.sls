pkgs:
  pkg.installed:
    - pkgs:
      - vim-enhanced
      - net-tools
      - man-db
      - nfs-utils
      - munge
      - gcc
      - gcc-c++
      - kernel-devel
      - ncurses-devel
      - make
      - rpm-build
      - munge-devel
      - readline-devel
      - openssl-devel
      - openssl
      - perl-devel
      - pam-devel
      - lua
      - mariadb
      - mariadb-devel
      - glib
      - gtk+
      - libcurl-devel
      - man2html
      - rsync
      - perl-Switch
      - git
      - wget
      - lz4
      - lz4-devel
#      - pmix
#      - pmix-devel
#      - openmpi
#      - openmpi-devel
      - perl-Data-Dumper
      - autoconf
      - libedit
      - automake
      - libtool
      - libevent-devel
      - flex
{% if grains['id'] == pillar['slurm_server'] %}
      - mariadb-server
{% endif %}
