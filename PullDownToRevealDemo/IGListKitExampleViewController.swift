//
//  IGListKitExampleViewController.swift
//  PullDownToRevealDemo
//
//  Created by Tony Amoyal on 6/11/18.
//  Copyright © 2018 Tony Amoyal. All rights reserved.
//

import IGListKit

class IGListKitExampleViewController: UIViewController {
    let headerKey = "4376527865746875643"
    let data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"]

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.alwaysBounceVertical = true

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

        collectionView.backgroundColor = UIColor.gray
        view.addSubview(collectionView)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("view.safeAreaInsets.top:", view.safeAreaInsets.top)
        collectionView.contentInset.top = -HeaderSectionController.revealSectionHeight
        collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
}

extension IGListKitExampleViewController: UIScrollViewDelegate {
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

extension IGListKitExampleViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [headerKey as ListDiffable] + data.map { $0 as ListDiffable }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let o = object as? String, o == headerKey {
            return HeaderSectionController()
        } else {
            return DataSectionController()
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

final class DataSectionController: ListSectionController {
    private var object: String?

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 64)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: DataCell.self, for: self, at: index) as? DataCell else {
            fatalError()
        }
        cell.backgroundColor = UIColor.blue
        cell.myLabel.text = object
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? String
    }
}

final class HeaderSectionController: ListSectionController {
    static var revealSectionHeight: CGFloat = 100.0
    private var object: String?

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: HeaderSectionController.revealSectionHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: HeaderCell.self, for: self, at: index) as? HeaderCell else {
            fatalError()
        }
        cell.backgroundColor = UIColor.green
        cell.myLabel.text = "hEaDeR CeLL"
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? String
    }
}
