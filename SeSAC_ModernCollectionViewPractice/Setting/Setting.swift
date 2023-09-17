//
//  Setting.swift
//  SeSAC_ModernCollectionViewPractice
//
//  Created by 문정호 on 2023/09/18.
//

import Foundation

enum SettingType{
    case general
    case personal
    case etc
}

struct Setting: Hashable{
    let name: String
    let settingType: SettingType
}
