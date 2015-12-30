UNIT MD5;
INTERFACE
USES
  Windows,
  SysUtils;

//自定函数  计算字符串的MD5值
FUNCTION StrToMD5(str: STRING): STRING; //计算字符串的MD5值
FUNCTION FileToMD5(FilePath: STRING): STRING; //计算文件的MD5值

TYPE
  MD5Count = ARRAY[0..1] OF DWORD;
  MD5State = ARRAY[0..3] OF DWORD;
  MD5Block = ARRAY[0..15] OF DWORD;
  MD5CBits = ARRAY[0..7] OF byte;
  MD5Digest = ARRAY[0..15] OF byte;
  MD5Buffer = ARRAY[0..63] OF byte;
  MD5Context = RECORD
    State: MD5State;
    Count: MD5Count;
    Buffer: MD5Buffer;
  END;
  // -----------------------------------------------------------------------------------------------
IMPLEMENTATION
// -----------------------------------------------------------------------------------------------
VAR
  PADDING: MD5Buffer = (
    $80, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00
    );

FUNCTION F(x, y, z: DWORD): DWORD;
BEGIN
  Result := (x AND y) OR ((NOT x) AND z);
END;

FUNCTION G(x, y, z: DWORD): DWORD;
BEGIN
  Result := (x AND z) OR (y AND (NOT z));
END;

FUNCTION H(x, y, z: DWORD): DWORD;
BEGIN
  Result := x XOR y XOR z;
END;

FUNCTION I(x, y, z: DWORD): DWORD;
BEGIN
  Result := y XOR (x OR (NOT z));
END;

PROCEDURE rot(VAR x: DWORD; n: BYTE);
BEGIN
  x := (x SHL n) OR (x SHR (32 - n));
END;

PROCEDURE FF(VAR a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
BEGIN
  inc(a, F(b, c, d) + x + ac);
  rot(a, s);
  inc(a, b);
END;

PROCEDURE GG(VAR a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
BEGIN
  inc(a, G(b, c, d) + x + ac);
  rot(a, s);
  inc(a, b);
END;

PROCEDURE HH(VAR a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
BEGIN
  inc(a, H(b, c, d) + x + ac);
  rot(a, s);
  inc(a, b);
END;

PROCEDURE II(VAR a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
BEGIN
  inc(a, I(b, c, d) + x + ac);
  rot(a, s);
  inc(a, b);
END;
// -----------------------------------------------------------------------------------------------
// Encode Count bytes at Source into (Count / 4) DWORDs at Target

PROCEDURE Encode(Source, Target: pointer; Count: longword);
VAR
  S: PByte;
  T: PDWORD;
  I: longword;
BEGIN
  S := Source;
  T := Target;
  FOR I := 1 TO Count DIV 4 DO
    BEGIN
      T^ := S^;
      inc(S);
      T^ := T^ OR (S^ SHL 8);
      inc(S);
      T^ := T^ OR (S^ SHL 16);
      inc(S);
      T^ := T^ OR (S^ SHL 24);
      inc(S);
      inc(T);
    END;
END;
// Decode Count DWORDs at Source into (Count * 4) Bytes at Target

PROCEDURE Decode(Source, Target: pointer; Count: longword);
VAR
  S: PDWORD;
  T: PByte;
  I: longword;
BEGIN
  S := Source;
  T := Target;
  FOR I := 1 TO Count DO
    BEGIN
      T^ := S^ AND $FF;
      inc(T);
      T^ := (S^ SHR 8) AND $FF;
      inc(T);
      T^ := (S^ SHR 16) AND $FF;
      inc(T);
      T^ := (S^ SHR 24) AND $FF;
      inc(T);
      inc(S);
    END;
END;
// Transform State according to first 64 bytes at Buffer

PROCEDURE Transform(Buffer: pointer; VAR State: MD5State);
VAR
  a, b, c, d: DWORD;
  Block: MD5Block;
BEGIN
  Encode(Buffer, @Block, 64);
  a := State[0];
  b := State[1];
  c := State[2];
  d := State[3];
  FF(a, b, c, d, Block[0], 7, $D76AA478);
  FF(d, a, b, c, Block[1], 12, $E8C7B756);
  FF(c, d, a, b, Block[2], 17, $242070DB);
  FF(b, c, d, a, Block[3], 22, $C1BDCEEE);
  FF(a, b, c, d, Block[4], 7, $F57C0FAF);
  FF(d, a, b, c, Block[5], 12, $4787C62A);
  FF(c, d, a, b, Block[6], 17, $A8304613);
  FF(b, c, d, a, Block[7], 22, $FD469501);
  FF(a, b, c, d, Block[8], 7, $698098D8);
  FF(d, a, b, c, Block[9], 12, $8B44F7AF);
  FF(c, d, a, b, Block[10], 17, $FFFF5BB1);
  FF(b, c, d, a, Block[11], 22, $895CD7BE);
  FF(a, b, c, d, Block[12], 7, $6B901122);
  FF(d, a, b, c, Block[13], 12, $FD987193);
  FF(c, d, a, b, Block[14], 17, $A679438E);
  FF(b, c, d, a, Block[15], 22, $49B40821);
  GG(a, b, c, d, Block[1], 5, $F61E2562);
  GG(d, a, b, c, Block[6], 9, $C040B340);
  GG(c, d, a, b, Block[11], 14, $265E5A51);
  GG(b, c, d, a, Block[0], 20, $E9B6C7AA);
  GG(a, b, c, d, Block[5], 5, $D62F105D);
  GG(d, a, b, c, Block[10], 9, $2441453);
  GG(c, d, a, b, Block[15], 14, $D8A1E681);
  GG(b, c, d, a, Block[4], 20, $E7D3FBC8);
  GG(a, b, c, d, Block[9], 5, $21E1CDE6);
  GG(d, a, b, c, Block[14], 9, $C33707D6);
  GG(c, d, a, b, Block[3], 14, $F4D50D87);
  GG(b, c, d, a, Block[8], 20, $455A14ED);
  GG(a, b, c, d, Block[13], 5, $A9E3E905);
  GG(d, a, b, c, Block[2], 9, $FCEFA3F8);
  GG(c, d, a, b, Block[7], 14, $676F02D9);
  GG(b, c, d, a, Block[12], 20, $8D2A4C8A);
  HH(a, b, c, d, Block[5], 4, $FFFA3942);
  HH(d, a, b, c, Block[8], 11, $8771F681);
  HH(c, d, a, b, Block[11], 16, $6D9D6122);
  HH(b, c, d, a, Block[14], 23, $FDE5380C);
  HH(a, b, c, d, Block[1], 4, $A4BEEA44);
  HH(d, a, b, c, Block[4], 11, $4BDECFA9);
  HH(c, d, a, b, Block[7], 16, $F6BB4B60);
  HH(b, c, d, a, Block[10], 23, $BEBFBC70);
  HH(a, b, c, d, Block[13], 4, $289B7EC6);
  HH(d, a, b, c, Block[0], 11, $EAA127FA);
  HH(c, d, a, b, Block[3], 16, $D4EF3085);
  HH(b, c, d, a, Block[6], 23, $4881D05);
  HH(a, b, c, d, Block[9], 4, $D9D4D039);
  HH(d, a, b, c, Block[12], 11, $E6DB99E5);
  HH(c, d, a, b, Block[15], 16, $1FA27CF8);
  HH(b, c, d, a, Block[2], 23, $C4AC5665);
  II(a, b, c, d, Block[0], 6, $F4292244);
  II(d, a, b, c, Block[7], 10, $432AFF97);
  II(c, d, a, b, Block[14], 15, $AB9423A7);
  II(b, c, d, a, Block[5], 21, $FC93A039);
  II(a, b, c, d, Block[12], 6, $655B59C3);
  II(d, a, b, c, Block[3], 10, $8F0CCC92);
  II(c, d, a, b, Block[10], 15, $FFEFF47D);
  II(b, c, d, a, Block[1], 21, $85845DD1);
  II(a, b, c, d, Block[8], 6, $6FA87E4F);
  II(d, a, b, c, Block[15], 10, $FE2CE6E0);
  II(c, d, a, b, Block[6], 15, $A3014314);
  II(b, c, d, a, Block[13], 21, $4E0811A1);
  II(a, b, c, d, Block[4], 6, $F7537E82);
  II(d, a, b, c, Block[11], 10, $BD3AF235);
  II(c, d, a, b, Block[2], 15, $2AD7D2BB);
  II(b, c, d, a, Block[9], 21, $EB86D391);
  inc(State[0], a);
  inc(State[1], b);
  inc(State[2], c);
  inc(State[3], d);
END;
// -----------------------------------------------------------------------------------------------
// Initialize given Context

PROCEDURE MD5Init(VAR Context: MD5Context);
BEGIN
  WITH Context DO
    BEGIN
      State[0] := $67452301;
      State[1] := $EFCDAB89;
      State[2] := $98BADCFE;
      State[3] := $10325476;
      Count[0] := 0;
      Count[1] := 0;
      ZeroMemory(@Buffer, SizeOf(MD5Buffer));
    END;
END;
// Update given Context to include Length bytes of Input

PROCEDURE MD5Update(VAR Context: MD5Context; Input: pChar; Length: longword);
VAR
  Index: longword;
  PartLen: longword;
  I: longword;
BEGIN
  WITH Context DO
    BEGIN
      Index := (Count[0] SHR 3) AND $3F;
      inc(Count[0], Length SHL 3);
      IF Count[0] < (Length SHL 3) THEN inc(Count[1]);
      inc(Count[1], Length SHR 29);
    END;
  PartLen := 64 - Index;
  IF Length >= PartLen THEN
    BEGIN
      CopyMemory(@Context.Buffer[Index], Input, PartLen);
      Transform(@Context.Buffer, Context.State);
      I := PartLen;
      WHILE I + 63 < Length DO
        BEGIN
          Transform(@Input[I], Context.State);
          inc(I, 64);
        END;
      Index := 0;
    END
  ELSE
    I := 0;
  CopyMemory(@Context.Buffer[Index], @Input[I], Length - I);
END;
// Finalize given Context, create Digest and zeroize Context

PROCEDURE MD5Final(VAR Context: MD5Context; VAR Digest: MD5Digest);
VAR
  Bits: MD5CBits;
  Index: longword;
  PadLen: longword;
BEGIN
  Decode(@Context.Count, @Bits, 2);
  Index := (Context.Count[0] SHR 3) AND $3F;
  IF Index < 56 THEN
    PadLen := 56 - Index
  ELSE
    PadLen := 120 - Index;
  MD5Update(Context, @PADDING, PadLen);
  MD5Update(Context, @Bits, 8);
  Decode(@Context.State, @Digest, 4);
  ZeroMemory(@Context, SizeOf(MD5Context));
END;
// -----------------------------------------------------------------------------------------------
// Create digest of given Message

FUNCTION MD5String(M: STRING): MD5Digest;
VAR
  Context: MD5Context;
BEGIN
  MD5Init(Context);
  MD5Update(Context, pChar(M), length(M));
  MD5Final(Context, Result);
END;
// Create digest of file with given Name

FUNCTION MD5File(N: STRING): MD5Digest;
VAR
  FileHandle: THandle;
  MapHandle: THandle;
  ViewPointer: pointer;
  Context: MD5Context;
BEGIN
  MD5Init(Context);
  FileHandle := CreateFile(pChar(N), GENERIC_READ, FILE_SHARE_READ OR FILE_SHARE_WRITE,
    NIL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL OR FILE_FLAG_SEQUENTIAL_SCAN, 0);
  IF FileHandle <> INVALID_HANDLE_VALUE THEN
    TRY
      MapHandle := CreateFileMapping(FileHandle, NIL, PAGE_READONLY, 0, 0, NIL);
      IF MapHandle <> 0 THEN
        TRY
          ViewPointer := MapViewOfFile(MapHandle, FILE_MAP_READ, 0, 0, 0);
          IF ViewPointer <> NIL THEN
            TRY
              MD5Update(Context, ViewPointer, GetFileSize(FileHandle, NIL));
            FINALLY
              UnmapViewOfFile(ViewPointer);
            END;
        FINALLY
          CloseHandle(MapHandle);
        END;
    FINALLY
      CloseHandle(FileHandle);
    END;
  MD5Final(Context, Result);
END;
// Create hex representation of given Digest

FUNCTION MD5Print(D: MD5Digest): STRING;
VAR
  I: byte;
CONST
  Digits: ARRAY[0..15] OF char =
  ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');
BEGIN
  Result := '';
  FOR I := 0 TO 15 DO
    Result := Result + Digits[(D[I] SHR 4) AND $0F] + Digits[D[I] AND $0F];
END;
// -----------------------------------------------------------------------------------------------
// Compare two Digests

FUNCTION MD5Match(D1, D2: MD5Digest): boolean;
VAR
  I: byte;
BEGIN
  I := 0;
  Result := TRUE;
  WHILE Result AND (I < 16) DO
    BEGIN
      Result := D1[I] = D2[I];
      inc(I);
    END;
END;

FUNCTION StrToMD5(str: STRING): STRING;
BEGIN
  result := UpperCase(MD5Print(MD5String(str)));
END;

FUNCTION FileToMD5(FilePath: STRING): STRING;
BEGIN
  result := UpperCase(MD5Print(MD5File(FilePath)));
END;
END.

