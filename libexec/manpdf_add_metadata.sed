#!/usr/bin/sed -f

# Set PDF Title metadata from the man page's nicely-formatted title
# based on args to the man(7) `.TH` or mdoc(7) `.Dt` macro
s#^\.(TH|Dt) "?(\S+)"? "?(\S+)"?#.pdfinfo /Title \L\2(\3)\E\n&#g;

# Set PDF Subject metadata to the man page's short description
# - First try: from the line after the `.SH NAME` man macro
/^\.SH "?NAME"?/{n;s#^[^[:space:]]+ \\?- (.+)$#&\n.pdfinfo /Subject \1#g;};
# - Second try: from args to the `.Nd` mdoc macro
s#^\.Nd (.+)$#&\n.pdfinfo /Subject \1#g;

# Create 1st-level bookmarks for all 1st-level headings
# from all `.Sh` (mdoc) or `.SH` (man) macros
s#^\.S[hH] (.+)$#.pdfbookmark 1 \1\n&#g;

# Create 2nd-level bookmarks for all 2nd-level headings from all `.SS` macros
s#^\.SS (.+)$#.pdfbookmark 2 \1\n&#g;

# Set PDF options at top of file:
# - .pdfview /PageMode /UseOutlines <- Show bookmarks panel when opened
# -          /Page 1                <- Open to first page
# -          /View [/Fit]           <- Zoom to fit page to window
# - .nr PDFOUTLINE.FOLDLEVEL 1      <- Collapse all nested bookmarks
# - .nr PDFHREF.VIEW.LEADING 30.0p  <- Set bookmark targets 30 points
#                                      above the text so the window won't
#                                      cut it off
1s#.*#.pdfview /PageMode /UseOutlines /Page 1 /View [/Fit]\n.nr PDFOUTLINE.FOLDLEVEL 1\n.nr PDFHREF.VIEW.LEADING 30.0p\n&#;

# Call the `.pdfsync` macro to apply the metadata commands
$s#.*#&\n.pdfsync#;
