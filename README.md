# FilterGroupView

一个基于 UIKit + SnapKit 的分组筛选 ActionSheet 组件，支持自定义头部、灵活布局和选中回调，轻量易用。

## 功能特性
- **自定义头部**：标题、关闭按钮均可替换  
- **多分组选项**：基于 UICollectionView，无限分组  
- **灵活布局**：支持 `itemsPerRow` 与 `interItemSpacing` 配置  
- **选中回调**：使用闭包 `(sectionIndex, itemIndex) -> Void` 简洁接收选择结果  

## 安装
1. 将以下文件加入项目：  
   - `FilterGroupView.swift`  
   - `FilterGroupModel.swift`  
   - `FilterGroupCell.swift`  
   - `FilterGroupSectionHeaderView.swift`  
   - `ActionsheetHeader.swift`  

2. 确保项目中引入了 SnapKit 依赖：  
   ```swift
   import SnapKit
   ```

## 使用示例
```swift
let sections = [
    FilterGroupModel(title: "质量控制", options: ["全部","正常","不正常"], selectedIndex: 0),
    FilterGroupModel(title: "站点类型", options: ["全部","国家站","区域站"], selectedIndex: 0),
    FilterGroupModel(title: "地区选择", options: ["全国","北京","天津"], selectedIndex: 0)
]

let layoutConfigs = [
    SectionLayoutConfig(itemsPerRow: 3, interItemSpacing: 16),
    SectionLayoutConfig(itemsPerRow: 3, interItemSpacing: 16),
    SectionLayoutConfig(itemsPerRow: 2, interItemSpacing: 12)
]

let filterView = FilterGroupView(sections: sections, layoutConfigs: layoutConfigs)
filterView.selectionHandler = { section, index in
    print("第 \(section) 组，选择了第 \(index) 项")
}

present(CustomAlert(view: filterView), animated: true)
```

## 自定义
- **头部视图**：可替换 `ActionsheetHeader` 实现标题、关闭按钮等自定义内容  
- **样式调整**：可修改 Cell 和 Header 样式，也可替换数据模型与布局配置  

## 许可证
MIT License
