const { writeFileSync } = require('fs');

const { fetch } = require('raspar');

const { JSDOM } = require('jsdom');

const UNITY_VERSION_PATTERN = /[0-9]{1,4}\.[0-9]+\.[0-9a-z]+/;

fetch('https://unity3d.com/get-unity/download/archive').then(({ body }) => {
    const { document } = new JSDOM(body).window;
    const editorInstallers = [].slice
        .call(
            document.querySelectorAll(
                '.archive .row .options a[href*="EditorInstaller"]'
            )
        )
        .map(elem => elem.getAttribute('href'))
        .reduce((acc, url) => {
            const version = url.match(UNITY_VERSION_PATTERN)[0];

            if (!acc[version]) {
                acc[version] = {};
            }

            if (url.match(/MacEditor/)) {
                acc[version].mac = url;
            } else if (url.match(/Windows64/)) {
                acc[version].win64 = url;
            } else if (url.match(/Windows32/)) {
                acc[version].win32 = url;
            }

            return acc;
        }, {});
    writeFileSync(
        `${__dirname}/../data/editor-installers.json`,
        `${JSON.stringify(editorInstallers, null, 4)}\n`
    );
});
