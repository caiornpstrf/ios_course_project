//
//  ContactsDao.swift
//  Native Mood App?
//
//  Created by ios8106 on 19/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

import UIKit

class ContactsDao: CoreDataUtil {
    static private var defaultDao: ContactsDao!
    private var contacts: Array<Contact>!
    
    static func sharedInstance() -> ContactsDao {
        if defaultDao == nil {
            defaultDao = ContactsDao()
        }
        return defaultDao
    }
    
    override private init() {
        super.init()
        self.addDefaultValues()
        self.fetchContacts()
    }
    
    func newContact() -> Contact {
            return NSEntityDescription.insertNewObject(forEntityName: "Contact", into: self.persistentContainer.viewContext) as! Contact
    }
    
    func add(_ contact: Contact) {
        self.contacts.append(contact)
    }
    
    func remove(_ index: Int) {
        persistentContainer.viewContext.delete(self.contacts[index])
        self.contacts.remove(at: index)
    }
    
    func getList() -> Array<Contact> {
        return self.contacts
    }
    
    func getAt(_ at: Int) -> Contact {
        return self.contacts[at]
    }
    
    func getIndex(_ of: Contact) -> Int {
        return self.contacts.index(of: of)!
    }
    
    func edit(_ at: Int, _ contact: Contact) {
        self.contacts[at] = contact
    }
    
    func getCount() -> Int {
        return self.contacts.count
    }
    
    func addDefaultValues() {
        let config = UserDefaults.standard
        let insertedData = config.bool(forKey: "inserted_data")
        
        if !insertedData {
            let myData = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: self.persistentContainer.viewContext) as! Contact
            
            myData.name = "Caio Reis"
            myData.phone = "+5511999999999"
            myData.address = "Wall Street, New York"
            myData.site = "https://partyAtMyPlace.com"
            myData.latitude = 40.64378274
            myData.longitude = -74.07839211
            
            self.saveContext()
            config.set(true, forKey: "inserted_data")
            config.synchronize()
        }
    }
    
    func fetchContacts() {
        let search = NSFetchRequest<Contact>(entityName: "Contact")
        let orderByName = NSSortDescriptor(key: "name", ascending: true)
        
        search.sortDescriptors = [orderByName]
        
        do {
            self.contacts = try self.persistentContainer.viewContext.fetch(search)
        }
        catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
}
