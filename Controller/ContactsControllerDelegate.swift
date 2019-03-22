//
//  ContactsControllerDelegate.swift
//  Native Mood App?
//
//  Created by Caio Reis on 21/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

import Foundation

protocol ContactsControllerDelegate {
    func isContactUpdated(_ contact:Contact)
    func isContactAdded(_ contact:Contact)  
}
