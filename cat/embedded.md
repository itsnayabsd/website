---
layout: catpage
title: Embedded
excerpt: Embedded System articles
---
<div>
   		{% for post in site.posts %}
			{% assign catg = post.category %}
			{% if catg != "rpi3b-elinux" and catg != "networking" and catg != "embedded" and catg != "linux-drivers" and catg != "drivers" %}
				{% continue %}
			{% endif %}
       			<a class="post-link" href="{{ post.url }}">&#9897; {{ post.title }}</a>
   		{% endfor %}
</div>

