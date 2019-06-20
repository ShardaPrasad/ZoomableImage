//
//  SliderPagerViewController.swift
//  ZoomableImage
//
//  Created by Sharda prasad on 20/06/19.
//  Copyright © 2019 Sharda prasad. All rights reserved.
//

import UIKit

class SliderPagerViewController: UIPageViewController {

    var backGroundImage: UIImage?
    var imagesURL = [String]()
    var currentIndex: Int?
    let clossButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required public init?(coder: NSCoder) {
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        basicSetUp()
    }
    
    public convenience init(images: [String], currentIndex: Int?, placeHolderImage: UIImage?) {
        self.init()
        
        self.backGroundImage = placeHolderImage
        self.imagesURL = images
        if let _ = currentIndex {
            self.currentIndex = currentIndex!
        }
        basicSetUp()
    }
    
    var isHidden = true {
        didSet{
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    override var prefersStatusBarHidden: Bool {
        
        print("prefersStatusBarHidden:\(isHidden)")
        return isHidden
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.isHidden = true
        //UIApplication.shared.isStatusBarHidden = true
    }
    
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         self.isHidden = false
        //UIApplication.shared.isStatusBarHidden = false
    }
    
    func basicSetUp() {
        dataSource = self
        self.view.backgroundColor = UIColor.white
        
        
        // 1
        if let viewController = getZoomedPhotoViewController(currentIndex ?? 0) {
            let viewControllers = [viewController]
            // 2
            setViewControllers(viewControllers,
                               direction: .forward,
                               animated: false,
                               completion: nil)
        }
        
        setUpUI()
    }
    
    func setUpUI()
    {
        let bundle = Bundle(for: self.classForCoder)
        let image = UIImage(named: "close", in: bundle, compatibleWith: nil)
        clossButton.setBackgroundImage(image, for: .normal)
        clossButton.addTarget(self, action: #selector(clossButtonTapped), for: .touchUpInside)
        
        //self.view.addSubview(imageIndexLabel)
        self.view.addSubview(clossButton)
       // self.view.bringSubview(toFront: imageIndexLabel)
        self.view.bringSubviewToFront(clossButton)
        
        clossButton.translatesAutoresizingMaskIntoConstraints = false
       // imageIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        
       // let labelTrailingConstraint = NSLayoutConstraint(item: imageIndexLabel, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -8)
       // let labelBottomConstraint = NSLayoutConstraint(item: imageIndexLabel, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .top, multiplier: 1, constant: -8)
        
        let crossButtonLeadingConstraint = NSLayoutConstraint(item: clossButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 8)
        let crossButtonTopConstraint = NSLayoutConstraint(item: clossButton, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 8)
        let crossButtonWidthConstraint = NSLayoutConstraint(item: clossButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 30)
        let crossButtonHeightConstraint = NSLayoutConstraint(item: clossButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30)
        
       // self.view.addConstraints([labelTrailingConstraint, labelBottomConstraint, clossButtonLeadingConstraint, clossButtonTopConstraint, clossButtonWidthConstraint, clossButtonHeightConstraint])
        self.view.addConstraints([crossButtonLeadingConstraint, crossButtonTopConstraint, crossButtonWidthConstraint, crossButtonHeightConstraint])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getZoomedPhotoViewController(_ index: Int) -> ZoomedPhotosController?
    {
        let page = ZoomedPhotosController(pageViewController: self, index: index, imageUrl: imagesURL[index], totalImageCount: imagesURL.count)
        
        
        
        return page
    }
    
    
    
    @objc func clossButtonTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }

}

//MARK: implementation of UIPageViewControllerDataSource
extension SliderPagerViewController: UIPageViewControllerDataSource {
    // 1
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? ZoomedPhotosController,
            let index = viewController.photoIndex,
            index > 0 {
            return getZoomedPhotoViewController(index - 1)
        }
        
        return nil
    }
    
    // 2
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? ZoomedPhotosController,
            let index = viewController.photoIndex,
            (index + 1) < imagesURL.count {
            return getZoomedPhotoViewController(index + 1)
        }
        
        return nil
    }
    
    // MARK: UIPageControl
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
}
