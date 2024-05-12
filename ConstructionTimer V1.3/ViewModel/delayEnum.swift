//
//  delayEnum.swift
//  ConstructionTimer V1.3
//
//  Created by Satoshi Mitsumori on 3/22/24.
//  Copyright 2024 Satoshi Mitsumori. All rights reserved.

import Foundation
import SwiftUI

enum delayEnum: String, CaseIterable {
    case utility = "Utility Delay"
    case gcsite = "GC Site Preparation Delay"
    case internaldelay = "Internal Equipment Delay"
    case weather = "Weather Delay"
    case material = "Material Delay"
    case design = "Design, Permit, Contract Delay"
    case selfinflicted = "Self Inflicted Delay"
    case none = "None"
}
