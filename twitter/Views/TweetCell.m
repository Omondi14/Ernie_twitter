//
//  TweetCell.m
//  twitter
//
//  Created by Ernest Omondi on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)didTapFavourite:(id)sender {
    [self toggleLike];
    }

- (void)setTweet:(Tweet *)tweet{
    _tweet = tweet;
    [self refreshData];
}
- (IBAction)didTapRetweet:(id)sender {
    [self toggleRetweet];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) refreshData {
    self.userNameLabel.text  = self.tweet.user.name;
    NSLog(@"%@", self.userNameLabel.text);
    self.tweetContentLabel.text = self.tweet.text;
    
    if (self.tweet.favorited){
        self.didTapLike.selected = YES;
    }
    else{
        self.didTapLike.selected = NO;
    }
    if(self.tweet.retweeted){
        self.retweetButton.selected = YES;
    }
    else{
        self.retweetButton.selected = NO;
    }
    self.favoriteLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.retweetLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];

}

- (void) toggleLike{
    // unfavorite a tweet
    if (self.tweet.favorited){
        // update the local tweet model
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        // change from red to not red
        self.didTapLike.selected = NO;
        
        // Send a POST request to the POST favorites/destroy endpoint
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    // favorite a tweet
    else{
        // TODO: Update the local tweet model
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        // change from red to not red
        self.didTapLike.selected = YES;
        
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}

- (void) toggleRetweet {
    // unretweet
    if (self.tweet.retweeted){
        // update the local tweet model
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        // change retweet button color from green to gray
        self.retweetButton.selected = NO;
        
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
        
    }
    else{
        // update the local tweet model
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        // change retweet button color from green to gray
        self.retweetButton.selected = YES;
        
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}

@end
