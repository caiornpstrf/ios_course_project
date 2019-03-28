//
//  ContactsModel.m
//  Native Mood App?
//
//  Created by ios8106 on 19/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

#import "Contact.h"

@implementation Contact
@dynamic name, phone, address, site, latitude, longitude, profilePic;

//- (NSString *)description {
//    return [NSString stringWithFormat:@"Name: %@,  Phone: %@  Address: %@  Site: %@", self.name, self.phone, self.address, self.site];
//}

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return self.address;
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

//- (NSString *) name {
//    return self.name;
//}
//
//-(void) setName:(NSString *) name {
//    self.name = name;
//}
//
//- (NSString *) phone {
//    return self.phone;
//}
//
//-(void) setPhone:(NSString *) phone {
//    self.phone = phone;
//}
//
//- (NSString *) address {
//    return self.address;
//}
//
//-(void) setAddress:(NSString *) address {
//    self.address = address;
//}
//
//- (NSString *) site {
//    return self.site;
//}
//
//-(void) setSite:(NSString *) site {
//    self.site = site;
//}
@end
