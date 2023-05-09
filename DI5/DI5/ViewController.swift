//
//  ViewController.swift
//  DI5
//
//  Created by 方品中 on 2023/5/8.
//

import UIKit
//❤️中中～～～～～～！！！！❤️🫶🧚🧖
class ViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var presentButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var colorMap: [UIColor] = [.red, .orange, .yellow, .green, .blue]
    var colorIndex = 0
    var isPresent: Bool = false
    
    @IBAction func doNext(_ sender: UIButton) {
        let nextVC = self.getInstantiateViewController()

        self.navigationController!.show(nextVC, sender: self)
    }
    
    @IBAction func doPresent(_ sender: UIButton) {
        let nextVC = self.getInstantiateViewController()
        nextVC.isPresent = true
        
        let navigationController = UINavigationController(rootViewController: nextVC)
        navigationController.modalPresentationStyle = .fullScreen
        
        self.setMoveInTransition()
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @IBAction func doCancel(_ sender: UIButton) {
        self.doBack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let color = self.colorMap[self.colorIndex]
        
        self.view.backgroundColor = color
        
        // 若是最後一夜，把按鈕清空
        if self.colorIndex == self.colorMap.count - 1 {
            self.nextButton.isHidden = true
            self.presentButton.isHidden = true
        }
        
        // 若是第一頁，或是present mode，把上一夜隱藏
        if self.colorIndex == 0 || self.isPresent {
            self.navigationItem.hidesBackButton = true
        } else {
            self.navigationItem.backAction = UIAction() { [weak self] action in
                self?.doBack()
            }
        }
        
        // 若不是present mode，把叉叉隱藏
        if !self.isPresent {
            self.cancelButton.isHidden = true
        }
    }
    
    private func doBack() {
        if self.isPresent {
            setMoveOutTransition()
        }
        
        if self.colorIndex <= 2 {
            self.navigationController!.popToViewController(doGetPresentController(offset: 1), animated: !self.isPresent)
        }
        
        if self.colorIndex == 3 {
            self.navigationController!.popToViewController(doGetPresentController(offset: 2), animated: !self.isPresent)
        }
        
        if self.colorIndex == 4 {
            self.navigationController!.popToViewController(doGetPresentController(offset: 4), animated: !self.isPresent)
        }
    }
    
    private func getInstantiateViewController() -> ViewController {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        viewController.colorIndex = self.colorIndex + 1
        
        return viewController
    }
    
    private func setMoveInTransition() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController?.view.layer.add(transition, forKey: nil)
    }
    
    private func setMoveOutTransition() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: kCATransition)
    }
    
    private func doGetPresentController(offset: Int) -> UIViewController {
        let index = self.navigationController?.viewControllers.firstIndex(of: self)!
        return (self.navigationController?.viewControllers[index! - offset])!
    }
}
