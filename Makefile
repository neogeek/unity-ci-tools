update:
	node utils/editor-installers-update.js
	git diff data/editor-installers.json && ./utils/commit-changes.sh
