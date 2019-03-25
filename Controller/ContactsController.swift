//
//  ViewController.swift
//  Native Mood App?
//
//  Created by ios8106 on 19/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

import UIKit

class ContactsController: UIViewController,
                          UIImagePickerControllerDelegate,
                          UINavigationControllerDelegate
{
    
    static let cellId:String = "ContactsCell"
    
    var delegate:ContactsControllerDelegate?
    
    var dao:ContactsDao!
    var activeContact:Contact!
    var activeIndex:Int!
    
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
    
    @IBOutlet var imageProfile: UIImageView!
    
    @IBAction func addContact() {
        let contact:Contact = self.getContact()
        dao.add(contact)
        self.delegate?.isContactAdded(contact)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editContact() {
        let contact:Contact = self.getContact()
        dao.edit(self.activeIndex, contact)
        self.delegate?.isContactUpdated(contact)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getContact() -> Contact {
        let contact: Contact = Contact()
        contact.name = self.textfName.text
        contact.phone = self.textfPhone.text
        contact.address = self.textfAddress.text
        contact.site = self.textfSite.text
        contact.profilePic = self.imageProfile.image
        return contact
    }
    
    func popMessage(_ time: Double) {
        labelMessage.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.labelMessage.isHidden = true
        }
    }
    
    func selectPhoto(sender: AnyObject) {
        print("HERE")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
        }
        else {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.activeContact != nil {
            self.textfName.text = self.activeContact.name
            self.textfPhone.text = self.activeContact.phone
            self.textfAddress.text = self.activeContact.address
            self.textfSite.text = self.activeContact.site
            self.imageProfile.image = self.activeContact.profilePic
            
            self.navigationItem.rightBarButtonItem =
                UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(editContact))
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectPhoto(sender:)))
        self.imageProfile.addGestureRecognizer(tap)
        self.imageProfile.layer.cornerRadius = self.imageProfile.frame.height/2
        self.imageProfile.clipsToBounds = true
        self.imageProfile.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageProfile.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

