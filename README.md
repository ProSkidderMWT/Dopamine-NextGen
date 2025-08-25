*Dopamine QNA*

前言( 请大家一定要读一下QNA呐 o(TヘTo) )
-
目前的Dopamine是针对希沃管家***版本1.4.9.3649***而制作的，Dopamine的作者也会在力所能及的范围内对新版本进行适配，如果遇到无法成功杀死进程的情况请及时大家提issues，对完善Dopamine的过程出一份力，谢谢大家。

1.什么是Dopamine?
-
Dopamine是一款类似于Windows的'服务'的应用,由batch脚本(旧版本还有vbs脚本)构成，常驻于后台寻找并杀死希沃白板的运维服务进程，操作简单且便捷，软件轻量，适用于***Windows 7及以上***的系统版本。

2.我应该如何使用Dopamine?
-
在release中下载Dopamine的最新构建，下载完毕后打开Dopamine，在弹出的窗口中选择“是”，之后Dopamine便会常驻于后台为您杀死希沃白板的运维服务进程。关闭Dopamine也很简单，重复上述步骤即可。

3.使用Dopamine的Windows系统需求是什么?
-
***Dopamine最新版***(v1.6 alpha及以上)会自动检测您的Windows系统是否符合运行需求，如果Dopamine检测到你的Windows不符合需求，Dopamine将不会运行。在Dopamine版本v1.1 alpha中已经添加了对系统文件的自动检测，Dopamine版本v1.6 alpha已经添加了对系统语言的自动检测。<br>

 在Dopamine v1.4 alpha之后，您的Windows系统语言应该为简体中文。<br>
<br>
Dopamine需要的Windows系统文件：<br>
***1 > ping.exe<br>***
***2 > taskkill.exe<br>***
***3 > cmd.exe<br>***
***4 > powershell.exe<br>***
<br>在Dopamine的 Legacy (已过时的) 版本之前，Dopamine并不需要powershell.exe<br>
在Dopamine v1.5 alpha之前，Dopamine还需要wscript.exe<br>
<br>
***以上文件缺一不可。<br>***

4.我应该在何处提交bug?
-
请在本repo的issues界面提交你的bug。<br>
正确的bug提交应该包含以下信息:<br><br>
***1.Windows版本***<br>
***2.Dopamine版本***<br>
***3.希沃管家版本*** + 安装包(如果可能)<br>
***4.复现bug的方法***<br><br>
请不要提交来自Legacy或其他版本的bug，谢谢。<br>
<br>

以下内容是为开发者所写，正常用户可以止步了<br><br>
5.如何使用该repo的文件?
-
首先，在本repo界面中点击 "Code" 按钮，并选择 "Download ZIP" 将本repo的文件下载下来；<br>
然后，在%appdata%文件夹中创建名为Dopamine的文件夹
接着，将本repo的文件("Dopamine.bat","default-config.txt")解压到新建的文件夹中；<br>
最后，启动Dopamine。<br>

6.我如何构建自己的可执行文件?
-
首先，在repo界面中点击 "Code" 按钮，并选择 "Download ZIP" 将本repo的文件下载下来；<br>
接着，在下载下来的ZIP文件中，使用任意解压软件在文件中新建一个名叫"Dopamine"的文件夹，并将以下的文件复制到您新建的文件夹中<br>("Dopamine.bat")；<br>
然后，使用任意带自解压功能的软件(例如：***好压***)，打开其自解压功能，将解压路径选择至%appdata%并打开"解压后打开"功能；<br>
最后，在"解压后打开"一栏填入"Dopamine\Dopamine.bat"，解压模式选择静默+覆盖文件，再选择任意图标即可构建。<br>

7.我如何为Dopamine的开发做出贡献?
-
首先，在repo界面中fork本项目；<br>
接着，在本repo的issues界面寻找bug并思考修复的思路；<br>
然后，在您fork的版本更改Dopamine的代码；<br>
最后，在本repo的界面提交Pull requests。<br><br>
在作者核查完代码并确保代码风格的一致性，您的代码会被合并到主分支。<br>
感谢您对Dopamine的开发伸出援手！
