#!/bin/bash
apt-get update
apt-get -y install python-pip python-dev
pip install tornado
cat >app.py <<EOL
import tornado.ioloop
import tornado.web

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write('Hello, world')

def make_app():
    return tornado.web.Application([
        (r'/.*', MainHandler),
    ])

if __name__ == "__main__":
    app = make_app()
    app.listen(54321)
    app2 = make_app()
    app2.listen(4321)
    tornado.ioloop.IOLoop.current().start()
EOL
nohup python app.py &
