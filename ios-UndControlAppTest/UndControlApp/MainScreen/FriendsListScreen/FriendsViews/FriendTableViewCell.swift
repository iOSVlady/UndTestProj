//
//  FriendTableViewCell.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 06.08.2023.
//

import UIKit
import SnapKit
import SwiftUI

class FriendTableViewCell: UITableViewCell {
    
    public var option: Bool = false
    private var containerView: UIView! // Create a containerView for the rounded background
    private(set) var friendImageView: UIImageView!
    private(set) var nameLabel: UILabel!
    private(set) var button: UIButton?

    // Add a delete action handler closure
    var addAction: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        backgroundColor = .clear
        
        containerView = UIView()
        containerView.backgroundColor = UIColor(Color.customColor7)
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.height.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        friendImageView = UIImageView()
        friendImageView.layer.cornerRadius = 20
        friendImageView.layer.masksToBounds = true // Clip the image to the bounds
        containerView.addSubview(friendImageView)
        friendImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        nameLabel = UILabel()
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(friendImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        nameLabel.textColor = UIColor(Color.customColor1)
        nameLabel.font = UIFont.customFont(family: .nunito, style: .regular, size: 16)

        setupButton()
    }
    
    func setupButton() {
        if button == nil {
            button = UIButton(type: .system)
            guard let button = button else { return }
            containerView.addSubview(button)
            button.tintColor = .white
            button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

            button.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(12)
                make.centerY.equalToSuperview()
            }
        }

        let image = UIImage(named: option ? "add-icon" : "remove-friend")
        let scaledImage = scaledImage(from: image, newSize: CGSize(width: 30, height: 30))
        button?.setImage(scaledImage, for: .normal)
    }
    
    
    func configure(with urlString: String) {
        if let url = URL(string: urlString) {
            friendImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    private func scaledImage(from image: UIImage?, newSize: CGSize) -> UIImage? {
        guard let image = image else { return nil }
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }

    // Button tap handler
    @objc private func addButtonTapped() {
        addAction?()
    }
}
