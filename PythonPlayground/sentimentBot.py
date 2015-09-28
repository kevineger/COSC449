#!/usr/bin/python
import praw
from DatumBox import DatumBox
import time

user_agent = "A continuous sentiment analysis of the front-page"
r = praw.Reddit(user_agent=user_agent)
r.login('LowLanding', 'Lespaul94', disable_warning=True)

datum_box = DatumBox('c3ac3635add7e6d13ce0218ff033674f')

# Array for submissions already analyzed
already_done = []

while True:
    submissions = r.get_top()
    for submission in submissions:
        op_text = submission
        print "\n"
        print op_text
        print "Sentiment: {}".format(datum_box.sentiment_analysis(op_text))
        print "Topic: {}".format(datum_box.topic_classification(op_text))
    print "Sleeping"
    time.sleep(20)
