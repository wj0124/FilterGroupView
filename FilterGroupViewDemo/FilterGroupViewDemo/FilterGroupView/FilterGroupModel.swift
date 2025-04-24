//
//  FilterGroupModel.swift
//  ZhongYangQiXiangTai
//
//  Created by 王杰 on 2025/4/24.
//
import UIKit

// MARK: - 分组数据模型
struct FilterGroupModel {
    let title: String
    var options: [FilterGroupOption]
    var selectedIndex: Int? = 0
    let layoutConfig: SectionLayoutConfig
}

struct FilterGroupOption {
    let title: String?
    var extra: String?
}


// MARK: - 布局配置模型
struct SectionLayoutConfig {
    let itemsPerRow: Int
    let interItemSpacing: CGFloat
}
