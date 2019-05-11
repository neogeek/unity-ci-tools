test:
	shellcheck bin/auth.sh bin/deauth.sh bin/install.sh bin/test.sh

update:
	node utils/editor-installers-update.js
	git diff --quiet data/editor-installers.json || ./utils/commit-changes.sh
