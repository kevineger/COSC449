#!/usr/bin/python
import praw
import pprint

user_agent = "A test script by /u/LowLanding"
r = praw.Reddit(user_agent=user_agent)

# Get the top 10 posts on /r/python
submissions = r.get_subreddit('python').get_top(limit=10)
submission = next(submissions)
print submission

# Get a user's karma
user = r.get_redditor('LowLanding')
print "Link Karma: {}".format(user.link_karma)

# Redditor Karma by Subreddit
thing_limit = 10
user_name = "LowLanding"
user = r.get_redditor(user_name)
gen = user.get_submitted(limit=thing_limit)
karma_by_subreddit = {}
for thing in gen:
    subreddit = thing.subreddit.display_name
    karma_by_subreddit[subreddit] = (karma_by_subreddit.get(subreddit, 0)
                                     + thing.score)
pprint.pprint(karma_by_subreddit)