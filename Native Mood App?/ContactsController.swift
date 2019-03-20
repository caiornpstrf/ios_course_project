//
//  ViewController.swift
//  Native Mood App?
//
//  Created by ios8106 on 19/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelPhone: UILabel!
    @IBOutlet var labelAddress: UILabel!
    @IBOutlet var labelSite: UILabel!
    @IBOutlet var labelMessage: UILabel!
    
    @IBOutlet var textfName: UITextField!
    @IBOutlet var textfPhone: UITextField!
    @IBOutlet var textfAddress: UITextField!
    @IBOutlet var textfSite: UITextField!
    
    
    @IBAction func changeLabel() {
        //let name = labelName.text
        //let phone = labelPhone.text
        //let address = labelAddress.text
        //let site = labelSite.text
        
        //print(name + phone + address + site)
        
        labelMessage.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { // Change `2.0` to the desired number of seconds.
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

