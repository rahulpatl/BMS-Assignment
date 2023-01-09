//
//  DashboardVC.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 09/01/23.
//

import UIKit

final class DashboardVC: UITabBarController, UITabBarControllerDelegate {
    //MARK: Properties
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        return loader
    }()
    
    lazy var loaderView: UIView = {
        let loaderView = UIView(frame: UIScreen.main.bounds)
        loaderView.addSubview(loader)
        loaderView.backgroundColor = .lightGray.withAlphaComponent(0.8)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor).isActive = true
        loader.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loader.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return loaderView
    }()
    
    var viewModel = DashboardViewModel()
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.tabBar.tintColor = .red
        updateData()
    }
    
    //MARK: Methods
    private func updateData() {
        viewModel.updateSegments = { [weak self] list in
            self?.updateSegment(models: list)
        }
        viewModel.showAlert = { [weak self] message in
            self?.showAlertWith(message: message)
        }
        loader(startAnimating: true)
        viewModel.getUniverses()
    }

    private func updateSegment(models: [UniverseViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.loader(startAnimating: false)
            var controller = [UIViewController]()
            for (index, item) in models.enumerated() {
                let viewController = UniversesVC(_viewModel: item)
                viewController.title = item.name
                controller.append(viewController)
            }
            self.title = controller.first?.title
            self.viewControllers = controller
        }
    }
    
    private func showAlertWith(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.loader(startAnimating: false)
            let alert = UIAlertController(title: Constants.alert, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.retry, style: .destructive, handler: {_ in
                self?.viewModel.getUniverses()
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    private func loader(startAnimating: Bool) {
        if startAnimating {
            self.view.addSubview(loaderView)
            loader.startAnimating()
        } else {
            loader.stopAnimating()
            loaderView.removeFromSuperview()
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.title = viewController.title
    }
}
