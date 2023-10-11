unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Win.ComObj;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Label2: TLabel;
    Button3: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  numero: Word;
  listanumeros: array[1..90] of Word;
  indicenumero: Word;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);

var
   Voice: Variant;

begin
     Voice := CreateOLEObject('SAPI.SpVoice');
     Voice.speak(numero.ToString);
end;

procedure TForm2.Button2Click(Sender: TObject);

var
   Voice: Variant;
   contador: Word;
   existe: Boolean;

begin
     if (indicenumero<=90) then
        begin
             repeat
                   numero:=Random(90)+1;
                   for contador:=1 to indicenumero do
                       if numero=listanumeros[contador] then
                          begin
                               existe:=True;
                               Break;
                          end
                       else
                           existe:=False;
             until (existe=False) or (indicenumero=90);
             listanumeros[indicenumero]:=numero;
             Inc(indicenumero,1);
             Label2.Caption:='Cantidad de números: '+(indicenumero-1).ToString;
             if numero>=10 then
                begin
                      Label1.Caption:=numero.ToString;
                      Memo1.Text:=Memo1.Text+numero.ToString+'  ';
                 end
              else
                  begin
                       Label1.Caption:='0'+numero.ToString;
                       Memo1.Text:=Memo1.Text+'0'+numero.ToString+'  ';
                  end;
             label1.Update;
             memo1.Update;
             form2.SetFocus;
             Voice := CreateOLEObject('SAPI.SpVoice');
             Voice.speak(numero.ToString);
        end
     else
         begin
              Voice := CreateOLEObject('SAPI.SpVoice');
              Voice.speak('¡Ya debería haber bingo!');
              MessageBox(0,'Ya debería haber Bingo','¡¡Ya debería haber Bingo!!',MB_OK+MB_ICONINFORMATION);
         end;
end;

procedure TForm2.Button3Click(Sender: TObject);

var
   contador: Word;
   Voice: Variant;

begin
     Memo1.Clear;
     for contador := 1 to 90 do
         listanumeros[contador]:=0;
     indicenumero:=1;
     Voice := CreateOLEObject('SAPI.SpVoice');
     Voice.speak('Nuevo bingo. Empezamos de nuevo.');
     FormActivate(nil);
end;

procedure TForm2.FormActivate(Sender: TObject);

var
   Voice: Variant;
   contador: Word;
   existe: Boolean;

begin
     Randomize();
     repeat
           numero:=Random(90)+1;
           for contador:=1 to indicenumero do
               if numero=listanumeros[contador] then
                  begin
                       existe:=True;
                       Break;
                  end
               else
                   existe:=False;

     until (numero>0) and (existe=False);
     listanumeros[indicenumero]:=numero;
     Inc(indicenumero,1);
     Label2.Caption:='Cantidad de números: '+(indicenumero-1).ToString;
     if numero>=10 then
        begin
             Label1.Caption:=numero.ToString;
             Memo1.Text:=Memo1.Text+numero.ToString+'  ';
        end
     else
         begin
              Label1.Caption:='0'+numero.ToString;
              Memo1.Text:=Memo1.Text+'0'+numero.ToString+'  ';
         end;
     label1.Update;
     Memo1.Update;
     form2.SetFocus;
     Voice := CreateOLEObject('SAPI.SpVoice');
     Voice.speak(numero.ToString);
end;




procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);

var
   Voice: Variant;

begin
     Voice := CreateOLEObject('SAPI.SpVoice');
     Voice.speak('Gracias por probar el bingo de Nacho y Eric. Hasta la próxima.');
     CanClose:=True;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
     for indicenumero := 1 to 90 do
         listanumeros[indicenumero]:=0;
     indicenumero:=1;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

var
   contador: Word;
   Voice: Variant;

begin
     case Key of
          82: Button1Click(nil);
          78: Button2Click(nil);
          66: begin
                   Memo1.Clear;
                   for contador := 1 to 90 do
                       listanumeros[contador]:=0;
                   indicenumero:=1;
                   Voice := CreateOLEObject('SAPI.SpVoice');
                   Voice.speak('Nuevo bingo. Empezamos de nuevo');
                   Form2.Update;
                   FormActivate(nil);
              end;
     end;
end;

end.
