---
layout: catpage
title: Linux
excerpt: Embedded Linux with RPI3 Model B
---
<div>
   		{% for post in site.posts %}
			{% assign catg = post.category %}
			{% if catg != "linux" and catg != "linux-tools" and catg != "linux-drivers" and catg != "man2" and catg != "man3" %}
				{% continue %}
			{% endif %}
       			<a class="post-link" href="{{ post.url }}">&#9897; {{ post.title }}</a>
   		{% endfor %}
</div>

