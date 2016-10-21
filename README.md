# EMClassIntrospection

A tool for runtime which can help us to explore some interesting things.

# 中文介绍
你可以在[「这里」](http://www.jianshu.com/p/c04d89546237)找到详细的中文介绍和扩展方法。


# Integration
Use cocoapods like this (Just support iOS):
```C
pod `EMClassIntrospection`
```
Or add `EMCI.h` & `EMCI.m` to your project. It also works on macOS & watchOS.

# Usage
## Example
### To print all classes
Set a breakpoint, then input:
```oc
(lldb) e [EMCI pAllClass]
```
Now you can check all classes in the Runtime context:
```oc
(lldb) e [EMCI pAllClass]
There are 4726 classes registed:
No.0 : JSExport
No.1 : NSLeafProxy
No.2 : NSProxy
No.3 : _UITargetedProxy
No.4 : _UIViewServiceReplyControlTrampoline
No.5 : _UIViewServiceReplyAwaitingTrampoline
No.6 : _UIViewServiceUIBehaviorProxy
......
No.4720 : OS_dispatch_queue_mgr
No.4721 : OS_dispatch_queue_root
No.4722 : OS_dispatch_queue_main
No.4723 : OS_dispatch_queue_concurrent
No.4724 : OS_dispatch_queue_serial
No.4725 : OS_dispatch_queue_runloop
(lldb) 
```
### To print all subclass of class `UIViewController`
```oc
(lldb) e [EMCI pSubclass:@"UIViewController"]
No.0 : UISearchController
No.1 : UIPrinterSetupDisplayPINViewController
No.2 : UIPrinterSetupPINViewController
No.3 : UIWebDateTimePopoverViewController
No.4 : UICloudSharingController
No.5 : UIDebuggingZoomViewController
No.6 : UIMultiColumnViewController
......
No.97 : _UIDictationPrivacySheetController
No.98 : UIPrintPanelNavigationController
No.99 : UIVideoEditorController
No.100 : UIImagePickerController
No.101 : UIMoreNavigationController
No.102 : ViewController
(lldb) 
```

### To print all instance method of class `NSArray`
```oc
(lldb) e [EMCI sClass:@"NSArray"]
NSArray > 
(lldb) e [EMCI pInstanceMethod]
Class [NSArray] has 162 instance methods:
No.0: (-)_ui_onlyObject
No.1: (-)_ui_firstObject
No.2: (-)_filteredArrayOfObjectsPassingTest:
No.3: (-)ui_arrayByRemovingLastObjectEqualTo:
No.4: (-)_initWithObjectsFromArray:range:
No.5: (-)_makeObjectsPerformSelector:object:range:
No.6: (-)_nextToLastObject
......
No.156: (-)initWithObjects:
No.157: (-)description
No.158: (-)makeObjectsPerformSelector:
No.159: (-)objectsPassingTest:
No.160: (-)sortedArrayUsingFunction:context:
No.161: (-)makeObjectsPerformSelector:withObject:
(lldb) 
```

## Usage detail
### Example: To explore the initialization process of class `NSMutableArray`
- Check all subclasses of class `NSMutableArray`
```oc
(lldb) e [EMCI pSubclass:@"NSMutableArray"]
No.0 : UITableViewVisibleCells
No.1 : NSArrayChanges
No.2 : NSConcreteArrayChanges
No.3 : NSKeyValueMutableArray
No.4 : NSKeyValueNotifyingMutableArray
No.5 : NSKeyValueIvarMutableArray
No.6 : NSKeyValueSlowMutableArray
No.7 : NSKeyValueFastMutableArray
No.8 : NSKeyValueFastMutableArray2
No.9 : NSKeyValueFastMutableArray1
No.10 : NSCFArray
No.11 : __NSArrayM
No.12 : __NSPlaceholderArray
No.13 : __NSCFArray
(lldb)
```
- Set `__NSArrayM` to be the target class
```oc
(lldb) e [EMCI sClass:@"__NSArrayM"]
__NSArrayM > 
(lldb)
```
- Check the inhenrit relationship of class `__NSArrayM`
```oc
(lldb) e [EMCI pInherit]
__NSArrayM -> NSMutableArray -> NSArray -> NSObject
(lldb) 
```

- Check all class method of target class
```oc
(lldb) e [EMCI pClassMethod]
Class [__NSArrayM] has 3 class methods:
No.0: (+)automaticallyNotifiesObserversForKey:
No.1: (+)allocWithZone:
No.2: (+)__new:::
(lldb) 
```
- Check the detail of the 2-nd class method `__new:::`
```oc
(lldb) e [EMCI pClassMethodDetail:2]
[__NSArrayM __new:::] > 
Method has 5 arguments:
No.0 : @ -> (id)
No.1 : : -> (SEL)
No.2 : r^@ -> r(pointer)(id)
No.3 : Q -> (unsigned long long)
No.4 : B -> (C++ bool or a C99 _Bool)
Return @ -> (id)
(lldb) 
```
## Use short API
### To explore the initialization process of class `NSMutableArray`
```oc
(lldb) e [EMCI PS:@"NSMutableArray"]
No.0 : UITableViewVisibleCells
No.1 : NSArrayChanges
No.2 : NSConcreteArrayChanges
No.3 : NSKeyValueMutableArray
No.4 : NSKeyValueNotifyingMutableArray
No.5 : NSKeyValueIvarMutableArray
No.6 : NSKeyValueSlowMutableArray
No.7 : NSKeyValueFastMutableArray
No.8 : NSKeyValueFastMutableArray2
No.9 : NSKeyValueFastMutableArray1
No.10 : NSCFArray
No.11 : __NSArrayM
No.12 : __NSPlaceholderArray
No.13 : __NSCFArray
(lldb) e [EMCI SC:@"__NSArrayM"]
__NSArrayM > 
(lldb) e [EMCI PI]
__NSArrayM -> NSMutableArray -> NSArray -> NSObject
(lldb) e [EMCI PCM]
Class [__NSArrayM] has 3 class methods:
No.0: (+)automaticallyNotifiesObserversForKey:
No.1: (+)allocWithZone:
No.2: (+)__new:::
(lldb) e [EMCI PCMD:2]
[__NSArrayM __new:::] > 
Method has 5 arguments:
No.0 : @ -> (id)
No.1 : : -> (SEL)
No.2 : r^@ -> r(pointer)(id)
No.3 : Q -> (unsigned long long)
No.4 : B -> (C++ bool or a C99 _Bool)
Return @ -> (id)
(lldb) 
```

# API
## Normal API
+ `(void)pAllClass;` 
—— Print all class.
+ `(void)pSubclass:(NSString *)clsName;` 
—— Print all subclass of the superclass.
+ `(void)pAllProtocol;` 
—— Print all protocol
+ `(void)sObject:(NSObject *)obj;` 
—— Set target class with an object.
+ `(void)sClass:(NSString *)clsName;` 
—— Set target class with a NSString
+ `(void)sBack;`
—— Cancle the target
+ `(void)pInherit;`
—— Print the inhenrit relationship of target class
+ `(void)pProtocol;`
—— Print the protocols of target class conforms
+ `(void)pProtocolDetail:(int)index;`
—— Print the detail of the protocol selected by index
+ `(void)pInstanceMethod;`
—— Print instance methods of target class
+ `(void)pClassMethod;`
—— Print class methods of target class
+ `(void)pInstanceMethodDetail:(int)index;`
—— Print the detail of the instance method selected by index
+ `(void)pClassMethodDetail:(int)index;`
—— Print the detail of the class method selected by index
+ `(void)pInstanceVariable;`
—— Print the instance variable of target class

## Short API
+ `(void)PAC;`
+ `(void)PS:(NSString *)clsName;`
+ `(void)PAP;`
+ `(void)SO:(NSObject *)obj;`
+ `(void)SC:(NSString *)clsName;`
+ `(void)SB;`
+ `(void)PI;`
+ `(void)PP;`
+ `(void)PPD:(int)index;`
+ `(void)PIM;`
+ `(void)PCM;`
+ `(void)PIMD:(int)index;`
+ `(void)PCMD:(int)index;`
+ `(void)PIV;`

