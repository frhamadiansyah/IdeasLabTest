# IdeasLab Interview Answers

## 1. How do we investigate leaks and performance issue?
To investigate leaks and performance issue XCode provide several tools we can use. I usually use Leaks on instrument, Memory Graph, and a simple deinit debugger on suspected class
### Leaks Instrument
On XCode instrument, there are several tools we can use to our apps performance. For memory leaks, we use Leaks tools. While the instruments monitor the app, we navigate throughout the app and see if the instrument detect leaks during that time. If it does, we can see what object causing the leaks.
After that we can check the debug memory graph to make sure the leaks located on the parts we suspect there are. The leaks can be seen on the sidebar.
Since leaks usually caused by strong reference causing an object not deinitialized properly. Sometimes the simplest method is the best method. I put a print function on deinit to see if the suspected object is really deinitialized or not.

### Memory Leaks Example
In this example we try to simulate memory leak. We have two objects with strong reference on one another on second view controller. 

If we navigate to second view controller and dismiss it back to first view controller, we can the leaks intrument detects a memory leak. If we select the memory leak icon, it will give us the object that causing the leak

As you can see, There's a leak on MainClass and SubClass class. From the timestamp and action we did, we know that leak happens when we dismiss second view controller.

When we check the codebase, we saw the strong reference on MainClass parameter causing the class cannot be fully destroyed when the view is dismissed. We can fix it by changing it to weak var. We put a deinitializer to trigger a print action when the class is destroyed

So you can see after whe change it to weak var, the all the class used on second view controller is destroyed when the second view controller is dismissed, solving our memory leak issue

## 2A. How can we manage tasks in a multithreaded environment? Give us an example on how to use the Grand Central Dispatch properly to divide tasks in different threads.

## 2B. How can we manage tasks and wait for other tasks to finish before moving on to another task to start?

## 2C. How do you perform multithreaded tasks in Core Data?
We can do use the perform and performAndWait method on NSManagedContext to perform multithreaded tasks in Core Data. all action inside the perform and performAndWait bracket will be done on separate thread, The difference between perform and performAndWait is the way in which the specified block of code is executed, asynchronously or synchronously.

We can also use async/await on swift, and specify the thread used on that task in Task block.

