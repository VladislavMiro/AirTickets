//
//  TicketsListViewController.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 06.06.2024.
//

import UIKit
import Combine

final class TicketsListViewController: UIViewController {

    //MARK: - Private properties
    
    private let viewModel: TicketsListViewModelProtocol
    private var cancelable: Set<AnyCancellable>
    
    //MARK: - UI elements
    
    private lazy var navigationView: TicketsListNavigationView = {
        let view = TicketsListNavigationView()
        
        view.addTarget(self,
                       action: #selector(backButtonTapped),
                       for: .touchUpInside)
        
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self,
                                 action: #selector(refreshData),
                                 for: .valueChanged)
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.itemSpacing
        layout.minimumInteritemSpacing = Constants.itemSpacing
        layout.estimatedItemSize = .init(width: Constants.estimatedItemWidth,
                                         height: Constants.estimatedItemHeight)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        collectionView.contentInset = UIEdgeInsets(top: Constants.contentInsetsTop,
                                                   left: .zero,
                                                   bottom: .zero,
                                                   right: .zero)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "Cell")
        
        return collectionView
    }()
    
    private lazy var bottomButtons: TicketsListBottomButtonView = {
        let view = TicketsListBottomButtonView()
        
        return view
    }()
    
    //MARK: - Imitialaizers
    
    public init(viewModel: TicketsListViewModelProtocol) {
        self.viewModel = viewModel
        cancelable = []
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        layout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }

}

//MARK: - Extension with UICollectionViewDataSource

extension TicketsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tickets.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .red
        
        return cell
    }
    
}

//MARK: - Extension with private methods

private extension TicketsListViewController {
    
    func configuration() {
        view.backgroundColor = Colors.background
        
        navigationView.set(title: viewModel.title,
                           subtitle: viewModel.subtitle)
        
        view.addSubview(navigationView)
        view.addSubview(collectionView)
        view.addSubview(bottomButtons)
    }
    
    func layout() {
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(Constants.layoutOffset)
            $0.leading.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.trailing.equalToSuperview()
                .inset(Constants.layoutOffset)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.equalToSuperview()
                .offset(Constants.layoutOffset)
            $0.trailing.equalToSuperview()
                .inset(Constants.layoutOffset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        bottomButtons.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                .inset(Constants.layoutOffset)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func bind() {
        
        viewModel.state.sink { [unowned self] state in
            switch state {
            case .downloaded:
                collectionView.reloadData()
            case .networkError(let error):
                showAlert(message: error)
            }
            collectionView.refreshControl?.endRefreshing()
        }.store(in: &cancelable)
        
    }
    
    @objc func backButtonTapped() {
        viewModel.popView()
    }
    
    @objc func refreshData() {
        viewModel.fetchData()
        collectionView.refreshControl?.beginRefreshing()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: StringConstants.alertTitle,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: StringConstants.alertActionTitle,
                                   style: .destructive)
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
}

//MARK: - Extension with private subobjects

private extension TicketsListViewController {
    
    enum Constants {
        static let layoutOffset = 16.0
        static let itemSpacing = 16.0
        static let estimatedItemWidth = 328.0
        static let estimatedItemHeight = 119.0
        static let contentInsetsTop = 26.0
    }
    
    enum StringConstants {
        static let alertTitle = "Ошибка"
        static let alertActionTitle = "OK"
    }
    
    enum Colors {
        static let background = R.color.backgroundBlackColor()
    }
    
}
