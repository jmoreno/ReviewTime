//
//  ZIAApplication.h
//  MonitorRank
//
//  Created by Javi on 05/08/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZIAApplication : NSObject

@property (nonatomic, strong) NSNumber *trackId;
@property (nonatomic, strong) NSString *trackName;
@property (nonatomic, strong) NSURL *artworkUrl60;
@property (nonatomic, strong) NSURL *artworkUrl100;
@property (nonatomic, strong) NSURL *artworkUrl512;
@property (nonatomic, strong) NSMutableArray *features;
@property (nonatomic, strong) NSMutableArray *supportedDevices;
@property (nonatomic, strong) NSNumber *artistId;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *formattedPrice;
@property (nonatomic, strong) NSMutableArray *genreIds;
@property (nonatomic, strong) NSMutableArray *genres;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSNumber *averageUserRatingForCurrentVersion;
@property (nonatomic, strong) NSNumber *userRatingCountForCurrentVersion;
@property (nonatomic, strong) NSNumber *averageUserRating;
@property (nonatomic, strong) NSNumber *userRatingCount;
@property (nonatomic, strong) NSString *trackContentRating;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *kind;
@property (nonatomic, strong) NSString *trackViewURL;


+ (ZIAApplication *)applicationWithDictionaryRepresentation:(NSDictionary *)dictionary;
- (id)initWithDictionaryRepresentation:(NSDictionary *)dictonary;

@end
