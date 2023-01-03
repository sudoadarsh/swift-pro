//
//  CustomCarousel.swift
//  swiftpro
//
//  Created by Adarsh Sudarsanan on 03/01/23.
//

import UIKit

// The custom carousel cell.
// MARK: - Custom carousel cell.

class CustomCarouselCell: UICollectionViewCell {
    
    // MARK: - Class properties.
    static let cellID: String = "CustomCarouselCell"
    
    // MARK: - Initialiser.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CustomCarouselCell {
    
    func setupUI(_ sender: UIView) {
        addSubview(sender)
    }
}

// MARK: - CustomCarouselView.

class CustomCarouselView: UIView {
    
    // MARK: - Class properties.
    struct CarouselData {
        let view: UIView
    }
    
    private var carouselData: [CarouselData] = []
    
    // MARK: - Subviews.
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .gray
        return pageControl
    }()
    
}

extension CustomCarouselView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCarouselCell.cellID, for: indexPath) as? CustomCarouselCell else {
            return UICollectionViewCell()
        }
        
        cell.setupUI(self.carouselData[indexPath.row].view)
        
        return cell
    }
    
    
}

extension CustomCarouselView {
    public func configure(with data: [CarouselData]) {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = carouselLayout
        
        self.carouselData = data
        self.collectionView.reloadData()
    }
}
