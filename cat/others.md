---
layout: catpage
title: Others
excerpt: Embedded System articles
---
<div>
   		{% for post in site.posts %}
			{% assign catg = post.category %}
			{% if catg != "web" and catg != "financial" and catg != "gadgets" and catg != "book" and catg != "cloud" and catg != "financial" and catg != "programming" and catg != "android" %}
				{% continue %}
			{% endif %}
       			<a class="post-link" href="{{ post.url }}">&#9897; {{ post.title }}</a>
   		{% endfor %}
</div>

