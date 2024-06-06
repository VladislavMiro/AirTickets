//
//  SearchTicketsViewController.swift
//  AviaTickets
//
//  Created by Vladislav Miroshnichenko on 03.06.2024.
//

import UIKit
import Combine

final class SearchTicketsViewController: UIViewController {

    //MARK: - Private properties
    
    private let viewModel: SearchTicketsViewModelProtocol
    private var cancelable: Set<AnyCancellable>
    
    //MARK: - UI elements
    
    private lazy var viewLine: UIView = {
        let view = UIView()
        
        view.backgroundColor = Colors.viewLine
        view.layer.cornerRadius = Constants.viewLineCornerRadius
        
        return view
    }()
    
    private lazy var searhInputView: SearchInputView = {
        let view = SearchInputView()
        
        view.arrivalTextField.addClearButtonTarget(self,
                                                   action: #selector(clearButtonTapped),
                                                   for: .touchUpInside)
        
        return view
    }()
    
    private lazy var buttonList: SearchViewButtonList = {
        let view = SearchViewButtonList()
        
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchViewCityCell.self,
                           forCellReuseIdentifier: SearchViewCityCell.indentifire)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorColor = R.color.grey4()
        tableView.separatorInset = .init(top: .zero, 
                                         left: Constants.tableViewSeparatorHorizontalInsets,
                                         bottom: .zero,
                                         right: Constants.tableViewSeparatorHorizontalInsets)
        
        return tableView
    }()
    
    private lazy var tableViewSection: UIView = {
        let view = UIView()
        
        view.backgroundColor = Colors.tableViewSection
        view.layer.cornerRadius = Constants.tableViewSectionCornerRadius
        view.layer.masksToBounds = true
        
        return view
    }()
    
    //MARK: - Initialaizers
    
    public init(viewModel: SearchTicketsViewModelProtocol) {
        self.viewModel = viewModel
        
        cancelable = Set<AnyCancellable>()
        
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
        searhInputView.departureTextField.text = viewModel.departure
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.didFinish()
    }
    
    //MARK: - Overrided methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

}

//MARK: - Extension with UITableViewDataSource implementation

extension SearchTicketsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: SearchViewCityCell.indentifire,
                                 for: indexPath) as? SearchViewCityCell
        else { return .init() }
        
        let data = viewModel.cities[indexPath.row]
        
        cell.setup(data: data)
        
        return cell
    }
    
}

//MARK: - Extension with UITableViewDelegate implementation

extension SearchTicketsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectRow(at: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        searhInputView.arrivalTextField.becomeFirstResponder()
    }
    
}

//MARK: - Extension with private methods

private extension SearchTicketsViewController {
    
    func configuration() {
        view.backgroundColor = Colors.background
        
        tableViewSection.addSubview(tableView)
        
        view.addSubview(viewLine)
        view.addSubview(searhInputView)
        view.addSubview(buttonList)
        view.addSubview(tableViewSection)
    }
    
    func layout() {
        
        viewLine.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(LayoutConstants.viewLineTop)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(LayoutConstants.viewLineWidth)
            $0.height.equalTo(LayoutConstants.viewLineHeight)
        }
        
        searhInputView.snp.makeConstraints {
            $0.top.equalTo(viewLine.snp.bottom)
                .offset(LayoutConstants.searchInputViewTop)
            $0.leading.equalToSuperview()
                .offset(LayoutConstants.horizontalSpacing)
            $0.trailing.equalToSuperview()
                .inset(LayoutConstants.horizontalSpacing)
            $0.height.equalTo(LayoutConstants.searchInputViewHeight)
        }
        
        buttonList.snp.makeConstraints {
            $0.top.equalTo(searhInputView.snp.bottom)
                .offset(LayoutConstants.buttonListTopOffset)
            $0.leading.equalToSuperview()
                .offset(LayoutConstants.horizontalSpacing)
            $0.trailing.equalToSuperview()
                .inset(LayoutConstants.horizontalSpacing)
        }
        
        tableViewSection.snp.makeConstraints {
            $0.top.equalTo(buttonList.snp.bottom)
                .offset(LayoutConstants.tableViewSectonTop)
            $0.leading.equalToSuperview()
                .offset(LayoutConstants.horizontalSpacing)
            $0.trailing.equalToSuperview()
                .inset(LayoutConstants.horizontalSpacing)
            $0.height.equalTo(LayoutConstants.tableViewSectionHeight)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
                .offset(LayoutConstants.tableViewTopOffset)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
    func bind() {
        
        viewModel.arrival.sink { [unowned self] data in
            searhInputView.arrivalTextField.text = data
        }.store(in: &cancelable)
        
        searhInputView.arrivalTextField
            .textPublisher
            .sink(receiveValue: { [unowned self] data in
                viewModel.setArrival(data: data)
            })
            .store(in: &cancelable)
        
        searhInputView.keyboardDoneButtonPublisher
            .sink { [unowned self] _ in
                //Если текстовое поле не пустое и нажата кнопка возврата на клавиатуре
                //переход к пункту 3
                viewModel.showSekectedCountryView()
            }.store(in: &cancelable)
        
    }
    
    @objc func buttonTapped(_ button: SearchViewButton) {
        viewModel.buttonTapped(type: button.type)
    }
    
    @objc func clearButtonTapped() {
        viewModel.setArrival(data: .empty)
    }
    
}

//MARK: - Extension with private subobjects

private extension SearchTicketsViewController {
    
    enum Colors {
        static let background = R.color.grey2()
        static let viewLine = R.color.grey5()
        static let tableViewSection = R.color.grey3()
    }
    
    enum Constants {
        static let viewLineCornerRadius = 3.0
        static let tableViewSeparatorHorizontalInsets = 16.0
        static let tableViewSectionCornerRadius = 16.0
    }
    
    enum LayoutConstants {
        static let viewLineTop = 16.0
        static let viewLineWidth = 38.0
        static let viewLineHeight = 5.0
        static let searchInputViewTop = 25.0
        static let searchInputViewHeight = 96.0
        static let horizontalSpacing = 16.0
        static let tableViewTopOffset = 16.0
        static let tableViewSectonTop = 26.0
        static let tableViewSectionHeight = 216.0
        static let buttonListTopOffset = 26.0
    }
    
}
