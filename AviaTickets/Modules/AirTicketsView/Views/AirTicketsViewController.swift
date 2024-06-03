//
//  AirTicketsViewController.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 01.06.2024.
//

import UIKit
import Combine

final class AirTicketsViewController: UITableViewController {
    
    //MARK: - Private properties
    
    private let viewModel: AirTicketsViewModelProtocol
    private var cancelabel = Set<AnyCancellable>()
    
    //MARK: - UI elements
    
    private lazy var header: AirTicketsHeader = {
        let header = AirTicketsHeader()
        
        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        header.frame.size = size
        
        return header
    }()
    
    //MARK: - Initialaizers
    
    public init(viewModel: AirTicketsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadCachedData()
        viewModel.fetchData()
    }
    
}

extension AirTicketsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Secions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = Secions.allCases[indexPath.section]
        
        switch section {
        case .MusicSection:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: AirTicketsMusicSectionCell.identifire,
                                     for: indexPath) as? AirTicketsMusicSectionCell
            else { return .init() }
            
            let data = viewModel.offers
            let viewModel = AirTicketsMusicSectionViewModel(data: data)
            
            cell.setup(viewModel: viewModel)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = Secions.allCases[section]
        let header = AirTicketsSectionHeader()
        
        header.title = section.description
        
        return header
    }
    
}

//MARK: - Extension with private methods

private extension AirTicketsViewController {
    
    func configuration() {
        view.backgroundColor = Colors.background
    
        navigationController?.isNavigationBarHidden = true
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.background
        tableView.tableHeaderView = header
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AirTicketsMusicSectionCell.self,
                           forCellReuseIdentifier: AirTicketsMusicSectionCell.identifire)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
    }
    
    func bind() {
        
        viewModel.statePublisher.sink { [unowned self] state in
            switch state {
            case .cacheDownloaded(let data):
                header.departureTextField.text = data
            case .downloaded:
                tableView.refreshControl?.endRefreshing()
                tableView.reloadData()
            case .error(let error):
                showAlert(message: error)
            }
        }.store(in: &cancelabel)
        
        header.departureTextField.textPublisher
            .filter { !$0.isEmpty }
            .assign(to: \.departure, on: viewModel)
            .store(in: &cancelabel)
        
        header.departureTextField.textChangingDidEndPublisher
            .sink { [unowned self] _ in
                viewModel.cachedInputData()
            }.store(in: &cancelabel)
        
        header.arivalTextField.textChangingBeginPublisher
            .sink { [unowned self] _ in
                header.arivalTextField.resignFirstResponder()
                viewModel.showSearchView()
            }.store(in: &cancelabel)
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: StringConstants.alertTitle,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: StringConstants.alertActionTitle,
                                   style: .cancel)
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        viewModel.fetchData()
    }
    
}

//MARK: - Extension with private subobjects

private extension AirTicketsViewController {
    
    enum Colors {
        static let background = R.color.backgroundBlackColor()
        static let textColor = R.color.whiteTextColor()
    }
    
    enum StringConstants {
        static let alertTitle = "Ошибка"
        static let alertActionTitle = "OK"
    }
    
    enum Constants {
        static let numberOfRows = 1
    }
    
    enum Secions: CaseIterable, CustomStringConvertible {
        case MusicSection
        
        var description: String {
            switch self {
            case .MusicSection:
                return "Музыкально отлететь"
            }
        }
    }
    
}
