# Vim-Ruler

A plugin to let you cycle and use rulers in Vim.

## Cycling ruler

This plugin lets you cycle through various position of ruler (made with Vim's
`colorcolumn`) with the call to a function. Each call of the command
`RulerCycle` place the next ruler from a list, or remove all rulers when the
list have been fully used.

The list of available position is define in the variable `g:rulerList`. If not
defined, it will be initialized by default to `[80, 50, 100]`. That meas that
the fist call to `RulerCycle` will place the ruler at 80 columns, the second at
50 columns, the third at 100 columns, and the fourth will remove the ruler. It
will then loop back.

You can override that default list by defining the variable `g:rulerList` in
your vimrc. For example, if you want the first call to place a ruler at 90
columns, the second at 30 columns, and the last to remove the ruler, you can add
to your vimrc the line `let g:rulerList = [90, 30]`.

If you want, you can have multiple rulers shown at the same time. For example,
if you want to alternate between a ruler at 20 columns along with a one at 50,
and a ruler at 40 columns along with a one at 80, you can set the `g:rulerList`
variable as such: `let g:rulerList = ["20,50", "40,80"]`. Note the quotes and
the lack of space inside them.

## Cutting text to a ruler

The plugin also let you cut a line into smaller chunks that fit within a ruler.
You can do so with the command `RulerCut`. This command tries to cut the line at
spaces or tabs if they are present. If there is no spaces or tabs in the line,
it adds a new line right at the ruler.

If you have multiple rulers shown at the same time with the `"xx,xx,xx"` syntax,
the line is cut at the first ruler from the list.

## Configuration

This plugin is easier to use if the commands are triggered with a key binding.
Here is the extract from my vimrc that does it:

```vimscript
" vim-ruler
nnoremap <F6> :RulerCycle<Cr>
nnoremap <leader><F6> :RulerCut<Cr>
```

