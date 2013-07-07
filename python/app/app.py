## Creating a basic web server in python without
## any external modules or dependencies

import os
import SimpleHTTPServer
import SocketServer

PORT = 80
IP = "0.0.0.0"

## 'SimpleHTTPRequestHeader' is setup to serve up any
## files located in the current directory
Handler = SimpleHTTPServer.SimpleHTTPRequestHandler

httpd = SocketServer.TCPServer((IP, PORT), Handler)

print "serving at port: ", PORT
httpd.serve_forever()