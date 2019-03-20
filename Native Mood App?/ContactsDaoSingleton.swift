//
//  ContactsDaoSingleton.swift
//  Native Mood App?
//
//  Created by ios8106 on 19/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

import UIKit


static func SharedInstance() {
    if ContactsDao == nil {
        defaultDao = ContactsDao()
    }
}
