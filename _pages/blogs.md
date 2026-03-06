---
layout: default
title: "Blogs"
permalink: /blogs.html
author_profile: true
---

# My Blogs

这里记录了我的技术笔记与日常思考。

<ul>
  {% for post in site.posts %}
    <li>
      <span>{{ post.date | date: "%Y-%m-%d" }}</span> — 
      <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
