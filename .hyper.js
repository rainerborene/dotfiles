module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 11,

    // font family with optional fallbacks
    fontFamily: '"Menlo for Powerline", "Literation Mono Powerline", monospace',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: '#7587a6',

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BLOCK',

    // color of the text
    foregroundColor: '#a7a7a7',

    // terminal background color
    backgroundColor: '#1e1e1e',

    // border color (window, tabs)
    borderColor: '#333',

    // custom css to embed in the main window
    css: `
      .terms_terms { border-top: 1px solid #333 }
      .header_header * { font: bold 10px/34px "Menlo for Powerline", "DejaVu Sans Mono" }
    `,

    // custom css to embed in the terminal window
    termCSS: '',

    // set to `true` if you're using a Linux set up
    // that doesn't shows native menus
    // default: `false` on Linux, `true` on Windows (ignored on macOS)
    showHamburgerMenu: '',

    // set to `false` if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` on windows and Linux (ignored on macOS)
    showWindowControls: '',

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: '0px 4px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#1e1e1e',
      red: '#cf6a4d',
      green: '#8f9d6a',
      yellow: '#f9ee98',
      blue: '#7587a6',
      magenta: '#9b859d',
      cyan: '#afc4db',
      white: '#a7a7a7',
      lightBlack: '#5f5a60',
      lightRed: '#cda869',
      lightGreen: '#323537',
      lightYellow: '#464b50',
      lightBlue: '#838184',
      lightMagenta: '#c3c3c3',
      lightCyan: '#9b703f',
      lightWhite: '#ffffff'
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: '',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to false for no bell
    bell: false,

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: false

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: []
};
