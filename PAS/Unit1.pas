unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  Menus, cxContainer, IBODataset, IB_Components, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, StdCtrls, cxButtons, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxNavigator, cxDBNavigator;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1VVALOR_FATURA: TcxGridDBColumn;
    cxGrid1DBTableView1VCLIENTE: TcxGridDBColumn;
    cxGrid1DBTableView1VEMPRESA: TcxGridDBColumn;
    cxGrid1DBTableView1VID_VENDA: TcxGridDBColumn;
    cxGrid1DBTableView1VDOCUMENTO: TcxGridDBColumn;
    cxGrid1DBTableView1VSTATUS: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxDateEdit1: TcxDateEdit;
    cxDateEdit2: TcxDateEdit;
    IB_Connection1: TIB_Connection;
    IBOQuery1: TIBOQuery;
    DataSource1: TDataSource;
    cxDBNavigator1: TcxDBNavigator;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    cxGrid2: TcxGrid;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2DBTableView1VVALOR_FATURA: TcxGridDBColumn;
    cxGrid2DBTableView1VCLIENTE: TcxGridDBColumn;
    cxGrid2DBTableView1VEMPRESA: TcxGridDBColumn;
    cxGrid2DBTableView1VID_VENDA: TcxGridDBColumn;
    cxGrid2DBTableView1VDOCUMENTO: TcxGridDBColumn;
    cxGrid2DBTableView1VSTATUS: TcxGridDBColumn;
    cxGrid2Level1: TcxGridLevel;
    IBOQuery2: TIBOQuery;
    DataSource2: TDataSource;
    cxButton3: TcxButton;
    cxButton4: TcxButton;
    Edit3: TEdit;
    Edit5: TEdit;
    Label2: TLabel;
    cxDBNavigator2: TcxDBNavigator;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses untFuncoes, DateUtils;

{$R *.dfm}

procedure TForm1.cxButton1Click(Sender: TObject);
begin
  Self.IBOQuery1.Close; 
  Self.IBOQuery1.ParamByName('BAIXADO').Value := Edit4.Text;
  Self.IBOQuery1.ParamByName('data_inicial').Value := cxDateEdit1.Date;
  Self.IBOQuery1.ParamByName('data_final').Value := cxDateEdit2.Date;
  Self.IBOQuery1.ParamByName('quitado').Value := Edit2.Text;
  Self.IBOQuery1.Open; //By ITO

  Self.cxButton4Click(nil);
end;

procedure TForm1.cxButton2Click(Sender: TObject);
begin
  IBExecSQL('UPDATE CONTAS_RECEBER SET CONTRATO_BAIXADO = ' + QuotedStr(Edit1.Text) + ' WHERE EMPRESA = 1 AND DOCUMENTO = '
          + QuotedStr(Self.IBOQuery1.FieldByName('VDOCUMENTO').AsString), IB_Connection1, nil);
  
  Self.IBOQuery1.Refresh;
  Self.IBOQuery2.Refresh;
end;

procedure TForm1.cxButton4Click(Sender: TObject);
begin
  Self.IBOQuery2.Close;
  Self.IBOQuery2.ParamByName('BAIXADO').Value := Edit5.Text;
  Self.IBOQuery2.ParamByName('data_inicial').Value := cxDateEdit1.Date;
  Self.IBOQuery2.ParamByName('data_final').Value := cxDateEdit2.Date;
  Self.IBOQuery2.ParamByName('quitado').Value := Edit2.Text;
  Self.IBOQuery2.Open;
end;

procedure TForm1.cxButton3Click(Sender: TObject);
begin
  IBExecSQL('UPDATE CONTAS_RECEBER SET CONTRATO_BAIXADO = ' + QuotedStr(Edit3.Text) + ' WHERE EMPRESA = 1 AND DOCUMENTO = '
          + QuotedStr(Self.IBOQuery2.FieldByName('VDOCUMENTO').AsString), IB_Connection1, nil);
  Self.IBOQuery2.Refresh;
  Self.IBOQuery1.Refresh;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.cxDateEdit1.Date := Today - 30;
  Self.cxDateEdit2.Date := Today;
end;

end.
