@echo off
echo Just a moment, please!
echo I'm processing...

set SAXON_DIR=C:\Saxonica\

set CLASSPATH=%SAXON_DIR%lib;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9he.jar;%CLASSPATH%
set CLASSPATH=%SAXON_DIR%lib\saxon9-xqj.jar;%CLASSPATH%

if exist output rmdir output /s /q >NUL

@echo off
rem rem rem rem rem ********* idml_import.xml **********
rem java net.sf.saxon.Transform -o:temp\01-simplified.xml -s:resource\mergedXML.xml -xsl:xsls\01-simplify.xsl
rem java net.sf.saxon.Transform -o:temp\02-simplify.xml -s:temp\01-simplified.xml -xsl:xsls\02-simplify.xsl
rem java net.sf.saxon.Transform -o:temp\03-simplify.xml -s:temp\02-simplify.xml -xsl:xsls\03-simplify.xsl
rem java net.sf.saxon.Transform -o:temp\04-identified.xml -s:temp\03-simplify.xml -xsl:xsls\04-identity.xsl
rem java net.sf.saxon.Transform -o:temp\05-url-detected.xml -s:temp\04-identified.xml -xsl:xsls\05-detect-url.xsl
rem java net.sf.saxon.Transform -o:temp\06-assigned-headings.xml -s:temp\05-url-detected.xml -xsl:xsls\06-headings.xsl
rem java net.sf.saxon.Transform -o:temp\07-assigned-sections.xml -s:temp\06-assigned-headings.xml -xsl:xsls\07-sections.xsl
rem java net.sf.saxon.Transform -o:temp\08-splited-br.xml -s:temp\07-assigned-sections.xml -xsl:xsls\08-split-br.xsl
rem java net.sf.saxon.Transform -o:temp\09-topicalized.xml -s:temp\08-splited-br.xml -xsl:xsls\09-topicalize.xsl

rem rem rem rem rem ********* topic_hierarchy.xml ***********
rem java net.sf.saxon.Transform -o:temp\10-tree-structured.xml -s:temp\09-topicalized.xml -xsl:xsls\10-tree-structure.xsl
java net.sf.saxon.Transform -o:temp\11-inserted-id-float.xml -s:temp\10-tree-structured.xml -xsl:xsls\11-insert-id-float.xsl
java net.sf.saxon.Transform -o:temp\12-replaced-link-id.xml -s:temp\11-inserted-id-float.xml -xsl:xsls\12-replace-link-id.xsl
java net.sf.saxon.Transform -o:temp\13-nested-note-child.xml -s:temp\12-replaced-link-id.xml -xsl:xsls\13-nest-note-child.xsl
java net.sf.saxon.Transform -o:temp\14-merged-ul2-note.xml -s:temp\13-nested-note-child.xml -xsl:xsls\14-merge-ul2-note.xsl
java net.sf.saxon.Transform -o:temp\15-nested-ul2-note.xml -s:temp\14-merged-ul2-note.xml -xsl:xsls\15-nest-ul2-note.xsl
java net.sf.saxon.Transform -o:temp\16-nested-img-table-between-ul1-notes.xml -s:temp\15-nested-ul2-note.xml -xsl:xsls\16-nest-img-table-between-ul1-notes.xsl
java net.sf.saxon.Transform -o:temp\17-merged-ul1-note.xml -s:temp\16-nested-img-table-between-ul1-notes.xml -xsl:xsls\17-merge-ul1-note.xsl
java net.sf.saxon.Transform -o:temp\18-grouped-nested-img-table.xml -s:temp\17-merged-ul1-note.xml -xsl:xsls\18-group-nested-img-table.xsl
java net.sf.saxon.Transform -o:temp\19-nested-group-img-table.xml -s:temp\18-grouped-nested-img-table.xml -xsl:xsls\19-nest-group-img-table.xsl
java net.sf.saxon.Transform -o:temp\20-nested-description-2-3-4.xml -s:temp\19-nested-group-img-table.xml -xsl:xsls\20-nest-description-2-3-4.xsl
java net.sf.saxon.Transform -o:temp\21-nested-step-description-note.xml -s:temp\20-nested-description-2-3-4.xml -xsl:xsls\21-nest-step-description-note.xsl
java net.sf.saxon.Transform -o:temp\22-nested-step-ul2-note.xml -s:temp\21-nested-step-description-note.xml -xsl:xsls\22-nest-step-ul2-note.xsl
java net.sf.saxon.Transform -o:temp\23-nested-step-ul1-note.xml -s:temp\22-nested-step-ul2-note.xml -xsl:xsls\23-nest-step-ul1-note.xsl
java net.sf.saxon.Transform -o:temp\24-nest-Step-UL1_2.xml -s:temp\23-nested-step-ul1-note.xml -xsl:xsls\24-nest-Step-UL1_2.xsl
java net.sf.saxon.Transform -o:temp\24-merged-step-ul1-2.xml -s:temp\24-nest-Step-UL1_2.xml -xsl:xsls\24-merge-step-ul1-2.xsl
java net.sf.saxon.Transform -o:temp\25-nested-ul1-2-3.xml -s:temp\24-merged-step-ul1-2.xml -xsl:xsls\25-nest-ul1-2-3.xsl
java net.sf.saxon.Transform -o:temp\26-nested-between-colors.xml -s:temp\25-nested-ul1-2-3.xml -xsl:xsls\26-nest-between-colors.xsl
java net.sf.saxon.Transform -o:temp\27-grouped-nested-ol-color.xml -s:temp\26-nested-between-colors.xml -xsl:xsls\27-group-nested-ol-color.xsl
java net.sf.saxon.Transform -o:temp\28-nested-group-ol-colors.xml -s:temp\27-grouped-nested-ol-color.xml -xsl:xsls\28-nest-group-ol-colors.xsl
java net.sf.saxon.Transform -o:temp\29-nested-ul2-caution-warning.xml -s:temp\28-nested-group-ol-colors.xml -xsl:xsls\29-nest-ul2-caution-warning.xsl
java net.sf.saxon.Transform -o:temp\30-merged-ul1-caution-warning.xml -s:temp\29-nested-ul2-caution-warning.xml -xsl:xsls\30-merge-ul1-caution-warning.xsl
java net.sf.saxon.Transform -o:temp\31-nested-between-cmd-ols.xml -s:temp\30-merged-ul1-caution-warning.xml -xsl:xsls\31-nest-between-cmd-ols.xsl
java net.sf.saxon.Transform -o:temp\32-grouped-step-cmd-ols.xml -s:temp\31-nested-between-cmd-ols.xml -xsl:xsls\32-group-step-cmd-ols.xsl
java net.sf.saxon.Transform -o:temp\33-nested-between-ol-whites.xml -s:temp\32-grouped-step-cmd-ols.xml -xsl:xsls\33-nest-between-ol-whites.xsl
java net.sf.saxon.Transform -o:temp\34-grouped-ol-whites.xml -s:temp\33-nested-between-ol-whites.xml -xsl:xsls\34-group-ol-whites.xsl
java net.sf.saxon.Transform -o:temp\35-unwrapped-maginifer.xml -s:temp\34-grouped-ol-whites.xml -xsl:xsls\35-unwrap-magnifier.xsl
java net.sf.saxon.Transform -o:temp\36-reverted-headings.xml -s:temp\35-unwrapped-maginifer.xml -xsl:xsls\36-revert-headings.xsl
java net.sf.saxon.Transform -o:temp\37-wrapped-div-h1-h2-faq.xml -s:temp\36-reverted-headings.xml -xsl:xsls\37-wrap-div-h1-h2-faq.xsl
java net.sf.saxon.Transform -o:temp\37_1-warning-group.xml -s:temp\37-wrapped-div-h1-h2-faq.xml -xsl:xsls\37_1-warning-group.xsl
java net.sf.saxon.Transform -o:temp\37_2-warning-group-nest.xml -s:temp\37_1-warning-group.xml -xsl:xsls\37_2-warning-group-nest.xsl
java net.sf.saxon.Transform -o:temp\38-created-topic-map.xml -s:temp\37_2-warning-group-nest.xml -xsl:xsls\38-create-topic-map.xsl
java net.sf.saxon.Transform -o:resource\toc-base.xml -s:temp\38-created-topic-map.xml -xsl:xsls\39-make-toc-base.xsl
java net.sf.saxon.Transform -o:resource\html-base.xml -s:temp\37_2-warning-group-nest.xml -xsl:xsls\40-make-html-base.xsl
rem rem rem rem rem rem ***************************************************************************
java net.sf.saxon.Transform -o:temp\dummy.xml -s:resource\html-base.xml -xsl:xsls\42-split-into-html.xsl
java net.sf.saxon.Transform -o:temp\dummy.xml -s:resource\toc-base.xml -xsl:xsls\43-make-toc.xsl
java net.sf.saxon.Transform -o:temp\dummy.xml -s:resource\toc-base.xml -xsl:xsls\44-make-index.xsl
java net.sf.saxon.Transform -o:temp\dummy.xml -s:resource\html-base.xml -xsl:xsls\45-make-search-json.xsl
java net.sf.saxon.Transform -o:temp\dummy.xml -s:resource\html-base.xml -xsl:xsls\46-make-id-db-json.xsl
java net.sf.saxon.Transform -o:temp\dummy.xml -s:resource\toc-base.xml -xsl:xsls\47-make-mini-toc.xsl
java net.sf.saxon.Transform -o:temp\dummy.xml -s:resource\toc-base.xml -xsl:xsls\48-make-search-html.xsl
java net.sf.saxon.Transform -o:temp\dummy.xml -s:resource\ui_text.xml -xsl:xsls\49-make-ui_text-json.xsl



rem if exist temp rd /q/s temp

pause
