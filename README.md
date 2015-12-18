<b>ESPRSSIF MIT License</b>

Copyright © 2015 <ESPRESSIF SYSTEMS (SHANGHAI) PTE LTD>

Permission is hereby granted <b>for use on ESPRESSIF SYSTEMS ESP8266 only, in which case, it is free of charge,</b> to any person obtaining a copy of this software and
associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

<b>乐鑫 MIT 许可证</b>

版权 © 2015  <乐鑫信息科技（上海）有限公司>

<b>该许可证授权仅限于乐鑫信息科技 ESP8266 产品的应用开发。</b>在此情况下，该许可证免费授权任何获得该软件及其相关文档（统称为“软件”）的人无限制地经营该软件，包括无限制
的使用、复制、修改、合并、出版发行、散布、再授权、及贩售软件及软件副本的权利。被授权人在享受这些权利的同时，需服从下面的条件：

在软件和软件的所有副本中都必须包含以上的版权声明和授权声明。

该软件按本来的样子提供，没有任何明确或暗含的担保，包括但不仅限于关于试销性、适合某一特定用途和非侵权的保证。作者和版权持有人在任何情况下均不就由软件或软件使用引起的以合同形式、民事侵权或其它方式提出的任何索赔、损害或其它责任负责。


==================================v1.1.0==================================

1. Add notify myself button to make more easy to test apns.

==================================v1.0.0==================================

1.  The Demo could be run on iOS Simulator directly.

2.  If you'd like to run it on iOS real machine, please apply APNS TOKEN by http://iot.espressif.cn.

2.1 Apply App Private Key and APNS SSL Certificate by Apple Developer web site.

    (Please refer: http://docs.aws.amazon.com/sns/latest/dg/mobile-push-apns.html)

2.2 Send Your App Private Key and APNS SSL(including password if you have set) to wuyunzhou@espressif.com

2.3 Change the APNS_TOKEN in ESPUser.m
