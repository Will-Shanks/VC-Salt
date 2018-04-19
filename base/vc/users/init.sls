root:
  user.present:
    - name: root
    - password: {{ pillar['rootPass'] }}
shanks:
  user.present:
    - name: shanks
    - password: {{ pillar['shanksPass'] }}
#    - uid: {{ pillar['shanksid'] }}
#    - gid: {{ pillar['shanksid'] }}
    - home: /home/shanks
    - createhome: True
    - groups:
      - wheel
