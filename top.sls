base:
  '*':
    - base
  {% if "k8s-master" in grains.get('role', []) %}
    - k8s-master
  {% endif %}
  {% if "k8s-worker" in grains.get('role', []) %}
    - k8s-worker
  {% endif %}
