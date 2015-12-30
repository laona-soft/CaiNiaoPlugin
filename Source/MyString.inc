type
  {$IFDEF _FORCE_ANSI}      //此模式编译的DLL将不能在Unicode系统下使用
  MyString = AnsiString;
  PMyChar = PAnsiChar;
  {$ELSE}
    {$IFDEF _FORCE_UNICODE}
      {$IFDEF IDE_2009up}    //2009以上可以用Unicode模式，但不能使用以Ansi模式编译的DLL，如D7。
         MyString = UnicodeString;
         PMyChar = PChar;
      {$ELSE}
         {$MESSAGE WARN '!!!UNICODE Only Support in 2009 and UP DelphiIDE, No support in other version!!!'}
      {$ENDIF}
    {$ELSE}
      {$DEFINE _USE_WSTRING}   //默认使用WideString，支持D5~XE6的所有编译器。
      MyString = WideString;
      PMyChar = PWideChar;
    {$ENDIF}
  {$ENDIF}