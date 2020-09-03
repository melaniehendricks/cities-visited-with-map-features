//
//  Places.swift
//  Lab4
//
//  Created by Melanie Hendricks on 9/2/20.
//  Copyright © 2020 Melanie Hendricks. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Places:NSObject, MKAnnotation{
    
    var name:String?
    var coordinate:CLLocationCoordinate2D
    var title:String?
    
    init(name:String, coordinate: CLLocationCoordinate2D, title:String){
        self.name = name
        self.coordinate = coordinate
        self.title = title
    }
}
