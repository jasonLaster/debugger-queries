// let febPRs = require('./data/february_prs.json');
// let marchPRs = require('./data/march_prs.json');

const parse = require("csv-parse");
fs = require("fs");

const text = fs.readFileSync("data/prs.csv", "utf8");
const records = parse(text, { columns: true }, (err, prs) => {
  console.log(filterPRs(prs).length);
  mapData(filterPRs(prs));
});
// let prs = febPRs.concat(marchPRs);
//

const startDate = new Date("6/6/2017");
const endDate = new Date("6/13/2017");

function onlyUnique(value, index, self) {
  return self.indexOf(value) === index;
}

function filterPRs(prs) {
  return prs
    .filter(pr => {
      const d = new Date(pr.date);
      return d >= startDate && d <= endDate;
    })
    .filter(pr => {
      return !pr.login.match(/greenkeeper/i);
    });
}

function mapData(prs) {
  let titles = [];
  let urls = [];

  prs.forEach((pr, index) => {
    titles.push(`* [${pr.title}][pr-${index}] - [@${pr.login}]`);
    urls.push(`[pr-${index}]:${pr.url}`);
  });

  const authors = prs
    .map(pr => pr.login)
    .filter(onlyUnique)
    .map(author => `${author}`);

  const authorLinks = authors.map(
    author => `[@${author}]:http://github.com/${author}`
  );

  const authorList = authors.map(author => `[@${author}]`).join(", ");

  console.log(authorList);
  console.log(titles.join("\n"));
  console.log(urls.join("\n"));
  console.log(authorLinks.join("\n"));
}
