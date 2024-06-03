//
//  AirTicketsMusicSectionCell.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 02.06.2024.
//

import UIKit

final class AirTicketsMusicSectionCell: UITableViewCell {
 
    //MARK: - Public properties
    
    public static let identifire = "AirTicketsMusicSectionCell"
    
    //MARK: - Privavte properties
    
    private var viewModel: AirTicketsMusicSectionViewModelProtocol?
    
    //MARK: - UI elements
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: Constants.itemWidth,
                                 height: Constants.itemHeight)
        layout.minimumInteritemSpacing = Constants.itemSpacing
        layout.minimumLineSpacing = Constants.itemSpacing
        layout.sectionInset = UIEdgeInsets(top: Constants.verticalSectionInsets,
                                           left: Constants.horizontalSectionInsets,
                                           bottom: Constants.verticalSectionInsets,
                                           right: Constants.horizontalSectionInsets)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AirTicketsMusicCell.self,
                                forCellWithReuseIdentifier: AirTicketsMusicCell.identifire)
        
        return collectionView
    }()
    
    //MARK: - Initialaizers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuration()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Extension with UICollectionViewDataSource implementation

extension AirTicketsMusicSectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.outputData.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: AirTicketsMusicCell.identifire,
                                 for: indexPath) as? AirTicketsMusicCell,
              let data = viewModel?.outputData[indexPath.row]
        else { return .init() }
        
        cell.setup(data: data)
        
        return cell
    }
    
}

//MARK: - Extension with public methods

extension AirTicketsMusicSectionCell {
    
    public func setup(viewModel: AirTicketsMusicSectionViewModelProtocol) {
        self.viewModel = viewModel
        
        viewModel.prepareData()
        
        collectionView.reloadData()
    }
    
}

//MARK: - Extension with private methods

private extension AirTicketsMusicSectionCell {
    
    func configuration() {
        backgroundColor = R.color.backgroundBlackColor()
        contentView.addSubview(collectionView)
    }
    
    func layout() {
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(Constants.colectionViewHeight)
        }
        
    }
    
}

//MARK: - Extension with private subobjects

private extension AirTicketsMusicSectionCell {
    
    enum Constants {
        static let colectionViewHeight = 213.0
        static let itemSpacing = 20.0
        static let horizontalSectionInsets = 20.0
        static let verticalSectionInsets = 15.0
        static let itemHeight = 213.0
        static let itemWidth = 132.0
    }
    
}
