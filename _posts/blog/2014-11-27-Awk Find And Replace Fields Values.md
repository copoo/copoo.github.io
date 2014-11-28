---
layout: post
title: Awk 替换 Field
description: 
category: blog
---

have a data as follows :
	
	foo bar 12,300.50
	foo bar 2,300.50
	abc xyz 1,22,300.50

How do I replace all , from 3rd field using awk and pass output to bc -l in the following format to get sum of all numbers:

    12300.50+2300.50+1,22,300.50


You can use gsub() funcion as follows. The syntax is:
	
	gsub("find", "replace")
	gsub("find-regex", "replace")
	gsub("find-regex", "replace", t)
	gsub(r, s [, t])

From the awk man page:

For each substring matching the regular expression r in the string t, substitute the string s, and return the number of substitutions. If t is not supplied, use $0. An & in the replacement text is replaced with the text that was actually matched. Use \& to get a literal &.

You can also use the following syntax:

    gensub(r, s, h [, t])

From the awk man page:

Search the target string t for matches of the regular expression r. If h is a string beginning with g or G, then replace all matches of r with s. Otherwise, h is a number indicating which match of r to replace. If t is not supplied, $0 is used instead. Within the replacement text s, the sequence \n, where n is a digit from 1 to 9, may be used to indicate just the text that matched the n'th parenthesized subexpression. The sequence \0 represents the entire matched text, as does the character &. Unlike sub() and gsub(), the modified string is returned as the result of the function, and the original target string is not changed.

Example

Create a data file cat /tmp/data.txt

	foo 	bar	12,300.50
	foo	bar	2,300.50
	abc	xyz	1,22,300.50
Type the following awk command:

 
	awk '{ gsub(",","",$3); print $3 }' /tmp/data.txt
 
Sample outputs:

	12300.50
	2300.50
	122300.50

You can pass the output to any command or calculate sum of the fields:

 
	awk 'BEGIN{ sum=0} { gsub(",","",$3); sum += $3 } END{ printf "%.2f\n", sum}' /tmp/data.txt
 
OR build the list and pass to the bc -l:

	awk '{ x=gensub(",","","G",$3); printf x "+" } END{ print "0" }' /tmp/data.txt   | bc -l

[Andy阿离]:    http://copoo.github.io  "Andy阿离"
