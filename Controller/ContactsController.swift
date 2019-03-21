//
//  ViewController.swift
//  Native Mood App?
//
//  Created by ios8106 on 19/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

import UIKit

class ContactsController: UIViewController {
    
    var dao:ContactsDao!
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContactsDao.sharedInstance()
        super.init(coder: aDecoder)
    }

    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelPhone: UILabel!
    @IBOutlet var labelAddress: UILabel!
    @IBOutlet var labelSite: UILabel!
    @IBOutlet var labelMessage: UILabel!
    
    @IBOutlet var textfName: UITextField!
    @IBOutlet var textfPhone: UITextField!
    @IBOutlet var textfAddress: UITextField!
    @IBOutlet var textfSite: UITextField!
    
    
    @IBAction func addContact() {
        dao.add(self.getContact())
        print(dao.contacts)
        self.popMessage(5)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getContact() -> Contact {
        let contact: Contact = Contact()
        contact.name = textfName.text
        contact.phone = textfPhone.text
        contact.address = textfAddress.text
        contact.site = textfSite.text
        return contact
    }
    
    func popMessage(_ time: Double) {
        labelMessage.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.labelMessage.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

