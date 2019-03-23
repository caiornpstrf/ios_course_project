//
//  ActionManager.swift
//  Native Mood App?
//
//  Created by Caio Reis on 22/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

import UIKit

class ActionManager: NSObject {
    let contact:Contact
    var controller:UIViewController!
    
    init(of contact:Contact) {
        self.contact = contact
    }
    
    func openApp(url:String) {
        UIApplication.shared.open(
            URL(string: url)!,
            options: [:],
            completionHandler: nil
        )
    }
    
    func call() {
        let device = UIDevice.current
        if device.model == "iPhone" {
            self.openApp(url: "tel:" + self.contact.phone!)
        }
        else {
            let alert = UIAlertController(
                title: "Esse aparelho não suporta ligações!",
                message: "Dispositivo não é um iPhone.",
                preferredStyle: .alert
            )
            
            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.controller.present(alert, animated: true, completion: nil)
        }
    }
    
    func showMap() {
        let url = ("https://maps.google.com/maps?q="+self.contact.address!)
                    .addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        self.openApp(url: url)
    }
    
    func showSite() {
        var url = self.contact.site!
        let prefix = "https://"
        if !url.hasPrefix(prefix) {
            url = prefix+url
        }
        self.openApp(url: url)
    }
    
    func showActions(in controller:UIViewController) {
        self.controller = controller
        
        let alertView = UIAlertController(title: self.contact.name, message: nil, preferredStyle: .actionSheet)
        let cancel =  UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let call =  UIAlertAction(title: "Call", style: .default){action in
            self.call()
        }
        let showMap =  UIAlertAction(title: "Show on Map", style: .default){action in
            self.showMap()
        }
        let showSite =  UIAlertAction(title: "Go to Site", style: .default){action in
            self.showSite()
        }
        
        alertView.addAction(cancel)
        alertView.addAction(call)
        alertView.addAction(showMap)
        alertView.addAction(showSite)
        
        self.controller.present(alertView, animated: true, completion: nil)
    }
}
