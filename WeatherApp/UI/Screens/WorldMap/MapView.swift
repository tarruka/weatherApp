//
//  MapView.swift
//  WeatherApp
//
//  Created by Tarek Radovan on 01/10/2023.
//

import SwiftUI
import UIKit
import MapKit

struct MapView: UIViewRepresentable {
  
  @Binding var tappeddCoordinate: CLLocationCoordinate2D?
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    context.coordinator.map = mapView
    mapView.addGestureRecognizer(context.coordinator.gestureRecognizer)
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    weak var map: MKMapView?
    
    init(_ parent: MapView) {
      self.parent = parent
    }
    
    var gestureRecognizer: UITapGestureRecognizer {
      let gesture = UITapGestureRecognizer(
        target: self,
        action:#selector(getCoordinatesOnMap)
      )
      gesture.numberOfTapsRequired = 1
      return gesture
    }
    
    @objc func getCoordinatesOnMap(sender: UITapGestureRecognizer) {
      guard let map = map else {
        return
      }
      let touchLocation = sender.location(in: map)
      let locationCoordinate = map.convert(
        touchLocation,
        toCoordinateFrom: map
      )
      parent.tappeddCoordinate = locationCoordinate
    }
  }
}
