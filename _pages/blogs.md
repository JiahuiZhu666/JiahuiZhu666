---
layout: default
title: "Blogs"
permalink: /blogs.html
---

Technical notes, seminar slides, and research ideas.

<div class="writing-list">
{% for post in site.posts %}
<a class="writing-card" href="{{ post.url | relative_url }}"><div><p class="eyebrow">{{ post.date | date: '%b %d, %Y' | upcase }}</p><h3>{{ post.title }}</h3></div><span aria-hidden="true">↗</span></a>
{% endfor %}
</div>
