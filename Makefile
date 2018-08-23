update:
	node utils/editor-installers-update.js
	git diff --quiet data/editor-installers.json || ./utils/commit-changes.sh
