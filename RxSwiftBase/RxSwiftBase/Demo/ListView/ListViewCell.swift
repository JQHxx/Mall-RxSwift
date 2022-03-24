//
//  ListViewCell.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    private(set) var disposeBag = DisposeBag()

    // Cell重用，disposeBag要重新声明
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
