//
//  ContactsModel.h
//  Native Mood App?
//
//  Created by ios8106 on 19/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Contact : NSObject
    @property(strong) NSString* name;
    @property(strong) NSString* phone;
    @property(strong) NSString* address;
    @property(strong) NSString* site;
    @property(strong) UIImage* profilePic;
@end
