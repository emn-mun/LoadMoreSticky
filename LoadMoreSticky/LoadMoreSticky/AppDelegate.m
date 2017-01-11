#import "AppDelegate.h"
#import "NativeCollectionViewController.h"
#import "IGListCollectionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    NativeCollectionViewController *tabBarNativeVC = [[NativeCollectionViewController alloc] init];
    IGListCollectionViewController *tabBarIGListVC = [[IGListCollectionViewController alloc] init];
    UITabBarItem *tabBarNativeItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
    UITabBarItem *tabBarIGListItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    
    tabBarNativeVC.tabBarItem = tabBarNativeItem;
    tabBarIGListVC.tabBarItem = tabBarIGListItem;
    [tabBarController setViewControllers:@[tabBarNativeVC, tabBarIGListVC]];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
