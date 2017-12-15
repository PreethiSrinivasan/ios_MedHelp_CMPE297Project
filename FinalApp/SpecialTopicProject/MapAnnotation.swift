//
//  MapAnnotation.swift
//  SpecialTopicProject
//
//  Created by admin on 12/1/17.
//  Copyright © 2017 Prajakta Morale. All rights reserved.
//

import MapKit
class MapAnnotation: NSObject, MKAnnotation{
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        
        self.title=title
        self.subtitle=subtitle
        self.coordinate=coordinate
    }
    }

