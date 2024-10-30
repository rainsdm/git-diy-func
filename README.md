<!--推荐网站：https:shields.io-->

<!-- PROJECT LOGO -->
<br />
<h3 align="center">自定义Git bash功能性脚本</h3>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>目录</summary>
  <ol>
    <li>
      <a href="#about-the-project">关于项目</a>
    </li>
    <li>
      <a href="#getting-started">如何使用本项目</a>
    </li>
    <li><a href="#usage">用法</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>
<br/>


<!-- PROJECT SHIELDS -->
![GitHub contributors](https://img.shields.io/github/contributors/rainsdm/git-diy-func?color=green)
![GitHub forks](https://img.shields.io/github/forks/rainsdm/git-diy-func?style=flat)
![GitHub Repo stars](https://img.shields.io/github/stars/rainsdm/git-diy-func?style=flat)


<!-- ABOUT THE PROJECT -->
## 关于项目

&emsp;&emsp;在使用ssh尝试连接项目时，如果需要向多个不同的平台添加密钥，会显得十分麻烦。因此，我着手开发了一个半自动化的脚本，以代替频繁的手动操作。用户需要做的，只是简单的选择想要登录的平台，然后输入正确的密码，就能方便的使用 ssh-agent 了。


<!-- GETTING STARTED -->
## 如何使用本项目

&emsp;&emsp;首先，克隆本仓库到本地。然后将.profile文件复制到C:\Users\Administrator里面即可。如果你的密钥保存在不同的路径，一定要到源代码的第34行和第36行更正！


<!-- USAGE EXAMPLES -->
## 用法

&emsp;&emsp;启动git bash后，根据想要登录平台的不同，选择0表示登录github，选择1表示登录gitee。脚本会自动检查你是否添加了密钥。如果没有添加密钥，它将要求你输入对应密钥的密码，按回车键确认。


<!-- ROADMAP -->
## 开发路线图

- [x] 支持的语言：
    - [x] 简体中文
- [ ] 选择合适的协议


<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.


<!-- CONTACT -->
## 联系方式

Robert Wilson - lysy3280@163.com

Project Link: [git-diy-func](https://github.com/rainsdm/git-diy-func)

