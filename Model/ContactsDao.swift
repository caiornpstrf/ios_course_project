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
    private var contacts: Array<Contact>
    
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
    
    func getList() -> Array<Contact> {
        return self.contacts
    }
    
    func getAt(_ at: Int) -> Contact {
        return self.contacts[at]
    }
    
    func edit(_ at: Int, _ contact: Contact) {
        self.contacts[at] = contact
    }
    
    func getCount() -> Int {
        return self.contacts.count
    }
}
