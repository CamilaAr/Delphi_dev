unit U_Funcoes;

interface

function TestarPermissao(NOME_FORM: string) : boolean;

implementation

uses Vcl.Dialogs;

function TestarPermissao(NOME_FORM: string) : boolean;
begin   //futura implementação de acesso
   result := true;
   if result = false then
   begin
     ShowMessage('Acesso não permitido');
   end;
end;



end.
