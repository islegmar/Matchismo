//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Isi on 04/02/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) NSString *lastMatchText;
@end

@implementation CardMatchingGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (NSMutableArray *)cards
{
    if (!_cards) _cards=[[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for(int i=0; i<cardCount; ++i) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self=nil;
            } else {
                self.cards[i]=card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return index<self.cards.count ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if ( !card.isUnplayable ) {
        if (!card.isFaceUp) {
            // Search another matching card from the deck
            for(Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable=YES;
                        card.unplayable=YES;
                        self.score+=matchScore * MATCH_BONUS;
                        self.lastMatchText = [NSString stringWithFormat:@"Matched %@ and %@ for %d points!", [card contents], [otherCard contents], matchScore];
                    } else {
                        // If there is not match, faceDown the card
                        // (only one visible card every time, except
                        // when matching)
                        self.score -= MISMATCH_PENALTY;
                        otherCard.faceUp=NO;
                        self.lastMatchText = [NSString stringWithFormat:@"Flipped up %@", [card contents]];
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp=!card.isFaceUp;
    }
}
@end
