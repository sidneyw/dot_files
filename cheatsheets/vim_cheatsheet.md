======================
03/19/16 22:30:12
======================

Last Edited Text
======================
\ is to escape the backtick and not part of the command
\`[ beginning of last edited
\`] end of last edited

Substitute
======================
Use substitute to count occurances
	:%s/pattern//gn

	The n flag at the end is no op and therefore you just see the matches echoed in the
	Vim command line

	:h regexp

Marks
======================
	Marks [a-Z] are local
	Marks [A-Z] are global (between files)

	Marks '[ and '] delimit the last modified text
		- This is useful if you want to do something with text you just pasted or
		  something similar

	'a goes to a
	`a also goes to a

Range
======================
	(number)  Absolute line number
	.         Current line
	$         Last line in the file
	%         The current file
	't        Location of mark t
	/pattern/ The next line where pattern occurs
	?pattern? The previous line where pattern occurs

	:h range

Moving Lines
======================

	'am/Moving/-1
		moves the line at mark a to the line before the next occurrence of Moving

	/Test/m/Moving/-1
		moves the line starting with test to the line before the next occurrence of Moving

Note
======================
Press C-f in command line mode to get a list of the last few commands in a buffer.
You can edit a command as text and then hit enter to run it

Registers
======================
Registers 1-9 are delete registers. They work like a stack

Registers are executable as macros. If you pull into a register you can execute that text
as a macro since macro registers and copy/paste registers are the same group of registers

Note
======================
Count Operator Motion

External Tools
======================
To read in a file or output from a command
	:r file_name
	:r !external command

To run the current line through the stdin of an external command
	:.![cmd]

From normal mode to run the current line as a command
	!!sh

Note
======================
	:h ins-completion

Vim Surround
======================
cs"' change surrounding " to '
ds"  delete surrounding "
yss( Add surrounding braces
cst" change html tag to "

Vim Commentary
======================
gcc  toggle comment on a line
gcap toggle comment on a paragraph
