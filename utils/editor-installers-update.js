const { writeFileSync } = require('fs');

const { fetch } = require('raspar');

const { JSDOM } = require('jsdom');

const UNITY_VERSION_PATTERN = /[0-9]{1,4}\.[0-9]+\.[0-9a-z]+/;
const UNITY_EDITOR_PATTERN = /Unity Editor/;

fetch('https://unity3d.com/get-unity/download/archive').then(({ body }) => {
    const { document } = new JSDOM(body).window;
    const editorInstallers = [].slice
        .call(document.querySelectorAll('.version a[href*="unityhub"]'))
        .filter(elem => elem.getAttribute('href').match(UNITY_VERSION_PATTERN))
        .reduce((acc, elem) => {
            const version = elem
                .getAttribute('href')
                .match(UNITY_VERSION_PATTERN)[0];

            const links = [].slice
                .call(elem.parentNode.parentNode.querySelectorAll('.options a'))
                .filter(elem => elem.innerHTML.match(UNITY_EDITOR_PATTERN))
                .map(elem => elem.getAttribute('href'));

            if (!acc[version]) {
                acc[version] = {};
            }

            links.map(url => {
                if (url.match(/.(dmg|pkg)$/)) {
                    acc[version].mac = url;
                } else if (url.match(/Windows64/)) {
                    acc[version].win64 = url;
                } else if (url.match(/Windows32/)) {
                    acc[version].win32 = url;
                }
            });
            return acc;
        }, {});
    writeFileSync(
        `${__dirname}/../data/editor-installers.json`,
        `${JSON.stringify(editorInstallers, null, 4)}\n`
    );
});
