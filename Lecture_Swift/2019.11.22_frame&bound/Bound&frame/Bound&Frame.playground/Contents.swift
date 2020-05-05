//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black

        view.addSubview(label)
        self.view = view
    }
    
        
        let greenView = UIView()
        let redView = UIView()
        let blueView = UIView()

    override func viewDidLoad() {
        setupSuperView()
        
//        greenView.frame.origin = CGPoint(x: 0, y: 0)
        blueView.bounds.origin = CGPoint(x: 10, y: 10)
        blueView.frame.origin = CGPoint(x: 50, y: 50)
        
        
        
    }


    func setupSuperView(){
        
        greenView.frame = CGRect(x: 50, y: 50, width: 500, height: 500)
        greenView.backgroundColor = .green
        blueView.addSubview(greenView)
        
        redView.frame = CGRect(x: 100, y: 100, width: 80, height: 80)
        redView.backgroundColor = .red
        greenView.addSubview(redView)
        
        blueView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
        
    }

    
    
//    override func viewDidLoad() {
//        let hiperView = self.hiperView()
//        let superView = self.superView(x: hiperView)
//        self.subView(y: superView)
//    }
//
//
//    func hiperView() -> UIView{
//        let hiperView = UIView()
//        hiperView.frame = CGRect(x: 30, y: 30, width: 330, height: 500)
//        hiperView.backgroundColor = .blue
//        view.addSubview(hiperView)
//        return hiperView
//    }
//
//    func superView(x: UIView) -> UIView{
//        let superView = UIView()
//        superView.frame = CGRect(x: 30, y: 30, width: 260, height: 430)
//        superView.backgroundColor = .red
//        x.addSubview(superView)
//        return superView
//    }
//
//    func subView(y: UIView){
//        let subView = UIView()
//        subView.frame = CGRect(x: 30, y: 30, width: 200, height: 370)
//        subView.backgroundColor = .green
//        y.addSubview(subView)
//
//    }
    
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
