//
//  FilterGroupView.swift
//  ZhongYangQiXiangTai
//
//  Created by 王杰 on 2025/4/23.
//
import UIKit

// MARK: - 自定义分组筛选视图
class FilterGroupView: UIView {

    func collectionContentHeight() -> CGFloat {
        layoutIfNeeded()
        return myCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    var selectionHandler: ((IndexPath) -> Void)?
    /// 点击“确定”时，把所有 section 的当前选项传出去
    var confirmSelectionHandler: (([IndexPath]) -> Void)?

        
    private var sections: [FilterGroupModel]

    private lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.alwaysBounceVertical = true
        cv.register(FilterGroupCell.self, forCellWithReuseIdentifier: FilterGroupCell.reuseID)
        cv.register(FilterGroupSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilterGroupSectionHeaderView.reuseID)
        return cv
    }()

    init(sections: [FilterGroupModel]) {
        self.sections = sections
        super.init(frame: .zero)

        let headerV = ActionsheetHeader(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: 53))
        
        headerV.confirmHandler = { [weak self] in
            guard let self = self else { return }
            let selectedIndexPaths = self.sections.enumerated().map { section, model in
                IndexPath(item: model.selectedIndex ?? 0, section: section)
            }
            self.confirmSelectionHandler?(selectedIndexPaths)
        }
        
        headerV.backgroundColor = .white
        addSubview(headerV)
        addSubview(myCollectionView)
        
        headerV.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        myCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerV.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - UICollectionViewDataSource
extension FilterGroupView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].options.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterGroupCell.reuseID, for: indexPath) as! FilterGroupCell
        let sec = sections[indexPath.section]
        let isSel = (sec.selectedIndex == indexPath.item)
        cell.configure(info: sec.options[indexPath.item], selected: isSel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FilterGroupSectionHeaderView.reuseID, for: indexPath) as! FilterGroupSectionHeaderView
        header.configure(title: sections[indexPath.section].title)
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FilterGroupView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousIndex = sections[indexPath.section].selectedIndex
        sections[indexPath.section].selectedIndex = indexPath.item

        var indexPathsToReload: [IndexPath] = [indexPath]
        if let previous = previousIndex, previous != indexPath.item {
            indexPathsToReload.append(IndexPath(item: previous, section: indexPath.section))
        }

        UIView.performWithoutAnimation {
            collectionView.reloadItems(at: indexPathsToReload)
        }

        selectionHandler?(indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return sections[section].layoutConfig.interItemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 38)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let config = sections[indexPath.section].layoutConfig
        let sectionSpacing = 16.0 * 2 + CGFloat(config.itemsPerRow - 1) * config.interItemSpacing
        let _width = floor((SCREEN_WIDTH - sectionSpacing) / CGFloat(config.itemsPerRow))
        return CGSize(width: _width, height: 32)
    }
}


