sshd:
  pkg.installed:
    - name: openssh
  service.running:
    - name: sshd
    - enable: True
