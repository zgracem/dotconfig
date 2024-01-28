#!/usr/bin/env fish

switch $argv[1]
    case '*.pdf'
        exec pdftotext $argv[1] -
    case '*.jpg' '*.gif' '*.png'
        exec ocr-cli --accurate --language-correction $argv[1]
    case '*'
        exec cat $argv
end
