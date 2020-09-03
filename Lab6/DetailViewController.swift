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

class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    // declare variables
    @IBOutlet weak var cityLabel: UILabel!
    var selectedCity:String?
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var searchFor: UITextField!
    var lat:CLLocationCoordinate2D!
    var lon:CLLocationCoordinate2D!
    
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    var manager:CLLocationManager = CLLocationManager()
    
    
    
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
                let annotation = Places(name: placemark.locality!, coordinate: coords, title: placemark.name!)
                //annotation.title = placemark.locality
                //annotation.subtitle = placemark.subLocality
                
                // add annotation to map
                self.map.addAnnotation(annotation)
                
                self.latLabel.text = String(format: "%.4f", coords.latitude, ",")
                self.lonLabel.text = String(format: "%.4f", coords.longitude)
            }
        })
    }
    
    // MARK: - SEARCH NEARBY
    
    @IBAction func search(_ sender: Any) {
        
        // create search request
        let request = MKLocalSearch.Request()
        
        // get search string from text field
        request.naturalLanguageQuery = self.searchFor.text
        
        // where are we searching on teh map? the map region
        request.region = map.region
        
        // create search object
        let search = MKLocalSearch(request: request)
        
        // if there is no response, error message
        search.start{ response, _ in
            guard let response = response else{
                return 
            }
            print(response.mapItems)
            
            // else
            // response is an array of MKMapItem objects
            var matchingItems:[MKMapItem] = []
            
            // extract all map items and put into matchingItems array
            matchingItems = response.mapItems
            
            for i in 1...matchingItems.count - 1
            {
                // put latitude, longitude and name into place variable
                let place = matchingItems[i].placemark
            
                print(place.name)
                
                 
                //let annotation = MKPointAnnotation()
                let coords = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                
                
                // will print title on map
                let annotation = Places(name: place.locality!, coordinate: coords, title: place.name!)

                self.map.addAnnotation(annotation)
            }
        }
    }
    
    
    // MARK: - RELOAD AND DISPLAY ALL PINS
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "pin"
        if annotation is Places{
            var annotationView = map.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil{
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            }else{
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        
        return nil
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let place = view.annotation as! Places
        let name = place.name!
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
}
