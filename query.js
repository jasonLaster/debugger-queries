var gcloud = require('google-cloud');
var bigquery = gcloud.bigquery;

var bigqueryClient = bigquery({
  projectId: 'lateral-now-156717',
  keyFilename: 'api-key.json'
});


// var job = bigqueryClient.job('156717:62b4521aec8fe13ad75560a2b41b2f95_2_1488619135751');
// debugger
// // Use a callback.
// job.getQueryResults(function(err, rows) {
//   console.log(rows)
// });

var query = 'SELECT * FROM [dbg:2016_activity] LIMIT 100';

bigquery.prototype.createQueryStream(query)
  .on('error', console.error)
  .on('data', function(row) {
    debugger
    // row is a result from your query.
  })
  .on('end', function() {
    debugger
    // All rows retrieved.
  });
