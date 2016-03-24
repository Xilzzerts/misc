__author__ = 'Zirconi'

import tornado.web
import tornado.ioloop
import tornado.httpserver


class IndexHandler(tornado.web.RequestHandler):
    def get(self, *args, **kwargs):
        self.write("NO GET")

    def post(self, *args, **kwargs):
        # self.write(self.request)
        print(self.request)
        print(self.request.body)
        file_metas = self.request.files["file"]
        if file_metas:
            for meta in file_metas:
                filename = meta["filename"]
                filepath = "./" + filename
                with open(filepath, "wb") as f:
                    f.write(meta["body"])


if __name__ == "__main__":
    app = tornado.web.Application(handlers=[(r"/", IndexHandler), ])
    httpserver = tornado.httpserver.HTTPServer(app)
    httpserver.listen(8888)
    tornado.ioloop.IOLoop.instance().start()