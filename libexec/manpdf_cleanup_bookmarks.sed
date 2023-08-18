#!/usr/bin/sed -f

# Removes unsightly and unnecessary escape sequences from bookmark titles. These
# sequences aren't present to be removed until the previous sed script is
# complete [test case: zshall(1)].
/^\.pdfbookmark/s#\\?f([BIRP]|\[[CRV]?\])##g;
/^\.pdfbookmark/s#\\s-?[0-9]##g;
/^\.pdfbookmark/s#\\##g;
/^\.pdfbookmark/s#\\\?\\[[ac]q\\]#\'#g;
