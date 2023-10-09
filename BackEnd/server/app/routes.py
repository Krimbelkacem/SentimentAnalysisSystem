from flask import request, jsonify
from . import app

from .analyse import perform_sentiment_analysis


from flask_cors import CORS


CORS(app)


@app.route('/hello', methods=['GET'])
def hello_world():
    return 'Hello, World!'


@app.route('/analyse-sentiment', methods=['POST'])
def analyse_sentiment():
    if request.method == 'POST':
        data = request.get_json()
        text = data.get('text', '')

        if text:
            print(f'Received query: {text}')
            sentiment_result = perform_sentiment_analysis(text)
            print(f'Response sentiment: {sentiment_result}')
            return jsonify({'sentiment': sentiment_result})
        else:
            return jsonify({'error': 'Text data is missing'}), 400
    else:
        return jsonify({'error': 'Invalid request method'}), 405
