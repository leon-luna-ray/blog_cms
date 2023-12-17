
const Path = require("path");
const pwd = process.env.PWD;
const projectPaths = [
  Path.join(pwd, "../blog_cms/templates/**/*.html"),
  Path.join(pwd, "../apps/**/templates/**/*.html"),
  // add js file paths if you need
];

const contentPaths = [...projectPaths];
console.log(`tailwindcss will scan ${contentPaths}`);
module.exports = {
  content: contentPaths,
  theme: {
    extend: {},
  },
  plugins: [],
}
