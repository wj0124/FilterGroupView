//
//  ViewController.swift
//  FilterGroupViewDemo
//
//  Created by 王杰 on 2025/4/24.
//

import UIKit
import LEEAlert
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.height



/*
 func getStatusBarHeight() -> CGFloat {
     if #available(iOS 13.0, *) {
         let windowScene = UIApplication.shared.connectedScenes
             .filter { $0.activationState == .foregroundActive }
             .first as? UIWindowScene
         return windowScene?.statusBarManager?.statusBarFrame.height ?? 0
     } else {
         // 由于只兼容 iOS 13 及以上，这段 else 分支实际上不会执行
         return 0
     }
 }

 let statusBarHeight = getStatusBarHeight()
 */


let NAVIGATIONBAR_HEIGHT: CGFloat = 44
let IPHONEX_SAFE_HEIGHT: CGFloat = 34
// navigation高度
let NaviAndStatusHight: CGFloat = STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT
// tabbar高度
let TabBarHeight: CGFloat = STATUSBAR_HEIGHT > 20 ? 83: 49
// 是否是iphone x的屏幕类型
let iPhoneX = ((NaviAndStatusHight > 64) ? true : false)
// 底部安全高度
let BottomSafeHight: CGFloat = ((NaviAndStatusHight > 64) ? 34 : 0)



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        view.backgroundColor = .color217
        
        let btn = UIButton(frame: .init(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = .red
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
    }
    
    @objc func clickBtn() {
        showAlert()
    }
    
    
    func showAlert() {
        
        // 示例数据
        let sections = makeFilterSections()
        let filterView = FilterGroupView(sections: sections)
        filterView.backgroundColor = .white
        filterView.frame = .init(x: 0, y: 0, width: SCREEN_WIDTH, height: 300)
        let _height = filterView.collectionContentHeight()
        filterView.height = _height + 50
        
        // 设置选中回调
        filterView.selectionHandler = { indexPath in
            let a = sections[indexPath.section].title
            let b = sections[indexPath.section].options[indexPath.row].title ?? "-"
            print("[筛选选择] \(a): \(b)")
        }
        
        filterView.confirmSelectionHandler = { indexPaths in
            indexPaths.forEach { ip in
                let sec = sections[ip.section]
                let opt = sec.options[ip.item]
                let title = sec.title
                let optionTitle = opt.title ?? "-"
                print("[确定选择] \(title)：\(optionTitle)")
            }
        }
        

        let alert = LEEAlert.actionsheet()
        _ = alert.config
            .leeActionSheetBackgroundColor(.white)
            .leeHeaderInsets(.init(top: 0, left: 0, bottom: 0, right: 0))
            .leeMaxWidth(SCREEN_WIDTH)
//            .leeAddCustomView { cus in cus.view = headerV }
//            .leeItemInsets(.init(top: 0, left: 0, bottom: 10, right: 0))
            .leeAddCustomView { cus in cus.view = filterView }
            .leeClickBackgroundClose(true)
            .leeActionSheetBottomMargin(BottomSafeHight)
            .leeShow()
    }
    
    private func makeFilterSections() -> [FilterGroupModel] {
        return [
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
                options: ["全国", "北京", "天津", "河北", "山西", "内蒙古", "辽宁", "吉林", "黑龙江", "上海", "江苏", "浙江"]
                    .map { FilterGroupOption(title: $0, extra: nil) },
                selectedIndex: 0,
                layoutConfig: SectionLayoutConfig(itemsPerRow: 4, interItemSpacing: 13)
            )
        ]
    }


}

