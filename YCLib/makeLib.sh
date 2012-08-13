#!/bin/sh

#  Script.sh
#  YCLib
#
#  Created by li shiyong on 12-8-10.
#  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.

lipo -create "/Users/lishiyong/Library/Developer/Xcode/DerivedData/YCLib-ftxgagfxnbnkkcbvlooibemsirck/Build/Products/Release-iphoneos/libYCLib.a" "/Users/lishiyong/Library/Developer/Xcode/DerivedData/YCLib-ftxgagfxnbnkkcbvlooibemsirck/Build/Products/Release-iphonesimulator/libYCLib.a" -output "/Users/lishiyong/lsyWorks/YCLib/libYCLib.a" 