//
//  UniverseViewModel.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 08/01/23.
//

import Foundation

final class DashboardViewModel {
    //MARK: Closures
    var updateSegments: (([UniverseViewModel]) -> Void) = {_ in }
    var showAlert: ((String) -> Void) = {_ in }
    
    //MARK: Properties
    private let network: NetworkClient!
    private var segments = [UniverseViewModel]() {
        didSet {
            updateSegments(segments)
        }
    }
    
    //MARK: Initializer
    init() {
        network = NetworkClient()
    }
    
    //MARK: Methods
    func getUniverses() {
        let network = NetworkClient()
        
        let model = APIRequestModel(api: UniverseAPIs.getUniverses)
        _ = network.dataRequest(model, objectType: UniverseBase.self) { [weak self] (result: Result<UniverseBase, NetworkError>) in
            switch result {
            case let .success(response):
                self?.updateData(baseModel: response)
            case let .failure(error):
                self?.showAlert(error.localizedDescription)
            }
        }
    }
    
    /// Method takes base model as an argument and create different ViewModels for different tabs.
    /// - Parameter baseModel: UniverseBase
    private func updateData(baseModel: UniverseBase) {
        self.segments.removeAll()
        for i in 0..<baseModel.lineup.count {
            if let universeId = baseModel.lineup["universe\(i+1)"] {
                if let name = baseModel.universe[universeId]?.name {
                    var viewModel = UniverseViewModel(name: name, id: universeId)
                    viewModel.list = getSuperheroListWith(universeId: universeId, from: baseModel)
                    segments.append(viewModel)
                }
            }
        }
    }
    
    /// This method takes `UniverseId` and `BaseModel` as an argument and returns `[SuperheroCellViewModel]` for the universe.
    /// - Parameters:
    ///   - universeId: String
    ///   - baseModel: UniverseBase
    /// - Returns: [SuperheroCellViewModel]
    private func getSuperheroListWith(universeId: String, from baseModel: UniverseBase) -> [SuperheroCellViewModel] {
        var cellViewModels = [SuperheroCellViewModel]()
        baseModel.universe[universeId]?.superheroes.forEach({ (key, value) in
            var model = SuperheroCellViewModel(name: value.name)
            model.isLeader = value.isLeader
            model.imageURL = value.imageURL
            cellViewModels.append(model)
        })
        return cellViewModels
    }
}
