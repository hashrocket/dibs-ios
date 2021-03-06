#import "MyItemsController.h"
#import "MyItemCell.h"

@interface MyItemsController()
-(void)loadItems;
@end

@implementation MyItemsController

-(id)init {
  if (self = [super init]) {
    [self.collectionView registerClass:[MyItemCell class] forCellWithReuseIdentifier:@"ItemCell"];
  }
  return self;
}

-(void)loadItems {
  if (self.isLoading) return;
  [self setIsLoading:YES];
  [self.collectionView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height) animated:YES];
  [self.refreshControl beginRefreshing];
  [[DibsClient client] getPath:@"mine" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self setItemsAttributes:responseObject];
    [self setIsLoading:NO];
    [self.refreshControl endRefreshing];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [self setIsLoading:NO];
    [self.refreshControl endRefreshing];
  }];
}

-(void)didMoveToParentViewController:(UIViewController *)parent {
  [super didMoveToParentViewController:parent];
  if (!self.items || [self.items count] == 0) [self loadItems];
}

@end
