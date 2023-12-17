
const Path = require("path");
const pwd = process.env.PWD;
const projectPaths = [
  Path.join(pwd, "../blog_cms/templates/**/*.html"),
  Path.join(pwd, "../apps/*/templates/**/*.html"),
];

const contentPaths = [...projectPaths];

module.exports = {
  content: contentPaths,
  darkMode: 'class',
  theme: {
    container: {
      padding: {
        DEFAULT: '1.5rem',
        md: '2rem',
        lg: '4rem',
      },
      center: true,
    },
    extend: {
      colors: {
        primary: '#e00097',
      },
      // fontFamily: {
      //   dm: ['DM Sans', 'sans-serif'],
      //   lora: ['Lora', 'serif'],
      //   orbitron: ['Orbitron', 'sans-serif'],
      // },
    },
  },
  plugins: [],
}
