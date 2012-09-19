//
//  ZIAApplication.m
//  MonitorRank
//
//  Created by Javi on 05/08/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import "ZIAApplication.h"

@implementation ZIAApplication

+ (ZIAApplication *)applicationWithDictionaryRepresentation:(NSDictionary *)dictionary
{
    ZIAApplication *application = [[ZIAApplication alloc] initWithDictionaryRepresentation:dictionary];
    return application;
}

- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary
{
    self = [super init];
    if (self != nil) {
        _trackId = [NSNumber numberWithInteger:[[dictionary valueForKey:@"trackId"] integerValue]];
        _trackName = [[dictionary valueForKey:@"trackName"] description];
        _artworkUrl60 = [NSURL URLWithString:[[dictionary valueForKey:@"artworkUrl60"] description]];
        _artworkUrl100 = [NSURL URLWithString:[[dictionary valueForKey:@"artworkUrl100"] description]];
        _artworkUrl512 = [NSURL URLWithString:[[dictionary valueForKey:@"artworkUrl512"] description]];
        _features = [dictionary valueForKey:@"features"];
        _supportedDevices = [dictionary valueForKey:@"supportedDevices"];
        _artistId = [NSNumber numberWithInteger:[[dictionary valueForKey:@"artistId"] integerValue]];
        _artistName = [[dictionary valueForKey:@"artistName"] description];
        _price = [NSNumber numberWithDouble:[[dictionary valueForKey:@"price"] doubleValue]];
        _currency = [[dictionary valueForKey:@"currency"] description];
        _formattedPrice = [[dictionary valueForKey:@"formattedPrice"] description];
        _genreIds = [dictionary valueForKey:@"genreIds"];
        _genres = [dictionary valueForKey:@"genres"];
        _version = [[dictionary valueForKey:@"version"] description];
        _averageUserRatingForCurrentVersion = [NSNumber numberWithDouble:[[dictionary valueForKey:@"averageUserRatingForCurrentVersion"] doubleValue]];
        _userRatingCountForCurrentVersion = [NSNumber numberWithInteger:[[dictionary valueForKey:@"userRatingCountForCurrentVersion"] integerValue]];
        _averageUserRating = [NSNumber numberWithDouble:[[dictionary valueForKey:@"averageUserRating"] doubleValue]];
        _userRatingCount = [NSNumber numberWithInteger:[[dictionary valueForKey:@"userRatingCount"] integerValue]];
        _trackContentRating = [[dictionary valueForKey:@"trackContentRating"] description];
        _description = [[dictionary valueForKey:@"description"] description];
        _kind = [[dictionary valueForKey:@"kind"] description];
        _trackViewURL = [[dictionary valueForKey:@"trackViewUrl"] description];
    }
    return self;
}

@end
