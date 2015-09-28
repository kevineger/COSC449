#!/usr/bin/python
import praw
import time

user_agent = "A test script by /u/LowLanding"
r = praw.Reddit(user_agent=user_agent)

r.login('LowLanding', 'Lespaul94')
already_done = []

while True:
    subreddit = r.get_subreddit('redditdev')
    for submission in subreddit.get_top(limit=30):
        prawWords = ['praw', 'reddit_api', 'mellort', 'api']
        op_text = submission.selftext.lower()
        has_praw = any(string in op_text for string in prawWords)
        if submission.id not in already_done and has_praw:
            msg = '[PRAW related thread](%s)' % submission.short_link
            print "Message: {}".format(msg)
            already_done.append(submission.id)
    print "Sleeping"
    time.sleep(10)
