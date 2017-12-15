//
//  LocateViewController.swift
//  SpecialTopicProject
//
//  Created by admin on 12/1/17.
//  Copyright © 2017 Prajakta Morale. All rights reserved.
//

import UIKit
import MapKit

class LocateViewController: UIViewController {
    
    

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let distanceSpan: CLLocationDegrees = 2000
        
        let SCLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.313557, -121.934257)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(SCLocation, distanceSpan, distanceSpan), animated: true)
        let SJLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.252044, -121.946530)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(SJLocation, distanceSpan, distanceSpan), animated: true)
        let ESLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(34.998737, -85.218968)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(SJLocation, distanceSpan, distanceSpan), animated: true)
        
        
        
        let pin1=MapAnnotation(title: "Santa Clara Hospital", subtitle: "Santa Clara, Ca-95143", coordinate: SCLocation)
        mapView.addAnnotation(pin1)
        let pin2=MapAnnotation(title: "Good Samartian Hospital", subtitle: "San Jose, Ca-95126", coordinate: SJLocation)
        mapView.addAnnotation(pin2)
        let pin3=MapAnnotation(title: "Good Samartian Hospital", subtitle: "San Jose, Ca-95126", coordinate: ESLocation)
        mapView.addAnnotation(pin3)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
