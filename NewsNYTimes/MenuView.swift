//
//  MenuView.swift
//  NewsNYTimes
//
//  Created by Anastasia on 2/21/18.
//  Copyright © 2018 Anastasia. All rights reserved.
//

import UIKit

protocol MenuViewDelegate: class {
    func menuView(didSelectItem item: String)
}

@IBDesignable
class MenuView: UIView {
    
    // MARK: - IBInspectable Properties
    @IBInspectable var amountButtons: Int = 7
    @IBInspectable var colorNormal: UIColor = UIColor(displayP3Red: 51/255.0,
                                                      green: 51/255.0,
                                                      blue: 76/255.0,
                                                      alpha: 1)
    @IBInspectable var colorSelected: UIColor = UIColor(displayP3Red: 214/255.0,
                                                        green: 75/255.0,
                                                        blue: 116/255.0,
                                                        alpha: 1)
    
    
    // MARK: - Properties
    weak var delegate: MenuViewDelegate?
    
    var imagesNames: [String] = []
    private var buttonsArray: [UIButton] = []
    private let durationAnimation = 0.3
    private var buttonSize:CGFloat = -1.0
    
    // MARK: - Inits
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.createAndSetButtons(height: rect.height)
    }
}

// MARK: - Private
private extension MenuView {
    func createAndSetButtons(height: CGFloat) {
        buttonSize = self.bounds.height / CGFloat(amountButtons)
        
        let translate = CATransform3DMakeTranslation(-buttonSize/2.0, 0, 0)
        let rotation = CATransform3DRotate(translate, 90.0*CGFloat(Double.pi)/180.0, 0, 0.9, 0)
        
        for i in 0..<amountButtons {
            let button = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: buttonSize * CGFloat(i)),
                                                size: CGSize(width: buttonSize, height: buttonSize)))
            
            button.titleLabel?.textColor = .white
            button.backgroundColor = colorNormal
            button.setImage(UIImage(named: imagesNames[i]), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            button.layer.transform = rotation
            button.setTitle(imagesNames[i], for: .normal)
            button.addTarget(self, action: #selector(self.menuItemPressed(sender:)), for: .touchUpInside)
            
            buttonsArray.append(button)
            self.addSubview(button)
        }
    }
}

// MARK: - Public
extension MenuView {
    func updateFrames(_ size: CGSize, _ navBarHeight: CGFloat, _ statusBarHeight: CGFloat) {
        buttonSize = (size.height - navBarHeight - statusBarHeight) / CGFloat(amountButtons)
        
        var i = 0
        for case let button as UIButton in self.subviews {
            button.frame = CGRect(origin: CGPoint(x: 0, y: buttonSize * CGFloat(i)),
                                  size: CGSize(width: buttonSize, height: buttonSize))
            i += 1
        }
    }
    
    func show() {
        for i in 0..<amountButtons {
            self.isHidden = false
            
            UIView.animate(withDuration: durationAnimation, delay: Double(i)/5.0, options: .curveLinear, animations:  {
                self.buttonsArray[i].layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    func hide() {
        let translate = CATransform3DMakeTranslation(-buttonSize/2.0, 0, 0)
        let rotation = CATransform3DRotate(translate, 90.0*CGFloat(Double.pi)/180.0, 0, 0.9, 0)
        
        var i = 0
        var visibleButtons = 0
        for case let button as UIButton in self.subviews.reversed() {
            visibleButtons += 1
            UIView.animate(withDuration: durationAnimation, delay: Double(i)/5.0, options: .curveLinear, animations: {
                button.layer.transform = rotation
            }, completion: { (_) in
                visibleButtons -= 1
                if visibleButtons == 0 {
                    self.isHidden = true
                }
            })
            i += 1
        }
    }
}

// MARK: - User Actions
extension MenuView {
    @objc func menuItemPressed(sender: UIButton) {
        var itemName = sender.currentTitle ?? ""
        if !itemName.isEmpty {
            itemName = String(itemName.dropLast(4))
        }
        delegate?.menuView(didSelectItem: itemName)
    }
}
