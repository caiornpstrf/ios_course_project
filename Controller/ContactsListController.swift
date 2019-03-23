//
//  ContactsListController.swift
//  Native Mood App?
//
//  Created by Caio Reis on 20/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

import UIKit

class ContactsListController: UITableViewController, ContactsControllerDelegate {

    var dao:ContactsDao
    var hightlightLine: IndexPath?
    var selectedContact:Contact!
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContactsDao.sharedInstance()
        super.init(coder: aDecoder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactsFormSegue" {
            if let form = segue.destination as? ContactsController {
                    form.delegate = self
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        if let index = self.hightlightLine {
            self.tableView.selectRow(at: index, animated: true, scrollPosition: .middle)
            self.deselectRow(index, 5)
        }
    }
    
    func deselectRow(_ index: IndexPath, _ time: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.tableView.deselectRow(at: index, animated: true)
            self.hightlightLine = Optional.none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showMoreOptions(gesture:)))
        self.tableView.addGestureRecognizer(longPress)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func showMoreOptions(gesture: UIGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: self.tableView)
            if let indexPath = self.tableView.indexPathForRow(at: point) {
                self.selectedContact = self.dao.getAt(indexPath.row)
                let actions = ActionManager(of: self.selectedContact)
                actions.showActions(in: self)
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // print(self.dao.contacts.count)
        return self.dao.getCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsListId", for: indexPath)
        let contact:Contact = self.dao.getAt(indexPath.row)
        // Configure the cell...
        // print(self.dao.contacts[indexPath.row].name)
        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = contact.phone

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = self.dao.getAt(indexPath.row)
        self.showForm(selectedContact, indexPath.row)
    }
    
    func showForm(_ selectedContact: Contact, _ activeIndex: Int) {
        let storyboard:UIStoryboard = UIStoryboard(name: "ContactsView", bundle: nil)
        let form = storyboard.instantiateViewController(withIdentifier: "ContactsForm") as! ContactsController
        form.delegate = self
        form.activeContact = selectedContact
        form.activeIndex = activeIndex
        self.navigationController?.pushViewController(form, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.dao.remove(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func isContactUpdated(_ contact: Contact) {
        self.hightlightLine = IndexPath(row: self.dao.getIndex(contact), section: 0)
    }
    
    func isContactAdded(_ contact: Contact) {
        self.hightlightLine = IndexPath(row: self.dao.getIndex(contact), section: 0)
    }
}
