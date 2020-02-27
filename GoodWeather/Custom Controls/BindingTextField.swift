//
//  BindingTextField.swift
//  GoodWeather
//
//  Created by 배상렬 on 2020/02/28.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class BindingTextField: UITextField
{
    
    var textChangeClosure: (String) -> () = { _ in }
    
    func bind(callback: @escaping (String)->())
    {
        self.textChangeClosure = callback;
    }
    
    // MARK: - Init
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        commonInit();
    }

    required init?(coder aDecoder: NSCoder)
    {
       super.init(coder: aDecoder)
        commonInit();
    }

    
    
    
    
    private func commonInit()
    {
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged);
    }
    
    @objc
    func textFieldDidChange(_ textField:UITextField)
    {
        if let text = textField.text
        {
            self.textChangeClosure(textField.text!);
            
        }
    }
        
    
}
