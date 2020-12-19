## SDK_THP_VERIFONE

#### Usage
Create a single view application.

After the SampleApp created, drag in the ```SDK_THP_Verifone.xcodeproj```.

When you are dragging in the SDK_THP_Verifone make sure that you don't have another instance of Xcode open.

Once you have dragged in the framework it should have a little arrow next to it which will allow you to see the contents of that framework.
###### Add the framework to Frameworks, Libraries and Embedded Content
To do this you will need to click on the SampleApp project in the top left, go to the General tab and then look for Framework, Libraries and Embedded Content. Once you have found it, click on the + button. When you click on the + button you will get prompted to choose the framework you want to add. Make sure to select the ```SDK_THP_Verifone.xcodeproj```.

Now that we have everything setup we can use the framework. 

```
import SDK_THP_Verifone
```

Next add the following under the `viewDidLoad`

```
override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navigationBar = UINavigationController.init(rootViewController: cardView)
        self.present(navigationBar, animated: true, completion: nil)
    }
```
You should now be able to build and run the app.

<a href="https://ibb.co/m4ZqBZc"><img src="https://i.ibb.co/M7wVhwC/Screen-Shot-2020-12-19-at-13-47-53.png" alt="Screen-Shot-2020-12-19-at-13-47-53" border="0"></a>
