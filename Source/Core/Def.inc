{***********************************************************
 !!! Here come the options which you should NEVER change !!!
************************************************************}


{ VER80  => Delphi 1 }
{ VER90  => Delphi 2 }
{ VER93  => Bcb 1    }
{ VER100 => Delphi 3 }
{ VER110 => Bcb 3    }

{ VER120 => Delphi 4 }
{ VER125 => Bcb 4    }
{ VER130 => Delphi 5 }
{ VER140 => Delphi 6 }
{ VER150 => Delphi 7 }
{ VER160 => Delphi 8 }
{ VER170 => Delphi / BDS 2005 }
{ VER180 => Delphi / BDS 2006 }
{ VER190 => Delphi / RAD 2007 }
{ VER200 => Delphi / RAD 2009 }
{ VER210 => Delphi / RAD 2010 }
{ VER220 => Delphi / RAD XE }
{ VER230 => Delphi / RAD XE2 }
{ VER240 => Delphi / RAD XE3 }
{ VER250 => Delphi / RAD XE4 }

{$IFNDEF FPC}
  {$DEFINE IDE_6up}
  {$DEFINE IDE_7up}
  {$DEFINE IDE_2005up}
  {$DEFINE IDE_2006up}
  {$DEFINE IDE_2007up}
  {$DEFINE IDE_2009up}
  {$DEFINE IDE_2010up}
  {$DEFINE IDE_XEup}
  {$DEFINE IDE_XE2up}
  {$DEFINE IDE_XE3up}
  {$DEFINE IDE_XE4up}
  {$DEFINE IDE_XE5up}
  {$DEFINE IDE_XE6up}
{$ENDIF}

{$IFDEF VER120} //D4
  {$UNDEF IDE_6up}
  {$UNDEF IDE_7up}
  {$UNDEF IDE_2005up}
  {$UNDEF IDE_2006up}
  {$UNDEF IDE_2007up}
  {$UNDEF IDE_2009up}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER125} //bcb4
  {$UNDEF IDE_6up}
  {$UNDEF IDE_7up}
  {$UNDEF IDE_2005up}
  {$UNDEF IDE_2006up}
  {$UNDEF IDE_2007up}
  {$UNDEF IDE_2009up}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER130}
  {$UNDEF IDE_6up}
  {$UNDEF IDE_7up}
  {$UNDEF IDE_2005up}
  {$UNDEF IDE_2006up}
  {$UNDEF IDE_2007up}
  {$UNDEF IDE_2009up}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER135}
  {$UNDEF IDE_6up}
  {$UNDEF IDE_7up}
  {$UNDEF IDE_2005up}
  {$UNDEF IDE_2006up}
  {$UNDEF IDE_2007up}
  {$UNDEF IDE_2009up}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER140}
  {$UNDEF IDE_7up}
  {$UNDEF IDE_2005up}
  {$UNDEF IDE_2006up}
  {$UNDEF IDE_2007up}
  {$UNDEF IDE_2009up}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER145}
  {$UNDEF IDE_7up}
  {$UNDEF IDE_2005up}
  {$UNDEF IDE_2006up}
  {$UNDEF IDE_2007up}
  {$UNDEF IDE_2009up}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER150}
  {$UNDEF IDE_2005up}
  {$UNDEF IDE_2006up}
  {$UNDEF IDE_2007up}
  {$UNDEF IDE_2009up}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER160}
  {$UNDEF IDE_2005up}
  {$UNDEF IDE_2006up}
  {$UNDEF IDE_2007up}
  {$UNDEF IDE_2009up}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER170}
  {$UNDEF IDE_2006up}
  {$UNDEF IDE_2007up}
  {$UNDEF IDE_2009up}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER180}
  {$UNDEF IDE_2007up}
  {$UNDEF IDE_2009up}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER190}
  {$UNDEF IDE_2009up}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER200}
  {$UNDEF IDE_2010up}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER210}
  {$UNDEF IDE_XEup}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER220}
  {$UNDEF IDE_XE2up}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER230}
  {$UNDEF IDE_XE3up}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER240}
  {$UNDEF IDE_XE4up}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER250}
  {$UNDEF IDE_XE5up}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF VER260}
  {$UNDEF IDE_XE6up}
{$ENDIF}

{$IFDEF MSWINDOWS}
  {$DEFINE WINDOWS}
{$ENDIF}

{$IFDEF WIN32}
  {$DEFINE WINDOWS}
  {$DEFINE CPUX86}
{$ENDIF}

{$IFDEF WIN64}
  {$DEFINE WINDOWS}
  {$DEFINE CPUX64}
{$ENDIF}

{$IFDEF IDE_XE4up}
  {$ZEROBASEDSTRINGS OFF}
{$ENDIF}

{$IFDEF UNICODE}
  {$IFDEF IDE_2009up}
    {$DEFINE UNICODE_2009up}
  {$ENDIF}
{$ENDIF}

{$IFDEF FPC}
  {$mode delphi}
  {$PACKRECORDS 1}
  {$HINTS OFF}
{$ELSE}
  {$IFDEF POSIX}
    {$DEFINE FPC_POSIX}
  {$ENDIF}
  {$IFDEF MACOS}
    {$IFDEF IOS}
      {$DEFINE MACIOS}
    {$ELSE}
      {$DEFINE MACOSX}
    {$ENDIF}
  {$ENDIF}
  {$IFNDEF WIN32} // The IDE (RAD Studio) currently only works on 32-bit Windows
    {$DEFINE WPF_NOINTF}
  {$ENDIF}
{$ENDIF}

{$DEFINE DESKTOP}
{$IFDEF ANDROID}
  {$UNDEF DESKTOP}
{$ENDIF}

{$IFDEF MACIOS}
  {$UNDEF DESKTOP}
{$ENDIF}

{$IFDEF BCB5}
  {$DEFINE WPF_NOINTF}
{$ENDIF}

{$IFDEF CPUX64}
  {$DEFINE WPF_NOASM}
  // Intel 64-bit
{$ELSE}
  {$IFDEF CPUX86}
    // Intel 32-bit
    {$DEFINE CPUX32}
  {$ELSE}
    {$IFDEF CPU386}
      // Intel 32-bit
      {$DEFINE CPUX32} // For backwards compatibility
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF FPC}
  {$DEFINE WPF_NOASM}
{$ENDIF}

{$IFDEF NEXTGEN}
  {$DEFINE WPF_NOASM}
{$ENDIF}