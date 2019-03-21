//
//  ContactsDao.swift
//  Native Mood App?
//
//  Created by ios8106 on 19/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

import UIKit

class ContactsDao: NSObject {
    static private var defaultDao: ContactsDao!
    var contacts: Array<Contact>
    
    static func sharedInstance() -> ContactsDao {
        if defaultDao == nil {
            defaultDao = ContactsDao()
        }
        return defaultDao
    }
    
    override private init() {
        self.contacts = Array()
        super.init()
    }
    
    func add(_ contact: Contact) {
        self.contacts.append(contact)
    }
    
    func remove(_ index: Int) {
        self.contacts.remove(at: index)
    }
}
