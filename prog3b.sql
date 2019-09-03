SET SERVEROUTPUT ON
ACCEPT x PROMPT 'Please enter the sentence you would like broken up'

DECLARE
sentence VARCHAR2(80);
s_length NUMBER := 10;

procedure wrap_text(text in varchar2, w_length in number)is
  cur varchar2(4000);
  w_text varchar2(4000);
  text_length number;
  pos number := 1;
begin
  cur := text;
  text_length := length(text);
  while (pos > 0 and pos < text_length) loop    
    if length(cur) > w_length then
      pos := instr(substr(cur, 1, w_length), ' ', -1);    
      if (pos > 0) then
        w_text := w_text || substr(cur, 1, pos) || chr(10);
        cur := substr(cur, pos + 1);
      else
        w_text := w_text || cur;
        cur := NULL;
      end if;
    else
      w_text := w_text || cur;
      cur := NULL;
      pos := 0;
    end if;
  end loop;
  dbms_output.put_line(w_text);
end;

BEGIN
   sentence := ltrim(rtrim('&x'));
   wrap_text(sentence,s_length);
   EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR: Requested sentence length is too long');
END;