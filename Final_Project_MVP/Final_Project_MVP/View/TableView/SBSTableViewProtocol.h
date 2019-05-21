//
//  TableViewProtocol.h
//  Final_Project_MVP
//
//  Created by Вова on 08.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

@protocol SBSTableViewProtocol <NSObject>

@required
- (void)reloadTableViewWithIdentifier:(NSString *)identifier;

@end
