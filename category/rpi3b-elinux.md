---
layout: catpage
title: Embedded Linux for RPI3 Model B
excerpt: Series of tutorials for building Embedded Linux for Raspberry Pi 3 Model B
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
