//
//  MapViewController.swift
//  Pinz App
//
//  Created by Matt Hickman on 6/18/18.
//  Copyright © 2018 Matt Hickman. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import FirebaseDatabase

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //savePin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        // Create a GMSCameraPosition
        let camera = GMSCameraPosition.camera(withLatitude: 45.5122, longitude: -122.6587, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 45.5122, longitude: -122.6587)
        marker.title = "Portland"
        marker.snippet = "Oregon"
        marker.map = mapView
    }
    
    func savePin() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let storageReference = Database.database().reference().child("users/\(uid)")
        storageReference.setValue(["username": "test"])
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
