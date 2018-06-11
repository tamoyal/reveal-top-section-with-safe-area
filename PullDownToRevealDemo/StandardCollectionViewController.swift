//
//  ViewController.swift
//  PullDownToRevealDemo
//
//  Created by Tony Amoyal on 6/11/18.
//  Copyright © 2018 Tony Amoyal. All rights reserved.
//

import UIKit

class StandardCollectionViewController: UIViewController {
    let cellID = "cellID"
    let headerCellID = "headerCellID"
    let revealSectionHeight: CGFloat = 100

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.alwaysBounceVertical = true
        v.dataSource = self
        v.delegate = self
        v.backgroundColor = UIColor.clear

        // https://instagram.github.io/IGListKit/working-with-uicollectionview.html
        if #available(iOS 10.0, *) {
            v.isPrefetchingEnabled = false
        } else {
            // Fallback on earlier versions
        }

        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.gray
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.register(DataCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: headerCellID)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("view.safeAreaInsets.top:", view.safeAreaInsets.top)
        collectionView.contentInset.top = -revealSectionHeight
        collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
}

extension StandardCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 20
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerCellID, for: indexPath) as! HeaderCell
            cell.backgroundColor = UIColor.green
            cell.myLabel.text = "HEADER CELL"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DataCell
            cell.backgroundColor = UIColor.blue
            cell.myLabel.text = "\(indexPath.section):\(indexPath.row)"
            return cell
        }
    }
}

extension StandardCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: revealSectionHeight)
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: 48)
        }
    }
}

extension StandardCollectionViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("")
        print("adjustedContentInset.top:", scrollView.adjustedContentInset.top)
        print("contentInset.top:", scrollView.contentInset.top)
        print("contentOffset.y:", scrollView.contentOffset.y)
        print("contentSize:", scrollView.contentSize)

        // Reveal if we hit threshold
        if scrollView.contentOffset.y < -10 && scrollView.contentInset.top != 0 {
            UIView.animate(withDuration: 0.25) {
                scrollView.contentInset.top = 0
            }
        }
    }
}
