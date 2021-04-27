#!/usr/bin/env python3
"""
Amazon captcha resolver web service
Usage::
    ./server.py [<port>]
"""
from http.server import BaseHTTPRequestHandler, HTTPServer
from amazoncaptcha import AmazonCaptcha
import logging

class S(BaseHTTPRequestHandler):
    def _set_response(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/plain')
        self.end_headers()

    def do_GET(self):
        self._set_response()
        captcha = AmazonCaptcha.fromlink(self.path[1:])
        solution = captcha.solve()
        self.wfile.write(solution.encode('utf-8'))

def run(server_class=HTTPServer, handler_class=S, port=8080):
    logging.basicConfig(level=logging.INFO)
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    logging.info('Starting amzncaptcha...\n')
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    logging.info('Stopping amzncaptcha...\n')

if __name__ == '__main__':
    from sys import argv
    if len(argv) == 2:
        if argv[1] == "version":
            print("0.5.0")
        else:
            run(port=int(argv[1]))
    else:
        run()
