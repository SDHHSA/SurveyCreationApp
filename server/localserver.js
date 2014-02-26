// configure API
var express = require('express')
  , app = express() 
  , MongoClient = require('mongodb').MongoClient
  , cors = require('express-cors')

app.use(express.bodyParser());

MongoClient.connect('mongodb://127.0.0.1:27017/sandboxdb', function(err, db) {
    if (err) { throw err; }
    app.use(express.bodyParser());
    app.use(cors({
    allowedOrigins: [
        // add CORS exceptions here
          ]
      })); 
 
    // default route does nothing
    app.get('/', function(req, res) {
        res.write('welcome to proj 0.0.1');
        res.end();
    });
    
    app.post('/surveyadd', function(req, res) {
      var document = req.body;
      console.log(document);
      db.collection("surveys", function(err, collection) {
        if (err) {throw err};
        collection.insert(document, function(err, response) {
          if (err) {throw err}; res.end();
        });
      });
    });

    app.get('/surveyget', function(req, res) {
      db.collection("surveys", function(err, collection){
            if (err) {
                console.log(err);
                res.write(500);
                return res.end(err); 
            }
            collection.find().toArray(function(err, results) {
                if (err) {
                    console.log(err);
                    res.write(500);
                    return res.end(err); 
                }
                res.write(JSON.stringify(results));
                res.end();
              });    
        });  
    });

    app.listen(1230);
    console.log('Express server now listening port 1230');
    //});
});