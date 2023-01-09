//
//  UniversesVC.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 07/01/23.
//

import UIKit

final class UniversesVC: UIViewController {
    //MARK: Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: SuperheroTableCell.cellId, bundle: nil), forCellReuseIdentifier: SuperheroTableCell.cellId)
        return tableView
    }()
    
    var viewModel: UniverseViewModel?
    
    //MARK: Initializer
    convenience init(_viewModel: UniverseViewModel) {
        self.init()
        self.viewModel = _viewModel
    }
    
    //MARK: Lifecycle Methods
    override func loadView() {
        super.loadView()
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK: Methods
    private func setUpUI() {
        self.title = self.viewModel?.name
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -12).isActive = true
    }
}

//MARK: Table DataSource
extension UniversesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.list.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.viewModel?.list[indexPath.row] else {
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SuperheroTableCell.cellId, for: indexPath) as? SuperheroTableCell else {
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        }
        cell.set(_viewModel: model)
        return cell
    }
}
