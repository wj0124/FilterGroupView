# FilterGroupView

一个基于 UIKit + SnapKit 的分组筛选组件，配合 LEEAlert 使用，支持多分组、灵活布局和选中回调，轻量易用。

## 功能特性
- **自定义头部**：可组合 ActionsheetHeader 实现  
- **多分组选项**：基于 UICollectionView，支持灵活扩展  
- **布局配置**：每组独立设置 item 数量与间距  
- **选中回调**：支持单项回调与确定后统一回调  

## 安装
1. 拷贝以下文件到你的项目中：
   - `FilterGroupView.swift`
   - `FilterGroupModel.swift`
   - `FilterGroupCell.swift`
   - `FilterGroupSectionHeaderView.swift`
   - `ActionsheetHeader.swift`

2. 确保使用 SnapKit：
   ```swift
   import SnapKit
   ```

## 使用示例（结合 LEEAlert 弹窗）
```swift
let sections: [FilterGroupModel] = [
    FilterGroupModel(
        title: "质量控制",
        options: ["全部", "正常", "不正常"].map { FilterGroupOption(title: $0, extra: nil) },
        selectedIndex: 0,
        layoutConfig: SectionLayoutConfig(itemsPerRow: 3, interItemSpacing: 22)
    ),
    FilterGroupModel(
        title: "站点类型",
        options: ["全部", "国家站", "区域站"].map { FilterGroupOption(title: $0, extra: nil) },
        selectedIndex: 0,
        layoutConfig: SectionLayoutConfig(itemsPerRow: 3, interItemSpacing: 22)
    ),
    FilterGroupModel(
        title: "地区选择",
        options: ["全国", "北京", "天津", "河北", "山西", "内蒙古", "辽宁", "吉林", "黑龙江", "上海", "江苏", "浙江"].map {
            FilterGroupOption(title: $0, extra: nil)
        },
        selectedIndex: 0,
        layoutConfig: SectionLayoutConfig(itemsPerRow: 4, interItemSpacing: 13)
    )
]

let filterView = FilterGroupView(sections: sections)
filterView.backgroundColor = .white
filterView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 300)
filterView.height = filterView.collectionContentHeight() + 50

filterView.selectionHandler = { indexPath in
    let sec = sections[indexPath.section]
    let opt = sec.options[indexPath.item]
    print("[筛选选择] \(sec.title)：\(opt.title ?? "-")")
}

filterView.confirmSelectionHandler = { indexPaths in
    indexPaths.forEach { ip in
        let sec = sections[ip.section]
        let opt = sec.options[ip.item]
        print("[确定选择] \(sec.title)：\(opt.title ?? "-")")
    }
}

LEEAlert.actionsheet()
    .config
    .leeActionSheetBackgroundColor(.white)
    .leeAddCustomView { $0.view = filterView }
    .leeClickBackgroundClose(true)
    .leeActionSheetBottomMargin(BottomSafeHight)
    .leeShow()
```

## 自定义
- 修改 `FilterGroupModel` 可扩展更多信息字段  
- 替换 Cell 样式或头部视图，自由定制样式  
- 支持自定义外部弹窗容器（不强依赖 LEEAlert）  

## 许可证
MIT License
