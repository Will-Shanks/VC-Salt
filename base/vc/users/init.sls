/etc/passwd:
  file:
    - managed
    - source: salt://vc/users/passwd
    - mode: 644

/etc/group:
  file:
    - managed
    - source: salt://vc/users/group
    - mode: 644

/etc/shadow:
  file:
    - managed
    - source: salt://vc/users/shadow
    - mode: 000

/home/shanks:
  file.directory:
    - user: shanks
    - group: shanks
    - mode: 755
