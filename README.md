# DI Part 5 - Moving between ViewControllers without Segues

### Before Assignment

Due to the screen size limit, it's common to move between different view controllers on iPhone. In this assignment, we're going to achieve the following scenarios: 

1. Push a new UIViewController.
2. Present a new UIViewController in full screen.
3. Push from a presented UIViewController.

### Assignment

1. There are 5 pages with different background colors from red to blue respectively. 
2. The action of each button:
    * `Next` button:  push a new view controller
    * `Back` button: pop back to previous page
    * `Present` button: present a new UIViewController in full scree
    * `Close` button: dismiss the current page
3. Users could tap Next to navigate from the red page to the blue page.
    * On the blue page, tapping Back leads to the red page.
    * On the green page, tapping Back leads to the orange page.
    * On the yellow or orange page, tapping Back leads to the previous page.
4. Users could tap Present to display the orange page to the blue page.
    * On the blue page, tapping Close leads to the red page.
    * On the green page, tapping Close leads to the orange page.
    * On the yellow or orange page, tapping Close dismisses the current page.
5. Users should be able to tap Next or Present at will and the corresponding return behavior is the same as above.