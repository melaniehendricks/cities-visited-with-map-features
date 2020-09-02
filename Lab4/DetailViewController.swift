//
//  DetailViewController.swift
//  Lab4
//
//  Created by Melanie Hendricks on 2/27/20.
//  Copyright © 2020 Melanie Hendricks. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController, CLLocationManagerDelegate {

    // declare variables
    @IBOutlet weak var cityLabel: UILabel!
    var selectedCity:String?
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    var manager:CLLocationManager = CLLocationManager()
    
    
    
    // NEED IMAGE AND DESCRIPTION VARIABLES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityLabel.text = selectedCity
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - MAPTYPE SEG CONTROL, DISPLAY CITY ON MAP, DISPLAY LAT + LON
    
    @IBAction func showMap(_ sender: Any) {
        
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
        case 1:
            map.mapType = MKMapType.satellite
        case 2:
            map.mapType = MKMapType.hybrid
        default:
            map.mapType = MKMapType.standard
        }
        
        
        // create geocoder object
        let geoCoder = CLGeocoder()
        let address = selectedCity
        
        // pass address string to method (remote call)
        CLGeocoder().geocodeAddressString(address!, completionHandler: {(placemarks, error) in
            
            if error != nil{
                print("Geocode failed: \(error!.localizedDescription)")
                
                // go into placemarks object to see how many locations there are
                // might have more objects if you search a city
            }else if placemarks!.count > 0{
                let placemark = placemarks![0]
                
                // get location and lat/long coordinates
                let location = placemark.location
                let coords = location!.coordinate
                
                print(location)
                
                // create span/zoom
                let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                
                // create region on map based on coordinates
                let region = MKCoordinateRegion(center: coords, span: span)
                
                // set region on map based on region
                self.map.setRegion(region, animated: true)
                
                // create annotation object and set coordinates, title + subtitle
                let annotation = MKPointAnnotation()
                annotation.coordinate = coords
                annotation.title = placemark.locality
                annotation.subtitle = placemark.subLocality
                
                // add annotation to map
                self.map.addAnnotation(annotation)
                
                self.latLabel.text = String(format: "%.4f", coords.latitude, ",")
                self.lonLabel.text = String(format: "%.4f", coords.longitude)
            }
        })
    }
    
    // MARK: - SEARCH NEARBY
    
}
