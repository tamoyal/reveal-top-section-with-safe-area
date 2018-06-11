//
//  DataCell.swift
//  PullDownToRevealDemo
//
//  Created by Tony Amoyal on 6/11/18.
//  Copyright © 2018 Tony Amoyal. All rights reserved.
//

import UIKit

class DataCell: UICollectionViewCell {
    lazy var myLabel: UILabel = {
        return UILabel()
    }()

    lazy var topLine: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        v.backgroundColor = UIColor.yellow
        return v
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
        addSubview(topLine)
        myLabel.frame = self.bounds
    }
}
