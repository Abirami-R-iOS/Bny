//
//  PermissionManager.swift
//  Bny
//
//  Created by Abirami on 22/07/26.
//

import UIKit
import CoreLocation
import Photos

final class PermissionManager: NSObject {

    static let shared = PermissionManager()

    private let locationManager = CLLocationManager()

    func requestPermissions() {

        requestLocationPermission()
//        requestPhotoPermission()
    }

    private func requestLocationPermission() {

        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    private func requestPhotoPermission() {

        if #available(iOS 14, *) {

            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                print("Photo Permission:", status.rawValue)
            }

        } else {

            PHPhotoLibrary.requestAuthorization { status in
                print("Photo Permission:", status.rawValue)
            }
        }
    }
}
