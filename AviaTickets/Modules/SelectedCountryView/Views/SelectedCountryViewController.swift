//
//  SelectedCountryViewController.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 04.06.2024.
//

import UIKit
import Combine

final class SelectedCountryViewController: UIViewController {

    //MARK: - Private properties
    
    private let viewModel: SelectedCountryViewModelProtocol
    private var selectedItem: SelectedCountryItemType = .departureDate
    private var cancelable: Set<AnyCancellable> = []
    
    //MARK: - UI elements
    
    private lazy var searchView: SelectedCountrySearchView = {
        let view = SelectedCountrySearchView()
        
        view.backButton.addTarget(self,
                                  action: #selector(backButtonTapped),
                                  for: .touchUpInside)
        view.replaceButton.addTarget(self,
                                     action: #selector(replaceButtonTapped),
                                     for: .touchUpInside)
        view.clearButton.addTarget(self,
                                   action: #selector(clearButtonTapped),
                                   for: .touchUpInside)
        
        return view
    }()
    
    private lazy var buttonList: UICollectionView = {
        let collectionViewlayout = UICollectionViewFlowLayout()
        
        collectionViewlayout.scrollDirection = .horizontal
        collectionViewlayout.estimatedItemSize = .init(width: Constants.itemListItemWidth,
                                                       height: Constants.itemListItemWidth)
        collectionViewlayout.minimumLineSpacing = Constants.itemListItemSpacing
        collectionViewlayout.minimumInteritemSpacing = Constants.itemListItemSpacing
    
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout:  collectionViewlayout)
        
        collectionView.contentInset = .init(top: .zero,
                                            left: Constants.itemListHorizontalContentInsents,
                                            bottom: .zero,
                                            right: Constants.itemListHorizontalContentInsents)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(SelectedCountryItem.self,
                                forCellWithReuseIdentifier: SelectedCountryItem.identifire)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var ticketsList: TicketOfferListView = {
        let view = TicketOfferListView()
        
        view.tableView.dataSource = self
        view.tableView.delegate = self
        
        return view
    }()
    
    private lazy var showAllTicketsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle(StringConstants.showAllTicketsButtonTitle,
                        for: .normal)
        button.setTitleColor(Colors.showAllTicketsButtonNormal, for: .normal)
        button.backgroundColor = Colors.showAllTicketsButtonBackground
        button.layer.cornerRadius = Constants.showAllTicketsButtonCornerRadius
        button.titleLabel?.font = Fonts.buttonText1
        button.addTarget(self,
                         action: #selector(showAllTicketsButtonTapped),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var subscribeView: SelectedCountrySubscribeView = {
        let view = SelectedCountrySubscribeView()
        
        view.subscribeSwitch.addTarget(self,
                                       action: #selector(subscribeSwitchChanged),
                                       for: .valueChanged)
        
        return view
    }()
    
    private lazy var datePicker: CalendarView = {
        let view = CalendarView()
        
        view.center = self.view.center
        
        return view
    }()
    
    //MARK: - Initialaizers
    
    public init(viewModel: SelectedCountryViewModelProtocol) {
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
        layout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.didFinish()
    }

}

//MARK: - Extension with UITableViewDataSource implementation

extension SelectedCountryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ticketOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: TicketOfferListCell.indentifire,
                                 for: indexPath) as? TicketOfferListCell
        else { return .init() }
        
        let data = viewModel.ticketOffers[indexPath.row]
        
        cell.setup(image: indexPath.row, data: data)
        
        return cell
    }
    
}

//MARK: - Extension with UITableViewDelegate implementation

extension SelectedCountryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ticketsList.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - Extension with UICollectionViewDelegate implementation

extension SelectedCountryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let type = SelectedCountryItemType.allCases[indexPath.item]
        
        switch type {
        case .returningDay:
            selectedItem = type
            showCalendar()
        case .departureDate:
            selectedItem = type
            showCalendar()
        case .ticketClass:
            selectedItem = type
        case .filters:
            selectedItem = type
        }
    }
    
}

//MARK: - Extension with UICollectionViewDataSource implementation

extension SelectedCountryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SelectedCountryItemType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: SelectedCountryItem.identifire,
                                 for: indexPath) as? SelectedCountryItem
        else { return .init() }
        
        let type = SelectedCountryItemType.allCases[indexPath.item]
        let data = viewModel.itemData
        
        cell.setup(for: type, data: data)
        
        return cell
    }
    
}

//MARK: - Extension with private methods

private extension SelectedCountryViewController {
    
    func configuration() {
        view.backgroundColor = Colors.background
        
        view.addSubview(searchView)
        view.addSubview(buttonList)
        view.addSubview(ticketsList)
        view.addSubview(showAllTicketsButton)
        view.addSubview(subscribeView)
    }
    
    func layout() {
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(LayoutConstants.searchViewTop)
            $0.leading.equalToSuperview()
                .offset(LayoutConstants.horizontalOffset)
            $0.trailing.equalToSuperview()
                .inset(LayoutConstants.horizontalOffset)
        }
        
        buttonList.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom)
                .offset(LayoutConstants.buttonListTopOffset)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(LayoutConstants.buttonListHeight)
        }
        
        ticketsList.snp.makeConstraints {
            $0.top.equalTo(buttonList.snp.bottom)
                .offset(LayoutConstants.ticketsListViewTopOffset)
            $0.leading.equalToSuperview()
                .offset(LayoutConstants.horizontalOffset)
            $0.trailing.equalToSuperview()
                .inset(LayoutConstants.horizontalOffset)
            $0.height.equalTo(LayoutConstants.ticketsListHeight)
        }
        
        showAllTicketsButton.snp.makeConstraints {
            $0.top.equalTo(ticketsList.snp.bottom)
                .offset(LayoutConstants.showAllTicketsButtonTopOffset)
            $0.leading.equalToSuperview()
                .offset(LayoutConstants.horizontalOffset)
            $0.trailing.equalToSuperview()
                .inset(LayoutConstants.horizontalOffset)
            $0.height.equalTo(Constants.showAllTicketsButtonHeight)
        }
        
        subscribeView.snp.makeConstraints {
            $0.top.equalTo(showAllTicketsButton.snp.bottom)
                .offset(LayoutConstants.subscribeViewTopOffset)
            $0.leading.equalToSuperview()
                .offset(LayoutConstants.horizontalOffset)
            $0.trailing.equalToSuperview()
                .inset(LayoutConstants.horizontalOffset)
        }
        
    }
    
    func bind() {
        
        viewModel.departure.sink { [unowned self] data in
            searchView.departureTextField.text = data
        }.store(in: &cancelable)
        
        viewModel.arrival.sink { [unowned self] data in
            searchView.arrivalTextField.text = data
        }.store(in: &cancelable)
        
        searchView
            .arrivalTextField
            .textPublisher.sink { [unowned self] data in
                viewModel.setArrival(data: data)
            }.store(in: &cancelable)
        
        searchView.departureTextField
            .textPublisher.sink { [unowned self] data in
                viewModel.setDeparture(data: data)
            }.store(in: &cancelable)
        
        viewModel.isUpdateItemsView.sink { [unowned self] _ in
            buttonList.reloadData()
        }.store(in: &cancelable)
        
        viewModel.sibscribeOnThePrice.sink { [unowned self] data in
            subscribeView.subscribeSwitch.setOn(data, animated: true)
        }.store(in: &cancelable)
        
        viewModel.ticketOffersDowloadedPublisher.sink { [unowned self] _ in
            ticketsList.reloadTableView()
        }.store(in: &cancelable)
        
        datePicker.datePickerPublisher.sink { [unowned self] data in
            viewModel.setDate(type: selectedItem, data: data)
        }.store(in: &cancelable)
        
        datePicker.doneButtonPressedPublisher.sink { [unowned self] _ in
            hideCalendar()
        }.store(in: &cancelable)
        
        viewModel.isNetworkError.sink { [unowned self] error in
            showAlert(message: error)
        }.store(in: &cancelable)
        
    }
    
    @objc func backButtonTapped() {
        viewModel.popView()
    }
    
    @objc func replaceButtonTapped() {
        viewModel.replaceData()
    }
    
    @objc func clearButtonTapped() {
        viewModel.setArrival(data: .empty)
    }
    
    @objc func showAllTicketsButtonTapped() {
        viewModel.showTicketsListView()
    }
    
    @objc func subscribeSwitchChanged(_ sender: UISwitch) {
        viewModel.subscribeOnThePrice(data: sender.isOn)
    }
    
    func showCalendar() {
        if !view.subviews.contains(datePicker) {
            view.addSubview(datePicker)
        }
    }
    
    func hideCalendar() {
        if view.contains(datePicker) {
            datePicker.removeFromSuperview()
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: StringConstants.errorAlertTitle,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: StringConstants.alertActionTitle,
                                   style: .cancel)
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
}

//MARK: - Extension with private subobjects

private extension SelectedCountryViewController {
    
    enum Colors {
        static let background = R.color.backgroundBlackColor()
        static let showAllTicketsButtonNormal = R.color.whiteTextColor()
        static let showAllTicketsButtonBackground = R.color.darkBlue()
    }
    
    enum LayoutConstants {
        static let searchViewTop = 47.0
        static let horizontalOffset = 16.0
        static let showAllTicketsButtonTopOffset = 18.0
        static let subscribeViewTopOffset = 24.0
        static let ticketsListViewTopOffset = 15.0
        static let ticketsListHeight = 240.0
        static let buttonListTopOffset = 15.0
        static let buttonListHeight = 33.0
    }
    
    enum Constants {
        static let showAllTicketsButtonCornerRadius = 8.0
        static let showAllTicketsButtonHeight = 42.0
        static let itemListItemHeight = 33.0
        static let itemListItemWidth = 50.0
        static let itemListItemSpacing = 8.0
        static let itemListHorizontalContentInsents = 16.0
    }
    
    enum StringConstants {
        static let showAllTicketsButtonTitle = "Показать все билеты"
        static let alertActionTitle = "OK"
        static let errorAlertTitle = "Ошибка"
    }
}
