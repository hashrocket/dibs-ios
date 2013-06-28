#import "TabView.h"
#import "TabViewDelegate.h"

static CGFloat kTabViewHeight = 64.f;

@interface TabView()
@property(nonatomic,weak) id<TabViewDelegate> delegate;
@property(nonatomic,strong) NSMutableArray *buttons;
-(NSDictionary*)autolayoutDictionary;
-(NSString*)autolayoutHorizontalFormat;
@end

@implementation TabView

- (id)initWithDelegate:(id<TabViewDelegate>)delegate {
  if (self = [super init]) {
    [self setStyleId:@"tab_view"];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setDelegate:delegate];
    [self setNeedsUpdateConstraints];
  }
  return self;
}

-(NSMutableArray*)buttons {
  if (!_buttons) {
    _buttons = [NSMutableArray array];
  }
  return _buttons;
}

-(NSDictionary*)autolayoutDictionary {
  NSMutableDictionary *dictionary =[NSMutableDictionary dictionary];
  return [self.buttons reduceWithAccumulator:dictionary andIndexedBlock:^id(id acc, id button, NSUInteger index) {
    acc[strf(@"button%d",index)] = button;
    return acc;
  }];
}

-(NSString*)autolayoutHorizontalFormat {
  return [self.buttons reduceWithAccumulator:@"" andIndexedBlock:^id(id acc, id button, NSUInteger index) {
    return strf(@"%@[button%d(==button0)]", acc, index);
  }];
}

-(TabButton*)selectedButton {
  return [self.buttons detect:^BOOL(TabButton *button) {
    return [button isSelected];
  }];
}

-(void)addButton:(NSString *)title {
  [self addButton:title withIconNamed:nil];
}

-(void)addButton:(NSString *)title withIconNamed:(NSString *)iconName {
  TabButton *button = [TabButton buttonWithTitle:title andIconName:iconName];
  [button setTag:[self.buttons count]];
  [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
  [self.buttons addObject:button];
  [self addSubview:button];
  [self setNeedsUpdateConstraints];
}

-(void)selectButtonAtIndex:(NSInteger)index {
  TabButton *button = [self.buttons detect:^BOOL(UIButton* button) {
    return button.tag == index;
  }];
  [self didTapButton:button];
}

-(void)updateConstraints {
  [self removeConstraints:self.constraints];
  [super updateConstraints];
  [self addConstraintsWithVisualFormat:strf(@"H:|%@|", self.autolayoutHorizontalFormat)
                           forSubviews:self.autolayoutDictionary];
  [self.buttons eachWithIndex:^(UIButton *button, NSUInteger index) {
    [self addEqualityConstraintOn:NSLayoutAttributeBottom forSubview:button];
    [self addConstraintsWithVisualFormat:@"V:[button(height)]"
                             forSubviews:@{@"button": button}
                             withMetrics:@{@"height": @(kTabViewHeight)}];
  }];
}

-(void)didTapButton:(TabButton*)sender {
  [self.buttons each:^(id button) {
    [button setEnabled:YES];
  }];
  [sender setEnabled:NO];
  [self.delegate didTapButtonAtIndex:sender.tag];
}

@end