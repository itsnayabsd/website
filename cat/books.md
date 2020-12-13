---
layout: catpage
title: Books
excerpt: Online books - Embedded Linux with Raspberry Pi 3B, Learning Linux Command Line
---
<div>
   		{% for post in site.posts %}
			{% assign catg = post.category %}
			{% if catg != "book" %}
				{% continue %}
			{% endif %}
       			<a class="post-link" href="{{ post.url }}">&#9897; {{ post.title }}</a>
   		{% endfor %}
</div>

