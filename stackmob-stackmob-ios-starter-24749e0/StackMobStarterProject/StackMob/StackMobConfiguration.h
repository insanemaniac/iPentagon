// Copyright 2011 StackMob, Inc
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#if DEBUG
#define SMLog(format, ...) {NSLog(format, ##__VA_ARGS__);}
#define StackMobDebug(format, ...) {NSLog([[NSString stringWithFormat:@"[%s, %@, %d] ", __PRETTY_FUNCTION__, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__] stringByAppendingFormat:format, ##__VA_ARGS__]);}
#else
#define SMLog(format, ...)
#define StackMobDebug(format, ...)
#endif

//#define STACKMOB_PUBLIC_KEY         @"1ba8c465-44c4-444e-9d24-b857922dcfc2"
//#define STACKMOB_PRIVATE_KEY        @"1ce9d78f-4f1c-47dd-8806-3d8c3ad9675e"
//#define STACKMOB_APP_NAME           @"abc"
//#define STACKMOB_APP_SUBDOMAIN      @"com"
//#define STACKMOB_APP_DOMAIN         @"stackmob.com"
//#define STACKMOB_USER_OBJECT_NAME   @"user"
//#define STACKMOB_API_VERSION        0

#define STACKMOB_PUBLIC_KEY         @"3441cd26-eb49-46ea-b243-851bb20d1249"
#define STACKMOB_PRIVATE_KEY        @"a5f1193e-be32-46ce-aad3-c728cf90a3cc"
#define STACKMOB_APP_NAME           @"rigel"
#define STACKMOB_APP_SUBDOMAIN      @"com"
#define STACKMOB_APP_DOMAIN         @"stackmob.com"
#define STACKMOB_USER_OBJECT_NAME   @"user"
#define STACKMOB_API_VERSION        0


