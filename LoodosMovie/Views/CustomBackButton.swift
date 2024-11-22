//
//  CustomBackButton.swift
//  LoodosMovie
//
//  Created by Uğur Altıntaş on 21.11.2024.
//

import UIKit

class CustomBackButton: UIButton {

    init(icon: UIImage = UIImage(systemName: "chevron.left")!,
         backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.6),
         size: CGFloat = 40) {
        super.init(frame: .zero)

        // Görsel ayarları
        self.setImage(icon, for: .normal)
        self.tintColor = .white
        self.backgroundColor = backgroundColor

        // Yuvarlak tasarım
        self.layer.cornerRadius = size / 2
        self.clipsToBounds = true

        // Buton boyutlandırma
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: size).isActive = true
        self.heightAnchor.constraint(equalToConstant: size).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
