# MTE204_1b

GIT 101 for you guys that haven't really used git. - Sincerely Jin <3

<strong>MAKE AN ACCOUNT WITH GITHUB</strong>
https://github.com/

<strong>FOLLOW THIS DOC AND SETUP YOUR GIT:</strong>
https://help.github.com/articles/set-up-git/

<h4>Using the repository:</h4>

Open your (git bash) terminal

Go to a directory you set as the dedicated MTE 204 directory. You can do that using "cd":

    $ cd <path to directory>


There, you want to clone this repository. To clone this repository, run this command in the shell:

    git clone git@github.com:lee12jin/MTE204_1b.git


You will notice that you now have all the components of the repository inside a project folder... You can work with it and change the matlab code

<strong>IMPORTANT: pushing and pulling:</strong>
pulling is a way to update your computer with the most recent code.
pushing is a way to send your updates to github, where our code is being hosted.

How to pull:
To pull, just run this command inside the project folder:

    git pull


How to push:
You want to save your changes in your local git first by running this command..

    git add <filename>

Conversely if you want to add everything you changed, just do..
    
    git add -A

Now you want to commit everything you've added as the changes to github..
The following command stores all your changes you've added and adds it to 
your local git history with a message. Try to keep this message descriptive
enough for you to remember the changes that went along with everything.

    git commit -m <message>

I usually put the message within double quotations like so...

    git commit -m "Added so-and-so function to project."

Now that you've commited, you are able to push..

<strong>ALWAYS PULL BEFORE PUSHING</strong>. Somebody else's updates may tamper with your newest code.
It's difficult on the team if you push code that doesn't work with somebody else's code. Everybody gets affected by this.

    git pull

Verify that everything is fine, then...

    git push


![Alt text][id]
[id]: http://octodex.github.com/images/dojocat.jpg  "The Dojocat"
