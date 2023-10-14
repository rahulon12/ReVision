//
//  CLLocation+Landmarks.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/13/23.
//

import CoreLocation

extension CLLocation {
    func lookUpPlacemarkName(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        // Use the last reported location.
        let geocoder = CLGeocoder()
            
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(self,
                    completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation)
            }
            else {
             // An error occurred during geocoding.
                completionHandler(nil)
            }
        })
    }
}
