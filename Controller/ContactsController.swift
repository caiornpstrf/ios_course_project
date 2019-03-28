//
//  ViewController.swift
//  Native Mood App?
//
//  Created by ios8106 on 19/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

import UIKit
import CoreLocation

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
    //@IBOutlet var labelMessage: UILabel!
    @IBOutlet var labelLat: UILabel!
    @IBOutlet var labelLon: UILabel!
    @IBOutlet var labelLatNumb: UILabel!
    @IBOutlet var labelLonNumb: UILabel!
    
    @IBOutlet var textfName: UITextField!
    @IBOutlet var textfPhone: UITextField!
    @IBOutlet var textfAddress: UITextField!
    @IBOutlet var textfSite: UITextField!
    
    @IBOutlet var imageProfile: UIImageView!
    
    @IBAction func addContact() {
        self.getContact()
        dao.add(self.activeContact)
        self.delegate?.isContactAdded(self.activeContact)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editContact() {
        self.getContact()
        dao.edit(self.activeIndex, self.activeContact)
        self.delegate?.isContactUpdated(self.activeContact)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getLocation() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.textfAddress.text!) { (result, error) in
            if error == nil && result?.count ?? 0 > 0 {
                let placemark = result![0]
                let coordinates = placemark.location!.coordinate
                
                self.labelLatNumb.text = coordinates.latitude.description
                self.labelLonNumb.text = coordinates.longitude.description
            }
            else {
                let alert = UIAlertController(
                    title: "Address not informed!",
                    message: "Please inform an address before finding coordinates.",
                    preferredStyle: .alert
                )
                
                let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func getContact() {
        if self.activeContact == nil {
            self.activeContact = dao.newContact()
        }
        self.activeContact.name = self.textfName.text
        self.activeContact.phone = self.textfPhone.text
        self.activeContact.address = self.textfAddress.text
        self.activeContact.site = self.textfSite.text
        self.activeContact.profilePic = self.imageProfile.image
        if let latitude = Double(self.labelLatNumb.text!) {
            self.activeContact.latitude = latitude as NSNumber
        }
        if let longitude = Double(self.labelLonNumb.text!) {
            self.activeContact.longitude = longitude as NSNumber
        }
    }
    
//    func popMessage(_ time: Double) {
//        labelMessage.isHidden = false
//        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
//            self.labelMessage.isHidden = true
//        }
//    }
    
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
            self.labelLatNumb.text = self.activeContact.latitude?.description
            self.labelLonNumb.text = self.activeContact.longitude?.description
            
            self.navigationItem.rightBarButtonItem =
                UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(editContact))
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectPhoto(sender:)))
        // override viewDidLayoutSubviews
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

