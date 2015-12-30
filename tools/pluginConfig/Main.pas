unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, ComCtrls, Buttons, ExtCtrls, ImgList,
  WisdomCoreInterfaceForD, ResultCode;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    XPManifest1: TXPManifest;
    pnl1: TPanel;
    spl1: TSplitter;
    tvPlugin: TTreeView;
    btnNewPlugin: TBitBtn;
    btnAddPluginDll: TBitBtn;
    btnRemovePlugin: TBitBtn;
    OpenDialog1: TOpenDialog;
    pnl3: TPanel;
    edtXMLPath: TEdit;
    btnBrowse: TBitBtn;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    edtServiceName: TEdit;
    edtServiceID: TEdit;
    edtServiceAuthor: TEdit;
    edtServiceVer: TEdit;
    mmoServiceComment: TMemo;
    chk2: TCheckBox;
    lbl14: TLabel;
    rb6: TRadioButton;
    rb7: TRadioButton;
    lbl15: TLabel;
    edtServiceImp: TEdit;
    lbl16: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    edtName: TEdit;
    edtID: TEdit;
    edtAuthor: TEdit;
    edtVersion: TEdit;
    mmoComment: TMemo;
    mmoHistory: TMemo;
    rb1: TRadioButton;
    rb2: TRadioButton;
    pnl4: TPanel;
    lbl13: TLabel;
    rb3: TRadioButton;
    rb4: TRadioButton;
    rb5: TRadioButton;
    ImageList1: TImageList;
    btnActiveService: TButton;
    btnApply: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    edtLoaderID: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnAddPluginDllClick(Sender: TObject);
    procedure btnNewPluginClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure tvPluginChange(Sender: TObject; Node: TTreeNode);
    procedure btnRemovePluginClick(Sender: TObject);
    procedure btnActiveServiceClick(Sender: TObject);
    procedure chk2Click(Sender: TObject);
    procedure rb6Click(Sender: TObject);
    procedure rb7Click(Sender: TObject);
    procedure rb1Click(Sender: TObject);
    procedure rb2Click(Sender: TObject);
    procedure rb3Click(Sender: TObject);
    procedure rb4Click(Sender: TObject);
    procedure rb5Click(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
  private
    { Private declarations }
    FSelectedPluginNode, FSelectedServiceNode: TTreeNode;
    FConfig: IConfig;
    procedure SetButtonState(enabled: Boolean);
    procedure ClearPluginInfo;
    procedure ClearPluginUIInfo;
    procedure ClearServiceUIInfo;
    procedure RefreshTreeNodes;
    procedure UpdatePluginNodeState(const node: TTreeNode; pid: String);
    procedure UpdateServiceNodeState(const node: TTreeNode; sid: String);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses CreatePlugin;

procedure TfrmMain.btnAddPluginDllClick(Sender: TObject);
var           
  rsCode, count: Integer;
  pluginManager: IPluginManager;
begin
  if not FileExists(edtXMLPath.Text) then
    Exit;
  OpenDialog1.DefaultExt := '*.dll;*.bpl';
  OpenDialog1.Filter := '插件文件|*.dll;*.bpl';
  OpenDialog1.FileName := '';
  if OpenDialog1.Execute then begin
    pluginManager := GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager;
    count := pluginManager.GetPluginsCount;
    rsCode := pluginManager.LoadPluginDirect(OpenDialog1.FileName);
    case rsCode of
      ERROR_NOT_PLUGIN_DLL: MessageBox(Handle, '所选文件不是一个符合规范的插件模块。', '提示', MB_OK OR MB_ICONWARNING);
      ERROR_SERVICE_DONT_NOT_EXIST: MessageBox(Handle, '插件模块中的服务接口无效。', '提示', MB_OK OR MB_ICONWARNING);
      ERROR_SUCCESS: begin
        //因为PluginManager对相同的DLL不会重复载入，因此，如果注册的插件总数不变表明已载入了
        if pluginManager.GetPluginsCount>count then begin
          FConfig.AddPlugin(OpenDialog1.FileName);
          RefreshTreeNodes;
          SetButtonState(True);
        end else
          MessageBox(Handle, '相同的插件模块已载入。', '提示', MB_OK OR MB_ICONWARNING);
      end;
    end;
  end;
end;

procedure TfrmMain.btnBrowseClick(Sender: TObject);
begin
  OpenDialog1.DefaultExt := '*.xml';
  OpenDialog1.Filter := '插件配置|*.xml';
  OpenDialog1.FileName := 'config';
  if OpenDialog1.Execute then begin
    ClearPluginInfo;
    edtXMLPath.Text := OpenDialog1.FileName;
    FConfig.Open(edtXMLPath.Text);
    RefreshTreeNodes;
    tvPluginChange(tvPlugin, tvPlugin.Selected);
    SetButtonState(False);    
  end;
end;

procedure TfrmMain.btnNewPluginClick(Sender: TObject);
begin
  frmCreatePlugin := TfrmCreatePlugin.Create(Self);
  frmCreatePlugin.ShowModal;
  frmCreatePlugin.Free;
end;

procedure TfrmMain.btnRemovePluginClick(Sender: TObject);
begin
  if tvPlugin.Selected = nil then
    Exit;
  if tvPlugin.Selected.Level = 1 then begin
    MessageBox(Handle, '请选择插件节点或服务节点，再进行移除操作。', '提示', MB_OK OR MB_ICONWARNING);
    Exit;
  end;

  if MessageBox(Handle, '确定从配置中移除当前节点吗？', '提示', MB_OKCANCEL OR MB_ICONQUESTION) = IDCANCEL then
    Exit;

  if tvPlugin.Selected.Level = 0 then begin
    FConfig.RemovePlugin(edtID.Text);
    with GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
      UnLoadPluginByPluginID(edtID.Text);
    end;
    tvPlugin.Items.Delete(tvPlugin.Selected);
    tvPluginChange(tvPlugin, tvPlugin.Selected);
  end else

  if tvPlugin.Selected.Level = 2 then begin
    if Boolean(edtServiceID.Tag) then
      FConfig.RemoveExtendPoint(edtServiceID.Text)
    else
      FConfig.RemoveService(edtServiceID.Text);
    GServiceManager.UnRegService(edtServiceID.Text);
    UpdateServiceNodeState(tvPlugin.Selected, edtServiceID.Text);
  end;
  SetButtonState(True);
end;

procedure TfrmMain.ClearPluginUIInfo;
begin
  edtName.Text := '';
  edtVersion.Text := '';
  edtID.Text := '';
  edtAuthor.Text := '';
  edtLoaderID.Text := '';
  mmoComment.Text := '';
  mmoHistory.Text := '';
  rb1.Checked := false;
  rb2.Checked := false;
  rb3.Checked := false;
  rb4.Checked := false;
  rb5.Checked := false;
end;

procedure TfrmMain.ClearServiceUIInfo;
begin
  edtServiceName.Text := '';
  edtServiceVer.Text := '';
  edtServiceID.Text := '';
  edtServiceImp.Text := '';
  edtServiceAuthor.Text := '';
  mmoServiceComment.Text := '';
  rb6.Checked := false;
  rb7.Checked := false;
  chk2.Checked := false;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;

  tvPlugin.Items.Clear;
  ClearPluginUIInfo;
  ClearServiceUIInfo;
  FConfig := GServiceManager.GetService(CONFIG_ID) as IConfig;
end;

procedure TfrmMain.RefreshTreeNodes;
var
  i, j, count: Integer;
  treeNode, serviceNode, extPointNode: TTreeNode;
  pid, temS: String;
  pluginManager: IPluginManager;
  pInfo: IPluginInfo;
  sInfo: IServiceInfo;
begin
  tvPlugin.OnChange := nil;
  try
    tvPlugin.Items.Clear;
    pluginManager := GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager;

    i := 0;
    while i<FConfig.GetPluginCount do begin
      pid := FConfig.PluginIDFromIdx(i);
      //先检查插件dll文件是否存在
      temS := FConfig.PluginDLL(pid);
      if FileExists(temS) then
        if pluginManager.LoadPluginDirect(temS) = ERROR_SUCCESS then begin
          pInfo := pluginManager.GetPluginInfoByPluginID(pid);
          treeNode := tvPlugin.Items.AddChildObject(nil, ExtractFileName(temS), Pointer(pInfo));
          UpdatePluginNodeState(treeNode, pid);
          serviceNode := tvPlugin.Items.AddChild(treeNode, 'Services');
          extPointNode := tvPlugin.Items.AddChild(treeNode, 'ExtentPoint');
          with pInfo do begin
            count := GetServiceCount-1;
            for j:=0 to count do begin
              sInfo := GetServiceInfo(j);
              if sInfo.IsExtendPoint then
                treeNode := tvPlugin.Items.AddChildObject(extPointNode, sInfo.GetServiceName, Pointer(sInfo))
              else
                treeNode := tvPlugin.Items.AddChildObject(serviceNode, sInfo.GetServiceName, Pointer(sInfo));
              UpdateServiceNodeState(treeNode, sInfo.GetServiceID);
            end;
          end;
        end else begin
          if MessageBox(Handle, PChar('插件DLL：' + temS + #13#10 + '不是一个合法的插件程序，是否移除配置？'), '提示', MB_YESNO	or MB_ICONWARNING) = IDYES then begin
            FConfig.RemovePlugin(pid);
            FConfig.Save;
            Continue;
          end;
        end
      else
        if MessageBox(Handle, PChar('插件：' + temS + #13#10 + '不存在，是否移除配置？'), '提示', MB_YESNO	or MB_ICONWARNING) = IDYES then begin
          FConfig.RemovePlugin(pid);
          FConfig.Save;
          Continue;
        end;
      Inc(i);
    end;

    for i:=0 to tvPlugin.Items.Count-1 do
      if tvPlugin.Items.Item[i].Level = 0 then
        tvPlugin.Items.Item[i].Expand(True);
  finally
    tvPlugin.OnChange := tvPluginChange;
  end;  
end;

procedure TfrmMain.tvPluginChange(Sender: TObject; Node: TTreeNode);
  procedure SetButtonTag(tag: Integer);
  begin
    rb1.Tag := tag;
    rb2.Tag := tag;
    rb3.Tag := tag;
    rb4.Tag := tag;
    rb5.Tag := tag;
    rb6.Tag := tag;
    rb7.Tag := tag;
    chk2.Tag := tag;
  end;
var
  pid, temS: String;
  pInfo: IPluginInfo;
  sInfo, sInfoTem: IServiceInfo;
  topNode: TTreeNode;
begin
  btnActiveService.Visible := False;
  ClearPluginUIInfo;
  ClearServiceUIInfo;
  if not Assigned(Node) then begin
    FSelectedPluginNode := nil;
    FSelectedServiceNode := nil;
    Exit;
  end;

  SetButtonTag(1);

  topNode := Node;
  while not (topNode.Parent = nil) do
    topNode := topNode.Parent;

  FSelectedPluginNode := topNode;
  pInfo := IPluginInfo(topNode.Data);
  pid := pInfo.GetPluginID;
  //显示插件DLL信息
  if edtID.Text <> pid then begin
    with pInfo do begin
      edtName.Text := GetPluginName;
      edtVersion.Text := GetVersion;
      edtID.Text := pid;
      edtAuthor.Text := GetAuthor;
      mmoComment.Text := GetComment;
      mmoHistory.Text := GetUpdateHistory;
      edtLoaderID.Text := FConfig.GetPluginLoaderID(pid);
      if edtLoaderID.Text = PLUGIN_LOADER then
        edtLoaderID.Text := 'default';

      if FConfig.PluginIsDisable(pid) then
        rb2.Checked := True
      else
        rb1.Checked := True;

      temS := FConfig.GetPluginLoadState(pid);
      if temS = 'always' then
        rb3.Checked := True
      else if temS = 'when_use' then
        rb4.Checked := True
      else if temS = 'auto' then
        rb5.Checked := True;
    end;
  end;

  //显示服务信息
  if Node.Level = 0 then
    pgc1.ActivePageIndex := 0
  else if (Node.Level = 2) and (Node.Data <> nil) then begin
    FSelectedServiceNode := Node;
    sInfo := IServiceInfo(Node.Data);
    if sInfo.GetServiceID <> edtServiceID.Text then begin
      edtServiceName.Text := sInfo.GetServiceName;
      edtServiceVer.Text := sInfo.GetVersion;
      edtServiceID.Text := sInfo.GetServiceID;
      edtServiceID.Tag := Integer(sInfo.IsExtendPoint);
      edtServiceAuthor.Text := sInfo.GetAuthor;
      mmoServiceComment.Text := sInfo.GetComment;
      sInfoTem := GServiceManager.GetServiceInfo(sInfo.GetImplementServiceID);
      if Assigned(sInfoTem) then
        edtServiceImp.Text := sInfoTem.GetServiceName;
      chk2.Checked := FConfig.ServiceIsSingleton(sInfo.GetServiceID);
      if FConfig.ServiceIsDisable(sInfo.GetServiceID) or FConfig.ExtPointIsDisable(sInfo.GetServiceID) then
        rb7.Checked := True
      else
        rb6.Checked := True;
    end;    
    pgc1.ActivePageIndex := 1;
    btnActiveService.Visible := Node.StateIndex = 3;
  end;

  SetButtonTag(0);
end;

procedure TfrmMain.btnActiveServiceClick(Sender: TObject);
var
  sv: IServiceInfo;
begin
  sv := IServiceInfo(FSelectedServiceNode.Data);
  if sv.IsExtendPoint then
    FConfig.AddExtendPoint(sv)
  else
    FConfig.AddService(sv);
  UpdateServiceNodeState(FSelectedServiceNode, sv.GetServiceID);
  SetButtonState(True);
  btnActiveService.Visible := False;
end;

procedure TfrmMain.UpdatePluginNodeState(const node: TTreeNode; pid: String);
begin
  //内部使用，不作参数有效性检查
  if not FConfig.ExistPlugin(pid) then
    node.StateIndex := 3
  else if FConfig.PluginIsDisable(pid) then
    node.StateIndex := 2
  else
    node.StateIndex := 1;
end;

procedure TfrmMain.UpdateServiceNodeState(const node: TTreeNode;
  sid: String);
begin
  //内部使用，不作参数有效性检查
  if not (FConfig.ExistService(sid) or FConfig.ExistExtPoint(sid)) then
    node.StateIndex := 3
  else if FConfig.ServiceIsDisable(sid) or FConfig.ExtPointIsDisable(sid) then
    node.StateIndex := 2
  else
    node.StateIndex := 1;
end;

procedure TfrmMain.chk2Click(Sender: TObject);
begin
  if (edtServiceID.Text = '') or (chk2.Tag>0) then
    Exit;

  SetButtonState(True);
  if Boolean(edtServiceID.Tag) then  //如果为真表示是扩展点
    FConfig.SetExtendPointSingleton(edtServiceID.Text, chk2.Checked)
  else
    FConfig.SetServiceSingleton(edtServiceID.Text, chk2.Checked);
end;

procedure TfrmMain.rb6Click(Sender: TObject);
begin
  if (edtServiceID.Text = '') or (rb6.Tag > 0) then
    Exit;

  SetButtonState(True);
  if Boolean(edtServiceID.Tag) then  //如果为真表示是扩展点
    FConfig.EnabledExtendPoint(edtServiceID.Text)
  else
    FConfig.EnabledService(edtServiceID.Text);
  UpdateServiceNodeState(FSelectedServiceNode, edtServiceID.Text);
end;

procedure TfrmMain.rb7Click(Sender: TObject);
begin
  if (edtServiceID.Text = '') or (rb7.Tag>0) then
    Exit;

  SetButtonState(True);
  if Boolean(edtServiceID.Tag) then  //如果为真表示是扩展点
    FConfig.DisableExtendPoint(edtServiceID.Text)
  else
    FConfig.DisableService(edtServiceID.Text);
  UpdateServiceNodeState(FSelectedServiceNode, edtServiceID.Text);
end;

procedure TfrmMain.rb1Click(Sender: TObject);
begin
  if (edtID.Text = '') or (rb1.Tag>0) then
    Exit;

  SetButtonState(True);
  FConfig.EnabledPlugin(edtID.Text);
  UpdatePluginNodeState(FSelectedPluginNode, edtID.Text);
end;

procedure TfrmMain.rb2Click(Sender: TObject);
begin
  if (edtID.Text = '') or (rb2.Tag>0) then
    Exit;

  SetButtonState(True);
  FConfig.DisablePlugin(edtID.Text);
  UpdatePluginNodeState(FSelectedPluginNode, edtID.Text);
end;

procedure TfrmMain.SetButtonState(enabled: Boolean);
begin
  btnApply.Enabled := enabled;
  btnCancel.Enabled := enabled;
end;

procedure TfrmMain.rb3Click(Sender: TObject);
begin
  if (edtID.Text = '') or (rb3.Tag>0) then
    Exit;

  SetButtonState(True);
  FConfig.SetPluginLoadState(edtID.Text, 'always');
end;

procedure TfrmMain.rb4Click(Sender: TObject);
begin
  if (edtID.Text = '') or (rb4.Tag>0) then
    Exit;

  SetButtonState(True);
  FConfig.SetPluginLoadState(edtID.Text, 'when_use');
end;

procedure TfrmMain.rb5Click(Sender: TObject);
begin
  if (edtID.Text = '') or (rb5.Tag>0) then
    Exit;

  SetButtonState(True);
  FConfig.SetPluginLoadState(edtID.Text, 'auto');
end;

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  ClearPluginUIInfo;
  ClearServiceUIInfo;
  ClearPluginInfo;
  FConfig.Reload;
  RefreshTreeNodes;
  tvPluginChange(tvPlugin, tvPlugin.Selected);
  SetButtonState(False);
end;

procedure TfrmMain.btnApplyClick(Sender: TObject);
begin
  if edtID.Text <> '' then
    FConfig.SetPluginLoaderID(edtID.Text, Trim(edtLoaderID.Text));
  FConfig.Save;
  FConfig.Reload;
  RefreshTreeNodes;
  SetButtonState(False);
end;

procedure TfrmMain.ClearPluginInfo;
var
  i: Integer;
begin
  if tvPlugin.Items.Count=0 then
    Exit;
  with GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
    for i:=0 to tvPlugin.Items.Count-1 do
      if tvPlugin.Items.Item[i].Level = 0 then
        UnLoadPluginByPluginID(IPluginInfo(tvPlugin.Items.Item[i].Data).GetPluginID);
  end;
end;


end.
