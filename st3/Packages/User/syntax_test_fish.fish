#! SYNTAX TEST "Packages/User/fish.tmLanguage"

# If using fish to test parsing of this file, all invalid illegal tokens and their tests must be temporarily removed

# -----------------------------------------------------------------------------

./configure; and make; and make install
#!           ^^^ keyword.operator.word
#!                     ^^^ keyword.operator.word
#!               ^^^^ meta.function-call.name variable.function
#!                         ^^^^ meta.function-call.name variable.function
#!                              ^^^^^^^ meta.function-call.parameter.argument

./configure && make && make install
#!          ^^ meta.function-call.operator.control.double-ampersand
#!             ^^^^ meta.function-call.name variable.function
#!                  ^^ meta.function-call.operator.control.double-ampersand
command echo out 2>| cat
#!                ^^ meta.function-call.operator.pipe keyword.operator

not true && true ; or true || not true
#!       ^^ meta.function-call.operator.control.double-ampersand
#!                         ^^ meta.function-call.operator.control.double-bar

# -----------------------------------------------------------------------------

;
#! <- keyword.operator.control
&
#! <- invalid.illegal.function-call
|
#! <- invalid.illegal.function-call
\
#! <- constant.character.escape

echo arg & # comment
#! ^^^^^^^ meta.function-call
#!       ^ keyword.operator.control
#!         ^ comment.line

echo 'single-quoted' "double-quoted" unquoted
#!   ^^^^^^^^^^^^^^^ string.quoted.single
#!                   ^^^^^^^^^^^^^^^ string.quoted.double
#!                                   ^^^^^^^^ meta.string.unquoted

# The next line should have a tab character between b and c
echo a\tb	c
#!   ^^^^ meta.function-call.parameter.argument meta.string.unquoted
#!       ^ meta.function-call
#!         ^ meta.function-call.operator.control

# The ~ and % are only special characters in need of escaping when at the front of arguments
echo ~foo \~bar~\~ %foo \%bar%\%
#!   ^^^^ meta.string.unquoted
#!   ^ keyword.operator.tilde
#!        ^^^^^^^^ meta.string.unquoted
#!             ^ - keyword.operator.tilde
#!        ^^ constant.character.escape
#!                 ^^^^ meta.function-call.parameter.argument.process-expansion
#!                 ^ punctuation.definition.process
#!                      ^^^^^^^^ meta.string.unquoted
#!                      ^^ constant.character.escape
#!                           ^ - punctuation.definition.process

echo ~/foo/*.bar /**.bar foo.?\?r ***.bar foo/*\**
#!   ^^^^^^^^^^^ meta.string.unquoted
#!   ^ keyword.operator.tilde
#!         ^ keyword.operator.single-star
#!               ^^^^^^^ meta.string.unquoted
#!                ^^ keyword.operator.double-star
#!                       ^^^^^^^^ meta.string.unquoted
#!                           ^ keyword.operator.question-mark
#!                            ^^ constant.character.escape
#!                                ^^^^^^^ meta.string.unquoted
#!                                ^^ keyword.operator.double-star
#!                                  ^ keyword.operator.single-star
#!                                        ^^^^^^^^ meta.string.unquoted
#!                                            ^ keyword.operator.single-star
#!                                             ^^ constant.character.escape
#!                                               ^ keyword.operator.single-star

echo str\a str\x12345 str\X12345 str\012345
#!   ^^^^^ meta.string.unquoted
#!      ^^ constant.character.escape
#!            ^^^^ constant.character.escape
#!                       ^^^^ constant.character.escape
#!                                  ^^^^ constant.character.escape

echo str\u01a2345 str\U01a2b3c45 str\cab
#!   ^^^^^^^^^^^^ meta.string.unquoted
#!      ^^^^^^ constant.character.escape
#!                   ^^^^^^^^^^ constant.character.escape
#!                                  ^^^ constant.character.escape

echo arg # comment
echo arg
#! <- variable.function

echo ar\
g # comment
#! <- meta.function-call.parameter.argument meta.string.unquoted
#! ^^^^^^^^ comment.line

# If the '#' comes right at the start of the line, it will be part of the parameter!
echo out\
# not a comment!
#! <- meta.function-call.parameter.argument meta.string.unquoted

# But if we have any space at all, then a comment can begin
echo out\
 # comment
#! ^^^^^^^^ comment.line

echo str1 2 3str
#!   ^^^^ meta.string.unquoted
#!      ^ - constant.numeric
#!        ^ meta.string.unquoted constant.numeric
#!          ^ - constant.numeric
#!          ^^^^ meta.string.unquoted

echo 1 1.2 .3 4. .
#!   ^ constant.numeric
#!     ^^^ constant.numeric
#!         ^^ constant.numeric
#!            ^^ constant.numeric
#!               ^ - constant.numeric

echo --arg -arg arg ; echo arg # comment
#! <- meta.function-call.name variable.function
#! ^^^^^^^^^^^^^^^^  meta.function-call
#!   ^^^^^ meta.function-call.parameter.option.long variable.parameter
#!         ^^^^ meta.function-call.parameter.option.short variable.parameter
#!              ^^^ meta.function-call.parameter.argument
#!                  ^ keyword.operator.control
#!                    ^^^^ meta.function-call.name variable.function
#!                    ^^^^^^^^ meta.function-call
#!                             ^ punctuation.definition.comment
#!                             ^^^^^^^^^ comment.line

echo a=a -a=a --a=a
#!   ^^^ meta.string.unquoted
#!       ^^^^ meta.function-call.parameter.option.short variable.parameter meta.string.unquoted
#!       ^ punctuation.definition.option.short
#!         ^ - punctuation.definition.option.long.separator
#!            ^^^^^ meta.function-call.parameter.option.long meta.string.unquoted
#!            ^^ meta.function-call.parameter.option.long variable.parameter punctuation.definition.option.long.begin
#!               ^ meta.function-call.parameter.option.long variable.parameter punctuation.definition.option.long.separator

echo - 1
#!   ^ - variable.parameter

set equals =
echo "$equals"
#! <- variable.function

echo --==
cmd
#! <- variable.function

= arg
#! <- variable.function meta.string.unquoted
#! ^^ meta.function-call.parameter.argument

echo --num=2 -n2
#!   ^^^^^^ meta.string.unquoted
#!         ^ meta.function-call.parameter.option.long constant.numeric
#!             ^ - constant.numeric

cmd -h --help -- -- -h # comment
#! ^^^^^^^^^^^^^^^^^^^ meta.function-call
#!  ^^ meta.function-call.parameter.option.short variable.parameter
#!     ^^^^^^ meta.function-call.parameter.option.long variable.parameter
#!            ^^ meta.function-call.parameter.option.end variable.parameter punctuation.definition.option.end meta.string.unquoted
#!               ^^ - variable.parameter
#!                  ^^ - variable.parameter
#!                     ^^^^^^^^^ comment.line

1 arg -1 +1 -- -1. +.0
#! <- - constant.numeric
#!    ^^ meta.function-call.parameter.option.short variable.parameter
#!    ^^ - constant.numeric
#!       ^^ constant.numeric
#!             ^^^ constant.numeric
#!                 ^^^ constant.numeric

echo str \ # not-comment \  # comment
#!   ^^^ meta.string.unquoted
#!       ^^^ meta.string.unquoted
#!       ^^ constant.character.escape
#!                       ^^ meta.string.unquoted constant.character.escape
#!                          ^^^^^^^^^ comment.line

echo arg \ arg \
#! <- meta.function-call.name variable.function
#! ^^^^^^^^^^^^ meta.function-call
#!   ^^^ meta.function-call.parameter.argument
#!       ^ meta.function-call.parameter.argument
#!             ^ constant.character.escape
  # comment
#! ^^^^^^^^ comment.line
arg arg # comment
#! <- meta.function-call.parameter.argument
#! ^^^^ meta.function-call
#!  ^^^ meta.function-call.parameter.argument
#!      ^ comment.line

echo arg \
  # comment
#! ^^^^^^^^ comment.line
  arg # comment
#! ^^ meta.function-call.parameter.argument
#!    ^^^^^^^^^ comment.line

echo out \
"one" \

echo two
#! <- meta.function-call.name variable.function

echo arg (echo "inner" arg) outer arg
#!       ^^^^^^^^^^^^^^^^^^ meta.parens.command-substitution
#!       ^ punctuation.section.parens.begin
#!        ^^^^^^^^^^^^^^^^ meta.function-call
#!                        ^ punctuation.section.parens.end
#!                          ^ meta.function-call

echo arg(cat)(echo)(cat)arg arg
#!      ^ punctuation.section.parens.begin
#!          ^ punctuation.section.parens.end
#!           ^ punctuation.section.parens.begin
#!                ^ punctuation.section.parens.end
#!                 ^ punctuation.section.parens.begin
#!                     ^ punctuation.section.parens.end

echo (cat (cat))
# comment
#! <- - meta.parens.command-substitution

echo --arg=~/Documents --(echo arg)=(echo val)
#!         ^^^^^^^^^^^ meta.string.unquoted
#!         ^ - keyword.operator.tilde
#!                     ^^^^^^^^^^^^^ meta.function-call.parameter.option.long variable.parameter
#!                                  ^^^^^^^^^^ meta.function-call.parameter.option.long
#!                                  ^^^^^^^^^^ - variable.parameter

foo\ bar arg
#! ^^^^^ variable.function

'foo bar' arg
#! ^^^^^^ variable.function

"foo bar" arg
#! ^^^^^^ variable.function

f''o"o"\ ''b""ar arg
#! ^^^^^^^^^^^^^ variable.function

f'\''o"\$\\"o\ \|\$\*b\?\%a\#\(r\) arg
#! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ variable.function

\\foo arg
#! <- variable.function
#! ^^ variable.function

# Some valid function names are very strange
\ \  arg
#! <- variable.function
#! ^ variable.function
#!   ^^^ meta.function-call.parameter.argument

foo\
%bar arg
#! <- variable.function
#!   ^^^ meta.function-call.parameter.argument

~
#! <- variable.function

'\'\\'"\"\$\\"\a\b\e\f\n\r\t\v\ \$\\\*\?~\~%\%#\#\(\)\{\}\[\]\<\>^\^\&\|\;\"\'\x0a\X1b\01\u3ccc\U4dddeeee\c?
#! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ variable.function

%process arg
#! <- invalid.illegal.function-call
#! ^^^^^ invalid.illegal.function-call
#!       ^^^ meta.function-call.parameter.argument

<in.log arg
#! <- invalid.illegal.function-call
#! ^^^^ variable.function
#!      ^^^ meta.function-call.parameter.argument

>out.log arg
#! <- invalid.illegal.function-call
#! ^^^^^ variable.function
#!       ^^^ meta.function-call.parameter.argument

^err.log arg
#! <- invalid.illegal.function-call
#! ^^^^^ variable.function
#!       ^^^ meta.function-call.parameter.argument

;  ^^|err.pipe arg
#! ^^^ invalid.illegal.function-call
#!    ^^^^^^^^ variable.function
#!             ^^^ meta.function-call.parameter.argument

(echo out) arg
#! <- invalid.illegal.function-call
#! ^^^^^^^ invalid.illegal.function-call
#!         ^^^ meta.function-call.parameter.argument

foo()foo bar
#! ^^^^^ invalid.illegal.function-call
#!      ^ - invalid.illegal.function-call
#!       ^^^ meta.function-call.parameter.argument
## <- invalid.illegal.function-call # Not possible due to technical limitations

cat ((echo out) echo out) out
#!   ^^^^^^^^^^ invalid.illegal.function-call
#!             ^^^^^^^^^^ - invalid.illegal.function-call
#!                        ^^^ meta.function-call.parameter.argument

)option arg
#! <- invalid.illegal.function-call
#! ^^^^ invalid.illegal.function-call
##      ^^^ meta.function-call.parameter.argument # Not possible due to technical limitations

echo>out arg 2>err &
#! ^^^^^^^^^^^^^^^^^ meta.function-call
#!  ^^^^ meta.function-call.operator.redirection
#!           ^^^^^ meta.function-call.operator.redirection

echo one >out.log two < in.log three ^^err.log four4> out.log five
#!       ^^^^^^^^ meta.function-call.operator.redirection
#!       ^ keyword.operator.redirect
#!        ^^^^^^^ meta.function-call.operator.redirection.path
#!                ^^^ meta.function-call.parameter.argument
#!                    ^^^^^^^^ meta.function-call.operator.redirection
#!                    ^ keyword.operator.redirect
#!                      ^^^^^^ meta.function-call.operator.redirection.path
#!                                   ^^^^^^^^^ meta.function-call.operator.redirection
#!                                   ^^ keyword.operator.redirect
#!                                     ^^^^^^^ meta.function-call.operator.redirection.path
#!                                             ^^^^^ meta.function-call.parameter.argument
#!                                                  ^^^^^^^^^ meta.function-call.operator.redirection
#!                                                  ^ keyword.operator.redirect
#!                                                    ^^^^^^^ meta.function-call.operator.redirection.path
#!                                                            ^^^^ meta.function-call.parameter.argument

echo one 1>~/err.log two 2^err.log three^four five^6 7>? \
#!       ^^^^^^^^^^^ meta.function-call.operator.redirection
#!       ^   constant.numeric.file-descriptor
#!        ^   keyword.operator.redirect
#!         ^^^^^^^^^ meta.function-call.operator.redirection.path meta.string.unquoted
#!                   ^^^ meta.function-call.parameter.argument
#!                       ^^^^^^^^^ meta.function-call.parameter.argument
#!                                 ^^^^^^^^^^ meta.function-call.parameter.argument
#!                                            ^^^^^^ meta.function-call.parameter.argument
#!                                                   ^^^^ meta.function-call.operator.redirection
#!                                                   ^ constant.numeric.file-descriptor
#!                                                    ^^ keyword.operator.redirect
  out.log 8<? "in.log" nine
#!^^^^^^^ meta.function-call.operator.redirection.path
#!        ^^^^^^^^^^^^ meta.function-call.operator.redirection
#!        ^ constant.numeric.file-descriptor
#!         ^^ keyword.operator.redirect
#!            ^^^^^^^^ meta.function-call.operator.redirection.path string.quoted.double
#!                     ^^^^ meta.function-call.parameter.argument

echo one ^err.log^'log' >out.log<in.log < \?in.log > ?out.log
#!       ^^^^^^^^^^^^^^ meta.function-call.operator.redirection
#!       ^ keyword.operator.redirect
#!        ^^^^^^^^^^^^^ meta.function-call.operator.redirection.path
#!                ^^^^^ string.quoted.single
#!                      ^^^^^^^^^^^^^^^ meta.function-call.operator.redirection
#!                      ^ keyword.operator.redirect
#!                       ^^^^^^^ meta.function-call.operator.redirection.path
#!                              ^ keyword.operator.redirect
#!                               ^^^^^^ meta.function-call.operator.redirection.path
#!                                      ^^^^^^^^^^ meta.function-call.operator.redirection
#!                                      ^ keyword.operator.redirect
#!                                        ^^^^^^^^ meta.function-call.operator.redirection.path
#!                                                 ^^^^^^^^^^ meta.function-call.operator.redirection
#!                                                 ^ keyword.operator.redirect
#!                                                   ^^^^^^^^ invalid.illegal.path

echo one >? 1 >? 2<in.log
#!       ^^^^ meta.function-call.operator.redirection
#!       ^^ keyword.operator.redirect
#!          ^ meta.function-call.operator.redirection.path
#!            ^^^^^^^^^^^ meta.function-call.operator.redirection
#!            ^^ keyword.operator.redirect
#!               ^^^^^^^^ invalid.illegal.path

echo one > $file* <? (echo in.log) >{a,b} ^ \
#!       ^^^^^^^ meta.function-call.operator.redirection
#!       ^ keyword.operator.redirect
#!         ^^^^^ meta.string.unquoted variable.other
#!              ^ invalid.illegal.path
#!                ^^^^^^^^^^^^^^^^ meta.function-call.operator.redirection
#!                ^^ keyword.operator.redirect
#!                   ^^^^^^^^^^^^^ meta.parens.command-substitution
#!                                 ^^^^^^ meta.function-call.operator.redirection
#!                                 ^ keyword.operator.redirect
#!                                  ^^^^^ meta.function-call.operator.redirection invalid.illegal.path
#!                                  ^^^^^ - meta.braces.brace-expansion
#!                                        ^^ meta.function-call.operator.redirection
#!                                        ^ keyword.operator.redirect
#!                                          ^^ constant.character.escape
  "err.log"a? >out}a
#! ^^^^^^^^ meta.function-call.operator.redirection.path
#!          ^ invalid.illegal.path
#!                ^ invalid.illegal.path

echo one ^&2 two three3>&4 four 5>& \
#!       ^^^ meta.function-call.operator.redirection
#!       ^^ keyword.operator.redirect
#!         ^ constant.numeric.file-descriptor
#!               ^^^^^ meta.function-call.parameter.argument
#!                     ^^^ meta.function-call.operator.redirection
#!                     ^^ keyword.operator.redirect
#!                       ^ constant.numeric.file-descriptor
#!                              ^^^^ meta.function-call.operator.redirection
#!                              ^ constant.numeric.file-descriptor
#!                               ^^ keyword.operator.redirect
  - six 7<&->out.log 2> &1
#!^ keyword.operator.redirect.close
#!  ^^^ meta.function-call.parameter.argument
#!      ^^^^ meta.function-call.operator.redirection
#!      ^ constant.numeric.file-descriptor
#!       ^^ keyword.operator.redirect
#!         ^ keyword.operator.redirect.close
#!          ^^^^^^^^ meta.function-call.operator.redirection
#!          ^ keyword.operator.redirect
#!           ^^^^^^^ meta.function-call.operator.redirection.path
#!                   ^^^^^ meta.function-call.operator.redirection
#!                   ^ constant.numeric.file-descriptor
#!                    ^ keyword.operator.redirect
#!                      ^^ invalid.illegal.path

echo out >&"1" ^&"one"
#!         ^^^ meta.function-call.operator.redirection
##               ^^^^^ Scanning this string to ensure it contains exactly one integer is too hard, sorry

echo foo ^^&1& echo foo ^^&& 1
#!           ^ meta.function-call.operator.control keyword.operator.control
#!                         ^ meta.function-call.operator.redirection invalid.illegal.file-descriptor

echo bar >&\
& 1 >|cat
#! <- meta.function-call.operator.redirection invalid.illegal.file-descriptor

echo foo ^^fp& echo foo ^^>fp
#!           ^ meta.function-call.operator.control keyword.operator.control
#!                        ^ meta.function-call.operator.redirection invalid.illegal.path

echo one >&1>|cat; echo two >out>|cat
#!          ^^ meta.function-call.operator.pipe
#!                              ^^ meta.function-call.operator.pipe

echo one >&1>?two<&2>&4five
#!       ^^^ meta.function-call.operator.redirection
#!       ^^ keyword.operator.redirect
#!         ^ constant.numeric.file-descriptor
#!          ^^^^^ meta.function-call.operator.redirection
#!          ^^ keyword.operator.redirect
#!            ^^^ meta.function-call.operator.redirection.path
#!               ^^^ meta.function-call.operator.redirection
#!               ^^ keyword.operator.redirect
#!                 ^ constant.numeric.file-descriptor
#!                  ^^^^^^^ meta.function-call.operator.redirection
#!                  ^^ keyword.operator.redirect
#!                    ^^^^^ invalid.illegal.file-descriptor

foo>bar
#! <- meta.function-call.name variable.function
#! ^^^^ meta.function-call.operator.redirection

echo out <#comment <&#comment
#!        ^^^^^^^^ meta.function-call.operator.redirection invalid.illegal.path
#!                   ^^^^^^^^ meta.function-call.operator.redirection invalid.illegal.file-descriptor

echo (echo one \
#!   ^^^^^^^^^^^ meta.parens.command-substitution
#!             ^ constant.character.escape
two three # comment
#!        ^ comment.line
# comment
#! <- comment.line
echo four \
#! <- variable.function
#! ^^^^^^ meta.parens.command-substitution
five six # tricky comment \
echo seven
#! <- variable.function
)
#! <- meta.parens.command-substitution

echo ( \
#!     ^ constant.character.escape
;  &
#! <- keyword.operator.control
#! ^ invalid.illegal.function-call
echo &
#! <- meta.function-call
)  &  & hmm
#! ^ keyword.operator.control
#!    ^ invalid.illegal.function-call

echo ( # comment
#!     ^^^^^^^^^ comment.line
)

echo foo(echo -e nar\nbar)[2] f(echo oo)\[bar]
#!      ^^^^^^^^^^^^^^^^^^ meta.parens.command-substitution
#!                        ^^^ meta.brackets.index-expansion
#!                        ^ punctuation.section.brackets.begin
#!                          ^ punctuation.section.brackets.end
#!                                      ^^ constant.character.escape

foo\  # comment
#! ^^ variable.function

foo\ bar
#! ^^^^^ variable.function

exec echo \
#! <- meta.function-call.name support.function meta.string.unquoted
#!  ^ meta.function-call
#!   ^^^^ meta.function-call.name variable.function
arg
#! <-meta.function-call.parameter.argument

builtin echo &
#! <- meta.function-call.name support.function meta.string.unquoted
#!      ^^^^ meta.function-call.name variable.function
#!           ^ keyword.operator.control

builtin echo arg ; and echo arg
#! <- meta.function-call.name support.function
#!      ^^^^ meta.function-call.name variable.function
#!           ^^^ meta.function-call.parameter.argument
#!               ^ keyword.operator.control
#!                 ^^^ meta.function-call.name keyword.operator.word meta.string.unquoted
#!                     ^^^^ meta.function-call.name variable.function
#!                          ^^^ meta.function-call.parameter.argument

command  \
#! <- meta.function-call.name support.function meta.string.unquoted
#!       ^ constant.character.escape
echo  \
#! <- meta.function-call.name variable.function
arg & # comment
#! <-meta.function-call.parameter.argument
#!    ^ comment.line
echo arg
#! <- meta.function-call.name variable.function

command  &
#! <- meta.function-call.name variable.function
echo arg &
#! <-meta.function-call.name variable.function

builtin # comment
#! <- variable.function
#!      ^ comment.line

command echo # comment
#! <- support.function
#!           ^ comment.line

and \
#! <- meta.function-call.name keyword.operator.word
#! ^ meta.function-call
command \
#! <- meta.function-call.name support.function
echo \
#! <- meta.function-call.name variable.function
arg \
#! <- meta.function-call.parameter.argument
&
#! <- meta.function-call keyword.operator.control

not builtin case 1>/dev/null
#! <- meta.function-call.name keyword.operator.word meta.string.unquoted
#! ^ meta.function-call
#!  ^^^^^^^ meta.function-call.name support.function
#!          ^^^^ meta.function-call.name variable.function
#!               ^^^^^^^^^^^ meta.function-call.operator.redirection

not # comment
#! <- variable.function
#!  ^ comment.line

not true # comment
#! <- keyword.operator.word
#!       ^ comment.line

and # comment
#! <- variable.function
#!  ^ comment.line

or true # comment
#! <- keyword.operator.word
#!      ^ comment.line

and >out
#!  ^ invalid.illegal.function-call

echo (and)
#!    ^^^ variable.function

and && &
#!  ^^ invalid.illegal.function-call
#!     ^ invalid.illegal.function-call

and \
# comment
&
#! <- invalid.illegal.function-call

and | cat
#!  ^ invalid.illegal.function-call

not >out
#!  ^ invalid.illegal.function-call

echo (not)
#!    ^^^ variable.function

not && &
#!  ^^ invalid.illegal.function-call
#!     ^ invalid.illegal.function-call

not \
# comment
&
#! <- invalid.illegal.function-call

not | cat
#!  ^ invalid.illegal.function-call

echo out | echo out
#!  ^ meta.function-call
#!      ^ meta.function-call
#!        ^ meta.function-call

echo && echo &&& echo || echo ||| echo
#!    ^ invalid.illegal.function-call
#!            ^^ invalid.illegal.function-call
#!                     ^ invalid.illegal.function-call
#!                             ^^ invalid.illegal.function-call

command echo out 2>| cat
#!                ^^ meta.function-call.operator.pipe keyword.operator

exec %fish
#! <- meta.function-call.name support.function
#!   ^^^^^ invalid.illegal.function-call

and end; or %fish okay
#! <- meta.function-call.name keyword.operator.word
#!  ^^^ invalid.illegal.function-call
#!     ^ keyword.operator.control
#!       ^^ meta.function-call.name keyword.operator.word meta.string.unquoted
#!          ^^^^^ invalid.illegal.function-call

echo arg | cat
#! <- meta.function-call.name variable.function
#!       ^ meta.function-call keyword.operator.pipe
#!         ^^^ meta.function-call.name variable.function

echo \
#! <- meta.function-call.name variable.function
arg \
# comment
| \
#! <- meta.function-call keyword.operator.pipe
cat \
#! <- meta.function-call.name variable.function
| \
#! <- meta.function-call keyword.operator.pipe
cat \
#! <- meta.function-call.name variable.function
arg
#! <- meta.function-call.parameter.argument

| cat
#! <- invalid.illegal.function-call
#! ^^ variable.function

2>echo; 2>&>&|>&>|echo
#! <- invalid.illegal.function-call
#! ^^^ variable.function
#!      ^^^^^^^^^^ invalid.illegal.function-call
#!                ^^^^ variable.function

make fish 2>| less
#!        ^^^ meta.function-call.operator.pipe
#!        ^ constant.numeric.file-descriptor
#!         ^ keyword.operator.pipe.redirect
#!          ^ keyword.operator.pipe
#!            ^^^^ variable.function

echo (echo arg |) | cat
#!             ^ invalid.illegal.operator
#!                ^ meta.function-call keyword.operator

echo arg | # comment
#!       ^ invalid.illegal.operator

echo out one | \
# comment
#! <- comment.line
#! <- - meta.function-call
cat # we actually can't test if this command is here or not, but if it were absent then the pipeline would be invalid

echo arg | & cat
#!       ^ invalid.illegal.operator

echo arg | )paren
#!       ^ invalid.illegal.operator
#!         ^^^^^^ invalid.illegal.function-call

and echo arg | %fish
#!           ^ meta.function-call keyword.operator.pipe
#!             ^^^^^ invalid.illegal.function-call

not echo arg | | arg ; # comment
#!           ^ meta.function-call keyword.operator.pipe
#!             ^ invalid.illegal.function-call

echo out 1>|
#!       ^^^ invalid.illegal.operator

echo out >| 9>|
#!       ^^ meta.function-call.operator.pipe
#!          ^^^ invalid.illegal.function-call

echo out ^| cat ^^| cat
#!       ^ meta.function-call.operator.pipe keyword.operator.pipe.redirect
#!        ^ meta.function-call.operator.pipe keyword.operator.pipe
#!              ^^ meta.function-call.operator.pipe keyword.operator.pipe.redirect
#!                ^ meta.function-call.operator.pipe keyword.operator.pipe

command >| cat
#! <- variable.function

command >file out
#! <- variable.function
#!      ^^^^^ meta.function-call.operator.redirection
#!            ^^^ meta.function-call.parameter.argument

not >echo out
#!  ^ invalid.illegal.function-call
#!   ^^^^ variable.function
#!        ^^^ meta.function-call.parameter.argument

and or not
#!     ^^^ variable.function

not or and
#!     ^^^ variable.function

and \
# comment
#! <- comment.line
echo out

not \
# comment
#! <- comment.line
echo out

and echo out | and echo out
#!             ^^^ invalid.illegal.function-call

echo out | and
#!         ^^^ variable.function

echo out | 9>out
#!         ^^ invalid.illegal.function-call

2^cmd out | 1^^cmd in
#! <- variable.function
#!          ^^^ variable.function

echo out 1^| cat
#!       ^^ meta.function-call.parameter.argument

command 1^out 1^| out
#!      ^^^^^ variable.function

not 1^out
#!  ^^^^^ variable.function

echo out ^|
#!       ^^ invalid.illegal.operator

echo out 1>>out
#!       ^^^^^^ meta.function-call.operator.redirection

1>>out
#! <- invalid.illegal.function-call

and | cat
#! <- meta.function-call.name keyword.operator.word
#!  ^ invalid.illegal.function-call

and>cat
#! <- meta.function-call.name keyword.operator.word
#! ^ invalid.illegal.function-call
#!  ^^^ meta.function-call.name variable.function

echo || cat # comment
#!   ^ meta.function-call keyword.operator.pipe
#!    ^ invalid.illegal

echo arg | not echo arg
#!       ^ meta.function-call keyword.operator.pipe
#!         ^^^ meta.function-call keyword.operator.word
#!             ^^^^ meta.function-call.name variable.function

true; not and builtin true
#!    ^^^ meta.function-call keyword.operator.word
#!        ^^^ meta.function-call.name keyword.operator.word
#!            ^^^^^^^ meta.function-call.name support.function
#!                    ^^^^ meta.function-call.name variable.function

notecho out
#! <- meta.function-call.name variable.function

and -h
#! <- meta.function-call.name variable.function

builtin -h
#! <- meta.function-call.name variable.function

echo arg1 ; and echo arg2 & not echo arg3 | cat
#! <- meta.function-call.name variable.function
#!          ^^^ meta.function-call.name keyword.operator.word
#!              ^^^^ meta.function-call.name variable.function
#!                        ^ keyword.operator.control
#!                          ^^^ meta.function-call.name keyword.operator.word
#!                              ^^^^ meta.function-call.name variable.function
#!                                        ^ keyword.operator.pipe
#!                                          ^^^ meta.function-call.name variable.function

or echo arg1 | command cat
#! <- meta.function-call.name keyword.operator.word
#! ^^^^ meta.function-call.name variable.function
#!           ^ keyword.operator.pipe
#!             ^^^^^^^ meta.function-call.name support.function
#!                     ^^^ meta.function-call.name variable.function

builtin \
#! <- meta.function-call.name support.function
true | cat
#! <- meta.function-call.name variable.function
#!   ^ meta.function-call keyword.operator.pipe
#!     ^^^ meta.function-call.name variable.function

echo out | >echo
#!       ^ keyword.operator.pipe
#!         ^ invalid.illegal.function-call

echo "string"(echo "inner string")" outer string"
#!           ^^^^^^^^^^^^^^^^^^^^^ meta.parens.command-substitution
#!                                ^ string.quoted

echo $var $ $$"str" $var $$var $
#!   ^^^^ variable.other
#!   ^ punctuation.definition.variable
#!        ^ invalid.illegal.variable-expansion
#!          ^^ variable.other
#!          ^ punctuation.definition.variable
#!           ^ invalid.illegal.variable-expansion
#!            ^^^^^ string.quoted
#!                  ^^^^ variable.other
#!                       ^^^^^ variable.other
#!                       ^^ punctuation.definition.variable
#!                        ^^^^ variable.other variable.other
#!                             ^ invalid.illegal.variable-expansion

echo $foo\
bar
#! <- meta.variable-expansion variable.other

echo $var$ (echo $) $$!bad_var # comment
#!   ^^^^ variable.other
#!   ^ punctuation.definition.variable
#!       ^ invalid.illegal.variable-expansion
#!               ^ invalid.illegal.variable-expansion
#!                   ^^^^^^^^^ invalid.illegal.variable-expansion
#!                             ^^^^^^^^^ comment.line

echo $var[1..2] $var[1..$foo]
#!   ^^^^ variable.other
#!       ^^^^^^  meta.brackets.index-expansion
#!        ^ constant.numeric
#!         ^^ keyword.operator.range
#!           ^ constant.numeric
#!                  ^^^^^^^^^ meta.brackets.index-expansion
#!                      ^^^^ variable.other

# Check for when they're consecutive
echo $res[1]$res[2]
#!    ^^^ meta.variable-expansion variable.other
#!       ^^^  meta.brackets.index-expansion
#!           ^^^ meta.variable-expansion variable.other
#!              ^^^  meta.brackets.index-expansion

echo $var $var[$var[1 $var[1]] $var[1..2]] "str"
#!   ^^^^ variable.other
#!        ^^^^ variable.other
#!                  ^ meta.brackets.index-expansion meta.brackets.index-expansion
#!                    ^^^^ meta.brackets.index-expansion meta.brackets.index-expansion variable.other
#!                                         ^^^^^ string.quoted

echo $$var[ 1 ][ 1 ] $var[1.2]
#!   ^^^^^^^^^^^^^^^ meta.variable-expansion
#!    ^^^^ variable.other
#!        ^^^^^ meta.brackets.index-expansion
#!             ^^^^^ meta.brackets.index-expansion
#!                        ^^ - constant.numeric

echo $var[+1..-1]
#!        ^^ constant.numeric
#!            ^^ constant.numeric

echo $var[(echo 1)] $var["2"] "str"
#!   ^^^^ variable.other
#!       ^^^^^^^^^^ meta.brackets.index-expansion
#!        ^^^^^^^^  meta.parens.command-substitution
#!                       ^^^ string.quoted
#!                            ^^^^^ string.quoted

echo $var[abc] (echo 1)[ 1 * {1,2}2 ]
#!        ^^^ invalid.illegal.index
#!                       ^ constant.numeric
#!                         ^ invalid.illegal.index
#!                           ^^^^^ invalid.illegal.index
#!                                ^ constant.numeric

echo 'str$str\$str\'str\\"str"'
#!   ^ string.quoted.single punctuation.definition.string.begin
#!    ^^^^^^^^^^^^^^^^^^^^^^^^ string.quoted.single
#!                ^^ constant.character.escape
#!                     ^^ constant.character.escape
#!                            ^ string.quoted.single punctuation.definition.string.end

# This is to test that single-quoted strings always include newlines
echo 'str\
str
'
#! <- string.quoted.single punctuation.definition.string.end

echo "str$var\$str\"str\\'str'"
#!   ^ string.quoted.double punctuation.definition.string.begin
#!    ^^^^^^^^^^^^^^^^^^^^^^^^ string.quoted.double
#!       ^^^^ variable.other
#!       ^ punctuation.definition.variable
#!           ^^ constant.character.escape
#!                ^^ constant.character.escape
#!                     ^^ constant.character.escape
#!                            ^ string.quoted.double punctuation.definition.string.end

# This is to test that double-quoted strings can escape newlines
echo "str\
str
"
#! <- string.quoted.double punctuation.definition.string.end

echo $var{,'brace',"expansion",he{e,$e}re\,}"str"
#!   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.string.unquoted
#!   ^^^^ variable.other
#!   ^ punctuation.definition.variable
#!       ^ punctuation.section.braces.begin
#!        ^ punctuation.section.braces.separator
#!                ^ punctuation.section.braces.separator
#!                            ^ punctuation.section.braces.separator
#!                               ^ punctuation.section.braces.begin
#!                                 ^ punctuation.section.braces.separator
#!                                  ^^ variable.other
#!                                    ^ punctuation.section.braces.end
#!                                       ^^ constant.character.escape
#!                                         ^ punctuation.section.braces.end
#!                                          ^^^^^ string.quoted

echo 1{1.2,2a}3
#!   ^ - constant.numeric
#!     ^^^ constant.numeric
#!         ^ - constant.numeric
#!            ^ - constant.numeric

echo one{, ,\ }two
#!        ^ invalid.illegal.whitespace
#!          ^^ constant.character.escape

echo %"fish" one%two %%percent
#!   ^^^^^^^ meta.function-call.parameter.argument.process-expansion
#!   ^ punctuation.definition.process
#!    ^^^^^^ string.quoted
#!           ^^^^^^^ meta.string.unquoted
#!                   ^^^^^^^^^ meta.function-call.parameter.argument.process-expansion
#!                   ^ punctuation.definition.process
#!                    ^^^^^^^^ meta.string.unquoted

echo %fi\
sh>out
#! <- meta.function-call.parameter.argument.process-expansion
#! ^^^ meta.function-call.operator.redirection

echo %self foo %(set foo "fi"; echo $foo)sh "bar"
#!   ^^^^^ meta.function-call.parameter.argument.process-expansion
#!   ^ punctuation.definition.process
#!         ^^^ meta.string.unquoted
#!             ^ punctuation.definition.process
#!              ^^^^^^^^^^^^^^^^^^^^^^^^^ meta.parens.command-substitution
#!                                       ^^ meta.function-call.parameter.argument.process-expansion
#!                                          ^^^^^ string.quoted

echo %self>out
#!    ^^^^ variable.language

echo $var(echo str{$arg}str "{$var}")$var"str"$var
#!   ^^^^ variable.other
#!                 ^^^^ variable.other
#!                          ^^^^^^^^ string.quoted

echo -n --switch=(echo "str;";);
#!   ^^ meta.function-call.parameter.option.short
#!      ^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.parameter.option.long
#!                         ^ string.quoted
#!                           ^ keyword.operator.control
#!                             ^ keyword.operator.control

echo --switch=(echo "str;";
#!   ^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call.parameter.option.long
#!                      ^ string.quoted
#!                        ^ keyword.operator.control
  echo test \
#!   ^^^^^^^^^ meta.function-call.parameter.option.long
#!          ^ constant.character.escape
    &
#!  ^ keyword.operator.control
#!   ^ meta.function-call.parameter.option.long
)  ;
#! ^ keyword.operator.control

echo end
echo arg
#! <- meta.function-call.name variable.function

[ 1 -eq 1 >out ]; echo
#! <- meta.function-call.name support.function.test.begin
#! ^^^^^^^^^^^^^ meta.function-call
#!        ^^^^ meta.function-call.operator.redirection
#!             ^ meta.function-call.name support.function.test.end
#!              ^ keyword.operator.control

[1 ] ; [ 1 -eq 1] ;
#! <- meta.function-call.name variable.function
#! ^ meta.function-call.parameter.argument
#!                ^ invalid.illegal.function-call

return
#! <- meta.function-call.name keyword.control.conditional meta.string.unquoted

begin --help; end
#! <- meta.function-call.name variable.function
#!    ^^^^^^ meta.function-call.parameter.option.long
#!          ^ keyword.operator.control
#!            ^^^ invalid.illegal.function-call

foobegin; end
#! <- meta.function-call.name variable.function
#!        ^^^ invalid.illegal.function-call

foo\
begin; end
#! <- variable.function
#!     ^^^ invalid.illegal.function-call

begin &
#! <- meta.function-call.name variable.function meta.string.unquoted
#!    ^ invalid.illegal.operator

echo (begin))
#!    ^^^^^ meta.function-call meta.function-call.name variable.function meta.string.unquoted
#!         ^ meta.function-call invalid.illegal.operator

begin # comment
#! <- keyword.control.conditional
end

begin >echo arg; end >out | cat
#! <- variable.function
#!    ^ invalid.illegal.operator
#!               ^^^ invalid.illegal.function-call
#!                   ^ invalid.illegal.function-call
#!                        ^ meta.function-call.operator.pipe keyword.operator.pipe
#!                          ^^^ variable.function

begin end # comment
#! <- meta.block.begin meta.function-call.name keyword.control.conditional meta.string.unquoted
#!   ^ - meta.function-call
#!    ^^^ meta.block.begin meta.function-call.name keyword.control.conditional meta.string.unquoted
#!        ^^^^^^^^^ comment.line

begin true ; end
#!           ^^^ keyword.control.conditional

begin true & end ; end
#!           ^^^^^ meta.function-call
#!           ^^^ meta.function-call.name keyword.control.conditional
#!                 ^^^ invalid.illegal.function-call

echo one two& end
#!            ^^^ invalid.illegal.function-call

begin echo out; echo
end; or begin
#! ^ keyword.operator.control
#!      ^^^^^ meta.block.begin keyword.control.conditional
end
#! <- keyword.control.conditional

begin   # comment
#! ^^ keyword.control.conditional
  begin   # comment
  end end   # comment
#! ^^ keyword.control.conditional
#!    ^^^ meta.function-call.parameter.argument
end
#! <- keyword.control.conditional

echo one | begin
#!         ^^^^^ meta.block.begin keyword.control.conditional
  cat
  echo two
end >&1 | cat
#! <- meta.block.begin keyword.control.conditional
#!  ^^^ meta.function-call.operator.redirection
#!      ^ meta.function-call.operator.pipe keyword.operator.pipe
#!        ^^^ variable.function

begin; echo yes end | end ;
end
#! <- keyword.control.conditional

begin
  echo arg
end & echo next | cat
#!  ^ keyword.operator.control

# "echo (begin)" will error
# The second ')' and "end" are to catch the runaway scopes if needed
echo (begin) end)
#!    ^^^^^ variable.function
#!         ^ invalid.illegal.operator
#!            ^^^ meta.function-call.parameter.argument

while-cmd
#! ^^^^^^ variable.function

while true; break ; end
#! <- meta.block.while meta.function-call.name keyword.control.conditional meta.string.unquoted
#!   ^ - meta.function-call
#!    ^^^^ meta.block.while meta.function-call.name variable.function
#!                  ^^^ meta.block.while meta.function-call.name keyword.control.conditional meta.string.unquoted

while ; true ; end
#! ^^ variable.function
#!             ^^^ invalid.illegal.function-call

while --true; end
#!    ^^^^^^ meta.function-call.parameter.option.long
#!            ^^^ invalid.illegal.function-call

while &
# comment
#! <- comment.line

while # comment;end
#! <- variable.function
#!    ^^^^^^^^^^^^^ comment.line

while || true ; end
#! ^^ variable.function
#!    ^ invalid.illegal.operator
#!       ^^^^ variable.function
#!              ^^^ invalid.illegal.function-call

while>out arg;end
#! ^^ variable.function
#!   ^ invalid.illegal.operator
#!    ^^^ variable.function
#!            ^^^ invalid.illegal.function-call

while while; # comment end
#! <- keyword.control.conditional
#!    ^^^^^ variable.function
#!           ^ comment.line
end
#! <- keyword.control.conditional

while
#! ^^ variable.function
  true
end
#! <- invalid.illegal.function-call

while \
#! <- keyword.control.conditional
  true;
  echo
end

while while while while false; end ; end ; end ; end
#!                ^^^^^ meta.block.while meta.block.while  meta.block.while meta.block.while keyword.control.conditional
#!                                               ^^^ meta.block.while keyword.control.conditional

while test
#!        ^ meta.function-call.operator.control
while &
#! <- variable.function
#!    ^ invalid.illegal.operator
end

while true ; cmd arg ; end &
#!         ^ meta.function-call.operator.control keyword.operator.control
#!                     ^^^ keyword.control.conditional
#!                         ^ keyword.operator.control

while true & cmd arg ; end ;
#!         ^ invalid.illegal.function-call
#!                     ^^^ keyword.control.conditional
#!                         ^ keyword.operator.control

while false ))arg; end
#!          ^^^^^ invalid.illegal.function-call

while cmd end )end arg end; end
#!        ^^^ - keyword.control.conditional
#!            ^^^^ invalid.illegal.function-call
#!                     ^^^ - keyword.control.conditional
#!                          ^^^ keyword.control.conditional

# This executes without error
echo (while)
#!    ^^^^^ variable.function
#!         ^ punctuation.section.parens.end

begin
#! <- meta.block.begin keyword.control.conditional
  while echo arg
#! ^^^^ meta.block.while keyword.control.conditional
#!      ^^^^^^^^^ meta.function-call
    echo arg
#!  ^^^^^^^^ meta.function-call
    break ;
#!  ^^^^^ keyword.control.conditional meta.string.unquoted
#!        ^ keyword.operator.control
  end ;
#! ^^ keyword.control.conditional
#!    ^ keyword.operator.control
end &
#! <- keyword.control.conditional
#!  ^ keyword.operator.control

if echo arg
#! <- meta.block.if meta.function-call.name keyword.control.conditional meta.string.unquoted
#! ^^^^^^^^^ meta.block.if meta.function-call
#!         ^ meta.function-call.operator.control
  and echo arg
#!            ^ meta.function-call.operator.control
  echo arg
else if echo arg;
#! <- meta.function-call.name keyword.control.conditional meta.string.unquoted
#!   ^^ meta.function-call.name keyword.control.conditional meta.string.unquoted
#!              ^ meta.function-call.operator.control
  and echo arg
  echo arg
else; # comment
#! <- meta.function-call.name keyword.control.conditional meta.string.unquoted
#!  ^ meta.function-call.operator.control
#!    ^^^^^^^^^ comment.line
  echo arg
  if echo arg
    # comment
  else
#!    ^ meta.function-call.operator.control
  end
#! ^^ meta.function-call.name keyword.control.conditional
else
#! <- invalid.illegal.function-call
end # comment
#! <- meta.function-call.name keyword.control.conditional meta.string.unquoted
#!  ^^^^^^^^^ comment.line

if test
else if and true
#!      ^^^ keyword.operator.word
#!          ^^^^ variable.function
else \
#!   ^^ constant.character.escape
  if false
else if test &
#!           ^ invalid.illegal.function-call
  and test &# comment
#!         ^ keyword.operator.control
  echo arg
else cmd arg; echo &
#!   ^^^ invalid.illegal.string
#!       ^^^ invalid.illegal.string
#!            ^^^^ variable.function
end

if false # comment
#!       ^^^^^^^^^ comment.line
else if not true # comment
#!               ^^^^^^^^^ comment.line
else # comment
#!   ^^^^^^^^^ comment.line
end

if --foobar; else;
#! <- meta.function-call.name variable.function
#! ^^^^^^^^ meta.function-call.parameter.option.long
#!         ^ keyword.operator.control
#!           ^^^^ invalid.illegal.function-call

if # comment;end
#! <- variable.function
#! ^^^^^^^^^^^^^ comment.line

# This really works in fish!
if test
  else if --foobar
#!        ^^^^^^^^ variable.function
end

if \
#! ^ constant.character.escape
  test foo; end & # comment
#! ^^^ meta.block.if
#!        ^ keyword.operator.control
#!          ^^^ keyword.control.conditional
#!              ^ keyword.operator.control
#!                ^^^^^^^^^ comment.line

if if test
#! ^^ meta.block.if meta.block.if keyword.control.conditional
end
#! <- meta.block.if meta.block.if keyword.control.conditional
else if if test
#! <- meta.block.if keyword.control.conditional
#!   ^^ meta.block.if keyword.control.conditional
#!      ^^ meta.block.if meta.block.if keyword.control.conditional
end
#! <- meta.block.if meta.block.if keyword.control.conditional
else a&
#! <- meta.block.if keyword.control.conditional
#!   ^ invalid.illegal.string
#!    ^ invalid.illegal.function-call
else
#! <- invalid.illegal.function-call
end
#! <- meta.block.if keyword.control.conditional

# This executes without error
echo (if)
#!    ^^ variable.function
#!      ^ punctuation.section.parens.end

for arg arg in --foo bar ; break; end | cat
#!      ^^^ invalid.illegal.function-call
#!          ^^ keyword.control.conditional
#!             ^^^^^ meta.function-call.parameter.argument meta.string.unquoted
#!             ^^^^^ - variable.parameter
#!                   ^^^ meta.function-call.parameter.argument meta.string.unquoted
#!                     ^^^ meta.function-call
#!                         ^^^^^ keyword.control.conditional
#!                                    ^ meta.function-call.operator.pipe keyword.operator.pipe
#!                                      ^^^ variable.function

for a in b c d
#!            ^ meta.function-call.operator.control
end

for in in in in (seq 5) in in # comment
#! <- meta.block.for-in meta.function-call.name keyword.control.conditional meta.string.unquoted
#!^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call
#!  ^^ meta.function-call.parameter.argument
#!     ^^ meta.function-call.name keyword.control.conditional meta.string.unquoted
#!        ^^ meta.function-call.parameter.argument
#!           ^^ meta.function-call.parameter.argument
#!              ^^^^^^^ meta.function-call.parameter.argument meta.parens.command-substitution
#!                      ^^ meta.function-call.parameter.argument
#!                         ^^ meta.function-call.parameter.argument
#!                            ^^^^^^^^^ comment.line
  echo arg
#! ^^^ meta.function-call.name
  continue ;
#! ^^^^^^^ keyword.control.conditional meta.string.unquoted
#!         ^ keyword.operator.control
end
#! <- meta.function-call.name keyword.control.conditional meta.string.unquoted

for \
#! <- meta.block.for-in keyword.control.conditional
#!  ^ constant.character.escape
  varname \
#! ^^^^^^ meta.function-call.parameter.argument
#!        ^ constant.character.escape
  in \
#! ^ keyword.control.conditional
#!   ^ constant.character.escape
    (
#!  ^ meta.function-call.parameter.argument meta.parens.command-substitution
  echo \
#! ^^^ meta.function-call
  one two \
  three
) ;
#! <- meta.function-call.parameter.argument meta.parens.command-substitution
#!^ meta.function-call.operator.control
  echo arg arg
#! ^^^ meta.function-call.name
end
#! <- keyword.control.conditional

# This executes without error
echo (for)
#!    ^^^ variable.function
#!       ^ punctuation.section.parens.end

for # comment;end
#! <- variable.function
#!  ^^^^^^^^^^^^^ comment.line

# The second ')' and "end" are to catch the runaway scopes if needed
echo (for foo) end)
#!    ^^^ keyword.control.conditional
#!        ^^^ meta.function-call.parameter.argument
#!           ^ invalid.illegal.operator
#!             ^^^ keyword.control.conditional
echo (for foo in bar) end)
#!    ^^^ keyword.control.conditional
#!        ^^^ meta.function-call.parameter.argument
#!            ^^ keyword.control.conditional
#!               ^^^ meta.function-call.parameter.argument
#!                  ^ invalid.illegal.function-call
#!                    ^^^ keyword.control.conditional

switch value ; case wildcard ; command echo foo; end # comment
#! <- meta.block.switch meta.function-call.name keyword.control.conditional meta.string.unquoted
#! ^^^^^^^^^^^ meta.block.switch meta.function-call
#!           ^ meta.function-call.operator.control keyword.operator.control
#!             ^^^^^^^^^^^^^^^ meta.function-call
#!             ^^^^ meta.function-call.name keyword.control.conditional meta.string.unquoted
#!                           ^ meta.function-call.operator.control keyword.operator.control
#!                                             ^ keyword.operator.control
#!                                               ^^^ meta.block.switch meta.function-call.name keyword.control.conditional meta.string.unquoted
#!                                                   ^ comment.line

switch foo bar | echo &
#!     ^^^ meta.function-call.parameter.argument meta.string.unquoted
#!         ^^^ invalid.illegal.string
#!             ^ invalid.illegal.string
#!               ^^^^ invalid.illegal.string
#!                    ^ invalid.illegal.function-call
  case foo 2>| cmd >out & cmd # literally how fish highlights this
#!     ^^^ meta.function-call.parameter.argument meta.string.unquoted
#!         ^^^ invalid.illegal.function-call
#!             ^^^ variable.function
#!                 ^^^^ meta.function-call.operator.redirection
#!                      ^ keyword.operator.control
#!                        ^^^ variable.function
    echo arg
#!  ^^^^ variable.function
end | cat
#!  ^ meta.function-call.operator.pipe keyword.operator.pipe
#!    ^^^ variable.function

switch \-h
#!     ^^^ meta.function-call.parameter.argument meta.string.unquoted
#!     ^^^ - variable.parameter
#!        ^ meta.function-call.operator.control
  case -h
#!     ^^ meta.function-call.parameter.argument meta.string.unquoted
#!     ^^ - variable.parameter
#!       ^ meta.function-call.operator.control
    echo "-h" # Haha, this doesn't actually work
end

switch (echo $var)
#! <- meta.block.switch keyword.control.conditional
#!     ^^^^^^^^^^^ meta.block.switch meta.function-call.parameter.argument
  case foo baz # comment
#! ^^^ keyword.control.conditional
#!     ^^^ meta.function-call.parameter.argument
#!         ^^^ meta.function-call.parameter.argument
#!             ^^^^^^^^^ comment.line
    echo bar
  case bar
#! ^^^ keyword.control.conditional
#!     ^^^ meta.function-call.parameter.argument
    echo foo
end
#! <- keyword.control.conditional

switch \
# comment
"foo"
#! <- meta.block.switch meta.function-call.parameter.argument string.quoted.double
  case \
#! ^^^ keyword.control.conditional
  (echo foo)[] bar one two
#! ^^^^^^^^^^^ meta.function-call.parameter.argument
#!             ^^^ meta.function-call.parameter.argument
#!                 ^^^ meta.function-call.parameter.argument
    echo bar
  case '*'
#!     ^^^ meta.function-call.parameter.argument string.quoted.single
    echo arg
end
#! <- keyword.control.conditional

switch --help; case;
#! <- meta.function-call.name variable.function
#!     ^^^^^^ meta.function-call.parameter.option.long
#!           ^ keyword.operator.control
#!             ^^^^ invalid.illegal.function-call

switch--help arg
#! <- meta.function-call.name variable.function
#! ^^^^^^^^^ meta.function-call variable.function

# This executes without error
echo (switch)
#!    ^^^^^^ variable.function
#!          ^ punctuation.section.parens.end

switch # comment;end
#! <- variable.function
#!     ^^^^^^^^^^^^^ comment.line

function foo --arg="bar"
#! <- meta.block.function meta.function-call.name keyword.control.conditional meta.string.unquoted
#! ^^^^^^^^^^^^^^^^^^^^^^ meta.function-call
#!       ^^^ entity.name.function
#!           ^^^^^^^^^^^ meta.function-call.parameter.option.long
#!                      ^ meta.function-call.operator.control
  return 1
#! ^^^^^ keyword.control.conditional meta.string.unquoted
  echo arg
#! ^^^^^^^ meta.function-call
end
#! <- meta.function-call.name keyword.control.conditional meta.string.unquoted

function \
#! <- meta.block.function keyword.control.conditional
#!       ^ constant.character.escape
foo\ bar \
#! <- entity.name.function
#!       ^ constant.character.escape
  arg1 \
#! ^^^ meta.function-call.parameter.argument
  arg2 # comment
#! ^^^ meta.function-call.parameter.argument
#!     ^^^^^^^^^ comment.line
  echo arg
#! ^^^^^^^ meta.function-call
end
#! <- keyword.control.conditional

function inline; echo arg; end # comment
#! <- meta.block.function keyword.control.conditional
#!       ^^^^^^ entity.name.function
#!             ^ meta.function-call.operator.control keyword.operator.control
#!                       ^ keyword.operator.control
#!                             ^^^^^^^^^ comment.line

function $cmd>out
#!       ^^^^ entity.name.function meta.variable-expansion variable.other
#!           ^ invalid.illegal.function-call
  return 0
end

function fo(echo "ooba")r
#!       ^^^^^^^^^^^^^^^^ meta.function-call.parameter.argument entity.name.function
#!         ^^^^^^^^^^^^^ meta.parens.command-substitution
  return (echo 1)
end; foobar

function foo | bar;  end
#!           ^ invalid.illegal.function-call

function (echo f)oo)bar 2> & | --arg ; end
#!       ^^^^^^^^ meta.function-call.parameter.argument entity.name.function meta.parens.command-substitution
#!                 ^ invalid.illegal.function-call
#!                      ^^ invalid.illegal.function-call
#!                         ^ invalid.illegal.function-call
#!                           ^ invalid.illegal.function-call

function '$cmd$'; echo $argv; end; $cmd$ arg1 arg2
#!       ^^^^^^ entity.name.function
#!                               ^ keyword.operator.control
#!                                 ^^^^^ variable.function
#!                                       ^^^^ meta.function-call.parameter.argument

function foo\
bar
#! <- entity.name.function
  body
end

function ~name --argument a -b c; end
#! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.function-call
#!       ^ - keyword.operator.tilde

# This executes without error
echo (function)
#!    ^^^^^^^^ variable.function
#!            ^ punctuation.section.parens.end

function # comment;end
#! <- variable.function
#!       ^^^^^^^^^^^^^ comment.line