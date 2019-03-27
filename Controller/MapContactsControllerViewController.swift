//
//  MapContactsControllerViewController.swift
//  Native Mood App?
//
//  Created by Caio Reis on 25/03/19.
//  Copyright © 2019 Caio Reis. All rights reserved.
//

import UIKit
import MapKit

class MapContactsControllerViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    let dao:ContactsDao = ContactsDao.sharedInstance()
    let locationManager = CLLocationManager()
    var contacts: [Contact] = Array()
    
    override func viewWillAppear(_ animated: Bool) {
        self.contacts = dao.getList()
        self.map.addAnnotations(self.contacts)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.map.removeAnnotations(self.contacts)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.map.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        let locationButton = MKUserTrackingBarButtonItem(mapView: self.map)
        self.navigationItem.rightBarButtonItem = locationButton
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let identifier:String = "pin"
        var pin:MKPinAnnotationView
        
        if let reusePin = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            pin = reusePin
        }
        else {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        if let contact = annotation as? Contact {
            pin.pinTintColor = UIColor.init(displayP3Red: 0.8, green: 0.32, blue: 0.23, alpha: 1.0)
            pin.canShowCallout = true
            
            let frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
            let profilePic = UIImageView(frame: frame)
            
            profilePic.image = contact.profilePic
            pin.leftCalloutAccessoryView = profilePic
        }
        
        return pin
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let location = (view.annotation?.coordinate)!
        let region = MKCoordinateRegionMakeWithDistance(location, CLLocationDistance(exactly: 2500)!, CLLocationDistance(exactly: 2500)!)
        mapView.setCenter(location, animated: true)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        let location = (view.annotation?.coordinate)!
        let region = MKCoordinateRegionMakeWithDistance(location, CLLocationDistance(exactly: 20000)!, CLLocationDistance(exactly: 20000)!)
        mapView.setCenter(location, animated: true)
        mapView.setRegion(region, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
