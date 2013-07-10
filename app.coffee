# Require those modules
connect = require "connect"
http = require "http"
limiter = require "connect-ratelimit"
fs = require "fs"

# Configure those variables
PORT = process.env.PORT or 8000
INTRO_HTML = fs.readFileSync("intro.html", "utf8") # yeah that's right I used
OUTRO_HTML = fs.readFileSync("outro.html", "utf8") # sync. fuck the police

# Start that app
app = connect()

# Use that middleware
app.use limiter()

# Send that response TODO
app.use (req, res) ->
  body = INTRO_HTML + OUTRO_HTML
  res.writeHead(200, { "Content-Type": "text/html"})
  res.end body

# Start that server
http.createServer(app).listen(PORT)