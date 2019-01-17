# UIPresentationController

모달을 원하는 방향 혹은 애니메이션과 곁들여서 커스터마이징 하고 싶을때 사용한다.

## ViewController

- controller.delegate = self
- controller.transitioningDelegate = SlideInPresentationManager()
- controller.modalPresentationStyle = .custom

## SlideInPresentationManager

- UIViewControllerTransitioningDelegate 를 채택하는데 NSObject 를 상속받아야 한다.
- 추가적으로 방향을 설정해줄 수 있다.
- 여기에서 아래와 같은 함수가 필요

```swift

func presentationController(forPresented presented: UIViewController,
presenting: UIViewController?,
source: UIViewController) -> UIPresentationController?

```

- 여기에서 리턴되는 UIPresentationController 가 핵심이다.

## UIPresentationController

- 여러



> [ref](https://www.raywenderlich.com/915-uipresentationcontroller-tutorial-getting-started)
