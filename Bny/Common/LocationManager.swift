//
//  LocationManager.swift
//  Bny
//
//  Created by Abirami on 22/07/26.
//


import CoreLocation

final class LocationManager: NSObject {

    static let shared = LocationManager()

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    private var completion: ((String) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func getCurrentAddress(completion: @escaping (String?) -> Void) {

        self.completion = completion

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {

        guard let location = locations.first else {
            completion?("")
            return
        }

        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, _ in

            guard let placemark = placemarks?.first else {
                self?.completion?("")
                return
            }

            let address = [
                placemark.name,
                placemark.locality,
                placemark.administrativeArea,
                placemark.country
            ]
            .compactMap { $0 }
            .joined(separator: ", ")

            self?.completion?(address)
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {

        completion?("")
    }
}
