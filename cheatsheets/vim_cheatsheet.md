======================
03/19/16 22:30:12
======================

Ctags
======================

<C-]>    goto tag
<C-w> ]  open tag in preview
[ I      see where else the function/variable is used

Fugitive
======================

:Git [args]
:Gwrite    stages the current file
:Gremove
:Gmove
:Gcommit
:Gblame

Syntastic
======================

:SyntasticCheck
:Errors
:lclose
:lnext
:lprevious
:SyntasticToggleMode

Tmux
======================

Copy Paste
	<prefix [> Enter copy mode
	Space      Start selection
			   * Highlight Selection *
	<CR>       Copy to Tmux Buffer
			   * Navigate to Paste Location *
	<prefix	]> Paste From Buffer

Other Copy Paste
	tmux show-buffer
	tmux save-buffer file_name.txt
	tmux list-buffers
	tmux show-buffer -b [buff_index]
	tmux save-buffer -b [buff_index]

Command Line FU
==================

<C-x> <C-e>       | Opens a text editor to write a command in
<ESC> .           | The arguments from the last line
<space> command   | Command wont be saved in history
<C-u> [...] <C-y> | Yank the current line, run another command, paste the original line
vim -x filename   | Encrypt file
<ESC> *           | Insert autocompletion results on the command line

Vim Unimpaired
======================

*[a*     |:previous|
*]a*     |:next|
*[A*     |:first|
*]A*     |:last|
*[b*     |:bprevious|
*]b*     |:bnext|
*[B*     |:bfirst|
*]B*     |:blast|
*[l*     |:lprevious|
*]l*     |:lnext|
*[L*     |:lfirst|
*]L*     |:llast|
*[<C-L>* |:lpfile|
*]<C-L>* |:lnfile|
*[q*     |:cprevious|
*]q*     |:cnext|
*[Q*     |:cfirst|
*]Q*     |:clast|
*[<C-Q>* |:cpfile| (Note that <C-Q> only works in a terminal if you disable
*]<C-Q>* |:cnfile| flow control: stty -ixon)
*[t*     |:tprevious|
*]t*     |:tnext|
*[T*     |:tfirst|
*]T*     |:tlast|

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
