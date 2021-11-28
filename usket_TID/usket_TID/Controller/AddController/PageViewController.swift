//
//  PageViewController.swift
//  usket_TID
//
//  Created by 이경후 on 2021/11/21.
//

import UIKit
import RealmSwift

//페이지 관리
class PageViewController: UIPageViewController {
    
    //페이지(viewController) 배열
    var addPages = [UIViewController]()
    var idOfCell : ObjectId?
    let localReam = try! Realm()
    var tasks : Results<DefineWordModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //뷰컨트롤러 넣어주고
        let BasicVC = storyboard?.instantiateViewController(withIdentifier: "BasicViewController") as! BasicViewController
        let ContentVC = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        //뷰컨트롤러 넣어주고
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        //값전달을 위한 delegate
        BasicVC.delegate = ContentVC
        ContentVC.delegate = mainVC
        
        //id값이 같이 넘어오게 된다면 수정임.
        if let id = idOfCell {
            //해당 id의 값으로 셋팅하기
            tasks = localReam.objects(DefineWordModel.self)
            let target = tasks.filter("_id == %@", id)[0]
                
            BasicVC.cellId = target._id
            BasicVC.wordText = target.word
            BasicVC.firstText = target.firstWord
            ContentVC.idOfCell = target._id
        }
        //페이지넣고
        addPages.append(BasicVC)
        addPages.append(ContentVC)
        
        //delegate + dataSource
        self.dataSource = self
        self.delegate = self
        
        //시작 설정
        if let page = addPages.first{
            setViewControllers([page], direction: .forward, animated: true, completion: nil)
        }
        //PageControl Custom
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black

    }
    //스토리보드 특정 및 Identifier
    private func PageInstance(name : String) -> UIViewController{
        return UIStoryboard(name: "WordScreen", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    //PageControl 뷰에서 백그라운드 제거
    override func viewDidLayoutSubviews() {
        for view in self.view.subviews{
            if view is UIScrollView{
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl{
                view.backgroundColor = UIColor.clear
            }
        }
    }
}
extension PageViewController : UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    
    //자율이지만 해두자.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //전의 뷰컨트롤러 특정
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pageIndex = addPages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = pageIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard addPages.count > previousIndex else {
            return nil
        }
        
        return addPages[previousIndex]
    }
    //앞의 뷰컨트롤러 특정
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pageIndex = addPages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = pageIndex + 1
        guard nextIndex < addPages.count else {
            return nil
        }
        
        guard addPages.count > nextIndex else {
            return nil
        }
        
        return addPages[nextIndex]
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return addPages.count // 총 페이지수 2개
    }
    //보여지고 있는 뷰컨트롤러 특정 -> Index로 반환
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let page = viewControllers?.first, let pageIndex = addPages.firstIndex(of: page) else {
            return 0
        }
        return pageIndex
    }
}
