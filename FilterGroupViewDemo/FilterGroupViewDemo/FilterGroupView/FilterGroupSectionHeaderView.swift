//
//  FilterGroupSectionHeaderView.swift
//  ZhongYangQiXiangTai
//
//  Created by 王杰 on 2025/4/24.
//

import UIKit

// MARK: - Section Header
class FilterGroupSectionHeaderView: UICollectionReusableView {
    static let reuseID = "FilterGroupSectionHeaderView"

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        gradientLayer.colors = CAGradientLayer.standardBlueGradientColors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = line.bounds
        line.layer.insertSublayer(gradientLayer, at: 0)

        addSubview(line)
        line.layer.masksToBounds = true
        line.layer.cornerRadius = 2.5
        line.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 5.0, height: 18.0))
        }

        addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(line.snp.right).offset(6)
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    let line = UIView()
    let gradientLayer = CAGradientLayer()

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = line.bounds
    }

    func configure(title: String) {
        titleLab.text = title
    }

    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .colorDarkGray
        lab.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return lab
    }()
}


extension CAGradientLayer {
    static var standardBlueGradientColors: [CGColor] {
        return [
            UIColor(red: 46/255, green: 129/255, blue: 255/255, alpha: 1).cgColor,
            UIColor(red: 69/255, green: 189/255, blue: 250/255, alpha: 1).cgColor
        ]
    }
}
