---
layout: default
title: Scripts
---

# Available Scripts

Here are the available scaffolding scripts. Click on a script name to view its documentation.

| Script                      | Description                                       |
| --------------------------- | ------------------------------------------------- |
{% for script in site.scripts %}
| [{{ script.title }}]({{ script.url }}) | {{ script.description }} |
{% endfor %}
