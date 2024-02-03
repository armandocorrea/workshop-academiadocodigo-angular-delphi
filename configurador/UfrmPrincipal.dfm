object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Configurador Banco'
  ClientHeight = 276
  ClientWidth = 279
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 42
    Height = 15
    Caption = 'DriverID'
  end
  object Label2: TLabel
    Left = 144
    Top = 8
    Width = 48
    Height = 15
    Caption = 'Database'
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 53
    Height = 15
    Caption = 'Username'
  end
  object Label4: TLabel
    Left = 144
    Top = 64
    Width = 50
    Height = 15
    Caption = 'Password'
  end
  object Label5: TLabel
    Left = 8
    Top = 120
    Width = 22
    Height = 15
    Caption = 'Port'
  end
  object Label6: TLabel
    Left = 144
    Top = 120
    Width = 32
    Height = 15
    Caption = 'Server'
  end
  object Label7: TLabel
    Left = 8
    Top = 176
    Width = 42
    Height = 15
    Caption = 'Schema'
  end
  object edtDriverID: TEdit
    Left = 8
    Top = 29
    Width = 121
    Height = 23
    ImeName = 'Portuguese (Brazilian ABNT)'
    TabOrder = 0
    TextHint = 'PG'
  end
  object edtDatabase: TEdit
    Left = 144
    Top = 29
    Width = 121
    Height = 23
    TabOrder = 1
    TextHint = 'postgresql'
  end
  object edtUsername: TEdit
    Left = 8
    Top = 85
    Width = 121
    Height = 23
    TabOrder = 2
    TextHint = 'postgres'
  end
  object edtPassword: TEdit
    Left = 144
    Top = 85
    Width = 121
    Height = 23
    PasswordChar = '*'
    TabOrder = 3
  end
  object edtPort: TEdit
    Left = 8
    Top = 141
    Width = 121
    Height = 23
    TabOrder = 4
    TextHint = '5432'
  end
  object edtServer: TEdit
    Left = 144
    Top = 141
    Width = 121
    Height = 23
    TabOrder = 5
    TextHint = 'localhost'
  end
  object edtSchema: TEdit
    Left = 8
    Top = 197
    Width = 121
    Height = 23
    TabOrder = 6
    TextHint = 'workshop'
  end
  object btnGravar: TButton
    Left = 144
    Top = 234
    Width = 121
    Height = 25
    Caption = 'Gravar'
    TabOrder = 7
    OnClick = btnGravarClick
  end
  object btnTestar: TButton
    Left = 8
    Top = 234
    Width = 121
    Height = 25
    Caption = 'Testar Conex'#227'o'
    TabOrder = 8
    OnClick = btnTestarClick
  end
  object FDConnection1: TFDConnection
    Left = 152
    Top = 168
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\10\bin\libpq.dll'
    Left = 216
    Top = 168
  end
end
