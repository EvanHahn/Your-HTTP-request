# Require those modules
connect = require "connect"
http = require "http"
limiter = require "connect-ratelimit"
fs = require "fs"
explanations = require "./explanations.json"
require "sugar"

# Configure those variables
PORT = process.env.PORT or 8000
INTRO_HTML = fs.readFileSync("intro.html", "utf8") # yeah that's right I used
OUTRO_HTML = fs.readFileSync("outro.html", "utf8") # sync. fuck the police
REQ_PROPERTIES = ["url", "method", "statusCode"]
HEADER_PROPERTIES = ["host", "connection", "cache-control", "accept", "user-agent", "dnt", "accept-encoding", "accept-language"]

# Start that app
app = connect()

# Use that middleware
app.use limiter()

# Spit out that table row
row = (key, value) ->
  return "" unless value?
  """<tbody><tr>
    <td>#{key}</td>
    <td>#{value}</td>
    <td>#{explanations[key] or "N/A"}</td>
  </tr></tbody>"""

# Send that response
app.use (req, res) ->

  body = ""

  REQ_PROPERTIES.each (key) ->
    body += row(key, req[key])

  HEADER_PROPERTIES.each (key) ->
    body += row(key, req.headers[key])

  res.writeHead(200, { "Content-Type": "text/html"})
  res.end INTRO_HTML + body + OUTRO_HTML

# Start that server
http.createServer(app).listen(PORT)
