type
  {$IFDEF _FORCE_ANSI}      //��ģʽ�����DLL��������Unicodeϵͳ��ʹ��
  MyString = AnsiString;
  PMyChar = PAnsiChar;
  {$ELSE}
    {$IFDEF _FORCE_UNICODE}
      {$IFDEF IDE_2009up}    //2009���Ͽ�����Unicodeģʽ��������ʹ����Ansiģʽ�����DLL����D7��
         MyString = UnicodeString;
         PMyChar = PChar;
      {$ELSE}
         {$MESSAGE WARN '!!!UNICODE Only Support in 2009 and UP DelphiIDE, No support in other version!!!'}
      {$ENDIF}
    {$ELSE}
      {$DEFINE _USE_WSTRING}   //Ĭ��ʹ��WideString��֧��D5~XE6�����б�������
      MyString = WideString;
      PMyChar = PWideChar;
    {$ENDIF}
  {$ENDIF}