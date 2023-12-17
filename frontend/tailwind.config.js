
const Path = require("path");
const pwd = process.env.PWD;
const projectPaths = [
  Path.join(pwd, "../blog_cms/templates/**/*.html"),
  Path.join(pwd, "../apps/*/templates/**/*.html"),
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
