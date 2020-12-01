//
//  RestCell.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import UIKit

class RestCell: UITableViewCell {

    static let identifier: String = "RestCell"
    static let rowHeight: CGFloat = 66.0
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var viewModel: RestCellViewModel?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        unbindViewToViewModel()
    }

    public func configureCell(viewModel: RestCellViewModel) {
        self.viewModel = viewModel
        bindViewToViewModel()
    }
    
    private func bindViewToViewModel() {
        viewModel?.name.valueChanged = { [weak self] (name) in
            self?.nameLabel.text = name
        }
        viewModel?.category.valueChanged = { [weak self] (category) in
            self?.categoryLabel.text = category
        }
        viewModel?.description.valueChanged = { [weak self] (description) in
            self?.descriptionLabel.text = description
        }
    }
    
    private func unbindViewToViewModel() {
        viewModel?.name.valueChanged = nil
        viewModel?.category.valueChanged = nil
        viewModel?.description.valueChanged = nil
    }
}
