# UIPresentationController

모달을 원하는 방향 혹은 애니메이션과 곁들여서 커스터마이징 하고 싶을때 사용한다.

## ViewController

- controller.delegate = self
- controller.transitioningDelegate = SlideInPresentationManager()
- controller.modalPresentationStyle = .custom

## SlideInPresentationManager

- UIViewControllerTransitioningDelegate 를 채택하는데 NSObject 를 상속받아야 한다.
- 추가적으로 방향을 설정해줄 수 있다.
- 그 후에 presentationController 를 구현해야 한다.

```swift

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
    presenting: UIViewController?, source: UIViewController) 
        -> UIPresentationController? {
        
            let presentationController = SlideInPresentationController(presentedViewController: presented,
            presenting: presenting, direction: direction)
            
            return presentationController
    }
}

```

- 여기에서 리턴되는 UIPresentationController 가 핵심이고 이는 따로 구현을 해야한다.

## UIPresentationController

- 여기에서는 dimmingView를 통해서 dismiss 를 추가해주었다.
- direction 을 설정함으로서 재사용성을 생각함
- init 에서 방향 및 dimmingView를 설정한다.
- containerViewWillLayoutSubviews 에서 나타내줄 뷰의 사이즈를 설정할 수 있다.
- presentationTransitionWillBegin() 는 나타날때의 설정 dismissalTransitionWillBegin() 은 사라질때의 설정
- 



> [ref](https://www.raywenderlich.com/915-uipresentationcontroller-tutorial-getting-started)
