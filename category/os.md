---
layout: catpage
title: Operating Systems Articles
excerpt: All posts related to operating systems lists here
---
{% assign cat = {{page.name | remove: '.md'}} %}
<ul class="list-none">
{% for category in site.categories %}
{% if category.first == cat %}
{% for posts in category[1] %}
<li><a class="post-link" href="{{ posts.url }}">{{ posts.title }}</a></li>
{% endfor %}
{% endif %}
{% endfor %}
</ul>

