let febPRs = require("./data/february_prs.json");
let marchPRs = require("./data/march_prs.json");

let prs = febPRs.concat(marchPRs)

let titles = [];
let urls = [];

const startDate = new Date("3/1/2017");
const endDate = new Date("3/6/2017");

prs = prs.filter(pr => {
  const d = new Date(pr.date)
  return d >= startDate && d <= endDate
}).filter(pr => {
  return !pr.login.match(/greenkeeper/i)
})

prs.forEach((pr, index) => {
  titles.push(`* ${pr.date} [${pr.title}][pr-${index}] - [@${pr.login}]`)
  urls.push(`[pr-${index}]:${pr.url}`)
})

function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}



const authors = prs.map(pr => pr.login)
  .filter(onlyUnique)
  .map(author => `${author}`)

const authorLinks = authors
  .map(author => `[@${author}]:http://github.com/${author}`)

const authorList = authors.map(author => `[@${author}]`).join(", ")

console.log(authorList)
console.log(titles.join("\n"))
console.log(urls.join("\n"))
console.log(authorLinks.join("\n"))

/*

[my pr][pr-1]


[pr-1]:http:///github...../prs
*/
