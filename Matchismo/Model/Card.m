//
//  Card.m
//  Matchismo
//
//  Created by Isi on 04/02/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score=0;
    
    for(Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
        {
            score=1;
        }
    }
    
    return score;
}
@end
