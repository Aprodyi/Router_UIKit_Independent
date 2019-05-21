//
//  ColorsDictionary.m
//  Final_Project_MVPTests
//
//  Created by Вова on 15.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "ColorsDictionary.h"

@implementation ColorsDictionary

+ (NSDictionary*)getConstDictionary
{
    static NSDictionary *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst =  @{
                    @"result": @{
                        @"colors": @{
                            @"background_colors": @[
                                                  @{
                                                     @"b": @(47),
                                                     @"closest_palette_color": @"light bronze",
                                                     @"closest_palette_color_html_code": @"#8c5e37",
                                                     @"closest_palette_color_parent": @"skin",
                                                     @"closest_palette_distance": @(1.70506228322597),
                                                     @"g": @(92),
                                                     @"html_code": @"#8c5c2f",
                                                     @"percent": @(48.0033950805664),
                                                     @"r": @(140)
                                                    },
                                                  @{
                                                     @"b": @(146),
                                                     @"closest_palette_color": @"cerulean",
                                                     @"closest_palette_color_html_code": @"#0074a8",
                                                     @"closest_palette_color_parent": @"blue",
                                                     @"closest_palette_distance": @(5.53350780052479),
                                                     @"g": @(116),
                                                     @"html_code": @"#467492",
                                                     @"percent": @(39.0454025268555),
                                                     @"r": @(70)
                                                    },
                                                    ],
                                                                    @"color_percent_threshold": @(1.75),
                                                                    @"color_variance": @(36),
                                                                    @"foreground_colors": @[
                                                                            @{
                                                                                @"b": @(147),
                                                                                @"closest_palette_color": @"larkspur",
                                                                                @"closest_palette_color_html_code": @"#6e7e99",
                                                                                @"closest_palette_color_parent": @"blue",
                                                                                @"closest_palette_distance": @(8.60114706674971),
                                                                                @"g": @(125),
                                                                                @"html_code": @"#577d93",
                                                                                @"percent": @(52.3429222106934),
                                                                                @"r": @(87)
                                                                                },
                                                                            @{
                                                                                @"b": @(145),
                                                                                @"closest_palette_color": @"pewter",
                                                                                @"closest_palette_color_html_code": @"#84898c",
                                                                                @"closest_palette_color_parent": @"grey",
                                                                                @"closest_palette_distance": @(1.75501013175431),
                                                                                @"g": @(142),
                                                                                @"html_code": @"#898e91",
                                                                                @"percent": @(30.0293598175049),
                                                                                @"r": @(137)
                                                                                },
                                                                            ],
                                                                    @"image_colors": @[
                                                                            @{
                                                                                @"b": @(146),
                                                                                @"closest_palette_color": @"cerulean",
                                                                                @"closest_palette_color_html_code": @"#0074a8",
                                                                                @"closest_palette_color_parent": @"blue",
                                                                                @"closest_palette_distance": @(7.85085588656478),
                                                                                @"g": @(121),
                                                                                @"html_code": @"#547992",
                                                                                @"percent": @(48.3686981201172),
                                                                                @"r": @(84)
                                                                                },
                                                                            @{
                                                                                @"b": @(46),
                                                                                @"closest_palette_color": @"light bronze",
                                                                                @"closest_palette_color_html_code": @"#8c5e37",
                                                                                @"closest_palette_color_parent": @"skin",
                                                                                @"closest_palette_distance": @(3.05634270891355),
                                                                                @"g": @(86),
                                                                                @"html_code": @"#83562e",
                                                                                @"percent": @(47.9353446960449),
                                                                                @"r": @(131)
                                                                                },
                                                                            ],
                                                                    @"object_percentage": @(20.790994644165)
                                                                    }
                                                            },
                                                    @"status": @{
                                                            @"text": @"",
                                                            @"type": @"success"
                                                            }
                                                    };
    });
    return inst;
}

+ (NSArray *)getBackgroundColorsArray
{
    static NSArray *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst =  @[
                  @{
                      @"b": @(47),
                      @"closest_palette_color": @"light bronze",
                      @"closest_palette_color_html_code": @"#8c5e37",
                      @"closest_palette_color_parent": @"skin",
                      @"closest_palette_distance": @(1.70506228322597),
                      @"g": @(92),
                      @"html_code": @"#8c5c2f",
                      @"percent": @(48.0033950805664),
                      @"r": @(140)
                      },
                  @{
                      @"b": @(146),
                      @"closest_palette_color": @"cerulean",
                      @"closest_palette_color_html_code": @"#0074a8",
                      @"closest_palette_color_parent": @"blue",
                      @"closest_palette_distance": @(5.53350780052479),
                      @"g": @(116),
                      @"html_code": @"#467492",
                      @"percent": @(39.0454025268555),
                      @"r": @(70)
                      },
                  ];
    });
    return inst;
}

+ (NSArray *)getForegroundColorsArray
{
    static NSArray *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst =  @[
                  @{
                      @"b": @(147),
                      @"closest_palette_color": @"larkspur",
                      @"closest_palette_color_html_code": @"#6e7e99",
                      @"closest_palette_color_parent": @"blue",
                      @"closest_palette_distance": @(8.60114706674971),
                      @"g": @(125),
                      @"html_code": @"#577d93",
                      @"percent": @(52.3429222106934),
                      @"r": @(87)
                      },
                  @{
                      @"b": @(145),
                      @"closest_palette_color": @"pewter",
                      @"closest_palette_color_html_code": @"#84898c",
                      @"closest_palette_color_parent": @"grey",
                      @"closest_palette_distance": @(1.75501013175431),
                      @"g": @(142),
                      @"html_code": @"#898e91",
                      @"percent": @(30.0293598175049),
                      @"r": @(137)
                      },
                  ];
    });
    return inst;
}

+ (NSArray *)getImageColorsArray
{
    static NSArray *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst =  @[
                  @{
                      @"b": @(146),
                      @"closest_palette_color": @"cerulean",
                      @"closest_palette_color_html_code": @"#0074a8",
                      @"closest_palette_color_parent": @"blue",
                      @"closest_palette_distance": @(7.85085588656478),
                      @"g": @(121),
                      @"html_code": @"#547992",
                      @"percent": @(48.3686981201172),
                      @"r": @(84)
                      },
                  @{
                      @"b": @(46),
                      @"closest_palette_color": @"light bronze",
                      @"closest_palette_color_html_code": @"#8c5e37",
                      @"closest_palette_color_parent": @"skin",
                      @"closest_palette_distance": @(3.05634270891355),
                      @"g": @(86),
                      @"html_code": @"#83562e",
                      @"percent": @(47.9353446960449),
                      @"r": @(131)
                      },
                  ];
    });
    return inst;
}

@end
