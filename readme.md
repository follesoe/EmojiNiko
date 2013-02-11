# EmojiNiko - A Niko-niko Calender based on your git repository #
This is a proof-of-concept of an idea to generate a [Niko-niko Calendar](http://agiletrail.com/2011/09/12/how-to-track-the-teams-mood-with-a-niko-niko-calendar/) based on [Emoji emoticons](http://www.emoji-cheat-sheet.com/) mentioned in the commit messages.

The basic idea behind a Niko-niko Calendar is to track and visualize the team's mood over time, by having a calendar  where each team member can draw a happy or angry smiley face at the end of the day.

I have no idea why it is called a Niko-niko calendar, and it sounds kind of silly. Probably because any agile technique needs a Japanese name to gain attraction. I have no idea if it is an effective technique. This is the mere result of some hacking, and playing around with the power full ``git log`` command.

## Implementation ##
The data is extracted from the repository by using a ``git log``, using a regex search for anything matching ``:[a-z]+:``, which is the pattern for an emoji code. The log is formatted as a CSV file, so that each line can be read easily.

```
git log --since='last month' --pretty=format:'%aE;%aD;%s' -E --grep ':[a-z]+:'
```

The ``emojiniko.rb`` script issues the ``git log`` command and parses the results, before generating an HTML table, with one row for each team member, and one column for each day of the month. Any emoji icons used by a given team member for a given day is inserted.

The [emojify.js](http://hassankhan.github.com/emojify.js/) library is used to transform the emoji codes to icons. For an overview of available codes, see the [Emoji Cheat Sheet](http://www.emoji-cheat-sheet.com/).

Remember - this is a proof-of-concept and by no means pretty or complete implementation, so no attention has been put into CSS styling of the table.

## Usage ##
Simply drop ``emojiniko.rb`` into a folder containing a git repository, and issue the command:  ``ruby emojiniko.rb > output.html``. 

This will generate a calendar for the current month, starting on the first. The output.html file depends on [emojify.js](http://hassankhan.github.com/emojify.js/), so ``emojify.js`` and ``emojify.css`` must be present in the same directory as the ``output.html`` file is hosted from.

### Example Output for this repository ###
The generated calendar for this project [can be found here](https://rawgithub.com/follesoe/EmojiNiko/master/output.html).

:facepunch: :facepunch: :facepunch: