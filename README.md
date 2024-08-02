# Wheel of GitHub

This script is a fun exercise for dev teams. Or at least, I think it's fun. 

It comes from the idea that ALL CODE IS INTERESTING, if we choose to actually look at it. When we're writing code,
we're constantly making decisions and those decisions are interesting. Sometimes, we're doing things that the rest of 
your team are unaware of. These things might seem boring to you, but not to them.

So Wheel of GitHub combats the problem where code reviews end up focusing on the extremely polished code, or the 
extremely messy code. Wheel of GitHub is about everything in-between. It's about finding the interest in quotidian code.

Wheel of GitHub will pick a random files and line in your codebase. Then, your team can talk together about what 
they find:

* Why does this even exist?
* What alternatives could we have used?
* Could other code benefit from lessons here?
* Could this be improved?

It's amazing what you'll find with an undirected code review via Wheel Of GitHub.

## Pre-requisites

This script uses `zsh` shell, the GitHub CLI tool, `gh`, `python`, and `grep`. Which is to say, it was thrown together
for me by ChatGPT. And could maybe be done more succinctly. Maybe just using python, but if you don't like it, PR me. 

## Usage

From the root directory of your project, run `wheel-of-github.sh`. It will pick a random file and a random line, then 
open a web browser to that place:  

```zsh
../wheel-of-github/wheel-of-github.sh
```

You can also run it with `--url-only` to print the URL instead of immediately opening it.

```zsh
../wheel-of-github/wheel-of-github.sh --url-only
```

## Excluded Files

Note that at [Processity](https://www.processity.ai/), we work on Salesforce products. So this script is a little tailored to Salesforce in that it excludes some files that exist for Salesforce but have no interest e.g. the meta.xml files that go along with Apex source files. 