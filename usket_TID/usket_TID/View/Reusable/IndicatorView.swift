//
//  IndicatorView.swift
//  usket_TID
//
//  Created by 이경후 on 2022/03/14.
//

import UIKit
import SnapKit

final class IndicatorView : UIView {
    
    let informLabel = UILabel()
    let activityView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfig()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig(){
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        informLabel.textAlignment = .center
        informLabel.textColor = .white
        informLabel.numberOfLines = 0
        informLabel.font = UIFont(name: Helper.shared.originalFont, size: 17)
        informLabel.text = I18N.wait
        activityView.style = .large
        activityView.color = .white
    }
    
    func setUI(){
        addSubview(activityView)
        addSubview(informLabel)
        
        informLabel.snp.makeConstraints { make in
            make.bottom.equalTo(activityView.snp.top)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        activityView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        activityView.startAnimating()
    }
    
    func stopAction(){
        activityView.stopAnimating()
    }
}
