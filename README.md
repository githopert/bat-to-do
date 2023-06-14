# `bat-to-do`

A primitive TO-DO list system written in Batch.


## Features

* A simple interface consisting of 2 commands (`show` and `edit`).
* Use your favorite text editor: `vim`, `nvim`, `subl`, `notepad`, ...
* The script automatically creates today's entry.
* The script automatically transfers the undone tasks from yesterday's entry.
* The script uses TXT-files to store your tasks. They form the history of your daily productivity.


## Installation

1) Download the `.bat` file and place it in a folder added to the `PATH` variable.
2) Open it with a text editor and edit the 2 following parameters:
    ```bash
    set editor=
    set folder_path=
    ```
3) Open the command line and run `todo`.


## Usage

* `todo SHOW` and `todo` - shows today's entry (commands are not case sensitive).
* `todo EDIT` - opens today's entry in the text editor specified in the settings.
* `todo SHOW 13-06-2023` - shows the entry for the specified date (if it exists).
* `todo EDIT 13-06-2023` - similar to the two previous commands.
* Running any command of this script after 00:00 AM will automatically create an entry for a new day.

(*I have not used this script with other date formats. So, I do not know how it will handle them!*) 
