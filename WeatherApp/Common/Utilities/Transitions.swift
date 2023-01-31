//
//  Transitions.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 26/01/23.
//

import Foundation
import UIKit

public enum Transitions {
    public static var fade: CATransition = {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        return transition
    }()
}
