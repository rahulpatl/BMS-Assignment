//
//  SuperheroTableCell.swift
//  BMS Assignment
//
//  Created by Rahul Patil on 08/01/23.
//

import UIKit

final class SuperheroTableCell: UITableViewCell {
    //MARK: Properties
    static let cellId = "SuperheroTableCell"
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var imgSuperhero: UIImageView!
    @IBOutlet weak var lblSuperhero: UILabel!
    @IBOutlet weak var lblLeader: UILabel!
    private var imageDownloader: ImageDownloader?
    private var viewModel: SuperheroCellViewModel? {
        didSet {
            lblSuperhero.text = viewModel?.name
            lblSuperhero.textColor = .systemGray
            viewParent.backgroundColor = .clear
            lblLeader.isHidden = true
            if let isLeader = viewModel?.isLeader, isLeader {
                viewParent.backgroundColor = .red.withAlphaComponent(0.8)
                lblSuperhero.textColor = .white
                lblLeader.isHidden = false
                lblLeader.textColor = .white
            }
        }
    }
    
    //MARK: Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        /// Cell goes beyond list and operation is not completed then cances the operation.
        imageDownloader?.cancelDownload()
    }
    
    //MARK: Data update method
    func set(_viewModel: SuperheroCellViewModel) {
        imgSuperhero.image = nil
        self.viewModel = _viewModel
        if let url = URL(string: _viewModel.imageURL ?? "") {
            imageDownloader = self.viewModel?.getImage(url: url, handler: { [weak self] imageData in
                DispatchQueue.main.async {
                    self?.imgSuperhero.image = imageData ?? UIImage(systemName: Constants.person)
                }
            })
        }
    }
    

}
