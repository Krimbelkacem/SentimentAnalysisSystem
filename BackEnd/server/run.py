from app import app
from app import routes

from flask_cors import CORS
CORS(app)
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
CORS(app)
