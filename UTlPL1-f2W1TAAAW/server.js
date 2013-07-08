var express = require("express")
  , request = require("request")
  , qs = require("qs")
  , app = express();

// Define API credentials callback URL
var callbackURL = "http://" + process.env.APP_DNS + "/callback"
  , CLIENT_ID = 'GOOGLE_CLIENT_ID'
  , CLIENT_SECRET = 'GOOGLE_CLIENT_SECRET';

// Setup middleware
app.use(express.static(__dirname));

// Initialize our oauth variables used to store access_token and related data
var state = ''
  , access_token = ''
  , token_type = ''
  , expires = '';


// Start the OAuth flow by generating a URL that the client (index.html) opens
// as a popup. The URL takes the user to Google's site for authentication
app.get("/login", function(req, res) {


    // Generate a unique number that will be used to check if any hijacking
    // was performed during the OAuth flow
    state = Math.floor(Math.random() * 1e18);

    var params = {
        response_type: "code",
        client_id: CLIENT_ID,
        redirect_uri: callbackURL,
        state: state,
        display: "popup",
        scope: "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email"
    };

    params = qs.stringify(params);
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end("https://accounts.google.com/o/oauth2/auth?" + params);
});

// The route that Google will redirect the popup to once the user has authed.
// The data passed back will be used to retrieve the access_token
app.get("/callback", function(req, res) {

    // Collect the data contained in the querystring
    var code = req.query.code
      , cb_state = req.query.state
      , error = req.query.error;

    // Verify the 'state' variable generated during '/login' equals what was passed back
    if (state == cb_state) {
        if (code !== undefined) {

            // Setup params and URL used to call API to obtain an access_token
            var params = {
                code: code,
                client_id: CLIENT_ID,
                client_secret: CLIENT_SECRET,
                redirect_uri: callbackURL,
                grant_type: "authorization_code"
            };
            var url = "https://accounts.google.com/o/oauth2/token";

            // Send the API request
            request.post(url, {form: params}, function(err, resp, body) {

                // Handle any errors that may occur
                if (err) return console.error("Error occured: ", err);
                var results = JSON.parse(body);
                if (results.error) return console.error("Error returned from Google: ", results.error);

                // Retrieve and store access_token to session
                access_token = results.access_token;
                token_type = results.token_type;
                expires = results.expires_in;

                console.log("Connected to Google");

                // Close the popup. This will trigger the client (index.html) to redirect
                // to '/user' which will test out the access_token.
                var output = '<html><head></head><body onload="window.close();">Close this window</body></html>';
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.end(output);
            });
        } else {
            console.log("Code is undefined: " + code);
            console.log("Error: " + error);
        }
    } else {
        console.log('Mismatch with variable "state". Redirecting to /');
        res.redirect("/");
    }
});

// Test out the access_token by making an API call
app.get("/user", function(req, res) {

    // Check to see if user as an access_token first
    if (access_token) {

        // URL endpoint and params needed to make the API call
        var url = "https://www.googleapis.com/oauth2/v1/userinfo";
        var params = {
            access_token: access_token
        };

        // Send the request
        request.get({url: url, qs: params}, function(err, resp, user) {
            // Check for errors
            if (err) return console.error("Error occured: ", err);

            // Send output as response
            var output = "<h1>Your User Details</h1><pre>" + user + "</pre>";
            res.writeHead(200, {'Content-Type': 'text/html'});
            res.end(output);
        });
    } else {
        console.log("Couldn't verify user was authenticated. Redirecting to /");
        res.redirect("/");
    }
});


app.listen(80);