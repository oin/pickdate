`pickdate` is a Mac command line utility that displays a date picker and prints the selected date after user confirmation.

## How to use

First, compile the program:

```
make
```

Then, launch it:

```
./pickdate
```

A window will appear with a picker set to today's date.
Select a date using the mouse, then either confirm by double-clicking the date, or close the window.

Upon confirmation, the program will print the selected date with the `YYYY-MM-DD` format to the standard output, and exit.
If no date has been selected, the program exits with status 1.

## Keyboard shortcuts

The program can also be operated entirely using the keyboard:

 - _Cmd+T_: Select today
 - _Return_: Confirm the selected date
 - _Escape_ or _Cmd+W_ or _Cmd+Q_: Cancel
 - _Left_: Select the previous day
 - _Right_: Select the next day
 - _Up_: Select the previous week
 - _Down_: Select the next week
 - _Alt+Up_: Select the previous month
 - _Alt+Down_: Select the next month
 - _Alt+Left_: Select the previous year
 - _Alt+Right_: Select the next year

## Initial date

Instead of today's date, you can set another initial date as a user default, using the `YYYY-MM-DD` format:

```
./pickdate -InitialDate 2020-01-01
```
