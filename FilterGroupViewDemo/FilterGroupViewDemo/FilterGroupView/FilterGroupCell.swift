//
//  UICollectionViewCell.swift
//  ZhongYangQiXiangTai
//
//  Created by 王杰 on 2025/4/24.
//
import UIKit

class FilterGroupCell: UICollectionViewCell {
    
    func configure(info: FilterGroupOption, selected: Bool) {
        titleLabel.text = info.title
        if selected {
            applyGradientBackground()
            backgroundViewForGradient.layer.borderWidth = 0
            titleLabel.textColor = .white
            titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        } else {
            removeGradientBackground()
            backgroundViewForGradient.backgroundColor = .white
            titleLabel.textColor = .color102
            titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
            backgroundViewForGradient.layer.borderWidth = 0.5
            backgroundViewForGradient.layer.borderColor = UIColor.color229.cgColor
        }
    }
    
    
    static let reuseID = "FilterGroupCell"

    private let backgroundViewForGradient: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkText
        label.backgroundColor = .clear
        return label
    }()

    private var gradientLayer: CAGradientLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(backgroundViewForGradient)
        backgroundViewForGradient.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundViewForGradient.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func applyGradientBackground() {
        removeGradientBackground()
        backgroundViewForGradient.layoutIfNeeded()

        let gradient = CAGradientLayer()
        gradient.colors = CAGradientLayer.standardBlueGradientColors
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = backgroundViewForGradient.bounds
        gradient.cornerRadius = 16

        backgroundViewForGradient.layer.insertSublayer(gradient, at: 0)
        gradientLayer = gradient
    }

    private func removeGradientBackground() {
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil
    }
}
