//
//  RouterProtocol.h
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

@protocol SBSRouterProtocol <NSObject>

@required
- (void)pushViewController:(id)viewController;
- (void)popViewController;

@end
