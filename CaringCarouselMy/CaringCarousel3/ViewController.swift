//
//  ViewController.swift
//  CaringCarousel3
//
//  Created by Admin on 27.07.2023.
//

import UIKit

class ViewController: UIViewController {
    let data: [Int] = Array(1...15)

    let cellWidth: CGFloat = 300
     let cellHeight: CGFloat = 400

    let itemSpacing: CGFloat = 16
    let leftInset: CGFloat = 10
    var pageControl = UIPageControl()
    
    private lazy var collectionView: UICollectionView = {
      
        let layout = CustomCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = itemSpacing
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
      
        collection.backgroundColor = .systemBackground
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false

        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
     
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Collection"
        view.addSubview(collectionView)
        setupView()
    }
    
    private func setupView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = cellWidth
        let height: CGFloat = cellHeight
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return itemSpacing
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
     
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: leftInset)
    }
   }

extension ViewController: UICollectionViewDataSource {
       func collectionView( _ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return data.count
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
           let colors = Array(repeating: [UIColor.systemGray2, .systemGray3, .systemGray4], count: data.count).flatMap({ $0 })
           cell.backgroundColor = colors[indexPath.row]
           cell.layer.cornerRadius = 10
           return cell
       }
   }


