//
//  User.h
//  twitter
//
//  Created by Ernest Omondi on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

// MARK: Properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSURL *profileImageUrl;

// Add any additional properties here

// Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
