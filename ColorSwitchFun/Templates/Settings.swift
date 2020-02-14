//
//  Settings.swift
//  ColorSwitchFun
//
//  Created by Rashmi Kesireddy on 2/12/20.
//  Copyright © 2020 Rashmi Kesireddy. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1         // 01
    static let switchCategory: UInt32 = 0x1 << 1  // 10
}

enum ZPositions {
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}
