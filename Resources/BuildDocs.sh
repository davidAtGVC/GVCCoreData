#! /bin/sh

/usr/local/bin/appledoc \
--project-name "GVCCoreData" \
--project-company "Global Village Consulting" \
--company-id "net.global-village" \
--docset-atom-filename "GVCCoreData.atom" \
--docset-feed-url "http://global-village.net/GVCCoreData/%DOCSETATOMFILENAME" \
--docset-package-url "http://global-village.net/GVCCoreData/%DOCSETPACKAGEFILENAME" \
--docset-fallback-url "http://global-village.net/GVCCoreData/" \
--output "~/help" \
--publish-docset \
--logformat xcode \
--keep-undocumented-objects \
--keep-undocumented-members \
--keep-intermediate-files \
--no-repeat-first-par \
--no-warn-invalid-crossref \
--ignore "*.m" \
--index-desc "${PROJECT_DIR}/Resources/Licenses/GVC License.md" \
"${PROJECT_DIR}/GVCCoreData"
