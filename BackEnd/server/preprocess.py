# preprocess.py

import pandas as pd


def load_movie_data():
    # Load movies and ratings data from the data directory
    movies = pd.read_csv('data/movies.csv')
    ratings = pd.read_csv('data/ratings.csv')

    # Perform any necessary data preprocessing here

    return movies, ratings
