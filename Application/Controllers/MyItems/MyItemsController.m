#import "MyItemsController.h"

@interface MyItemsController()
-(void)loadItems;
@end

@implementation MyItemsController

-(id)init {
  if (self = [super init]) {
    [self loadItems];
  }
  return self;
}

-(void)loadItems {
  if (self.isLoading) return;
  [self setIsLoading:YES];
  [[DibsClient client] getPath:@"mine" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self setItemsAttributes:responseObject];
    [self setIsLoading:NO];
    [self.refreshControl endRefreshing];
  } failure:nil];
}

-(void)didMoveToParentViewController:(UIViewController *)parent {
  [super didMoveToParentViewController:parent];
  if (!self.items) [self loadItems];
}

@end
