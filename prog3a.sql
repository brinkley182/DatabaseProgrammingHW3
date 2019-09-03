SET SERVEROUTPUT ON
ACCEPT x PROMPT 'Please enter the name in this format FIRST LAST TITLE or LAST, FIRST TITLE'
DECLARE
    string_to_parse varchar2(2000) := '&x';
        PROCEDURE parse_name(parse IN varchar2)IS
            l_count number;
            n number;
            f_name varchar2(2000);
            l_name varchar2(2000);
            title varchar2(2000);
            pos1 number;
            pos2 number;
            e_invalid_input exception;
        BEGIN
            n:=regexp_instr(parse,',',1,1);
            pos1:=regexp_instr(parse,' ',1,1);
            pos2:=regexp_instr(parse,' ',1,2);
            l_count := length(parse) - length(replace(parse,' ',''));
            IF l_count <> 2 THEN
                raise e_invalid_input;
            END IF;
            IF n <> 0 THEN
                select substr(parse,1,n-1)
                into l_name
                from dual;
                select substr(parse,pos1+1,pos2-pos1)
                into f_name
                from dual;
                select substr(parse,pos2+1,length(parse))
                into title
                from dual;
                dbms_output.put_line(title|| ' '||f_name||' '||l_name);
            ELSE 
                select substr(parse,1,pos1-1)
                into f_name
                from dual;
                select substr(parse,pos1+1,pos2-pos1)
                into l_name
                from dual;
                select substr(parse,pos2+1,length(parse))
                into title
                from dual;
                dbms_output.put_line(title|| ' '||f_name||' '||l_name);
            END IF;
            EXCEPTION
                WHEN e_invalid_input THEN
                    dbms_output.put_line('Error: Invalid input');
        END parse_name;
BEGIN
    parse_name(string_to_parse);
END;