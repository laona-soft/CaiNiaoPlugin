UNIT pluginConst;

INTERFACE

CONST
//说明 插件安装的菜单目录是由PluginMenu决定的，通用"_"分割开，最大5级菜单 服务功能的插件默认只能安装到服务管理菜单下，自动添加启动，关闭，服务器设置三个子菜单
  IID_PluginHttpSrv = '{4D9D997C-AC10-40F3-B913-91855055DCCD}';
  PluginId = '{F97EA57B-1F4B-45BD-A9DA-0C05D1C4F766}';
  PluginName = 'HttpSrv';
  PluginMenu = 'Http服务';
  PluginComment = '基于Rtc的http服务插件';
  PluginVer = '1.0.0';
  PluginAuthor = 'Q744840146';

IMPLEMENTATION
END.

