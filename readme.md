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

<table>
  <thead>
    <tr>
      <th colspan="28">2013-02-01</th>
    </tr>
    <tr>
      <th></th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
      <th>10</th>
      <th>11</th>
      <th>12</th>
      <th>13</th>
      <th>14</th>
      <th>15</th>
      <th>16</th>
      <th>17</th>
      <th>18</th>
      <th>19</th>
      <th>20</th>
      <th>21</th>
      <th>22</th>
      <th>23</th>
      <th>24</th>
      <th>25</th>
      <th>26</th>
      <th>27</th>
      <th>28</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td>jonas@follesoe.no</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>:facepunch: :tiger:</td>
        <td></td>
        <td></td>
        <td></td>
        <td>:facepunch:</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>    
  </tbody>
</table>  
<table>
  <thead>
    <tr>
      <th colspan="31">2013-01-01</th>
    </tr>
    <tr>
      <th></th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
      <th>10</th>
      <th>11</th>
      <th>12</th>
      <th>13</th>
      <th>14</th>
      <th>15</th>
      <th>16</th>
      <th>17</th>
      <th>18</th>
      <th>19</th>
      <th>20</th>
      <th>21</th>
      <th>22</th>
      <th>23</th>
      <th>24</th>
      <th>25</th>
      <th>26</th>
      <th>27</th>
      <th>28</th>
      <th>29</th>
      <th>30</th>
      <th>31</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td>jonas@follesoe.no</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>:facepunch: :poop: :facepunch: :metal: :triumph: :smile:</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>olepbang@gmail.com</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>:bowtie:</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>    
  </tbody>
</table>  

:facepunch: :facepunch: :facepunch: