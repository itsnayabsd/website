---
layout: catpage
title: Developer tools configuration and usage in the cloud.
excerpt: All posts related to dev tools and configuration list here.
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

