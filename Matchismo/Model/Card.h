//
//  Card.h
//  Matchismo
//
//  Created by Isi on 04/02/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;

@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
