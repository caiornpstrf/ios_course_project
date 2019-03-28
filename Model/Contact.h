//
//  ContactsModel.h
//  Native Mood App?
//
//  Created by ios8106 on 19/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreData/CoreData.h>

@interface Contact : NSManagedObject <MKAnnotation>
@property(strong) NSString* name;
@property(strong) NSString* phone;
@property(strong) NSString* address;
@property(strong) NSString* site;
@property(strong) UIImage* profilePic;
@property(strong) NSNumber* latitude;
@property(strong) NSNumber* longitude;
@end
