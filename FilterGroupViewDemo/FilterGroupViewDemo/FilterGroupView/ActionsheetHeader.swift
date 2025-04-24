//
//  ActionsheetHeader.swift
//  ZhongYangQiXiangTai
//
//  Created by 王杰 on 2025/4/24.
//

import UIKit
import SnapKit

class ActionsheetHeader: UIView {

    /// 新增：点击“确定”时的回调
    var confirmHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        addSubview(arrowButton)
        addSubview(titleLabel)
        addSubview(confirmButton)

        arrowButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(44)
        }

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        confirmButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(60)
        }
        // 给 confirmButton 绑定事件
        confirmButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        
        let line = UIView()
        addSubview(line)
        line.backgroundColor = .color229
        line.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
    }
    
    @objc private func didTapConfirm() {
        confirmHandler?()
    }
    
    let arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(.mapPopupRetract, for: .normal)
        return button
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "筛选"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .colorDarkGray
        return label
    }()

    let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("确定", for: .normal)
        button.setTitleColor(.color69144255, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
}
