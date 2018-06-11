//
//  HeaderCell.swift
//  PullDownToRevealDemo
//
//  Created by Tony Amoyal on 6/11/18.
//  Copyright © 2018 Tony Amoyal. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    lazy var myLabel: UILabel = {
        return UILabel()
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(myLabel)
        myLabel.frame = self.bounds
    }
}
