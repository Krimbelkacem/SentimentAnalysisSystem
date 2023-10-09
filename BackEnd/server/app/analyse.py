import pandas as pd
from flask import jsonify

from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer


def perform_sentiment_analysis(text):
    # Initialize the VADER sentiment analyzer
    analyzer = SentimentIntensityAnalyzer()

    # Analyze sentiment
    sentiment_scores = analyzer.polarity_scores(text)

    # Determine sentiment based on compound score
    compound_score = sentiment_scores['compound']

    if compound_score >= 0.05:
        return 'positive'
    elif compound_score <= -0.05:
        return 'negative'
    else:
        return 'neutral'
