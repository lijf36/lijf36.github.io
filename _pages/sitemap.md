---
layout: archive
title: "Sitemap"
permalink: /sitemap/
author_profile: true
---

{% include base_path %}

<ul>
{% for link in site.data.navigation.main %}
  <li><a href="{{ base_path }}{{ link.url }}">{{ link.title }}</a></li>
{% endfor %}
</ul>
