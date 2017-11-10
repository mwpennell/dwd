## Lecture 2 Commands -- Introduction to git and github


The first thing we are going to do is to set up your system so you don't have to type in your username and/or password each time. Let's follow [Jenny Bryan's excellent guide here](http://happygitwithr.com/credential-caching.html#credential-caching)

###Next we recommend that you change your name to something more ridiculous than your current name - e.g. Cacagator

### Reseting repo to a specific commit

Be super careful with this one!! Imagine you really messed up and want to go back in time to a specific commit (let's say it is labeled e3f1e37). To set your local repo (i.e., the one on your computer) back to this commit, all you need to do is to click on `Tools -> Shell` then type

```
git checkout master
git reset --hard e3f1e37
````

If you want to do the even more dangerous thing and reset your GitHub repo to this commit, also type the line

```
git push --force origin master

```

