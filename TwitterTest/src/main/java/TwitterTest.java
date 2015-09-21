/**
 * Created by kevin on 20/09/15.
 */

import twitter4j.*;
import twitter4j.conf.ConfigurationBuilder;

import java.util.List;

public class TwitterTest {

    public static void main(String[] args) {

        // Print out the arguments
        System.out.println("Arguments:");
        for(String arg : args) {
            System.out.println(arg);
        }
        System.out.println("-----------------------");

        // Connect OAuth
        ConfigurationBuilder cb = new ConfigurationBuilder();
        cb.setDebugEnabled(true)
                .setOAuthConsumerKey("0iGriIYgWLiQThhbuEPKbmgYV")
                .setOAuthConsumerSecret("EUxLYgrsRcdykkpyRhZrt5ViTMO7e9in33CxODxyQBtuVdx3cg")
                .setOAuthAccessToken("3541214658-DEjwOv00F829Qa9Srndq5ri8MnCXxfiGccwYa1W")
                .setOAuthAccessTokenSecret("PTg5WegA7ohvLZRfucqMK59r1NggcSPAgAIfjIQa6YuuI");
        TwitterFactory tf = new TwitterFactory(cb.build());

        Twitter twitter = tf.getInstance();

        try {
            // Update Status
            //twitter.updateStatus("Testing Twitter API in Java");

            // Get Timeline
            /*System.out.println("Home Timeline:");
            List<Status> statuses = twitter.getHomeTimeline();
            for (Status status : statuses ) {
                System.out.println(status.getUser().getName() + ": " + status.getText());
            }*/

            Query query = new Query("to:techcrunch");
            QueryResult result = twitter.search(query);
            for (Status status : result.getTweets()) {
                System.out.println("@" + status.getUser().getScreenName() + ": " + status.getText());
            }

        } catch(TwitterException te) {
            System.out.println(te);
        }

    }
}
