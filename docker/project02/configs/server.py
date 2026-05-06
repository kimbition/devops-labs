from http.server import BaseHTTPRequestHandler, HTTPServer
import json
import os
import socket
from datetime import datetime, timezone


class Handler(BaseHTTPRequestHandler):
    def _send_json(self, status, payload):
        body = json.dumps(payload, ensure_ascii=False, indent=2).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        if self.path == "/health":
            self._send_json(200, {
                "status": "ok",
                "service": "devops-python-api"
            })
            return

        if self.path == "/":
            self._send_json(200, {
                "message": "hello from optimized docker image",
                "hostname": socket.gethostname(),
                "time": datetime.now(timezone.utc).isoformat()
            })
            return

        self._send_json(404, {
            "error": "not found",
            "path": self.path
        })


if __name__ == "__main__":
    port = int(os.getenv("PORT", "8000"))
    server = HTTPServer(("0.0.0.0", port), Handler)
    print(f"listening on 0.0.0.0:{port}", flush=True)
    server.serve_forever()
